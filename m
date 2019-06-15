Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB21AC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 22:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E7921473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 22:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="PNJT8Rmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfFOWWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 18:22:43 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36432 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 18:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1560637359; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sVyIFnScoxPXqLI9tBcjmS2//cgjT4c+m2gvnY81jCs=;
        b=PNJT8Rmfq1mOruQzkh5Clw9tA/Z4vAL+pEWIUuYcjUpwrJc7pt/GEWrTpyR0ZenAm8XnEA
        ZLC1dNozXtdj12dyU0QI3aNZlLsAKfVDjhFmLQuQHp2eE7NtWdJzYM77fDagcdBXlaUKgp
        Tj3ubec6/ZEBD4ATunaPH7OZRsyopo0=
Date:   Sun, 16 Jun 2019 00:22:33 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mtd: rawnand: ingenic: Fix build error
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        vigneshr@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Message-Id: <1560637353.3745.0@crapouillou.net>
In-Reply-To: <20190615134430.30384-1-yuehaibing@huawei.com>
References: <20190615134430.30384-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't think the patch is correct. We want to be able to build
the ingenic_nand driver without the ingenic_ecc code.

The actual problem is that if the ingenic_nand driver is built-in,
then the ingenic_ecc driver must be built-in too (if enabled),
and we don't verify that constraint.

Something like that should work better:

config MTD_NAND_INGENIC_ECC
	def_tristate m if MTD_NAND_JZ4780=3Dm
	def_tristate y if MTD_NAND_JZ4780=3Dy

Thanks,
-Paul


Le sam. 15 juin 2019 =E0 15:44, YueHaibing <yuehaibing@huawei.com> a=20
=E9crit :
> If MTD_NAND_JZ4780 is y and MTD_NAND_JZ4780_BCH is m,
> which select CONFIG_MTD_NAND_INGENIC_ECC to m, building fails:
>=20
> drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function=20
> `ingenic_nand_remove':
> ingenic_nand.c:(.text+0x177): undefined reference to=20
> `ingenic_ecc_release'
> drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function=20
> `ingenic_nand_ecc_correct':
> ingenic_nand.c:(.text+0x2ee): undefined reference to=20
> `ingenic_ecc_correct'
>=20
> Select MTD_NAND_INGENIC_ECC if MTD_NAND_JZ4780 is set
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fiexes: 15de8c6efd0e ("mtd: rawnand: ingenic: Separate top-level and=20
> SoC specific code")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/mtd/nand/raw/ingenic/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig=20
> b/drivers/mtd/nand/raw/ingenic/Kconfig
> index 19a96ce..d0b1909 100644
> --- a/drivers/mtd/nand/raw/ingenic/Kconfig
> +++ b/drivers/mtd/nand/raw/ingenic/Kconfig
> @@ -9,6 +9,7 @@ config MTD_NAND_JZ4740
>  config MTD_NAND_JZ4780
>  	tristate "JZ4780 NAND controller"
>  	depends on JZ4780_NEMC
> +	select MTD_NAND_INGENIC_ECC
>  	help
>  	  Enables support for NAND Flash connected to the NEMC on JZ4780 SoC
>  	  based boards, using the BCH controller for hardware error=20
> correction.
> @@ -20,7 +21,6 @@ config MTD_NAND_INGENIC_ECC
>=20
>  config MTD_NAND_JZ4740_ECC
>  	tristate "Hardware BCH support for JZ4740 SoC"
> -	select MTD_NAND_INGENIC_ECC
>  	help
>  	  Enable this driver to support the Reed-Solomon error-correction
>  	  hardware present on the JZ4740 SoC from Ingenic.
> @@ -30,7 +30,6 @@ config MTD_NAND_JZ4740_ECC
>=20
>  config MTD_NAND_JZ4725B_BCH
>  	tristate "Hardware BCH support for JZ4725B SoC"
> -	select MTD_NAND_INGENIC_ECC
>  	help
>  	  Enable this driver to support the BCH error-correction hardware
>  	  present on the JZ4725B SoC from Ingenic.
> @@ -40,7 +39,6 @@ config MTD_NAND_JZ4725B_BCH
>=20
>  config MTD_NAND_JZ4780_BCH
>  	tristate "Hardware BCH support for JZ4780 SoC"
> -	select MTD_NAND_INGENIC_ECC
>  	help
>  	  Enable this driver to support the BCH error-correction hardware
>  	  present on the JZ4780 SoC from Ingenic.
> --
> 2.7.4
>=20
>=20

=

