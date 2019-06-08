Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FDEC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC1A214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OaOZ2r2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFHKWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:22:21 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52246 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559989339; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pURQs9CY2mpuFiZSCMQU4qI61477m0CbkzHnmzitjaE=;
        b=OaOZ2r2mFo+aasqU+cQsqrt2pBttc3uAgYgAz8aCjebx1PDMOnTsmA38uYlj/A3yutjhzs
        U3x8aemgE01DwEVkXf5sc91C5iNKDH6xfROwKEFpwLBl/jlVK+juICQ/F6BODU7uJslKDs
        czE0pGedx9PZmKlg3PbJt+SqTzmHHmw=
Date:   Sat, 08 Jun 2019 12:22:14 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] mtd/rawnand: ingenic-ecc: Make probe function
 __init_or_module
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     od@zcrc.me, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <1559989334.1815.5@crapouillou.net>
In-Reply-To: <20190607160200.16052-1-paul@crapouillou.net>
References: <20190607160200.16052-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I misunderstood what __init_or_module was for. Please ignore this=20
patchset. Sorry for the noise.


Le ven. 7 juin 2019 =E0 18:01, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> This allows the probe function to be dropped after the kernel finished
> its initialization, in the case where the driver was not compiled as a
> module.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 2 +-
>  drivers/mtd/nand/raw/ingenic/ingenic_ecc.h | 3 ++-
>  drivers/mtd/nand/raw/ingenic/jz4780_bch.c  | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c=20
> b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> index d3e085c5685a..74eff8fb5d32 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> @@ -124,7 +124,7 @@ void ingenic_ecc_release(struct ingenic_ecc *ecc)
>  }
>  EXPORT_SYMBOL(ingenic_ecc_release);
>=20
> -int ingenic_ecc_probe(struct platform_device *pdev)
> +int __init_or_module ingenic_ecc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct ingenic_ecc *ecc;
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h=20
> b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> index 2cda439b5e11..535eb8f29df6 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
> @@ -4,6 +4,7 @@
>=20
>  #include <linux/compiler_types.h>
>  #include <linux/err.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/types.h>
>  #include <uapi/asm-generic/errno-base.h>
> @@ -78,6 +79,6 @@ struct ingenic_ecc {
>  	struct mutex lock;
>  };
>=20
> -int ingenic_ecc_probe(struct platform_device *pdev);
> +int __init_or_module ingenic_ecc_probe(struct platform_device *pdev);
>=20
>  #endif /* __DRIVERS_MTD_NAND_INGENIC_ECC_INTERNAL_H__ */
> diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c=20
> b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
> index 079266a0d6cf..cc0656ac505d 100644
> --- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
> +++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
> @@ -229,7 +229,7 @@ static int jz4780_correct(struct ingenic_ecc *bch,
>  	return ret;
>  }
>=20
> -static int jz4780_bch_probe(struct platform_device *pdev)
> +static int __init_or_module jz4780_bch_probe(struct platform_device=20
> *pdev)
>  {
>  	struct ingenic_ecc *bch;
>  	int ret;
> --
> 2.21.0.593.g511ec345e18
>=20

=

