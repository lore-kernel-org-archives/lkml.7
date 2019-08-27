Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61580C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4E620828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wUk9ilqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfH0Fc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:32:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55154 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0Fc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:32:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R5WmOf083296;
        Tue, 27 Aug 2019 00:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566883968;
        bh=ZOBbzQh94UfeCL8yLtF+6xVYeEmFxPdI6e7CvV3hTzM=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=wUk9ilqktGaFxEiH/+rKN+HVtB8E02XJGpfhA6usfpIxMXXvauQ+7lPgSHfLmFoTL
         irrUt+o7acSoP3nGXvLgGBELUgnBeguDj4Et8fj5iKMzdMKPfi4mSpVVkTCIlDObdV
         4Et5BEKHeDTL5DN/3xB5/Bad5Awulaf9Edum5TPs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R5Wm33103738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Aug 2019 00:32:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 27
 Aug 2019 00:32:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 27 Aug 2019 00:32:48 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R5Wird016346;
        Tue, 27 Aug 2019 00:32:45 -0500
Subject: Re: [RESEND PATCH v3 00/20] mtd: spi-nor: move manuf out of the core
To:     <Tudor.Ambarus@microchip.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c70b4cc8-466d-3b20-2b0c-ff456f1b7b97@ti.com>
Date:   Tue, 27 Aug 2019 11:03:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826120821.16351-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/08/19 5:38 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
[...]
> 
> Tested on sst26vf064b with atmel-quadspi SPIMEM driver.
> 

Tested s25fl256s, mx66l51235l with ti-qspi and s25fl512s with
cadence-quadspi. n25q128a13 with legacy 1 bit SPI controller.

> Boris Brezillon (7):
>   mtd: spi-nor: Add a default_init() fixup hook for gd25q256
>   mtd: spi-nor: Create a ->set_4byte() method
>   mtd: spi-nor: Rework the SPI NOR lock/unlock logic
>   mtd: spi-nor: Add post_sfdp() hook to tweak flash config
>   mtd: spi-nor: Add spansion_post_sfdp_fixups()
>   mtd: spi-nor: Add a ->convert_addr() method
>   mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag
> 
> Tudor Ambarus (13):
>   mtd: spi-nor: Regroup flash parameter and settings
>   mtd: spi-nor: Use nor->params
>   mtd: spi-nor: Drop quad_enable() from 'struct spi-nor'
>   mtd: spi-nor: Move erase_map to 'struct spi_nor_flash_parameter'
>   mtd: spi-nor: Add default_init() hook to tweak flash parameters
>   mtd: spi_nor: Move manufacturer quad_enable() in ->default_init()
>   mtd: spi-nor: Split spi_nor_init_params()
>   mtd: spi_nor: Add a ->setup() method
>   mtd: spi-nor: Add s3an_post_sfdp_fixups()
>   mtd: spi-nor: Bring flash params init together
>   mtd: spi_nor: Introduce spi_nor_set_addr_width()
>   mtd: spi-nor: Introduce spi_nor_get_flash_info()
>   mtd: spi-nor: Rework the disabling of block write protection
> 
>  drivers/mtd/spi-nor/spi-nor.c | 1304 +++++++++++++++++++++++------------------
>  include/linux/mtd/spi-nor.h   |  298 +++++++---
>  2 files changed, 927 insertions(+), 675 deletions(-)
> 

-- 
Regards
Vignesh
