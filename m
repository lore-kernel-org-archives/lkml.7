Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF18C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F4E217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfHYLcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 07:32:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37738 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfHYLcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 07:32:46 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4CB3028A5BC;
        Sun, 25 Aug 2019 12:32:44 +0100 (BST)
Date:   Sun, 25 Aug 2019 13:32:41 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] mtd: spi-nor: Drop quad_enable() from 'struct
 spi-nor'
Message-ID: <20190825133241.5e920e69@collabora.com>
In-Reply-To: <20190823155325.13459-4-tudor.ambarus@microchip.com>
References: <20190823155325.13459-1-tudor.ambarus@microchip.com>
        <20190823155325.13459-4-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 15:53:39 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> All flash parameters and settings should reside inside
> 'struct spi_nor_flash_parameter'. Drop the local copy of
> quad_enable() and use the one from 'struct spi_nor_flash_parameter'.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 38 ++++++++++++++++++++++----------------
>  include/linux/mtd/spi-nor.h   |  2 --
>  2 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index e9b9cd70a999..6bd104c29cd9 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4403,7 +4403,6 @@ static int spi_nor_setup(struct spi_nor *nor,
>  {
>  	struct spi_nor_flash_parameter *params = &nor->params;
>  	u32 ignored_mask, shared_mask;
> -	bool enable_quad_io;
>  	int err;
>  
>  	/*
> @@ -4457,17 +4456,27 @@ static int spi_nor_setup(struct spi_nor *nor,
>  		return err;
>  	}
>  
> -	/* Enable Quad I/O if needed. */
> -	enable_quad_io = (spi_nor_get_protocol_width(nor->read_proto) == 4 ||
> -			  spi_nor_get_protocol_width(nor->write_proto) == 4);
> -	if (enable_quad_io && params->quad_enable)
> -		nor->quad_enable = params->quad_enable;
> -	else
> -		nor->quad_enable = NULL;
> -
>  	return 0;
>  }
>  
> +/**
> + * spi_nor_quad_enable() - enable Quad I/O if needed.
> + * @nor:                pointer to a 'struct spi_nor'
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_quad_enable(struct spi_nor *nor)
> +{
> +	if (!nor->params.quad_enable)
> +		return 0;
> +
> +	if (!(spi_nor_get_protocol_width(nor->read_proto) == 4 ||
> +	      spi_nor_get_protocol_width(nor->write_proto) == 4))
> +		return 0;
> +
> +	return nor->params.quad_enable(nor);
> +}
> +
>  static int spi_nor_init(struct spi_nor *nor)
>  {
>  	int err;
> @@ -4484,12 +4493,10 @@ static int spi_nor_init(struct spi_nor *nor)
>  		}
>  	}
>  
> -	if (nor->quad_enable) {
> -		err = nor->quad_enable(nor);
> -		if (err) {
> -			dev_err(nor->dev, "quad mode not supported\n");
> -			return err;
> -		}
> +	err = spi_nor_quad_enable(nor);
> +	if (err) {
> +		dev_err(nor->dev, "quad mode not supported\n");
> +		return err;
>  	}
>  
>  	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES)) {
> @@ -4706,7 +4713,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	 * - select op codes for (Fast) Read, Page Program and Sector Erase.
>  	 * - set the number of dummy cycles (mode cycles + wait states).
>  	 * - set the SPI protocols for register and memory accesses.
> -	 * - set the Quad Enable bit if needed (required by SPI x-y-4 protos).
>  	 */
>  	ret = spi_nor_setup(nor, hwcaps);
>  	if (ret)
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 77ba692d9348..17787238f0e9 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -535,7 +535,6 @@ struct flash_info;
>   * @flash_unlock:	[FLASH-SPECIFIC] unlock a region of the SPI NOR
>   * @flash_is_locked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
>   *			completely locked
> - * @quad_enable:	[FLASH-SPECIFIC] enables SPI NOR quad mode
>   * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
>   *			the SPI NOR Status Register.
>   * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
> @@ -579,7 +578,6 @@ struct spi_nor {
>  	int (*flash_lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  	int (*flash_unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
> -	int (*quad_enable)(struct spi_nor *nor);
>  	int (*clear_sr_bp)(struct spi_nor *nor);
>  	struct spi_nor_flash_parameter params;
>  

