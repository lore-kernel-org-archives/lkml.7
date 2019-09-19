Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285ECC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CAA2196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ltkD1iFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391981AbfISRfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:35:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52306 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbfISRfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:35:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8JHYPf6073600;
        Thu, 19 Sep 2019 12:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568914465;
        bh=cOiZeb+gQRtuveKyuopQAS6XW1r76ndwhAM3amjPJSE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ltkD1iFwzU9aKt3aTZozclTrUOXzyXz3vZea6qQpagOIYM7C/Uf6ySu3Ysffjcj3w
         27mDk2Qi+6Ptifx2zzP0DEcNikFG8FWpX+nvXuMJGgWqHBG4CrlB21+gKc3OhvHWkg
         OMP+qtdbbRl6GF41g0W068bUw3x+Y1pxLG5NkwmA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8JHYPB7034798
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Sep 2019 12:34:25 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 19
 Sep 2019 12:34:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 19 Sep 2019 12:34:21 -0500
Received: from [10.250.132.15] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8JHYKuU013494;
        Thu, 19 Sep 2019 12:34:21 -0500
Subject: Re: [PATCH 19/23] mtd: spi-nor: Rework
 spansion(_no)_read_cr_quad_enable()
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <20190917155426.7432-20-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <f811a9a6-4b88-e017-5cc6-ad758edbcab3@ti.com>
Date:   Thu, 19 Sep 2019 23:04:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917155426.7432-20-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17-Sep-19 9:25 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Merge:
> spansion_no_read_cr_quad_enable()
> spansion_read_cr_quad_enable()
> 
> in spi_nor_sr2_bit1_quad_enable().
> 
> Avoid duplication of code by using spi_nor_write_16bit_sr_and_check(),
> the SNOR_F_NO_READ_CR case is treated there.
> 
> We now do the Read Back test even for the old
> spansion_no_read_cr_quad_enable() case.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 89 ++++++++++---------------------------------
>  include/linux/mtd/spi-nor.h   |  4 +-
>  2 files changed, 22 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 2f79923e7db5..8648666fb9bd 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -907,7 +907,7 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 status_new,
>  		 * Write Status (01h) command is available just for the cases
>  		 * in which the QE bit is described in SR2 at BIT(1).
>  		 */
> -		sr_cr[1] = CR_QUAD_EN_SPAN;
> +		sr_cr[1] = SR2_QUAD_EN_BIT1;
>  	} else {
>  		sr_cr[1] = 0;
>  	}
> @@ -1963,81 +1963,34 @@ static int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor)
>  }
>  
>  /**
> - * spansion_no_read_cr_quad_enable() - set QE bit in Configuration Register.
> + * spi_nor_sr2_bit1_quad_enable() - set the Quad Enable BIT(1) in the Status
> + * Register 2.
>   * @nor:	pointer to a 'struct spi_nor'
>   *
> - * Set the Quad Enable (QE) bit in the Configuration Register.
> - * This function should be used with QSPI memories not supporting the Read
> - * Configuration Register (35h) instruction.
> - *
> - * bit 1 of the Configuration Register is the QE bit for Spansion like QSPI
> - * memories.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
> -{
> -	u8 *sr_cr = nor->bouncebuf;
> -	int ret;
> -
> -	/* Keep the current value of the Status Register. */
> -	ret = spi_nor_read_sr(nor, &sr_cr[0]);
> -	if (ret)
> -		return ret;
> -
> -	sr_cr[1] = CR_QUAD_EN_SPAN;
> -
> -	return spi_nor_write_sr(nor, sr_cr, 2);
> -}
> -
> -/**
> - * spansion_read_cr_quad_enable() - set QE bit in Configuration Register.
> - * @nor:	pointer to a 'struct spi_nor'
> - *
> - * Set the Quad Enable (QE) bit in the Configuration Register.
> - * This function should be used with QSPI memories supporting the Read
> - * Configuration Register (35h) instruction.
> - *
> - * bit 1 of the Configuration Register is the QE bit for Spansion like QSPI
> - * memories.
> + * Bit 1 of the Status Register 2 is the QE bit for Spansion like QSPI memories.
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -static int spansion_read_cr_quad_enable(struct spi_nor *nor)
> +static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
>  {
> -	u8 *sr_cr = nor->bouncebuf;
>  	int ret;
>  
> -	/* Check current Quad Enable bit value. */
> -	ret = spi_nor_read_cr(nor, &sr_cr[1]);
> -	if (ret)
> -		return ret;
> -
> -	if (sr_cr[1] & CR_QUAD_EN_SPAN)
> -		return 0;
> +	if (!(nor->flags & SNOR_F_NO_READ_CR)) {
> +		/* Check current Quad Enable bit value. */
> +		ret = spi_nor_read_cr(nor, &nor->bouncebuf[0]);
> +		if (ret)
> +			return ret;
>  
> -	sr_cr[1] |= CR_QUAD_EN_SPAN;
> +		if (nor->bouncebuf[0] & SR2_QUAD_EN_BIT1)
> +			return 0;
> +	}
>  
>  	/* Keep the current value of the Status Register. */
> -	ret = spi_nor_read_sr(nor, &sr_cr[0]);
> -	if (ret)
> -		return ret;
> -
> -	ret = spi_nor_write_sr(nor, sr_cr, 2);
> -	if (ret)
> -		return ret;
> -
> -	/* Read back and check it. */
> -	ret = spi_nor_read_cr(nor, &sr_cr[1]);
> +	ret = spi_nor_read_sr(nor, &nor->bouncebuf[0]);
>  	if (ret)
>  		return ret;
>  
> -	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
> -		dev_err(nor->dev, "Spansion Quad bit not set\n");
> -		return -EIO;
> -	}
> -
> -	return 0;

