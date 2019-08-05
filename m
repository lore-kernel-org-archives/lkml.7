Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B48C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054CE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KQCe62tX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfHEFNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 01:13:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43390 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfHEFNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 01:13:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x755DX7t000360;
        Mon, 5 Aug 2019 00:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564982013;
        bh=ewdIibSSQijgwi+dlHIsVHF2PIynzZcDv3GyCZ5qoao=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KQCe62tXWVeGrSrKB9tF8y+nwKb2Sh5uurchqHfP8F1fhvgx+d8cxZ3C/x1g2gzah
         kWUoh9JEucHPLlqgW/DWzGz7rGPZgbSlup4Q/HHYAMBF3fnKJDVCxndejSz8FioivS
         XC6GeUq/5BAR/0Pk7Dxj1fIG2oFeVjvzZxFidgX8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x755DXbQ036738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 00:13:33 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 00:13:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 00:13:32 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x755DT5L104396;
        Mon, 5 Aug 2019 00:13:30 -0500
Subject: Re: [PATCH 6/6] mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
 <20190731091145.27374-7-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <93dc5a5d-3a72-c80e-0b0d-7fd758a1ea5e@ti.com>
Date:   Mon, 5 Aug 2019 10:44:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731091145.27374-7-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/19 2:42 PM, Tudor.Ambarus@microchip.com wrote:
> From: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> S3AN flashes use a specific opcode to read the status register.
> We currently use the SPI_S3AN flag to decide whether this specific
> SR read opcode should be used, but SPI_S3AN is about to disappear, so
> let's add a new flag.
> 

I think you can drop SPI_S3AN right away either as separate patch in
this series or as part of this patch itself.

Regards
Vignesh

> Note that we use the same bit as SPI_S3AN implies SPI_NOR_XSR_RDY and
> vice versa.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 5fea5d7ce2cb..01be6d49ce3b 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -213,6 +213,14 @@ struct flash_info {
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
> @@ -4818,7 +4826,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	 * spi_nor_wait_till_ready(). Xilinx S3AN share MFR
>  	 * with Atmel spi-nor
>  	 */
> -	if (info->flags & SPI_S3AN)
> +	if (info->flags & SPI_NOR_XSR_RDY)
>  		nor->flags |=  SNOR_F_READY_XSR_RDY;
>  
>  	/* Kept only for backward compatibility purpose. */
> 

-- 
Regards
Vignesh
