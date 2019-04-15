Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A350EC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB8920880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfDOQGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:06:32 -0400
Received: from foss.arm.com ([217.140.101.70]:37976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbfDOQG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:06:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD35F1BB2;
        Mon, 15 Apr 2019 09:06:28 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33A873F68F;
        Mon, 15 Apr 2019 09:06:27 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 25/36] coresight: Rearrange platform data probing
Date:   Mon, 15 Apr 2019 17:04:08 +0100
Message-Id: <1555344260-12375-26-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to introduce methods to clean up the platform data
as we switch to tracking the device reference from "name" to "fwnode
handles" for device connections. This requires us to drop the fwnode
handle references when the data is no longer required - i.e, when
the device probe fails or the device gets unregistered.

In order to consolidate the invocation of the cleanup, we delay the
platform probing to the very last minute, possibly before invoking
the coresight_register. Then, we leave the coresight core code to
do the clean up. i.e, if the coresight_register fails, it takes
care of freeing the data. Otherwise, coresight_unregister will
do the necessary operations.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 14 +++++++-------
 drivers/hwtracing/coresight/coresight-etb10.c      | 10 +++++-----
 drivers/hwtracing/coresight/coresight-etm3x.c      | 12 +++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.c      | 10 +++++-----
 drivers/hwtracing/coresight/coresight-funnel.c     | 10 +++++-----
 drivers/hwtracing/coresight/coresight-replicator.c | 12 +++++++-----
 drivers/hwtracing/coresight/coresight-stm.c        | 11 +++++++----
 drivers/hwtracing/coresight/coresight-tmc.c        | 16 ++++++++--------
 drivers/hwtracing/coresight/coresight-tpiu.c       |  9 ++++-----
 9 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 03f5b95..f249be6 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -505,13 +505,6 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	struct device *dev = &adev->dev;
 	void __iomem *base;
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata)) {
-		ret = PTR_ERR(pdata);
-		goto out;
-	}
-	dev->platform_data = pdata;
-
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata) {
 		ret = -ENOMEM;
@@ -544,6 +537,13 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto out;
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata)) {
+		ret = PTR_ERR(pdata);
+		goto out;
+	}
+	dev->platform_data = pdata;
+
 	drvdata->base = base;
 	catu_desc.pdata = pdata;
 	catu_desc.dev = dev;
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 91a5d7a..e5b46c7 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -682,11 +682,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-	adev->dev.platform_data = pdata;
-
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -718,6 +713,11 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata->buf)
 		return -ENOMEM;
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
+
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 	desc.ops = &etb_cs_ops;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 101fb01..f2d4616 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -795,11 +795,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-
-	adev->dev.platform_data = pdata;
 	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
 	dev_set_drvdata(dev, drvdata);
 
@@ -849,6 +844,13 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	etm_init_trace_id(drvdata);
 	etm_set_default(&drvdata->config);
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata)) {
+		ret = PTR_ERR(pdata);
+		goto err_arch_supported;
+	}
+	adev->dev.platform_data = pdata;
+
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
 	desc.ops = &etm_cs_ops;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 7ff0989..7c53fb2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -981,11 +981,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-	adev->dev.platform_data = pdata;
-
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -1028,6 +1023,11 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
+
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
 	desc.ops = &etm4_cs_ops;
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 61a9e01..38af045 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -186,11 +186,6 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-	adev->dev.platform_data = pdata;
-
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -211,6 +206,11 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->base = base;
 	pm_runtime_put(&adev->dev);
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
+
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
 	desc.ops = &funnel_cs_ops;
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 939f20d..8fbc028 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -179,11 +179,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	struct coresight_desc desc = { 0 };
 	void __iomem *base;
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-	dev->platform_data = pdata;
-
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -209,6 +204,13 @@ static int replicator_probe(struct device *dev, struct resource *res)
 		desc.groups = replicator_groups;
 	}
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata)) {
+		ret = PTR_ERR(pdata);
+		goto out_disable_clk;
+	}
+	dev->platform_data = pdata;
+
 	dev_set_drvdata(dev, drvdata);
 	desc.type = CORESIGHT_DEV_TYPE_LINK;
 	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_SPLIT;
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 734227f..5c7fc4a 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -810,10 +810,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	size_t bitmap_size;
 	struct coresight_desc desc = { 0 };
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-	adev->dev.platform_data = pdata;
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -866,6 +862,13 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		return -EPROBE_DEFER;
 	}
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata)) {
+		ret = PTR_ERR(pdata);
+		goto stm_unregister;
+	}
+	adev->dev.platform_data = pdata;
+
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE;
 	desc.ops = &stm_cs_ops;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 02c5cb5..94d3ebf 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -396,13 +396,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata)) {
-		ret = PTR_ERR(pdata);
-		goto out;
-	}
-	adev->dev.platform_data = pdata;
-
 	ret = -ENOMEM;
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
@@ -430,7 +423,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	else
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
 
-	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_tmc_groups;
 	desc.name = dev_name(dev);
@@ -461,6 +453,14 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata)) {
+		ret = PTR_ERR(pdata);
+		goto out;
+	}
+	adev->dev.platform_data = pdata;
+	desc.pdata = pdata;
+
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 792f1d6..39a509f 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -121,11 +121,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 
-	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
-	dev->platform_data = pdata;
-
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
@@ -148,6 +143,10 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	/* Disable tpiu to support older devices */
 	tpiu_disable_hw(drvdata);
 
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	dev->platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PORT;
-- 
2.7.4

