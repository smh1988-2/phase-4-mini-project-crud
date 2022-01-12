class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_error

    def index
        spices = Spice.all
        if spices
            render json: spices, status: :ok
        else
            render_error
        end
    end

    def create
        new_spice = Spice.create(spice_params)
        render json: new_spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: :ok
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_error
        render json: { "message:" => "your shit's all fucked"}
    end

    def find_spice
        Spice.find(params[:id])
    end

end
