Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9E121841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfCTSvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:51:17 -0400
Received: from foss.arm.com ([217.140.101.70]:45038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfCTSus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73001BC0;
        Wed, 20 Mar 2019 11:50:47 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DD123F59C;
        Wed, 20 Mar 2019 11:50:46 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 22/25] coresight: Use platform agnostic names
Date:   Wed, 20 Mar 2019 18:49:39 +0000
Message-Id: <1553107783-3340-23-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far we have reused the name of the "platform" device for
the CoreSight device. But this is not very intuitive when
we move to ACPI. Also, the ACPI device names have ":" in them
(e.g, ARMHC97C:01), which the perf tool doesn't like very much.
This patch introduces a generic naming scheme, givin more intuitive
names for the devices that appear on the CoreSight bus.
The names follow the pattern "prefix" followed by "index" (e.g, etm5).
We maintain a list of allocated devices per "prefix" to make sure
we don't allocate a new name when it is reprobed (e.g, due to
unsatisifed device dependencies). So, we maintain the list
of "fwnodes" of the parent devices to allocate a consistent name.
All devices except the ETMs get an index allocated in the order
of probing. ETMs get an index based on the CPU they are attached to.

TMC devices are named using "tmc_etf", "tmc_etb", and "tmc_etr"
prefixes depending on the configuration of the device.

The replicators are not classified as dynamic/static anymore.
One could easily figure that out by checking the presence of
"mgmt" registers under sysfs.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c       |  7 +++
 drivers/hwtracing/coresight/coresight-etb10.c      |  6 +++
 drivers/hwtracing/coresight/coresight-etm3x.c      |  5 ++
 drivers/hwtracing/coresight/coresight-etm4x.c      |  4 ++
 drivers/hwtracing/coresight/coresight-funnel.c     |  6 +++
 drivers/hwtracing/coresight/coresight-replicator.c |  7 +++
 drivers/hwtracing/coresight/coresight-stm.c        |  6 +++
 drivers/hwtracing/coresight/coresight-tmc.c        | 14 ++++++
 drivers/hwtracing/coresight/coresight-tpiu.c       |  6 +++
 drivers/hwtracing/coresight/coresight.c            | 58 ++++++++++++++++++++++
 include/linux/coresight.h                          | 25 +++++++++-
 11 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 4595c67..6492bce 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -28,6 +28,8 @@
 #define catu_dbg(x, ...) do {} while (0)
 #endif
 
+DEFINE_CORESIGHT_DEVLIST(catu_devs, "catu");
+
 struct catu_etr_buf {
 	struct tmc_sg_table *catu_table;
 	dma_addr_t sladdr;
@@ -510,6 +512,11 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = PTR_ERR(pdata);
 		goto out;
 	}
+
+	pdata->name = coresight_alloc_device_name(&catu_devs, dev);
+	if (!pdata->name)
+		return -ENOMEM;
+
 	dev->platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index e4175849..42b525c 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -62,6 +62,8 @@
 #define ETB_FFSR_BIT		1
 #define ETB_FRAME_SIZE_WORDS	4
 
+DEFINE_CORESIGHT_DEVLIST(etb10_devs, "etb10_");
+
 /**
  * struct etb_drvdata - specifics associated to an ETB component
  * @base:	memory mapped base address for this component.
@@ -692,6 +694,10 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
+	pdata->name = coresight_alloc_device_name(&etb10_devs, dev);
+	if (!pdata->name)
+		return -ENOMEM;
+
 	adev->dev.platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index b101464..35ed953 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -797,6 +797,11 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
 
+	pdata->name  = devm_kasprintf(dev, GFP_KERNEL,
+				      "etm%d", pdata->cpu);
+	if (!pdata->name)
+		return -ENOMEM;
+
 	adev->dev.platform_data = pdata;
 	drvdata->use_cp14 = fwnode_property_read_bool(dev->fwnode, "arm,cp14");
 	dev_set_drvdata(dev, drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index bfc23ab..55fcb78 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -982,6 +982,10 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
+	pdata->name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", pdata->cpu);
+	if (!pdata->name)
+		return -ENOMEM;
+
 	adev->dev.platform_data = pdata;
 
 	dev_set_drvdata(dev, drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 2590744..96b6773 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -27,6 +27,8 @@
 #define FUNNEL_HOLDTIME		(0x7 << FUNNEL_HOLDTIME_SHFT)
 #define FUNNEL_ENSx_MASK	0xff
 
+DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
+
 /**
  * struct funnel_drvdata - specifics associated to a funnel component
  * @base:	memory mapped base address for this component.
@@ -189,6 +191,10 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
+	pdata->name = coresight_alloc_device_name(&funnel_devs, dev);
+	if (!pdata->name)
+		return -ENOMEM;
+
 	adev->dev.platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 7eb3bf7..7b937c0 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -22,6 +22,8 @@
 #define REPLICATOR_IDFILTER0		0x000
 #define REPLICATOR_IDFILTER1		0x004
 
+DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
+
 /**
  * struct replicator_drvdata - specifics associated to a replicator component
  * @base:	memory mapped base address for this component. Also indicates
@@ -184,6 +186,11 @@ static int replicator_probe(struct device *dev, struct resource *res)
 		return PTR_ERR(pdata);
 	dev->platform_data = pdata;
 
+	pdata->name = coresight_alloc_device_name(&replicator_devs, dev);
+
+	if (!pdata->name)
+		return -ENOMEM;
+
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 6514586..d94ae22 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -107,6 +107,8 @@ struct channel_space {
 	unsigned long		*guaranteed;
 };
 
+DEFINE_CORESIGHT_DEVLIST(stm_devs, "stm");
+
 /**
  * struct stm_drvdata - specifics associated to an STM component
  * @base:		memory mapped base address for this component.
@@ -813,6 +815,10 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
+	pdata->name = coresight_alloc_device_name(&stm_devs, dev);
+	if (!pdata->name)
+		return -ENOMEM;
+
 	adev->dev.platform_data = pdata;
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 147ab17..030303d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -25,6 +25,10 @@
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
+DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
+DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
+DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
+
 void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
 	/* Ensure formatter, unformatter and hardware fifo are empty */
