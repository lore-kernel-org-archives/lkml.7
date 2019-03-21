Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F94C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EAD21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OrVGl6Dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfCUQDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:03:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38568 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCUQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:03:16 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LG2x0r085829;
        Thu, 21 Mar 2019 11:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553184179;
        bh=CcfwO0xXZTc2lFwlD8Xkh+VeRbMlWvxdrXLDbseq+RU=;
        h=From:To:CC:Subject:Date;
        b=OrVGl6Djfhz4ZmNDSSJYcq2qig0e9RIFX45ka3/5dsYoSmkghLLg2TASJHMoRsaFP
         hQ5DeFsO3tg7lsxjUu4JZQ3ZHWJoIOTYwMe1BF8sLnsyvLQbdtVVi8AShyblShxqx3
         sgQHEa16J4UG89PHguD5ddOTCO9wqVB1NeJR8To8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LG2xZB022412
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 11:02:59 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 11:02:58 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 11:02:58 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LG2w8X002916;
        Thu, 21 Mar 2019 11:02:58 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2LG2vU22517;
        Thu, 21 Mar 2019 11:02:57 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [RFC][PATCH] misc: sram: Add dma-heap-export reserved SRAM area type
Date:   Thu, 21 Mar 2019 11:02:57 -0500
Message-ID: <20190321160257.27669-1-afd@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new export type exposes to userspace the SRAM area as a DMA-Heap,
this allows for allocations as DMA-BUFs that can be consumed by various
DMA-BUF supporting devices.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---

Hello all,

This is an example user of the currently RFC DMA-HEAP framework. It
exports a defined SRAM area showing how various memory presenting
devices can use the DMA-HEAP framework to provide DMA-BUF allocations
to userspace and other devices.

It has a couple problems still, one being that the SRAM subsystem
probes before the DMA-BUF subsystem, can the SRAM driver be changed
from postcore_initcall to subsys_initcall or even device_initcall?

Thanks,
Andrew

 .../devicetree/bindings/sram/sram.txt         |   7 +-
 drivers/misc/Kconfig                          |   7 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/sram-dma-heap.c                  | 235 ++++++++++++++++++
 drivers/misc/sram.c                           |  20 +-
 drivers/misc/sram.h                           |  17 ++
 6 files changed, 282 insertions(+), 5 deletions(-)
 create mode 100644 drivers/misc/sram-dma-heap.c

diff --git a/Documentation/devicetree/bindings/sram/sram.txt b/Documentation/devicetree/bindings/sram/sram.txt
index e98908bd4227..c5584f1f6ae8 100644
--- a/Documentation/devicetree/bindings/sram/sram.txt
+++ b/Documentation/devicetree/bindings/sram/sram.txt
@@ -43,11 +43,16 @@ Optional properties in the area nodes:
 - export : indicates that the reserved SRAM area may be accessed outside
            of the kernel, e.g. by bootloader or userspace
 - protect-exec : Same as 'pool' above but with the additional
-		 constraint that code wil be run from the region and
+		 constraint that code will be run from the region and
 		 that the memory is maintained as read-only, executable
 		 during code execution. NOTE: This region must be page
 		 aligned on start and end in order to properly allow
 		 manipulation of the page attributes.
