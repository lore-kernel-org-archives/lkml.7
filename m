Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE29CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2499208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ve07LNiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfJ1Lv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:51:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38182 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfJ1Lv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:51:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9SBojvA027216;
        Mon, 28 Oct 2019 06:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572263446;
        bh=jv9WgwLJhbx+vhz2gcFuPdEfy6XQxWXyLONyfY3NIXY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ve07LNiFspaL3s+gTrd4zsTOxb66vwnfZx5Ty2fbs4hPgORrXKtIC4cnEjy0Acxzk
         4HpvmBEU71ym4M3jrzjk8hED3gKLo8Hi8wZ8eXYrx6IDgxm5oLOLUwdRyGowVg0fvT
         R1u4LUJ2vArieaYpmcCYLcGZS5BiOp1YtBNJ/slQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9SBojji126595;
        Mon, 28 Oct 2019 06:50:45 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 06:50:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 06:50:45 -0500
Received: from [10.250.147.141] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9SBofoR119917;
        Mon, 28 Oct 2019 06:50:42 -0500
Subject: Re: [PATCH 3/3] mtd: spi-nor: Add support for w25q256jw
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <robh+dt@kernel.org>
CC:     <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <darshak.patel@einfochips.com>, <prajose.john@einfochips.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
 <20191024144235.3182-4-manivannan.sadhasivam@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <bf435b43-f118-f3cb-73ed-5fa67905c4aa@ti.com>
Date:   Mon, 28 Oct 2019 17:20:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024144235.3182-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/10/19 8:12 PM, Manivannan Sadhasivam wrote:
> Add MTD support for w25q256jw SPI NOR chip from Winbond. This chip
> supports dual/quad I/O mode with 512 blocks of memory organized in
> 4KB sectors. 

512 blocks of memory organized into 64KB sector, right? In additional
flash also supports 4KB small sector.

Regards
Vignesh

> The device has been validated using Thor96 board.


> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Darshak Patel <darshak.patel@einfochips.com>
> [Mani: cleaned up for upstream]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 1d8621d43160..2c25b371d9f0 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2482,6 +2482,8 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
>  			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
>  			SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
>  
> 
