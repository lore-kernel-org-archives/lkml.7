Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE76C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4C8206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfHAGqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:46:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34144 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAGqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:46:16 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id ACDC42604D6;
        Thu,  1 Aug 2019 07:46:14 +0100 (BST)
Date:   Thu, 1 Aug 2019 08:46:12 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: Bring flash params init together
Message-ID: <20190801084612.26633b65@collabora.com>
In-Reply-To: <20190731091835.27766-2-tudor.ambarus@microchip.com>
References: <20190731091835.27766-1-tudor.ambarus@microchip.com>
        <20190731091835.27766-2-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 09:18:45 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Bring all flash parameters default initialization in
> spi_nor_default_params_init().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 01be6d49ce3b..fba941a932cc 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4319,6 +4319,7 @@ static void spi_nor_default_init_params(struct spi_nor *nor,
>  {
>  	struct spi_nor_erase_map *map = &nor->erase_map;
>  	const struct flash_info *info = nor->info;
> +	struct device_node *np = spi_nor_get_flash_node(nor);
>  	u8 i, erase_mask;
>  
>  	/* Set legacy flash parameters as default. */
> @@ -4328,18 +4329,25 @@ static void spi_nor_default_init_params(struct spi_nor *nor,
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
> @@ -4876,24 +4884,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	nor->page_size = params.page_size;
>  	mtd->writebufsize = nor->page_size;
>  
> -	if (np) {
> -		/* If we were instantiated by DT, use it */
> -		if (of_property_read_bool(np, "m25p,fast-read"))
> -			params.hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
> -		else
> -			params.hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
> -	} else {
> -		/* If we weren't instantiated by DT, default to fast-read */
> -		params.hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
> -	}
> -
>  	if (of_property_read_bool(np, "broken-flash-reset"))
>  		nor->flags |= SNOR_F_BROKEN_RESET;
>  
> -	/* Some devices cannot do fast-read, no matter what DT tells us */
> -	if (info->flags & SPI_NOR_NO_FR)
> -		params.hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
> -
>  	if (nor->locking_ops) {
>  		mtd->_lock = spi_nor_lock;
>  		mtd->_unlock = spi_nor_unlock;

