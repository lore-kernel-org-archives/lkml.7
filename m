Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D43C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3BD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcTSjT+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfC0P1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:27:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45744 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfC0P1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:27:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so9011529pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ba1l5BCxj079539rifrbp0JUqAEjS/qS8MQ5M7nFD/s=;
        b=UcTSjT+PwWaRTGu2cbIFrOQEocbCilNLotzOT+rLC+OD74+fIUO1pVByTQD/gZAjVq
         V9giXUm9yhq7MgqQ9/Rw0O6+vDJXc8HMeM9m/Ss8jAhVDCD5PhiCfjZcHrdeti4p2CWK
         9AGvUYEVnk6duvTjNkg86GyRnedtJUlQwuT7OprrSLpRs8ouHNg3Qhstzvw1d42bvwuK
         pjWm8vTXyOCrWJp7WYTfVUaEEtTP/7ge8PlDVl0WjgHkTKK0nEO8A6xjzWlZoPk10/7z
         xqKfdKgoxS0n59G/Oo8WNAQuoVQywCs2djw7i1We2erAtulSqx54HtSG190ZaTA0awtp
         PPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ba1l5BCxj079539rifrbp0JUqAEjS/qS8MQ5M7nFD/s=;
        b=LjPrrfB1wgcGRakmGl6K54n/CQc50CzW145EobGs/68ayNXfFLX0KtzixCmQ7zrJKu
         zzCxf68tv63jL6/saJ9mt0n7b0s9MXRB834n/ICtwJiHhc/U8xGhPAHiT89Cca+6Y0c9
         2UtzaEXdcSPujyxTzWyPOWY88RXHVBZG78ltGToCNCFqLQR/uz6uOTGA7bHNqP4/O8FR
         vKp5QEXjcQozCTO7ytvcZmlY3ntcXuZNCV2OcbXmkz1Q+6EW//0wMcS9t0w+60b7FHT/
         J29wlDhMP64NWBOa+Y2MFxeZCx5sxgI/apbbOVtDk0WfEK0+5A+XdiRFHsKNG7bWqlFw
         vl7Q==
X-Gm-Message-State: APjAAAWULlwzFLhsQsMe+gTFY3cqP/itTKqcxzgoq5Tj55nT6hIosxa6
        iEHWrtt+YiHkakW/+s2RdklkfYlFYWQ=
X-Google-Smtp-Source: APXvYqygC+ofHEclEKTPDivcpnefTuDTH6jt2stzXNjyNI1A/Idvx6adjgG2PeBqsH3LSRNdqXfU6w==
X-Received: by 2002:a63:c548:: with SMTP id g8mr31810981pgd.451.1553700472483;
        Wed, 27 Mar 2019 08:27:52 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g4sm6953943pfm.115.2019.03.27.08.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 08:27:51 -0700 (PDT)
Date:   Wed, 27 Mar 2019 09:27:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
Subject: Re: [PATCH 05/25] coresight: Merge the static and dynamic replicator
 drivers
Message-ID: <20190327152749.GC1658@xps15>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-6-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553107783-3340-6-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 06:49:22PM +0000, Suzuki K Poulose wrote:
> Merge the drivers for the two varieties of replicators into
> a singel one. The dynamic replicator has programming base
> which can be programmed to filter the trace data. The driver
> detects the type based on the "base" address value of the
> device, which is NULL for the static device.
> 
> Also, while at it, remove the now obsolete DYNAMIC_REPLICATOR
> config entry.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I'll pickup patches 1 to 5 immediately as they are useful on their own.

Mathieu


