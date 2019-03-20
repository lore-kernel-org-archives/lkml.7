Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A8CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA0C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCTSuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44820 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbfCTSuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B1E0A78;
        Wed, 20 Mar 2019 11:50:16 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9553D3F59C;
        Wed, 20 Mar 2019 11:50:14 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 04/25] coresight: dynamic-replicator: Prepare for merging with static replicator
Date:   Wed, 20 Mar 2019 18:49:21 +0000
Message-Id: <1553107783-3340-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the dynamic replicator specific routines for merging with the
replicator driver. Also re-arrange the probe routine to make it easier
to merge.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../coresight/coresight-dynamic-replicator.c       | 104 +++++++++++++--------
 1 file changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index fe176b9..b7d7c41 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -21,13 +21,13 @@
 #define REPLICATOR_IDFILTER1		0x004
 
 /**
- * struct replicator_state - specifics associated to a replicator component
+ * struct replicator_drvdata - specifics associated to a replicator component
  * @base:	memory mapped base address for this component.
  * @dev:	the device entity associated with this component
  * @atclk:	optional clock for the core parts of the replicator.
  * @csdev:	component vitals needed by the framework
  */
-struct replicator_state {
+struct replicator_drvdata {
 	void __iomem		*base;
 	struct device		*dev;
 	struct clk		*atclk;
@@ -35,9 +35,9 @@ struct replicator_state {
 };
 
 /*
- * replicator_reset : Reset the replicator configuration to sane values.
+ * dynamic_replicator_reset : Reset the replicator configuration to sane values.
  */
-static void replicator_reset(struct replicator_state *drvdata)
+static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -50,12 +50,11 @@ static void replicator_reset(struct replicator_state *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int replicator_enable(struct coresight_device *csdev, int inport,
-			      int outport)
+static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
+				     int inport, int outport)
 {
 	int rc = 0;
 	u32 reg;
-	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	switch (outport) {
 	case 0:
@@ -76,21 +75,28 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 		rc = coresight_claim_device_unlocked(drvdata->base);
 
 	/* Ensure that the outport is enabled. */
-	if (!rc) {
+	if (!rc)
 		writel_relaxed(0x00, drvdata->base + reg);
-		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
-	}
-
 	CS_LOCK(drvdata->base);
 
 	return rc;
 }
 
-static void replicator_disable(struct coresight_device *csdev, int inport,
-				int outport)
+static int replicator_enable(struct coresight_device *csdev, int inport,
+			     int outport)
+{
+	int rc = 0;
+	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	rc = dynamic_replicator_enable(drvdata, inport, outport);
+	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+	return rc;
+}
+
+static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
+				       int inport, int outport)
 {
 	u32 reg;
-	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	switch (outport) {
 	case 0:
@@ -113,7 +119,14 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
 		coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
+}
 
+static void replicator_disable(struct coresight_device *csdev, int inport,
+			       int outport)
+{
+	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	dynamic_replicator_disable(drvdata, inport, outport);
 	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
@@ -127,7 +140,7 @@ static const struct coresight_ops replicator_cs_ops = {
 };
 
 #define coresight_replicator_reg(name, offset) \
-	coresight_simple_reg32(struct replicator_state, name, offset)
+	coresight_simple_reg32(struct replicator_drvdata, name, offset)
 
 coresight_replicator_reg(idfilter0, REPLICATOR_IDFILTER0);
 coresight_replicator_reg(idfilter1, REPLICATOR_IDFILTER1);
@@ -148,52 +161,55 @@ static const struct attribute_group *replicator_groups[] = {
 	NULL,
 };
 
-static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
+static int replicator_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
-	struct device *dev = &adev->dev;
-	struct resource *res = &adev->res;
 	struct coresight_platform_data *pdata = NULL;
-	struct replicator_state *drvdata;
+	struct replicator_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
-	struct device_node *np = adev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	void __iomem *base;
 
 	if (np) {
 		pdata = of_get_coresight_platform_data(dev, np);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
-		adev->dev.platform_data = pdata;
+		dev->platform_data = pdata;
 	}
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->dev = &adev->dev;
-	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
+	drvdata->dev = dev;
+	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
 		if (ret)
 			return ret;
 	}
 
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto out_disable_clk;
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
 	}
 
-	drvdata->base = base;
 	dev_set_drvdata(dev, drvdata);
 
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
 	desc.ops = &replicator_cs_ops;
-	desc.pdata = adev->dev.platform_data;
-	desc.dev = &adev->dev;
-	desc.groups = replicator_groups;
+	desc.pdata = dev->platform_data;
+	desc.dev = dev;
 	drvdata->csdev = coresight_register(&desc);
 
 	if (IS_ERR(drvdata->csdev)) {
@@ -201,8 +217,8 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_disable_clk;
 	}
 
-	replicator_reset(drvdata);
-	pm_runtime_put(&adev->dev);
+	dynamic_replicator_reset(drvdata);
+	pm_runtime_put(dev);
 
 out_disable_clk:
 	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
@@ -210,10 +226,16 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int dynamic_replicator_probe(struct amba_device *adev,
+				    const struct amba_id *id)
+{
+	return replicator_probe(&adev->dev, &adev->res);
+}
+
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
-	struct replicator_state *drvdata = dev_get_drvdata(dev);
+	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
 
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
@@ -223,7 +245,7 @@ static int replicator_runtime_suspend(struct device *dev)
 
 static int replicator_runtime_resume(struct device *dev)
 {
-	struct replicator_state *drvdata = dev_get_drvdata(dev);
+	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
 
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
@@ -238,7 +260,7 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 			   NULL)
 };
 
-static const struct amba_id replicator_ids[] = {
+static const struct amba_id dynamic_replicator_ids[] = {
 	{
 		.id     = 0x000bb909,
 		.mask   = 0x000fffff,
@@ -251,13 +273,13 @@ static const struct amba_id replicator_ids[] = {
 	{ 0, 0 },
 };
 
-static struct amba_driver replicator_driver = {
+static struct amba_driver dynamic_replicator_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-replicator",
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
-	.probe		= replicator_probe,
-	.id_table	= replicator_ids,
+	.probe		= dynamic_replicator_probe,
+	.id_table	= dynamic_replicator_ids,
 };
-builtin_amba_driver(replicator_driver);
+builtin_amba_driver(dynamic_replicator_driver);
-- 
2.7.4

