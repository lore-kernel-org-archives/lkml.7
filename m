Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4662AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAFE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FkgWU285"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfHEGkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:40:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45792 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfHEGkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:40:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x756dp7a081488;
        Mon, 5 Aug 2019 01:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564987191;
        bh=LBLhEib+Vvdjx8rBTm6w8IrgBBnJI0LAgsA5wofhZmw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FkgWU285I+wxRxwscDIfw35p6Tl6i64L4waJGO9TCBJ7MOhn7nvqbQ9jy4fHjB4yb
         PwHDHrZ2RWVBEl0YXIrQ28o55BFVd3nHLC+pooUUHTWPap60LmGFyaHRENHaU6ccsD
         Dvu8jqQVtBK91jAYow/Gq6bXRbkoE51xq+u49TEo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x756dphx013620
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Aug 2019 01:39:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 5 Aug
 2019 01:39:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 5 Aug 2019 01:39:51 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x756dma4058972;
        Mon, 5 Aug 2019 01:39:49 -0500
Subject: Re: [PATCH] mtd: spi-nor: Fix the disabling of write protection at
 init
To:     <Tudor.Ambarus@microchip.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20190731084606.26289-1-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <6bc1b181-a439-77c3-5162-a032a5f21b08@ti.com>
Date:   Mon, 5 Aug 2019 12:10:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731084606.26289-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/19 2:16 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> spi_nor_spansion_clear_sr_bp() depends on spansion_quad_enable().
> While spansion_quad_enable() is selected as default when
> initializing the flash parameters, the nor->quad_enable() method
> can be overwritten later on when parsing BFPT.
> 
> Select the write protection disable mechanism at spi_nor_init() time,
> when the nor->quad_enable() method is already known.
> 
> Fixes: 191f5c2ed4b6faba ("mtd: spi-nor: use 16-bit WRR command when QE is set on spansion flashes")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 924dbaf3fa49..28a64dbdaea9 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -4357,8 +4357,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  		default:
>  			/* Kept only for backward compatibility purpose. */
>  			params->quad_enable = spansion_quad_enable;
> -			if (nor->clear_sr_bp)
> -				nor->clear_sr_bp = spi_nor_spansion_clear_sr_bp;
>  			break;
>  		}
>  
> @@ -4621,6 +4619,9 @@ static int spi_nor_init(struct spi_nor *nor)
>  	int err;
>  
>  	if (nor->clear_sr_bp) {
> +		if (nor->quad_enable == spansion_quad_enable)
> +			nor->clear_sr_bp = spi_nor_spansion_clear_sr_bp;
> +
>  		err = nor->clear_sr_bp(nor);
>  		if (err) {
>  			dev_err(nor->dev,
> 

-- 
Regards
Vignesh
