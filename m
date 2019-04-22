Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE47C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B37B214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfDVQvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:51:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55032 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfDVQvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:51:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D1891A0217;
        Mon, 22 Apr 2019 18:51:28 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2029A1A0039;
        Mon, 22 Apr 2019 18:51:28 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id AF3ED205DD;
        Mon, 22 Apr 2019 18:51:27 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org
Cc:     leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH] dma-mapping: create iommu mapping for newly allocated dma coherent mem
Date:   Mon, 22 Apr 2019 19:51:25 +0300
Message-Id: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

If possible / available call into the DMA API to get a proper iommu
mapping and a dma address for the newly allocated coherent dma memory.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm/mm/dma-mapping-nommu.c |  3 ++-
 include/linux/dma-mapping.h     | 12 ++++++---
 kernel/dma/coherent.c           | 45 +++++++++++++++++++++++----------
 kernel/dma/mapping.c            |  3 ++-
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index f304b10e23a4..2c42e83a6995 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -74,7 +74,8 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
 		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 	} else {
 		int ret = dma_release_from_global_coherent(get_order(size),
-							   cpu_addr);
+							   cpu_addr, size,
+							   dma_addr);
 
 		WARN_ON_ONCE(ret == 0);
 	}
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6309a721394b..cb23334608a7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -161,19 +161,21 @@ static inline int is_device_dma_capable(struct device *dev)
  */
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 				       dma_addr_t *dma_handle, void **ret);
-int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
+int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr,
+				  ssize_t size, dma_addr_t dma_handle);
 
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			    void *cpu_addr, size_t size, int *ret);
 
 void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle);
-int dma_release_from_global_coherent(int order, void *vaddr);
+int dma_release_from_global_coherent(int order, void *vaddr, ssize_t size,
+				     dma_addr_t dma_handle);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
 				  size_t size, int *ret);
 
 #else
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
-#define dma_release_from_dev_coherent(dev, order, vaddr) (0)
+#define dma_release_from_dev_coherent(dev, order, vaddr, size, dma_handle) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
 
 static inline void *dma_alloc_from_global_coherent(ssize_t size,
@@ -182,7 +184,9 @@ static inline void *dma_alloc_from_global_coherent(ssize_t size,
 	return NULL;
 }
 
-static inline int dma_release_from_global_coherent(int order, void *vaddr)
+static inline int dma_release_from_global_coherent(int order, void *vaddr
+						   ssize_t size,
+						   dma_addr_t dma_handle)
 {
 	return 0;
 }
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 29fd6590dc1e..b40439d6feaa 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -135,13 +135,15 @@ void dma_release_declared_memory(struct device *dev)
 }
 EXPORT_SYMBOL(dma_release_declared_memory);
 
-static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
-		ssize_t size, dma_addr_t *dma_handle)
+static void *__dma_alloc_from_coherent(struct device *dev,
+				       struct dma_coherent_mem *mem,
+				       ssize_t size, dma_addr_t *dma_handle)
 {
 	int order = get_order(size);
 	unsigned long flags;
 	int pageno;
 	void *ret;
+	const struct dma_map_ops *ops = dev ? get_dma_ops(dev) : NULL;
 
 	spin_lock_irqsave(&mem->spinlock, flags);
 
@@ -155,10 +157,16 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
 	/*
 	 * Memory was found in the coherent area.
 	 */
-	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
 	ret = mem->virt_base + (pageno << PAGE_SHIFT);
 	spin_unlock_irqrestore(&mem->spinlock, flags);
 	memset(ret, 0, size);
+	if (ops && ops->map_resource)
+		*dma_handle = ops->map_resource(dev,
+						mem->device_base +
+							(pageno << PAGE_SHIFT),
+						size, DMA_BIDIRECTIONAL, 0);
+	else
+		*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
 	return ret;
 err:
 	spin_unlock_irqrestore(&mem->spinlock, flags);
@@ -187,7 +195,7 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 	if (!mem)
 		return 0;
 
-	*ret = __dma_alloc_from_coherent(mem, size, dma_handle);
+	*ret = __dma_alloc_from_coherent(dev, mem, size, dma_handle);
 	return 1;
 }
 
@@ -196,18 +204,26 @@ void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
 	if (!dma_coherent_default_memory)
 		return NULL;
 
-	return __dma_alloc_from_coherent(dma_coherent_default_memory, size,
-			dma_handle);
+	return __dma_alloc_from_coherent(NULL, dma_coherent_default_memory,
+			size, dma_handle);
 }
 
-static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
-				       int order, void *vaddr)
+static int __dma_release_from_coherent(struct device *dev,
+				       struct dma_coherent_mem *mem,
+				       int order, void *vaddr, ssize_t size,
+				       dma_addr_t dma_handle)
 {
+	const struct dma_map_ops *ops = dev ? get_dma_ops(dev) : NULL;
+
 	if (mem && vaddr >= mem->virt_base && vaddr <
 		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
 		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
 		unsigned long flags;
 
+		if (ops && ops->unmap_resource)
+			ops->unmap_resource(dev, dma_handle, size,
+					    DMA_BIDIRECTIONAL, 0);
+
 		spin_lock_irqsave(&mem->spinlock, flags);
 		bitmap_release_region(mem->bitmap, page, order);
 		spin_unlock_irqrestore(&mem->spinlock, flags);
@@ -228,20 +244,23 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
  * Returns 1 if we correctly released the memory, or 0 if the caller should
  * proceed with releasing memory from generic pools.
  */
-int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
+int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr,
+				  ssize_t size, dma_addr_t dma_handle)
 {
 	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
 
-	return __dma_release_from_coherent(mem, order, vaddr);
+	return __dma_release_from_coherent(dev, mem, order, vaddr, size,
+					   dma_handle);
 }
 
-int dma_release_from_global_coherent(int order, void *vaddr)
+int dma_release_from_global_coherent(int order, void *vaddr, ssize_t size,
+				     dma_addr_t dma_handle)
 {
 	if (!dma_coherent_default_memory)
 		return 0;
 
-	return __dma_release_from_coherent(dma_coherent_default_memory, order,
-			vaddr);
+	return __dma_release_from_coherent(NULL, dma_coherent_default_memory,
+					   order, vaddr, size, dma_handle);
 }
 
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 685a53f2a793..398bf838b7d7 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -269,7 +269,8 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
+	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr,
+					  size, dma_handle))
 		return;
 	/*
 	 * On non-coherent platforms which implement DMA-coherent buffers via
-- 
2.17.1

