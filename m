Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C4C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DF2205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OobObrhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbfDYTzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:55:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41309 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbfDYTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so308909pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ODmt6mTinl87zt7U+SaDi+ecpEn3Z4Nl4lSlwfYHCAU=;
        b=OobObrhHTyQ90G05Srm0vhk6l9yYarEdEygY53eHuP4Vn5e5sl7bdhfKhisdunb2GA
         mVomzAQ/HXit4+qy1oW6CCVBVna2F9clf5hF9z1soVV8npkN8O+6G6iH8rPcMvkfucb2
         +4BO0hqfIqmbOtPCpgVeq6U1WpMhAMG2I0O00LgR/UTGXHPjjIRwy6pLwB+CL2kWbenu
         JJiKtcLZbPb5Um8WKKULPy1DqTgwiLFoAA82bYGF7cLD1qjDQkJ3Of3A6plpjXql1Nxy
         pyUfRh0AkOCAaMYvGeaOXfncBAPmfm0aLCwh3gge1nFNWHMV5Sh6NjtqCyuNbRl635G8
         xivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ODmt6mTinl87zt7U+SaDi+ecpEn3Z4Nl4lSlwfYHCAU=;
        b=rVc+3bEYY+Ok8EUtn1WSZk8HhyQ42XyW/0pvr4q8iPVFi2cW2Zi1IXeytcBrcttEYu
         U9BIWYdnxFUD+KbCQeA8lNKMixVmFmq3ykE6RWmzyfmGPYtXUn8af/EvWOhFjmGEMeS6
         Zakoi+qInMhGbs9ZBaIKBLJBNdpPOX8yqwDuwMVVTQsKPhCcYuowslTCNyV7ET5tLfGp
         mZdYS9Fp4pF05fgSvVTup6wknxZMQINqaK7hW6NbsYlEhCAARJOsQe9GcZ7sBrROAMjS
         kJYnMZUViJR7YSmXM/YDdEAFBehCniuh+UJhiNrtkJffBn4BAItF6JCzxK7IGrKGjK7c
         t0KA==
X-Gm-Message-State: APjAAAVfruZDhFSqEj0hlarM7fdYKZI4mD/XY5HXCdQkKILXGOOE+I+s
        DR0C1YycDx+YQPSDTLJUvbfe1g1toYU=
X-Google-Smtp-Source: APXvYqwhgs1cNv4JSMpabHV1KHLeMZcdoDt6gRvrhQ1wiTBLNXNWN7a9JmhHXkWawfesgCRLX0RZfg==
X-Received: by 2002:a17:902:4381:: with SMTP id j1mr40772667pld.173.1556222001529;
        Thu, 25 Apr 2019 12:53:21 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:20 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/32] coresight: Merge the static and dynamic replicator drivers
Date:   Thu, 25 Apr 2019 13:52:45 -0600
Message-Id: <20190425195310.31562-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Merge the drivers for the two varieties of replicators into
a singel one. The dynamic replicator has programming base
which can be programmed to filter the trace data. The driver
detects the type based on the "base" address value of the
device, which is NULL for the static device.

Also, while at it, remove the now obsolete DYNAMIC_REPLICATOR
config entry.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |   8 -
 drivers/hwtracing/coresight/Makefile          |   1 -
 .../coresight/coresight-dynamic-replicator.c  | 285 ------------------
 .../coresight/coresight-replicator.c          | 174 ++++++++++-
 4 files changed, 169 insertions(+), 299 deletions(-)
 delete mode 100644 drivers/hwtracing/coresight/coresight-dynamic-replicator.c

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ad34380cac49..a40d796f0a4b 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -81,14 +81,6 @@ config CORESIGHT_SOURCE_ETM4X
 	  for instruction level tracing. Depending on the implemented version
 	  data tracing may also be available.
 
-config CORESIGHT_DYNAMIC_REPLICATOR
-	bool "CoreSight Programmable Replicator driver"
-	depends on CORESIGHT_LINKS_AND_SINKS
-	help
-	  This enables support for dynamic CoreSight replicator link driver.
-	  The programmable ATB replicator allows independent filtering of the
-	  trace data based on the traceid.
-
 config CORESIGHT_STM
 	bool "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 41870ded51a3..3b435aa42af5 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
 					coresight-etm3x-sysfs.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
 					coresight-etm4x-sysfs.o
-obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
 obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
