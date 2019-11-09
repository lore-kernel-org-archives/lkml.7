Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7FC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 09:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3384521882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 09:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wU/9lGbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfKIJEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 04:04:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37066 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfKIJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 04:04:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA994OLn038721;
        Sat, 9 Nov 2019 03:04:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573290264;
        bh=MS0ZJR89aYLynPojaKgN//CmOPNVtiUcDOuCsT7RzzI=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=wU/9lGbrqiFLpquGXlIICAYtvFzeaAtgCzAveTzoJSaCWoK7ooOP4qRjVtd8m1ike
         2+MIkKRHsfQJ/+KB1xiZKTm7R+/4fKKH/1LUKkS6c9/f52sLmqur7OVDgw1EO9XTfG
         emwm0U+wHI6HhFfLLUL3i7JImVn9Kzp8YPmAdedY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA994OgB106706;
        Sat, 9 Nov 2019 03:04:24 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sat, 9 Nov
 2019 03:04:24 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sat, 9 Nov 2019 03:04:23 -0600
Received: from [10.250.132.49] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA994Kv5086632;
        Sat, 9 Nov 2019 03:04:21 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v5 2/6] mtd: spi-nor: Rework the disabling of block write
 protection
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191107084135.22122-1-tudor.ambarus@microchip.com>
 <20191107084135.22122-3-tudor.ambarus@microchip.com>
Message-ID: <ddf792f8-ea2a-2659-2e9c-d6d94eb5168d@ti.com>
Date:   Sat, 9 Nov 2019 14:34:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191107084135.22122-3-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07-Nov-19 2:11 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> spi_nor_unlock() unlocks blocks of memory or the entire flash memory
> array, if requested. clear_sr_bp() unlocks the entire flash memory
> array at boot time. This calls for some unification, clear_sr_bp() is
> just an optimization for the case when the unlock request covers the
> entire flash size.
> 
> Get rid of clear_sr_bp() and introduce spi_nor_unlock_all(), which is
> just a call to spi_nor_unlock() for the entire flash memory array.
> This fixes a bug that was present in spi_nor_spansion_clear_sr_bp().
> When the QE bit was zero, we used the Write Status (01h) command with
> one data byte, which might cleared the Status Register 2. We now always
> use the Write Status (01h) command with two data bytes when
> SNOR_F_HAS_16BIT_SR is set, to avoid clearing the Status Register 2.
> 
> The SNOR_F_NO_READ_CR case is treated as well. When the flash doesn't
> support the CR Read command, we make an assumption about the value of
> the QE bit. In spi_nor_init(), call spi_nor_quad_enable() first, then
> spi_nor_unlock_all(), so that at the spi_nor_unlock_all() time we can
> be sure the QE bit has value one, because of the previous call to
> spi_nor_quad_enable().
> 
> Get rid of the MFR handling and implement specific manufacturer
> default_init() fixup hooks.
> 
> Note that this changes a bit the logic for the SNOR_MFR_ATMEL,
> SNOR_MFR_INTEL and SNOR_MFR_SST cases. Before this patch, the Atmel,
> Intel and SST chips did not set the locking ops, but unlocked the entire
> flash at boot time, while now they are setting the locking ops to
> stm_locking_ops. This should work, since the the disable of the block

Nit: s/the the/the