+- dma-heap-export : Similar to 'pool' and 'export' this region will be
+		    exported for use by drivers, devices, and userspace
+		    using the DMA-Heaps framework. NOTE: This region must
+		    be page aligned on start and end in order to properly
+		    allow manipulation of the page attributes.
 - label : the name for the reserved partition, if omitted, the label
           is taken from the node name excluding the unit address.
 - clocks : a list of phandle and clock specifier pair that controls the
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec92a04..5e655890458d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -487,6 +487,13 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config SRAM_DMA_HEAP
+	bool "Export on-chip SRAM pools using DMA-Heaps"
+	depends on SRAM
+	help
+	  This driver allows the export of on-chip SRAM marked as exportable
+	  to userspace using the DMA-Heaps interface.
+
 config VEXPRESS_SYSCFG
 	bool "Versatile Express System Configuration driver"
 	depends on VEXPRESS_CONFIG
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d5b7d3404dc7..f9db5326e0f7 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
+obj-$(CONFIG_SRAM_DMA_HEAP)	+= sram-dma-heap.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
diff --git a/drivers/misc/sram-dma-heap.c b/drivers/misc/sram-dma-heap.c
new file mode 100644
index 000000000000..bc930fced648
--- /dev/null
+++ b/drivers/misc/sram-dma-heap.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SRAM DMA-Heaps userspace exporter
+ *
+ * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ *	Andrew F. Davis <afd@ti.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/genalloc.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+
+#include "sram.h"
+
+struct sram_dma_heap {
+	struct dma_heap heap;
+	struct gen_pool *pool;
+};
+
+struct sram_dma_heap_buffer {
+	struct gen_pool *pool;
+	struct list_head attachments;
+	struct mutex attachments_lock;
+	unsigned long len;
+	unsigned long vaddr;
+	phys_addr_t paddr;
+};
+
+struct dma_heaps_attachment {
+	struct device *dev;
+	struct sg_table *table;
+	struct list_head list;
+};
+
+static int dma_heap_attach(struct dma_buf *dmabuf,
+			   struct dma_buf_attachment *attachment)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	struct dma_heaps_attachment *a;
+	struct sg_table *table;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	table = kmalloc(sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		kfree(a);
+		return -ENOMEM;
+	}
+	if (sg_alloc_table(table, 1, GFP_KERNEL)) {
+		kfree(a);
+		return -ENOMEM;
+	}
+	sg_set_page(table->sgl, pfn_to_page(PFN_DOWN(buffer->paddr)), buffer->len, 0);
+
+	a->table = table;
+	a->dev = attachment->dev;
+	INIT_LIST_HEAD(&a->list);
+
+	attachment->priv = a;
+
+	mutex_lock(&buffer->attachments_lock);
+	list_add(&a->list, &buffer->attachments);
+	mutex_unlock(&buffer->attachments_lock);
+
+	return 0;
+}
+
+static void dma_heap_detatch(struct dma_buf *dmabuf,
+			     struct dma_buf_attachment *attachment)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	struct dma_heaps_attachment *a = attachment->priv;
+
+	mutex_lock(&buffer->attachments_lock);
+	list_del(&a->list);
+	mutex_unlock(&buffer->attachments_lock);
+
+	sg_free_table(a->table);
+	kfree(a->table);
+	kfree(a);
+}
+
+static struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
+					     enum dma_data_direction direction)
+{
+	struct dma_heaps_attachment *a = attachment->priv;
+	struct sg_table *table = a->table;
+
+	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
+			      direction, DMA_ATTR_SKIP_CPU_SYNC))
+		return ERR_PTR(-ENOMEM);
+
+	return table;
+}
+
+static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				   struct sg_table *table,
+				   enum dma_data_direction direction)
+{
+	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
+			   direction, DMA_ATTR_SKIP_CPU_SYNC);
+}
+
+static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+
+	gen_pool_free(buffer->pool, buffer->vaddr, buffer->len);
+	kfree(buffer);
+}
+
+static void *dma_heap_kmap(struct dma_buf *dmabuf, unsigned long page_num)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+
+	return (void *)buffer->vaddr + (page_num * PAGE_SIZE);
+}
+
+static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	int ret;
+
+	/* SRAM mappings are not cached */
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+
+	ret = vm_iomap_memory(vma, buffer->paddr, buffer->len);
+	if (ret)
+		pr_err("Could not map buffer to userspace\n");
+
+	return ret;
+}
+
+const struct dma_buf_ops sram_dma_heap_buf_ops = {
+	.attach = dma_heap_attach,
+	.detach = dma_heap_detatch,
+	.map_dma_buf = dma_heap_map_dma_buf,
+	.unmap_dma_buf = dma_heap_unmap_dma_buf,
+	.release = dma_heap_dma_buf_release,
+	.map = dma_heap_kmap,
+	.mmap = dma_heap_mmap,
+};
+
+static int sram_dma_heap_allocate(struct dma_heap *heap,
+				  unsigned long len,
+				  unsigned long flags)
+{
+	struct sram_dma_heap *sram_dma_heap = container_of(heap, struct sram_dma_heap, heap);
+	struct sram_dma_heap_buffer *buffer;
+
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret;
+
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+	buffer->pool = sram_dma_heap->pool;
+	INIT_LIST_HEAD(&buffer->attachments);
+	mutex_init(&buffer->attachments_lock);
+	buffer->len = len;
+
+	buffer->vaddr = gen_pool_alloc(buffer->pool, buffer->len);
+	if (!buffer->vaddr) {
+		ret = -ENOMEM;
+		goto free_buffer;
+	}
+
+	buffer->paddr = gen_pool_virt_to_phys(buffer->pool, buffer->vaddr);
+	if (buffer->paddr == -1) {
+		ret = -ENOMEM;
+		goto free_pool;
+	}
+
+	/* create the dmabuf */
+	exp_info.ops = &sram_dma_heap_buf_ops;
+	exp_info.size = buffer->len;
+	exp_info.flags = O_RDWR;
+	exp_info.priv = buffer;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto free_pool;
+	}
+
+	ret = dma_buf_fd(dmabuf, O_CLOEXEC);
+	if (ret < 0) {
+		dma_buf_put(dmabuf);
+		/* just return, as put will call release and that will free */
+		return ret;
+	}
+
+	return ret;
+
+free_pool:
+	gen_pool_free(buffer->pool, buffer->vaddr, buffer->len);
+free_buffer:
+	kfree(buffer);
+
+	return ret;
+}
+
+static struct dma_heap_ops sram_dma_heap_ops = {
+	.allocate = sram_dma_heap_allocate,
+};
+
+int sram_dma_heap_export(struct sram_dev *sram,
+			 struct sram_reserve *block,
+			 phys_addr_t start,
+			 struct sram_partition *part)
+{
+	struct sram_dma_heap *sram_dma_heap;
+
+	dev_info(sram->dev, "Exporting SRAM pool '%s'\n", block->label);
+
+	sram_dma_heap = kzalloc(sizeof(*sram_dma_heap), GFP_KERNEL);
+	if (!sram_dma_heap)
+		return -ENOMEM;
+
+	sram_dma_heap->heap.name = block->label;
+	sram_dma_heap->heap.ops = &sram_dma_heap_ops;
+	sram_dma_heap->pool = part->pool;
+
+	dma_heap_add(&sram_dma_heap->heap);
+
+	return 0;
+}
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 80d8cbe8c01a..d11a3ab7b9b2 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -122,6 +122,15 @@ static int sram_add_partition(struct sram_dev *sram, struct sram_reserve *block,
 		if (ret)
 			return ret;
 	}