You need to set QE bit here before writing to CR register. This function
does not do that.

> +	return spi_nor_write_16bit_sr_and_check(nor, nor->bouncebuf[0], 0xFF);

Neither does spi_nor_write_16bit_sr_and_check().
We need a function that allows to modify SR2/CR register content as well
so as to set QE bit right?

Regards
Vignesh

>  }
>  
>  /**
> @@ -2117,7 +2070,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
>   *
>   * Read-modify-write function that clears the Block Protection bits from the
>   * Status Register without affecting other bits. The function is tightly
> - * coupled with the spansion_read_cr_quad_enable() function. Both assume that
> + * coupled with the spi_nor_sr2_bit1_quad_enable() function. Both assume that
>   * the Write Register with 16 bits, together with the Read Configuration
>   * Register (35h) instructions are supported.
>   *
> @@ -2138,7 +2091,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
>  	 * When the configuration register Quad Enable bit is one, only the
>  	 * Write Status (01h) command with two data bytes may be used.
>  	 */
> -	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
> +	if (sr_cr[1] & SR2_QUAD_EN_BIT1) {
>  		ret = spi_nor_read_sr(nor, &sr_cr[0]);
>  		if (ret)
>  			return ret;
> @@ -3642,7 +3595,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		 * supported.
>  		 */
>  		nor->flags |= SNOR_F_NO_READ_CR;
> -		flash->quad_enable = spansion_no_read_cr_quad_enable;
> +		flash->quad_enable = spi_nor_sr2_bit1_quad_enable;
>  		break;
>  
>  	case BFPT_DWORD15_QER_SR1_BIT6:
> @@ -3663,7 +3616,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		 * assumption of a 16-bit Write Status (01h) command.
>  		 */
>  		nor->flags |= SNOR_F_HAS_16BIT_SR;
> -		flash->quad_enable = spansion_read_cr_quad_enable;
> +		flash->quad_enable = spi_nor_sr2_bit1_quad_enable;
>  		break;
>  
>  	default:
> @@ -4626,7 +4579,7 @@ static void spi_nor_info_init_flash_params(struct spi_nor *nor)
>  	u8 i, erase_mask;
>  
>  	/* Initialize legacy flash parameters and settings. */
> -	flash->quad_enable = spansion_read_cr_quad_enable;
> +	flash->quad_enable = spi_nor_sr2_bit1_quad_enable;
>  	flash->set_4byte = spansion_set_4byte;
>  	flash->setup = spi_nor_default_setup;
>  	/* Default to 16-bit Write Status (01h) Command */
> @@ -4844,7 +4797,7 @@ static int spi_nor_init(struct spi_nor *nor)
>  	int err;
>  
>  	if (nor->clear_sr_bp) {
> -		if (nor->flash.quad_enable == spansion_read_cr_quad_enable)
> +		if (nor->flash.quad_enable == spi_nor_sr2_bit1_quad_enable)
>  			nor->clear_sr_bp = spi_nor_spansion_clear_sr_bp;
>  
>  		err = nor->clear_sr_bp(nor);
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 3a835de90b6a..5590a36eb43e 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -144,10 +144,8 @@
>  #define FSR_P_ERR		BIT(4)	/* Program operation status */
>  #define FSR_PT_ERR		BIT(1)	/* Protection error bit */
>  
> -/* Configuration Register bits. */
> -#define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
> -
>  /* Status Register 2 bits. */
> +#define SR2_QUAD_EN_BIT1	BIT(1)
>  #define SR2_QUAD_EN_BIT7	BIT(7)
>  
>  /* Supported SPI protocols */
> 
