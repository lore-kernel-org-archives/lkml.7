Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D358C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F3820880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfDOQG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:06:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37924 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbfDOQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:06:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 717D61715;
        Mon, 15 Apr 2019 09:06:23 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E80113F68F;
        Mon, 15 Apr 2019 09:06:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 22/36] coresight: Remove name from platform description
Date:   Mon, 15 Apr 2019 17:04:05 +0100
Message-Id: <1555344260-12375-23-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to use a name independent of the parent AMBA device
name. As such, there is no need to have it in the platform description.
Let us move this to coresight description instead.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 2 ++
 drivers/hwtracing/coresight/coresight-etb10.c      | 3 ++-
 drivers/hwtracing/coresight/coresight-etm3x.c      | 1 +
 drivers/hwtracing/coresight/coresight-etm4x.c      | 1 +
 drivers/hwtracing/coresight/coresight-funnel.c     | 1 +
 drivers/hwtracing/coresight/coresight-platform.c   | 3 ---
 drivers/hwtracing/coresight/coresight-replicator.c | 2 ++
 drivers/hwtracing/coresight/coresight-stm.c        | 1 +
 drivers/hwtracing/coresight/coresight-tmc.c        | 5 +++--
 drivers/hwtracing/coresight/coresight-tpiu.c       | 1 +
 drivers/hwtracing/coresight/coresight.c            | 2 +-
 include/linux/coresight.h                          | 8 ++++----
 12 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 65b86ec..03f5b95 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -551,6 +551,8 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	catu_desc.type = CORESIGHT_DEV_TYPE_HELPER;
 	catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
 	catu_desc.ops = &catu_ops;
+	catu_desc.name = dev_name(dev);
+
 	drvdata->csdev = coresight_register(&catu_desc);
 	if (IS_ERR(drvdata->csdev))
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index cd61b54..91a5d7a 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -723,12 +723,13 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &etb_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
 	desc.groups = coresight_etb_groups;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
-	drvdata->miscdev.name = pdata->name;
+	drvdata->miscdev.name = desc.name;
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &etb_fops;
 	ret = misc_register(&drvdata->miscdev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 722fab96..101fb01 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -854,6 +854,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &etm_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
 	desc.groups = coresight_etm_groups;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index ced31d1..7ff0989 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1034,6 +1034,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_etmv4_groups;
+	desc.name = dev_name(dev);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 2590744..61a9e01 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -216,6 +216,7 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &funnel_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
 	desc.groups = coresight_funnel_groups;
 	drvdata->csdev = coresight_register(&desc);
 
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index f1ab1b5..0415fff 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -314,9 +314,6 @@ coresight_get_platform_data(struct device *dev)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	/* Use device name as sysfs handle */
-	pdata->name = dev_name(dev);
-
 	if (is_of_node(fwnode))
 		return of_get_coresight_platform_data(dev, pdata);
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 7eb3bf7..939f20d 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -215,6 +215,8 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	desc.ops = &replicator_cs_ops;
 	desc.pdata = dev->platform_data;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
+
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index eae0094..734227f 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -871,6 +871,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &stm_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
 	desc.groups = coresight_stm_groups;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 7dbdf59..02c5cb5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -433,6 +433,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_tmc_groups;
+	desc.name = dev_name(dev);
 
 	switch (drvdata->config_type) {
 	case TMC_CONFIG_TYPE_ETB:
@@ -455,7 +456,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.ops = &tmc_etf_cs_ops;
 		break;
 	default:
-		pr_err("%s: Unsupported TMC config\n", pdata->name);
+		pr_err("%s: Unsupported TMC config\n", desc.name);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -466,7 +467,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
-	drvdata->miscdev.name = pdata->name;
+	drvdata->miscdev.name = desc.name;
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &tmc_fops;
 	ret = misc_register(&drvdata->miscdev);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index eea7fd1..792f1d6 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -154,6 +154,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpiu_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
 	drvdata->csdev = coresight_register(&desc);
 
 	if (!IS_ERR(drvdata->csdev)) {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 55204dd..91c63cd 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1197,7 +1197,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->dev.parent = desc->dev;
 	csdev->dev.release = coresight_device_release;
 	csdev->dev.bus = &coresight_bustype;
-	dev_set_name(&csdev->dev, "%s", desc->pdata->name);
+	dev_set_name(&csdev->dev, "%s", desc->name);
 
 	ret = device_register(&csdev->dev);
 	if (ret) {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index bb7548f..84a2137 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -91,13 +91,11 @@ union coresight_dev_subtype {
 
 /**
  * struct coresight_platform_data - data harvested from the DT specification
- * @name:	name of the component as shown under sysfs.
  * @nr_inport:	number of input ports for this component.
  * @nr_outport:	number of output ports for this component.
  * @conns:	Array of nr_outport connections from this component
  */
 struct coresight_platform_data {
-	const char *name;
 	int nr_inport;
 	int nr_outport;
 	struct coresight_connection *conns;
@@ -108,11 +106,12 @@ struct coresight_platform_data {
  * @type:	as defined by @coresight_dev_type.
  * @subtype:	as defined by @coresight_dev_subtype.
  * @ops:	generic operations for this component, as defined
-		by @coresight_ops.
+ *		by @coresight_ops.
  * @pdata:	platform data collected from DT.
  * @dev:	The device entity associated to this component.
  * @groups:	operations specific to this component. These will end up
-		in the component's sysfs sub-directory.
+ *		in the component's sysfs sub-directory.
+ * @name:	name for the coresight device, also shown under sysfs.
  */
 struct coresight_desc {
 	enum coresight_dev_type type;
@@ -121,6 +120,7 @@ struct coresight_desc {
 	struct coresight_platform_data *pdata;
 	struct device *dev;
 	const struct attribute_group **groups;
+	const char *name;
 };
 
 /**
-- 
2.7.4

