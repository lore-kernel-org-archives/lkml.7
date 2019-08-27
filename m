Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E219C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411E620828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lxivtr3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfH0HsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:48:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37550 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbfH0HsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:48:20 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R7m55l011401;
        Tue, 27 Aug 2019 02:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566892085;
        bh=DAEmQY6ZcVPLUHgDx6bVO328R5BPWYgZs0CQXt41clQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lxivtr3CCfY0WlrlGLRWdOIV9dw5+vpZGkk3YRQzrzS2UlmwSFwA+XOXykYongFPl
         gdXC7uNpZpQbaJxS3KpGkUQxljzhjCk34FUubsAv4YqhTAqjdbsfDvcNzJeSgOaI23
         8fqld3gxFatQZaCBUMOOW4xZocdC2nnp9TxcYXSU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R7m58Y116885
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 02:48:05 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 02:48:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 02:48:05 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R7m0h6129701;
        Tue, 27 Aug 2019 02:48:02 -0500
Subject: Re: [RESEND PATCH v3 16/20] mtd: spi-nor: Add the SPI_NOR_XSR_RDY
 flag
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-17-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <6c4c1b43-426d-75c9-126d-f60c0af0e956@ti.com>
Date:   Tue, 27 Aug 2019 13:18:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-17-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/19 5:39 PM, Tudor.Ambarus@microchip.com wrote:
> From: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> S3AN flashes use a specific opcode to read the status register.
> We currently use the SPI_S3AN flag to decide whether this specific
> SR read opcode should be used, but SPI_S3AN is about to disappear, so
> let's add a new flag.
> 
> Note that we use the same bit as SPI_S3AN implies SPI_NOR_XSR_RDY and
> vice versa.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

> v3: no changes
> 
>  drivers/mtd/spi-nor/spi-nor.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index edf1c8badac9..2699e999d21a 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -211,6 +211,14 @@ struct flash_info {
>  					 * bit. Must be used with
>  					 * SPI_NOR_HAS_LOCK.
>  					 */
> +#define SPI_NOR_XSR_RDY		BIT(10)	/*
> +					 * S3AN flashes have specific opcode to
> +					 * read the status register.
> +					 * Flags SPI_NOR_XSR_RDY and SPI_S3AN
> +					 * use the same bit as one implies the
> +					 * other, but we will get rid of
> +					 * SPI_S3AN soon.
> +					 */
>  #define	SPI_S3AN		BIT(10)	/*
>  					 * Xilinx Spartan 3AN In-System Flash
>  					 * (MFR cannot be used for probing
> @@ -4798,7 +4806,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	 * spi_nor_wait_till_ready(). Xilinx S3AN share MFR
>  	 * with Atmel spi-nor
>  	 */
> -	if (info->flags & SPI_S3AN)
> +	if (info->flags & SPI_NOR_XSR_RDY)
>  		nor->flags |=  SNOR_F_READY_XSR_RDY;
>  
>  	if (info->flags & SPI_NOR_HAS_LOCK)
> 

-- 
Regards
Vignesh