deleted file mode 100644
index b7d7c4146f9a..000000000000
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ /dev/null
@@ -1,285 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
- */
-
-#include <linux/amba/bus.h>
-#include <linux/clk.h>
-#include <linux/coresight.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/pm_runtime.h>
-#include <linux/slab.h>
-
-#include "coresight-priv.h"
-
-#define REPLICATOR_IDFILTER0		0x000
-#define REPLICATOR_IDFILTER1		0x004
-
-/**
- * struct replicator_drvdata - specifics associated to a replicator component
- * @base:	memory mapped base address for this component.
- * @dev:	the device entity associated with this component
- * @atclk:	optional clock for the core parts of the replicator.
- * @csdev:	component vitals needed by the framework
- */
-struct replicator_drvdata {
-	void __iomem		*base;
-	struct device		*dev;
-	struct clk		*atclk;
-	struct coresight_device	*csdev;
-};
-
-/*
- * dynamic_replicator_reset : Reset the replicator configuration to sane values.
- */
-static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
-{
-	CS_UNLOCK(drvdata->base);
-
-	if (!coresight_claim_device_unlocked(drvdata->base)) {
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
-		coresight_disclaim_device_unlocked(drvdata->base);
-	}
-
-	CS_LOCK(drvdata->base);
-}
-
-static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
-				     int inport, int outport)
-{
-	int rc = 0;
-	u32 reg;
-
-	switch (outport) {
-	case 0:
-		reg = REPLICATOR_IDFILTER0;
-		break;
-	case 1:
-		reg = REPLICATOR_IDFILTER1;
-		break;
-	default:
-		WARN_ON(1);
-		return -EINVAL;
-	}
-
-	CS_UNLOCK(drvdata->base);
-
-	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
-	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
-		rc = coresight_claim_device_unlocked(drvdata->base);
-
-	/* Ensure that the outport is enabled. */
-	if (!rc)
-		writel_relaxed(0x00, drvdata->base + reg);
-	CS_LOCK(drvdata->base);
-
-	return rc;
-}
-
-static int replicator_enable(struct coresight_device *csdev, int inport,
-			     int outport)
-{
-	int rc = 0;
-	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	rc = dynamic_replicator_enable(drvdata, inport, outport);
-	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
-	return rc;
-}
-
-static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
-				       int inport, int outport)
-{
-	u32 reg;
-
-	switch (outport) {
-	case 0:
-		reg = REPLICATOR_IDFILTER0;
-		break;
-	case 1:
-		reg = REPLICATOR_IDFILTER1;
-		break;
-	default:
-		WARN_ON(1);
-		return;
-	}
-
-	CS_UNLOCK(drvdata->base);
-
-	/* disable the flow of ATB data through port */
-	writel_relaxed(0xff, drvdata->base + reg);
-
-	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
-	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
-		coresight_disclaim_device_unlocked(drvdata->base);
-	CS_LOCK(drvdata->base);
-}
-
-static void replicator_disable(struct coresight_device *csdev, int inport,
-			       int outport)
-{
-	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	dynamic_replicator_disable(drvdata, inport, outport);
-	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
-}
-
-static const struct coresight_ops_link replicator_link_ops = {
-	.enable		= replicator_enable,
-	.disable	= replicator_disable,
-};
-
-static const struct coresight_ops replicator_cs_ops = {
-	.link_ops	= &replicator_link_ops,
-};
-
-#define coresight_replicator_reg(name, offset) \
-	coresight_simple_reg32(struct replicator_drvdata, name, offset)
-
-coresight_replicator_reg(idfilter0, REPLICATOR_IDFILTER0);
-coresight_replicator_reg(idfilter1, REPLICATOR_IDFILTER1);
-
-static struct attribute *replicator_mgmt_attrs[] = {
-	&dev_attr_idfilter0.attr,
-	&dev_attr_idfilter1.attr,
-	NULL,
-};
-
-static const struct attribute_group replicator_mgmt_group = {
-	.attrs = replicator_mgmt_attrs,
-	.name = "mgmt",
-};
-
-static const struct attribute_group *replicator_groups[] = {
-	&replicator_mgmt_group,
-	NULL,
-};
-
-static int replicator_probe(struct device *dev, struct resource *res)
-{
-	int ret = 0;
-	struct coresight_platform_data *pdata = NULL;
-	struct replicator_drvdata *drvdata;
-	struct coresight_desc desc = { 0 };
-	struct device_node *np = dev->of_node;
-	void __iomem *base;
-
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-		dev->platform_data = pdata;
-	}
-
-	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	drvdata->dev = dev;
-	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
-	if (!IS_ERR(drvdata->atclk)) {
-		ret = clk_prepare_enable(drvdata->atclk);
-		if (ret)
-			return ret;
-	}
-
-	/*
-	 * Map the device base for dynamic-replicator, which has been
-	 * validated by AMBA core
-	 */
-	if (res) {
-		base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(base)) {
-			ret = PTR_ERR(base);
-			goto out_disable_clk;
-		}
-		drvdata->base = base;
-		desc.groups = replicator_groups;
-	}
-
-	dev_set_drvdata(dev, drvdata);
-
-	desc.type = CORESIGHT_DEV_TYPE_LINK;
-	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
-	desc.ops = &replicator_cs_ops;
-	desc.pdata = dev->platform_data;
-	desc.dev = dev;
-	drvdata->csdev = coresight_register(&desc);
-
-	if (IS_ERR(drvdata->csdev)) {
-		ret = PTR_ERR(drvdata->csdev);
-		goto out_disable_clk;
-	}
-
-	dynamic_replicator_reset(drvdata);
-	pm_runtime_put(dev);
-
-out_disable_clk:
-	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
-		clk_disable_unprepare(drvdata->atclk);
-	return ret;
-}
-
-static int dynamic_replicator_probe(struct amba_device *adev,
-				    const struct amba_id *id)
-{
-	return replicator_probe(&adev->dev, &adev->res);
-}
-
-#ifdef CONFIG_PM
-static int replicator_runtime_suspend(struct device *dev)
-{
-	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
-
-	if (drvdata && !IS_ERR(drvdata->atclk))
-		clk_disable_unprepare(drvdata->atclk);
-
-	return 0;
-}
-
-static int replicator_runtime_resume(struct device *dev)
-{
-	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
-
-	if (drvdata && !IS_ERR(drvdata->atclk))
-		clk_prepare_enable(drvdata->atclk);
-
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops replicator_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(replicator_runtime_suspend,
-			   replicator_runtime_resume,
-			   NULL)
-};
-
-static const struct amba_id dynamic_replicator_ids[] = {
-	{
-		.id     = 0x000bb909,
-		.mask   = 0x000fffff,
-	},
-	{
-		/* Coresight SoC-600 */
-		.id     = 0x000bb9ec,
-		.mask   = 0x000fffff,
-	},
-	{ 0, 0 },
-};
-
-static struct amba_driver dynamic_replicator_driver = {
-	.drv = {
-		.name	= "coresight-dynamic-replicator",
-		.pm	= &replicator_dev_pm_ops,
-		.suppress_bind_attrs = true,
-	},
-	.probe		= dynamic_replicator_probe,
-	.id_table	= dynamic_replicator_ids,
-};
-builtin_amba_driver(dynamic_replicator_driver);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 43cbcf1e7be8..4e0da85efd2d 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
  *
  * Description: CoreSight Replicator driver
  */
 
