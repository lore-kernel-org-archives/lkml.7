Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6932C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0172070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jxwL9ao5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfH0HhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:37:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35850 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfH0HhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:37:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R7b8nG008201;
        Tue, 27 Aug 2019 02:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566891428;
        bh=+On+Kzei5T8FLnVMz3GVbo60HJWmYrS5AsenYCDqT/4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=jxwL9ao5UeYW2k/Dm8gtBcsueN3SFuSQMFyvQwDh0gh5cek7X7/+YWufYPklqnBDm
         4sujXmlPq+rVxj4k15X7CLNR705Up/gwt9zTv1s7egNV4BkxFLgzVwhoeR5KW1B7Ep
         YQBxtrzhTcvWFGWrIYB0s+kY4l1otU+JuwaDjU0A=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R7b8Bv129011
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 02:37:08 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 02:37:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 02:37:07 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R7b3H8099128;
        Tue, 27 Aug 2019 02:37:04 -0500
Subject: Re: [RESEND PATCH v3 19/20] mtd: spi-nor: Introduce
 spi_nor_get_flash_info()
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-20-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <5c3a96a8-228a-3659-d59e-fb3e3d603bb2@ti.com>
Date:   Tue, 27 Aug 2019 13:07:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-20-tudor.ambarus@microchip.com>
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
> Dedicate a function for getting the pointer to the flash_info
> const struct. Trim a bit the spi_nor_scan() huge function.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3: no changes
> 
>  drivers/mtd/spi-nor/spi-nor.c | 76 +++++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d13317d1f372..ec70b58294ec 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4766,10 +4766,50 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
>  	return 0;
>  }
>  
> +static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
> +						       const char *name)
> +{
> +	const struct flash_info *info = NULL;
> +
> +	if (name)
> +		info = spi_nor_match_id(name);
> +	/* Try to auto-detect if chip name wasn't specified or not found */
> +	if (!info)
> +		info = spi_nor_read_id(nor);
> +	if (IS_ERR_OR_NULL(info))
> +		return ERR_PTR(-ENOENT);
> +
> +	/*
> +	 * If caller has specified name of flash model that can normally be
> +	 * detected using JEDEC, let's verify it.
> +	 */
> +	if (name && info->id_len) {
> +		const struct flash_info *jinfo;
> +
> +		jinfo = spi_nor_read_id(nor);
> +		if (IS_ERR(jinfo)) {
> +			return jinfo;
> +		} else if (jinfo != info) {
> +			/*
> +			 * JEDEC knows better, so overwrite platform ID. We
> +			 * can't trust partitions any longer, but we'll let
> +			 * mtd apply them anyway, since some partitions may be
> +			 * marked read-only, and we don't want to lose that
> +			 * information, even if it's not 100% accurate.
> +			 */
> +			dev_warn(nor->dev, "found %s, expected %s\n",
> +				 jinfo->name, info->name);
> +			info = jinfo;
> +		}
> +	}
> +
> +	return info;
> +}
> +
>  int spi_nor_scan(struct spi_nor *nor, const char *name,
>  		 const struct spi_nor_hwcaps *hwcaps)
>  {
> -	const struct flash_info *info = NULL;
> +	const struct flash_info *info;
>  	struct device *dev = nor->dev;
>  	struct mtd_info *mtd = &nor->mtd;
>  	struct device_node *np = spi_nor_get_flash_node(nor);
> @@ -4800,37 +4840,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (!nor->bouncebuf)
>  		return -ENOMEM;
>  
> -	if (name)
> -		info = spi_nor_match_id(name);
> -	/* Try to auto-detect if chip name wasn't specified or not found */
> -	if (!info)
> -		info = spi_nor_read_id(nor);
> -	if (IS_ERR_OR_NULL(info))
> -		return -ENOENT;
> -
> -	/*
> -	 * If caller has specified name of flash model that can normally be
> -	 * detected using JEDEC, let's verify it.
> -	 */
> -	if (name && info->id_len) {
> -		const struct flash_info *jinfo;
> -
> -		jinfo = spi_nor_read_id(nor);
> -		if (IS_ERR(jinfo)) {
> -			return PTR_ERR(jinfo);
> -		} else if (jinfo != info) {
> -			/*
> -			 * JEDEC knows better, so overwrite platform ID. We
> -			 * can't trust partitions any longer, but we'll let
> -			 * mtd apply them anyway, since some partitions may be
> -			 * marked read-only, and we don't want to lose that
> -			 * information, even if it's not 100% accurate.
> -			 */
> -			dev_warn(dev, "found %s, expected %s\n",
> -				 jinfo->name, info->name);
> -			info = jinfo;
> -		}
> -	}
> +	info = spi_nor_get_flash_info(nor, name);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
>  
>  	nor->info = info;
>  
> 

-- 
Regards
Vignesh
