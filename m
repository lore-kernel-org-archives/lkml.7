Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528EC5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE872086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hZ6aUdZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF0XQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:16:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfF0XQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:16:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZbPg2THBz9s4V;
        Fri, 28 Jun 2019 09:16:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561677401;
        bh=Q05Nw0HVE70a4aFv0eZt8fTUgrJWUZka4HLCio2Chwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hZ6aUdZswkJ1qrdAxLYiDmROiI57O1ISMTO7RITbgoPJy9YfaAsaAYz0gXdFiOTuJ
         sywRmB9gm/hNvf7WA5U3LZUCt6Ass/BVFEOf8r8kn41C5JwKXSj/jmjt+EYpWNndMF
         hR5J6+lwb9GHV6FaPO2i1aXrZ6k/68lRMCLag63VGL/J78dW6bCqRa3ejijip08vBL
         vyvGNRqtIDCwW73DKkKlXLi2E0Hk5UT6maES4QHVHgkCOP1S6/rylIjCK6fn3meDuy
         C0DH12wyw3+CsFTxh/D8QCnVbfQiDBgSeUCvqUCEZxdd/gzW2BiqEdoMks51BWouYb
         yrFs2/3+1cA/A==
Date:   Fri, 28 Jun 2019 09:16:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Russell King <rmk@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: manual merge of the samsung-krzk tree with the arm
 tree
Message-ID: <20190628091634.12fdc79c@canb.auug.org.au>
In-Reply-To: <20190621093347.36987c97@canb.auug.org.au>
References: <20190621093347.36987c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OJPZYXv17hFl./GZ7eVF/Ea"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OJPZYXv17hFl./GZ7eVF/Ea
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 21 Jun 2019 09:33:47 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the samsung-krzk tree got a conflict in:
>=20
>   arch/arm/configs/exynos_defconfig
>=20
> between commit:
>=20
>   5f41f9198f29 ("ARM: 8864/1: Add workaround for I-Cache line size mismat=
ch between CPU cores")
>=20
> from the arm tree and commit:
>=20
>   9f532d26c75c ("ARM: exynos_defconfig: Trim and reorganize with savedefc=
onfig")
>=20
> from the samsung-krzk tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc arch/arm/configs/exynos_defconfig
> index 9b959afaaa12,f140532ddca7..000000000000
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@@ -4,12 -5,7 +5,8 @@@ CONFIG_PREEMPT=3D
>   CONFIG_CGROUPS=3Dy
>   CONFIG_BLK_DEV_INITRD=3Dy
>   CONFIG_PERF_EVENTS=3Dy
> - CONFIG_MODULES=3Dy
> - CONFIG_MODULE_UNLOAD=3Dy
> - CONFIG_PARTITION_ADVANCED=3Dy
>   CONFIG_ARCH_EXYNOS=3Dy
> - CONFIG_ARCH_EXYNOS3=3Dy
>  +CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=3Dy
>   CONFIG_SMP=3Dy
>   CONFIG_BIG_LITTLE=3Dy
>   CONFIG_NR_CPUS=3D8

This is now a conflict between the arm-soc tree and the arm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/OJPZYXv17hFl./GZ7eVF/Ea
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0VTlIACgkQAVBC80lX
0Gzb8AgAkr/zl+SHq23CQEifsWT7dCMUdarzVZNqwDzNzAK7Ml+qgj7cpDMQTOg/
VPJmPuk6shOgrW+gUg13OxdYguPjebJy/zpbzcQFbLIClLgQtJL7jtXc3aNDWChP
UIzDsK8u1L5qAm+yyQpcI/WCU60Vwjf1DL34ZQF5mde+VgbhnTQMyT9l7MwFBlJ+
sLsd0mOUjawtucfB7YFRyJI24YDgjR2wPFP/GlBqVnV+4ykij674fuhMf+o2gxA+
Id+/LskwXenuHwAY0QWuv+6FJ3vVUFPlK9+60KSA1qYjV+799cHJwk1lc7em0rLI
SKcwXFYSP6sLaqxHJQHLDMIJcn72hA==
=WKW+
-----END PGP SIGNATURE-----

--Sig_/OJPZYXv17hFl./GZ7eVF/Ea--