> ---
>  drivers/hwtracing/coresight/Kconfig                |   8 -
>  drivers/hwtracing/coresight/Makefile               |   1 -
>  .../coresight/coresight-dynamic-replicator.c       | 285 ---------------------
>  drivers/hwtracing/coresight/coresight-replicator.c | 174 ++++++++++++-
>  4 files changed, 169 insertions(+), 299 deletions(-)
>  delete mode 100644 drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ad34380..a40d796 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -81,14 +81,6 @@ config CORESIGHT_SOURCE_ETM4X
>  	  for instruction level tracing. Depending on the implemented version
>  	  data tracing may also be available.
>  
> -config CORESIGHT_DYNAMIC_REPLICATOR
> -	bool "CoreSight Programmable Replicator driver"
> -	depends on CORESIGHT_LINKS_AND_SINKS
> -	help
> -	  This enables support for dynamic CoreSight replicator link driver.
> -	  The programmable ATB replicator allows independent filtering of the
> -	  trace data based on the traceid.
> -
>  config CORESIGHT_STM
>  	bool "CoreSight System Trace Macrocell driver"
>  	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 41870de..3b435aa 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -15,7 +15,6 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
>  					coresight-etm3x-sysfs.o
>  obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
>  					coresight-etm4x-sysfs.o
> -obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
>  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>  obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> deleted file mode 100644
> index b7d7c41..0000000
> --- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> +++ /dev/null
> @@ -1,285 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
> - */
> -
> -#include <linux/amba/bus.h>
> -#include <linux/clk.h>
> -#include <linux/coresight.h>
> -#include <linux/device.h>
> -#include <linux/err.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -#include <linux/kernel.h>
> -#include <linux/of.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/slab.h>
> -
> -#include "coresight-priv.h"
> -
> -#define REPLICATOR_IDFILTER0		0x000
> -#define REPLICATOR_IDFILTER1		0x004
> -
> -/**
> - * struct replicator_drvdata - specifics associated to a replicator component
> - * @base:	memory mapped base address for this component.
> - * @dev:	the device entity associated with this component
> - * @atclk:	optional clock for the core parts of the replicator.
> - * @csdev:	component vitals needed by the framework
> - */
> -struct replicator_drvdata {
> -	void __iomem		*base;
> -	struct device		*dev;
> -	struct clk		*atclk;
> -	struct coresight_device	*csdev;
> -};
> -
> -/*
> - * dynamic_replicator_reset : Reset the replicator configuration to sane values.
> - */
> -static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
> -{
> -	CS_UNLOCK(drvdata->base);
> -
> -	if (!coresight_claim_device_unlocked(drvdata->base)) {
> -		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
> -		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
> -		coresight_disclaim_device_unlocked(drvdata->base);
> -	}
> -
> -	CS_LOCK(drvdata->base);
> -}
> -
> -static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
> -				     int inport, int outport)
> -{
> -	int rc = 0;
> -	u32 reg;
> -
> -	switch (outport) {
> -	case 0:
> -		reg = REPLICATOR_IDFILTER0;
> -		break;
> -	case 1:
> -		reg = REPLICATOR_IDFILTER1;
> -		break;
> -	default:
> -		WARN_ON(1);
> -		return -EINVAL;
> -	}
> -
> -	CS_UNLOCK(drvdata->base);
> -
> -	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
> -	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
> -		rc = coresight_claim_device_unlocked(drvdata->base);
> -
> -	/* Ensure that the outport is enabled. */
> -	if (!rc)
> -		writel_relaxed(0x00, drvdata->base + reg);
> -	CS_LOCK(drvdata->base);
> -
> -	return rc;
> -}
> -
> -static int replicator_enable(struct coresight_device *csdev, int inport,
> -			     int outport)
> -{
> -	int rc = 0;
> -	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	rc = dynamic_replicator_enable(drvdata, inport, outport);
> -	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
> -	return rc;
> -}
> -
> -static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
> -				       int inport, int outport)
> -{
> -	u32 reg;
> -
> -	switch (outport) {
> -	case 0:
> -		reg = REPLICATOR_IDFILTER0;
> -		break;
> -	case 1:
> -		reg = REPLICATOR_IDFILTER1;
> -		break;
> -	default:
> -		WARN_ON(1);
> -		return;
> -	}
> -
> -	CS_UNLOCK(drvdata->base);
> -
> -	/* disable the flow of ATB data through port */
> -	writel_relaxed(0xff, drvdata->base + reg);
> -
> -	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
> -	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
> -		coresight_disclaim_device_unlocked(drvdata->base);
> -	CS_LOCK(drvdata->base);
> -}
> -
> -static void replicator_disable(struct coresight_device *csdev, int inport,
> -			       int outport)
> -{
> -	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	dynamic_replicator_disable(drvdata, inport, outport);
> -	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
> -}
> -
> -static const struct coresight_ops_link replicator_link_ops = {
> -	.enable		= replicator_enable,
> -	.disable	= replicator_disable,
> -};
> -
> -static const struct coresight_ops replicator_cs_ops = {
> -	.link_ops	= &replicator_link_ops,
> -};
> -
> -#define coresight_replicator_reg(name, offset) \
> -	coresight_simple_reg32(struct replicator_drvdata, name, offset)
> -
> -coresight_replicator_reg(idfilter0, REPLICATOR_IDFILTER0);
> -coresight_replicator_reg(idfilter1, REPLICATOR_IDFILTER1);
> -
> -static struct attribute *replicator_mgmt_attrs[] = {
> -	&dev_attr_idfilter0.attr,
> -	&dev_attr_idfilter1.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group replicator_mgmt_group = {
> -	.attrs = replicator_mgmt_attrs,
> -	.name = "mgmt",
> -};
> -
> -static const struct attribute_group *replicator_groups[] = {
> -	&replicator_mgmt_group,
> -	NULL,
> -};
> -
> -static int replicator_probe(struct device *dev, struct resource *res)
> -{
> -	int ret = 0;
> -	struct coresight_platform_data *pdata = NULL;
> -	struct replicator_drvdata *drvdata;
> -	struct coresight_desc desc = { 0 };
> -	struct device_node *np = dev->of_node;
> -	void __iomem *base;
> -
> -	if (np) {
> -		pdata = of_get_coresight_platform_data(dev, np);
> -		if (IS_ERR(pdata))
> -			return PTR_ERR(pdata);
> -		dev->platform_data = pdata;
> -	}
> -
> -	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> -	if (!drvdata)
> -		return -ENOMEM;
> -
> -	drvdata->dev = dev;
> -	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
> -	if (!IS_ERR(drvdata->atclk)) {
> -		ret = clk_prepare_enable(drvdata->atclk);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	/*
> -	 * Map the device base for dynamic-replicator, which has been
> -	 * validated by AMBA core
> -	 */
> -	if (res) {
> -		base = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(base)) {
> -			ret = PTR_ERR(base);
> -			goto out_disable_clk;
> -		}
> -		drvdata->base = base;
> -		desc.groups = replicator_groups;
> -	}
> -
> -	dev_set_drvdata(dev, drvdata);
> -
> -	desc.type = CORESIGHT_DEV_TYPE_LINK;
> -	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
> -	desc.ops = &replicator_cs_ops;
> -	desc.pdata = dev->platform_data;
> -	desc.dev = dev;
> -	drvdata->csdev = coresight_register(&desc);
> -
> -	if (IS_ERR(drvdata->csdev)) {
> -		ret = PTR_ERR(drvdata->csdev);
> -		goto out_disable_clk;
> -	}
> -
> -	dynamic_replicator_reset(drvdata);
> -	pm_runtime_put(dev);
> -
> -out_disable_clk:
> -	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
> -		clk_disable_unprepare(drvdata->atclk);
> -	return ret;
> -}
> -
> -static int dynamic_replicator_probe(struct amba_device *adev,
> -				    const struct amba_id *id)
> -{
> -	return replicator_probe(&adev->dev, &adev->res);
> -}
> -
> -#ifdef CONFIG_PM
> -static int replicator_runtime_suspend(struct device *dev)
> -{
> -	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
> -
> -	if (drvdata && !IS_ERR(drvdata->atclk))
> -		clk_disable_unprepare(drvdata->atclk);
> -
> -	return 0;
> -}
> -
> -static int replicator_runtime_resume(struct device *dev)
> -{
> -	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
> -
> -	if (drvdata && !IS_ERR(drvdata->atclk))
> -		clk_prepare_enable(drvdata->atclk);
> -
> -	return 0;
> -}
> -#endif
> -
> -static const struct dev_pm_ops replicator_dev_pm_ops = {
> -	SET_RUNTIME_PM_OPS(replicator_runtime_suspend,
> -			   replicator_runtime_resume,
> -			   NULL)
> -};
> -
> -static const struct amba_id dynamic_replicator_ids[] = {
> -	{
> -		.id     = 0x000bb909,
> -		.mask   = 0x000fffff,
> -	},
> -	{
> -		/* Coresight SoC-600 */
> -		.id     = 0x000bb9ec,
> -		.mask   = 0x000fffff,
> -	},
> -	{ 0, 0 },
> -};
> -
> -static struct amba_driver dynamic_replicator_driver = {
> -	.drv = {
> -		.name	= "coresight-dynamic-replicator",
> -		.pm	= &replicator_dev_pm_ops,
> -		.suppress_bind_attrs = true,
> -	},
> -	.probe		= dynamic_replicator_probe,
> -	.id_table	= dynamic_replicator_ids,
> -};
> -builtin_amba_driver(dynamic_replicator_driver);
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 43cbcf1..4e0da85 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -1,10 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
>   *
>   * Description: CoreSight Replicator driver
>   */
>  
> +#include <linux/amba/bus.h>
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> @@ -18,25 +19,117 @@
>  
>  #include "coresight-priv.h"
>  
> +#define REPLICATOR_IDFILTER0		0x000
> +#define REPLICATOR_IDFILTER1		0x004
> +
>  /**
>   * struct replicator_drvdata - specifics associated to a replicator component
> + * @base:	memory mapped base address for this component. Also indicates
> + *		whether this one is programmable or not.
>   * @dev:	the device entity associated with this component
>   * @atclk:	optional clock for the core parts of the replicator.
>   * @csdev:	component vitals needed by the framework
>   */
>  struct replicator_drvdata {
> +	void __iomem		*base;
>  	struct device		*dev;
>  	struct clk		*atclk;
>  	struct coresight_device	*csdev;
>  };
>  
> +static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
> +{
> +	CS_UNLOCK(drvdata->base);
> +
> +	if (!coresight_claim_device_unlocked(drvdata->base)) {
> +		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
> +		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
> +		coresight_disclaim_device_unlocked(drvdata->base);
> +	}
> +
> +	CS_LOCK(drvdata->base);
> +}
> +
> +/*
> + * replicator_reset : Reset the replicator configuration to sane values.
> + */
> +static inline void replicator_reset(struct replicator_drvdata *drvdata)
> +{
> +	if (drvdata->base)
> +		dynamic_replicator_reset(drvdata);
> +}
> +
> +static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
> +				     int inport, int outport)
> +{
> +	int rc = 0;
> +	u32 reg;
> +
> +	switch (outport) {
> +	case 0:
> +		reg = REPLICATOR_IDFILTER0;
> +		break;
> +	case 1:
> +		reg = REPLICATOR_IDFILTER1;
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
> +	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
> +		rc = coresight_claim_device_unlocked(drvdata->base);
> +
> +	/* Ensure that the outport is enabled. */
> +	if (!rc)
> +		writel_relaxed(0x00, drvdata->base + reg);
> +	CS_LOCK(drvdata->base);
> +
> +	return rc;
> +}
> +
>  static int replicator_enable(struct coresight_device *csdev, int inport,
>  			     int outport)
>  {
> +	int rc = 0;
>  	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> -	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
> -	return 0;
> +	if (drvdata->base)
> +		rc = dynamic_replicator_enable(drvdata, inport, outport);
> +	if (!rc)
> +		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
> +	return rc;
> +}
> +
> +static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
> +				       int inport, int outport)
> +{
> +	u32 reg;
> +
> +	switch (outport) {
> +	case 0:
> +		reg = REPLICATOR_IDFILTER0;
> +		break;
> +	case 1:
> +		reg = REPLICATOR_IDFILTER1;
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return;
> +	}
> +
> +	CS_UNLOCK(drvdata->base);
> +
> +	/* disable the flow of ATB data through port */
> +	writel_relaxed(0xff, drvdata->base + reg);
> +
> +	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
> +	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
> +		coresight_disclaim_device_unlocked(drvdata->base);
> +	CS_LOCK(drvdata->base);
>  }
>  
>  static void replicator_disable(struct coresight_device *csdev, int inport,
> @@ -44,6 +137,8 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>  {
>  	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
> +	if (drvdata->base)
> +		dynamic_replicator_disable(drvdata, inport, outport);
>  	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
>  }
>  
> @@ -56,13 +151,36 @@ static const struct coresight_ops replicator_cs_ops = {
>  	.link_ops	= &replicator_link_ops,
>  };
>  
> -static int replicator_probe(struct device *dev)
> +#define coresight_replicator_reg(name, offset) \
> +	coresight_simple_reg32(struct replicator_drvdata, name, offset)
> +
> +coresight_replicator_reg(idfilter0, REPLICATOR_IDFILTER0);
> +coresight_replicator_reg(idfilter1, REPLICATOR_IDFILTER1);
> +
> +static struct attribute *replicator_mgmt_attrs[] = {
> +	&dev_attr_idfilter0.attr,
> +	&dev_attr_idfilter1.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group replicator_mgmt_group = {
> +	.attrs = replicator_mgmt_attrs,
> +	.name = "mgmt",
> +};
> +
> +static const struct attribute_group *replicator_groups[] = {
> +	&replicator_mgmt_group,
> +	NULL,
> +};
> +
> +static int replicator_probe(struct device *dev, struct resource *res)
>  {
>  	int ret = 0;
>  	struct coresight_platform_data *pdata = NULL;
>  	struct replicator_drvdata *drvdata;
>  	struct coresight_desc desc = { 0 };
>  	struct device_node *np = dev->of_node;
> +	void __iomem *base;
>  
>  	if (np) {
>  		pdata = of_get_coresight_platform_data(dev, np);
> @@ -83,6 +201,20 @@ static int replicator_probe(struct device *dev)
>  			return ret;
>  	}
>  
> +	/*
> +	 * Map the device base for dynamic-replicator, which has been
> +	 * validated by AMBA core
> +	 */
> +	if (res) {
> +		base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(base)) {
> +			ret = PTR_ERR(base);
> +			goto out_disable_clk;
> +		}
> +		drvdata->base = base;
> +		desc.groups = replicator_groups;
> +	}
> +
>  	dev_set_drvdata(dev, drvdata);
>  
>  	desc.type = CORESIGHT_DEV_TYPE_LINK;
> @@ -96,6 +228,7 @@ static int replicator_probe(struct device *dev)
>  		goto out_disable_clk;
>  	}
>  
> +	replicator_reset(drvdata);
>  	pm_runtime_put(dev);
>  
>  out_disable_clk:
> @@ -112,7 +245,8 @@ static int static_replicator_probe(struct platform_device *pdev)
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
> -	ret = replicator_probe(&pdev->dev);
> +	/* Static replicators do not have programming base */
> +	ret = replicator_probe(&pdev->dev, NULL);
>  
>  	if (ret) {
>  		pm_runtime_put_noidle(&pdev->dev);
> @@ -164,3 +298,33 @@ static struct platform_driver static_replicator_driver = {
>  	},
>  };
>  builtin_platform_driver(static_replicator_driver);
> +
> +static int dynamic_replicator_probe(struct amba_device *adev,
> +				    const struct amba_id *id)
> +{
> +	return replicator_probe(&adev->dev, &adev->res);
> +}
> +
> +static const struct amba_id dynamic_replicator_ids[] = {
> +	{
> +		.id     = 0x000bb909,
> +		.mask   = 0x000fffff,
> +	},
> +	{
> +		/* Coresight SoC-600 */
> +		.id     = 0x000bb9ec,
> +		.mask   = 0x000fffff,
> +	},
> +	{ 0, 0 },
> +};
> +
> +static struct amba_driver dynamic_replicator_driver = {
> +	.drv = {
> +		.name	= "coresight-dynamic-replicator",
> +		.pm	= &replicator_dev_pm_ops,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe		= dynamic_replicator_probe,
> +	.id_table	= dynamic_replicator_ids,
> +};
> +builtin_amba_driver(dynamic_replicator_driver);
> -- 
> 2.7.4
> 
