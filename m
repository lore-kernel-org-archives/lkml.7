Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF5EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48F6206C1
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M/HcfsoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfHEGSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:18:09 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42786 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEGSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:18:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x756Hfu2075491;
        Mon, 5 Aug 2019 01:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564985861;
        bh=exasCwuJ86G358eXNZVxvh3NAnCoduVKquJVHpwvm34=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M/HcfsoJATT2XUlGxBdf0U1DmjIepGssW2FOBUgKDaFf77ijK5w5JJJUD3vFyjEJP
         eLMHxJA/UcxkumQSbrFTgJjxWmV+d9gS3YFYfDnja5+7/F9JBumrTLcefe0RmXWFm2
         N57RYycOOeSeR+LzIQ50U6/d2gkxXPq2czcrpoWE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x756Hfbf026623
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 01:17:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 01:17:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 01:17:41 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x756HY0c063879;
        Mon, 5 Aug 2019 01:17:35 -0500
Subject: Re: [PATCH 3/5] mtd: spi-nor: add Global Block Unlock support
To:     <Tudor.Ambarus@microchip.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
References: <20190717084745.19322-1-tudor.ambarus@microchip.com>
 <20190717084745.19322-4-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3fe57110-026f-200f-ee6b-e74bb36d50b9@ti.com>
Date:   Mon, 5 Aug 2019 11:48:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717084745.19322-4-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/07/19 2:18 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> To avoid inadvertent writes during power-up, some flashes are
> write-protected by default after a power-on reset cycle.
> A Global Block-Protection Unlock command offers a single
> command cycle that unlocks the entire memory array. This is
> identical with what other nor flashes are doing by clearing
> the block protection bits from the status register: disable
> the write protection after a power-on reset cycle.
> 
> We can't determine this purely by manufacturer type and it's not
> autodetectable by anything like SFDP, so make a new flag for it:
> UNLOCK_GLOBAL_BLOCK.
> 
> Note that the Global Block Unlock command has different names
> depending on the manufacturer, but always the same command value:
> 0x98. Macronix's MX25U12835F names it Gang Block Unlock,
> Winbound's W25Q128FV names it Global Block Unlock and
> Microchip's SST26VF064B names it Global Block Protection Unlock.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


> ---
>  drivers/mtd/spi-nor/spi-nor.c | 21 ++++++++++++++++++++-
>  include/linux/mtd/spi-nor.h   |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index e9e441f91b68..767e2e6eb1b8 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -250,7 +250,7 @@ struct flash_info {
>  	u16		page_size;
>  	u16		addr_width;
>  
> -	u16		flags;
> +	u32		flags;
>  #define SECT_4K			BIT(0)	/* SPINOR_OP_BE_4K works uniformly */
>  #define SPI_NOR_NO_ERASE	BIT(1)	/* No erase command needed */
>  #define SST_WRITE		BIT(2)	/* use SST byte programming */
> @@ -279,6 +279,7 @@ struct flash_info {
>  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
>  #define USE_CLSR		BIT(14)	/* use CLSR command */
>  #define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
> +#define UNLOCK_GLOBAL_BLOCK	BIT(16) /* Unlock global block protection */
>  
>  	/* Part specific fixup hooks. */
>  	const struct spi_nor_fixups *fixups;
> @@ -1725,6 +1726,20 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
>  	return spi_nor_clear_sr_bp(nor);
>  }
>  
> +static int spi_nor_unlock_global_block_protection(struct spi_nor *nor)
> +{
> +	int ret;
> +
> +	write_enable(nor);
> +
> +	ret = nor->write_reg(nor, SPINOR_OP_ULBPR, NULL, 0);
> +	if (ret < 0) {
> +		dev_err(nor->dev, "error %d on ULBPR\n", ret);
> +		return ret;
> +	}
> +	return spi_nor_wait_till_ready(nor);
> +}
> +
>  /* Used when the "_ext_id" is two bytes at most */
>  #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
>  		.id = {							\
> @@ -4053,6 +4068,10 @@ static int spi_nor_init(struct spi_nor *nor)
>  				spi_nor_spansion_clear_sr_bp;
>  	}
>  
> +	if (nor->info->flags & UNLOCK_GLOBAL_BLOCK)
> +		nor->disable_write_protection =
> +			spi_nor_unlock_global_block_protection;
> +
>  	if (nor->disable_write_protection) {
>  		err = nor->disable_write_protection(nor);
>  		if (err) {
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 6c3273760700..84d279fd287e 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -65,6 +65,7 @@
>  #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
>  #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
>  #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
> +#define SPINOR_OP_ULBPR		0x98    /* Global Block Unlock Protection */
>  
>  /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
>  #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
> 

-- 
Regards
Vignesh
