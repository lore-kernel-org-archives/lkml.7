Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38882C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F336D2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oghbLHY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfE2Lh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:37:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36392 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfE2Lh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:37:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so1205101qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 04:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4I+yVsFui1q+HuA8J10YJCFLmUyLo2cIkU4LtqGBM1k=;
        b=oghbLHY8ep9QZKce2ieUeQT3gPuemuAnGQIo+m5Hoq6VpTfKMYApMbfP2+x+xf5vCn
         gnmcN7sIHwX45/4/MqLC4tmcRSEwqiugrXmdL88HcsNpeAKvdcmU3x19yuHS3kt/Fh4F
         B8CQQB6p7lK658kiFKQkAVRjHv5DGrWkLMeCXujK1b5tiHFJHU2UU/MRamPs6bpjwFT1
         cRUt58OV90HYa10qAsEGrFUBnS2uxY9AiEe5LvlyurW0ePe3rIOv/L60KiZb/0VxoaOL
         jd/Cun9qFDv8NS3XTxtXclJsGLpHaWmElUtIgjIB/agULXNgyrY9i/2thofvG1f1AoT1
         D98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4I+yVsFui1q+HuA8J10YJCFLmUyLo2cIkU4LtqGBM1k=;
        b=hweJfv2otFgAyPhUIf8nafQkoXqrbB0YBlD3+NG/8CrNiSWbJqnykqR7IKu5jyXkAM
         ak3CQZ9tU5wjAYH8+ZmWGATralz3wSJHTTmen0H8AbmRVXlsyoowmd/UpSvcNJIs7em1
         gWPRgKJFA0/NI9hUj+esZ8zDparenvT29ckiDBK/A+FIX//vkU0vypGO8igrTcrxPcNG
         TB4jjXhLum6MY0qW4np3vZM2WwSila/lM+QZ1H1KW5gvKXazaektDTNMDBiU/59tkR4f
         8EVSzPBw+3bIePy+JM/sL+P5fMvVMjfyWV7BndSZt/AeItR3Ly9BncaH5K8EOnrm4Z3T
         1iPg==
X-Gm-Message-State: APjAAAVjbqdbBh9F+ifdfJdh4rexAf5rmvuIKgYYXxzpHeo2QL0rK8X6
        nwaUK6vzk4nOBer4gASMeHs=
X-Google-Smtp-Source: APXvYqz7RIJJG5RHtl0ZFgx2zF+LBx+kxUIGpVpeQWlLdJITpeK/r1dvCOJdHyGf33JH7n8D1/afhg==
X-Received: by 2002:a37:8183:: with SMTP id c125mr44772302qkd.306.1559129874621;
        Wed, 29 May 2019 04:37:54 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 100sm2941930qtb.53.2019.05.29.04.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 04:37:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3600421EBC;
        Wed, 29 May 2019 07:37:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 May 2019 07:37:52 -0400
X-ME-Sender: <xms:DW_uXH_za8CZea6fsDhgIhtYy5auGbqohTlVxj4DeHB8gQpPnwii3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddvjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrg
    hinheplhhinhhugihplhhumhgsvghrshgtohhnfhdrohhrghenucfkphepgeehrdefvddr
    uddvkedruddtleenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmth
    hprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddq
    sghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvnecuve
    hluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:DW_uXEpFB8I8zj3WwIg4HqfhKA7TJolnB1Mqq57Hlpv8oLVyxa_t_Q>
    <xmx:DW_uXFUCPhARswvx3akHMqIUAa0MJzXXxllnikC99ikC_h2wNoezow>
    <xmx:DW_uXB4mXSquRC4TeqotxGPy9iGrPFgxv47XkFuFUDFBb3DLyUUUmg>
    <xmx:EG_uXDWzXN0HGFUTVJAA25HrXYPPShtc-h-PsYEzVQljyg9WQvGyYzcu_jw>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id ACE97380088;
        Wed, 29 May 2019 07:37:48 -0400 (EDT)
Date:   Wed, 29 May 2019 19:37:45 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/17] locking/lockdep: Add read-write type for
 dependency
Message-ID: <20190529112321.GB5929@tardis>
References: <20190516080015.16033-1-duyuyang@gmail.com>
 <20190516080015.16033-3-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20190516080015.16033-3-duyuyang@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 04:00:00PM +0800, Yuyang Du wrote:
