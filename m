Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9856C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF142068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575905438;
	bh=LYjRBh90O5HYAIu5dtpovBGv6ud9Pv4H6SyZaJxCCG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dHtoPtMmZVL3qSsFAE1XFF0sLaBdKYBwwihQyb3+qdwv9NocQ05ZbUGj0AUB/eGVf
	 JjfxrxNkQ4vWDhJhMecJitUsgMvUNeDwxDqYcNPUZgMOMCDRDLjWfNyV4/snSNsP/K
	 GHQp6A6UPNjBC2poJdGUB8i97B/uBNc8nIAvzPBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLIPah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfLIPah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:30:37 -0500
Received: from localhost (unknown [89.205.132.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E073E2068E;
        Mon,  9 Dec 2019 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575905435;
        bh=LYjRBh90O5HYAIu5dtpovBGv6ud9Pv4H6SyZaJxCCG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8dyaFJc26XWEkqrZE7OPAFunXLGJAe4VMYn7kTD+y+HxwNy7kd6zOPRXPxKWP/rh
         Gg1ejCitUO270AjzGN9I2QwBfkVkvSdsgZhLUDlh21TsKN3bhxbPXJcnV6s+WHKHdM
         CUcxfPbFLLZbQUwnt8ZZ3X2+S/umolRLJw69IZr4=
Date:   Mon, 9 Dec 2019 16:30:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Subject: Re: [PATCH v2 1/2] uio: uio_xilinx_apm: Add Xilinx AXI performance
 monitor driver
Message-ID: <20191209153031.GC1280846@kroah.com>
References: <1575901405-3084-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575901405-3084-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 07:53:24PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Added driver for Xilinx AXI performance monitor IP.
> 
> Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> Updated the header
> 
>  drivers/uio/Kconfig          |  12 ++
>  drivers/uio/Makefile         |   1 +
>  drivers/uio/uio_xilinx_apm.c | 358 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 drivers/uio/uio_xilinx_apm.c
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81..de30312 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -165,4 +165,16 @@ config UIO_HV_GENERIC
>  	  to network and storage devices from userspace.
>  
>  	  If you compile this as a module, it will be called uio_hv_generic.
> +
> +config UIO_XILINX_APM
> +	tristate "Xilinx AXI Performance Monitor driver"
> +	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
> +	help
> +	  This driver is developed for AXI Performance Monitor IP, designed to
> +	  monitor AXI4 traffic for performance analysis of AXI bus in the
> +	  system. Driver maps HW registers and parameters to userspace.
> +
> +	  To compile this driver as a module, choose M here; the module
> +	  will be called uio_xilinx_apm.
> +
>  endif
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index c285dd2..b3464d8 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
>  obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
>  obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
>  obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
> +obj-$(CONFIG_UIO_XILINX_APM)	+= uio_xilinx_apm.o
> diff --git a/drivers/uio/uio_xilinx_apm.c b/drivers/uio/uio_xilinx_apm.c
> new file mode 100644
> index 0000000..3f69922
> --- /dev/null
> +++ b/drivers/uio/uio_xilinx_apm.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx AXI Performance Monitor
> + *
> + * Description:
> + * This driver is developed for AXI Performance Monitor IP,
> + * designed to monitor AXI4 traffic for performance analysis
> + * of AXI bus in the system. Driver maps HW registers and parameters
> + * to userspace. Userspace need not clear the interrupt of IP since
> + * driver clears the interrupt.
> + *
> + * Copyright (c) 2019 Xilinx Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/uio_driver.h>
> +
> +#define XAPM_IS_OFFSET		0x0038  /* Interrupt Status Register */
> +#define DRV_NAME		"xilinxapm_uio"
> +#define DRV_VERSION		"1.0"

No need for a version, the code is in the kernel tree, use the version
of the kernel instead please.

> +#define UIO_DUMMY_MEMSIZE	4096
> +#define XAPM_MODE_ADVANCED	1
> +#define XAPM_MODE_PROFILE	2
> +#define XAPM_MODE_TRACE		3
> +
> +/**
> + * struct xapm_param - HW parameters structure
> + * @mode: Mode in which APM is working
> + * @maxslots: Maximum number of Slots in APM
> + * @eventcnt: Event counting enabled in APM
> + * @eventlog: Event logging enabled in APM
> + * @sampledcnt: Sampled metric counters enabled in APM
> + * @numcounters: Number of counters in APM
> + * @metricwidth: Metric Counter width (32/64)
> + * @sampledwidth: Sampled metric counter width
> + * @globalcntwidth: Global Clock counter width
> + * @scalefactor: Scaling factor
> + * @isr: Interrupts info shared to userspace
> + * @is_32bit_filter: Flags for 32bit filter
> + * @clk: Clock handle
> + */
> +struct xapm_param {
> +	u32 mode;
> +	u32 maxslots;
> +	u32 eventcnt;
> +	u32 eventlog;
> +	u32 sampledcnt;
> +	u32 numcounters;
> +	u32 metricwidth;
> +	u32 sampledwidth;
> +	u32 globalcntwidth;
> +	u32 scalefactor;
> +	u32 isr;
> +	bool is_32bit_filter;
> +	struct clk *clk;

You seem to copy this structure to hardware?  How?  This is not a
definition of a proper hardware interface.  Or are you copying it to
userspace?  If so, even worse!  This is not how to properly define such
a structure at all.

> +};
> +
> +/**
> + * struct xapm_dev - Global driver structure
> + * @info: uio_info structure
> + * @param: xapm_param structure
> + * @regs: IOmapped base address
> + */
> +struct xapm_dev {
> +	struct uio_info info;
> +	struct xapm_param param;
> +	void __iomem *regs;
> +};
> +
> +/**
> + * xapm_handler - Interrupt handler for APM
> + * @irq: IRQ number
> + * @info: Pointer to uio_info structure
> + *
> + * Return: Always returns IRQ_HANDLED
> + */
> +static irqreturn_t xapm_handler(int irq, struct uio_info *info)
> +{
> +	struct xapm_dev *xapm = (struct xapm_dev *)info->priv;

DO you need to cast?

> +	void *ptr;
> +
> +	ptr = (unsigned long *)xapm->info.mem[1].addr;

No need to cast.  And ptr is a void, not unsigned long *.

> +	/* Clear the interrupt and copy the ISR value to userspace */
> +	xapm->param.isr = readl(xapm->regs + XAPM_IS_OFFSET);
> +	writel(xapm->param.isr, xapm->regs + XAPM_IS_OFFSET);
> +	memcpy(ptr, &xapm->param, sizeof(struct xapm_param));

Where did you just copy this memory to?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * xapm_getprop - Retrieves dts properties to param structure
> + * @pdev: Pointer to platform device
> + * @param: Pointer to param structure
> + *
> + * Returns: '0' on success and failure value on error
> + */
> +static int xapm_getprop(struct platform_device *pdev, struct xapm_param *param)
> +{
> +	u32 mode = 0;
> +	int ret;
> +	struct device_node *node;
> +
> +	node = pdev->dev.of_node;
> +
> +	/* Retrieve required dts properties and fill param structure */
> +	ret = of_property_read_u32(node, "xlnx,enable-profile", &mode);
> +	if (ret < 0)
> +		dev_info(&pdev->dev, "no property xlnx,enable-profile\n");

If it's an error, make it dev_err().  No need to be noisy otherwise.
Same for all of these.

> +	else if (mode)
> +		param->mode = XAPM_MODE_PROFILE;
> +
> +	ret = of_property_read_u32(node, "xlnx,enable-trace", &mode);
> +	if (ret < 0)
> +		dev_info(&pdev->dev, "no property xlnx,enable-trace\n");
> +	else if (mode)
> +		param->mode = XAPM_MODE_TRACE;
> +
> +	ret = of_property_read_u32(node, "xlnx,num-monitor-slots",
> +				   &param->maxslots);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property xlnx,num-monitor-slots");

Doesn't of_property_read_u32() print an error if it can not be found?
Don't duplicate the message please.  Same for all of these.


> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "xlnx,enable-event-count",
> +				   &param->eventcnt);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property xlnx,enable-event-count");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "xlnx,enable-event-log",
> +				   &param->eventlog);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property xlnx,enable-event-log");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "xlnx,have-sampled-metric-cnt",
> +				   &param->sampledcnt);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property xlnx,have-sampled-metric-cnt");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "xlnx,num-of-counters",
> +				   &param->numcounters);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property xlnx,num-of-counters");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "xlnx,metric-count-width",
> +				   &param->metricwidth);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property xlnx,metric-count-width");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "xlnx,metrics-sample-count-width",
> +				   &param->sampledwidth);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property metrics-sample-count-width");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "xlnx,global-count-width",
> +				   &param->globalcntwidth);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property xlnx,global-count-width");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "xlnx,metric-count-scale",
> +				   &param->scalefactor);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "no property xlnx,metric-count-scale");
> +		return ret;
> +	}
> +
> +	param->is_32bit_filter = of_property_read_bool(node,
> +						"xlnx,id-filter-32bit");
> +
> +	return 0;
> +}
> +
> +/**
> + * xapm_probe - Driver probe function
> + * @pdev: Pointer to the platform_device structure
> + *
> + * Returns: '0' on success and failure value on error
> + */
> +

