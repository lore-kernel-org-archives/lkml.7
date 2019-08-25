Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A1FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737DC206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 12:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfHYMjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 08:39:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38210 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 08:39:17 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1E80B28A1AB;
        Sun, 25 Aug 2019 13:39:15 +0100 (BST)
Date:   Sun, 25 Aug 2019 14:39:12 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: Bring flash params init together
Message-ID: <20190825143912.7fccd9bd@collabora.com>
In-Reply-To: <20190824121910.15267-2-tudor.ambarus@microchip.com>
References: <20190824121910.15267-1-tudor.ambarus@microchip.com>
        <20190824121910.15267-2-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2019 12:19:20 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Bring all flash parameters default initialization in
> spi_nor_legacy_params_init().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index e76c23d1c54a..7e6da0ace2c7 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4469,6 +4469,7 @@ static void spi_nor_legacy_init_params(struct spi_nor *nor)
>  	struct spi_nor_flash_parameter *params = &nor->params;
>  	struct spi_nor_erase_map *map = &params->erase_map;
>  	const struct flash_info *info = nor->info;
> +	struct device_node *np = spi_nor_get_flash_node(nor);
>  	u8 i, erase_mask;
>  
>  	/* Initialize legacy flash parameters and settings. */
> @@ -4480,18 +4481,25 @@ static void spi_nor_legacy_init_params(struct spi_nor *nor)
>  	params->size = (u64)info->sector_size * info->n_sectors;
>  	params->page_size = info->page_size;
>  
> +	if (!(info->flags & SPI_NOR_NO_FR)) {
> +		/* Default to Fast Read for DT and non-DT platform devices. */
> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
> +
> +		/* Mask out Fast Read if not requested at DT instantiation. */
> +		if (np && !of_property_read_bool(np, "m25p,fast-read"))
> +			params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
> +	}
> +
>  	/* (Fast) Read settings. */
>  	params->hwcaps.mask |= SNOR_HWCAPS_READ;
>  	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ],
>  				  0, 0, SPINOR_OP_READ,
>  				  SNOR_PROTO_1_1_1);
>  
> -	if (!(info->flags & SPI_NOR_NO_FR)) {
> -		params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
> +	if (params->hwcaps.mask & SNOR_HWCAPS_READ_FAST)
>  		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_FAST],
>  					  0, 8, SPINOR_OP_READ_FAST,
>  					  SNOR_PROTO_1_1_1);
> -	}
>  
>  	if (info->flags & SPI_NOR_DUAL_READ) {
>  		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
> @@ -4897,24 +4905,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	nor->page_size = params->page_size;
>  	mtd->writebufsize = nor->page_size;
>  
> -	if (np) {
> -		/* If we were instantiated by DT, use it */
> -		if (of_property_read_bool(np, "m25p,fast-read"))
> -			params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
> -		else
> -			params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
> -	} else {
> -		/* If we weren't instantiated by DT, default to fast-read */
> -		params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
> -	}
> -
>  	if (of_property_read_bool(np, "broken-flash-reset"))
>  		nor->flags |= SNOR_F_BROKEN_RESET;
>  
> -	/* Some devices cannot do fast-read, no matter what DT tells us */
> -	if (info->flags & SPI_NOR_NO_FR)
> -		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
> -
>  	/*
>  	 * Configure the SPI memory:
>  	 * - select op codes for (Fast) Read, Page Program and Sector Erase.

