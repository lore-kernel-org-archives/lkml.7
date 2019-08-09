Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA54C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA25208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="krfxRCrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406593AbfHILfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:35:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48976 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHILfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:35:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79BYvKo068148;
        Fri, 9 Aug 2019 06:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565350497;
        bh=0BMlv1o/BjXl7KrAZmoe5OBOTIqcoyjR0RPjS96IGjo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=krfxRCrvQqZqaFVYFFYuCpxAzZ9IEu9mlirFp+lPozaMGcoepKvSWZAqddF7x0JOX
         LrDQlvkVmF8qnhmE+S/9X41Gn8sYUUGKFTyfEAk4rgm015fIiQuatwALRjuJaYmb0F
         QOk/lKAPLXboZOqc6ZF4tbElqtA6xT+jDHdNJQvI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79BYv5h059450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 06:34:57 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 06:34:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 06:34:56 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79BYqSe001362;
        Fri, 9 Aug 2019 06:34:53 -0500
Subject: Re: [PATCH v7 2/4] mtd: spi-nor: fix nor->addr_width for is25wp256
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        <marek.vasut@gmail.com>, <tudor.ambarus@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <paul.walmsley@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
 <1562092745-11541-3-git-send-email-sagar.kadam@sifive.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <5d1d10be-d01f-51ca-0a08-c5a52cd467b9@ti.com>
Date:   Fri, 9 Aug 2019 17:05:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562092745-11541-3-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/19 12:09 AM, Sagar Shrikant Kadam wrote:
> Use the post bfpt fixup hook for the is25wp256 device as done for
> is25lp256 device to overwrite the address width advertised by BFPT.
> 
> For instance the standard devices eg: IS25WP256D-JMLE where J stands
> for "standard" does not support SFDP.
> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  drivers/mtd/spi-nor/spi-nor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 971f0f3..315eeec 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1860,7 +1860,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			SPI_NOR_4B_OPCODES)
> -	},
> +			.fixups = &is25lp256_fixups },
>  	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
>  	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
> 

-- 
Regards
Vignesh
