Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFAFC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790A8213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DsNaOifu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDHXMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:12:41 -0400
Received: from ozlabs.org ([203.11.71.1]:51887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfDHXMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:12:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dR5w6yp4z9sQp;
        Tue,  9 Apr 2019 09:12:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554765157;
        bh=Mj1exSdNGMt94EuDnSSJiDOMCo2WHX7jPSaghrWyzrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DsNaOifu6sQwfxTBYPtlkrKPTN8yNc2YifpclYt/3J5VxKSASpV01lZJrRabglEPG
         guV+I4tuMzKXRpLsQM3/t81ip0ewxP+blV+q/m0MNJQ3KH4FWCYCNOJdfixPY4dTRb
         Y7/zOGYIdNhP0UcegXMhbqCdTbjeV7WMdLMTFqw0sNa7ljWymcqCmOgDJmll/Kd8AL
         aXrmsZnuDSsTQPnq08R6FwG39z1drmV0fytOVB1MOQ4CSiENU2yhbYdtH2FdX30gxl
         YAq8LV8AdjRwegK7ThebhAIGnxkzGnoer3XX/SwlvNsyZ0dPM65djKJiTIJocUoYkr
         8G9N2kDiGiqJQ==
Date:   Tue, 9 Apr 2019 09:12:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20190409091231.57cf760a@canb.auug.org.au>
In-Reply-To: <20190326100145.3ee50933@canb.auug.org.au>
References: <20190326100145.3ee50933@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UWcL=wt71r.47lzmU.udJqq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UWcL=wt71r.47lzmU.udJqq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 26 Mar 2019 10:01:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the sound-asoc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>=20
> sound/soc/codecs/tlv320aic32x4-clk.c: In function 'clk_aic32x4_pll_recalc=
_rate':
> sound/soc/codecs/tlv320aic32x4-clk.c:149:38: warning: 'settings.d' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
>      ((settings->j * 10000) + settings->d);
>                               ~~~~~~~~^~~
> sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.d' was decla=
red here
>   struct clk_aic32x4_pll_muldiv settings;
>                                 ^~~~~~~~
> sound/soc/codecs/tlv320aic32x4-clk.c:149:15: warning: 'settings.j' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
>      ((settings->j * 10000) + settings->d);
>        ~~~~~~~~^~~
> sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.j' was decla=
red here
>   struct clk_aic32x4_pll_muldiv settings;
>                                 ^~~~~~~~
> sound/soc/codecs/tlv320aic32x4-clk.c:148:37: warning: 'settings.r' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
>   rate =3D (u64) parent_rate * settings->r *
>                              ~~~~~~~~^~~
> sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.r' was decla=
red here
>   struct clk_aic32x4_pll_muldiv settings;
>                                 ^~~~~~~~
> sound/soc/codecs/tlv320aic32x4-clk.c:151:56: warning: 'settings.p' may be=
 used uninitialized in this function [-Wmaybe-uninitialized]
>   return (unsigned long) DIV_ROUND_UP_ULL(rate, settings->p * 10000);
>                                                         ^~
> sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.p' was decla=
red here
>   struct clk_aic32x4_pll_muldiv settings;
>                                 ^~~~~~~~
>=20
> Introduced by commit
>=20
>   514b044cba66 ("ASoC: tlv320aic32x4: Model PLL in CCF")

I am still getting these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/UWcL=wt71r.47lzmU.udJqq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyr1V8ACgkQAVBC80lX
0GyUrAf/e8cfMwKWceRi9VmwDT+25ltW3Alzfq2rXyrnKMxgCRETRfUUf65nRZRC
IZzgCosIfkhBrt6uhmLfZh+Opu7B98r+uNSPTpZ07w+Or7rqQDZKS9ZrzrnsjrAJ
F+r5uo9F8aV8AlknM6Pp1lTWdImRAqQU43cI37IYjE4lnVQgDJOHUookUqvZjxOl
ZUiJW5BkEvNqUIGMmKkfEa4UdZf8xy1Q0p5c81thsYDOQTVxVTMGOBGV0VBoHXaw
ONVxkXjVKZmlw5KNoSgf754GaqhQdbaEQGmgwOraH5E2IW2YvVJOoj1e4NSofa6N
FElZGj2HY9fgeem2JauvwNb5og/PUw==
=EIkw
-----END PGP SIGNATURE-----

--Sig_/UWcL=wt71r.47lzmU.udJqq--
