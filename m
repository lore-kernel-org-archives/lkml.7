Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD8AC010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F1F21D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oJ5m4d/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbfKEMfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33070 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfKEMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:35:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5CZVnu048667;
        Tue, 5 Nov 2019 06:35:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572957331;
        bh=8/LkuZqw2Fwss/j34lhjzcKYqZ/5qbKCBCN7h5aUhg4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oJ5m4d/LfKKiT4iFU3jWjs5/e2RAvAPV7m+fnD//K8usy15wstncvQH9wUWN5Wh6Z
         1b4bGnfcKDucrflHH2ekxRClvAAwgUtpsLmIewYWdfumt76v+Wamg8q45iUnOGk86z
         tVfGhd5CE9i0mzDJchw0ShIqM8YCTKTvZJiu2/2o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5CZVBV070292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 06:35:31 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 06:35:16 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 5 Nov 2019 06:35:16 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5CZS6x112873;
        Tue, 5 Nov 2019 06:35:29 -0600
Subject: Re: [PATCH v4 10/20] mtd: spi-nor: Fix errno on Quad Enable methods
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-11-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9c742bb8-3675-5f7a-519e-540471c1969f@ti.com>
Date:   Tue, 5 Nov 2019 18:06:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-11-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/19 4:53 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> When the Read-Modify-Write-Read-Back Quad Enable methods failed on
> the Read-Back, they returned -EINVAL. Since this is an I/O error,
> return -EIO.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index f5193733a0f6..14146619bf19 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1964,7 +1964,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
>  
>  	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
>  		dev_dbg(nor->dev, "Macronix Quad bit not set\n");
> -		return -EINVAL;
> +		return -EIO;
>  	}
>  
>  	return 0;
> @@ -2042,7 +2042,7 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
>  
>  	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
>  		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
> -		return -EINVAL;
> +		return -EIO;
>  	}
>  
>  	return 0;
> @@ -2086,7 +2086,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  
>  	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
>  		dev_dbg(nor->dev, "SR2 Quad bit not set\n");
> -		return -EINVAL;
> +		return -EIO;
>  	}
>  
>  	return 0;
> 

-- 
Regards
Vignesh
