Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B36A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfCTSun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:43 -0400
Received: from foss.arm.com ([217.140.101.70]:44984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfCTSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8EDC1BF7;
        Wed, 20 Mar 2019 11:50:40 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F36C3F59C;
        Wed, 20 Mar 2019 11:50:39 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 18/25] coresight: Introduce generic platform data helper
Date:   Wed, 20 Mar 2019 18:49:35 +0000
Message-Id: <1553107783-3340-19-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we have hard coded the DT platform parsing code in
every driver. Introduce generic helper to parse the information
provided by the firmware in a platform agnostic manner, in preparation
for the ACPI support.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 13 ++---
 drivers/hwtracing/coresight/coresight-etb10.c      | 11 ++--
 drivers/hwtracing/coresight/coresight-etm3x.c      | 12 ++--
 drivers/hwtracing/coresight/coresight-etm4x.c      | 11 ++--
 drivers/hwtracing/coresight/coresight-funnel.c     | 11 ++--
 drivers/hwtracing/coresight/coresight-platform.c   | 65 +++++++++++++---------
 drivers/hwtracing/coresight/coresight-replicator.c | 12 ++--
 drivers/hwtracing/coresight/coresight-stm.c        | 11 ++--
 drivers/hwtracing/coresight/coresight-tmc.c        | 13 ++---
 drivers/hwtracing/coresight/coresight-tpiu.c       | 11 ++--
 include/linux/coresight.h                          |  7 +--
 11 files changed, 80 insertions(+), 97 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 671a05a..4595c67 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -503,17 +503,14 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	struct coresight_desc catu_desc;
 	struct coresight_platform_data *pdata = NULL;
 	struct device *dev = &adev->dev;
-	struct device_node *np = dev->of_node;
 	void __iomem *base;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata)) {
-			ret = PTR_ERR(pdata);
-			goto out;
-		}
-		dev->platform_data = pdata;
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata)) {
+		ret = PTR_ERR(pdata);
+		goto out;
 	}
+	dev->platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata) {
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index a471cbd..e4175849 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -688,14 +688,11 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	struct etb_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = adev->dev.of_node;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-		adev->dev.platform_data = pdata;
-	}
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 7137f06..b101464 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -788,20 +788,16 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct etm_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = adev->dev.of_node;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-
-		adev->dev.platform_data = pdata;
-	}
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
 
+	adev->dev.platform_data = pdata;
 	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
 	dev_set_drvdata(dev, drvdata);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 8d5ee3b..bfc23ab 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -974,18 +974,15 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	struct etmv4_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = adev->dev.of_node;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-		adev->dev.platform_data = pdata;
-	}
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
 
 	dev_set_drvdata(dev, drvdata);
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 1085f31..2590744 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -185,14 +185,11 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	struct funnel_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = adev->dev.of_node;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-		adev->dev.platform_data = pdata;
-	}
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 514cc2b..693e3f5 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -17,6 +17,20 @@
 #include <linux/cpumask.h>
 #include <asm/smp_plat.h>
 
+static int coresight_alloc_conns(struct device *dev,
+				 struct coresight_platform_data *pdata)
+{
+	if (pdata->nr_outport) {
+		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
+					    sizeof(*pdata->conns),
+					    GFP_KERNEL);
+		if (!pdata->conns)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static int of_dev_node_match(struct device *dev, void *data)
 {
@@ -133,20 +147,6 @@ static void of_coresight_get_ports(const struct device_node *node,
 	}
 }
 
-static int of_coresight_alloc_memory(struct device *dev,
-			struct coresight_platform_data *pdata)
-{
-	if (pdata->nr_outport) {
-		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
-					    sizeof(*pdata->conns),
-					    GFP_KERNEL);
-		if (!pdata->conns)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
 int of_coresight_get_cpu(const struct device_node *node)
 {
 	int cpu;
@@ -226,23 +226,17 @@ static int of_coresight_parse_endpoint(struct device *dev,
 	return ret;
 }
 
-struct coresight_platform_data *
+static struct coresight_platform_data *
 of_get_coresight_platform_data(struct device *dev,
-			       const struct device_node *node)
+			       struct coresight_platform_data *pdata)
 {
 	int ret = 0;
-	struct coresight_platform_data *pdata;
 	struct coresight_connection *conn;
 	struct device_node *ep = NULL;
 	const struct device_node *parent = NULL;
 	bool legacy_binding = false;
+	struct device_node *node = dev->of_node;
 
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	/* Use device name as sysfs handle */
-	pdata->name = dev_name(dev);
 	pdata->cpu = of_coresight_get_cpu(node);
 
 	/* Get the number of input and output port for this component */
@@ -252,7 +246,7 @@ of_get_coresight_platform_data(struct device *dev,
 	if (!pdata->nr_outport)
 		return pdata;
 
-	ret = of_coresight_alloc_memory(dev, pdata);
+	ret = coresight_alloc_conns(dev, pdata);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -294,5 +288,26 @@ of_get_coresight_platform_data(struct device *dev,
 
 	return pdata;
 }
-EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
 #endif
+
+struct coresight_platform_data *
+coresight_get_platform_data(struct device *dev)
+{
+	struct coresight_platform_data *pdata;
+
+	if (IS_ERR_OR_NULL(dev->fwnode))
+		return NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	/* Use device name as sysfs handle */
+	pdata->name = dev_name(dev);
+
+	if (is_of_node(dev->fwnode))
+		return of_get_coresight_platform_data(dev, pdata);
+
+	return ERR_PTR(-ENOENT);
+}
+EXPORT_SYMBOL_GPL(coresight_get_platform_data);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 8bbb008..7eb3bf7 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -177,15 +177,12 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	struct coresight_platform_data *pdata = NULL;
 	struct replicator_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = dev->of_node;
 	void __iomem *base;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-		dev->platform_data = pdata;
-	}
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	dev->platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -213,7 +210,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	}
 
 	dev_set_drvdata(dev, drvdata);
-
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc.ops = &replicator_cs_ops;
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index eb96bba..6514586 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -809,14 +809,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	size_t bitmap_size;
 	struct coresight_desc desc = { 0 };
 	struct coresight_device *csdev;
-	struct device_node *np = adev->dev.of_node;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-		adev->dev.platform_data = pdata;
-	}
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 7ce3427..147ab17 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -394,16 +394,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	struct tmc_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = adev->dev.of_node;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata)) {
-			ret = PTR_ERR(pdata);
-			goto out;
-		}
-		adev->dev.platform_data = pdata;
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata)) {
+		ret = PTR_ERR(pdata);
+		goto out;
 	}
+	adev->dev.platform_data = pdata;
 
 	ret = -ENOMEM;
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 9763721..18a749a 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -120,14 +120,11 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 	struct coresight_device *csdev;
-	struct device_node *np = adev->dev.of_node;
 
-	if (np) {
-		pdata = of_get_coresight_platform_data(dev, np);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-		adev->dev.platform_data = pdata;
-	}
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 7b87965..5b29255 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -293,14 +293,11 @@ static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
 
 #ifdef CONFIG_OF
 extern int of_coresight_get_cpu(const struct device_node *node);
-extern struct coresight_platform_data *
-of_get_coresight_platform_data(struct device *dev,
-			       const struct device_node *node);
 #else
 static inline int of_coresight_get_cpu(const struct device_node *node)
 { return 0; }
-static inline struct coresight_platform_data *of_get_coresight_platform_data(
-	struct device *dev, const struct device_node *node) { return NULL; }
 #endif
 
+struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
+
 #endif
-- 
2.7.4

