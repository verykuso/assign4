PImage bg1,bg2,fighter,hp,treasure,start1,start2,end1,end2,shoot,enemy;
int f=0,k=0,m=0,n=0,shoot_count=0,game_state,enemy_shape,game_start=0,game_run=1,game_end=2,currentFlame=0;
float fighterX,fighterY,treasureX,treasureY,bg1X=640,bg2X=0,hpRate=10,enemy_space,yy;
PImage[] flame = new PImage[5];
float[] enemyX = new float[5];
float[] enemyY = new float[5];
float[][] enemyX1 = new float[5][5];
float[][] enemyY1 = new float[5][5];
float[] shootX = new float[5];
float[] shootY = new float[5];
boolean goUp = false;
boolean goDown = false;
boolean goLeft = false;
boolean goRight = false;
boolean[] fire = new boolean[5];



void setup () {
  size(640,480);
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  treasure=loadImage("img/treasure.png");
  fighter=loadImage("img/fighter.png");
  shoot=loadImage("img/shoot.png");
  hp=loadImage("img/hp.png");  
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  enemy = loadImage("img/enemy.png");
  enemy_space = 61;  
  fighterX=width-50;
  fighterY=random(20,height-20);
  treasureX=random(50,width-50);
  treasureY=random(40,height-40);
  game_state = 0;
  enemy_shape = 0;
  
  enemyY[0]=random(50,400);
  
  for(int i=1;i<5;i++)  enemyY[i]=enemyY[0];
  for(int i=0;i<5;i++)  enemyX[i]= -61-i*enemy_space;
 
  for(int i=0;i<5;i++) flame[i]=loadImage("img/flame"+(i+1)+".png");
  yy=random(30,130);//for 2D-array enemyY1 init
  
  //2D array init
  for(int i=0;i<5;i++)
  for(int j=0;j<5;j++)
  {
   enemyX1[i][j]=-61-i*enemy_space; 
   enemyY1[i][j]=yy+j*enemy_space; 
   }
  //end of 2D init
  
  f=(currentFlame++)%5;
}


