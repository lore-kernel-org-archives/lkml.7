Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A178C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F422084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i+07IQiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfDBGft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:35:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50296 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfDBGft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:35:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x326ZfNl043826;
        Tue, 2 Apr 2019 01:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554186941;
        bh=HTjMvbYhszDsh9wAemiBc4VWJwjGHUCoqh5TnYUrZWY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i+07IQiGDG8M3y9IV9pnKewA7I/32MTVyC1vscCLlVsBwF2wCXOUcIwpKZq/ILDtL
         yvpwGRTRa/Ka69WogUKKUNq96rTksdGavXnef1FsiiWPJ3Jy7pEcO7xGzWY9boe2o5
         aq75OsR+9fb2cyefoBfoKwN4cLdjTVVl8D5URum4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x326Zfew082278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 01:35:41 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 01:35:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 01:35:40 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x326ZbKi054265;
        Tue, 2 Apr 2019 01:35:38 -0500
Subject: Re: [PATCH 1/3] mtd: devices: m25p80: Simplify m25p80_read()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <linux-mtd@lists.infradead.org>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20190401044938.31237-1-andrew.smirnov@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <72cf37d0-e0b8-a02c-1626-46f342cc72bd@ti.com>
Date:   Tue, 2 Apr 2019 12:06:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401044938.31237-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/04/19 10:19 AM, Andrey Smirnov wrote:
> Spi_nor_read() already has an appropriate loop around .read() callback
> to handle the case when not all of the data requested was written in a
> signle ->read() call. Drop extra code doing the same thing in
> m25p80_read().
> 

Thanks for the patch series! But we are in the process of completely
moving m25p80.c into spi-nor.c which should take care of this series.
See[1][2], I plan to post the next version shortly. Let me know if
something is missing.

[1] https://patchwork.ozlabs.org/patch/982925/
[2] https://patchwork.ozlabs.org/patch/982922/

Regards
Vignesh

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mtd/devices/m25p80.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 651bab6d4e31..114f8ccea85b 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -125,7 +125,6 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
>  				   SPI_MEM_OP_ADDR(nor->addr_width, from, 1),
>  				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
>  				   SPI_MEM_OP_DATA_IN(len, buf, 1));
> -	size_t remaining = len;
>  	int ret;
>  
>  	/* get transfer protocols. */
> @@ -137,22 +136,15 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
>  	/* convert the dummy cycles to the number of bytes */
>  	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
>  
> -	while (remaining) {
> -		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
> -		ret = spi_mem_adjust_op_size(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> -
> -		ret = spi_mem_exec_op(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> +	ret = spi_mem_adjust_op_size(flash->spimem, &op);
> +	if (ret)
> +		return ret;
>  
> -		op.addr.val += op.data.nbytes;
> -		remaining -= op.data.nbytes;
> -		op.data.buf.in += op.data.nbytes;
> -	}
> +	ret = spi_mem_exec_op(flash->spimem, &op);
> +	if (ret)
> +		return ret;
>  
> -	return len;
> +	return op.data.nbytes;
>  }
>  
>  /*
> 

-- 
Regards
Vignesh
