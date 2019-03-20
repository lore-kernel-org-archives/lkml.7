Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A058BC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B912184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCTSu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:50:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfCTSuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:50:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B6B7A78;
        Wed, 20 Mar 2019 11:50:23 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B60F13F59C;
        Wed, 20 Mar 2019 11:50:21 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathie.poirier@linaro.org>
Subject: [PATCH 08/25] coresight: tmc: Clean up device specific data
Date:   Wed, 20 Mar 2019 18:49:25 +0000
Message-Id: <1553107783-3340-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to use a consistent device naming scheme,
clean up the device link tracking in replicator driver.
Use the "coresight" device instead of the "real" parent device
for all internal purposes. All other requests (e.g, power management,
DMA operations) must use the "real" device which is the parent device.

Since the CATU driver also uses the TMC-SG infrastructure, update
the callers to ensure they pass the appropriate device argument
for the tables.

Cc: Mathieu Poirier <mathie.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c    |  5 ++---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 26 ++++++++++++++-----------
 drivers/hwtracing/coresight/coresight-tmc.c     | 22 ++++++++++-----------
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 170fbb6..11c6f2f 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -328,19 +328,18 @@ static int catu_alloc_etr_buf(struct tmc_drvdata *tmc_drvdata,
 			      struct etr_buf *etr_buf, int node, void **pages)
 {
 	struct coresight_device *csdev;
-	struct device *catu_dev;
 	struct tmc_sg_table *catu_table;
 	struct catu_etr_buf *catu_buf;
 
 	csdev = tmc_etr_get_catu_device(tmc_drvdata);
 	if (!csdev)
 		return -ENODEV;
-	catu_dev = csdev->dev.parent;
 	catu_buf = kzalloc(sizeof(*catu_buf), GFP_KERNEL);
 	if (!catu_buf)
 		return -ENOMEM;
 
-	catu_table = catu_init_sg_table(catu_dev, node, etr_buf->size, pages);
+	catu_table = catu_init_sg_table(&csdev->dev, node,
+					etr_buf->size, pages);
 	if (IS_ERR(catu_table)) {
 		kfree(catu_buf);
 		return PTR_ERR(catu_table);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f684283..4152774 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -153,10 +153,11 @@ static void tmc_pages_free(struct tmc_pages *tmc_pages,
 			   struct device *dev, enum dma_data_direction dir)
 {
 	int i;
+	struct device *real_dev = dev->parent;
 
 	for (i = 0; i < tmc_pages->nr_pages; i++) {
 		if (tmc_pages->daddrs && tmc_pages->daddrs[i])
-			dma_unmap_page(dev, tmc_pages->daddrs[i],
+			dma_unmap_page(real_dev, tmc_pages->daddrs[i],
 					 PAGE_SIZE, dir);
 		if (tmc_pages->pages && tmc_pages->pages[i])
 			__free_page(tmc_pages->pages[i]);
@@ -184,6 +185,7 @@ static int tmc_pages_alloc(struct tmc_pages *tmc_pages,
 	int i, nr_pages;
 	dma_addr_t paddr;
 	struct page *page;
+	struct device *real_dev = dev->parent;
 
 	nr_pages = tmc_pages->nr_pages;
 	tmc_pages->daddrs = kcalloc(nr_pages, sizeof(*tmc_pages->daddrs),
@@ -207,8 +209,8 @@ static int tmc_pages_alloc(struct tmc_pages *tmc_pages,
 			page = alloc_pages_node(node,
 						GFP_KERNEL | __GFP_ZERO, 0);
 		}
-		paddr = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
-		if (dma_mapping_error(dev, paddr))
+		paddr = dma_map_page(real_dev, page, 0, PAGE_SIZE, dir);
+		if (dma_mapping_error(real_dev, paddr))
 			goto err;
 		tmc_pages->daddrs[i] = paddr;
 		tmc_pages->pages[i] = page;
@@ -295,7 +297,7 @@ static int tmc_alloc_data_pages(struct tmc_sg_table *sg_table, void **pages)
  * and data buffers. TMC writes to the data buffers and reads from the SG
  * Table pages.
  *
- * @dev		- Device to which page should be DMA mapped.
+ * @dev		- Coresight device to which page should be DMA mapped.
  * @node	- Numa node for mem allocations
  * @nr_tpages	- Number of pages for the table entries.
  * @nr_dpages	- Number of pages for Data buffer.
@@ -339,13 +341,13 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
 {
 	int i, index, start;
 	int npages = DIV_ROUND_UP(size, PAGE_SIZE);
-	struct device *dev = table->dev;
+	struct device *real_dev = table->dev->parent;
 	struct tmc_pages *data = &table->data_pages;
 
 	start = offset >> PAGE_SHIFT;
 	for (i = start; i < (start + npages); i++) {
 		index = i % data->nr_pages;
-		dma_sync_single_for_cpu(dev, data->daddrs[index],
+		dma_sync_single_for_cpu(real_dev, data->daddrs[index],
 					PAGE_SIZE, DMA_FROM_DEVICE);
 	}
 }
@@ -354,11 +356,11 @@ void tmc_sg_table_sync_data_range(struct tmc_sg_table *table,
 void tmc_sg_table_sync_table(struct tmc_sg_table *sg_table)
 {
 	int i;
-	struct device *dev = sg_table->dev;
+	struct device *real_dev = sg_table->dev->parent;
 	struct tmc_pages *table_pages = &sg_table->table_pages;
 
 	for (i = 0; i < table_pages->nr_pages; i++)
-		dma_sync_single_for_device(dev, table_pages->daddrs[i],
+		dma_sync_single_for_device(real_dev, table_pages->daddrs[i],
 					   PAGE_SIZE, DMA_TO_DEVICE);
 }
 
@@ -581,6 +583,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 				  void **pages)
 {
 	struct etr_flat_buf *flat_buf;
+	struct device *real_dev = drvdata->dev->parent;
 
 	/* We cannot reuse existing pages for flat buf */
 	if (pages)
@@ -590,7 +593,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 	if (!flat_buf)
 		return -ENOMEM;
 
-	flat_buf->vaddr = dma_alloc_coherent(drvdata->dev, etr_buf->size,
+	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
 					     &flat_buf->daddr, GFP_KERNEL);
 	if (!flat_buf->vaddr) {
 		kfree(flat_buf);
@@ -608,9 +611,10 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
 {
 	struct etr_flat_buf *flat_buf = etr_buf->private;
+	struct device *real_dev = flat_buf->dev->parent;
 
 	if (flat_buf && flat_buf->daddr)
-		dma_free_coherent(flat_buf->dev, flat_buf->size,
+		dma_free_coherent(real_dev, flat_buf->size,
 				  flat_buf->vaddr, flat_buf->daddr);
 	kfree(flat_buf);
 }
@@ -815,7 +819,7 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
 	struct etr_buf *etr_buf;
 
 	has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
-	has_iommu = iommu_get_domain_for_dev(drvdata->dev);
+	has_iommu = iommu_get_domain_for_dev(drvdata->dev->parent);
 	has_catu = !!tmc_etr_get_catu_device(drvdata);
 
 	has_sg = has_catu || has_etr_sg;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 647b6aa..9e7ff83 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -330,24 +330,22 @@ const struct attribute_group *coresight_tmc_groups[] = {
 	NULL,
 };
 
-static inline bool tmc_etr_can_use_sg(struct tmc_drvdata *drvdata)
+static inline bool tmc_etr_can_use_sg(struct device *dev)
 {
-	return fwnode_property_present(drvdata->dev->fwnode,
-				       "arm,scatter-gather");
+	return fwnode_property_present(dev->fwnode, "arm,scatter-gather");
 }
 
 /* Detect and initialise the capabilities of a TMC ETR */
-static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
-			     u32 devid, void *dev_caps)
+static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
 {
 	int rc;
-
 	u32 dma_mask = 0;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
 
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
 
-	if (!(devid & TMC_DEVID_NOSCAT) && tmc_etr_can_use_sg(drvdata))
+	if (!(devid & TMC_DEVID_NOSCAT) && tmc_etr_can_use_sg(parent))
 		tmc_etr_set_cap(drvdata, TMC_ETR_SG);
 
 	/* Check if the AXI address width is available */
@@ -365,15 +363,15 @@ static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
 	case 44:
 	case 48:
 	case 52:
-		dev_info(drvdata->dev, "Detected dma mask %dbits\n", dma_mask);
+		dev_info(parent, "Detected dma mask %dbits\n", dma_mask);
 		break;
 	default:
 		dma_mask = 40;
 	}
 
-	rc = dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(dma_mask));
+	rc = dma_set_mask_and_coherent(parent, DMA_BIT_MASK(dma_mask));
 	if (rc)
-		dev_err(drvdata->dev, "Failed to setup DMA mask: %d\n", rc);
+		dev_err(parent, "Failed to setup DMA mask: %d\n", rc);
 	return rc;
 }
 
@@ -403,7 +401,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		goto out;
 
-	drvdata->dev = &adev->dev;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -448,7 +445,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etr_cs_ops;
-		ret = tmc_etr_setup_caps(drvdata, devid,
+		ret = tmc_etr_setup_caps(dev, devid,
 					 coresight_get_uci_data(id));
 		if (ret)
 			goto out;
@@ -470,6 +467,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
+	drvdata->dev = &drvdata->csdev->dev;
 	drvdata->miscdev.name = pdata->name;
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &tmc_fops;
-- 
2.7.4

