Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74E9C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52C421019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZanEG8f6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfE2LpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:45:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35612 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfE2Lo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:44:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id l128so1221465qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saTss3WI4v6NFzjGLfT7HQ5xbm2l2+yyVHdCJ+dqTy0=;
        b=ZanEG8f6daZ6KHNn/3CokKUxEz4szRiJWaFDVc2AnzBbLWG9bQY/uZWmRoN7XMwiY+
         7ZXDUvXIiLdEAyzgj849pP+dgDDBxZTZTScctzwO/G1i4EA3kVjTMxC+zvhG4gk+cgup
         T/9IkbXPIJRHOQ1VuP8SVumqDTURuImbEaeNF3MHcjT3EztTTCMUI30ckr9EZ8QwD+V7
         kCE9Tp1tNQC7ElBhOPaQ/sWaQZE49PiLQTHKBdKLaxf5re8vClN0ibK2r6tZH/pr/3dV
         72Ck+DkKyK0p58plgzsYsq7PrhaKzlzx2UKuQubcxS7wq9ULYkHttujgHifYiV7a4gIk
         fneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saTss3WI4v6NFzjGLfT7HQ5xbm2l2+yyVHdCJ+dqTy0=;
        b=ulgGphX+8DLv91+jBd0CPxVLQeW5tMivxNedDdDKZFEXd8AoLGFjT6ia6s2dUl1ryc
         WGzZBy3gYnGv+Ym5HdqhsJgPZNc+gat3r6H2uI23XDqYmxSKZQYdajBhMYWSTaialVga
         Lqy8yxw/wR6tC2xci+2pgl58uCs8EahUmPCYE95nedm393yqElEkRKzXAoeirAjgSsi+
         r2QNh/eQGMMo5VeMaf1CKnUcG00xz0rHhUa00kymvEiN3SwlG9XYo+pf3tW7rtC4BXuK
         gAJeoCx0UmzgrKLxtFwvD0ZgxmrjjWNQI1qdn0WisinFBrzq4zN5zE4b6/+yX7MHk9Ud
         PWbw==
X-Gm-Message-State: APjAAAVII6yre7VnXshBlyKlCFlDgkFNJN4LGi8z7WWv+uoxVmakFX4V
        7pJrrTJkkcD4QuXcynFo3as=
X-Google-Smtp-Source: APXvYqyWqBcoZYdtH7zKBoHPQSY5syLt2sOBYEjoVtmJdxh6Jnzcfi3hXMkHz9hXT8qF/4rJ4koRpQ==
X-Received: by 2002:a37:a4d3:: with SMTP id n202mr13523412qke.84.1559130298504;
        Wed, 29 May 2019 04:44:58 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n26sm554309qtn.36.2019.05.29.04.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 04:44:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C89EE22095;
        Wed, 29 May 2019 07:44:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 May 2019 07:44:56 -0400
X-ME-Sender: <xms:t3DuXPIN55-r_6nfIGPOsvCjiFk5LFIEeXBsewZ0M3peGBAxNGyVXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepge
    ehrdefvddruddvkedruddtleenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:t3DuXHZRJQRhjETX_U_AK8CnFJU37LyaC4xk3EbLcHcMpYaW9xky2Q>
    <xmx:t3DuXCughnmlzww6rWXGWHg6r8M5Lo4RYfoez9IfNmy1Ls2J1GYbkA>
    <xmx:t3DuXMvd27K5b4D9Q5CvMsOC2cvuyvY7v4ivWtlhrhV0hYt74M9njQ>
    <xmx:uHDuXOW_v1M9RxFnJzoHeQOMor1w4x3dCJDnc1cufq8ZJfustai7rMebrbY>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id DAA40380073;
        Wed, 29 May 2019 07:44:54 -0400 (EDT)
Date:   Wed, 29 May 2019 19:44:51 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/17] locking/lockdep: Adjust lockdep selftest cases
Message-ID: <20190529114451.GA12812@tardis>
References: <20190516080015.16033-1-duyuyang@gmail.com>
 <20190516080015.16033-12-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20190516080015.16033-12-duyuyang@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 04:00:09PM +0800, Yuyang Du wrote:
