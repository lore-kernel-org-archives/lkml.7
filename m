Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102D6CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5259222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 14:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfJSO1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 10:27:11 -0400
Received: from shell.v3.sk ([90.176.6.54]:54118 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfJSO1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:27:11 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Oct 2019 10:27:09 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B22B34F1C0;
        Sat, 19 Oct 2019 16:20:26 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DjxP6GpsWBXi; Sat, 19 Oct 2019 16:20:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7EC60501B1;
        Sat, 19 Oct 2019 16:20:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6LVNgAAGEd2u; Sat, 19 Oct 2019 16:20:12 +0200 (CEST)
Received: from nedofet.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D9D2B4F1C0;
        Sat, 19 Oct 2019 16:20:10 +0200 (CEST)
Message-ID: <4d6920e9fab519ddf69aae9da13a1cd02d13bddd.camel@v3.sk>
Subject: Re: [PATCH 44/46] ARM: mmp: remove tavorevb board support
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Oct 2019 16:20:07 +0200
In-Reply-To: <20191018154201.1276638-44-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
         <20191018154201.1276638-44-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 (3.34.0-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-18 at 17:41 +0200, Arnd Bergmann wrote:
> There are two tavorevb boards in the kernel, one using a PXA930 chip in
> mach-pxa, and one using the later PXA910 chip in mach-mmp.  They use the
> same board number, which is generally a bad idea, and in a multiplatform
> kernel, we can end up with funny link errors like this one resulting
> from two boards gettting controlled by the same Kconfig symbol:
> 
> arch/arm/mach-mmp/tavorevb.o: In function `tavorevb_init':
> tavorevb.c:(.init.text+0x4c): undefined reference to `pxa910_device_uart1'
> tavorevb.c:(.init.text+0x50): undefined reference to `pxa910_device_gpio'
> tavorevb.o:(.arch.info.init+0x54): undefined reference to `pxa910_init_irq'
> tavorevb.o:(.arch.info.init+0x58): undefined reference to `pxa910_timer_init'
> 
> The mach-pxa TavorEVB seems much more complete than the mach-mmp one
> that supports only uart, gpio and ethernet. Further, I could find no
> information about the board on the internet aside from references to
> the Linux kernel, so I assume this was never available outside of Marvell
> and can be removed entirely.
> 
> There is a third board named TavorEVB in the Kconfig description,
> but this refers to the "TTC_DKB" machine. The two are clearly
> related, so I change the Kconfig description to just list both
> names.
> 
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

In fact, I'd love to see more non-DT boards go from mach-mmp. There are
good indications nobody is looking after MMP2-based "Jasper", "Flint"
and "Brownstone" and they probably weren't seen outside Marvell either.
The latter has a DTS file.

Would anybody miss them?

Thanks
Lubo

> ---
>  arch/arm/mach-mmp/Kconfig    |  10 +---
>  arch/arm/mach-mmp/Makefile   |   1 -
>  arch/arm/mach-mmp/tavorevb.c | 113 -----------------------------------
>  3 files changed, 1 insertion(+), 123 deletions(-)
>  delete mode 100644 arch/arm/mach-mmp/tavorevb.c
> 
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index 0440109e973b..fc8cbe0064ae 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -39,16 +39,8 @@ config MACH_AVENGERS_LITE
>  	  Say 'Y' here if you want to support the Marvell PXA168-based
>  	  Avengers Lite Development Board.
>  
> -config MACH_TAVOREVB
> -	bool "Marvell's PXA910 TavorEVB Development Board"
> -	depends on ARCH_MULTI_V5
> -	select CPU_PXA910
> -	help
> -	  Say 'Y' here if you want to support the Marvell PXA910-based
> -	  TavorEVB Development Board.
> -
>  config MACH_TTC_DKB
> -	bool "Marvell's PXA910 TavorEVB Development Board"
> +	bool "Marvell's PXA910 TavorEVB/TTC_DKB Development Board"
>  	depends on ARCH_MULTI_V5
>  	select CPU_PXA910
>  	help
> diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
> index 8f267c7bc6e8..0dc07e1f3196 100644
> --- a/arch/arm/mach-mmp/Makefile
> +++ b/arch/arm/mach-mmp/Makefile
> @@ -27,7 +27,6 @@ endif
>  obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
>  obj-$(CONFIG_MACH_ZYLONITE2)	+= aspenite.o
>  obj-$(CONFIG_MACH_AVENGERS_LITE)+= avengers_lite.o
> -obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
>  obj-$(CONFIG_MACH_TTC_DKB)	+= ttc_dkb.o
>  obj-$(CONFIG_MACH_BROWNSTONE)	+= brownstone.o
>  obj-$(CONFIG_MACH_FLINT)	+= flint.o
> diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
> deleted file mode 100644
> index 3261d2322198..000000000000
> --- a/arch/arm/mach-mmp/tavorevb.c
> +++ /dev/null
> @@ -1,113 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/arch/arm/mach-mmp/tavorevb.c
> - *
> - *  Support for the Marvell PXA910-based TavorEVB Development Platform.
> - */
> -#include <linux/gpio.h>
> -#include <linux/gpio-pxa.h>
> -#include <linux/init.h>
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/smc91x.h>
> -
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include "addr-map.h"
> -#include "mfp-pxa910.h"
> -#include "pxa910.h"
> -#include "irqs.h"
> -
> -#include "common.h"
> -
> -static unsigned long tavorevb_pin_config[] __initdata = {
> -	/* UART2 */
> -	GPIO47_UART2_RXD,
> -	GPIO48_UART2_TXD,
> -
> -	/* SMC */
> -	SM_nCS0_nCS0,
> -	SM_ADV_SM_ADV,
> -	SM_SCLK_SM_SCLK,
> -	SM_SCLK_SM_SCLK,
> -	SM_BE0_SM_BE0,
> -	SM_BE1_SM_BE1,
> -
> -	/* DFI */
> -	DF_IO0_ND_IO0,
> -	DF_IO1_ND_IO1,
> -	DF_IO2_ND_IO2,
> -	DF_IO3_ND_IO3,
> -	DF_IO4_ND_IO4,
> -	DF_IO5_ND_IO5,
> -	DF_IO6_ND_IO6,
> -	DF_IO7_ND_IO7,
> -	DF_IO8_ND_IO8,
> -	DF_IO9_ND_IO9,
> -	DF_IO10_ND_IO10,
> -	DF_IO11_ND_IO11,
> -	DF_IO12_ND_IO12,
> -	DF_IO13_ND_IO13,
> -	DF_IO14_ND_IO14,
> -	DF_IO15_ND_IO15,
> -	DF_nCS0_SM_nCS2_nCS0,
> -	DF_ALE_SM_WEn_ND_ALE,
> -	DF_CLE_SM_OEn_ND_CLE,
> -	DF_WEn_DF_WEn,
> -	DF_REn_DF_REn,
> -	DF_RDY0_DF_RDY0,
> -};
> -
> -static struct pxa_gpio_platform_data pxa910_gpio_pdata = {
> -	.irq_base	= MMP_GPIO_TO_IRQ(0),
> -};
> -
> -static struct smc91x_platdata tavorevb_smc91x_info = {
> -	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
> -};
> -
> -static struct resource smc91x_resources[] = {
> -	[0] = {
> -		.start	= SMC_CS1_PHYS_BASE + 0x300,
> -		.end	= SMC_CS1_PHYS_BASE + 0xfffff,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= MMP_GPIO_TO_IRQ(80),
> -		.end	= MMP_GPIO_TO_IRQ(80),
> -		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
> -	}
> -};
> -
> -static struct platform_device smc91x_device = {
> -	.name		= "smc91x",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data = &tavorevb_smc91x_info,
> -	},
> -	.num_resources	= ARRAY_SIZE(smc91x_resources),
> -	.resource	= smc91x_resources,
> -};
> -
> -static void __init tavorevb_init(void)
> -{
> -	mfp_config(ARRAY_AND_SIZE(tavorevb_pin_config));
> -
> -	/* on-chip devices */
> -	pxa910_add_uart(1);
> -	platform_device_add_data(&pxa910_device_gpio, &pxa910_gpio_pdata,
> -				 sizeof(struct pxa_gpio_platform_data));
> -	platform_device_register(&pxa910_device_gpio);
> -
> -	/* off-chip devices */
> -	platform_device_register(&smc91x_device);
> -}
> -
> -MACHINE_START(TAVOREVB, "PXA910 Evaluation Board (aka TavorEVB)")
> -	.map_io		= mmp_map_io,
> -	.nr_irqs	= MMP_NR_IRQS,
> -	.init_irq       = pxa910_init_irq,
> -	.init_time	= pxa910_timer_init,
> -	.init_machine   = tavorevb_init,
> -	.restart	= mmp_restart,
> -MACHINE_END

