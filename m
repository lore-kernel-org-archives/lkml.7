Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40B6CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719A621D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572878882;
	bh=hD9m5Y3EuYgscg3p8MUnBKeG7n6NcVKhx8BB5uWLW+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kx6jcvOWu1qNI5QWl2KdCNevvE1dKAtMmPCxN/M0k93jroDWsL1lG2MLgw8/fKBrC
	 Q8hDztu0VLpNgUk/9rZK1mZFV6oakQ3szHW1/yDIjp1U8gYjlu1F9KxVXbz2bmqk/v
	 FsgYi+f/xFxiskORGSq7WveoxBNaqPMP/xfizPSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfKDOsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfKDOsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:48:01 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49740218BA;
        Mon,  4 Nov 2019 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572878879;
        bh=hD9m5Y3EuYgscg3p8MUnBKeG7n6NcVKhx8BB5uWLW+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4AHIjlUtYI0OB1KE5upSC2x5/m0oo1X4zTA2s3ZGG94cZ2tPYs88rqp3MJpSiXeS
         OfsDQIUcNPoiwuJlSs5GfJrhDuMyur4qjmzORrJ8nh6ZAMEMdu7yZsWoyMJF/bMqD/
         cm0C5L2ZVvb8VnH95ELpBwiL+bRgqaxQFW1GLtUw=
Date:   Mon, 4 Nov 2019 15:47:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     felipe.balbi@linux.intel.com, pawell@cadence.com,
        peter.chen@nxp.com, nsekhar@ti.com, kurahul@cadence.com,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: cdns3: Add TI specific wrapper driver
Message-ID: <20191104144752.GB2183570@kroah.com>
References: <20191028093249.22822-1-rogerq@ti.com>
 <20191028093249.22822-3-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028093249.22822-3-rogerq@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:32:49AM +0200, Roger Quadros wrote:
> The J721e platform comes with 2 Cadence USB3 controller
> instances. This driver supports the TI specific wrapper
> on this platform.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Reviewed-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Kconfig    |  10 ++
>  drivers/usb/cdns3/Makefile   |   1 +
>  drivers/usb/cdns3/cdns3-ti.c | 236 +++++++++++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+)
>  create mode 100644 drivers/usb/cdns3/cdns3-ti.c
> 
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index d0331613a355..2a1e89d12ed9 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -43,4 +43,14 @@ config USB_CDNS3_PCI_WRAP
>  	  If you choose to build this driver as module it will
>  	  be dynamically linked and module will be called cdns3-pci.ko
>  
> +config USB_CDNS3_TI
> +	tristate "Cadence USB3 support on TI platforms"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	default USB_CDNS3
> +	help
> +	  Say 'Y' or 'M' here if you are building for Texas Instruments
> +	  platforms that contain Cadence USB3 controller core.
> +
> +	  e.g. J721e.
> +
>  endif
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index a703547350bb..948e6b88d1a9 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -14,3 +14,4 @@ endif
>  cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
>  
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci-wrap.o
> +obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> new file mode 100644
> index 000000000000..c6a79ca15858
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * cdns3-ti.c - TI specific Glue layer for Cadence USB Controller
> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +
> +/* USB Wrapper register offsets */
> +#define USBSS_PID		0x0
> +#define	USBSS_W1		0x4
> +#define USBSS_STATIC_CONFIG	0x8
> +#define USBSS_PHY_TEST		0xc
> +#define	USBSS_DEBUG_CTRL	0x10
> +#define	USBSS_DEBUG_INFO	0x14
> +#define	USBSS_DEBUG_LINK_STATE	0x18
> +#define	USBSS_DEVICE_CTRL	0x1c
> +
> +/* Wrapper 1 register bits */
> +#define USBSS_W1_PWRUP_RST		BIT(0)
> +#define USBSS_W1_OVERCURRENT_SEL	BIT(8)
> +#define USBSS_W1_MODESTRAP_SEL		BIT(9)
> +#define USBSS_W1_OVERCURRENT		BIT(16)
> +#define USBSS_W1_MODESTRAP_MASK		GENMASK(18, 17)
> +#define USBSS_W1_MODESTRAP_SHIFT	17
> +#define USBSS_W1_USB2_ONLY		BIT(19)
> +
> +/* Static config register bits */
> +#define USBSS1_STATIC_PLL_REF_SEL_MASK	GENMASK(8, 5)
> +#define USBSS1_STATIC_PLL_REF_SEL_SHIFT	5
> +#define USBSS1_STATIC_LOOPBACK_MODE_MASK	GENMASK(4, 3)
> +#define USBSS1_STATIC_LOOPBACK_MODE_SHIFT	3
> +#define USBSS1_STATIC_VBUS_SEL_MASK	GENMASK(2, 1)
> +#define USBSS1_STATIC_VBUS_SEL_SHIFT	1
> +#define USBSS1_STATIC_LANE_REVERSE	BIT(0)
> +
> +/* Modestrap modes */
> +enum modestrap_mode { USBSS_MODESTRAP_MODE_NONE,
> +		      USBSS_MODESTRAP_MODE_HOST,
> +		      USBSS_MODESTRAP_MODE_PERIPHERAL};
> +
> +struct cdns_ti {
> +	struct device *dev;
> +	void __iomem *usbss;
> +	int usb2_only:1;
> +	int vbus_divider:1;

'bool' instead of bitfields?  Makes it more obvious, right?

> +	struct clk *usb2_refclk;
> +	struct clk *lpm_clk;
> +};
> +
> +static const int cdns_ti_rate_table[] = {	/* in KHZ */
> +	9600,
> +	10000,
> +	12000,
> +	19200,
> +	20000,
> +	24000,
> +	25000,
> +	26000,
> +	38400,
> +	40000,
> +	58000,
> +	50000,
> +	52000,
> +};
> +
> +static inline u32 cdns_ti_readl(struct cdns_ti *data, u32 offset)
> +{
> +	return readl(data->usbss + offset);
> +}

