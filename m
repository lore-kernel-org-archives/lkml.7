Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C52C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CC921882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t4XqoUa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbfKEQFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:05:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60646 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390011AbfKEQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:05:54 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5G5ZO6077804;
        Tue, 5 Nov 2019 10:05:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572969935;
        bh=ifqGbh2iK7gCjM34CfaUPg5dKbqv4hsuWqKdYPnSGWk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t4XqoUa1Q9IdKhWKcc6jvYqDlwYyx4v5DZ3z0peERQoohVdGZV5Ufg0o9wY0WMC4c
         dOoGP67ABI4bj8rK4RvJM74wEg60Ot0kYz16J94+YBY1QXgiJsSFg+ONC7c59sJmcX
         TNoZKvFnqWk3Xc1ydxGkAUYem8z1NzM0T6/rHuok=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA5G5Z4T110661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Nov 2019 10:05:35 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 5 Nov
 2019 10:05:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 10:05:20 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5G5W4W081978;
        Tue, 5 Nov 2019 10:05:33 -0600
Subject: Re: [PATCH v4 15/20] mtd: spi-nor: Extend the QE Read Back test to
 both SR1 and SR2
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-16-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b9a4e491-d081-1325-1532-b392f55fcaf9@ti.com>
Date:   Tue, 5 Nov 2019 21:36:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-16-tudor.ambarus@microchip.com>
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
> In case of 16-bit Write Status Register, check that both SR1 and
> SR2 were written correctly.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

This can be merged with previous patch as changes are quite similar

Regards
Vignesh

>  drivers/mtd/spi-nor/spi-nor.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 08fd2c97897d..8f11c00e8ae5 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2067,6 +2067,7 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
>  {
>  	u8 *sr_cr = nor->bouncebuf;
>  	int ret;
> +	u8 sr_written;
>  
>  	/* Keep the current value of the Status Register. */
>  	ret = spi_nor_read_sr(nor, sr_cr);
> @@ -2075,7 +2076,22 @@ static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
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
> @@ -2116,6 +2132,17 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
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
>  	sr_written = sr_cr[1];
>  
>  	/* Read back and check it. */
> 

-- 
Regards
Vignesh
