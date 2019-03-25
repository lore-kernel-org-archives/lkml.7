Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB8120896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UY7JyjFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfCYAXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:23:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40829 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfCYAXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:23:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so5093376pfc.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 17:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=agLggfzVNvnniz+s+u4yB447HTg0tUwLs9vsHM/rn0w=;
        b=UY7JyjFaPNeJTBUU6g7aahOv4IHJpuC7sKDIyYq27Np2dzww2yHKkLkzNzUxy0UlkC
         /H9W5hyBJ1LQnJC4L/smWzdt0VTZPuOEPqY7drXE8RQ6s1MZx7bMYisUndC0NxKp5rdI
         lPn04jenEPl23eEdtrLXxGtCGWbxfIAIVulIYVT0i7gz8oEJ0hKenXDxCnXrWxqN/WDq
         9In3dvfenRsDsspHrm4droUnKtmCaX8R1TpqpVlOs2CEMjRbI5NFDVKmhRLkCzqI8qHo
         UWoJhPz1SOyHDegucg1ljPhRASZNbJoQaF8+9ccvApJyz/UGdZw2UwYpC/LIIUg1z0Mv
         76wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=agLggfzVNvnniz+s+u4yB447HTg0tUwLs9vsHM/rn0w=;
        b=XD4yX3oJK3Lm0MUKOObQgbthS5gouk6GnllixsL0ooMsXVLrvJ3rFOAk0QVsHeh8OQ
         z+1hrQAGhIK00ERape6AwdZlDWUkWDgUpVqxYDtld+yugaJAiIry2Rb2MRy8XgcA/Wxw
         6mXVuqQjC9S8/GaVcO5NQ2XPBZIiKzmQ90QhX3Rn5QqBDVckco0D51nDSKL6C6sO4NbZ
         rstytMVVD3iNPtr9XQXdyA2ZiS6fDjpj+J0fEgwTP0ritf0n3SbeAhddLMFa0RIf59AF
         7nrOxw3jB0e/E431WMLIm4fo75+3N7GVuTOy67xTpTRfy6dD2zpSSbfojp72jXZRa7Pd
         612A==
X-Gm-Message-State: APjAAAXo4p54U66fkf3UXqO5dB9yEy/oy1dFZVjRWQEaApqYLVzsRqIj
        AgAGhA42jM4T+d70eNqJZiFunA==
X-Google-Smtp-Source: APXvYqw4obTifPQt8Y9MhyymipTFMf1o1mXWAa1f/B2SbXtKkG+9R3vQNCAMmSVOvNyVmCjSUIv6bA==
X-Received: by 2002:a63:29c3:: with SMTP id p186mr20733392pgp.24.1553473409424;
        Sun, 24 Mar 2019 17:23:29 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id g13sm24637390pfm.159.2019.03.24.17.23.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 17:23:28 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:23:27 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH 2/2] edac: sifive: Add EDAC driver for SiFive FU540-C000
 chip
In-Reply-To: <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1903241558210.8028@viisi.sifive.com>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com> <1553082728-9232-3-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yash,

Just a few brief comments here:

On Wed, 20 Mar 2019, Yash Shah wrote:

> This EDAC driver supports:
> - Initial configuration reporting on bootup via debug logs
> - ECC event monitoring and reporting through the EDAC framework
> - ECC event injection
> 

It's probably worth mentioning here, as you did in the subject line, that 
this is for the FU540-C000 platform.

> This driver is partially based on pnd2_edac.c and altera_edac.c
> 
> Initially L2 Cache controller is added as a subcomponent to
> this EDAC driver.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/Kconfig         |   1 +
>  drivers/edac/Kconfig       |  13 ++
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/sifive_edac.c | 297 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 312 insertions(+)
>  create mode 100644 drivers/edac/sifive_edac.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 515fc3c..fede4b6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -49,6 +49,7 @@ config RISCV
>  	select RISCV_TIMER
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select ARCH_HAS_PTE_SPECIAL
> +	select EDAC_SUPPORT
>  
>  config MMU
>  	def_bool y

