Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3368FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F202622CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VXRycNKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfH0Hgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:36:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47772 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfH0Hgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:36:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R7aZOB115578;
        Tue, 27 Aug 2019 02:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566891395;
        bh=rabRdcGKKXk+rI54LrxDrK1WyVh94dphJ3IbIT41bu4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=VXRycNKGQXkAgoosfTFixNw3RyXk2jqekFV7a9mr9NA9HaB284o4u5x/DlwopOBgB
         rXMc/oOm5F8+KKQqhUeGttDSaQrfw7S+vL0hIyRPxNu1xMCUIeYug2Jf1tPUzoBHVm
         XxYrw7pqHTRy+GpHmJ0MFCOH7+jAnqRjE4xNKUik=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R7aY0v128167
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 02:36:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 02:36:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 02:36:34 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R7aVST072874;
        Tue, 27 Aug 2019 02:36:32 -0500
Subject: Re: [RESEND PATCH v3 18/20] mtd: spi_nor: Introduce
 spi_nor_set_addr_width()
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-19-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <61c0950b-6c1b-00da-bc8c-4d26d630d57b@ti.com>
Date:   Tue, 27 Aug 2019 13:07:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-19-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/19 5:39 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Parsing of flash parameters were interleaved with setting of the
> nor addr width. Dedicate a function for setting nor addr width.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3: no changes
> 
>  drivers/mtd/spi-nor/spi-nor.c | 50 ++++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index dcda96a20f6c..d13317d1f372 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4739,6 +4739,33 @@ static const struct flash_info *spi_nor_match_id(const char *name)
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
> @@ -4885,29 +4912,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
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
> 

-- 
Regards
Vignesh
