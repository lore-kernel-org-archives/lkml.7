Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77550C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401F6218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfGYNVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:21:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:38169 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfGYNVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:21:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 06:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="189318286"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2019 06:19:44 -0700
Subject: Re: [PATCH v2 2/2] mmc: Add support for the ASPEED SD controller
To:     Andrew Jeffery <andrew@aj.id.au>, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ryanchen.aspeed@gmail.com
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-3-andrew@aj.id.au>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d6f7fdf2-07ed-354a-ca29-f3175623679c@intel.com>
Date:   Thu, 25 Jul 2019 16:18:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190712033214.24713-3-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/19 6:32 AM, Andrew Jeffery wrote:
> Add a minimal driver for ASPEED's SD controller, which exposes two
> SDHCIs.
> 
> The ASPEED design implements a common register set for the SDHCIs, and
> moves some of the standard configuration elements out to this common
> area (e.g. 8-bit mode, and card detect configuration which is not
> currently supported).
> 
> The SD controller has a dedicated hardware interrupt that is shared
> between the slots. The common register set exposes information on which
> slot triggered the interrupt; early revisions of the patch introduced an
> irqchip for the register, but reality is it doesn't behave as an
> irqchip, and the result fits awkwardly into the irqchip APIs. Instead
> I've taken the simple approach of using the IRQ as a shared IRQ with
> some minor performance impact for the second slot.
> 
> Ryan was the original author of the patch - I've taken his work and
> massaged it to drop the irqchip support and rework the devicetree
> integration. The driver has been smoke tested under qemu against a
> minimal SD controller model and lightly tested on an ast2500-evb.
> 
> Signed-off-by: Ryan Chen <ryanchen.aspeed@gmail.com>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Looks fine.  Few minor comments below.

> ---
> In v2:
> 
> * Drop unnecesasry MODULE_DEVICE_TABLE()
> * Rename sd-controller compatible
> * Add IBM copyright
> * Drop unnecesary data assignment in of match table entries
> * Derive the slot from the SDHCI offset
> 
>  drivers/mmc/host/Kconfig           |  12 ++
>  drivers/mmc/host/Makefile          |   1 +
>  drivers/mmc/host/sdhci-of-aspeed.c | 326 +++++++++++++++++++++++++++++
>  3 files changed, 339 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 931770f17087..2bb5e1264b3d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -154,6 +154,18 @@ config MMC_SDHCI_OF_ARASAN
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_OF_ASPEED
> +	tristate "SDHCI OF support for the ASPEED SDHCI controller"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	help
> +	  This selects the ASPEED Secure Digital Host Controller Interface.
> +
> +	  If you have a controller with this interface, say Y or M here. You
> +	  also need to enable an appropriate bus interface.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_OF_AT91
>  	tristate "SDHCI OF support for the Atmel SDMMC controller"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 73578718f119..390ee162fe71 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
>  obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
> +obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
>  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> new file mode 100644
> index 000000000000..9528e43c257d
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (C) 2019 ASPEED Technology Inc. */
> +/* Copyright (C) 2019 IBM Corp. */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +#include "sdhci-pltfm.h"
> +
> +#define ASPEED_SDC_INFO		0x00
> +#define   ASPEED_SDC_S1MMC8	BIT(25)
> +#define   ASPEED_SDC_S0MMC8	BIT(24)
> +
> +struct aspeed_sdc {
> +	struct clk *clk;
> +	struct resource *res;
> +
> +	spinlock_t lock;
> +	void __iomem *regs;
> +};
> +
> +struct aspeed_sdhci {
> +	struct aspeed_sdc *parent;
> +	u32 width_mask;
> +};
> +
> +static void aspeed_sdc_bus_width(struct aspeed_sdc *sdc,
> +				 struct aspeed_sdhci *sdhci, bool bus8)

The function name threw me at first.  I suggest:

