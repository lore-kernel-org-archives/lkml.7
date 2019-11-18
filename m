Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEE7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00762230C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2c5Q0c7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKRW4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:56:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34307 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKRW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:56:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so10630496plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VweJvPw9KXJliTxPoEDSfPBhjVqbH3eDBuR8yLkz1fQ=;
        b=m2c5Q0c74gWhnvp4je3yqVZcm7DqVKA7jisqzl6wqj+KANRa+9gSEkePSx+qbZoaIq
         R2c1K/fg1JRaP08zgUhVHsKc0UZenovlOMyQ1F2TrUrw6RR3kPVdEqoPCz/2/QV0ujBl
         d0EYKzY0yKLJSxhzPstWXVbPrtYo9FEq/D4zp6Gzw1Tw6zo7oTYjN7gxJhq4Pn1qFRKo
         VNPGFVlrlhX8jRdiH9N+9SvGBuJIl/CdyGNXCR4hKHsG2SR6zcgToLbfRJp/c3DjjAku
         3vMG2cMRTOXpO3/7Vseils5w5rk2vECowKwc3l92CduNFz0rQAYdSzOTB69H2EDUVqjq
         zavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VweJvPw9KXJliTxPoEDSfPBhjVqbH3eDBuR8yLkz1fQ=;
        b=C755gvKZdsTi7JNYUwU1DHMzLpd+ZNaNeYN5+/oY/fySdS82wDanGS9TcFclTWtx9q
         4WacKw24N0eQoM3Uw9329IbHIgf4T4zJEpZ1u5qW3YyOrjNXEJ+FmDR6e1rbcM5QGiS8
         maVvIQ4j9zMtRHmuH9WzGy1903QQxFahAIrRHAEM1U34JzHTM4th+xbZsd7bX1Vprq9c
         skggAvI+1Cos2Is0RhgpYrT8neavsv/cI5wGtQYobAOVugNAROoBXA8U0pXUJzhC9Lkj
         uaP2RbnULOoGdJ4i8hBA8BgD4aIrUDKwQ83qork3uBjn8tkytmF5GpT9CEd8zf0iRLyO
         4faQ==
X-Gm-Message-State: APjAAAUoSFxPfU3IWqfwGciye8822sKX/2Wswgik4rPrDaOeGomvDKWV
        Me21p1b3n73LeNM7vYCHpfrtGg==
X-Google-Smtp-Source: APXvYqxPxXUh1fUDenKA7oTOOIicqOty+iYA7of050uUKhOw8y0cUSgnUpNevfVWnjpQcfqTd3YtVA==
X-Received: by 2002:a17:90a:3746:: with SMTP id u64mr1928022pjb.4.1574117790803;
        Mon, 18 Nov 2019 14:56:30 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f35sm491856pje.32.2019.11.18.14.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 14:56:30 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:56:28 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] remoteproc: ingenic: Added remoteproc driver
Message-ID: <20191118225628.GA18243@xps15>
References: <20191116170846.67220-1-paul@crapouillou.net>
 <20191116170846.67220-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116170846.67220-4-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sat, Nov 16, 2019 at 06:08:46PM +0100, Paul Cercueil wrote:
> This driver is used to boot, communicate with and load firmwares to the
> MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
> Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Remove exception for always-mapped memories
>     v3: - Use clk_bulk API
>         - Move device-managed code to its own patch [3/4]
>     	- Move devicetree table right above ingenic_rproc_driver
>     	- Removed #ifdef CONFIG_OF around devicetree table
>     	- Removed .owner = THIS_MODULE in ingenic_rproc_driver
>     	- Removed useless platform_set_drvdata()
> 
>  drivers/remoteproc/Kconfig         |   8 +
>  drivers/remoteproc/Makefile        |   1 +
>  drivers/remoteproc/ingenic_rproc.c | 242 +++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/remoteproc/ingenic_rproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 94afdde4bc9f..f7d4b183d152 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -214,6 +214,14 @@ config STM32_RPROC
>  
>  	  This can be either built-in or a loadable module.
>  
> +config INGENIC_RPROC

Are you sure you don't want to make this something like
INGENIC_RPROC_JZ47XX_VPU so that future remote proc system from Ingenic can be
added easily?

