Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268C1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DA921E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B7V4WtUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbfHGQZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:25:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47466 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbfHGQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:25:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77GOf0D107164;
        Wed, 7 Aug 2019 11:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565195081;
        bh=Rd7DS5JXyHAAq1zmDNMB/zcMDAc9CvS8qijx51VvoE4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=B7V4WtUqCJKRhb8XCc+VDGs9BPnK8H9DPPO+JOynJn9NdS6J/ZooZPjWG2DTZ7OmS
         MUHiWChnP2fE2N5RAHHnWDa+aQK6/JP/YWuqR4M7+r9IeYfGXZ/wlrq499Q0VkJy/r
         c5ZJFeGC2x47zrH51wD09nxj5blpGvLibc5g9HZs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77GOfOS058892
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 11:24:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 11:24:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 11:24:41 -0500
Received: from [10.250.132.50] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77GObFI102314;
        Wed, 7 Aug 2019 11:24:38 -0500
Subject: Re: [PATCH v2 5/5] mtd: spi-nor: add Kconfig option to disable write
 protection at power-up
To:     <Tudor.Ambarus@microchip.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
References: <0fc5d3bb-aa11-2816-4734-75dc86deb0d2@microchip.com>
 <20190717113047.32596-1-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <0ea41a21-a1bb-9d19-f739-8e6ccdd6a421@ti.com>
Date:   Wed, 7 Aug 2019 21:54:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717113047.32596-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tudor

On 17-Jul-19 5:00 PM, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
[...]
> 
>  drivers/mtd/spi-nor/Kconfig   | 8 ++++++++
>  drivers/mtd/spi-nor/spi-nor.c | 7 +++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index 6de83277ce8b..b550e10657f1 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -22,6 +22,14 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>  	  Please note that some tools/drivers/filesystems may not work with
>  	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
>  
> +config MTD_SPI_NOR_DISABLE_POWER_UP_WRITE_PROTECTION
> +	bool "Disable write protection during power-up"
> +	default y
> +	help
> +	   Some spi-nor flashes are write protected by default after a power-on
> +	   reset cycle, in order to avoid inadvertend writes during power-up.
> +	   Disable the write protection during power-up.
> +


Hmm, how about setting MTD_POWERUP_LOCK flag in mtd->flags whenever
flash powers up with WP enabled? User can disable WP by declaring
partitions rw or keep partitions locked with ro. MTD core takes care of
calling mtd->unlock() depending up on the rw/ro flag as part of
add_mtd_device()

We could probably enhance spi_nor_unlock() to use
spi_nor_unlock_global_block_protection() when asked to unlock entire flash.

Kconfig option does not scale well for multi-platform build. There would
not be a way to have WP enabled on one platform but disabled on other.


Regards
Vignesh

>  config SPI_ASPEED_SMC
>  	tristate "Aspeed flash controllers in SPI mode"
>  	depends on ARCH_ASPEED || COMPILE_TEST
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index ffb53740031c..9b948295ef27 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1684,7 +1684,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> -static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
> +static int __maybe_unused spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
>  {
>  	int ret;
>  	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
> @@ -1726,7 +1726,8 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
>  	return spi_nor_clear_sr_bp(nor);
>  }
>  
> -static int spi_nor_unlock_global_block_protection(struct spi_nor *nor)
> +static int __maybe_unused
> +spi_nor_unlock_global_block_protection(struct spi_nor *nor)
>  {
>  	int ret;
>  
> @@ -4049,6 +4050,7 @@ static int spi_nor_init(struct spi_nor *nor)
>  {
>  	int err;
>  
> +#ifdef CONFIG_MTD_SPI_NOR_DISABLE_POWER_UP_WRITE_PROTECTION
>  	/*
>  	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
>  	 * with the software protection bits set.
> @@ -4082,6 +4084,7 @@ static int spi_nor_init(struct spi_nor *nor)
>  			return err;
>  		}
>  	}
> +#endif
>  
>  	if (nor->quad_enable) {
>  		err = nor->quad_enable(nor);
> 