static void aspeed_sdhci_set_clr_8_bit_mode(struct aspeed_sdhci *aspeed_sdhci,
					    bool bus8)
{
	struct aspeed_sdc *aspeed_sdc = aspeed_sdhci->parent;

> +{
> +	u32 info;
> +
> +	/* Set/clear 8 bit mode */
> +	spin_lock(&sdc->lock);
> +	info = readl(sdc->regs + ASPEED_SDC_INFO);
> +	if (bus8)
> +		info |= sdhci->width_mask;
> +	else
> +		info &= ~sdhci->width_mask;
> +	writel(info, sdc->regs + ASPEED_SDC_INFO);
> +	spin_unlock(&sdc->lock);
> +}
> +
> +static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	unsigned long timeout;
> +	int div;
> +	u16 clk;
> +
> +	if (clock == host->clock)
> +		return;
> +
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (clock == 0)
> +		goto out;
> +
> +	for (div = 1; div < 256; div *= 2) {
> +		if ((host->max_clk / div) <= clock)
> +			break;
> +	}
> +	div >>= 1;
> +
> +	clk = div << SDHCI_DIVIDER_SHIFT;

Could call sdhci_enable_clk() here.

> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 20 ms */
> +	timeout = 20;
> +	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +		 & SDHCI_CLOCK_INT_STABLE)) {
> +		if (timeout == 0) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			return;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +out:
> +	host->clock = clock;
> +}
> +
> +static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
> +{
> +	struct sdhci_pltfm_host *pltfm_priv;
> +	struct aspeed_sdhci *aspeed_sdhci;
> +	struct aspeed_sdc *aspeed_sdc;
> +	u8 ctrl;
> +
> +	pltfm_priv = sdhci_priv(host);
> +	aspeed_sdhci = sdhci_pltfm_priv(pltfm_priv);
> +	aspeed_sdc = aspeed_sdhci->parent;
> +
> +	/* Set/clear 8-bit mode */
> +	aspeed_sdc_bus_width(aspeed_sdc, aspeed_sdhci,
> +			     width == MMC_BUS_WIDTH_8);
> +
> +	/* Set/clear 1 or 4 bit mode */
> +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +	if (width == MMC_BUS_WIDTH_4)
> +		ctrl |= SDHCI_CTRL_4BITBUS;
> +	else
> +		ctrl &= ~SDHCI_CTRL_4BITBUS;
> +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +}
> +
> +static const struct sdhci_ops aspeed_sdhci_ops = {
> +	.set_clock = aspeed_sdhci_set_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.set_bus_width = aspeed_sdhci_set_bus_width,
> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pltfm_data aspeed_sdc_pdata = {

Up to you, but this is for the aspeed_sdhci driver, so I would
have expected it to be called aspeed_sdhci_pdata

> +	.ops = &aspeed_sdhci_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,

You don't use sdhci_set_clock() or sdhci_calc_clk(), so it doesn't
look like SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN is needed.

> +};
> +
> +static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> +					      struct resource *res)
> +{
> +	resource_size_t delta;
> +
> +	if (!res || resource_type(res) != IORESOURCE_MEM)
> +		return -EINVAL;
> +
> +	if (res->start < dev->parent->res->start)
> +		return -EINVAL;
> +
> +	delta = res->start - dev->parent->res->start;
> +	if (delta & (0x100 - 1))
> +		return -EINVAL;
> +
> +	return (delta / 0x100) - 1;
> +}
> +
> +static int aspeed_sdhci_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct aspeed_sdhci *dev;
> +	struct sdhci_host *host;
> +	struct resource *res;
> +	int slot;
> +	int ret;
> +
> +	host = sdhci_pltfm_init(pdev, &aspeed_sdc_pdata, sizeof(*dev));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	dev = sdhci_pltfm_priv(pltfm_host);
> +	dev->parent = dev_get_drvdata(pdev->dev.parent);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	slot = aspeed_sdhci_calculate_slot(dev, res);
> +	if (slot < 0)
> +		return slot;
> +	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
> +	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;

That implies that you only support 2 slots which begs the question why
you don't validate slot.

> +
> +	sdhci_get_of_property(pdev);
> +
> +	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pltfm_host->clk))
> +		return PTR_ERR(pltfm_host->clk);
> +
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to enable SDIO clock\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		goto err_sdhci_add;
> +
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		goto err_sdhci_add;
> +
> +	return 0;
> +
> +err_sdhci_add:
> +	clk_disable_unprepare(pltfm_host->clk);
> +err_pltfm_free:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static int aspeed_sdhci_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	int dead;
> +
> +	host = platform_get_drvdata(pdev);
> +	pltfm_host = sdhci_priv(host);
> +
> +	dead = readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff;

'dead' only makes sense for PCI. Just set it to zero.

> +
> +	sdhci_remove_host(host, dead);
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +
> +	sdhci_pltfm_free(pdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_sdhci_of_match[] = {
> +	{ .compatible = "aspeed,ast2400-sdhci", },
> +	{ .compatible = "aspeed,ast2500-sdhci", },
> +	{ }
> +};
> +
> +static struct platform_driver aspeed_sdhci_driver = {
> +	.driver		= {
> +		.name	= "sdhci-aspeed",
> +		.of_match_table = aspeed_sdhci_of_match,
> +	},
> +	.probe		= aspeed_sdhci_probe,
> +	.remove		= aspeed_sdhci_remove,
> +};
> +
> +module_platform_driver(aspeed_sdhci_driver);
> +
> +static int aspeed_sdc_probe(struct platform_device *pdev)
> +
> +{
> +	struct device_node *parent, *child;
> +	struct aspeed_sdc *sdc;
> +	int ret;
> +
> +	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
> +	if (!sdc)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&sdc->lock);
> +
> +	sdc->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(sdc->clk))
> +		return PTR_ERR(sdc->clk);
> +
> +	ret = clk_prepare_enable(sdc->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to enable SDCLK\n");
> +		return ret;
> +	}
> +
> +	sdc->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sdc->regs = devm_ioremap_resource(&pdev->dev, sdc->res);
> +	if (IS_ERR(sdc->regs)) {
> +		ret = PTR_ERR(sdc->regs);
> +		goto err_clk;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, sdc);
> +
> +	parent = pdev->dev.of_node;
> +	for_each_available_child_of_node(parent, child) {
> +		struct platform_device *cpdev;
> +
> +		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
> +		if (IS_ERR(cpdev)) {
> +			of_node_put(child);
> +			ret = PTR_ERR(pdev);
> +			goto err_clk;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(sdc->clk);
> +	return ret;
> +}
> +
> +static int aspeed_sdc_remove(struct platform_device *pdev)
> +{
> +	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
> +
> +	clk_disable_unprepare(sdc->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_sdc_of_match[] = {
> +	{ .compatible = "aspeed,ast2400-sd-controller", },
> +	{ .compatible = "aspeed,ast2500-sd-controller", },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
> +
> +static struct platform_driver aspeed_sdc_driver = {
> +	.driver		= {
> +		.name	= "sd-controller-aspeed",
> +		.pm	= &sdhci_pltfm_pmops,
> +		.of_match_table = aspeed_sdc_of_match,
> +	},
> +	.probe		= aspeed_sdc_probe,
> +	.remove		= aspeed_sdc_remove,
> +};
> +
> +module_platform_driver(aspeed_sdc_driver);
> +
> +MODULE_DESCRIPTION("Driver for the ASPEED SD/SDIO/SDHCI Controllers");
> +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> +MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> +MODULE_LICENSE("GPL v2");
> 

