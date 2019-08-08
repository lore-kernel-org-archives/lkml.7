Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A09C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B5621872
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aOuzZgSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbfHHBwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 21:52:50 -0400
Received: from ozlabs.org ([203.11.71.1]:40221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbfHHBwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:52:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463rwt5rjlz9s3Z;
        Thu,  8 Aug 2019 11:52:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565229166;
        bh=2Yy/cS6AEuURYiuCIqDYhqO1IpoktaM9SX64Ys7iwJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aOuzZgSPYdx3pdpMPRaweLOi2GCuqOw4FXoedOlSnPUEpfov48c9TH7nTzgRFCPFi
         TS/kJqDte9HbABn9cdZNO8l5nP+fJ1gGyBgT76fb4eu5Rkd5PVMz7XRVry5n6RW1Pj
         UkxcnQ7EDBd29zkL5moA1fcfVQOT+oHJlRj++OB/TReu7YicGRpVLz2TnXsPovBIiD
         SGXH7Hq1ZbLds4WIwWnYUiC0BlgEQRM0xPkmi/YkRSUKt3RsADZi4DXDlUQz/HieZ/
         CLaITeOZAvjvjTntzLDLQ9gy41HOheMG0xKXGeYVJiGj0MK0PJDgwBnBEUUPgTLfFp
         ISnwmWJ/25Xlw==
Date:   Thu, 8 Aug 2019 11:52:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20190808115245.0c88c300@canb.auug.org.au>
In-Reply-To: <20190805145736.2d39f95b@canb.auug.org.au>
References: <20190805145736.2d39f95b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Cdn2bCWDZ7kVZqfm9YvqfR+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Cdn2bCWDZ7kVZqfm9YvqfR+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 5 Aug 2019 14:57:36 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> After merging the crypto tree, today's linux-next build (sparc64
> defconfig) failed like this:
>=20
> drivers/char/hw_random/n2-drv.c: In function 'n2rng_probe':
> drivers/char/hw_random/n2-drv.c:771:29: error: 'pdev' undeclared (first u=
se in this function); did you mean 'cdev'?
>   err =3D devm_hwrng_register(&pdev->dev, &np->hwrng);
>                              ^~~~
>                              cdev
> drivers/char/hw_random/n2-drv.c:771:29: note: each undeclared identifier =
is reported only once for each function it appears in
>=20
> Caused by commit
>=20
>   3e75241be808 ("hwrng: drivers - Use device-managed registration API")
>=20
> I applied the following patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 5 Aug 2019 14:49:59 +1000
> Subject: [PATCH] hwrng: fix typo in n2-drv.c
>=20
> Fixes: 3e75241be808 ("hwrng: drivers - Use device-managed registration AP=
I")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/char/hw_random/n2-drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-=
drv.c
> index 2d256b3470db..73e408146420 100644
> --- a/drivers/char/hw_random/n2-drv.c
> +++ b/drivers/char/hw_random/n2-drv.c
> @@ -768,7 +768,7 @@ static int n2rng_probe(struct platform_device *op)
>  	np->hwrng.data_read =3D n2rng_data_read;
>  	np->hwrng.priv =3D (unsigned long) np;
> =20
> -	err =3D devm_hwrng_register(&pdev->dev, &np->hwrng);
> +	err =3D devm_hwrng_register(&op->dev, &np->hwrng);
>  	if (err)
>  		goto out_hvapi_unregister;
> =20
> --=20
> 2.20.1

I am still applying that patch ...

--=20
Cheers,
Stephen Rothwell

--Sig_/Cdn2bCWDZ7kVZqfm9YvqfR+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1LgG0ACgkQAVBC80lX
0Gy5Vwf9FbyB0CanhhAKbljUp3638ElADCsp3vzNhhA19zlow8SLSEUDu6DCZhxx
SSKovam2VtyMS+xe0fYCZDdHJySUySmwtJHQYahnOJ4qC0W/kP2R3/FTPyRJQLvV
ux586Y8HfIXT5LMkjYwKIDc4/zz00f0pWTJqvf0bibvNEcqFmX8uuhFfFsQfyVSF
kQ1d62oMq1K1IOco7h3VdbXtbFMxJ14Isx4/6J7QZuADwBfJ99M8LW9f93cVRqmN
TXtTbZxAAFXq6txuOhHrWQyiupVdw4J58mvXMsXMaE21aPW4s6ybdldRoevBERP5
NUrAcHBw9U6TgMsF7Mlw9z8fYSXZkQ==
=seSx
-----END PGP SIGNATURE-----

--Sig_/Cdn2bCWDZ7kVZqfm9YvqfR+--
