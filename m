Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF0DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8856921917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dfqJALfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCUWxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:53:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfCUWxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AyCBwPbpM5mZLjGJI2JihnqcjJj7rmgeIxLbnmVYgXQ=; b=dfqJALfCXIwms+p3RVZbiVrpcC
        kfv81fyh60h9t6nB26O7crLPEG4KoscROX48qPWUJmpnBzalzL3fPC2lcTkRZ5U8HnT8ZQDtmgemP
        CS7oybZd4qr/1HjwL9opq+wk73NLr1Wob8xrtVzLMU++0osbazVlEyayHqsfZN1osVG6lGG6FvaKa
        +Hr2bwNLXJNCqouTjLknCJQBC8SUa8qDgk1Ele+v1oHCVAOs2PgMZ4z5po0ntOhF7K7mWCQT2z3aD
        VQjdnCCsNdaGXVZn1g3LmCioR56m4q5uNgiShXXx3s5XLsrsd+hxAv/LaPLk2gc/EwAoJbcEt0DtL
        DpkrF/Mw==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76Z3-00008j-1j; Thu, 21 Mar 2019 22:53:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] x86: remove the x86_dma_fallback_dev hack
Date:   Thu, 21 Mar 2019 15:52:35 -0700
Message-Id: <20190321225235.30648-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
References: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we removed support for the NULL device argument in the DMA API,
there is no need to cater for that in the x86 code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/dma-mapping.h | 10 ----------
 arch/x86/kernel/amd_gart_64.c      |  6 ------
 arch/x86/kernel/pci-dma.c          | 20 --------------------
 kernel/dma/mapping.c               |  7 -------
 4 files changed, 43 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index ce4d176b3d13..6b15a24930e0 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -13,14 +13,7 @@
 #include <asm/swiotlb.h>
 #include <linux/dma-contiguous.h>
 
-#ifdef CONFIG_ISA
-# define ISA_DMA_BIT_MASK DMA_BIT_MASK(24)
-#else
-# define ISA_DMA_BIT_MASK DMA_BIT_MASK(32)
-#endif
-
 extern int iommu_merge;
-extern struct device x86_dma_fallback_dev;
 extern int panic_on_overflow;
 
 extern const struct dma_map_ops *dma_ops;
@@ -30,7 +23,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-bool arch_dma_alloc_attrs(struct device **dev);
-#define arch_dma_alloc_attrs arch_dma_alloc_attrs
-
 #endif
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 2c0aa34af69c..bf7f13ea3c64 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -233,9 +233,6 @@ static dma_addr_t gart_map_page(struct device *dev, struct page *page,
 	unsigned long bus;
 	phys_addr_t paddr = page_to_phys(page) + offset;
 
-	if (!dev)
-		dev = &x86_dma_fallback_dev;
-
 	if (!need_iommu(dev, paddr, size))
 		return paddr;
 
@@ -392,9 +389,6 @@ static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	if (nents == 0)
 		return 0;
 
-	if (!dev)
-		dev = &x86_dma_fallback_dev;
-
 	out		= 0;
 	start		= 0;
 	start_sg	= sg;
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index d460998ae828..dcd272dbd0a9 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -51,14 +51,6 @@ int iommu_pass_through __read_mostly;
 
 extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
 
-/* Dummy device used for NULL arguments (normally ISA). */
-struct device x86_dma_fallback_dev = {
-	.init_name = "fallback device",
-	.coherent_dma_mask = ISA_DMA_BIT_MASK,
-	.dma_mask = &x86_dma_fallback_dev.coherent_dma_mask,
-};
-EXPORT_SYMBOL(x86_dma_fallback_dev);
-
 void __init pci_iommu_alloc(void)
 {
 	struct iommu_table_entry *p;
@@ -77,18 +69,6 @@ void __init pci_iommu_alloc(void)
 	}
 }
 
-bool arch_dma_alloc_attrs(struct device **dev)
-{
-	if (!*dev)
-		*dev = &x86_dma_fallback_dev;
-
-	if (!is_device_dma_capable(*dev))
-		return false;
-	return true;
-
-}
-EXPORT_SYMBOL(arch_dma_alloc_attrs);
-
 /*
  * See <Documentation/x86/x86_64/boot-options.txt> for the iommu kernel
  * parameter documentation.
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index c000906348c9..685a53f2a793 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -238,10 +238,6 @@ u64 dma_get_required_mask(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
-#ifndef arch_dma_alloc_attrs
-#define arch_dma_alloc_attrs(dev)	(true)
-#endif
-
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs)
 {
@@ -256,9 +252,6 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-	if (!arch_dma_alloc_attrs(&dev))
-		return NULL;
-
 	if (dma_is_direct(ops))
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	else if (ops->alloc)
-- 
2.20.1

