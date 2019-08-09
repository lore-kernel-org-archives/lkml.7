Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E428EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A82208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TMFOedF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406560AbfHILe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:34:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34794 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfHILeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:34:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79BXp2W103086;
        Fri, 9 Aug 2019 06:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565350431;
        bh=DXv/jQeoUgS/jLmVHHjMH1IRgDVmsq4gwr/8uuGGdBQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TMFOedF/iy9Y8Y2M+fSQrQ89aXeGFUuT/AlY+DphI4DUdVvzFsm+/Vu2URSw0jDh3
         KQ1GMeXkdHEjzu1xuoftDGiZsb9V6gxDAU3BGygFlur9P1lvDKLhnk2P33b8BMa542
         +pcnyIjRpEaGQZVd2iOFq6ABf+nDLFych41oswOc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79BXpUs044281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 06:33:51 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 06:33:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 06:33:51 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79BXlD6078973;
        Fri, 9 Aug 2019 06:33:47 -0500
Subject: Re: [PATCH v7 1/4] mtd: spi-nor: add support for is25wp256
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        <marek.vasut@gmail.com>, <tudor.ambarus@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>
CC:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <paul.walmsley@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
 <1562092745-11541-2-git-send-email-sagar.kadam@sifive.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c193950a-ddd9-cf8e-0694-eeb91b994729@ti.com>
Date:   Fri, 9 Aug 2019 17:04:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1562092745-11541-2-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/19 12:09 AM, Sagar Shrikant Kadam wrote:
> Update spi_nor_id table for is25wp256 (32MB) device from ISSI,
> present on HiFive Unleashed dev board (Rev: A00).
> 
> Set method to enable quad mode for ISSI device in flash parameters
> table.
> 
> Based on code originally written by Wesley Terpstra <wesley@sifive.com>
> and/or Palmer Dabbelt <palmer@sifive.com>
> https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b
> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


>  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++++-
>  include/linux/mtd/spi-nor.h   | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index e3a28c0..971f0f3 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1857,7 +1857,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -
> +	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			SPI_NOR_4B_OPCODES)
> +	},
>  	/* Macronix */
>  	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
>  	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
> @@ -3687,6 +3690,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  		case SNOR_MFR_ST:
>  		case SNOR_MFR_MICRON:
>  			break;
> +		case SNOR_MFR_ISSI:
> +			params->quad_enable = macronix_quad_enable;
> +			break;
> +
>  
>  		default:
>  			/* Kept only for backward compatibility purpose. */
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index b3d360b..b0e42b3 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -21,6 +21,7 @@
>  #define SNOR_MFR_INTEL		CFI_MFR_INTEL
>  #define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
>  #define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
> +#define SNOR_MFR_ISSI		0x9d		/* ISSI */
>  #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
>  #define SNOR_MFR_SPANSION	CFI_MFR_AMD
>  #define SNOR_MFR_SST		CFI_MFR_SST
> 

-- 
Regards
Vignesh
