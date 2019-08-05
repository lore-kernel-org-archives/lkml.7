Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10500C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85E320644
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm1oADYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfHEOn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:43:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41488 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfHEOn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:43:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so2236095qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=no3R8uHJn/9Ndu80u9sBGxzmrCb/4AhgTseW2J0eL70=;
        b=Vm1oADYkXmDJsMpBUFieXKlX+TaPfP6M67ElUkZ8KmHDThWnCtrtZcyDD+OYLzZ8X1
         RV9dT0oCmFXr5SWNKXMlOjCx1dLXoMGq1Xkh+xaYdmV99fZ7BSTB0W4gLVxGiJv1L6wc
         eu5pRVD1ucO7+sZdQSorb0Ds7x7nAa8mPFA/zwCNm2VAEuSneAooCo8hsZtHrOftUx0e
         UBXkt1Hi6UwjOGYmOLpeGF3hw725MpZGsaWobs5eaSlGYTM29eHwH25GPyl19lf8gE19
         dhC8LDIzJqWIJPiwaaUSztlvm14LKfmahzMDqEkYW5IeY6KhZ5cxQLeoiHYy3W6X/qY7
         1rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=no3R8uHJn/9Ndu80u9sBGxzmrCb/4AhgTseW2J0eL70=;
        b=RjPNfEvT3QVcopgv+LXvJpjOVx54HOeXyG/HCYjJHhYhsnBWbiGAb1zKn8dFXNN7Rt
         ockji7nt30OBkbdaOL3TAGwknUsc0ZS1ru86/+LIzEZWnCyqJVN2+Idu4CAvXiAfRVqk
         Bu+gFO1mD5ABctbL0na//hebR1mtK2DNREy9LoExQyOT8a8y41hbebBM0e1a/6xoJzp/
         MZ4Y7S2H/RVKx5QOlEhqmwf7NhK3gQ2OKlyC2GUrVCfLwnR/pTf2x4urOpQdbaI/V3bs
         V516QwDHK4NEATMl0EQSB6uFVYn870uoO/iM+TTCOrN7mIIehUOJ3mu/W35x9N9DiTmm
         n2sQ==
X-Gm-Message-State: APjAAAWjUQXYQuJVFoZz8eyGVQhZXiykIG/ssu+uI8bgRbwUjLbaX5wR
        3vX0skhTF9xELQgzLUV5WXs=
X-Google-Smtp-Source: APXvYqxayVqC7vxfTOPvQwZT4b3Cs8k1DuVP2GHa33EJBnu1K/AdvbzL0pdD7XCyg9Wa2Ser65V9+A==
X-Received: by 2002:ac8:688:: with SMTP id f8mr31294606qth.130.1565016208193;
        Mon, 05 Aug 2019 07:43:28 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t26sm44632518qtc.95.2019.08.05.07.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 07:43:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0AAFA21ADD;
        Mon,  5 Aug 2019 10:43:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Aug 2019 10:43:26 -0400
X-ME-Sender: <xms:i0BIXTinMSb24A21pOheuq0Map1zIfN0JuuAJWURKm-RjKCY27M9ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddtjedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepge
    ehrdefvddruddvkedruddtleenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:i0BIXXZIVdCgnwWPLR1AGn9Xxn3UJnxmES0qnvonC7c2QlyxC6ZZ7w>
    <xmx:i0BIXfEroebiAy1KRDe1KjzGqC0NVfauXIDVPYJCZI1OAxVNJdXcdw>
    <xmx:i0BIXZ7Qy3PXaYQpXvp3hDCPQ5f5rT4vW0vuopJgaVbi3BcbSpIMiA>
    <xmx:jkBIXRjZxAGK_2PR1aSkYukjSxkAvfIifnELD69SxGa0LT0JcMHlgZngEjo>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A93A380085;
        Mon,  5 Aug 2019 10:43:23 -0400 (EDT)
Date:   Mon, 5 Aug 2019 22:43:18 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        juri.lelli@redhat.com, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH] locking/percpu_rwsem: Rewrite to not use rwsem
Message-ID: <20190805144318.GA972@tardis>
References: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20190805140241.GI2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 04:02:41PM +0200, Peter Zijlstra wrote:
[...]
> =20
>  static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
>  {
> +	rwsem_release(&sem->dep_map, 1, _RET_IP_);
> +
>  	preempt_disable();
>  	/*
>  	 * Same as in percpu_down_read().
>  	 */
> -	if (likely(rcu_sync_is_idle(&sem->rss)))
> +	if (likely(rcu_sync_is_idle(&sem->rss))) {
>  		__this_cpu_dec(*sem->read_count);
> -	else
> -		__percpu_up_read(sem); /* Unconditional memory barrier */
> -	preempt_enable();
> +		preempt_enable();
> +		return;
> +	}
> =20
> -	rwsem_release(&sem->rw_sem.dep_map, 1, _RET_IP_);

Missing a preempt_enable() here?

Regards,
Boqun

> +	__percpu_up_read(sem); /* Unconditional memory barrier */
>  }
> =20
[...]

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl1IQIIACgkQSXnow7UH
+riYhwgArXXexCI0Q1tAuo22Sm/mIuybM3hwoFeONPNiLj0lk2CkxXgk+pjpJ0e8
jBzEkvDXllSIuEbpNwYo7fsyPgR6Bz7+Pgt/H3ntOXDENpsIFyqTPXlI2yPixIwc
7YQey4/qPlLXxG/8lQl7KjZSWTMLcC3rTpLXzOr5jOiOKrnWAZ2jIs+LiGJxnON8
dZT0jo21LEDh1cgj85rxplP7mh4OFoPvGkdzSxm0hGe22Jk96lTyw/WV0BpnQkWw
q7i7n4lLtJGuzTSKxu2ulonLUI9mGBZeh+PXBPqMUSvuxQIJ6fywe3p5TpGXsjn0
KFgxmj77SKhuj+zFwdMMzWwgGGxkPg==
=iaEy
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
