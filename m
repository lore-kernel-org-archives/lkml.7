Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A0AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2DE2173E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 11:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfHYLrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 07:47:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37908 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfHYLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 07:47:09 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 69EE82787E3;
        Sun, 25 Aug 2019 12:47:07 +0100 (BST)
Date:   Sun, 25 Aug 2019 13:47:04 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] mtd: spi_nor: Move manufacturer quad_enable() in
 ->default_init()
Message-ID: <20190825134704.677c83d6@collabora.com>
In-Reply-To: <20190824120027.14452-4-tudor.ambarus@microchip.com>
References: <20190824120027.14452-1-tudor.ambarus@microchip.com>
        <20190824120027.14452-4-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2019 12:00:41 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The goal is to move the quad_enable manufacturer specific init in the
> nor->manufacturer->fixups->default_init()
> 
> The legacy quad_enable() implementation is spansion_quad_enable(),
> select this method by default.
> 
> Set specific manufacturer fixups->default_init() hooks to overwrite
> the default quad_enable() implementation when needed.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 48 ++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 27951e5a01e2..c9514dfd7d6d 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4150,13 +4150,38 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	return err;
>  }
>  
> +static void macronix_set_default_init(struct spi_nor *nor)
> +{
> +	nor->params.quad_enable = macronix_quad_enable;

Since it's now supposed to be the default QE implementation I'd
recommend renaming the function into default_quad_enable() (this can be
done in a separate patch).

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> +}
> +
> +static void st_micron_set_default_init(struct spi_nor *nor)
> +{
> +	nor->params.quad_enable = NULL;
> +}
> +
>  /**
>   * spi_nor_manufacturer_init_params() - Initialize the flash's parameters and
> - * settings based on ->default_init() hook.
> + * settings based on MFR register and ->default_init() hook.
>   * @nor:	pointer to a 'struct spi-nor'.
>   */
>  static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
>  {
> +	/* Init flash parameters based on MFR */
> +	switch (JEDEC_MFR(nor->info)) {
> +	case SNOR_MFR_MACRONIX:
> +		macronix_set_default_init(nor);
> +		break;
> +
> +	case SNOR_MFR_ST:
> +	case SNOR_MFR_MICRON:
> +		st_micron_set_default_init(nor);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
>  	if (nor->info->fixups && nor->info->fixups->default_init)
>  		nor->info->fixups->default_init(nor);
>  }
> @@ -4168,6 +4193,9 @@ static int spi_nor_init_params(struct spi_nor *nor)
>  	const struct flash_info *info = nor->info;
>  	u8 i, erase_mask;
>  
> +	/* Initialize legacy flash parameters and settings. */
> +	params->quad_enable = spansion_quad_enable;
> +
>  	/* Set SPI NOR sizes. */
>  	params->size = (u64)info->sector_size * info->n_sectors;
>  	params->page_size = info->page_size;
> @@ -4233,24 +4261,6 @@ static int spi_nor_init_params(struct spi_nor *nor)
>  			       SPINOR_OP_SE);
>  	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
>  
> -	/* Select the procedure to set the Quad Enable bit. */
> -	if (params->hwcaps.mask & (SNOR_HWCAPS_READ_QUAD |
> -				   SNOR_HWCAPS_PP_QUAD)) {
> -		switch (JEDEC_MFR(info)) {
> -		case SNOR_MFR_MACRONIX:
> -			params->quad_enable = macronix_quad_enable;
> -			break;
> -
> -		case SNOR_MFR_ST:
> -		case SNOR_MFR_MICRON:
> -			break;
> -
> -		default:
> -			/* Kept only for backward compatibility purpose. */
> -			params->quad_enable = spansion_quad_enable;
> -			break;
> -		}
> -	}
>  
>  	spi_nor_manufacturer_init_params(nor);
>  

