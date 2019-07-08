Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F38C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C198A21707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dUvryMtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGHXMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:12:48 -0400
Received: from ozlabs.org ([203.11.71.1]:44579 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfGHXMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:12:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jLp518FDz9s3Z;
        Tue,  9 Jul 2019 09:12:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562627565;
        bh=nd0L5KvIlUBThUk3llUF/iTHenWnlgmOQfj8lXdA6Tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dUvryMtEwm3xpq0uikBGgNNa6koRF2gFM8NUjoojFkqiz5+a03fHNDvve0YGXuCBk
         dOzPd4v5O7KgVvJsVCeURe5UuMSc8BV3Qh8EZ0zgpH6HFAfU0vKWFzsRD6K4HDBNQK
         hp6JeUJrrXFbvdmZsawhQGdWK6BKJMszBaclWWlPEm+uUc4wFl5hROcIsl3ZP1TPa7
         s5zkB3uZwMcP+fIKLOz2Arz+ni4EzIQY6gvpY/VJRD01SzfjzHAp3cgxgdd91t+BjO
         pdneCPSC6ioVXLrDtfehvxKvmPSk+Qr4MBtbrGvrzrPCSiovUcqTh5qW3+gy2ZZsjo
         bQde4CtMvjm8w==
Date:   Tue, 9 Jul 2019 09:12:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 pidfd tree
Message-ID: <20190709091236.3b658262@canb.auug.org.au>
In-Reply-To: <20190522114314.515b410d@canb.auug.org.au>
References: <20190522114314.515b410d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IRDCyuFiV/FuGuV+Q6a9QFe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IRDCyuFiV/FuGuV+Q6a9QFe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 22 May 2019 11:43:14 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   kernel/pid.c
>=20
> between commit:
>=20
>   99e9da7f2796 ("pid: add pidfd_open()")
>=20
> from the pidfd tree and commit:
>=20
>   51c59c914840 ("kernel/pid.c: convert struct pid:count to refcount_t")
>=20
> from the akpm-current tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc kernel/pid.c
> index 39181ccca846,b59681973dd6..000000000000
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@@ -37,8 -36,7 +37,8 @@@
>   #include <linux/init_task.h>
>   #include <linux/syscalls.h>
>   #include <linux/proc_ns.h>
> - #include <linux/proc_fs.h>
> + #include <linux/refcount.h>
>  +#include <linux/sched/signal.h>
>   #include <linux/sched/task.h>
>   #include <linux/idr.h>
>  =20

I am still getting this conflict.  Just a reminder in case you think
Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/IRDCyuFiV/FuGuV+Q6a9QFe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jzeQACgkQAVBC80lX
0Gwb1wf+IPW9D2u1iKzZgxiBMWjepDrUjwjHC9DHUXJclpawkF4A0nR4sW3vZnP+
RyDNy1UrE377NY5XNWviBBIrWUhynPslxMTbDNYcLZT5phMCsmqUWNx0ZtAYUEQT
jmupMjSjwVd4mbr2ar33LQgP3FVZcaefmGXBl5v1LCdYmPlKiDCjm00jtObLJae+
/wsyT9INHXVPHrMFcjlOhToeDrRuy8Wmvw8RHtALVLV1uhv2Q3+0l6TB9ryEHMlW
/sQBicaMnY/jrV3MzvY3NV5nEPDyN0s9Ls1PwjYGyamQQKqWNB40ZtdQTDDjzzV0
9d4bsLeZg1OAA3Xx/1Z/3Jg0+slE7Q==
=5GWn
-----END PGP SIGNATURE-----

--Sig_/IRDCyuFiV/FuGuV+Q6a9QFe--