+	if (block->dma_heap_export) {
+		ret = sram_add_pool(sram, block, start, part);
+		if (ret)
+			return ret;
+
+		ret = sram_dma_heap_export(sram, block, start, part);
+		if (ret)
+			return ret;
+	}
 	if (block->protect_exec) {
 		ret = sram_check_protect_exec(sram, block, part);
 		if (ret)
@@ -222,8 +231,11 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 		if (of_find_property(child, "protect-exec", NULL))
 			block->protect_exec = true;
 
-		if ((block->export || block->pool || block->protect_exec) &&
-		    block->size) {
+		if (of_find_property(child, "dma-heap-export", NULL))
+			block->dma_heap_export = true;
+
+		if ((block->export || block->pool || block->protect_exec ||
+		     block->dma_heap_export) && block->size) {
 			exports++;
 
 			label = NULL;
@@ -285,8 +297,8 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 			goto err_chunks;
 		}
 
-		if ((block->export || block->pool || block->protect_exec) &&
-		    block->size) {
+		if ((block->export || block->pool || block->protect_exec ||
+		     block->dma_heap_export) && block->size) {
 			ret = sram_add_partition(sram, block,
 						 res->start + block->start);
 			if (ret) {
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index c181ce4c8fca..c1eef4c32152 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -35,6 +35,7 @@ struct sram_reserve {
 	bool export;
 	bool pool;
 	bool protect_exec;
+	bool dma_heap_export;
 	const char *label;
 };
 
@@ -55,4 +56,20 @@ static inline int sram_add_protect_exec(struct sram_partition *part)
 	return -ENODEV;
 }
 #endif /* CONFIG_SRAM_EXEC */
+
+#ifdef CONFIG_SRAM_DMA_HEAP
+int sram_dma_heap_export(struct sram_dev *sram,
+			 struct sram_reserve *block,
+			 phys_addr_t start,
+			 struct sram_partition *part);
+#else
+static inline int sram_dma_heap_export(struct sram_dev *sram,
+				       struct sram_reserve *block,
+				       phys_addr_t start,
+				       struct sram_partition *part)
+{
+	return 0;
+}
+#endif /* CONFIG_SRAM_DMA_HEAP */
+
 #endif /* __SRAM_H */
-- 
2.21.0