+#include <linux/amba/bus.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
@@ -18,25 +19,117 @@
 
 #include "coresight-priv.h"
 
+#define REPLICATOR_IDFILTER0		0x000
+#define REPLICATOR_IDFILTER1		0x004
+
 /**
  * struct replicator_drvdata - specifics associated to a replicator component
+ * @base:	memory mapped base address for this component. Also indicates
+ *		whether this one is programmable or not.
  * @dev:	the device entity associated with this component
  * @atclk:	optional clock for the core parts of the replicator.
  * @csdev:	component vitals needed by the framework
  */
 struct replicator_drvdata {
+	void __iomem		*base;
 	struct device		*dev;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 };
 
+static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	if (!coresight_claim_device_unlocked(drvdata->base)) {
+		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+		coresight_disclaim_device_unlocked(drvdata->base);
+	}
+
+	CS_LOCK(drvdata->base);
+}
+
+/*
+ * replicator_reset : Reset the replicator configuration to sane values.
+ */
+static inline void replicator_reset(struct replicator_drvdata *drvdata)
+{
+	if (drvdata->base)
+		dynamic_replicator_reset(drvdata);
+}
+
+static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
+				     int inport, int outport)
+{
+	int rc = 0;
+	u32 reg;
+
+	switch (outport) {
+	case 0:
+		reg = REPLICATOR_IDFILTER0;
+		break;
+	case 1:
+		reg = REPLICATOR_IDFILTER1;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	CS_UNLOCK(drvdata->base);
+
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
+		rc = coresight_claim_device_unlocked(drvdata->base);
+
+	/* Ensure that the outport is enabled. */
+	if (!rc)
+		writel_relaxed(0x00, drvdata->base + reg);
+	CS_LOCK(drvdata->base);
+
+	return rc;
+}
+
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			     int outport)
 {
+	int rc = 0;
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
-	return 0;
+	if (drvdata->base)
+		rc = dynamic_replicator_enable(drvdata, inport, outport);
+	if (!rc)
+		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+	return rc;
+}
+
+static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
+				       int inport, int outport)
+{
+	u32 reg;
+
+	switch (outport) {
+	case 0:
+		reg = REPLICATOR_IDFILTER0;
+		break;
+	case 1:
+		reg = REPLICATOR_IDFILTER1;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	CS_UNLOCK(drvdata->base);
+
+	/* disable the flow of ATB data through port */
+	writel_relaxed(0xff, drvdata->base + reg);
+
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
+		coresight_disclaim_device_unlocked(drvdata->base);
+	CS_LOCK(drvdata->base);
 }
 
 static void replicator_disable(struct coresight_device *csdev, int inport,
@@ -44,6 +137,8 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	if (drvdata->base)
+		dynamic_replicator_disable(drvdata, inport, outport);
 	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
@@ -56,13 +151,36 @@ static const struct coresight_ops replicator_cs_ops = {
 	.link_ops	= &replicator_link_ops,
 };
 
-static int replicator_probe(struct device *dev)
+#define coresight_replicator_reg(name, offset) \
+	coresight_simple_reg32(struct replicator_drvdata, name, offset)
+
+coresight_replicator_reg(idfilter0, REPLICATOR_IDFILTER0);
+coresight_replicator_reg(idfilter1, REPLICATOR_IDFILTER1);
+
+static struct attribute *replicator_mgmt_attrs[] = {
+	&dev_attr_idfilter0.attr,
+	&dev_attr_idfilter1.attr,
+	NULL,
+};
+
+static const struct attribute_group replicator_mgmt_group = {
+	.attrs = replicator_mgmt_attrs,
+	.name = "mgmt",
+};
+
+static const struct attribute_group *replicator_groups[] = {
+	&replicator_mgmt_group,
+	NULL,
+};
+
+static int replicator_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
 	struct coresight_platform_data *pdata = NULL;
 	struct replicator_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
 	struct device_node *np = dev->of_node;
+	void __iomem *base;
 
 	if (np) {
 		pdata = of_get_coresight_platform_data(dev, np);
@@ -83,6 +201,20 @@ static int replicator_probe(struct device *dev)
 			return ret;
 	}
 
+	/*
+	 * Map the device base for dynamic-replicator, which has been
+	 * validated by AMBA core
+	 */
+	if (res) {
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base)) {
+			ret = PTR_ERR(base);
+			goto out_disable_clk;
+		}
+		drvdata->base = base;
+		desc.groups = replicator_groups;
+	}
+
 	dev_set_drvdata(dev, drvdata);
 
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
@@ -96,6 +228,7 @@ static int replicator_probe(struct device *dev)
 		goto out_disable_clk;
 	}
 