Why the blank line?  Why the kernel doc for static functions?

> +static int xapm_probe(struct platform_device *pdev)
> +{
> +	struct xapm_dev *xapm;
> +	struct resource *res;
> +	int irq;
> +	int ret;
> +	void *ptr;
> +
> +	xapm = devm_kzalloc(&pdev->dev, (sizeof(struct xapm_dev)), GFP_KERNEL);
> +	if (!xapm)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xapm->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xapm->regs)) {
> +		dev_err(&pdev->dev, "unable to iomap registers\n");
> +		return PTR_ERR(xapm->regs);
> +	}
> +
> +	xapm->param.clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(xapm->param.clk)) {
> +		if (PTR_ERR(xapm->param.clk) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "axi clock error\n");
> +		return PTR_ERR(xapm->param.clk);
> +	}
> +
> +	ret = clk_prepare_enable(xapm->param.clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Unable to enable clock.\n");
> +		return ret;
> +	}
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	/* Initialize mode as Advanced so that if no mode in dts, default
> +	 * is Advanced
> +	 */

Odd commenting style, this isn't the network stack :)


> +	xapm->param.mode = XAPM_MODE_ADVANCED;
> +	ret = xapm_getprop(pdev, &xapm->param);
> +	if (ret < 0)
> +		goto err_clk_dis;
> +
> +	xapm->info.mem[0].name = "xilinx_apm";

