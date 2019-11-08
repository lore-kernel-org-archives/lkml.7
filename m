Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3F4FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4C620679
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yFIvI/nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKHQEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:04:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44670 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfKHQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:04:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA8G41ud040231;
        Fri, 8 Nov 2019 10:04:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573229041;
        bh=RQLuI3bVRjnGZ4T0rUT7hoe93Bh+p1MDphEFDAXWInA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yFIvI/nd+xrp061E2ZNxp6CIKBP8wbhauCb0ck2aFDcs+Q3wkPeqZzZ2TgD/aTy90
         aNa9MxZBSPsnFEA6gaGdq37RhmIjAkEJO6S5byfx+Zf8KuDlPVFfCbRE7d+kuzX79n
         Nw+LY6obvpHke5xCaEWz2UAvrthVVJuTtj1a+iEE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA8G41qe107220;
        Fri, 8 Nov 2019 10:04:01 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 8 Nov
 2019 10:03:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 8 Nov 2019 10:03:44 -0600
Received: from [10.250.132.49] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA8G3wBg036082;
        Fri, 8 Nov 2019 10:03:58 -0600
Subject: Re: [PATCH v5 3/6] mtd: spi-nor: Extend the SR Read Back test
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191107084135.22122-1-tudor.ambarus@microchip.com>
 <20191107084135.22122-4-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c77ad4df-43f7-7c24-4944-0656d05ec467@ti.com>
Date:   Fri, 8 Nov 2019 21:33:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107084135.22122-4-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07-Nov-19 2:11 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Test that all the bits from Status Register 1 and Status Register 2
> were written correctly.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 58 +++++++++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 06aac894ee6d..d33ad56d3b67 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2047,20 +2047,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  
>  	nor->bouncebuf[0] |= SR_QUAD_EN_MX;
>  
> -	ret = spi_nor_write_sr(nor, nor->bouncebuf, 1);
> -	if (ret)
> -		return ret;
> -
> -	ret = spi_nor_read_sr(nor, nor->bouncebuf);
> -	if (ret)
> -		return ret;
> -
> -	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
> -		dev_dbg(nor->dev, "Macronix Quad bit not set\n");
> -		return -EIO;
> -	}
> -
> -	return 0;
> +	return spi_nor_write_sr1_and_check(nor, nor->bouncebuf[0]);
>  }
>  
>  /**
> @@ -2080,6 +2067,7 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
>  {
>  	u8 *sr_cr = nor->bouncebuf;
>  	int ret;
> +	u8 sr_written;
>  
>  	/* Keep the current value of the Status Register. */
>  	ret = spi_nor_read_sr(nor, sr_cr);
> @@ -2088,7 +2076,22 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
>  
>  	sr_cr[1] = CR_QUAD_EN_SPAN;
>  
> -	return spi_nor_write_sr(nor, sr_cr, 2);
> +	ret = spi_nor_write_sr(nor, sr_cr, 2);
> +	if (ret)
> +		return ret;
> +
> +	sr_written = sr_cr[0];
> +
> +	ret = spi_nor_read_sr(nor, sr_cr);
> +	if (ret)
> +		return ret;
> +
> +	if (sr_cr[0] != sr_written) {
> +		dev_err(nor->dev, "SR: Read back test failed\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> @@ -2108,6 +2111,7 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>  {
>  	u8 *sr_cr = nor->bouncebuf;
>  	int ret;
> +	u8 sr_written;
>  
>  	/* Check current Quad Enable bit value. */
>  	ret = spi_nor_read_cr(nor, &sr_cr[1]);
> @@ -2128,13 +2132,26 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>  	if (ret)
>  		return ret;
>  
> +	sr_written = sr_cr[0];
> +
> +	ret = spi_nor_read_sr(nor, sr_cr);
> +	if (ret)
> +		return ret;
> +
> +	if (sr_written != sr_cr[0]) {
> +		dev_err(nor->dev, "SR: Read back test failed\n");
> +		return -EIO;
> +	}
> +
> +	sr_written = sr_cr[1];
> +
>  	/* Read back and check it. */
>  	ret = spi_nor_read_cr(nor, &sr_cr[1]);
>  	if (ret)
>  		return ret;
>  
> -	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
> -		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
> +	if (sr_cr[1] != sr_written) {
> +		dev_dbg(nor->dev, "CR: Read back test failed\n");
>  		return -EIO;
>  	}
>  
> @@ -2157,6 +2174,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  {
>  	u8 *sr2 = nor->bouncebuf;
>  	int ret;
> +	u8 sr2_written;
>  
>  	/* Check current Quad Enable bit value. */
>  	ret = spi_nor_read_sr2(nor, sr2);
> @@ -2172,13 +2190,15 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  	if (ret)
>  		return ret;
>  
> +	sr2_written = *sr2;
> +
>  	/* Read back and check it. */
>  	ret = spi_nor_read_sr2(nor, sr2);
>  	if (ret)
>  		return ret;
>  
> -	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
> -		dev_dbg(nor->dev, "SR2 Quad bit not set\n");
> +	if (*sr2 != sr2_written) {
> +		dev_dbg(nor->dev, "SR2: Read back test failed\n");
>  		return -EIO;
>  	}
>  
> 
