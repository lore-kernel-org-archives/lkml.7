Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC76C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C0E2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfEGKyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:54:12 -0400
Received: from foss.arm.com ([217.140.101.70]:50250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfEGKyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD4031684;
        Tue,  7 May 2019 03:54:08 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7A5853F5AF;
        Tue,  7 May 2019 03:54:07 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 19/30] coresight: Remove name from platform description
Date:   Tue,  7 May 2019 11:52:46 +0100
Message-Id: <1557226378-10131-20-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to use a name independent of the parent AMBA device
name. As such, there is no need to have it in the platform description.
Let us move this to coresight description instead.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
index 799ba1d..05c7304 100644
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
index 612f1e9..5e7ecc6 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -770,12 +770,13 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
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
index 03576f3..8adc148 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1142,6 +1142,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_etmv4_groups;
+	desc.name = dev_name(dev);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index fc033fd..ded33f5 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -229,6 +229,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	desc.ops = &funnel_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 541e500..f500de6 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -323,9 +323,6 @@ coresight_get_platform_data(struct device *dev)
 		goto error;
 	}
 
-	/* Use device name as sysfs handle */
-	pdata->name = dev_name(dev);
-
 	if (is_of_node(fwnode))
 		ret = of_get_coresight_platform_data(dev, pdata);
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 054b335..f28bafd 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -220,6 +220,8 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	desc.ops = &replicator_cs_ops;
 	desc.pdata = dev->platform_data;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
+
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 9faa1ed..02031d9 100644
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
index be0bd98..44a5719 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -437,6 +437,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.pdata = pdata;
 	desc.dev = dev;
 	desc.groups = coresight_tmc_groups;
+	desc.name = dev_name(dev);
 
 	switch (drvdata->config_type) {
 	case TMC_CONFIG_TYPE_ETB:
@@ -461,7 +462,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.ops = &tmc_etf_cs_ops;
 		break;
 	default:
-		pr_err("%s: Unsupported TMC config\n", pdata->name);
+		pr_err("%s: Unsupported TMC config\n", desc.name);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -472,7 +473,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
-	drvdata->miscdev.name = pdata->name;
+	drvdata->miscdev.name = desc.name;
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &tmc_fops;
 	ret = misc_register(&drvdata->miscdev);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index aec0ed7..d8a2e39 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -157,6 +157,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpiu_cs_ops;
 	desc.pdata = pdata;
 	desc.dev = dev;
+	desc.name = dev_name(dev);
 	drvdata->csdev = coresight_register(&desc);
 
 	if (!IS_ERR(drvdata->csdev)) {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4b13028..04b5d3c 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1199,7 +1199,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->dev.parent = desc->dev;
 	csdev->dev.release = coresight_device_release;
 	csdev->dev.bus = &coresight_bustype;
-	dev_set_name(&csdev->dev, "%s", desc->pdata->name);
+	dev_set_name(&csdev->dev, "%s", desc->name);
 
 	ret = device_register(&csdev->dev);
 	if (ret) {
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index bf241db..298db20 100644
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

