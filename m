Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108F3C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC94E2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="diACuOPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388745AbfKEMhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:37:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33228 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbfKEMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:37:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA5CbLMS048959;
        Tue, 5 Nov 2019 06:37:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572957441;
        bh=cCmaD8eE1fK00Mnm1DnRD4gZ7GKdETqTugixTFFcrzg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=diACuOPt/3Wh00a89YIc7Lb+EGZsAPs7USi6bPr+jRWny31oN8C2rM0UtOd8zbNWV
         TVkOA1GsSZmHBDMHJKmSew2EDEkX1CdEkyqDExZvzRY1kcocVyYaZfVxvSaQVdVUu+
         rVQJR8dQiWBVlSBpAaeOZeRkttQ5e3Bko/BW0Lmo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5CbLr8094660;
        Tue, 5 Nov 2019 06:37:21 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 5 Nov
 2019 06:37:06 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 5 Nov 2019 06:37:06 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA5CbI4m052932;
        Tue, 5 Nov 2019 06:37:19 -0600
Subject: Re: [PATCH v4 12/20] mtd: spi-nor: Print debug message when the read
 back test fails
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
 <20191102112316.20715-13-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9474c875-94a1-3d19-ddab-b90d352967a9@ti.com>
Date:   Tue, 5 Nov 2019 18:07:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102112316.20715-13-tudor.ambarus@microchip.com>
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
> Demystify where the EIO error occurs.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

I think this is a small enough change that can be squashed into previous
patch itself

>  drivers/mtd/spi-nor/spi-nor.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 8f5e9833081b..725dab241271 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -974,7 +974,12 @@ static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new)
>  	if (ret)
>  		return ret;
>  
> -	return (nor->bouncebuf[0] != status_new) ? -EIO : 0;
> +	if (nor->bouncebuf[0] != status_new) {
> +		dev_dbg(nor->dev, "SR: read back test failed\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> 

-- 
Regards
Vignesh
