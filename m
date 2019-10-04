Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1F6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B5820873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s5zIP7p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390399AbfJDQHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:07:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58858 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390128AbfJDQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:07:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x94G6tgi076297;
        Fri, 4 Oct 2019 11:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570205215;
        bh=BsWmvlcQuJmrgH47mTCBTA5XIa3Tj4rOkLTCsDrH5lI=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=s5zIP7p/cygckP402n3In5MDCx6l9VOg6OJ0y+y3FVaUzY6kIrV4NAtkgQw6BkLZ9
         MLnBvtxoDIQJ6Fk8TPW0GV8SZVEoOLZVuJxHv8dkzoX8MJXnzC3SCsbhmoi9rtCyHn
         b2ktdoIQEN6w0B9xUzQZbtD8QMtetWQauCVBPRdU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x94G6tso024225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Oct 2019 11:06:55 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 4 Oct
 2019 11:06:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 4 Oct 2019 11:06:55 -0500
Received: from [10.250.132.26] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x94G6qn9059591;
        Fri, 4 Oct 2019 11:06:53 -0500
Subject: Re: [PATCH] mtd: spi-nor: Fix direction of the write_sr() transfer
To:     <Tudor.Ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <john.garry@huawei.com>
References: <c703dec2-dd11-5898-83ad-fb06127b6575@huawei.com>
 <20191004104746.23537-1-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3a09e103-a705-7e4c-6b75-82a928cac2d6@ti.com>
Date:   Fri, 4 Oct 2019 21:36:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004104746.23537-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04-Oct-19 4:17 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> write_sr() sends data to the SPI memory, fix the direction.
> 
> Fixes: b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
> Reported-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Thanks for the quick fix!

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 1d8621d43160..7acf4a93b592 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -487,7 +487,7 @@ static int write_sr(struct spi_nor *nor, u8 val)
>  			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
>  				   SPI_MEM_OP_NO_ADDR,
>  				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> +				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
>  
>  		return spi_mem_exec_op(nor->spimem, &op);
>  	}
> 