Not driver name?  Why have that #define then?

> +	xapm->info.mem[0].addr = res->start;
> +	xapm->info.mem[0].size = resource_size(res);
> +	xapm->info.mem[0].memtype = UIO_MEM_PHYS;
> +
> +	xapm->info.mem[1].addr = (unsigned long)kzalloc(UIO_DUMMY_MEMSIZE,
> +							GFP_KERNEL);
> +	ptr = (unsigned long *)xapm->info.mem[1].addr;
> +	xapm->info.mem[1].size = UIO_DUMMY_MEMSIZE;
> +	xapm->info.mem[1].memtype = UIO_MEM_LOGICAL;
> +
> +	xapm->info.name = "axi-pmon";
> +	xapm->info.version = DRV_VERSION;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "unable to get irq\n");
> +		ret = irq;
> +		goto err_clk_dis;
> +	}
> +
> +	xapm->info.irq = irq;
> +	xapm->info.handler = xapm_handler;
> +	xapm->info.priv = xapm;
> +	xapm->info.irq_flags = IRQF_SHARED;
> +
> +	memcpy(ptr, &xapm->param, sizeof(struct xapm_param));

Where did you just copy this to?

> +
> +	ret = uio_register_device(&pdev->dev, &xapm->info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to register to UIO\n");
> +		goto err_clk_dis;
> +	}
> +
> +	platform_set_drvdata(pdev, xapm);
> +
> +	dev_info(&pdev->dev, "Probed Xilinx APM\n");

Again, this should be quiet if all goes well, didn't I say that before?

Finally, why do you need a UIO driver at all here?  Why can't the
current ones work properly for you?

thanks,

greg k-h