This part of the patch either needs to get an ack from Palmer, or should 
be split into a final, separate patch that Palmer can merge separately.  
That way it will avoid unexpected merge conflicts if anything that Palmer 
merges changes this file.

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index e286b5b..112d9d1 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -440,6 +440,19 @@ config EDAC_ALTERA_SDMMC
>  	  Support for error detection and correction on the
>  	  Altera SDMMC FIFO Memory for Altera SoCs.
>  
> +config EDAC_SIFIVE
> +	tristate "Sifive ECC"
> +	depends on RISCV
> +	help
> +	  Support for error detection and correction on the SiFive SoCs.
> +
> +config EDAC_SIFIVE_L2
> +	bool "SiFive L2 Cache ECC"
> +	depends on EDAC_SIFIVE=y
> +	help
> +	  Support for error detection and correction of the L2 cache
> +	  memory on SiFive SoCs.
> +
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
>  	depends on ARCH_ZYNQ || ARCH_ZYNQMP
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 716096d..b16dce8 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
>  obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
>  
>  obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
> +obj-$(CONFIG_EDAC_SIFIVE)		+= sifive_edac.o
>  obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
> diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
> new file mode 100644
> index 0000000..e11ae6b5
> --- /dev/null
> +++ b/drivers/edac/sifive_edac.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SiFive EDAC Driver
> + *
> + * Copyright (C) 2018-2019 SiFive, Inc.
> + *
> + */
> +#include <linux/edac.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include "edac_module.h"
> +
> +#define SIFIVE_EDAC_DIRFIX_LOW 0x100
> +#define SIFIVE_EDAC_DIRFIX_HIGH 0x104
> +#define SIFIVE_EDAC_DIRFIX_COUNT 0x108
> +
> +#define SIFIVE_EDAC_DATFIX_LOW 0x140
> +#define SIFIVE_EDAC_DATFIX_HIGH 0x144
> +#define SIFIVE_EDAC_DATFIX_COUNT 0x148
> +
> +#define SIFIVE_EDAC_DATFAIL_LOW 0x160
> +#define SIFIVE_EDAC_DATFAIL_HIGH 0x164
> +#define SIFIVE_EDAC_DATFAIL_COUNT 0x168
> +
> +#define SIFIVE_EDAC_ECCINJECTERR 0x40
> +#define SIFIVE_EDAC_CONFIG 0x00
> +
> +#define SIFIVE_EDAC_MAX_INTR 3
> +
> +/************************* EDAC Parent Probe *************************/
> +
> +static const struct of_device_id sifive_edac_device_of_match[];
> +
> +static const struct of_device_id sifive_edac_of_match[] = {
> +	{ .compatible = "sifive,ecc-manager" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sifive_edac_of_match);
> +
> +static int sifive_edac_probe(struct platform_device *pdev)
> +{
> +	of_platform_populate(pdev->dev.of_node, sifive_edac_device_of_match,
> +			     NULL, &pdev->dev);
> +	return 0;
> +}
> +
> +static struct platform_driver sifive_edac_driver = {
> +	.probe =  sifive_edac_probe,
> +	.driver = {
> +		.name = "ecc_manager",

As mentioned before we don't have an ECC manager IP block, so we probably 
should figure out a different approach here, if possible.

> +		.of_match_table = sifive_edac_of_match,
> +	},
> +};
> +module_platform_driver(sifive_edac_driver);
> +
> +struct sifive_edac_device_prv {
> +	void (*setup)(struct edac_device_ctl_info *dci);
> +	irqreturn_t (*ecc_irq_handler)(int irq, void *dev_id);
> +	const struct file_operations *inject_fops;
> +};
> +
> +struct sifive_edac_device_dev {
> +	void __iomem *base;
> +	int irq[SIFIVE_EDAC_MAX_INTR];
> +	struct sifive_edac_device_prv *data;
> +	char *edac_dev_name;
> +};
> +
> +enum {
> +	dir_corr = 0,
> +	data_corr,
> +	data_uncorr,
> +};

Best to put these in all caps, per coding-style.rst:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n727

> +
> +static struct dentry *sifive_edac_test;
> +
> +static ssize_t sifive_edac_l2_write(struct file *file, const char __user *data,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct edac_device_ctl_info *dci = file->private_data;
> +	struct sifive_edac_device_dev *drvdata = dci->pvt_info;
> +	unsigned int val;
> +
> +	if (kstrtouint_from_user(data, count, 0, &val))
> +		return -EINVAL;
> +	if ((val >= 0 && val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
> +		writel(val, drvdata->base + SIFIVE_EDAC_ECCINJECTERR);
> +	else
> +		return -EINVAL;
> +	return count;
> +}
> +
> +static const struct file_operations sifive_edac_l2_fops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +	.write = sifive_edac_l2_write
> +};
> +
> +static void setup_sifive_debug(struct edac_device_ctl_info *edac_dci,
> +			       const struct sifive_edac_device_prv *prv)
> +{
> +	struct sifive_edac_device_dev *drvdata = edac_dci->pvt_info;
> +
> +	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
> +		return;

Can all of these debugfs functions be wrapped with an #if ... #endif such 
that, if CONFIG_EDAC_DEBUG is not set, they will all be stripped out by 
the preprocessor?

> +
> +	sifive_edac_test = edac_debugfs_create_dir(drvdata->edac_dev_name);
> +	if (!sifive_edac_test)
> +		return;
> +
> +	if (!edac_debugfs_create_file("sifive_debug_inject_error", 0200,
> +				      sifive_edac_test, edac_dci,
> +				      prv->inject_fops))
> +		debugfs_remove_recursive(sifive_edac_test);
> +}
> +
> +static void teardown_sifive_debug(void)
> +{
> +	debugfs_remove_recursive(sifive_edac_test);
> +}
> +
> +/*
> + * sifive_edac_l2_int_handler - ISR function for l2 cache controller
> + * @irq:	Irq Number
> + * @device:	Pointer to the edac device controller instance
> + *
> + * This routine is triggered whenever there is ECC error detected
> + *
> + * Return: Always returns IRQ_HANDLED
> + */
> +static irqreturn_t sifive_edac_l2_int_handler(int irq, void *device)
> +{
> +	struct edac_device_ctl_info *dci =
> +					(struct edac_device_ctl_info *)device;
> +	struct sifive_edac_device_dev *drvdata = dci->pvt_info;
> +	u32 regval, add_h, add_l;
> +
> +	if (irq == drvdata->irq[dir_corr]) {
> +		add_h = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_HIGH);
> +		add_l = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_LOW);
> +		dev_err(dci->dev,
> +			"DirError at address 0x%08X.%08X\n", add_h, add_l);
> +		regval = readl(drvdata->base + SIFIVE_EDAC_DIRFIX_COUNT);
> +		edac_device_handle_ce(dci, 0, 0, "DirECCFix");
> +	}
> +	if (irq == drvdata->irq[data_corr]) {
> +		add_h = readl(drvdata->base + SIFIVE_EDAC_DATFIX_HIGH);
> +		add_l = readl(drvdata->base + SIFIVE_EDAC_DATFIX_LOW);
> +		dev_err(dci->dev,
> +			"DataError at address 0x%08X.%08X\n", add_h, add_l);
> +		regval = readl(drvdata->base + SIFIVE_EDAC_DATFIX_COUNT);
> +		edac_device_handle_ce(dci, 0, 0, "DatECCFix");
> +	}
> +	if (irq == drvdata->irq[data_uncorr]) {
> +		add_h = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_HIGH);
> +		add_l = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_LOW);
> +		dev_err(dci->dev,
> +			"DataFail at address 0x%08X.%08X\n", add_h, add_l);
> +		regval = readl(drvdata->base + SIFIVE_EDAC_DATFAIL_COUNT);
> +		edac_device_handle_ue(dci, 0, 0, "DatECCFail");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sifive_edac_l2_config_read(struct edac_device_ctl_info *dci)
> +{
> +	struct sifive_edac_device_dev *drvdata = dci->pvt_info;
> +	u32 regval, val;
> +
> +	regval = readl(drvdata->base + SIFIVE_EDAC_CONFIG);
> +	val = regval & 0xFF;
> +	dev_info(dci->dev, "No. of Banks in the cache: %d\n", val);
> +	val = (regval & 0xFF00) >> 8;
> +	dev_info(dci->dev, "No. of ways per bank: %d\n", val);
> +	val = (regval & 0xFF0000) >> 16;
> +	dev_info(dci->dev, "Sets per bank: %llu\n", (uint64_t)1 << val);
> +	val = (regval & 0xFF000000) >> 24;
> +	dev_info(dci->dev,
> +		 "Bytes per cache block: %llu\n", (uint64_t)1 << val);
> +}
> +
> +static const struct sifive_edac_device_prv l2ecc_data = {
> +	.setup = sifive_edac_l2_config_read,
> +	.inject_fops = &sifive_edac_l2_fops,
> +	.ecc_irq_handler = sifive_edac_l2_int_handler,
> +};
> +
> +/*
> + * sifive_edac_device_probe()
> + *	This is a generic EDAC device driver that will support
> + *	various SiFive memory devices as well as the memories
> + *	for other peripherals. Module specific initialization is
> + *	done by passing the function index in the device tree.
> + */
> +static int sifive_edac_device_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci;
> +	struct sifive_edac_device_dev *drvdata;
> +	int rc, i;
> +	struct resource *res;
> +	void __iomem *baseaddr;
> +	struct device_node *np = pdev->dev.of_node;
> +	char *ecc_name = (char *)np->name;
> +	static int dev_instance;
> +
> +	/* Get the data from the platform device */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	baseaddr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(baseaddr))
> +		return PTR_ERR(baseaddr);
> +
> +	dci = edac_device_alloc_ctl_info(sizeof(*drvdata), ecc_name,
> +					 1, ecc_name, 1, 1, NULL, 0,
> +					 dev_instance++);
> +	if (IS_ERR(dci))
> +		return PTR_ERR(dci);
> +
> +	drvdata = dci->pvt_info;
> +	drvdata->base = baseaddr;
> +	drvdata->edac_dev_name = ecc_name;
> +	dci->dev = &pdev->dev;
> +	dci->mod_name = "Sifive ECC Manager";
> +	dci->ctl_name = dev_name(&pdev->dev);
> +	dci->dev_name = dev_name(&pdev->dev);
> +
> +	 /* Get driver specific data for this EDAC device */
> +	drvdata->data = of_match_node(sifive_edac_device_of_match, np)->data;
> +
> +	setup_sifive_debug(dci, drvdata->data);
> +
> +	if (drvdata->data->setup)
> +		drvdata->data->setup(dci);
> +
> +	for (i = 0; i < SIFIVE_EDAC_MAX_INTR; i++) {
> +		drvdata->irq[i] = platform_get_irq(pdev, i);
> +		rc = devm_request_irq(&pdev->dev, drvdata->irq[i],
> +				      sifive_edac_l2_int_handler, 0,
> +				      dev_name(&pdev->dev), (void *)dci);
> +		if (rc) {
> +			dev_err(&pdev->dev,
> +				"Could not request IRQ %d\n", drvdata->irq[i]);
> +			goto del_edac_device;
> +		}
> +	}
> +
> +	rc = edac_device_add_device(dci);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed to register with EDAC core\n");
> +		goto del_edac_device;
> +	}
> +
> +	return rc;
> +
> +del_edac_device:
> +	teardown_sifive_debug();
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);
> +
> +	return rc;
> +}
> +
> +static int sifive_edac_device_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
> +
> +	teardown_sifive_debug();
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sifive_edac_device_of_match[] = {
> +	{ .compatible = "sifive,ccache0", .data = &l2ecc_data },

This match string should be "sifive,fu540-c000-ccache" if 
the intention is to probe against the L2 controller.

> +	{ /* end of table */ },
> +};
> +MODULE_DEVICE_TABLE(of, sifive_edac_device_of_match);
> +
> +static struct platform_driver sifive_edac_device_driver = {
> +	.driver = {
> +		 .name = "sifive_edac_device",
> +		 .owner = THIS_MODULE,
> +		 .of_match_table = sifive_edac_device_of_match,
> +	},
> +	.probe = sifive_edac_device_probe,
> +	.remove = sifive_edac_device_remove,
> +};
> +
> +module_platform_driver(sifive_edac_device_driver);
> +
> +MODULE_AUTHOR("SiFive Inc.");
> +MODULE_DESCRIPTION("SiFive EDAC driver");
> +MODULE_LICENSE("GPL v2");

- Paul
