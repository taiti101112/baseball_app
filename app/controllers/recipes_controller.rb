class RecipesController < ApplicationController
  # before_action :authenticate_user!, except: [:index]
  def index
    @recipes = Recipe.all 
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new 
  end
  
  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "レシピを投稿しました。"
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user != current_user
      redirect_to recipes_path, alert: "不正なアクセスです。"
    end 
  end
  
  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipe_path
  end 
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "レシピを更新しました。"
    else
      render :edit
    end
  end
  
  
  
  private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end 
  
  
end
