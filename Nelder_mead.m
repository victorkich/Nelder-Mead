%Declaração de Funções
centroid = @(x,y) [(x(1)+y(1))/2,(y(2)+x(2))/2];
distancia = @(x) x(1)^2 + x(2)^2 - 2*x(1) - 2*x(2) + 2;
xr = @(x,y) [x(1) + 1*(x(1) - y(1)), x(2) + 1*(x(2) - y(2))];
xe = @(x,y) [x(1) + 2*(x(1) - y(1)), x(2) + 2*(x(2) - y(2))];
xc = @(x,y) [x(1) + 0.5*(y(1) - x(1)), x(2) + 0.5*(y(2) - x(2))];

%Declaração dos Pontos Iniciais
v1 = [9.5,8];
v2 = [1,5];
v3 = [5,3];

old_array=0;

%Loop de Iterações
while(1)
  array = [v1,v2,v3]
% Calcular a distância dos pontos em relação ao gradiente  
  array_distances = [distancia(v1); distancia(v2); distancia(v3)];
% Ordena os resultados e salva na variável y seus indices
  [x y] = sort(array_distances);
% Reordena as variaveis
  v1 = array(:,[y(1)*2-1,y(1)*2]);
  v2 = array(:,[y(2)*2-1,y(2)*2]);
  v3 = array(:,[y(3)*2-1,y(3)*2]);
  
% Teste de condição de parada
  if(array==old_array)
    break;
  end
  
% Calcula a centroid entre v1 e v2
  array_centroid = [centroid(v1,v2)];
% Reflete o ponto v3
  reflected_point = xr(array_centroid,v3);
% f(x1)=<f(xr)<f(xn), xn+1<-xr
  if(distancia(v1)<=distancia(reflected_point)<distancia(v2))
    v3 = reflected_point;
  end
% f(xr)<f(x1)
  if(distancia(reflected_point)<distancia(v1))
    expanded_point = xe(reflected_point, array_centroid);
%   f(xe)<f(xr), xn+1<-xe 
    if(distancia(expanded_point)<distancia(reflected_point))
      v3 = expanded_point;
%   xn_1<-xr
    else
      v3 = reflected_point;
    end
% f(xr) > f(xn)
  else
    contraction_point = xc(v3,array_centroid);
%   f(xc)<f(xn+1), xn+1 <-xc
    if(distancia(contraction_point)<distancia(v3))
      v3 = contraction_point;
%   Redução dos eixos 
    else
      v2 = [v1(1) + 0.5*(v2(1)-v1(1)), v1(2) + 0.5*(v2(2)-v1(2))];
      v3 = [v1(1) + 0.5*(v3(1)-v1(1)), v1(2) + 0.5*(v3(2)-v1(2))];
    end
  end
% Salva para fazer a condição de parada
  old_array = array;
end
