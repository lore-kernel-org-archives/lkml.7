Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1F0C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CF32464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfLELVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:21:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729017AbfLELVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:21:24 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7FD9DD56C9737AD06B31;
        Thu,  5 Dec 2019 11:21:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 5 Dec 2019 11:21:22 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Thu, 5 Dec 2019
 11:21:21 +0000
Subject: Re: [PATCH 3/3] mtd: spi-nor: Add USE_FSR flag for n25q* entries
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20191205065935.5727-1-vigneshr@ti.com>
 <20191205065935.5727-4-vigneshr@ti.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <36213198-a09c-a969-1f57-092e0fb7cd68@huawei.com>
Date:   Thu, 5 Dec 2019 11:21:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191205065935.5727-4-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2019 06:59, Vignesh Raghavendra wrote:
> Add USE_FSR flag to all variants of n25q entries that support Flag Status
> Register.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Tested-by: John Garry <john.garry@huawei.com> #for n25q128a13

> ---
>   drivers/mtd/spi-nor/spi-nor.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index a5cb647378f0..1082b6bb1393 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2454,16 +2454,21 @@ static const struct flash_info spi_nor_ids[] = {
>   	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
>   	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
>   	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
> -	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
> -	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
> +	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K |
> +			      USE_FSR | SPI_NOR_QUAD_READ) },
> +	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K |
> +			      USE_FSR | SPI_NOR_QUAD_READ) },
>   	{ "mt25ql256a",  INFO6(0x20ba19, 0x104400, 64 * 1024,  512,
>   			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>   			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> -	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
> +			      USE_FSR | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },
>   	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
>   			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>   			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> -	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
> +	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K |
> +			      USE_FSR | SPI_NOR_QUAD_READ) },
>   	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024,
>   			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>   			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> @@ -2472,7 +2477,7 @@ static const struct flash_info spi_nor_ids[] = {
>   			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>   			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K |
> -			      SPI_NOR_QUAD_READ) },
> +			      USE_FSR | SPI_NOR_QUAD_READ) },
>   	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>   	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>   	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
> 

