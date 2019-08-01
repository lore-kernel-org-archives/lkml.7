Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F5C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E558C206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfHAGmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:42:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34106 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfHAGmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:42:32 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9160528BFE1;
        Thu,  1 Aug 2019 07:42:29 +0100 (BST)
Date:   Thu, 1 Aug 2019 08:42:26 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Message-ID: <20190801084226.27572bb6@collabora.com>
In-Reply-To: <20190731091145.27374-6-tudor.ambarus@microchip.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
        <20190731091145.27374-6-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 09:12:16 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> s3an_nor_scan() was overriding the opcode selection done in
> spi_nor_default_setup(). Set nor->setup() method in order to
> avoid unnecessary call to spi_nor_default_setup().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 0ff474e5e4f5..5fea5d7ce2cb 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2795,7 +2795,9 @@ static int spi_nor_check(struct spi_nor *nor)
>  	return 0;
>  }
>  
> -static int s3an_nor_scan(struct spi_nor *nor)
> +static int s3an_nor_setup(struct spi_nor *nor,
> +			  const struct spi_nor_flash_parameter *params,
> +			  const struct spi_nor_hwcaps *hwcaps)
>  {
>  	int ret;
>  	u8 val;
> @@ -4393,6 +4395,11 @@ static void spansion_post_sfdp_fixups(struct spi_nor *nor)
>  	nor->mtd.erasesize = nor->info->sector_size;
>  }
>  
> +static void s3an_post_sfdp_fixups(struct spi_nor *nor)
> +{
> +	nor->setup = s3an_nor_setup;
> +}
> +
>  static void
>  spi_nor_manufacturer_post_sfdp_fixups(struct spi_nor *nor,
>  				      struct spi_nor_flash_parameter *params)
> @@ -4405,6 +4412,9 @@ spi_nor_manufacturer_post_sfdp_fixups(struct spi_nor *nor,
>  	default:
>  		break;
>  	}
> +
> +	if (nor->info->flags & SPI_S3AN)
> +		s3an_post_sfdp_fixups(nor);
>  }
>  
>  static void spi_nor_post_sfdp_fixups(struct spi_nor *nor,
> @@ -4582,9 +4592,9 @@ static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
>  	return 0;
>  }
>  
> -static int spi_nor_setup(struct spi_nor *nor,
> -			 const struct spi_nor_flash_parameter *params,
> -			 const struct spi_nor_hwcaps *hwcaps)
> +static int spi_nor_default_setup(struct spi_nor *nor,
> +				 const struct spi_nor_flash_parameter *params,
> +				 const struct spi_nor_hwcaps *hwcaps)
>  {
>  	u32 ignored_mask, shared_mask;
>  	int err;
> @@ -4641,6 +4651,16 @@ static int spi_nor_setup(struct spi_nor *nor,
>  	return err;
>  }
>  
> +static int spi_nor_setup(struct spi_nor *nor,
> +			 const struct spi_nor_flash_parameter *params,
> +			 const struct spi_nor_hwcaps *hwcaps)
> +{
> +	if (!nor->setup)
> +		return 0;
> +
> +	return nor->setup(nor, params, hwcaps);
> +}
> +
>  static int spi_nor_disable_write_protection(struct spi_nor *nor)
>  {
>  	if (!nor->disable_write_protection)
> @@ -4804,6 +4824,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	/* Kept only for backward compatibility purpose. */
>  	nor->quad_enable = spansion_quad_enable;
>  	nor->set_4byte = spansion_set_4byte;
> +	nor->setup = spi_nor_default_setup;
>  
>  	/* Default locking operations. */
>  	if (info->flags & SPI_NOR_HAS_LOCK) {
> @@ -4905,12 +4926,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		return -EINVAL;
>  	}
>  
> -	if (info->flags & SPI_S3AN) {
> -		ret = s3an_nor_scan(nor);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	/* Send all the required SPI flash commands to initialize device */
>  	ret = spi_nor_init(nor);
>  	if (ret)

Almost all of this (except the s3an specific bits) should be done in
the previous patch. So I'll put a condition on the R-b I placed on patch
4: some of this code should be moved there.
