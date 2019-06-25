Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E8C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABE2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pMFlxvyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfFYJBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:01:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731222AbfFYJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OSB/pyGYojiY3sdqNs0r90WCUzNFlQOPe6uMqnDtBbc=; b=pMFlxvyw1Bb16t5MaLee0BM7Bt
        C+xZOyLkGS65fjTnBsKMWQr2BtGOHdxtRCQXOPwLXkjQLnNhbgv16PpOEjndWjmza0N2HWjA3kTh7
        VSq3e/lorK9K+O0gzt3dwh0Jxw2MyWrq46npXu+MnJhGUoWDa35+USN2vloBjGlek+OMz+RbEh77m
        4IhlTUtSQ7ainfkJmpCd8fCvphYYzZMv2LphFGBGnPb8YDL1akru0XA/N80YzWwn8gmz/wCNq3azN
        K3FcPuKpJiztwfTTVn1SLJy1uDBd3Tzt/YcfmcS1THmHrKjwKuQe4KY2uwvYmFPcSVVeipeQDIOhJ
        YdLEFnCQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfhKe-0004CA-Bs; Tue, 25 Jun 2019 09:01:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] m68k: use the generic dma coherent remap allocator
Date:   Tue, 25 Jun 2019 11:01:34 +0200
Message-Id: <20190625090135.18872-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625090135.18872-1-hch@lst.de>
References: <20190625090135.18872-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switche to using common code for the DMA allocations, including
potential use of the CMA allocator if configure.  Also add a
comment where the existing behavior seems to be lacking.

Switching to the generic code enables DMA allocations from atomic
context, which is required by the DMA API documentation, and also
adds various other minor features drivers start relying upon.  It
also makes sure we have on tested code base for all architectures
that require uncached pte bits for coherent DMA allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig      |  2 ++
 arch/m68k/kernel/dma.c | 59 ++++++++----------------------------------
 2 files changed, 13 insertions(+), 48 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 218e037ef901..3a52bf46e043 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,10 +3,12 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_NO_PREEMPT if !COLDFIRE
+	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
 	select HAVE_IDE
 	select HAVE_AOUT if MMU
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index b4aa853051bd..9c6a350a16d8 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -18,57 +18,20 @@
 #include <asm/pgalloc.h>
 
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t flag, unsigned long attrs)
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
 {
-	struct page *page, **map;
-	pgprot_t pgprot;
-	void *addr;
-	int i, order;
-
-	pr_debug("dma_alloc_coherent: %d,%x\n", size, flag);
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	page = alloc_pages(flag | __GFP_ZERO, order);
-	if (!page)
-		return NULL;
-
-	*handle = page_to_phys(page);
-	map = kmalloc(sizeof(struct page *) << order, flag & ~__GFP_DMA);
-	if (!map) {
-		__free_pages(page, order);
-		return NULL;
+	/*
+	 * XXX: this doesn't seem to handle the sun3 MMU at all.
+	 */
+	if (CPU_IS_040_OR_060) {
+		pgprot_val(prot) &= ~_PAGE_CACHE040;
+		pgprot_val(prot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
+	} else {
+		pgprot_val(prot) |= _PAGE_NOCACHE030;
 	}
-	split_page(page, order);
-
-	order = 1 << order;
-	size >>= PAGE_SHIFT;
-	map[0] = page;
-	for (i = 1; i < size; i++)
-		map[i] = page + i;
-	for (; i < order; i++)
-		__free_page(page + i);
-	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_DIRTY);
-	if (CPU_IS_040_OR_060)
-		pgprot_val(pgprot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
-	else
-		pgprot_val(pgprot) |= _PAGE_NOCACHE030;
-	addr = vmap(map, size, VM_MAP, pgprot);
-	kfree(map);
-
-	return addr;
+	return prot;
 }
-
-void arch_dma_free(struct device *dev, size_t size, void *addr,
-		dma_addr_t handle, unsigned long attrs)
-{
-	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
-	vfree(addr);
-}
-
 #else
 
 #include <asm/cacheflush.h>
-- 
2.20.1