> +	tristate "Ingenic JZ47xx VPU remoteproc support"
> +	depends on MIPS || COMPILE_TEST
> +	help
> +	  Say y or m here to support the VPU in the JZ47xx SoCs from Ingenic.
> +	  This can be either built-in or a loadable module.
> +	  If unsure say N.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 00f09e658cb3..6eb0137abbc7 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_sysfs.o
>  remoteproc-y				+= remoteproc_virtio.o
>  remoteproc-y				+= remoteproc_elf_loader.o
>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
> +obj-$(CONFIG_INGENIC_RPROC)			+= ingenic_rproc.a

This comes out as one tab to many on my side.

>  obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
> diff --git a/drivers/remoteproc/ingenic_rproc.c b/drivers/remoteproc/ingenic_rproc.c
> new file mode 100644
> index 000000000000..5a7c7d8d9a90
> --- /dev/null
> +++ b/drivers/remoteproc/ingenic_rproc.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Ingenic JZ47xx remoteproc driver
> + * Copyright 2019, Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +
> +#include "remoteproc_internal.h"
> +
> +#define REG_AUX_CTRL		0x0
> +#define REG_AUX_MSG_ACK		0x10
> +#define REG_AUX_MSG		0x14
> +#define REG_CORE_MSG_ACK	0x18
> +#define REG_CORE_MSG		0x1C
> +
> +#define AUX_CTRL_SLEEP		BIT(31)
> +#define AUX_CTRL_MSG_IRQ_EN	BIT(3)
> +#define AUX_CTRL_NMI_RESETS	BIT(2)
> +#define AUX_CTRL_NMI		BIT(1)
> +#define AUX_CTRL_SW_RESET	BIT(0)
> +
> +struct vpu_mem_map {
> +	const char *name;
> +	unsigned int da;
> +};
> +
> +struct vpu_mem_info {
> +	const struct vpu_mem_map *map;
> +	unsigned long len;
> +	void __iomem *base;
> +};
> +
> +static const struct vpu_mem_map vpu_mem_map[] = {
> +	{ "tcsm0", 0x132b0000 },
> +	{ "tcsm1", 0xf4000000 },
> +	{ "sram",  0x132f0000 },
> +};
> +
> +/* Device data */
> +struct vpu {
> +	int irq;
> +	struct clk_bulk_data clks[2];
> +	void __iomem *aux_base;
> +	struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
> +	struct device *dev;
> +};

Documentation of structure fields is always appreciated but it is up to Bjorn to
decide on this one.

