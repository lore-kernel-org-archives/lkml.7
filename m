Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D3C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77750206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfHAGtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:49:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfHAGtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:49:07 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 28AF92604D6;
        Thu,  1 Aug 2019 07:49:05 +0100 (BST)
Date:   Thu, 1 Aug 2019 08:49:02 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mtd: spi-nor: Introduce spi_nor_get_flash_info()
Message-ID: <20190801084902.0cddd236@collabora.com>
In-Reply-To: <20190731091835.27766-4-tudor.ambarus@microchip.com>
References: <20190731091835.27766-1-tudor.ambarus@microchip.com>
        <20190731091835.27766-4-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 09:18:49 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Dedicate a function for getting the pointer to the flash_info
> const struct. Trim a bit the spi_nor_scan() huge function.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 52 ++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index c322d7cd8216..636f065cc869 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4800,25 +4800,10 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
>  	return 0;
>  }
>  
> -int spi_nor_scan(struct spi_nor *nor, const char *name,
> -		 const struct spi_nor_hwcaps *hwcaps)
> +static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
> +						       const char *name)
>  {
> -	struct spi_nor_flash_parameter params;
>  	const struct flash_info *info = NULL;
> -	struct device *dev = nor->dev;
> -	struct mtd_info *mtd = &nor->mtd;
> -	struct device_node *np = spi_nor_get_flash_node(nor);
> -	int ret;
> -	int i;
> -
> -	ret = spi_nor_check(nor);
> -	if (ret)
> -		return ret;
> -
> -	/* Reset SPI protocol for all commands. */
> -	nor->reg_proto = SNOR_PROTO_1_1_1;
> -	nor->read_proto = SNOR_PROTO_1_1_1;
> -	nor->write_proto = SNOR_PROTO_1_1_1;
>  
>  	if (name)
>  		info = spi_nor_match_id(name);
> @@ -4826,7 +4811,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (!info)
>  		info = spi_nor_read_id(nor);
>  	if (IS_ERR_OR_NULL(info))
> -		return -ENOENT;
> +		return ERR_PTR(-ENOENT);
>  
>  	/*
>  	 * If caller has specified name of flash model that can normally be
> @@ -4837,7 +4822,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  
>  		jinfo = spi_nor_read_id(nor);
>  		if (IS_ERR(jinfo)) {
> -			return PTR_ERR(jinfo);
> +			return jinfo;
>  		} else if (jinfo != info) {
>  			/*
>  			 * JEDEC knows better, so overwrite platform ID. We
> @@ -4846,12 +4831,39 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  			 * marked read-only, and we don't want to lose that
>  			 * information, even if it's not 100% accurate.
>  			 */
> -			dev_warn(dev, "found %s, expected %s\n",
> +			dev_warn(nor->dev, "found %s, expected %s\n",
>  				 jinfo->name, info->name);
>  			info = jinfo;
>  		}
>  	}
>  
> +	return info;
> +}
> +
> +int spi_nor_scan(struct spi_nor *nor, const char *name,
> +		 const struct spi_nor_hwcaps *hwcaps)
> +{
> +	struct spi_nor_flash_parameter params;
> +	const struct flash_info *info;
> +	struct device *dev = nor->dev;
> +	struct mtd_info *mtd = &nor->mtd;
> +	struct device_node *np = spi_nor_get_flash_node(nor);
> +	int ret;
> +	int i;
> +
> +	ret = spi_nor_check(nor);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset SPI protocol for all commands. */
> +	nor->reg_proto = SNOR_PROTO_1_1_1;
> +	nor->read_proto = SNOR_PROTO_1_1_1;
> +	nor->write_proto = SNOR_PROTO_1_1_1;
> +
> +	info = spi_nor_get_flash_info(nor, name);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
>  	nor->info = info;
>  
>  	mutex_init(&nor->lock);

