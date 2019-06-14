Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD9C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADC42133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJaWxF1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfFNOpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:45:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfFNOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6oT8UJTQXi/1p8Vkkp5X8xwmGurQs1ddz1miIiClqjk=; b=mJaWxF1LU5NE66yogc7K2jE1M/
        ajfoGNhD/vHgJ/uO2a6yGrnarIGQmAne1urocITqlmwPKCKe2hlDmAS5mYlahdFDwlTHEpCkUvZst
        H/0IapTE9o/v3gUJZtcOSKnxWVSlqsRtANoKdrY4+dxqP8cB9X1c+Ds8XzV0nIqb7c0zXEBxA8pgT
        Q0QJQs89LQ6TsbElGVp2107/s1joP7iiwY/LBLoR9E7trvIwigj06pgJxwCloASrzS6n0cw8RPir2
        eVruFf63T1nOouQVzlVGxJTiFciYyfyh+t+IgLGxXQEMNMLk4Fo9aGxmnTOJVy2gf1kdcyN/sCPZe
        77MjzUgw==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbnRp-00064n-IM; Fri, 14 Jun 2019 14:44:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code
Date:   Fri, 14 Jun 2019 16:44:30 +0200
Message-Id: <20190614144431.21760-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614144431.21760-1-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA_ATTR_NO_KERNEL_MAPPING is generally implemented by allocating
normal cacheable pages or CMA memory, and then returning the page
pointer as the opaque handle.  Lift that code from the xtensa and
generic dma remapping implementations into the generic dma-direct
code so that we don't even call arch_dma_alloc for these allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/kernel/pci-dma.c    |  8 +-------
 include/linux/dma-noncoherent.h |  2 ++
 kernel/dma/direct.c             | 14 ++++++++++++++
 kernel/dma/remap.c              | 13 ++-----------
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 9171bff76fc4..206771277dff 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -167,10 +167,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	*handle = phys_to_dma(dev, page_to_phys(page));
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		return page;
-	}
-
 #ifdef CONFIG_MMU
 	if (PageHighMem(page)) {
 		void *p;
@@ -196,9 +192,7 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	struct page *page;
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		page = vaddr;
-	} else if (platform_vaddr_uncached(vaddr)) {
+	if (platform_vaddr_uncached(vaddr)) {
 		page = virt_to_page(platform_vaddr_to_cached(vaddr));
 	} else {
 #ifdef CONFIG_MMU
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 732919ac5c11..53ee36ecdf37 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -28,6 +28,8 @@ static inline bool dma_alloc_need_uncached(struct device *dev,
 {
 	if (dev_is_dma_coherent(dev))
 		return false;
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return false;
 	if (IS_ENABLED(CONFIG_DMA_NONCOHERENT_CACHE_SYNC) &&
 	    (attrs & DMA_ATTR_NON_CONSISTENT))
 		return false;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index fc354f4f490b..b90e1aede743 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -138,6 +138,14 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+		/* remove any dirty cache lines on the kernel alias */
+		if (!PageHighMem(page))
+			arch_dma_prep_coherent(page, size);
+		/* return the page pointer as the opaque cookie */
+		return page;
+	}
+
 	if (PageHighMem(page)) {
 		/*
 		 * Depending on the cma= arguments and per-arch setup
@@ -178,6 +186,12 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+		/* cpu_addr is a struct page cookie, not a kernel address */
+		__dma_direct_free_pages(dev, size, cpu_addr);
+		return;
+	}
+
 	if (force_dma_unencrypted())
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 0207e3764d52..a594aec07882 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -202,8 +202,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	size = PAGE_ALIGN(size);
 
-	if (!gfpflags_allow_blocking(flags) &&
-	    !(attrs & DMA_ATTR_NO_KERNEL_MAPPING)) {
+	if (!gfpflags_allow_blocking(flags)) {
 		ret = dma_alloc_from_pool(size, &page, flags);
 		if (!ret)
 			return NULL;
@@ -217,11 +216,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* remove any dirty cache lines on the kernel alias */
 	arch_dma_prep_coherent(page, size);
 
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		ret = page; /* opaque cookie */
-		goto done;
-	}
-
 	/* create a coherent mapping */
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
 			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
@@ -240,10 +234,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
-		/* vaddr is a struct page cookie, not a kernel address */
-		__dma_direct_free_pages(dev, size, vaddr);
-	} else if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
+	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
 		phys_addr_t phys = dma_to_phys(dev, dma_handle);
 		struct page *page = pfn_to_page(__phys_to_pfn(phys));
 
-- 
2.20.1

