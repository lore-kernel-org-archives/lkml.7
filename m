Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5EEC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF342087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DLFCe8J7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfFQLYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:24:13 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42598 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfFQLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1560770649; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XXgClKH7M7bb5E8c4HAo2DhEtqDm8AwWK0DAg3w6CSA=;
        b=DLFCe8J7F1iPnSyAWfCXNCPswqEMS67tC5mWBLsUUPwwict7OqgpXo58qFhDKzwVuWmzPl
        TCvyCpszlQ8FaFEm+TC3DOPxtvbwxLOoI1+wWRdFKVEjsCDewxvAz27jOkgCkA0D6HuhTQ
        T0Cn9LgLxGKKsufguSZno81dsI1kJRU=
Date:   Mon, 17 Jun 2019 13:24:04 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mtd: rawnand: ingenic: fix ingenic_ecc dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <1560770644.1774.0@crapouillou.net>
In-Reply-To: <20190617111110.2103786-1-arnd@arndb.de>
References: <20190617111110.2103786-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,


Le lun. 17 juin 2019 =E0 13:10, Arnd Bergmann <arnd@arndb.de> a =E9crit :
> The ecc code is called from the main ingenic_nand module, but the
> Kconfig symbol gets selected by the dependent ones.
>=20
> If the child drivers are loadable modules, this leads to a link
> error:
>=20
> drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function=20
> `ingenic_nand_remove':
> ingenic_nand.c:(.text+0x1a1): undefined reference to=20
> `ingenic_ecc_release'
> drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function=20
> `ingenic_nand_ecc_correct':
> ingenic_nand.c:(.text+0x1fa): undefined reference to=20
> `ingenic_ecc_correct'
> drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function=20
> `ingenic_nand_ecc_calculate':
> ingenic_nand.c:(.text+0x255): undefined reference to=20
> `ingenic_ecc_calculate'
> drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function=20
> `ingenic_nand_probe':
> ingenic_nand.c:(.text+0x3ca): undefined reference to=20
> `of_ingenic_ecc_get'
> ingenic_nand.c:(.text+0x685): undefined reference to=20
> `ingenic_ecc_release'
>=20
> Rearrange this to have the ecc code linked the same way as the main
> driver.

I think there's a better way to fix it, only in Kconfig.

* Add a bool symbol MTD_NAND_INGENIC_USE_HW_ECC
* Have the three ECC/BCH drivers select this symbol instead of
  MTD_NAND_INGENIC_ECC
* Add the following to the MTD_NAND_JZ4780 config option:
  "select MTD_NAND_INGENIC_ECC if MTD_NAND_INGENIC_USE_HW_ECC"


> Fixes: 15de8c6efd0e ("mtd: rawnand: ingenic: Separate top-level and=20
> SoC specific code")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mtd/nand/raw/ingenic/Kconfig  | 2 +-
>  drivers/mtd/nand/raw/ingenic/Makefile | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig=20
> b/drivers/mtd/nand/raw/ingenic/Kconfig
> index 19a96ce515c1..66b7cffdb0c2 100644
> --- a/drivers/mtd/nand/raw/ingenic/Kconfig
> +++ b/drivers/mtd/nand/raw/ingenic/Kconfig
> @@ -16,7 +16,7 @@ config MTD_NAND_JZ4780
>  if MTD_NAND_JZ4780
>=20
>  config MTD_NAND_INGENIC_ECC
> -	tristate
> +	bool
>=20
>  config MTD_NAND_JZ4740_ECC
>  	tristate "Hardware BCH support for JZ4740 SoC"
> diff --git a/drivers/mtd/nand/raw/ingenic/Makefile=20
> b/drivers/mtd/nand/raw/ingenic/Makefile
> index 1ac4f455baea..5a55efc5d9bb 100644
> --- a/drivers/mtd/nand/raw/ingenic/Makefile
> +++ b/drivers/mtd/nand/raw/ingenic/Makefile
> @@ -2,7 +2,10 @@
>  obj-$(CONFIG_MTD_NAND_JZ4740) +=3D jz4740_nand.o
>  obj-$(CONFIG_MTD_NAND_JZ4780) +=3D ingenic_nand.o
>=20
> -obj-$(CONFIG_MTD_NAND_INGENIC_ECC) +=3D ingenic_ecc.o
> +ifdef CONFIG_MTD_NAND_INGENIC_ECC
> +obj-$(CONFIG_MTD_NAND_JZ4780) +=3D ingenic_ecc.o
> +endif
> +
>  obj-$(CONFIG_MTD_NAND_JZ4740_ECC) +=3D jz4740_ecc.o
>  obj-$(CONFIG_MTD_NAND_JZ4725B_BCH) +=3D jz4725b_bch.o
>  obj-$(CONFIG_MTD_NAND_JZ4780_BCH) +=3D jz4780_bch.o
> --
> 2.20.0
>=20

=

