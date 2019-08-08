Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8715AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F430217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UTQWvhiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404166AbfHHQBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:01:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403889AbfHHQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ess16cPXbwlPMdQlB/xmV3Dd8N7gPnmmYAJHlhdUYyM=; b=UTQWvhiKzWRKxbwjgLpwDsLgDC
        mdER2aY5BkjLhbcVD3e7Qn2ZWj8gN9YmhyDOIZXRFaHCOkJqMssGtkgQ6B8/VLEOBirIPphRjIcLq
        tiS8OHDJu2YKmix5fXR8g6vL8uomNeUbO+m/Tuexlii7PxDRAESee02EcVtFUNHSxWkdaEdrhQGi0
        K5xHqvMOWsAMX02BpcU/2C2e4OOxLMReujU0ZBGCPxq2purguCPYY2w0mLbdpOqV00tdd+PU8ms3b
        Vw350H8QjPAmpD/uQ1hyaDUCyLtIOKSt1smGUSm651G33drEHzlSC2shYAz/YSDZpgctQ+GzJKuMh
        Wzl07JIA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkqW-0006wr-CU; Thu, 08 Aug 2019 16:00:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Takashi Iwai <tiwai@suse.de>, Helge Deller <deller@gmx.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] dma-mapping: remove CONFIG_ARCH_NO_COHERENT_DMA_MMAP
Date:   Thu,  8 Aug 2019 19:00:05 +0300
Message-Id: <20190808160005.10325-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ARCH_NO_COHERENT_DMA_MMAP is now functionally identical to
!CONFIG_MMU, so remove the separate symbol.  The only difference is that
arm did not set it for !CONFIG_MMU, but arm uses a separate dma mapping
implementation including its own mmap method, which is handled by moving
the CONFIG_MMU check in dma_can_mmap so that is only applies to the
dma-direct case, just as the other ifdefs for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig            |  3 ---
 arch/c6x/Kconfig        |  1 -
 arch/m68k/Kconfig       |  1 -
 arch/microblaze/Kconfig |  1 -
 arch/sh/Kconfig         |  1 -
 arch/xtensa/Kconfig     |  1 -
 kernel/dma/mapping.c    | 12 +++++-------
 7 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a7b57dd42c26..ec2834206d08 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -790,9 +790,6 @@ config COMPAT_32BIT_TIME
 	  This is relevant on all 32-bit architectures, and 64-bit architectures
 	  as part of compat syscall handling.
 
-config ARCH_NO_COHERENT_DMA_MMAP
-	bool
-
 config ARCH_NO_PREEMPT
 	bool
 
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index b4fb61c83494..e65e8d82442a 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -20,7 +20,6 @@ config C6X
 	select OF_EARLY_FLATTREE
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
-	select ARCH_NO_COHERENT_DMA_MMAP
 	select MMU_GATHER_NO_RANGE if MMU
 
 config MMU
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index c518d695c376..614b355ae338 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -8,7 +8,6 @@ config M68K
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
-	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_NO_PREEMPT if !COLDFIRE
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d411de05b628..632c9477a0f6 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -9,7 +9,6 @@ config MICROBLAZE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
 	select TIMER_OF
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 6b1b5941b618..f356ee674d89 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -5,7 +5,6 @@ config SUPERH
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_PATA_PLATFORM
 	select CLKDEV_LOOKUP
 	select DMA_DECLARE_COHERENT
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index ebc135bda921..70653aed3005 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -5,7 +5,6 @@ config XTENSA
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 64d1de59e133..fc17016b0871 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -186,7 +186,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
-#ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
+#ifdef CONFIG_MMU
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
@@ -217,7 +217,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
 #else
 	return -ENXIO;
-#endif /* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
+#endif /* CONFIG_MMU */
 }
 
 /**
@@ -231,12 +231,10 @@ bool dma_can_mmap(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (IS_ENABLED(CONFIG_ARCH_NO_COHERENT_DMA_MMAP))
-		return false;
-
 	if (dma_is_direct(ops)) {
-		return dev_is_dma_coherent(dev) ||
-			IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN);
+		return IS_ENABLED(CONFIG_MMU) &&
+		       (dev_is_dma_coherent(dev) ||
+			IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN));
 	}
 
 	return ops->mmap != NULL;
-- 
2.20.1