> +
> +static int ingenic_rproc_prepare(struct rproc *rproc)
> +{
> +	struct vpu *vpu = rproc->priv;
> +	int ret;
> +
> +	/* The clocks must be enabled for the firmware to be loaded in TCSM */
> +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(vpu->clks), vpu->clks);
> +	if (ret)
> +		dev_err(vpu->dev, "Unable to start clocks: %d", ret);
> +
> +	return ret;
> +}
> +
> +static void ingenic_rproc_unprepare(struct rproc *rproc)
> +{
> +	struct vpu *vpu = rproc->priv;
> +
> +	clk_bulk_disable_unprepare(ARRAY_SIZE(vpu->clks), vpu->clks);
> +}
> +
> +static int ingenic_rproc_start(struct rproc *rproc)
> +{
> +	struct vpu *vpu = rproc->priv;
> +	u32 ctrl;
> +
> +	enable_irq(vpu->irq);
> +
> +	/* Reset the AUX and enable message IRQ */
> +	ctrl = AUX_CTRL_NMI_RESETS | AUX_CTRL_NMI | AUX_CTRL_MSG_IRQ_EN;
> +	writel(ctrl, vpu->aux_base + REG_AUX_CTRL);

Out of curiosity, there is no power domain associated with this
co-processor?  Clocks are all you need?

> +
> +	return 0;
> +}
> +
> +static int ingenic_rproc_stop(struct rproc *rproc)
> +{
> +	struct vpu *vpu = rproc->priv;
> +
> +	/* Keep AUX in reset mode */
> +	writel(AUX_CTRL_SW_RESET, vpu->aux_base + REG_AUX_CTRL);
> +
> +	disable_irq_nosync(vpu->irq);

Also out of curiosity, why the need for _nosync()?

> +
> +	return 0;
> +}
> +
> +static void ingenic_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct vpu *vpu = rproc->priv;
> +
> +	writel(vqid, vpu->aux_base + REG_CORE_MSG);
> +}
> +
> +static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> +{
> +	struct vpu *vpu = rproc->priv;
> +	void __iomem *va = NULL;
> +	unsigned int i;
> +
> +	if (len <= 0)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
> +		const struct vpu_mem_info *info = &vpu->mem_info[i];
> +		const struct vpu_mem_map *map = info->map;
> +
> +		if (da >= map->da && (da + len) < (map->da + info->len)) {
> +			va = info->base + (da - map->da);
> +			break;
> +		}
> +	}
> +
> +	return (__force void *)va;
> +}
> +
> +static struct rproc_ops ingenic_rproc_ops = {
> +	.prepare = ingenic_rproc_prepare,
> +	.unprepare = ingenic_rproc_unprepare,
> +	.start = ingenic_rproc_start,
> +	.stop = ingenic_rproc_stop,
> +	.kick = ingenic_rproc_kick,
> +	.da_to_va = ingenic_rproc_da_to_va,
> +};
> +
> +static irqreturn_t vpu_interrupt(int irq, void *data)
> +{
> +	struct rproc *rproc = data;
> +	struct vpu *vpu = rproc->priv;
> +	u32 vring;
> +
> +	vring = readl(vpu->aux_base + REG_AUX_MSG);
> +
> +	/* Ack the interrupt */
> +	writel(0, vpu->aux_base + REG_AUX_MSG_ACK);
> +
> +	return rproc_vq_interrupt(rproc, vring);
> +}
> +
> +static int ingenic_rproc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *mem;
> +	struct rproc *rproc;
> +	struct vpu *vpu;
> +	unsigned int i;
> +	int ret;
> +
> +	rproc = devm_rproc_alloc(dev, "ingenic-vpu",
> +				 &ingenic_rproc_ops, NULL, sizeof(*vpu));
> +	if (!rproc)
> +		return -ENOMEM;
> +
> +	vpu = rproc->priv;
> +	vpu->dev = &pdev->dev;
> +
> +	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux");
> +	vpu->aux_base = devm_ioremap_resource(dev, mem);
> +	if (IS_ERR(vpu->aux_base)) {
> +		dev_err(dev, "Failed to ioremap");
> +		return PTR_ERR(vpu->aux_base);
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
> +		mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   vpu_mem_map[i].name);
> +
> +		vpu->mem_info[i].base = devm_ioremap_resource(dev, mem);
> +		if (IS_ERR(vpu->mem_info[i].base)) {
> +			ret = PTR_ERR(vpu->mem_info[i].base);
> +			dev_err(dev, "Failed to ioremap");
> +			return ret;
> +		}
> +
> +		vpu->mem_info[i].len = resource_size(mem);
> +		vpu->mem_info[i].map = &vpu_mem_map[i];
> +	}
> +
> +	vpu->clks[0].id = "vpu";
> +	vpu->clks[1].id = "aux";
> +
> +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(vpu->clks), vpu->clks);
> +	if (ret) {
> +		dev_err(dev, "Failed to get clocks");
> +		return ret;
> +	}
> +
> +	vpu->irq = platform_get_irq(pdev, 0);
> +	if (vpu->irq < 0) {
> +		dev_err(dev, "Failed to get platform IRQ");
> +		return vpu->irq;
> +	}
> +
> +	ret = devm_request_irq(dev, vpu->irq, vpu_interrupt, 0, "VPU", rproc);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to request IRQ");
> +		return ret;
> +	}
> +
> +	disable_irq_nosync(vpu->irq);
> +
> +	ret = devm_rproc_add(dev, rproc);
> +	if (ret) {
> +		dev_err(dev, "Failed to register remote processor");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ingenic_rproc_of_matches[] = {
> +	{ .compatible = "ingenic,jz4770-vpu-rproc", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
> +
> +static struct platform_driver ingenic_rproc_driver = {
> +	.probe = ingenic_rproc_probe,
> +	.driver = {
> +		.name = "ingenic-vpu",
> +		.of_match_table = of_match_ptr(ingenic_rproc_of_matches),
> +	},
> +};
> +module_platform_driver(ingenic_rproc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> +MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control driver");

Nice, clean and simple driver.  With the above and after rolling in Julia's
patch:

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.24.0
> 
