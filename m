Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BE3C73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3664220838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2g5VotB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfGJFSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:18:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37842 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfGJFSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:18:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so1139498qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 22:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HNQkK0ST9s71G0a9f85FFAYCOVdBLHg3XcIO+dqr2X4=;
        b=O2g5VotBP10fMKZPgJwrl14W54e5CLPfJWdax/0pI8Vmh2FJE9Vu8f6efgnf+IJn9q
         Y/SwUyQOoSYEorIz0bZpp2MxqM+iNK+rP9oS5WgSbiIICvkjI7qClW/C1ymaPGLa/mJW
         9i1FfnEwsb+J+CD9Ck1gr3rAjEfy6fSQDXHT58SfpAb/rr9Dj3ZLZJHX/seemH2ED2mo
         GMxd1X75cBWFzN2jvRUTmpaLsFcpTCrtDNDIegFqzNKVyjWB5dWSWhEfaGDNhuh57hvD
         IOCDafvX7auwCq4dM8lMII18OKc4/76+SQjIaViY4h7Cd8hlszssIiPkDishzo/Vb9L4
         WgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HNQkK0ST9s71G0a9f85FFAYCOVdBLHg3XcIO+dqr2X4=;
        b=kLKEQiXJ4PGA3ki1AkIgsEAosUOeXvQNSPUZwfgrAIXx4OmAC8Fv6jd7EsS+9w30Kf
         dBZwT1swA9oc/tDwd8/HypqBntOeeluxnvlLPqMRdlHF2tipvtsYvVH/lYd22s0t2kAk
         Mza6LG4z0yTVNKoV9AzP9lCTviFkFRKozImleFYP1I1GPowVdUxHXMhhcNdEDb9Z7bh4
         LLAr2btgLkmyXeTnxIZxmY30pI0d9HyRl8Xy2wjwQmT/pr5gLKO+K9XdPL3XZ6fyJ/ef
         bkd0zfKNZMGcplRg+Wbmwao93DCtj2XKR4hxKh63diL0hF69pNmi+OD9/r0PDfGLNrNL
         2eZA==
X-Gm-Message-State: APjAAAXxV56cS6RPhILZq4W3zvCZLFRnF1nu01B8qpv1F4PBxbVCpv0m
        I7336ktUj2fSGiMSZuPyolI=
X-Google-Smtp-Source: APXvYqxnd2FsHhnH7JNDcKRdjHc2z8EN/xM/DXouN3lXFnYf/FJlB1CoeOAhuyaSAUYNB+3du6O9tw==
X-Received: by 2002:ac8:376e:: with SMTP id p43mr22240807qtb.354.1562735920167;
        Tue, 09 Jul 2019 22:18:40 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h26sm697866qta.58.2019.07.09.22.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 22:18:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id D4D8320C86;
        Wed, 10 Jul 2019 01:18:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Jul 2019 01:18:37 -0400
X-ME-Sender: <xms:LHUlXYlDYRXOGfBmeZECfx4rcNmuGD2sM0YUPzACzuUWba2DZX0zzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeehgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeeghe
    drfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:LHUlXdHgYZzoE70qj9uh3HtxXVFS4jeOevBE7jptHkmvNLEDC3GUPw>
    <xmx:LHUlXYUe6NzT7gX66iDa5yqBjys1M2rGYbzU9BpD7qGWwz6XrwUHVg>
    <xmx:LHUlXcxyJUcSMUn4kAIFxcHUEQySanic1HiUSgo6LvNVR_WNKHqcUw>
    <xmx:LXUlXTbqZmnV5ArfYTeSjWG-sXB0ImvGOBqAHNKkBymD49bQLT8ndSPl3Uw>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A4D0380075;
        Wed, 10 Jul 2019 01:18:35 -0400 (EDT)
Date:   Wed, 10 Jul 2019 13:18:30 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v3 17/30] locking/lockdep: Add read-write type for a lock
 dependency
Message-ID: <20190710051830.GB14490@tardis>
References: <20190628091528.17059-1-duyuyang@gmail.com>
 <20190628091528.17059-18-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20190628091528.17059-18-duyuyang@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 05:15:15PM +0800, Yuyang Du wrote:
> Direct dependencies need to keep track of their read-write lock types.
> Two bit fields, which share the distance field, are added to lock_list
> struct so the types are stored there.
>=20
> With a dependecy lock1 -> lock2, lock_type1 has the type for lock1 and
> lock_type2 has the type for lock2, where the values are one of the
> lock_type enums.
>=20
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> ---
>  include/linux/lockdep.h  | 15 ++++++++++++++-
>  kernel/locking/lockdep.c | 25 +++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index eb26e93..fd619ac 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -185,6 +185,8 @@ static inline void lockdep_copy_map(struct lockdep_ma=
p *to,
>  		to->class_cache[i] =3D NULL;
>  }
> =20
> +#define LOCK_TYPE_BITS	2
> +
>  /*
>   * Every lock has a list of other locks that were taken after or before
>   * it as lock dependencies. These dependencies constitute a graph, which
> @@ -207,7 +209,17 @@ struct lock_list {
>  	struct list_head		chains;
>  	struct lock_class		*class[2];
>  	struct lock_trace		trace;
> -	int				distance;
> +
> +	/*
> +	 * The lock_type fields keep track of the lock type of this
> +	 * dependency.
> +	 *
> +	 * With L1 -> L2, lock_type1 stores the lock type of L1, and
> +	 * lock_type2 stores that of L2.
> +	 */
> +	unsigned int			lock_type1 : LOCK_TYPE_BITS,
> +					lock_type2 : LOCK_TYPE_BITS,

Bad names ;-) Maybe fw_dep_type and bw_dep_type? Which seems to be
aligned with the naming schema other functions.

Regards,
Boqun

> +					distance   : 32 - 2*LOCK_TYPE_BITS;
> =20
>  	/*
>  	 * The parent field is used to implement breadth-first search.
> @@ -362,6 +374,7 @@ enum lock_type {
>  	LOCK_TYPE_WRITE		=3D 0,
>  	LOCK_TYPE_READ,
>  	LOCK_TYPE_RECURSIVE,
> +	NR_LOCK_TYPE,
>  };
> =20
>  /*
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 3c97d71..1805017 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1307,9 +1307,17 @@ static struct lock_list *alloc_list_entry(void)
>   */
>  static int add_lock_to_list(struct lock_class *lock1, struct lock_class =
*lock2,
>  			    unsigned long ip, int distance,
> -			    struct lock_trace *trace, struct lock_chain *chain)
> +			    struct lock_trace *trace, struct lock_chain *chain,
> +			    int lock_type1, int lock_type2)
>  {
>  	struct lock_list *entry;
> +
> +	/*
> +	 * The distance bit field in struct lock_list must be large
> +	 * enough to hold the maximum lock depth.
> +	 */
> +	BUILD_BUG_ON((1 << (32 - 2*LOCK_TYPE_BITS)) < MAX_LOCK_DEPTH);
> +
>  	/*
>  	 * Lock not present yet - get a new dependency struct and
>  	 * add it to the list:
> @@ -1322,6 +1330,8 @@ static int add_lock_to_list(struct lock_class *lock=
1, struct lock_class *lock2,
>  	entry->class[1] =3D lock2;
>  	entry->distance =3D distance;
>  	entry->trace =3D *trace;
> +	entry->lock_type1 =3D lock_type1;
> +	entry->lock_type2 =3D lock_type2;
> =20
>  	/*
>  	 * Both allocation and removal are done under the graph lock; but
> @@ -1465,6 +1475,16 @@ static inline struct list_head *get_dep_list(struc=
t lock_list *lock, int forward
>  	return &class->dep_list[forward];
>  }
> =20
> +static inline int get_lock_type1(struct lock_list *lock)
> +{
> +	return lock->lock_type1;
> +}
> +
> +static inline int get_lock_type2(struct lock_list *lock)
> +{
> +	return lock->lock_type2;
> +}
> +
>  /*
>   * Forward- or backward-dependency search, used for both circular depend=
ency
>   * checking and hardirq-unsafe/softirq-unsafe checking.
> @@ -2503,7 +2523,8 @@ static inline void inc_chains(void)
>  	 * dependency list of the previous lock <prev>:
>  	 */
>  	ret =3D add_lock_to_list(hlock_class(prev), hlock_class(next),
> -			       next->acquire_ip, distance, trace, chain);
> +			       next->acquire_ip, distance, trace, chain,
> +			       prev->read, next->read);
>  	if (!ret)
>  		return 0;
> =20
> --=20
> 1.8.3.1
>=20

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl0ldSIACgkQSXnow7UH
+rjUfggAs1tL8SMEN1es3pqMdMCh4YkM/Q+DN5cPWAvNlxYbK0LyCsB988gqbRat
kI7VxYNptg622sloQjAToQkRsgU8CtjnpZHAvZRa16KmCz6xgXK0GkoM8IE5eQwH
ICZDAEEuUyXknzRKlMNlhZmkmXwfEidPni+wVUb2Lhaa4N2rGQIFNjphlKYVVzEp
EMw9gvEgyZ64Bu8517WvRKWCOS8AmaoMGWSODKjUEpHcp7PWIqILoSiyE9tvE5kh
nVvcIcgzf+fUu8qM4qEFgwVInfLiFa/YMx7HWv5nJ3RWbDS5OVulg3zJn9DYGeF/
8QSvp2ieavFbUfCjoSeqydd+je6rYw==
=akAy
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