> protection at the boot time used the same Status Register bits to unlock
> the flash, as in the stm_locking_ops case.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>  drivers/mtd/spi-nor/spi-nor.c | 140 +++++++++++++++---------------------------
>  include/linux/mtd/spi-nor.h   |   3 -
>  2 files changed, 50 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d696334f25f0..06aac894ee6d 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2185,74 +2185,6 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  	return 0;
>  }
>  
> -/**
> - * spi_nor_clear_sr_bp() - clear the Status Register Block Protection bits.
> - * @nor:        pointer to a 'struct spi_nor'
> - *
> - * Read-modify-write function that clears the Block Protection bits from the
> - * Status Register without affecting other bits.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -static int spi_nor_clear_sr_bp(struct spi_nor *nor)
> -{
> -	int ret;
> -	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
> -
> -	ret = spi_nor_read_sr(nor, nor->bouncebuf);
> -	if (ret)
> -		return ret;
> -
> -	nor->bouncebuf[0] &= ~mask;
> -
> -	return spi_nor_write_sr(nor, nor->bouncebuf, 1);
> -}
> -
> -/**
> - * spi_nor_spansion_clear_sr_bp() - clear the Status Register Block Protection
> - * bits on spansion flashes.
> - * @nor:        pointer to a 'struct spi_nor'
> - *
> - * Read-modify-write function that clears the Block Protection bits from the
> - * Status Register without affecting other bits. The function is tightly
> - * coupled with the spansion_read_cr_quad_enable() function. Both assume that
> - * the Write Register with 16 bits, together with the Read Configuration
> - * Register (35h) instructions are supported.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
> -{
> -	int ret;
> -	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
> -	u8 *sr_cr =  nor->bouncebuf;
> -
> -	/* Check current Quad Enable bit value. */
> -	ret = spi_nor_read_cr(nor, &sr_cr[1]);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * When the configuration register Quad Enable bit is one, only the
> -	 * Write Status (01h) command with two data bytes may be used.
> -	 */
> -	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
> -		ret = spi_nor_read_sr(nor, sr_cr);
> -		if (ret)
> -			return ret;
> -
> -		sr_cr[0] &= ~mask;
> -
> -		return spi_nor_write_sr(nor, sr_cr, 2);
> -	}
> -
> -	/*
> -	 * If the Quad Enable bit is zero, use the Write Status (01h) command
> -	 * with one data byte.
> -	 */
> -	return spi_nor_clear_sr_bp(nor);
> -}
> -
>  /* Used when the "_ext_id" is two bytes at most */
>  #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
>  		.id = {							\
> @@ -4634,12 +4566,27 @@ static int spi_nor_setup(struct spi_nor *nor,
>  	return nor->params.setup(nor, hwcaps);
>  }
>  
> +static void atmel_set_default_init(struct spi_nor *nor)
> +{
> +	nor->flags |= SNOR_F_HAS_LOCK;
> +}
> +
> +static void intel_set_default_init(struct spi_nor *nor)
> +{
> +	nor->flags |= SNOR_F_HAS_LOCK;
> +}
> +
>  static void macronix_set_default_init(struct spi_nor *nor)
>  {
>  	nor->params.quad_enable = macronix_quad_enable;
>  	nor->params.set_4byte = macronix_set_4byte;
>  }
>  
> +static void sst_set_default_init(struct spi_nor *nor)
> +{
> +	nor->flags |= SNOR_F_HAS_LOCK;
> +}
> +
>  static void st_micron_set_default_init(struct spi_nor *nor)
>  {
>  	nor->flags |= SNOR_F_HAS_LOCK;
> @@ -4661,6 +4608,14 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
>  {
>  	/* Init flash parameters based on MFR */
>  	switch (JEDEC_MFR(nor->info)) {
> +	case SNOR_MFR_ATMEL:
> +		atmel_set_default_init(nor);
> +		break;
> +
> +	case SNOR_MFR_INTEL:
> +		intel_set_default_init(nor);
> +		break;
> +
>  	case SNOR_MFR_MACRONIX:
>  		macronix_set_default_init(nor);
>  		break;
> @@ -4670,6 +4625,10 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
>  		st_micron_set_default_init(nor);
>  		break;
>  
> +	case SNOR_MFR_SST:
> +		sst_set_default_init(nor);
> +		break;
> +
>  	case SNOR_MFR_WINBOND:
>  		winbond_set_default_init(nor);
>  		break;
> @@ -4930,21 +4889,26 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
>  	return nor->params.quad_enable(nor);
>  }
>  
> -static int spi_nor_init(struct spi_nor *nor)
> +/**
> + * spi_nor_unlock_all() - Unlocks the entire flash memory array.
> + * @nor:	pointer to a 'struct spi_nor'.
> + *
> + * Some SPI NOR flashes are write protected by default after a power-on reset
> + * cycle, in order to avoid inadvertent writes during power-up. Backward
> + * compatibility imposes to unlock the entire flash memory array at power-up
> + * by default.
> + */
> +static int spi_nor_unlock_all(struct spi_nor *nor)
>  {
> -	int err;
> +	if (nor->flags & SNOR_F_HAS_LOCK)
> +		return spi_nor_unlock(&nor->mtd, 0, nor->params.size);
>  
> -	if (nor->clear_sr_bp) {
> -		if (nor->params.quad_enable == spansion_read_cr_quad_enable)
> -			nor->clear_sr_bp = spi_nor_spansion_clear_sr_bp;
> +	return 0;
> +}
>  
> -		err = nor->clear_sr_bp(nor);
> -		if (err) {
> -			dev_dbg(nor->dev,
> -				"fail to clear block protection bits\n");
> -			return err;
> -		}
> -	}
> +static int spi_nor_init(struct spi_nor *nor)
> +{
> +	int err;
>  
>  	err = spi_nor_quad_enable(nor);
>  	if (err) {
> @@ -4952,6 +4916,12 @@ static int spi_nor_init(struct spi_nor *nor)
>  		return err;
>  	}
>  
> +	err = spi_nor_unlock_all(nor);
> +	if (err) {
> +		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
> +		return err;
> +	}
> +
>  	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
>  		/*
>  		 * If the RESET# pin isn't hooked up properly, or the system
> @@ -5134,16 +5104,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (info->flags & SPI_NOR_HAS_LOCK)
>  		nor->flags |= SNOR_F_HAS_LOCK;
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
>  	/* Init flash parameters based on flash_info struct and SFDP */
>  	spi_nor_init_params(nor);
>  
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index d6ec55cc6d97..11daecc5a83d 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -581,8 +581,6 @@ struct flash_info;
>   * @write_proto:	the SPI protocol for write operations
>   * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
>   * @controller_ops:	SPI NOR controller driver specific operations.
> - * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
> - *			the SPI NOR Status Register.
>   * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
>   *                      The structure includes legacy flash parameters and
>   *                      settings that can be overwritten by the spi_nor_fixups
> @@ -611,7 +609,6 @@ struct spi_nor {
>  
>  	const struct spi_nor_controller_ops *controller_ops;
>  
> -	int (*clear_sr_bp)(struct spi_nor *nor);
>  	struct spi_nor_flash_parameter params;
>  
>  	void *priv;
> 