void draw(){
 background(255);
 //begin the game_state switch
 switch(game_state){ 
   case 0://game_state case 0
     image(start2,0,0);
    if(mouseX>=207&&mouseX<=454&&mouseY>=378&&mouseY<=413) image(start1,0,0);
    
    if(mousePressed)
    if(mouseX>=207&&mouseX<=454&&mouseY>=378&&mouseY<=413)
      game_state = game_run;
      break;
    // end of game_state case 0  
      
      
    case 1://game_state case game_run  
      //background appears
        image(bg1,bg1X-640,0);
        bg1X+=3;
        bg1X%=1280;
        image(bg2,bg2X-640,0);
        bg2X+=3;
        bg2X%=1280;
      //end of background
            
      //fighter appears
      image(fighter,fighterX,fighterY);
      //fighter can not move beyond the area
   
     if(fighterX<=0) fighterX = 0;
     if(fighterX>=width-51) fighterX=width-51;
     if(fighterY<=0) fighterY=0;
     if(fighterY>=height-51) fighterY = height-51;
      // key-controlling the fighter 
      if(goUp) fighterY-=2;
      if(goDown) fighterY +=2;
      if(goLeft) fighterX -=2;
      if(goRight) fighterX +=2;
      //end of fighter controlling
      
      
      //TREASURE
    //treasure appears
       image(treasure,treasureX,treasureY);
    //when fighter touch treasure   
       if( (fighterX>=treasureX&&fighterX<=treasureX+41&&fighterY>=treasureY&&fighterY<=treasureY+41)||(treasureX>=fighterX&&treasureX<=fighterX+51&&treasureY>=fighterY&&treasureY<=fighterY+51) ) 
          {
            treasureX=random(50,width-50);
            treasureY=random(40,height-40);
            hpRate++;
            if(hpRate>=10) hpRate=10;
            }
    //end of treasure
    
    //HP bar appears
        fill(255,0,0);
        if(hpRate<=0) game_state = game_end;
        rect(41,23,200*hpRate/10,20);
        image(hp,30,20);
     //end of HP   
    
      //FIRING    
    //發射子彈，如果出現值為true則出現並前進，如果越過邊界則出現值為false而消失，此時可再發射一顆子彈
 
   if(fire[0]==true){
   image(shoot,shootX[0]-=3,shootY[0]);
   if(shootX[0]<=-31){
    fire[0]=false;shootY[0]=-99;
   }
   }
   if(fire[1]==true){
   image(shoot,shootX[1]-=3,shootY[1]);
   if(shootX[1]<=-31){
   fire[1]=false;shootY[1]=-99;
   }
   }
   if(fire[2]==true){
   image(shoot,shootX[2]-=3,shootY[2]);
   if(shootX[2]<=-31){
   fire[2]=false;shootY[2]=-99;
   }
   }
   if(fire[3]==true){
   image(shoot,shootX[3]-=3,shootY[3]);
   if(shootX[3]<=-31){
   fire[3]=false;shootY[3]=-99;
   }
   }
   if(fire[4]==true){
   image(shoot,shootX[4]-=3,shootY[4]);
   if(shootX[4]<=-31){
   fire[4]=false;shootY[4]=-99;
   }
   }
   //end of FIRING    
      
      // beginning of the enemy shape
      //switch(enemy_shape)
      
      switch(enemy_shape){
        
        //enemy_shape case 0
        case 0:
        image(enemy,enemyX[0],enemyY[0]);
        image(enemy,enemyX[1],enemyY[1]);
        image(enemy,enemyX[2],enemyY[2]);
        image(enemy,enemyX[3],enemyY[3]);
        image(enemy,enemyX[4],enemyY[4]);
          for(int i=0;i<5;i++) enemyX[i]+=4;//enemy fowards
          //when fighter crash enemy
          for(int i=0;i<5;i++)
               //if  ((fighterX>=enemyX[j]-j*enemy_space&&fighterX<=enemyX[j]-j*enemy_space+61)   &&      ((fighterY>=enemyY[j]&&fighterY<=enemyY[j]+61)||(fighterY+51>=enemyY[j]&&fighterY+51<=enemyY[j]+61))) 
                //if  ((fighterX>=enemyX[i]-i*enemy_space&&fighterX<=enemyX[i]-i*enemy_space+61) && ((fighterY>=enemyY[i]-25)||(fighterY<=enemyY[i]+25))) 
                if( (fighterX>=enemyX[i]&&fighterX<=enemyX[i]+61) &&((fighterY>=enemyY[i]&&fighterY<=enemyY[i]+61)||(fighterY+51>=enemyY[i]&&fighterY+51<=enemyY[i]+61))  )
                 {
                    hpRate-=2;
                  image(flame[f],fighterX-30,fighterY); if(frameCount%6==0) image(flame[f],fighterX-30,fighterY);
                   
                    enemyY[i]=888;//let enemy will not hit again
                 }
                    
          //end of fighter crash enemy
          
          //begin to shoot
          
             for(int j=0;j<5;j++)
             for(int i=0;i<5;i++)
              {
                //if  ((shootX[j]>=enemyX[i]-i*enemy_space&&shootX[j]<=enemyX[i]-i*enemy_space+61)   &&      ((shootY[j]>=enemyY[i]&&shootY[j]<=enemyY[i]+61)||(shootY[j]<enemyY[i]&&shootY[j]+27>=enemyY[i]+61))) 
                if( (shootX[j]>=enemyX[i]&&shootX[j]<=enemyX[i]+61) &&((shootY[j]>=enemyY[i]&&shootY[j]<=enemyY[i]+61)||(shootY[j]+27>=enemyY[i]&&shootY[j]+27<=enemyY[i]+61))  )
                 {
                  fire[i]=false;
                  image(flame[f],shootX[j]-30,shootY[j]);if(frameCount%6==0) image(flame[f],shootX[j]-30,shootY[j]);
                    shootX[j]=-999;shootY[j]=999;//let bullet will not hit again
                    enemyY[i]=888;//let enemy will not hit again
                 }
              }        
          
          //end of shoot
          
          
          
          
           if(enemyX[4]>=width) //if enemy all go out then reshape and go to case 1
            {   //init for case 1
                enemyY[0]=random(30,140);
                for(int i=1;i<5;i++) enemyY[i]=enemyY[0]+i*enemy_space;
                for(int i=0;i<5;i++) enemyX[i]= -61-i*enemy_space;
                enemy_shape = 1;//go to enemy_shape case 1
                } 
             break;
                //end of enemy_shape case 1
        
        
        //enemy_shape case 1
        case 1:
        image(enemy,enemyX[0],enemyY[0]);
        image(enemy,enemyX[1],enemyY[1]);
        image(enemy,enemyX[2],enemyY[2]);
        image(enemy,enemyX[3],enemyY[3]);
        image(enemy,enemyX[4],enemyY[4]);
        for(int i=0;i<5;i++) enemyX[i]+=4;//enemy fowards
        
        //when fighter crash enemy
          for(int i=0;i<5;i++)
              // if  ((fighterX>=enemyX[i]-i*enemy_space&&fighterX<=enemyX[i]-i*enemy_space+61)   &&      ((fighterY>=enemyY[i]&&fighterY<=enemyY[i]+61)||(fighterY+51>=enemyY[i]&&fighterY+51<=enemyY[i]+61))) 
            //if ((fighterX>=enemyX[i]-i*enemy_space&&fighterX<=enemyX[i]-i*enemy_space+61)&&((fighterY>=enemyY[i]+i*enemy_space-25)||(fighterY<=enemyY[i]+i*enemy_space+25)||((fighterY<=enemyY[i]+i*enemy_space)&&(fighterY+51<=enemyY[i]+i*enemy_space+61))))     
                if( (fighterX>=enemyX[i]&&fighterX<=enemyX[i]+61) &&((fighterY>=enemyY[i]&&fighterY<=enemyY[i]+61)||(fighterY+51>=enemyY[i]&&fighterY+51<=enemyY[i]+61))  )
                 {
                    hpRate-=2;
                    image(flame[f],fighterX-30,fighterY);if(frameCount%6==0) image(flame[f],fighterX-30,fighterY);
                    enemyY[i]=888;//let enemy will not hit again
                 }
                    
          //end of fighter crash enemy  
          
      
        //begin to shoot
          
             for(int j=0;j<5;j++)
             for(int i=0;i<5;i++)
              {
                //if  ((shootX[j]>=enemyX[i]-i*enemy_space&&shootX[j]<=enemyX[i]-i*enemy_space+61)   &&      ((shootY[j]>=enemyY[i]&&shootY[j]<=enemyY[i]+61)||(shootY[j]<enemyY[i]&&shootY[j]+27>=enemyY[i]+61))) 
                if( (shootX[j]>=enemyX[i]&&shootX[j]<=enemyX[i]+61) &&((shootY[j]>=enemyY[i]&&shootY[j]<=enemyY[i]+61)||(shootY[j]+27>=enemyY[i]&&shootY[j]+27<=enemyY[i]+61))  )
                 {
                  fire[i]=false;
                  image(flame[f],shootX[j]-30,shootY[j]);if(frameCount%6==0) image(flame[f],shootX[j]-30,shootY[j]);
                    shootX[j]=-999;shootY[j]=999;//let bullet will not hit again
                    enemyY[i]=888;//let enemy will not hit again
                 }
              }        
          
          //end of shoot
      
      if(enemyX[4]>=width) //if enemy all go out then reshape and go to case 1
            {
              //2D array init for case 2
              yy=random(30,130);//for 2D-array enemyY1 init
              for(int i=0;i<5;i++)
              for(int j=0;j<5;j++)
                {
                   enemyX1[i][j]=-61-i*enemy_space; 
                   enemyY1[i][j]=yy+j*enemy_space; 
                     }
             //end of 2D init
             
             
              enemy_shape = 2;
             }
           
         break;//end of enemy_shape case 1
        
        
        
        //enemy_shape case 2
        case 2:
        
         for(int i=0;i<5;i++)
          for(int j=0;j<5;j++)
           if  ((i==2&&j==0)||(i==1&&j==1)||(i==3&&j==1)|(i==0&&j==2)||(i==4&&j==2)||(i==1&&j==3)||(i==3&&j==3)||(i==2&&j==4))
                {image(enemy,enemyX1[i][j],enemyY1[i][j]);
                  enemyX1[i][j]+=4;
                }
        //fighter crashes enemy
        
        for(int i=0;i<5;i++)
          for(int j=0;j<5;j++)
           if ((i==2&&j==0)||(i==1&&j==1)||(i==3&&j==1)|(i==0&&j==2)||(i==4&&j==2)||(i==1&&j==3)||(i==3&&j==3)||(i==2&&j==4))
            //if(  (fighterX>=enemyX1[i][j]-i*enemy_space&&fighterX<=enemyX1[i][j]-i*enemy_space+61) && ((fighterY>=enemyY1[i][j]+j*enemy_space&&fighterY<=enemyY1[i][j]+j*enemy_space+61)||(fighterY+51>=enemyY1[i][j]+j*enemy_space&&fighterY+51<=enemyY1[i][j]+j*enemy_space+61)) )
              if( (fighterX>=enemyX1[i][j]&&fighterX<=enemyX1[i][j]+61) &&((fighterY>=enemyY1[i][j]&&fighterY<=enemyY1[i][j]+61)||(fighterY+51>=enemyY1[i][j]&&fighterY+51<=enemyY1[i][j]+61))  )
               {
                    hpRate-=2;
                   image(flame[f],fighterX-30,fighterY);if(frameCount%6==0) image(flame[f],fighterX-30,fighterY);
                    enemyY1[i][j]=1888;//let enemy will not hit again
                     }
      
        
        
        
        //end of fighter crashes enemy
        
       //begin to shoot
             for(int s=0;s<5;s++)
             for(int j=0;j<5;j++)
             for(int i=0;i<5;i++)
              {
                
                if( (shootX[s]>=enemyX1[i][j]&&shootX[s]<=enemyX1[i][j]+61) &&((shootY[s]>=enemyY1[i][j]&&shootY[s]<=enemyY1[i][j]+61)||(shootY[s]+27>=enemyY1[i][j]&&shootY[s]+27<=enemyY1[i][j]+61))  )
                 {
                  fire[s]=false;
                  image(flame[f],shootX[s]-30,shootY[s]);if(frameCount%6==0) image(flame[f],shootX[s]-30,shootY[s]);
                    shootX[s]=-999;shootY[s]=4999;//let bullet will not hit again
                    enemyY1[i][j]=2888;//let enemy will not hit again
                 }
              }        
          
          //end of shoot
        
        
        
        
        
        if(enemyX1[4][2]>=width) //if enemy all go out then reshape and go to case 0
             { //init for case 0
                enemyY[0]=random(50,400);
  
                for(int i=1;i<5;i++)  enemyY[i]=enemyY[0];
                for(int i=0;i<5;i++)  enemyX[i]= -61-i*enemy_space;
          
               enemy_shape = 0;
               }
            break;//end of enemy_shape case 2
            }   
    
    break;//end of game_state 1
    
    
  // game_state case game_end  
    case 2:
    //init all
          hpRate=10;//if not recovering here, game will be over soon.
          enemyY[0]=random(50,400);
          for(int i=1;i<5;i++)  enemyY[i]=enemyY[0];
          for(int i=0;i<5;i++)  enemyX[i]= -61-i*enemy_space;
          //2D array init
          for(int i=0;i<5;i++)
          for(int j=0;j<5;j++)
          {
           enemyX1[i][j]=-61-i*enemy_space; 
           enemyY1[i][j]=yy+j*enemy_space; 
               }
            //end of 2D init
            
          for(int i=0;i<5;i++) fire[i] = false;//let bullet all disappear
          
          //end of init all
        image(end2,0,0);
        if(205<mouseX&&mouseX<440&&305<mouseY&&mouseY<350)
        image(end1,0,0);
        
        if(205<mouseX&&mouseX<440&&305<mouseY&&mouseY<350&&mousePressed)
        {           
         game_state = game_run;
         enemy_shape = 0;//if not set back to 0, it would keep the same shape as it ended
        }
  
       break;//end of game_state 2
  
      }//end of the game_state switch 
}//end of draw  

  


