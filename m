Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128A9C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63D4217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfEVKfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:35:43 -0400
Received: from foss.arm.com ([217.140.101.70]:47094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbfEVKfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57FD9341;
        Wed, 22 May 2019 03:35:40 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 483293F575;
        Wed, 22 May 2019 03:35:39 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 17/30] coresight: Make device to CPU mapping generic
Date:   Wed, 22 May 2019 11:34:50 +0100
Message-Id: <1558521304-27469-18-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CoreSight components ETM and CPU-Debug are always associated
with CPUs. Replace the of_coresight_get_cpu() with a platform
agnostic helper, in preparation to add ACPI support.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c |  3 +--
 drivers/hwtracing/coresight/coresight-platform.c  | 18 +++++++++++++-----
 include/linux/coresight.h                         |  7 +------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index e8819d7..07a1367 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -572,14 +572,13 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
 	struct device *dev = &adev->dev;
 	struct debug_drvdata *drvdata;
 	struct resource *res = &adev->res;
-	struct device_node *np = adev->dev.of_node;
 	int ret;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
+	drvdata->cpu = coresight_get_cpu(dev);
 	if (per_cpu(debug_drvdata, drvdata->cpu)) {
 		dev_err(dev, "CPU%d drvdata has already been initialized\n",
 			drvdata->cpu);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 5d78f4f..ba8c146 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -151,12 +151,14 @@ static void of_coresight_get_ports(const struct device_node *node,
 	}
 }
 
-int of_coresight_get_cpu(const struct device_node *node)
+static int of_coresight_get_cpu(struct device *dev)
 {
 	int cpu;
 	struct device_node *dn;
 
-	dn = of_parse_phandle(node, "cpu", 0);
+	if (!dev->of_node)
+		return 0;
+	dn = of_parse_phandle(dev->of_node, "cpu", 0);
 	/* Affinity defaults to CPU0 */
 	if (!dn)
 		return 0;
@@ -166,7 +168,6 @@ int of_coresight_get_cpu(const struct device_node *node)
 	/* Affinity to CPU0 if no cpu nodes are found */
 	return (cpu < 0) ? 0 : cpu;
 }
-EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
 
 /*
  * of_coresight_parse_endpoint : Parse the given output endpoint @ep
@@ -240,8 +241,6 @@ static int of_get_coresight_platform_data(struct device *dev,
 	bool legacy_binding = false;
 	struct device_node *node = dev->of_node;
 
-	pdata->cpu = of_coresight_get_cpu(node);
-
 	/* Get the number of input and output port for this component */
 	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
 
@@ -300,6 +299,14 @@ of_get_coresight_platform_data(struct device *dev,
 }
 #endif
 
+int coresight_get_cpu(struct device *dev)
+{
+	if (is_of_node(dev->fwnode))
+		return of_coresight_get_cpu(dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(coresight_get_cpu);
+
 struct coresight_platform_data *
 coresight_get_platform_data(struct device *dev)
 {
@@ -318,6 +325,7 @@ coresight_get_platform_data(struct device *dev)
 
 	/* Use device name as sysfs handle */
 	pdata->name = dev_name(dev);
+	pdata->cpu = coresight_get_cpu(dev);
 
 	if (is_of_node(fwnode))
 		ret = of_get_coresight_platform_data(dev, pdata);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index e2b95e0..98a4440 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -292,12 +292,7 @@ static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
 
 #endif
 
-#ifdef CONFIG_OF
-extern int of_coresight_get_cpu(const struct device_node *node);
-#else
-static inline int of_coresight_get_cpu(const struct device_node *node)
-{ return 0; }
-#endif
+extern int coresight_get_cpu(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
 
-- 
2.7.4

