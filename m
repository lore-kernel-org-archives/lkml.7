Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C56C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659742184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uXoakiBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfH0FyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:54:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58622 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0FyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:54:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R5s7mF089216;
        Tue, 27 Aug 2019 00:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566885247;
        bh=PdGPhP6yk9Qew2y7lV7qkkA/6T4hgy/lRD/J6Aq/um4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=uXoakiBPlar/EIUhpDG+u6sSCBv0L5sda/xUZYZh+K/IK3g+9s02+IIJK7CoNrkPz
         RCUvpqHF2FeiJXSMEm03Uk9Ld5Io25NFwSAR1K08tLoo7E8hgx3u0YZTWiVfuyb/Fs
         PqDJgRUsei6Lk+vPdpDP2w5Oig28GeU8zlNdCp3o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R5s7Am002150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 00:54:07 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 00:54:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 00:54:07 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R5s37Q059007;
        Tue, 27 Aug 2019 00:54:04 -0500
Subject: Re: [RESEND PATCH v3 07/20] mtd: spi_nor: Move manufacturer
 quad_enable() in ->default_init()
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-8-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <143f11c8-1227-3907-e17a-b54f2612514f@ti.com>
Date:   Tue, 27 Aug 2019 11:24:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-8-tudor.ambarus@microchip.com>
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
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---


Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh


> v3: collect R-b
> 
>  drivers/mtd/spi-nor/spi-nor.c | 48 ++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 3dbbfe34d1d2..2a239531704a 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4150,13 +4150,38 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	return err;
>  }
>  
> +static void macronix_set_default_init(struct spi_nor *nor)
> +{
> +	nor->params.quad_enable = macronix_quad_enable;
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
> 

-- 
Regards
Vignesh
