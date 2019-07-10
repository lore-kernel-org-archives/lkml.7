Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE14C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA84A2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 00:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LafklzLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGJABo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 20:01:44 -0400
Received: from ozlabs.org ([203.11.71.1]:43261 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfGJABn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 20:01:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jzr24tKxz9sN4;
        Wed, 10 Jul 2019 10:01:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562716900;
        bh=ZWT4dSLXGeBs9XVigkI+30TBQ9J8kSZ60+J4UqtPvYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LafklzLdksK/zVUdYrI/ey0rB/HWstyncJSsMtWq0eDwGu/awoMl+ujmWHD7c4DaB
         YJ0E6aD4Ze7MsDDVdb8YGIKMnKFs9s6D+fJJxoRMVAVNmNLBnsC+vDk3hkPrJcsYtH
         2jYoYNrr+0/xY8N8ORenC23+mytneUu6m5ru81PAxTO0g/4wKOxzFhEqnDHz9Y36Gg
         s8T1W63kTEUAQQXDAKWnFc3op6KPsi4weshNR7W6WtHYMwVYxFnZK/5bmEgBRcnoy1
         lTKUmHzIhqB5LpjynDDRCwxu3llfOiNbP7biNmOyCwIiC398/Mr372LjiojWqCseaP
         DHlxys483Ll+A==
Date:   Wed, 10 Jul 2019 10:01:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sage Weil <sage@newdream.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20190710100138.0aa36d47@canb.auug.org.au>
In-Reply-To: <20190709165459.11b353d8@canb.auug.org.au>
References: <20190709165459.11b353d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K8zLqV=lrMVaNpLiLljZFRd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K8zLqV=lrMVaNpLiLljZFRd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Jul 2019 16:54:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> drivers/block/rbd.c: In function 'wake_lock_waiters':
> drivers/block/rbd.c:3933:2: error: implicit declaration of function 'lock=
dep_assert_held_exclusive'; did you mean 'lockdep_assert_held_write'? [-Wer=
ror=3Dimplicit-function-declaration]
>   lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   lockdep_assert_held_write
>=20
> Caused by commit
>=20
>   9ffbe8ac05db ("locking/lockdep: Rename lockdep_assert_held_exclusive() =
-> lockdep_assert_held_write()")
>=20
> interacting with commits
>=20
>   637cd060537d ("rbd: new exclusive lock wait/wake code")
>   a2b1da09793d ("rbd: lock should be quiesced on reacquire")
>=20
> from the ceph tree.
>=20
> I have added the following merge fix patch for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 9 Jul 2019 16:46:12 +1000
> Subject: [PATCH] rbd: fix up for lockdep_assert_held_exclusive rename
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/block/rbd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 723c3ef4bd59..02216fbdb854 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3930,7 +3930,7 @@ static void wake_lock_waiters(struct rbd_device *rb=
d_dev, int result)
>  	struct rbd_img_request *img_req;
> =20
>  	dout("%s rbd_dev %p result %d\n", __func__, rbd_dev, result);
> -	lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
> +	lockdep_assert_held_write(&rbd_dev->lock_rwsem);
> =20
>  	cancel_delayed_work(&rbd_dev->lock_dwork);
>  	if (!completion_done(&rbd_dev->acquire_wait)) {
> @@ -4209,7 +4209,7 @@ static bool rbd_quiesce_lock(struct rbd_device *rbd=
_dev)
>  	bool need_wait;
> =20
>  	dout("%s rbd_dev %p\n", __func__, rbd_dev);
> -	lockdep_assert_held_exclusive(&rbd_dev->lock_rwsem);
> +	lockdep_assert_held_write(&rbd_dev->lock_rwsem);
> =20
>  	if (rbd_dev->lock_state !=3D RBD_LOCK_STATE_LOCKED)
>  		return false;

This fix now needs to be applied to the merge of the ceph tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/K8zLqV=lrMVaNpLiLljZFRd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0lKuIACgkQAVBC80lX
0Gzkhwf9HBh6ZtEpp4PTwOrsoynTc3CYF5zxyUoT7jOwCjrWBNvxSwhzrM/fdbKs
0YSAtiOQEWC7BJo1DpYgs0XQIig/LkJAoVFuOETE7AB14qTLaxjlvLnJ1dkhaM2l
9sZmbsbuJgGlJV/MbxVgVlbh0hb4S/lg+DQqXndjgxgt5C0rA+K4FjCBx0mwMv99
lmJIn+o1car8FcF+BXQKs2X+dzFByjhQCnrWzso+HvJnL09vLga6DYsrcsZUTeEm
wQ2L6JzM0GvPjnuZHaf/nlLOE1FVv4tPnsvf5CmDBlDiZT10XiUEXUP85rMKvn6E
B3VSAWgTYDkkkarDl7NhNf/NtDWy4A==
=o5q5
-----END PGP SIGNATURE-----

--Sig_/K8zLqV=lrMVaNpLiLljZFRd--
