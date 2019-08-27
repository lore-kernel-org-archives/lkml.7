Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF6CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BD520828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mLW/ZDdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfH0Fsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:48:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47440 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0Fsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:48:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R5mN9X107439;
        Tue, 27 Aug 2019 00:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566884903;
        bh=NLw1dkWiMq9XrUKh2CldBAJYtOZ9XDX5mN04ZYPcLhw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mLW/ZDdvX02S4VgGO0bsiCCS/YrKFaTx1Sr/yJ+RqX79aIcLFhg7rGFnp2zYtNYxS
         BdSgY7hUYdDYc44sZk9DIqufyGnfAVhv6ieJ2W5EO1EXDzXiB6utAt74R8+xVp2mdY
         sTIk5SZlSJ2OlKaze46E6EqSJVYYnJgADlVVhrZA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R5mNx9086346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 00:48:23 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 00:48:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 00:48:22 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R5mJvL051681;
        Tue, 27 Aug 2019 00:48:20 -0500
Subject: Re: [RESEND PATCH v3 06/20] mtd: spi-nor: Add a default_init() fixup
 hook for gd25q256
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-7-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <74bfb73e-e1c4-ce78-f1cb-6ee0050eb275@ti.com>
Date:   Tue, 27 Aug 2019 11:18:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-7-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/19 5:38 PM, Tudor.Ambarus@microchip.com wrote:
> From: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> gd25q256 needs to tweak the ->quad_enable() implementation and the
> ->default_init() fixup hook is the perfect place to do that. This way,
> if we ever need to tweak more things for this flash, we won't have to
> add new fields in flash_info.
> 
> We can get rid of the flash_info->quad_enable field as gd25q256 was
> the only user.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> [tudor.ambarus@microchip.com: use ->default_init() hook instead of
> ->post_sfdp()]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---


Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3: no changes
> >  drivers/mtd/spi-nor/spi-nor.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 8fd60e1eebd2..3dbbfe34d1d2 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -222,8 +222,6 @@ struct flash_info {
>  
>  	/* Part specific fixup hooks. */
>  	const struct spi_nor_fixups *fixups;
> -
> -	int	(*quad_enable)(struct spi_nor *nor);
>  };
>  
>  #define JEDEC_MFR(info)	((info)->id[0])
> @@ -2126,6 +2124,21 @@ static struct spi_nor_fixups mx25l25635_fixups = {
>  	.post_bfpt = mx25l25635_post_bfpt_fixups,
>  };
>  
> +static void gd25q256_default_init(struct spi_nor *nor)
> +{
> +	/*
> +	 * Some manufacturer like GigaDevice may use different
> +	 * bit to set QE on different memories, so the MFR can't
> +	 * indicate the quad_enable method for this case, we need
> +	 * to set it in the default_init fixup hook.
> +	 */
> +	nor->params.quad_enable = macronix_quad_enable;
> +}
> +
> +static struct spi_nor_fixups gd25q256_fixups = {
> +	.default_init = gd25q256_default_init,
> +};
> +
>  /* NOTE: double check command sets and memory organization when you add
>   * more nor chips.  This current list focusses on newer chips, which
>   * have been converging on command sets which including JEDEC ID.
> @@ -2218,7 +2231,7 @@ static const struct flash_info spi_nor_ids[] = {
>  		"gd25q256", INFO(0xc84019, 0, 64 * 1024, 512,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			SPI_NOR_4B_OPCODES | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> -			.quad_enable = macronix_quad_enable,
> +			.fixups = &gd25q256_fixups,
>  	},
>  
>  	/* Intel/Numonyx -- xxxs33b */
> @@ -4237,15 +4250,6 @@ static int spi_nor_init_params(struct spi_nor *nor)
>  			params->quad_enable = spansion_quad_enable;
>  			break;
>  		}
> -
> -		/*
> -		 * Some manufacturer like GigaDevice may use different
> -		 * bit to set QE on different memories, so the MFR can't
> -		 * indicate the quad_enable method for this case, we need
> -		 * set it in flash info list.
> -		 */
> -		if (info->quad_enable)
> -			params->quad_enable = info->quad_enable;
>  	}
>  
>  	spi_nor_manufacturer_init_params(nor);
> 

-- 
Regards
Vignesh