> With read-write lock support, some read-write lock cases need to be updat=
ed,
> specifically, some read-lock involved deadlocks are actually not deadlock=
s.
> Hope I am not wildly wrong.
>=20
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> ---
>  lib/locking-selftest.c | 44 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> index a170554..f83f047 100644
> --- a/lib/locking-selftest.c
> +++ b/lib/locking-selftest.c
> @@ -424,7 +424,7 @@ static void rwsem_ABBA2(void)
>  	ML(Y1);
>  	RSL(X1);
>  	RSU(X1);
> -	MU(Y1); // should fail
> +	MU(Y1); // should NOT fail

I'm afraid you get this wrong ;-) reader of rwsem is non-recursive if I
understand correctly, so case like:

	Task 0			Task 1

	down_read(A);
				mutex_lock(B);

				down_read(A);
	mutex_lock(B);

can be a deadlock, if we consider a third independent task:

	Task 0			Task 1			Task 2

	down_read(A);
				mutex_lock(B);
							down_write(A);
				down_read(A);
	mutex_lock(B);

in this case, Task 1 can not get it's lock for A, therefore, deadlock.

Regards,
Boqun

>  }
> =20
> =20
> @@ -462,12 +462,13 @@ static void rwsem_ABBA3(void)
> =20
>  /*
>   * ABBA deadlock:
> + *
> + * Should fail except for either A or B is read lock.
>   */
> -
>  #define E()					\
>  						\
>  	LOCK_UNLOCK_2(A, B);			\
> -	LOCK_UNLOCK_2(B, A); /* fail */
> +	LOCK_UNLOCK_2(B, A);
> =20
>  /*
>   * 6 testcases:
> @@ -494,13 +495,15 @@ static void rwsem_ABBA3(void)
> =20
>  /*
>   * AB BC CA deadlock:
> + *
> + * Should fail except for read or recursive-read locks.
>   */
> =20
>  #define E()					\
>  						\
>  	LOCK_UNLOCK_2(A, B);			\
>  	LOCK_UNLOCK_2(B, C);			\
> -	LOCK_UNLOCK_2(C, A); /* fail */
> +	LOCK_UNLOCK_2(C, A);
> =20
>  /*
>   * 6 testcases:
> @@ -527,13 +530,15 @@ static void rwsem_ABBA3(void)
> =20
>  /*
>   * AB CA BC deadlock:
> + *
> + * Should fail except for read or recursive-read locks.
>   */
> =20
>  #define E()					\
>  						\
>  	LOCK_UNLOCK_2(A, B);			\
>  	LOCK_UNLOCK_2(C, A);			\
> -	LOCK_UNLOCK_2(B, C); /* fail */
> +	LOCK_UNLOCK_2(B, C);
> =20
>  /*
>   * 6 testcases:
> @@ -560,6 +565,8 @@ static void rwsem_ABBA3(void)
> =20
>  /*
>   * AB BC CD DA deadlock:
> + *
> + * Should fail except for read or recursive-read locks.
>   */
> =20
>  #define E()					\
> @@ -567,7 +574,7 @@ static void rwsem_ABBA3(void)
>  	LOCK_UNLOCK_2(A, B);			\
>  	LOCK_UNLOCK_2(B, C);			\
>  	LOCK_UNLOCK_2(C, D);			\
> -	LOCK_UNLOCK_2(D, A); /* fail */
> +	LOCK_UNLOCK_2(D, A);
> =20
>  /*
>   * 6 testcases:
> @@ -594,13 +601,15 @@ static void rwsem_ABBA3(void)
> =20
>  /*
>   * AB CD BD DA deadlock:
> + *
> + * Should fail except for read or recursive-read locks.
>   */
>  #define E()					\
>  						\
>  	LOCK_UNLOCK_2(A, B);			\
>  	LOCK_UNLOCK_2(C, D);			\
>  	LOCK_UNLOCK_2(B, D);			\
> -	LOCK_UNLOCK_2(D, A); /* fail */
> +	LOCK_UNLOCK_2(D, A);
> =20
>  /*
>   * 6 testcases:
> @@ -627,13 +636,15 @@ static void rwsem_ABBA3(void)
> =20
>  /*
>   * AB CD BC DA deadlock:
> + *
> + * Should fail except for read or recursive-read locks.
>   */
>  #define E()					\
>  						\
>  	LOCK_UNLOCK_2(A, B);			\
>  	LOCK_UNLOCK_2(C, D);			\
>  	LOCK_UNLOCK_2(B, C);			\
> -	LOCK_UNLOCK_2(D, A); /* fail */
> +	LOCK_UNLOCK_2(D, A);
> =20
>  /*
>   * 6 testcases:
> @@ -1238,7 +1249,7 @@ static inline void print_testname(const char *testn=
ame)
>  /*
>   * 'read' variant: rlocks must not trigger.
>   */
> -#define DO_TESTCASE_6R(desc, name)				\
> +#define DO_TESTCASE_6AA(desc, name)				\
>  	print_testname(desc);					\
>  	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
>  	dotest(name##_wlock, FAILURE, LOCKTYPE_RWLOCK);		\
> @@ -1249,6 +1260,17 @@ static inline void print_testname(const char *test=
name)
>  	dotest_rt(name##_rtmutex, FAILURE, LOCKTYPE_RTMUTEX);	\
>  	pr_cont("\n");
> =20
> +#define DO_TESTCASE_6R(desc, name)				\
> +	print_testname(desc);					\
> +	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
> +	dotest(name##_wlock, FAILURE, LOCKTYPE_RWLOCK);		\
> +	dotest(name##_rlock, SUCCESS, LOCKTYPE_RWLOCK);		\
> +	dotest(name##_mutex, FAILURE, LOCKTYPE_MUTEX);		\
> +	dotest(name##_wsem, FAILURE, LOCKTYPE_RWSEM);		\
> +	dotest(name##_rsem, SUCCESS, LOCKTYPE_RWSEM);		\
> +	dotest_rt(name##_rtmutex, FAILURE, LOCKTYPE_RTMUTEX);	\
> +	pr_cont("\n");
> +
>  #define DO_TESTCASE_2I(desc, name, nr)				\
>  	DO_TESTCASE_1("hard-"desc, name##_hard, nr);		\
>  	DO_TESTCASE_1("soft-"desc, name##_soft, nr);
> @@ -1991,7 +2013,7 @@ void locking_selftest(void)
>  	debug_locks_silent =3D !debug_locks_verbose;
>  	lockdep_set_selftest_task(current);
> =20
> -	DO_TESTCASE_6R("A-A deadlock", AA);
> +	DO_TESTCASE_6AA("A-A deadlock", AA);
>  	DO_TESTCASE_6R("A-B-B-A deadlock", ABBA);
>  	DO_TESTCASE_6R("A-B-B-C-C-A deadlock", ABBCCA);
>  	DO_TESTCASE_6R("A-B-C-A-B-C deadlock", ABCABC);
> @@ -2048,7 +2070,7 @@ void locking_selftest(void)
>  	pr_cont("             |");
>  	dotest(rlock_ABBA2, SUCCESS, LOCKTYPE_RWLOCK);
>  	pr_cont("             |");
> -	dotest(rwsem_ABBA2, FAILURE, LOCKTYPE_RWSEM);
> +	dotest(rwsem_ABBA2, SUCCESS, LOCKTYPE_RWSEM);
> =20
>  	print_testname("mixed write-lock/lock-write ABBA");
>  	pr_cont("             |");
> --=20
> 1.8.3.1
>=20

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlzucK8ACgkQSXnow7UH
+riNDAf+MRdBMrKvao3O0YfV7Rg8vEb2/KwZVHdj78NXb+1rkkK9EbP7pGomyp+u
f8gr5mAm014BOZe5cd1pvyDrS+ZxA7monBzqNRpFXTbgcmrKV3H+09mK3vrj3XhY
92x5Y+6uyY5Bf4kToz5k+qzyXDGoYXvGCKqimzWbASM+PAa6XFn2VOBYtD+04aeE
AUNva+H8RUbkX1qrflr0jozdWpnL/ELuK0fVpRS8W32Cy3dQxZs4qpj2djO/Tnza
gANrdIWLuERDlelXec00Q2O0qXjZKwgSFURCYhjYcH8rrq+F8UBmfC9fy42VA14C
0IMQW4dUBC9guMRKttCKkBOsF9a8wQ==
=/l2M
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
