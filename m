Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32D2C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3B1222C2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bT90Ccoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbfKEMMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:12:53 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50868 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388352AbfKEMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:12:53 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5CCOTs010663;
        Tue, 5 Nov 2019 06:12:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572955944;
        bh=+BWuk0Yrda7tSkoHrnt1ZpTJvKdEtz2ycB7ZWuF1V/0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bT90CcoauXy9PEOZFe+i0dZplotbtT0w6TWT1a7qGY5jmru/coO0+wUUOJOL4Xguz
         omdyvB/UiqDu3ZpNrE4JrCAqvXsIueit8PJNW1bZtRguXcyiKBu7ACNI1CoL//FEAx
         GmP+1QKzYrVVdWoBoquyujc/iX/qDDX9P5d39hZU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5CCO3i120941
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 06:12:24 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 5 Nov
 2019 06:12:08 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 06:12:08 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5CCK0K076620;
        Tue, 5 Nov 2019 06:12:21 -0600
Subject: Re: [PATCH v4 01/20] mtd: spi-nor: Use dev_dbg insted of dev_err for
 low level info
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-2-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <bc98d845-1994-69a8-a655-81ba1bb9253f@ti.com>
Date:   Tue, 5 Nov 2019 17:42:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/11/19 4:53 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> What most users care about is "my dev is not working properly".
> All low level information should be discovered when activating
> the debug traces.
> 
> Keep error messages for just three cases:
> - when the JEDEC ID is not recognized
> - when the resume() call fails
> - when the spi_nor_check() fails.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 52 +++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
[...]
>  
> @@ -679,9 +679,9 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
>  	if (nor->flags & SNOR_F_USE_CLSR &&
>  	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
>  		if (nor->bouncebuf[0] & SR_E_ERR)
> -			dev_err(nor->dev, "Erase Error occurred\n");
> +			dev_dbg(nor->dev, "Erase Error occurred\n");
>  		else
> -			dev_err(nor->dev, "Programming Error occurred\n");
> +			dev_dbg(nor->dev, "Programming Error occurred\n");
>  
>  		spi_nor_clear_sr(nor);
>  		return -EIO;
> @@ -714,12 +714,12 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
>  
>  	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
>  		if (nor->bouncebuf[0] & FSR_E_ERR)
> -			dev_err(nor->dev, "Erase operation failed.\n");
> +			dev_dbg(nor->dev, "Erase operation failed.\n");
>  		else
> -			dev_err(nor->dev, "Program operation failed.\n");
> +			dev_dbg(nor->dev, "Program operation failed.\n");
>  
>  		if (nor->bouncebuf[0] & FSR_PT_ERR)
> -			dev_err(nor->dev,
> +			dev_dbg(nor->dev,
>  			"Attempted to modify a protected sector.\n");
> 

Since, we are specifically parsing FSR bits to know the reason for
failure, I think we should use dev_err()s here.
I specifically like the last one which informs the user that
program/erase operation failed as sector was write protected.

Rest looks fine to me:

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>  		spi_nor_clear_fsr(nor);
> @@ -770,7 +770,7 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
>  		cond_resched();
>  	}
>  
> -	dev_err(nor->dev, "flash operation timed out\n");
> +	dev_dbg(nor->dev, "flash operation timed out\n");
>  
>  	return -ETIMEDOUT;
>  }
> @@ -807,7 +807,7 @@ static int spi_nor_write_sr_cr(struct spi_nor *nor, const u8 *sr_cr)
>  	}
>  
>  	if (ret) {
> -		dev_err(nor->dev,
> +		dev_dbg(nor->dev,
>  			"error while writing configuration register\n");
>  		return -EINVAL;
>  	}
> @@ -1771,7 +1771,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  		return ret;
>  
>  	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
> -		dev_err(nor->dev, "Macronix Quad bit not set\n");
> +		dev_dbg(nor->dev, "Macronix Quad bit not set\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1819,7 +1819,7 @@ static int spansion_quad_enable(struct spi_nor *nor)
>  		return ret;
>  
>  	if (!(nor->bouncebuf[0] & CR_QUAD_EN_SPAN)) {
> -		dev_err(nor->dev, "Spansion Quad bit not set\n");
> +		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1897,7 +1897,7 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>  		return ret;
>  
>  	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
> -		dev_err(nor->dev, "Spansion Quad bit not set\n");
> +		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1935,7 +1935,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  
>  	ret = spi_nor_write_sr2(nor, sr2);
>  	if (ret) {
> -		dev_err(nor->dev, "error while writing status register 2\n");
> +		dev_dbg(nor->dev, "error while writing status register 2\n");
>  		return ret;
>  	}
>  
> @@ -1949,7 +1949,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  		return ret;
>  
>  	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
> -		dev_err(nor->dev, "SR2 Quad bit not set\n");
> +		dev_dbg(nor->dev, "SR2 Quad bit not set\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1978,7 +1978,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
>  
>  	ret = spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
>  	if (ret) {
> -		dev_err(nor->dev, "write to status register failed\n");
> +		dev_dbg(nor->dev, "write to status register failed\n");
>  		return ret;
>  	}
>  
> @@ -2525,7 +2525,7 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>  						    SPI_NOR_MAX_ID_LEN);
>  	}
>  	if (tmp) {
> -		dev_err(nor->dev, "error %d reading JEDEC ID\n", tmp);
> +		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
>  		return ERR_PTR(tmp);
>  	}
>  
> @@ -2740,7 +2740,7 @@ static int s3an_nor_setup(struct spi_nor *nor,
>  
>  	ret = spi_nor_xread_sr(nor, nor->bouncebuf);
>  	if (ret) {
> -		dev_err(nor->dev, "error %d reading XRDSR\n", ret);
> +		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
>  		return ret;
>  	}
>  
> @@ -4102,7 +4102,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  		err = spi_nor_read_sfdp(nor, sizeof(header),
>  					psize, param_headers);
>  		if (err < 0) {
> -			dev_err(dev, "failed to read SFDP parameter headers\n");
> +			dev_dbg(dev, "failed to read SFDP parameter headers\n");
>  			goto exit;
>  		}
>  	}
> @@ -4349,7 +4349,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
>  	/* Select the (Fast) Read command. */
>  	err = spi_nor_select_read(nor, shared_mask);
>  	if (err) {
> -		dev_err(nor->dev,
> +		dev_dbg(nor->dev,
>  			"can't select read settings supported by both the SPI controller and memory.\n");
>  		return err;
>  	}
> @@ -4357,7 +4357,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
>  	/* Select the Page Program command. */
>  	err = spi_nor_select_pp(nor, shared_mask);
>  	if (err) {
> -		dev_err(nor->dev,
> +		dev_dbg(nor->dev,
>  			"can't select write settings supported by both the SPI controller and memory.\n");
>  		return err;
>  	}
> @@ -4365,7 +4365,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
>  	/* Select the Sector Erase command. */
>  	err = spi_nor_select_erase(nor);
>  	if (err) {
> -		dev_err(nor->dev,
> +		dev_dbg(nor->dev,
>  			"can't select erase settings supported by both the SPI controller and memory.\n");
>  		return err;
>  	}
> @@ -4686,7 +4686,7 @@ static int spi_nor_init(struct spi_nor *nor)
>  
>  		err = nor->clear_sr_bp(nor);
>  		if (err) {
> -			dev_err(nor->dev,
> +			dev_dbg(nor->dev,
>  				"fail to clear block protection bits\n");
>  			return err;
>  		}
> @@ -4694,7 +4694,7 @@ static int spi_nor_init(struct spi_nor *nor)
>  
>  	err = spi_nor_quad_enable(nor);
>  	if (err) {
> -		dev_err(nor->dev, "quad mode not supported\n");
> +		dev_dbg(nor->dev, "quad mode not supported\n");
>  		return err;
>  	}
>  
> @@ -4762,7 +4762,7 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
>  	}
>  
>  	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
> -		dev_err(nor->dev, "address width is too large: %u\n",
> +		dev_dbg(nor->dev, "address width is too large: %u\n",
>  			nor->addr_width);
>  		return -EINVAL;
>  	}
> 

-- 
Regards
Vignesh
