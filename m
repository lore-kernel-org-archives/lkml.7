Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA5C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A492053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="deQ5q3xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfGHCBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 22:01:17 -0400
Received: from ozlabs.org ([203.11.71.1]:41491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfGHCBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 22:01:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hpZy6VXkz9s3l;
        Mon,  8 Jul 2019 12:01:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562551275;
        bh=nOptHnZp+UG6V+othTF51osuTKzKT0Lbrwh1VPjnH1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=deQ5q3xSbP/9t98c5Uvqsit5junh5iv5g/k9aZBB0H0mGUvlgGDbkzlITgj1oDfM4
         XBjEL9ZnZ1GB1ZL6kSmQDS/ITb2ArCsitd1ZXyfXsJIMJe5hsgFZzsZbCbgzVpnhqo
         70CNtbKdkYxvcYgG+X3XSif4cU44xhBOx7qnXRBnszL7HovJRa7ug0G3r/rfQMFYNx
         1I5vn84G3KI1nhNmlnQ3kFB4rL6lF/MtrULaEYUzthcToC4eI7om85jyntVj/aOJqY
         NcZwkKwR8L64Uc5DVcGJ6H+95BnDLEl5Qn7OLvO3Gbsi4zifRgJNifKIroXJg37vIo
         SssNo/tk5Xhuw==
Date:   Mon, 8 Jul 2019 12:01:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 pidfd tree
Message-ID: <20190708120114.5ca1613d@canb.auug.org.au>
In-Reply-To: <20190515131629.405837b0@canb.auug.org.au>
References: <20190515131629.405837b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CAGrb0EMCBA2wpfIMB0fhwf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CAGrb0EMCBA2wpfIMB0fhwf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 15 May 2019 13:16:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   include/linux/pid.h
>=20
> between commit:
>=20
>   51f1b521a515 ("pidfd: add polling support")
>=20
> from the pidfd tree and commit:
>=20
>   c02e28a1bb18 ("kernel/pid.c: convert struct pid:count to refcount_t")
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
> diff --cc include/linux/pid.h
> index 1484db6ca8d1,0be5829ddd80..000000000000
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@@ -3,7 -3,7 +3,8 @@@
>   #define _LINUX_PID_H
>  =20
>   #include <linux/rculist.h>
>  +#include <linux/wait.h>
> + #include <linux/refcount.h>
>  =20
>   enum pid_type
>   {

I am still getting this conflict (the commits have changed).  Just a
reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/CAGrb0EMCBA2wpfIMB0fhwf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0io+oACgkQAVBC80lX
0Gy8Ywf/ey4AfeVKO3j8FEe0EYsTiG3K6zB0YFUzo7lywFtEOd/nn4f9cSCUH97c
RXMxzH8BIPlhL0550XIL1N7oxV8BCw9jHZWH1N8Heh3BW3DxAsvcSgb4I5exlR+T
5czHb2ixuiEGBtZwRW3V/f9S28Y+KFhSo1xDjQpoBZQ6gvr5+2+XDKjY8yPJqkcs
8b23HJRaJ7qTetQto8imY+RrHVDxZ5GGIxsZg/EpXqPBPSKYXXpO0X+oYX9OnvD+
wV3A55ssMeHXzT9x+tS3MmS1ao7I54q7glNOFufboX0SHFb4Av7oa5ZknJcdfNiY
4tfKk85vZbQWORwdvTIFPBXapzQ9nA==
=RIHh
-----END PGP SIGNATURE-----

--Sig_/CAGrb0EMCBA2wpfIMB0fhwf--