+	replicator_reset(drvdata);
 	pm_runtime_put(dev);
 
 out_disable_clk:
@@ -112,7 +245,8 @@ static int static_replicator_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = replicator_probe(&pdev->dev);
+	/* Static replicators do not have programming base */
+	ret = replicator_probe(&pdev->dev, NULL);
 
 	if (ret) {
 		pm_runtime_put_noidle(&pdev->dev);
@@ -164,3 +298,33 @@ static struct platform_driver static_replicator_driver = {
 	},
 };
 builtin_platform_driver(static_replicator_driver);
+
+static int dynamic_replicator_probe(struct amba_device *adev,
+				    const struct amba_id *id)
+{
+	return replicator_probe(&adev->dev, &adev->res);
+}
+
+static const struct amba_id dynamic_replicator_ids[] = {
+	{
+		.id     = 0x000bb909,
+		.mask   = 0x000fffff,
+	},
+	{
+		/* Coresight SoC-600 */
+		.id     = 0x000bb9ec,
+		.mask   = 0x000fffff,
+	},
+	{ 0, 0 },
+};
+
+static struct amba_driver dynamic_replicator_driver = {
+	.drv = {
+		.name	= "coresight-dynamic-replicator",
+		.pm	= &replicator_dev_pm_ops,
+		.suppress_bind_attrs = true,
+	},
+	.probe		= dynamic_replicator_probe,
+	.id_table	= dynamic_replicator_ids,
+};
+builtin_amba_driver(dynamic_replicator_driver);
-- 
2.17.1