void keyPressed(){
  //controlling the fighters
  if(key==CODED){
    switch(keyCode){
      case UP:
        goUp= true;
        break;
      case DOWN:
        goDown= true;
        break;
       case LEFT:
        goLeft= true;
        break;
      case RIGHT:
        goRight= true;
        break;
      
    }
  }
  //end of controlling 
  
  //FIRING
  //fire the bullet when press spacebar, when press the spacebar, if fire[i] is false the do the job and let fire[i] becomes to true, if fire[i] is still true then ignore it and go to the next fire[i]
  
  if(key==' '){
  if(fire[0]==false)
    {
      shootX[0]=fighterX;
      shootY[0]=fighterY;
      fire[0]=true;
    }
    else if(fire[1]==false)
     {
      shootX[1]=fighterX;
      shootY[1]=fighterY;
      fire[1]=true;
    }
     else if(fire[2]==false)
     {
      shootX[2]=fighterX;
      shootY[2]=fighterY;
      fire[2]=true;
    }
     else if(fire[3]==false)
     {
      shootX[3]=fighterX;
      shootY[3]=fighterY;
      fire[3]=true;
    }
     else if(fire[4]==false)
     {
      shootX[4]=fighterX;
      shootY[4]=fighterY;
      fire[4]=true;
    }
  }
  //end of firing
  
  
  
}


void keyReleased(){
  
  //controlling the fighters
  if(key==CODED){
    switch(keyCode){
      case UP:
        goUp= false;
        break;
      case DOWN:
        goDown= false;
        break;
       case LEFT:
        goLeft= false;
        break;
      case RIGHT:
        goRight= false;
        break;
    }
  }
  //end of controlling
  
  
}
