Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA6EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A357D2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YMsm+o6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfH0F7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:59:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39424 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0F7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:59:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R5xSHV087937;
        Tue, 27 Aug 2019 00:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566885568;
        bh=P4oNuerC0LXCGxytQnNK5ZvXLlbp4WG7fggGH4SexHA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=YMsm+o6gEfozuhAyKFfpLA022t7HmAkv9JTcolEqnneQAcGDrhKOP7FnJYrQno+du
         NjA4/eg6wD6XcPALz+OPuziyjJXp5kqbtr34zGOiRRHUiGer0hQ8TI0Gu3uIVCLimF
         vHNIgKjNTzvAtF7x6CSzqxHgF7q2HkN3F09bLIcY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R5xSZU100761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 00:59:28 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 00:59:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 00:59:27 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R5xO7I057803;
        Tue, 27 Aug 2019 00:59:25 -0500
Subject: Re: [RESEND PATCH v3 08/20] mtd: spi-nor: Split spi_nor_init_params()
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-9-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <db529e35-801c-efb2-1f05-922fbcb98aef@ti.com>
Date:   Tue, 27 Aug 2019 11:30:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-9-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/19 5:38 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Add functions to delimit what the chunks of code do:
> 
> static void spi_nor_init_params()
> {
> 	spi_nor_info_init_params()
> 	spi_nor_manufacturer_init_params()
> 	spi_nor_sfdp_init_params()
> }
> 
> Add descriptions to all methods.
> 
> spi_nor_init_params() becomes of type void, as all its children
> return void.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> v3: rename spi_nor_legacy_init_params() to spi_nor_info_init_params()


Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Minor nits below...

[...]
>  
> +/**
> + * spi_nor_init_params() - Initialize the flash's parameters and settings.
> + * @nor:	pointer to a 'struct spi-nor'.
> + *
> + * The flash parameters and settings are initialized based on a sequence of
> + * calls that are ordered by priority:
> + *
> + * 1/ Default flash parameters initialization. The initializations are done
> + *    based on nor->info data:
> + *		spi_nor_info_init_params()
> + *
> + * which can be overwritten by:
> + * 2/ Manufacturer flash parameters initialization. The initializations are
> + *    done based on MFR register, or when the decisions can not be done solely
> + *    based on MFR, by using specific flash_info tweeks, ->default_init():
> + *		spi_nor_manufacturer_init_params()
> + *
> + * which can be overwritten by:
> + * 3/ SFDP flash parameters initialization. JESD216 SFDP is a standard and
> + *    should be more accurate that the above.
> + *		spi_nor_sfdp_init_params()
> + *
> + *    Please not that there is a ->post_bfpt() fixup hook that can overwrite the

s/not/note

> + *    flash parameters and settings imediately after parsing the Basic Flash

s/imediately/immediately

> + *    Parameter Table.
> + */
> +static void spi_nor_init_params(struct spi_nor *nor)
> +{
> +	spi_nor_info_init_params(nor);
>  
>  	spi_nor_manufacturer_init_params(nor);
>  
> -	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
> -	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
> -		struct spi_nor_flash_parameter sfdp_params;
> -
> -		memcpy(&sfdp_params, params, sizeof(sfdp_params));
> -
> -		if (spi_nor_parse_sfdp(nor, &sfdp_params)) {
> -			nor->addr_width = 0;
> -			nor->flags &= ~SNOR_F_4B_OPCODES;
> -		} else {
> -			memcpy(params, &sfdp_params, sizeof(*params));
> -		}
> -	}
> -
> -	return 0;
> +	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
> +	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
> +		spi_nor_sfdp_init_params(nor);
>  }
>  
>  static int spi_nor_select_read(struct spi_nor *nor,
> @@ -4670,10 +4715,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	    nor->info->flags & SPI_NOR_HAS_LOCK)
>  		nor->clear_sr_bp = spi_nor_clear_sr_bp;
>  
> -	/* Parse the Serial Flash Discoverable Parameters table. */
> -	ret = spi_nor_init_params(nor);
> -	if (ret)
> -		return ret;
> +	/* Init flash parameters based on flash_info struct and SFDP */
> +	spi_nor_init_params(nor);
>  
>  	if (!mtd->name)
>  		mtd->name = dev_name(dev);
> 

-- 
Regards
Vignesh
