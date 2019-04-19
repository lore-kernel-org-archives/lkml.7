Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF66C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A71208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDSUjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:39:42 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:36467 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfDSUjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:39:42 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 6E203C0009;
        Fri, 19 Apr 2019 20:39:39 +0000 (UTC)
Date:   Fri, 19 Apr 2019 22:39:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Han Nandor <nandor.han@vaisala.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] rtc: ds3232: get SRAM access using NVMEM Framework
Message-ID: <20190419203939.GG12992@piout.net>
References: <33e0d0d0764c8606dc611721c8c5abe37678675a>
 <20190416105741.11895-1-nandor.han@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416105741.11895-1-nandor.han@vaisala.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2019 10:57:54+0000, Han Nandor wrote:
> DS3232 RTC has 236 bytes of persistent memory.
> 
> Add RTC SRAM read and write access using
> the NVMEM Framework.
> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
> 
> Description
> -----------
> Provides DS3232 RTC SRAM access using NVMEM framework.
> 
> Testing
> -------
> The test was done on a custom board which contains a
> DS3232 RTC device.
> Kernel Version: 4.14.60 (Just for clarity, the patch is against master)
> 
> 1. Verify that SRAM is accessible using NVMEM interface: PASS
> `
> # hexdump /sys/bus/nvmem/devices/ds3232_sram0/nvmem
> 0000000 0000 0000 0000 0000 0000 0000 0000 0000
> *
> 00000e0
> `
> 2. Modify the content.
> `
> # echo testing > /sys/bus/nvmem/devices/ds3232_sram0/nvmem
> #
> `
> 3. Power cycle the board and verify that contents are preserved: PASS
> `
> # hexdump -n 10 -C /sys/bus/nvmem/devices/ds3232_sram0/nvmem
> 00000000  74 65 73 74 69 6e 67 0a  00 00                    |testing...|
> 0000000a
> `
> 
> Testing on Kernel v5.1.0-rc3
> 
> 1. Update `arch/arm/configs/imx_v6_v7_defconfig` to contain
> `CONFIG_RTC_DRV_DS3232=y`
> 2. Verify that building the kernel is successful: PASS
> `
> make ARCH=arm CROSS_COMPILE=arm-linux-gnu- imx_v6_v7_defconfig zImage
> ...
> CC      drivers/rtc/rtc-ds3232.o
> ...
> Kernel: arch/arm/boot/zImage is ready
> `
> 
> Changes since v1
> ----------------
>  - remove the unnecessary header "rtc-core.h"
>  - use nvmem_config from the stack
>  - configure the nvmem type
>  - remove the `of_node` configuration
> 
> Changes since v2
> ----------------
>  - init unused struct nvmem_cfg members to 0
>  - use regmap as private data to nvmem struct
> 
>  drivers/rtc/rtc-ds3232.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
