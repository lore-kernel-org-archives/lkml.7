Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFACFC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CBD222FC
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfHGJv3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:51:29 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52341 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfHGJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:51:29 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 83D3D200009;
        Wed,  7 Aug 2019 09:51:25 +0000 (UTC)
Date:   Wed, 7 Aug 2019 11:51:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: Re: [PATCH 5/8] mtd: spinand: micron: prepare for generalizing
 driver
Message-ID: <20190807115124.2f4f5d8e@xps13>
In-Reply-To: <20190722055621.23526-6-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-6-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:18 +0200:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 

"mtd: spinand: micron: Rename helpers and structures to be more generic"

> Generalize OOB layout structure and function names.

Change the prefix of Micron driver's functions and structures before
supporting more chips: s/mt29f2g01abagd/micron/

> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/spi/micron.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 7d7b1f7fcf71..95bc5264ebc1 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -34,38 +34,38 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
>  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
> -static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int section,
> -					struct mtd_oob_region *region)
> +static int micron_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				struct mtd_oob_region *region)
>  {
>  	if (section)
>  		return -ERANGE;
>  
> -	region->offset = 64;
> -	region->length = 64;
> +	region->offset = mtd->oobsize / 2;
> +	region->length = mtd->oobsize / 2;
>  
>  	return 0;
>  }
>  
> -static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int section,
> -					 struct mtd_oob_region *region)
> +static int micron_ooblayout_free(struct mtd_info *mtd, int section,
> +				 struct mtd_oob_region *region)
>  {
>  	if (section)
>  		return -ERANGE;
>  
>  	/* Reserve 2 bytes for the BBM. */
>  	region->offset = 2;
> -	region->length = 62;
> +	region->length = (mtd->oobsize / 2) - 2;
>  
>  	return 0;
>  }
>  
> -static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout = {
> -	.ecc = mt29f2g01abagd_ooblayout_ecc,
> -	.free = mt29f2g01abagd_ooblayout_free,
> +static const struct mtd_ooblayout_ops micron_ooblayout_ops = {
> +	.ecc = micron_ooblayout_ecc,
> +	.free = micron_ooblayout_free,
>  };
>  
> -static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
> -					 u8 status)
> +static int micron_ecc_get_status(struct spinand_device *spinand,
> +				 u8 status)
>  {
>  	switch (status & MICRON_STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -98,8 +98,8 @@ static const struct spinand_info micron_spinand_table[] = {
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
> -				     mt29f2g01abagd_ecc_get_status)),
> +		     SPINAND_ECCINFO(&micron_ooblayout_ops,
> +				     micron_ecc_get_status)),
>  };
>  
>  static int micron_spinand_detect(struct spinand_device *spinand)


Thanks,
Miquèl