Does sparse like this function?

> +
> +static inline void cdns_ti_writel(struct cdns_ti *data, u32 offset, u32 value)
> +{
> +	writel(value, data->usbss + offset);

Same here, have you run sparse on this code?

> +}
> +
> +static int cdns_ti_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = pdev->dev.of_node;
> +	struct cdns_ti *data;
> +	int error;
> +	u32 reg;
> +	int rate_code, i;
> +	unsigned long rate;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	data->dev = dev;
> +
> +	data->usbss = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(data->usbss)) {
> +		dev_err(dev, "can't map IOMEM resource\n");

Doesn't the function print an error?

> +		return PTR_ERR(data->usbss);
> +	}
> +
> +	data->usb2_refclk = devm_clk_get(dev, "ref");
> +	if (IS_ERR(data->usb2_refclk)) {
> +		dev_err(dev, "can't get usb2_refclk\n");

Again, doesn't the function print an error?

> +		return PTR_ERR(data->usb2_refclk);
> +	}
> +
> +	data->lpm_clk = devm_clk_get(dev, "lpm");
> +	if (IS_ERR(data->lpm_clk)) {
> +		dev_err(dev, "can't get lpm_clk\n");

Same?

> +		return PTR_ERR(data->lpm_clk);
> +	}
> +
> +	rate = clk_get_rate(data->usb2_refclk);
> +	rate /= 1000;	/* To KHz */
> +	for (i = 0; i < ARRAY_SIZE(cdns_ti_rate_table); i++) {
> +		if (cdns_ti_rate_table[i] == rate)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(cdns_ti_rate_table)) {
> +		dev_err(dev, "unsupported usb2_refclk rate: %lu KHz\n", rate);

What can userspace do about this?

> +		return -EINVAL;
> +	}
> +
> +	rate_code = i;
> +
> +	pm_runtime_enable(dev);
> +	error = pm_runtime_get_sync(dev);
> +	if (error < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed: %d\n", error);

Again, the call should print the error, right?

> +		goto err_get;
> +	}
> +
> +	/* assert RESET */
> +	reg = cdns_ti_readl(data, USBSS_W1);
> +	reg &= ~USBSS_W1_PWRUP_RST;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	/* set static config */
> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +	reg &= ~USBSS1_STATIC_PLL_REF_SEL_MASK;
> +	reg |= rate_code << USBSS1_STATIC_PLL_REF_SEL_SHIFT;
> +
> +	reg &= ~USBSS1_STATIC_VBUS_SEL_MASK;
> +	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
> +	if (data->vbus_divider)
> +		reg |= 1 << USBSS1_STATIC_VBUS_SEL_SHIFT;
> +
> +	cdns_ti_writel(data, USBSS_STATIC_CONFIG, reg);
> +	reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
> +
> +	/* set USB2_ONLY mode if requested */
> +	reg = cdns_ti_readl(data, USBSS_W1);
> +	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
> +	if (data->usb2_only)
> +		reg |= USBSS_W1_USB2_ONLY;
> +
> +	/* set default modestrap */
> +	reg |= USBSS_W1_MODESTRAP_SEL;
> +	reg &= ~USBSS_W1_MODESTRAP_MASK;
> +	reg |= USBSS_MODESTRAP_MODE_NONE << USBSS_W1_MODESTRAP_SHIFT;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	/* de-assert RESET */
> +	reg |= USBSS_W1_PWRUP_RST;
> +	cdns_ti_writel(data, USBSS_W1, reg);
> +
> +	error = of_platform_populate(node, NULL, NULL, dev);
> +	if (error) {
> +		dev_err(dev, "failed to create children: %d\n", error);

Again, error in the caller?

thanks,

greg k-h
