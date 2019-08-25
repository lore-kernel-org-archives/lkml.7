Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A08C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587352070B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfHYNJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:09:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38322 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfHYNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:09:32 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 42A9F283C8C;
        Sun, 25 Aug 2019 14:09:30 +0100 (BST)
Date:   Sun, 25 Aug 2019 15:09:27 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] mtd: spi-nor: Move clear_sr_bp() to 'struct
 spi_nor_flash_parameter'
Message-ID: <20190825150927.5374b1ea@collabora.com>
In-Reply-To: <20190823155325.13459-5-tudor.ambarus@microchip.com>
References: <20190823155325.13459-1-tudor.ambarus@microchip.com>
        <20190823155325.13459-5-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 15:53:41 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> All flash parameters and settings should reside inside
> 'struct spi_nor_flash_parameter'. Move clear_sr_bp() from
> 'struct spi_nor' to 'struct spi_nor_flash_parameter'.
> 
> Rename clear_sr_bp()/disable_block_protection() to better indicate
> what the function does.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 47 +++++++++++++++++++++++++++++++++----------
>  include/linux/mtd/spi-nor.h   |  5 ++---
>  2 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 6bd104c29cd9..15b0b1148bf3 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4477,20 +4477,45 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
>  	return nor->params.quad_enable(nor);
>  }
>  
> +/**
> + * spi_nor_disable_block_protection() - Disable the write block protection
> + * during power-up.
> + * @nor:                pointer to a 'struct spi_nor'
> + *
> + * Some spi-nor flashes are write protected by default after a power-on reset
> + * cycle, in order to avoid inadvertend writes during power-up. Backward
> + * compatibility imposes to disable the write block protection at power-up
> + * by default.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_disable_block_protection(struct spi_nor *nor)
> +{
> +	if (!nor->params.disable_block_protection)
> +		return 0;
> +
> +	/*
> +	 * In case of the legacy quad enable requirements are set, if the
> +	 * configuration register Quad Enable bit is one, only the the
> +	 * Write Status (01h) command with two data bytes may be used to clear
> +	 * the block protection bits.
> +	 */
> +	if (nor->params.quad_enable == spansion_quad_enable)
> +		nor->params.disable_block_protection =
> +			spi_nor_spansion_clear_sr_bp;

Hm, doesn't look right to adjust the function pointer just before
calling it. Can't we move that logic earlier (when doing the
default/manufacturer specific init)? Also, as I said in one of my
previous emails, I'd prefer to have this hook moved to
spi_nor_locking_ops and just have a flag to reflect when block
protection can be disabled.

> +
> +	return nor->params.disable_block_protection(nor);
> +}
> +
>  static int spi_nor_init(struct spi_nor *nor)
>  {
>  	int err;
>  
> -	if (nor->clear_sr_bp) {
> -		if (nor->quad_enable == spansion_quad_enable)
> -			nor->clear_sr_bp = spi_nor_spansion_clear_sr_bp;
> -
> -		err = nor->clear_sr_bp(nor);
> -		if (err) {
> -			dev_err(nor->dev,
> -				"fail to clear block protection bits\n");
> -			return err;
> -		}
> +	err = spi_nor_disable_block_protection(nor);
> +	if (err) {
> +		dev_err(nor->dev,
> +			"fail to unlock the flash at init (err = %d)\n", err);
> +		return err;
>  	}
>  
>  	err = spi_nor_quad_enable(nor);
> @@ -4635,7 +4660,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	    JEDEC_MFR(nor->info) == SNOR_MFR_INTEL ||
>  	    JEDEC_MFR(nor->info) == SNOR_MFR_SST ||
>  	    nor->info->flags & SPI_NOR_HAS_LOCK)
> -		nor->clear_sr_bp = spi_nor_clear_sr_bp;
> +		nor->params.disable_block_protection = spi_nor_clear_sr_bp;
>  
>  	/* Parse the Serial Flash Discoverable Parameters table. */
>  	ret = spi_nor_init_params(nor);
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 17787238f0e9..399ac34a529d 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -480,6 +480,7 @@ struct spi_nor;
>   * @page_programs:	page program capabilities ordered by priority: the
>   *                      higher index in the array, the higher priority.
>   * @quad_enable:	enables SPI NOR quad mode.
> + * @disable_block_protection: disables block protection during power-up.
>   */
>  struct spi_nor_flash_parameter {
>  	u64				size;
> @@ -490,6 +491,7 @@ struct spi_nor_flash_parameter {
>  	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
>  
>  	int (*quad_enable)(struct spi_nor *nor);
> +	int (*disable_block_protection)(struct spi_nor *nor);
>  };
>  
>  /**
> @@ -535,8 +537,6 @@ struct flash_info;
>   * @flash_unlock:	[FLASH-SPECIFIC] unlock a region of the SPI NOR
>   * @flash_is_locked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
>   *			completely locked
> - * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
> - *			the SPI NOR Status Register.
>   * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
>   *                      The structure includes legacy flash parameters and
>   *                      settings that can be overwritten by the spi_nor_fixups
> @@ -578,7 +578,6 @@ struct spi_nor {
>  	int (*flash_lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  	int (*flash_unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
> -	int (*clear_sr_bp)(struct spi_nor *nor);
>  	struct spi_nor_flash_parameter params;
>  
>  	void *priv;

