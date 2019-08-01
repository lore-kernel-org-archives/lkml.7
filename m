Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FABBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55886206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfHAGrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:47:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34172 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAGru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:47:50 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 71A762604D6;
        Thu,  1 Aug 2019 07:47:49 +0100 (BST)
Date:   Thu, 1 Aug 2019 08:47:46 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mtd: spi_nor: Introduce spi_nor_set_addr_width()
Message-ID: <20190801084746.638eae0b@collabora.com>
In-Reply-To: <20190731091835.27766-3-tudor.ambarus@microchip.com>
References: <20190731091835.27766-1-tudor.ambarus@microchip.com>
        <20190731091835.27766-3-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 09:18:47 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Parsing of flash parameters were interleaved with setting of the
> nor addr width. Dedicate a function for setting nor addr width.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 50 ++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index fba941a932cc..c322d7cd8216 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4773,6 +4773,33 @@ static const struct flash_info *spi_nor_match_id(const char *name)
>  	return NULL;
>  }
>  
> +static int spi_nor_set_addr_width(struct spi_nor *nor)
> +{
> +	if (nor->addr_width) {
> +		/* already configured from SFDP */
> +	} else if (nor->info->addr_width) {
> +		nor->addr_width = nor->info->addr_width;
> +	} else if (nor->mtd.size > 0x1000000) {
> +		/* enable 4-byte addressing if the device exceeds 16MiB */
> +		nor->addr_width = 4;
> +	} else {
> +		nor->addr_width = 3;
> +	}
> +
> +	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
> +		dev_err(nor->dev, "address width is too large: %u\n",
> +			nor->addr_width);
> +		return -EINVAL;
> +	}
> +
> +	/* Set 4byte opcodes when possible. */
> +	if (nor->addr_width == 4 && nor->flags & SNOR_F_4B_OPCODES &&
> +	    !(nor->flags & SNOR_F_HAS_4BAIT))
> +		spi_nor_set_4byte_opcodes(nor);
> +
> +	return 0;
> +}
> +
>  int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		 const struct spi_nor_hwcaps *hwcaps)
>  {
> @@ -4903,29 +4930,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (ret)
>  		return ret;
>  
> -	if (nor->addr_width) {
> -		/* already configured from SFDP */
> -	} else if (info->addr_width) {
> -		nor->addr_width = info->addr_width;
> -	} else if (mtd->size > 0x1000000) {
> -		/* enable 4-byte addressing if the device exceeds 16MiB */
> -		nor->addr_width = 4;
> -	} else {
> -		nor->addr_width = 3;
> -	}
> -
>  	if (info->flags & SPI_NOR_4B_OPCODES)
>  		nor->flags |= SNOR_F_4B_OPCODES;
>  
> -	if (nor->addr_width == 4 && nor->flags & SNOR_F_4B_OPCODES &&
> -	    !(nor->flags & SNOR_F_HAS_4BAIT))
> -		spi_nor_set_4byte_opcodes(nor);
> -
> -	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
> -		dev_err(dev, "address width is too large: %u\n",
> -			nor->addr_width);
> -		return -EINVAL;
> -	}
> +	ret = spi_nor_set_addr_width(nor);
> +	if (ret)
> +		return ret;
>  
>  	/* Send all the required SPI flash commands to initialize device */
>  	ret = spi_nor_init(nor);

