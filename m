Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C34C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7E02186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t1ApPndM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfH3G3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:29:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfH3G3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0y+9KoS1PnyYgbZ0diEb55NBLOiuV9OrcKuSnhE0A+c=; b=t1ApPndMujtAmnjxx/tI3LPF6B
        ar9lyXJFl10DJG4oQiz61QsDha2qACQU9HQU+VoWJXDjnqQEh7xGGB1fEGteJXxDkjQpOUZQxBF0F
        36ciF83AzDSctqxofYkHfElUlJq0hSkHLtBWJ38ugY6ZfISExlDh6L+pNzIfkGQyoFgHvYeoVrxwg
        hOZ2WkzhJcgPDKQ6zbgmu2PdhWtJbVjIJ/b5iqtYRnIm7eRLtPF9YetmvWnDtsNoDu2EtCeYkbMUq
        uGLeu/JYEiloNWGJtzrLa1/ZCSnQjF4zGbEpSuBNsArCwwE9cej7rSDSG7X0TFbqga+vIqCpGfn/p
        Nu0WZs5w==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3aPd-0002qM-HG; Fri, 30 Aug 2019 06:29:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dma-mapping: always use VM_DMA_COHERENT for generic DMA remap
Date:   Fri, 30 Aug 2019 08:29:22 +0200
Message-Id: <20190830062924.21714-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830062924.21714-1-hch@lst.de>
References: <20190830062924.21714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the generic dma remap allocator gets a vm_flags passed by
the caller that is a little confusing.  We just introduced a generic
vmalloc-level flag to identify the dma coherent allocations, so use
that everywhere and remove the now pointless argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c    | 10 ++++------
 arch/xtensa/kernel/pci-dma.c |  4 ++--
 drivers/iommu/dma-iommu.c    |  6 +++---
 include/linux/dma-mapping.h  |  6 ++----
 kernel/dma/remap.c           | 25 +++++++++++--------------
 5 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5c0af4a2faa7..054a66f725b3 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -340,13 +340,12 @@ static void *
 __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
 	const void *caller)
 {
-	return dma_common_contiguous_remap(page, size, VM_DMA_COHERENT,
-			prot, caller);
+	return dma_common_contiguous_remap(page, size, prot, caller);
 }
 
 static void __dma_free_remap(void *cpu_addr, size_t size)
 {
-	dma_common_free_remap(cpu_addr, size, VM_DMA_COHERENT);
+	dma_common_free_remap(cpu_addr, size);
 }
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE	SZ_256K
@@ -1373,8 +1372,7 @@ static void *
 __iommu_alloc_remap(struct page **pages, size_t size, gfp_t gfp, pgprot_t prot,
 		    const void *caller)
 {
-	return dma_common_pages_remap(pages, size, VM_DMA_COHERENT, prot,
-			caller);
+	return dma_common_pages_remap(pages, size, prot, caller);
 }
 
 /*
@@ -1617,7 +1615,7 @@ void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	}
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
-		dma_common_free_remap(cpu_addr, size, VM_DMA_COHERENT);
+		dma_common_free_remap(cpu_addr, size);
 
 	__iommu_remove_mapping(dev, handle, size);
 	__iommu_free_buffer(dev, pages, size, attrs);
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 65f05776d827..154979d62b73 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -167,7 +167,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (PageHighMem(page)) {
 		void *p;
 
-		p = dma_common_contiguous_remap(page, size, VM_MAP,
+		p = dma_common_contiguous_remap(page, size,
 						pgprot_noncached(PAGE_KERNEL),
 						__builtin_return_address(0));
 		if (!p) {
@@ -192,7 +192,7 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		page = virt_to_page(platform_vaddr_to_cached(vaddr));
 	} else {
 #ifdef CONFIG_MMU
-		dma_common_free_remap(vaddr, size, VM_MAP);
+		dma_common_free_remap(vaddr, size);
 #endif
 		page = pfn_to_page(PHYS_PFN(dma_to_phys(dev, dma_handle)));
 	}
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f68a62c3c32b..013416f5ad38 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -617,7 +617,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 			< size)
 		goto out_free_sg;
 
-	vaddr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
+	vaddr = dma_common_pages_remap(pages, size, prot,
 			__builtin_return_address(0));
 	if (!vaddr)
 		goto out_unmap;
@@ -941,7 +941,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 		pages = __iommu_dma_get_pages(cpu_addr);
 		if (!pages)
 			page = vmalloc_to_page(cpu_addr);
-		dma_common_free_remap(cpu_addr, alloc_size, VM_USERMAP);
+		dma_common_free_remap(cpu_addr, alloc_size);
 	} else {
 		/* Lowmem means a coherent atomic or CMA allocation */
 		page = virt_to_page(cpu_addr);
