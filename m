Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398C22070B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfHYM0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:26:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38086 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfHYM0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:26:24 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 16C29260D63;
        Sun, 25 Aug 2019 13:26:22 +0100 (BST)
Date:   Sun, 25 Aug 2019 14:26:18 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 6/7] mtd: spi-nor: Rework the SPI NOR lock/unlock
 logic
Message-ID: <20190825142618.70938b43@collabora.com>
In-Reply-To: <20190824120027.14452-7-tudor.ambarus@microchip.com>
References: <20190824120027.14452-1-tudor.ambarus@microchip.com>
        <20190824120027.14452-7-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2019 12:00:47 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Add the SNOR_F_HAS_LOCK flag and set it when SPI_NOR_HAS_LOCK is set
> in the flash_info entry or when it's a Micron or ST flash.
> 
> Move the locking hooks in a separate struct so that we have just
> one field to update when we change the locking implementation.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> [tudor.ambarus@microchip.com: use ->default_init() hook, introduce
> spi_nor_late_init_params(), set ops in nor->params]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 50 ++++++++++++++++++++++++++++++++-----------
>  include/linux/mtd/spi-nor.h   | 23 ++++++++++++++------
>  2 files changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 1629584be30e..fc9e14777212 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1598,6 +1598,12 @@ static int stm_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
>  	return stm_is_locked_sr(nor, ofs, len, status);
>  }
>  
> +static const struct spi_nor_locking_ops stm_locking_ops = {
> +	.lock = stm_lock,
> +	.unlock = stm_unlock,
> +	.is_locked = stm_is_locked,
> +};
> +
>  static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  {
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
> @@ -1607,7 +1613,7 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	if (ret)
>  		return ret;
>  
> -	ret = nor->flash_lock(nor, ofs, len);
> +	ret = nor->params.locking_ops->lock(nor, ofs, len);
>  
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK);
>  	return ret;
> @@ -1622,7 +1628,7 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	if (ret)
>  		return ret;
>  
> -	ret = nor->flash_unlock(nor, ofs, len);
> +	ret = nor->params.locking_ops->unlock(nor, ofs, len);
>  
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
>  	return ret;
> @@ -1637,7 +1643,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  	if (ret)
>  		return ret;
>  
> -	ret = nor->flash_is_locked(nor, ofs, len);
> +	ret = nor->params.locking_ops->is_locked(nor, ofs, len);
>  
>  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
>  	return ret;
> @@ -4148,6 +4154,7 @@ static void macronix_set_default_init(struct spi_nor *nor)
>  
>  static void st_micron_set_default_init(struct spi_nor *nor)
>  {
> +	nor->flags = SNOR_F_HAS_LOCK;
>  	nor->params.quad_enable = NULL;
>  	nor->params.set_4byte = st_micron_set_4byte;
>  }
> @@ -4292,6 +4299,23 @@ static void spi_nor_legacy_init_params(struct spi_nor *nor)
>  }
>  
>  /**
> + * spi_nor_late_init_params() - Late initialization of legacy flash parameters.
> + * @nor:	pointer to a 'struct spi_nor'
> + *
> + * Used to set legacy flash parameters and settings when the ->default_init()
> + * hook or the SFDP parser let voids.
> + */
> +static void spi_nor_late_init_params(struct spi_nor *nor)
> +{
> +	/*
> +	 * NOR protection support. When locking_ops are not provided, we pick
> +	 * the default ones.
> +	 */
> +	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params.locking_ops)
> +		nor->params.locking_ops = &stm_locking_ops;
> +}
> +
> +/**
>   * spi_nor_init_params() - Initialize the flash's parameters and settings.
>   * @nor:	pointer to a 'struct spi-nor'.
>   *
> @@ -4316,6 +4340,10 @@ static void spi_nor_legacy_init_params(struct spi_nor *nor)
>   *    Please not that there is a ->post_bfpt() fixup hook that can overwrite the
>   *    flash parameters and settings imediately after parsing the Basic Flash
>   *    Parameter Table.
> + *
> + * 4/ Late legacy flash parameters initialization, used when the
> + * ->default_init() hook or the SFDP parser do not set specific params.
> + *		spi_nor_late_init_params()
>   */
>  static void spi_nor_init_params(struct spi_nor *nor)
>  {
> @@ -4326,6 +4354,8 @@ static void spi_nor_init_params(struct spi_nor *nor)
>  	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
>  	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
>  		spi_nor_sfdp_init_params(nor);
> +
> +	spi_nor_late_init_params(nor);
>  }
>  
>  static int spi_nor_select_read(struct spi_nor *nor,
> @@ -4730,6 +4760,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (info->flags & SPI_S3AN)
>  		nor->flags |=  SNOR_F_READY_XSR_RDY;
>  
> +	if (info->flags & SPI_NOR_HAS_LOCK)
> +		nor->flags |= SNOR_F_HAS_LOCK;
> +
>  	/*
>  	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
>  	 * with the software protection bits set.
> @@ -4754,16 +4787,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	mtd->_read = spi_nor_read;
>  	mtd->_resume = spi_nor_resume;
>  
> -	/* NOR protection support for STmicro/Micron chips and similar */
> -	if (JEDEC_MFR(info) == SNOR_MFR_ST ||
> -	    JEDEC_MFR(info) == SNOR_MFR_MICRON ||
> -	    info->flags & SPI_NOR_HAS_LOCK) {
> -		nor->flash_lock = stm_lock;
> -		nor->flash_unlock = stm_unlock;
> -		nor->flash_is_locked = stm_is_locked;
> -	}
> -
> -	if (nor->flash_lock && nor->flash_unlock && nor->flash_is_locked) {
> +	if (nor->params.locking_ops) {
>  		mtd->_lock = spi_nor_lock;
>  		mtd->_unlock = spi_nor_unlock;
>  		mtd->_is_locked = spi_nor_is_locked;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 012731ad339f..6c5eaf607b50 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -243,6 +243,7 @@ enum spi_nor_option_flags {
>  	SNOR_F_BROKEN_RESET	= BIT(6),
>  	SNOR_F_4B_OPCODES	= BIT(7),
>  	SNOR_F_HAS_4BAIT	= BIT(8),
> +	SNOR_F_HAS_LOCK		= BIT(9),
>  };
>  
>  /**
> @@ -466,6 +467,18 @@ enum spi_nor_pp_command_index {
>  struct spi_nor;
>  
>  /**
> + * struct spi_nor_locking_ops - SPI NOR locking methods
> + * @lock:	lock a region of the SPI NOR.
> + * @unlock:	unlock a region of the SPI NOR.
> + * @is_locked:	check if a region of the SPI NOR is completely locked
> + */
> +struct spi_nor_locking_ops {
> +	int (*lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
> +	int (*unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
> +	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
> +};
> +
> +/**
>   * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
>   * Includes legacy flash parameters and settings that can be overwritten
>   * by the spi_nor_fixups hooks, or dynamically when parsing the JESD216
> @@ -484,6 +497,7 @@ struct spi_nor;
>   * @quad_enable:	enables SPI NOR quad mode.
>   * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
>   * @disable_block_protection: disables block protection during power-up.
> + * @locking_ops:	SPI NOR locking methods.
>   */
>  struct spi_nor_flash_parameter {
>  	u64				size;
> @@ -498,6 +512,8 @@ struct spi_nor_flash_parameter {
>  	int (*quad_enable)(struct spi_nor *nor);
>  	int (*set_4byte)(struct spi_nor *nor, bool enable);
>  	int (*disable_block_protection)(struct spi_nor *nor);

Should we move this ->disable_block_protection() hook to
spi_nor_locking_ops? 

> +
> +	const struct spi_nor_locking_ops *locking_ops;
>  };
>  
>  /**
> @@ -538,10 +554,6 @@ struct flash_info;
>   * @erase:		[DRIVER-SPECIFIC] erase a sector of the SPI NOR
>   *			at the offset @offs; if not provided by the driver,
>   *			spi-nor will send the erase opcode via write_reg()
> - * @flash_lock:		[FLASH-SPECIFIC] lock a region of the SPI NOR
> - * @flash_unlock:	[FLASH-SPECIFIC] unlock a region of the SPI NOR
> - * @flash_is_locked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
> - *			completely locked
>   * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
>   *                      The structure includes legacy flash parameters and
>   *                      settings that can be overwritten by the spi_nor_fixups
> @@ -579,9 +591,6 @@ struct spi_nor {
>  			size_t len, const u_char *write_buf);
>  	int (*erase)(struct spi_nor *nor, loff_t offs);
>  
> -	int (*flash_lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
> -	int (*flash_unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
> -	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  	struct spi_nor_flash_parameter params;
>  
>  	void *priv;

