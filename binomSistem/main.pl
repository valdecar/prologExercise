%show and/or inside predicate
f(X,Y):-
	X>Y,print(conclution0);
	X=Y,print(conclution1);
	X<Y,print(conclution2).

myLength(0,[]).
myLength(N,[X|ListTail]):-
	myLength(N1,ListTail),N is N1+1.
%use like
%?-myReverse(0,[1,2,3],L)
%[3,2,1|_G123]
myReverse(N,[],ListOut):-
	print(ListOut).
myReverse(N,[X|ListTail],ListOut):-
	N1 is N+1,
	myReverse(N1,ListTail,[X|ListOut]).

%use like
%?-changeElemOfList(1,5,[1,2,3],L).
%L = [1, 5, 3].
changeElemOfList(ElemNumber,ElemNewValue,ListOld,ListNew):-
	nth0(ElemNumber,ListOld,_,ListTmp),
	nth0(ElemNumber,ListNew,ElemNewValue,ListTmp).

%change at one element with index ElemNumper
changeElemOfListAt1(ElemNumber,ListOld,ListNew):-
	nth0(ElemNumber,ListOld,ElemOldValue,ListTmp),
	ElemNewValue is ElemOldValue+1,
	nth0(ElemNumber,ListNew,ElemNewValue,ListTmp).
%change at N element with index ElemNumper
changeElemOfListAtN(ElemNumber,N,ListOld,ListNew):-
	nth0(ElemNumber,ListOld,ElemOldValue,ListTmp),
	ElemNewValue is ElemOldValue+N,
	nth0(ElemNumber,ListNew,ElemNewValue,ListTmp).

factorial(0,N):-
	N=1.
factorial(K,N):-
	K>0,
	K1 is K-1,
	factorial(K1,N1),
	N is N1*K.
binom(N,K,B):-
	N>=K,
	factorial(N,N1),
	NKTmp is N-K,
	factorial(NKTmp,NK1),
	factorial(K,K1),
	B is N1/(NK1*K1).
%init T=1
%%find Ck: binom(Ck,K,Xk)
bb(Ck,K,Xk,T):-
	T=<Xk,
	binom(T,K,B),
	B=Xk,
	Ck is T.
bb(Ck,K,Xk,T):-
	T=<Xk,
	T1 is T+1,
	bb(Ck,K,Xk,T1).
%find  C1,...,Ck : binom(C1,1)=X1,...,binom(Ck,k)=Xk
%init K=1
b(K,[],ListOut):-
	append([],[],ListOut).
b(K,[Xk|ListTail],ListOut):-
	%length([Ck|ListTail],N),
	%K=<N,
	bb(Ck,K,Xk,1),%find Ck: binom(Ck,K,Xk)
	K1 is K+1,
	b(K1,ListTail,ListOut1),
	append([Ck],ListOut1,ListOut).

%find [c_1,..,c_n|c_1+..+c_n=X]
%K going throut dimention List
%T up value of some element List[i]
%init K=0,T=1,List=[0,0,0]
s(X,List,K,T):-
	%c_1+..+c_n=X
	sum_list(List,S),
	S=X,
	%permutation(List,ListPerm),
	b(1,List,ListBinoms),
	print(ListBinoms).
%change c_1,..,c_n one by one.
s(X,List,K,T):-
	sum_list(List,S),
	S<X,
	length(List,N),
	K<N,
	changeElemOfListAt1(K,List,NewList),
	Knew is K+1,
	s(X,NewList,Knew,T);
	sum_list(List,S),
	S<X,
	length(List,N),
	%second round
	K>=N,
	Knew is 0,
	s(X,List,Knew,T).
%change T and up c_K at T
s(X,List,K,T):-
	T=<X,
	sum_list(List,S),
	S<X,
	changeElemOfListAtN(K,T,List,NewList),
	Tnew is T+1,
	s(X,NewList,K,T).