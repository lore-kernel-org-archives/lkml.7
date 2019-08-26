Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878EFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDE1217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="obE0oGFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfHZMT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:19:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHZMTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uH1XEnooqVO+kijX2zwd1T4ENFnH9Jm9s21Ta3q26GA=; b=obE0oGFOp4Dx4rGrFKRIaa8iXc
        W3uUj0Bf5p5gIbW9cQtbcLbJtRSCq5LwBSpLZmUi2wQ8dUpWMr5w789r67dZvJ8+NP15OxBKgzoKY
        J93XPXR/erFGPPPPDq2QWCZOeOubl4cIa93RCQowXc2GWeQA7EaU8VYMTvdMIZzBJhB4Nl1NnQQ8V
        ZRKku+0NZ7NXbzBHeLXGr8+V3Xm8ccSAiqj5vDj9up+NQSNwyptyV/pupL3Ty0VZMPoLW6bqcGHAP
        g8zM3qaVemKhbJc90UQgAY87V39bK5BCnuHfsRnYts7tAw3+E9bRCqcfhCiVaRA9k7/ta7PNQSHwI
        7T5iANzQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2DyR-0002HL-Gk; Mon, 26 Aug 2019 12:19:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH 02/11] xen/arm: use dev_is_dma_coherent
Date:   Mon, 26 Aug 2019 14:19:35 +0200
Message-Id: <20190826121944.515-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826121944.515-1-hch@lst.de>
References: <20190826121944.515-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the dma-noncoherent dev_is_dma_coherent helper instead of the home
grown variant.  Note that both are always initialized to the same
value in arch_setup_dma_ops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm/include/asm/dma-mapping.h   |  6 ------
 arch/arm/xen/mm.c                    | 12 ++++++------
 arch/arm64/include/asm/dma-mapping.h |  9 ---------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index dba9355e2484..bdd80ddbca34 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -91,12 +91,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 }
 #endif
 
-/* do not use this function in a driver */
-static inline bool is_device_dma_coherent(struct device *dev)
-{
-	return dev->archdata.dma_coherent;
-}
-
 /**
  * arm_dma_alloc - allocate consistent memory for DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index d33b77e9add3..90574d89d0d4 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/cpu.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/export.h>
@@ -99,7 +99,7 @@ void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
 	     enum dma_data_direction dir, unsigned long attrs)
 {
-	if (is_device_dma_coherent(hwdev))
+	if (dev_is_dma_coherent(hwdev))
 		return;
 	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
 		return;
@@ -112,7 +112,7 @@ void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		unsigned long attrs)
 
 {
-	if (is_device_dma_coherent(hwdev))
+	if (dev_is_dma_coherent(hwdev))
 		return;
 	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
 		return;
@@ -123,7 +123,7 @@ void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 void __xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	if (is_device_dma_coherent(hwdev))
+	if (dev_is_dma_coherent(hwdev))
 		return;
 	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
 }
@@ -131,7 +131,7 @@ void __xen_dma_sync_single_for_cpu(struct device *hwdev,
 void __xen_dma_sync_single_for_device(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	if (is_device_dma_coherent(hwdev))
+	if (dev_is_dma_coherent(hwdev))
 		return;
 	__xen_dma_page_cpu_to_dev(hwdev, handle, size, dir);
 }
@@ -159,7 +159,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 	 * memory and we are not able to flush the cache.
 	 */
 	return (!hypercall_cflush && (xen_pfn != bfn) &&
-		!is_device_dma_coherent(dev));
+		!dev_is_dma_coherent(dev));
 }
 
 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index bdcb0922a40c..67243255a858 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -18,14 +18,5 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-/*
- * Do not use this function in a driver, it is only provided for
- * arch/arm/mm/xen.c, which is used by arm64 as well.
- */
-static inline bool is_device_dma_coherent(struct device *dev)
-{
-	return dev->dma_coherent;
-}
-
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_DMA_MAPPING_H */
-- 
2.20.1