@@ -979,7 +979,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
-				VM_USERMAP, prot, __builtin_return_address(0));
+				prot, __builtin_return_address(0));
 		if (!cpu_addr)
 			goto out_free_pages;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea32c78..c9725390fbbc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -616,13 +616,11 @@ extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs);
 
 void *dma_common_contiguous_remap(struct page *page, size_t size,
-			unsigned long vm_flags,
 			pgprot_t prot, const void *caller);
 
 void *dma_common_pages_remap(struct page **pages, size_t size,
-			unsigned long vm_flags, pgprot_t prot,
-			const void *caller);
-void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags);
+			pgprot_t prot, const void *caller);
+void dma_common_free_remap(void *cpu_addr, size_t size);
 
 int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot);
 bool dma_in_atomic_pool(void *start, size_t size);
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index ffe78f0b2fe4..01d4ef5685a4 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -12,12 +12,11 @@
 #include <linux/vmalloc.h>
 
 static struct vm_struct *__dma_common_pages_remap(struct page **pages,
-			size_t size, unsigned long vm_flags, pgprot_t prot,
-			const void *caller)
+			size_t size, pgprot_t prot, const void *caller)
 {
 	struct vm_struct *area;
 
-	area = get_vm_area_caller(size, vm_flags, caller);
+	area = get_vm_area_caller(size, VM_DMA_COHERENT, caller);
 	if (!area)
 		return NULL;
 
@@ -34,12 +33,11 @@ static struct vm_struct *__dma_common_pages_remap(struct page **pages,
  * Cannot be used in non-sleeping contexts
  */
 void *dma_common_pages_remap(struct page **pages, size_t size,
-			unsigned long vm_flags, pgprot_t prot,
-			const void *caller)
+			 pgprot_t prot, const void *caller)
 {
 	struct vm_struct *area;
 
-	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+	area = __dma_common_pages_remap(pages, size, prot, caller);
 	if (!area)
 		return NULL;
 
@@ -53,7 +51,6 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
  * Cannot be used in non-sleeping contexts
  */
 void *dma_common_contiguous_remap(struct page *page, size_t size,
-			unsigned long vm_flags,
 			pgprot_t prot, const void *caller)
 {
 	int i;
@@ -67,7 +64,7 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	for (i = 0; i < (size >> PAGE_SHIFT); i++)
 		pages[i] = nth_page(page, i);
 
-	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+	area = __dma_common_pages_remap(pages, size, prot, caller);
 
 	kfree(pages);
 
@@ -79,11 +76,11 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 /*
  * Unmaps a range previously mapped by dma_common_*_remap
  */
-void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
+void dma_common_free_remap(void *cpu_addr, size_t size)
 {
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
-	if (!area || (area->flags & vm_flags) != vm_flags) {
+	if (!area || area->flags != VM_DMA_COHERENT) {
 		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
 		return;
 	}
@@ -127,8 +124,8 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 	if (!atomic_pool)
 		goto free_page;
 
-	addr = dma_common_contiguous_remap(page, atomic_pool_size, VM_USERMAP,
-					   prot, __builtin_return_address(0));
+	addr = dma_common_contiguous_remap(page, atomic_pool_size, prot,
+					   __builtin_return_address(0));
 	if (!addr)
 		goto destroy_genpool;
 
@@ -143,7 +140,7 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 	return 0;
 
 remove_mapping:
-	dma_common_free_remap(addr, atomic_pool_size, VM_USERMAP);
+	dma_common_free_remap(addr, atomic_pool_size);
 destroy_genpool:
 	gen_pool_destroy(atomic_pool);
 	atomic_pool = NULL;
@@ -217,7 +214,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	arch_dma_prep_coherent(page, size);
 
 	/* create a coherent mapping */
-	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
+	ret = dma_common_contiguous_remap(page, size,
 			dma_pgprot(dev, PAGE_KERNEL, attrs),
 			__builtin_return_address(0));
 	if (!ret) {
-- 
2.20.1