@@ -394,6 +398,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	struct tmc_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
+	struct coresight_dev_list *dev_list = NULL;
 
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata)) {
@@ -440,6 +445,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etb_cs_ops;
+		dev_list = &etb_devs;
 		break;
 	case TMC_CONFIG_TYPE_ETR:
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
@@ -449,11 +455,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 					 coresight_get_uci_data(id));
 		if (ret)
 			goto out;
+		dev_list = &etr_devs;
 		break;
 	case TMC_CONFIG_TYPE_ETF:
 		desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
 		desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
 		desc.ops = &tmc_etf_cs_ops;
+		dev_list = &etf_devs;
 		break;
 	default:
 		pr_err("%s: Unsupported TMC config\n", pdata->name);
@@ -461,6 +469,12 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
+	pdata->name = coresight_alloc_device_name(dev_list, dev);
+	if (!pdata->name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev)) {
 		ret = PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 18a749a..f5cc457 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -46,6 +46,8 @@
 #define FFCR_FON_MAN		BIT(6)
 #define FFCR_STOP_FI		BIT(12)
 
+DEFINE_CORESIGHT_DEVLIST(tpiu_devs, "tpiu");
+
 /**
  * @base:	memory mapped base address for this component.
  * @dev:	the coresight device entity associated to this component.
@@ -124,6 +126,10 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
 		return PTR_ERR(pdata);
+	pdata->name = coresight_alloc_device_name(&tpiu_devs, dev);
+	if (!pdata->name)
+		return -ENOMEM;
+
 	adev->dev.platform_data = pdata;
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 9cdedab..ca40c55 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1253,3 +1253,61 @@ void coresight_unregister(struct coresight_device *csdev)
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
+
+
+/*
+ * coresight_search_device_idx - Search the fwnode handle of a device
+ * in the given dev_idx list. Must be called with the coresight_mutex held.
+ *
+ * Returns the index of the entry, when found. Otherwise, -ENOENT.
+ */
+static inline int coresight_search_device_idx(struct coresight_dev_list *dict,
+					      struct fwnode_handle *fwnode)
+{
+	int i;
+
+	for (i = 0; i < dict->nr_idx; i++)
+		if (dict->fwnode_list[i] == fwnode)
+			return i;
+	return -ENOENT;
+}
+
+/*
+ * coresight_alloc_device_name - Get an index for a given device in the
+ * device index list specific to a driver. An index is allocated for a
+ * device and is tracked with the fwnode_handle to prevent allocating
+ * duplicate indices for the same device (e.g, if we defer probing of
+ * a device due to dependencies), in case the index is requested again.
+ */
+char *coresight_alloc_device_name(struct coresight_dev_list *dict,
+				  struct device *dev)
+{
+	int idx;
+	char *name = NULL;
+	struct fwnode_handle **list;
+
+	mutex_lock(&coresight_mutex);
+
+	idx = coresight_search_device_idx(dict, dev_fwnode(dev));
+	if (idx < 0) {
+		/* Make space for the new entry */
+		idx = dict->nr_idx;
+		list = krealloc(dict->fwnode_list,
+				(idx + 1) * sizeof(*dict->fwnode_list),
+				GFP_KERNEL);
+		if (ZERO_OR_NULL_PTR(list)) {
+			idx = -ENOMEM;
+			goto done;
+		}
+
+		list[idx] = dev_fwnode(dev);
+		dict->fwnode_list = list;
+		dict->nr_idx = idx + 1;
+	}
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
+done:
+	mutex_unlock(&coresight_mutex);
+	return name;
+}
+EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 76c31b2..9d933bb 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -174,6 +174,28 @@ struct coresight_device {
 	struct dev_ext_attribute *ea;
 };
 
+/*
+ * coresight_dev_list - Mapping for devices to "name" index for device
+ * names.
+ *
+ * @nr_idx:		Number of entries already allocated.
+ * @pfx:		Prefix pattern for device name.
+ * @fwnode_list:	Array of fwnode_handles associated with each allocated
+ *			index, upto nr_idx entries.
+ */
+struct coresight_dev_list {
+	int			nr_idx;
+	const char		*pfx;
+	struct fwnode_handle	**fwnode_list;
+};
+
+#define DEFINE_CORESIGHT_DEVLIST(var, dev_pfx)				\
+static struct coresight_dev_list (var) = {				\
+						.pfx = dev_pfx,		\
+						.nr_idx = 0,		\
+						.fwnode_list = NULL,	\
+}
+
 #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
 
 #define source_ops(csdev)	csdev->ops->source_ops
@@ -266,7 +288,8 @@ extern int coresight_claim_device_unlocked(void __iomem *base);
 
 extern void coresight_disclaim_device(void __iomem *base);
 extern void coresight_disclaim_device_unlocked(void __iomem *base);
-
+extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
+					 struct device *dev);
 #else
 static inline struct coresight_device *
 coresight_register(struct coresight_desc *desc) { return NULL; }
-- 
2.7.4

