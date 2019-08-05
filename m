Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD186C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F9A21841
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dt+vtJn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfHEFn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 01:43:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53194 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfHEFn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 01:43:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x755hbTp046310;
        Mon, 5 Aug 2019 00:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564983817;
        bh=9zG2RkIIDaIvIHIQnRxtENusq/XqLI16q+xvUC/9MUs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dt+vtJn77RdNaYlO4vmK0PM2hvq/dRPOwGHZv5bit+ds4o++cSnOe7On4W+5xEo3P
         iFz/2Qlfrm/5uZoZK42PgwlqdHYU9smqWxikfA3myhwSP0ZsrpLPVtZNwXvii4aem4
         8YqK9qJImCNXcGsgsqHrcxt2dJstD0MgBruPQvbc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x755hbss126057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 00:43:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 00:43:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 00:43:37 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x755hYsu009974;
        Mon, 5 Aug 2019 00:43:34 -0500
Subject: Re: [PATCH 2/5] mtd: spi-nor: group the code about the write
 protection at power-up
To:     <Tudor.Ambarus@microchip.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
References: <20190717084745.19322-1-tudor.ambarus@microchip.com>
 <20190717084745.19322-3-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9fee8e16-b2f6-2428-f42b-281db01e3706@ti.com>
Date:   Mon, 5 Aug 2019 11:14:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717084745.19322-3-tudor.ambarus@microchip.com>
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
> The write protection at power-up logic was split across functions
> because of a dependency to spansion_quad_enable(). Group the code
> in spi_nor_init() as the pointer to spansion_quad_enable() can be
> retrieved from nor->quad_enable.
> 
> While touching this code, rename nor->clear_sr_bp() to
> nor->disable_write_protection() to better indicate its scope: it
> disables the default write protection after a power-on reset cycle.

I prefer this function to be renamed to nor->disable_block_protection()
so as to avoid being confused with write protect signal input to the flash.

Regards
Vignesh

> 
> No functional change intended.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 39 ++++++++++++++++++++++++---------------
>  include/linux/mtd/spi-nor.h   |  6 +++---
>  2 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 03cc788511d5..e9e441f91b68 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -3780,8 +3780,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  		default:
>  			/* Kept only for backward compatibility purpose. */
>  			params->quad_enable = spansion_quad_enable;
> -			if (nor->clear_sr_bp)
> -				nor->clear_sr_bp = spi_nor_spansion_clear_sr_bp;
>  			break;
>  		}
>  
> @@ -4034,11 +4032,32 @@ static int spi_nor_init(struct spi_nor *nor)
>  {
>  	int err;
>  
> -	if (nor->clear_sr_bp) {
> -		err = nor->clear_sr_bp(nor);
> +	/*
> +	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
> +	 * with the software protection bits set.
> +	 */
> +	if (JEDEC_MFR(nor->info) == SNOR_MFR_ATMEL ||
> +	    JEDEC_MFR(nor->info) == SNOR_MFR_INTEL ||
> +	    JEDEC_MFR(nor->info) == SNOR_MFR_SST ||
> +	    nor->info->flags & SPI_NOR_HAS_LOCK) {
> +		nor->disable_write_protection = spi_nor_clear_sr_bp;
> +
> +		/*
> +		 * In case of spansion flashes, when the configuration register
> +		 * Quad Enable bit is one, only the the Write Status (01h)
> +		 * command with two data bytes may be used to clear the block
> +		 * protection bits.
> +		 */
> +		if (nor->quad_enable == spansion_quad_enable)
> +			nor->disable_write_protection =
> +				spi_nor_spansion_clear_sr_bp;
> +	}
> +
> +	if (nor->disable_write_protection) {
> +		err = nor->disable_write_protection(nor);
>  		if (err) {
>  			dev_err(nor->dev,
> -				"fail to clear block protection bits\n");
> +				"failed to unlock the flash at init\n");
>  			return err;
>  		}
>  	}
> @@ -4165,16 +4184,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (info->flags & SPI_S3AN)
>  		nor->flags |=  SNOR_F_READY_XSR_RDY;
>  
> -	/*
> -	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
> -	 * with the software protection bits set.
> -	 */
> -	if (JEDEC_MFR(nor->info) == SNOR_MFR_ATMEL ||
> -	    JEDEC_MFR(nor->info) == SNOR_MFR_INTEL ||
> -	    JEDEC_MFR(nor->info) == SNOR_MFR_SST ||
> -	    nor->info->flags & SPI_NOR_HAS_LOCK)
> -		nor->clear_sr_bp = spi_nor_clear_sr_bp;
> -
>  	/* Parse the Serial Flash Discoverable Parameters table. */
>  	ret = spi_nor_init_params(nor, &params);
>  	if (ret)
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index c4c2c5971284..6c3273760700 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -374,8 +374,8 @@ struct flash_info;
>   * @flash_is_locked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
>   *			completely locked
>   * @quad_enable:	[FLASH-SPECIFIC] enables SPI NOR quad mode
> - * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
> - *			the SPI NOR Status Register.
> + * @disable_write_protection: [FLASH-SPECIFIC] disable write protection during
> + *                            power-up
>   * @priv:		the private data
>   */
>  struct spi_nor {
> @@ -412,7 +412,7 @@ struct spi_nor {
>  	int (*flash_unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  	int (*quad_enable)(struct spi_nor *nor);
> -	int (*clear_sr_bp)(struct spi_nor *nor);
> +	int (*disable_write_protection)(struct spi_nor *nor);
>  
>  	void *priv;
>  };
> 

-- 
Regards
Vignesh
