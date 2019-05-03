Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0681EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A422070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfECOzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:55:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47321 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfECOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:55:24 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hMZas-0004fv-2J; Fri, 03 May 2019 16:55:22 +0200
Message-ID: <1556895321.3046.3.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] reset: Add reset controller support for BM1880 SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com
Date:   Fri, 03 May 2019 16:55:21 +0200
In-Reply-To: <20190425125508.5965-4-manivannan.sadhasivam@linaro.org>
References: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
         <20190425125508.5965-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

thank you for the patch. A few issues below:

On Thu, 2019-04-25 at 18:25 +0530, Manivannan Sadhasivam wrote:
> Add reset controller support for Bitmain BM1880 SoC reusing the
> reset-simple driver. While we are at it, this driver has also been
> modified to make use of the SPDX license identifier.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/reset/Kconfig        |  3 ++-
>  drivers/reset/Makefile       |  1 +
>  drivers/reset/reset-simple.c | 16 +++++++++++-----
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2c8c23db92fb..b25e8d139f0d 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -117,7 +117,7 @@ config RESET_QCOM_PDC
>  
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
> -	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
> +	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN
>  	help
>  	  This enables a simple reset controller driver for reset lines that
>  	  that can be asserted and deasserted by toggling bits in a contiguous,
> @@ -129,6 +129,7 @@ config RESET_SIMPLE
>  	   - RCC reset controller in STM32 MCUs
>  	   - Allwinner SoCs
>  	   - ZTE's zx2967 family
> +	   - Bitmain BM1880 SoC
>  
>  config RESET_STM32MP157
>  	bool "STM32MP157 Reset Driver" if COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 61456b8f659c..b87968771166 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
> +#obj-$(CONFIG_RESET_BM1880) += reset-bm1880.o

Leftover from a previous patch version? You can remove this.

>  obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index 77fbba3100c8..fd1fa4984d76 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Simple Reset Controller Driver
>   *
> @@ -8,11 +9,6 @@
>   * Copyright 2013 Maxime Ripard
>   *
>   * Maxime Ripard <maxime.ripard@free-electrons.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>   */

Please split this change into a separate patch and add Maxime to Cc:
 
>  #include <linux/device.h>
> @@ -119,6 +115,14 @@ static const struct reset_simple_devdata reset_simple_active_low = {
>  	.status_active_low = true,
>  };
>  
> +#define BM1880_NR_BANKS		2
> +
> +static const struct reset_simple_devdata reset_simple_bm1880 = {
> +	.nr_resets = BM1880_NR_BANKS * 32,

This is not necessary, given your device tree changes, the

        data->rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;

in reset_simple_probe should already do the right thing.
You can remove the .nr_resets from reset_simple_bm1880 and the
BM1880_NR_BANKS #define.

> +	.active_low = true,
> +	.status_active_low = true,
> +};
> +
>  static const struct of_device_id reset_simple_dt_ids[] = {
>  	{ .compatible = "altr,stratix10-rst-mgr",
>  		.data = &reset_simple_socfpga },
> @@ -129,6 +133,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
>  		.data = &reset_simple_active_low },
>  	{ .compatible = "aspeed,ast2400-lpc-reset" },
>  	{ .compatible = "aspeed,ast2500-lpc-reset" },
> +	{ .compatible = "bitmain,bm1880-reset",
> +		.data = &reset_simple_bm1880 },
>  	{ /* sentinel */ },
>  };

With these changes,
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
for both parts. 

regards
Philipp
