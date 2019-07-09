Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E62C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0452080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="foBaLLp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfGIOUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:20:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfGIOUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wylUAD2ia2Evk3TjfD7C9+1ej5v4UwGT3A98rcK5akw=; b=foBaLLp38uAHkB2MXZiFlhSIfH
        obdWBGSxA8OcfJrXnTRLf2ILzvCH2tYPTX3nviu4Hqyp4g3FqYvoaULGLURr6JGRX96iHkI0NNvG4
        n/yoGLfq/qz7F6CRw618qF08QZYb8HUV1+zflAATJj+qj6avMKS0895vYL63wO6oZ33Q4YGn0jWhF
        ztqf0evmViJeO/vqOihSnM8vBSYx50TqfQMHTbYE2g3gtcQIK4w3/1KwC59i8drkbi/QzPPx3A7xY
        eQEihSeKpbME2a7JA77Gx0gMrwAbJvM1ZrvaF6XcpBjUH1m7qyPW2l34VmdgLvQVaLIOQMjzvQF/Z
        kIJvnl8w==;
Received: from [209.244.105.251] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkqya-0001Bn-JN; Tue, 09 Jul 2019 14:20:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 2/2] arm: use swiotlb for bounce buffer on LPAE configs
Date:   Tue,  9 Jul 2019 07:20:11 -0700
Message-Id: <20190709142011.24984-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709142011.24984-1-hch@lst.de>
References: <20190709142011.24984-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API requires that 32-bit DMA masks are always supported, but on
arm LPAE configs they do not currently work when memory is present
above 4GB.  Wire up the swiotlb code like for all other architectures
to provide the bounce buffering in that case.

Fixes: 21e07dba9fb11 ("scsi: reduce use of block bounce buffers").
Reported-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h |  4 +-
 arch/arm/mm/Kconfig                |  5 +++
 arch/arm/mm/dma-mapping.c          | 61 ++++++++++++++++++++++++++++++
 arch/arm/mm/init.c                 |  5 +++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 03ba90ffc0f8..054119cd7757 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -18,7 +18,9 @@ extern const struct dma_map_ops arm_coherent_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : NULL;
+	if (IS_ENABLED(CONFIG_MMU) && !IS_ENABLED(CONFIG_ARM_LPAE))
+		return &arm_dma_ops;
+	return NULL;
 }
 
 #ifdef __arch_page_to_dma
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index b169e580bf82..2dd36183d0e6 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -663,6 +663,11 @@ config ARM_LPAE
 	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
 		!CPU_32v4 && !CPU_32v3
 	select PHYS_ADDR_T_64BIT
+	select SWIOTLB
+	select ARCH_HAS_DMA_COHERENT_TO_PFN
+	select ARCH_HAS_DMA_MMAP_PGPROT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	help
 	  Say Y if you have an ARMv7 processor supporting the LPAE page
 	  table format and you would like to access memory beyond the
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index bdf0d236aaee..01a5b96d76a7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/dma-contiguous.h>
 #include <linux/highmem.h>
 #include <linux/memblock.h>
@@ -1129,6 +1130,19 @@ int arm_dma_supported(struct device *dev, u64 mask)
 
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 {
+	/*
+	 * When CONFIG_ARM_LPAE is set, physical address can extend above
+	 * 32-bits, which then can't be addressed by devices that only support
+	 * 32-bit DMA.
+	 * Use the generic dma-direct / swiotlb ops code in that case, as that
+	 * handles bounce buffering for us.
+	 *
+	 * Note: this checks CONFIG_ARM_LPAE instead of CONFIG_SWIOTLB as the
+	 * latter is also selected by the Xen code, but that code for now relies
+	 * on non-NULL dev_dma_ops.  To be cleaned up later.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		return NULL;
 	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
 }
 
@@ -2333,6 +2347,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	const struct dma_map_ops *dma_ops;
 
 	dev->archdata.dma_coherent = coherent;
+#ifdef CONFIG_SWIOTLB
+	dev->dma_coherent = coherent;
+#endif
 
 	/*
 	 * Don't override the dma_ops if they have already been set. Ideally
@@ -2367,3 +2384,47 @@ void arch_teardown_dma_ops(struct device *dev)
 	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
 	set_dma_ops(dev, NULL);
 }
+
+#ifdef CONFIG_SWIOTLB
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_page_cpu_to_dev(phys_to_page(paddr), paddr & (PAGE_SIZE - 1),
+			      size, dir);
+}
+
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_page_dev_to_cpu(phys_to_page(paddr), paddr & (PAGE_SIZE - 1),
+			      size, dir);
+}
+
+long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
+		dma_addr_t dma_addr)
+{
+	return dma_to_pfn(dev, dma_addr);
+}
+
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		return __get_dma_pgprot(attrs, prot);
+	return prot;
+}
+
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs)
+{
+	return __dma_alloc(dev, size, dma_handle, gfp,
+			   __get_dma_pgprot(attrs, PAGE_KERNEL), false,
+			   attrs, __builtin_return_address(0));
+}
+
+void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_handle, unsigned long attrs)
+{
+	__arm_dma_free(dev, size, cpu_addr, dma_handle, attrs, false);
+}
+#endif /* CONFIG_SWIOTLB */
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index be0b42937888..64541be15d43 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -24,6 +24,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/sizes.h>
 #include <linux/stop_machine.h>
+#include <linux/swiotlb.h>
 
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
@@ -456,6 +457,10 @@ void __init mem_init(void)
 	extern u32 itcm_end;
 #endif
 
+#ifdef CONFIG_ARM_LPAE
+	swiotlb_init(1);
+#endif
+
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
 
 	/* this will put all unused low memory onto the freelists */
-- 
2.20.1

