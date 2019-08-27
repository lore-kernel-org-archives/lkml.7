Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E54C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020A82173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJKrpKms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfH0GHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:07:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33832 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfH0GHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:07:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R66val089330;
        Tue, 27 Aug 2019 01:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566886017;
        bh=rEIwKxJba03LbSEV/zaHDRCjnqXhT0nMrsqWIH7p1zE=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=IJKrpKmsafdNwyDowMq5mZVibP0LwIA7xB37pzvXABhINR+nPBKwW7U8JlJaxtK2p
         r6wjlhOTk3YsKww3z4kHJiNCj5byxEZXU00dTddnEGcTruAXPh/v2XlYDiCxTpZZDh
         Hn0/U8XKIvHFFwiprjb/ntfW84K93nKcvfz0zTbQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R66vRk059063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 01:06:57 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 01:06:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 01:06:57 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R66sIL097798;
        Tue, 27 Aug 2019 01:06:54 -0500
Subject: Re: [RESEND PATCH v3 09/20] mtd: spi-nor: Create a ->set_4byte()
 method
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-10-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <91224f9b-013d-8a67-85b4-59521dcef389@ti.com>
Date:   Tue, 27 Aug 2019 11:37:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-10-tudor.ambarus@microchip.com>
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
> The procedure used to enable 4 byte addressing mode depends on the NOR
> device, so let's provide a hook so that manufacturer specific handling
> can be implemented in a sane way.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> [tudor.ambarus@microchip.com: use nor->params.set_4byte() instead of
> nor->set_4byte()]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3: no changes>
>  drivers/mtd/spi-nor/spi-nor.c | 76 ++++++++++++++++++++++---------------------
>  include/linux/mtd/spi-nor.h   |  2 ++
>  2 files changed, 41 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 1e7f8dc3457d..235e82a121a1 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -633,6 +633,17 @@ static int macronix_set_4byte(struct spi_nor *nor, bool enable)
>  			      NULL, 0);
>  }
>  
> +static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
> +{
> +	int ret;
> +
> +	write_enable(nor);
> +	ret = macronix_set_4byte(nor, enable);
> +	write_disable(nor);
> +
> +	return ret;
> +}
> +
>  static int spansion_set_4byte(struct spi_nor *nor, bool enable)
>  {
>  	nor->bouncebuf[0] = enable << 7;
> @@ -667,45 +678,24 @@ static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
>  	return nor->write_reg(nor, SPINOR_OP_WREAR, nor->bouncebuf, 1);
>  }
>  
> -/* Enable/disable 4-byte addressing mode. */
> -static int set_4byte(struct spi_nor *nor, bool enable)
> +static int winbond_set_4byte(struct spi_nor *nor, bool enable)
>  {
> -	int status;
> -	bool need_wren = false;
> -
> -	switch (JEDEC_MFR(nor->info)) {
> -	case SNOR_MFR_ST:
> -	case SNOR_MFR_MICRON:
> -		/* Some Micron need WREN command; all will accept it */
> -		need_wren = true;
> -		/* fall through */
> -	case SNOR_MFR_MACRONIX:
> -	case SNOR_MFR_WINBOND:
> -		if (need_wren)
> -			write_enable(nor);
> +	int ret;
>  
> -		status = macronix_set_4byte(nor, enable);
> -		if (need_wren)
> -			write_disable(nor);
> +	ret = macronix_set_4byte(nor, enable);
> +	if (ret || enable)
> +		return ret;
>  
> -		if (!status && !enable &&
> -		    JEDEC_MFR(nor->info) == SNOR_MFR_WINBOND) {
> -			/*
> -			 * On Winbond W25Q256FV, leaving 4byte mode causes
> -			 * the Extended Address Register to be set to 1, so all
> -			 * 3-byte-address reads come from the second 16M.
> -			 * We must clear the register to enable normal behavior.
> -			 */
> -			write_enable(nor);
> -			spi_nor_write_ear(nor, 0);
> -			write_disable(nor);
> -		}
> +	/*
> +	 * On Winbond W25Q256FV, leaving 4byte mode causes the Extended Address
> +	 * Register to be set to 1, so all 3-byte-address reads come from the
> +	 * second 16M. We must clear the register to enable normal behavior.
> +	 */
> +	write_enable(nor);
> +	ret = spi_nor_write_ear(nor, 0);
> +	write_disable(nor);
>  
> -		return status;
> -	default:
> -		/* Spansion style */
> -		return spansion_set_4byte(nor, enable);
> -	}
> +	return ret;
>  }
>  
>  static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
> @@ -4153,11 +4143,18 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  static void macronix_set_default_init(struct spi_nor *nor)
>  {
>  	nor->params.quad_enable = macronix_quad_enable;
> +	nor->params.set_4byte = macronix_set_4byte;
>  }
>  
>  static void st_micron_set_default_init(struct spi_nor *nor)
>  {
>  	nor->params.quad_enable = NULL;
> +	nor->params.set_4byte = st_micron_set_4byte;
> +}
> +
> +static void winbond_set_default_init(struct spi_nor *nor)
> +{
> +	nor->params.set_4byte = winbond_set_4byte;
>  }
>  
>  /**
> @@ -4178,6 +4175,10 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
>  		st_micron_set_default_init(nor);
>  		break;
>  
> +	case SNOR_MFR_WINBOND:
> +		winbond_set_default_init(nor);
> +		break;
> +
>  	default:
>  		break;
>  	}
> @@ -4222,6 +4223,7 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
>  
>  	/* Initialize legacy flash parameters and settings. */
>  	params->quad_enable = spansion_quad_enable;
> +	params->set_4byte = spansion_set_4byte;
>  
>  	/* Set SPI NOR sizes. */
>  	params->size = (u64)info->sector_size * info->n_sectors;
> @@ -4587,7 +4589,7 @@ static int spi_nor_init(struct spi_nor *nor)
>  		 */
>  		WARN_ONCE(nor->flags & SNOR_F_BROKEN_RESET,
>  			  "enabling reset hack; may not recover from unexpected reboots\n");
> -		set_4byte(nor, true);
> +		nor->params.set_4byte(nor, true);
>  	}
>  
>  	return 0;
> @@ -4611,7 +4613,7 @@ void spi_nor_restore(struct spi_nor *nor)
>  	/* restore the addressing mode */
>  	if (nor->addr_width == 4 && !(nor->flags & SNOR_F_4B_OPCODES) &&
>  	    nor->flags & SNOR_F_BROKEN_RESET)
> -		set_4byte(nor, false);
> +		nor->params.set_4byte(nor, false);
>  }
>  EXPORT_SYMBOL_GPL(spi_nor_restore);
>  
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index a86c0d9fb01d..7da89dd483cb 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -482,6 +482,7 @@ struct spi_nor;
>   * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
>   *                      Table.
>   * @quad_enable:	enables SPI NOR quad mode.
> + * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
>   */
>  struct spi_nor_flash_parameter {
>  	u64				size;
> @@ -494,6 +495,7 @@ struct spi_nor_flash_parameter {
>  	struct spi_nor_erase_map        erase_map;
>  
>  	int (*quad_enable)(struct spi_nor *nor);
> +	int (*set_4byte)(struct spi_nor *nor, bool enable);
>  };
>  
>  /**
> 

-- 
Regards
Vignesh