> Direct dependency needs to keep track of its locks' read-write types. A
> union field is added to lock_list struct so the type is stored there as
> this:
>=20
> 	lock_type[1] (u16), lock_type[0] (u16)
>=20
> 			or:
>=20
> 	dep_type (int)
>=20
> where value:
>=20
>  0: exclusive / write
>  1: read
>  2: recursive read
>=20
> Note that (int) dep_type value may vary with different architectural
> endianness, so use helper functions to operate on these types.
>=20
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> ---
>  include/linux/lockdep.h            | 12 ++++++++++++
>  kernel/locking/lockdep.c           | 34 +++++++++++++++++++++++++++++++-=
--
>  kernel/locking/lockdep_internals.h |  3 +++
>  3 files changed, 46 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 1009c47..bc09c85 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -195,6 +195,18 @@ struct lock_list {
>  	struct lock_class		*links_to;
>  	struct lock_trace		trace;
>  	int				distance;
> +	/*
> +	 * This field keeps track of the read-write type of this dependency.
> +	 *
> +	 * With L1 -> L2:
> +	 *
> +	 * lock_type[0] stores the type of L1, while lock_type[1] stores the
> +	 * type of L2.
> +	 */
> +	union {
> +		int	dep_type;
> +		u16	lock_type[2];

This takes extra space for storing the type of dependencies. In my
previous patchset, only 2bits are used, because you only need to care
about four types of dependencies:

1.	Exclusive -> Recursive
2.	Shared (read or recursive read) -> Recursive
3.	Exclusize -> Non-Recursive (write or non-recursive readers)
4.	Shared (read or recursive read) -> Non-Recursive

To understand why, here are my slides for Linux Plumber Conference last
year:

	https://www.linuxplumbersconf.org/event/2/contributions/74/attachments/67/=
78/Recursive_read_deadlocks_and_Where_to_find_them.pdf

And we can steal two bits from "distance", since 2^30 would be enough.
I think it's important to save the size of lock_list since we will have
a lot of them.

Regards,
Boqun

> +	};
> =20
>  	/*
>  	 * The parent field is used to implement breadth-first search, and the
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index fb6be63..e7eedbf 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1225,7 +1225,7 @@ static struct lock_list *alloc_list_entry(void)
>  static int add_lock_to_list(struct lock_class *this,
>  			    struct lock_class *links_to, struct list_head *head,
>  			    unsigned long ip, int distance,
> -			    struct lock_trace *trace)
> +			    struct lock_trace *trace, int dep_type)
>  {
>  	struct lock_list *entry;
>  	/*
> @@ -1240,6 +1240,8 @@ static int add_lock_to_list(struct lock_class *this,
>  	entry->links_to =3D links_to;
>  	entry->distance =3D distance;
>  	entry->trace =3D *trace;
> +	entry->dep_type =3D dep_type;
> +
>  	/*
>  	 * Both allocation and removal are done under the graph lock; but
>  	 * iteration is under RCU-sched; see look_up_lock_class() and
> @@ -1677,6 +1679,30 @@ unsigned long lockdep_count_backward_deps(struct l=
ock_class *class)
>  	return ret;
>  }
> =20
> +static inline int get_dep_type(struct held_lock *lock1, struct held_lock=
 *lock2)
> +{
> +	/*
> +	 * With dependency lock1 -> lock2:
> +	 *
> +	 * lock_type[0] is lock1, while lock_type[1] is lock2.
> +	 *
> +	 * Avoid architectural endianness difference composing dep_type.
> +	 */
> +	u16 type[2] =3D { lock1->read, lock2->read };
> +
> +	return *(int *)type;
> +}
> +
> +static inline int get_lock_type1(struct lock_list *lock)
> +{
> +	return lock->lock_type[0];
> +}
> +
> +static inline int get_lock_type2(struct lock_list *lock)
> +{
> +	return lock->lock_type[1];
> +}
> +
>  /*
>   * Check that the dependency graph starting at <src> can lead to
>   * <target> or not. Print an error and return 0 if it does.
> @@ -2446,14 +2472,16 @@ static inline void inc_chains(void)
>  	 */
>  	ret =3D add_lock_to_list(hlock_class(next), hlock_class(prev),
>  			       &hlock_class(prev)->locks_after,
> -			       next->acquire_ip, distance, trace);
> +			       next->acquire_ip, distance, trace,
> +			       get_dep_type(prev, next));
> =20
>  	if (!ret)
>  		return 0;
> =20
>  	ret =3D add_lock_to_list(hlock_class(prev), hlock_class(next),
>  			       &hlock_class(next)->locks_before,
> -			       next->acquire_ip, distance, trace);
> +			       next->acquire_ip, distance, trace,
> +			       get_dep_type(next, prev));
>  	if (!ret)
>  		return 0;
> =20
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_=
internals.h
> index 150ec3f..c287bcb 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -26,6 +26,9 @@ enum lock_usage_bit {
>  #define LOCK_USAGE_DIR_MASK  2
>  #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_M=
ASK))
> =20
> +#define LOCK_TYPE_BITS	16
> +#define LOCK_TYPE_MASK	0xFFFF
> +
>  /*
>   * Usage-state bitmasks:
>   */
> --=20
> 1.8.3.1
>=20

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlzubwYACgkQSXnow7UH
+ritbgf+OQB5N20GU6RdiK2o3E111WP+1m/gp1sugFuQl9Hc8HjQiEZ2Zj7lJxcK
aUNes+or+m7Mj3jrJMUoj2TRmSrJ75OZA8NyETj9rBqBTchT7M8nPXnp6UoKus6b
/lWXAUL0Y4qWmGaT2XgIPKZeRQsePnKvtbGBGJiezWy4WsA1QIw3cKDiMwSJYGUZ
AOr6iwuMd1+HExTJ8Je/+32dBHz/nLt86HmGVsSl1iSMseXarEB0NdwZOzg3abXU
gqZyofmKugGW/m5I5HQ+SoWxg0Yhv5DNo233BxPkQNv5PCOWfppREWVOIPqfbOzk
ZLxU3pH/Gapr05/NX6F1N1QjrUo8/Q==
=n8wi
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
