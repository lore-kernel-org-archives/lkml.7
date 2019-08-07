Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4DC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B6B21E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfHGKEN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:04:13 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42563 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfHGKEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:04:13 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C5EB5E0012;
        Wed,  7 Aug 2019 10:04:08 +0000 (UTC)
Date:   Wed, 7 Aug 2019 12:04:08 +0200
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
Subject: Re: [PATCH 6/8] mtd: spinand: micron: Turn driver implementation
 generic
Message-ID: <20190807120408.031b8d1b@xps13>
In-Reply-To: <20190722055621.23526-7-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-7-sshivamurthy@micron.com>
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

shiva.linuxworks@gmail.com wrote on Mon, 22 Jul 2019 07:56:19 +0200:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
>

I am not sure the "turn implemenatation generic" title describes what
you do.
 
> Driver is redesigned using parameter page to support Micron SPI NAND
> flashes.

Redesigned is perhaps a bit too much.

"
> The reason why spinand_select_op_variant globalized is that the Micron
> driver no longer calling spinand_match_and_init.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/spi/core.c   |  2 +-
>  drivers/mtd/nand/spi/micron.c | 61 +++++++++++++++++++++++++----------
>  include/linux/mtd/spinand.h   |  4 +++
>  3 files changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 7ae76dab9141..aae715d388b7 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -920,7 +920,7 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
>  		return spinand->manufacturer->ops->cleanup(spinand);
>  }
>  
> -static const struct spi_mem_op *
> +const struct spi_mem_op *
>  spinand_select_op_variant(struct spinand_device *spinand,
>  			  const struct spinand_op_variants *variants)
>  {
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 95bc5264ebc1..6fde93ec23a1 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -90,22 +90,10 @@ static int micron_ecc_get_status(struct spinand_device *spinand,
>  	return -EINVAL;
>  }
>  
> -static const struct spinand_info micron_spinand_table[] = {
> -	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
> -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
> -		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> -		     0,
> -		     SPINAND_ECCINFO(&micron_ooblayout_ops,
> -				     micron_ecc_get_status)),
> -};
> -

I don't know if it is wise to drop this structure.

>  static int micron_spinand_detect(struct spinand_device *spinand)
>  {
> +	const struct spi_mem_op *op;
>  	u8 *id = spinand->id.data;
> -	int ret;
>  
>  	/*
>  	 * Micron SPI NAND read ID need a dummy byte,
> @@ -114,16 +102,55 @@ static int micron_spinand_detect(struct spinand_device *spinand)
>  	if (id[1] != SPINAND_MFR_MICRON)
>  		return 0;
>  
> -	ret = spinand_match_and_init(spinand, micron_spinand_table,
> -				     ARRAY_SIZE(micron_spinand_table), id[2]);

I am not sure this is the right solution. I would keep this call and
overwrite what you need to overwrite with the fixup hook.

> -	if (ret)
> -		return ret;
> +	spinand->flags = 0;
> +	spinand->eccinfo.get_status = micron_ecc_get_status;
> +	spinand->eccinfo.ooblayout = &micron_ooblayout_ops;
> +
> +	op = spinand_select_op_variant(spinand,
> +				       &read_cache_variants);
> +	if (!op)
> +		return -ENOTSUPP;
> +
> +	spinand->op_templates.read_cache = op;
> +
> +	op = spinand_select_op_variant(spinand,
> +				       &write_cache_variants);
> +	if (!op)
> +		return -ENOTSUPP;
> +
> +	spinand->op_templates.write_cache = op;
> +
> +	op = spinand_select_op_variant(spinand,
> +				       &update_cache_variants);
> +	spinand->op_templates.update_cache = op;
>  
>  	return 1;
>  }
>  
> +static void micron_fixup_param_page(struct spinand_device *spinand,
> +				    struct nand_onfi_params *p)
> +{
> +	/*
> +	 * As per Micron datasheets vendor[83] is defined as
> +	 * die_select_feature
> +	 */
> +	if (p->vendor[83] && !p->interleaved_bits)
> +		spinand->base.memorg.planes_per_lun = 1 << p->vendor[0];
> +
> +	spinand->base.memorg.ntargets = p->lun_count;
> +	spinand->base.memorg.luns_per_target = 1;
> +
> +	/*
> +	 * As per Micron datasheets,
> +	 * vendor[82] is ECC maximum correctability
> +	 */
> +	spinand->base.eccreq.strength = p->vendor[82];
> +	spinand->base.eccreq.step_size = 512;
> +}
> +
>  static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
>  	.detect = micron_spinand_detect,
> +	.fixup_param_page = micron_fixup_param_page,
>  };
>  
>  const struct spinand_manufacturer micron_spinand_manufacturer = {
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index fea820a20bc9..ddb2194273a8 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -461,4 +461,8 @@ int spinand_match_and_init(struct spinand_device *dev,
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int target);
>  
> +const struct spi_mem_op *
> +spinand_select_op_variant(struct spinand_device *spinand,
> +			  const struct spinand_op_variants *variants);
> +
>  #endif /* __LINUX_MTD_SPINAND_H */




Thanks,
Miquèl
