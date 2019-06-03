Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E1C282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B7327A32
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFCBXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:23:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:20792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCBXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:23:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 18:23:52 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 18:23:48 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
        kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>
Subject: [PATCH v4 4/9] iommu: Add bounce page APIs
Date:   Mon,  3 Jun 2019 09:16:15 +0800
Message-Id: <20190603011620.31999-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603011620.31999-1-baolu.lu@linux.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU hardware always use paging for DMA remapping.  The
minimum mapped window is a page size. The device drivers
may map buffers not filling whole IOMMU window. It allows
device to access to possibly unrelated memory and various
malicious devices can exploit this to perform DMA attack.

This introduces the bouce buffer mechanism for DMA buffers
which doesn't fill a minimal IOMMU page. It could be used
by various vendor specific IOMMU drivers as long as the
DMA domain is managed by the generic IOMMU layer. Below
APIs are added:

* iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
  - Map a buffer start at DMA address @addr in bounce page
    manner. For buffer parts that doesn't cross a whole
    minimal IOMMU page, the bounce page policy is applied.
    A bounce page mapped by swiotlb will be used as the DMA
    target in the IOMMU page table. Otherwise, the physical
    address @paddr is mapped instead.

* iommu_bounce_unmap(dev, addr, size, dir, attrs)
  - Unmap the buffer mapped with iommu_bounce_map(). The bounce
    page will be torn down after the bounced data get synced.

* iommu_bounce_sync(dev, addr, size, dir, target)
  - Synce the bounced data in case the bounce mapped buffer is
    reused.

The whole APIs are included within a kernel option IOMMU_BOUNCE_PAGE.
It's useful for cases where bounce page doesn't needed, for example,
embedded cases.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/Kconfig |  14 +++++
 drivers/iommu/iommu.c | 119 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  35 +++++++++++++
 3 files changed, 168 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 83664db5221d..d837ec3f359b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -86,6 +86,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
 
 	  If unsure, say N here.
 
+config IOMMU_BOUNCE_PAGE
+	bool "Use bounce page for untrusted devices"
+	depends on IOMMU_API
+	select SWIOTLB
+	help
+	  IOMMU hardware always use paging for DMA remapping. The minimum
+	  mapped window is a page size. The device drivers may map buffers
+	  not filling whole IOMMU window. This allows device to access to
+	  possibly unrelated memory and malicious device can exploit this
+	  to perform a DMA attack. Select this to use a bounce page for the
+	  buffer which doesn't fill a whole IOMU page.
+
+	  If unsure, say N here.
+
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2a906386bb8e..fa44f681a82b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2246,3 +2246,122 @@ int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return ops->sva_get_pasid(handle);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
+
+#ifdef CONFIG_IOMMU_BOUNCE_PAGE
+
+/*
+ * Bounce buffer support for external devices:
+ *
+ * IOMMU hardware always use paging for DMA remapping. The minimum mapped
+ * window is a page size. The device drivers may map buffers not filling
+ * whole IOMMU window. This allows device to access to possibly unrelated
+ * memory and malicious device can exploit this to perform a DMA attack.
+ * Use bounce pages for the buffer which doesn't fill whole IOMMU pages.
+ */
+
+static inline size_t
+get_aligned_size(struct iommu_domain *domain, dma_addr_t addr, size_t size)
+{
+	unsigned long page_size = 1 << __ffs(domain->pgsize_bitmap);
+	unsigned long offset = page_size - 1;
+
+	return ALIGN((addr & offset) + size, page_size);
+}
+
+dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
+			    phys_addr_t paddr, size_t size,
+			    enum dma_data_direction dir,
+			    unsigned long attrs)
+{
+	struct iommu_domain *domain;
+	unsigned int min_pagesz;
+	phys_addr_t tlb_addr;
+	size_t aligned_size;
+	int prot = 0;
+	int ret;
+
+	domain = iommu_get_dma_domain(dev);
+	if (!domain)
+		return DMA_MAPPING_ERROR;
+
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= IOMMU_READ;
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= IOMMU_WRITE;
+
+	aligned_size = get_aligned_size(domain, paddr, size);
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+
+	/*
+	 * If both the physical buffer start address and size are
+	 * page aligned, we don't need to use a bounce page.
+	 */
+	if (!IS_ALIGNED(paddr | size, min_pagesz)) {
+		tlb_addr = swiotlb_tbl_map_single(dev,
+				__phys_to_dma(dev, io_tlb_start),
+				paddr, size, aligned_size, dir, attrs);
+		if (tlb_addr == DMA_MAPPING_ERROR)
+			return DMA_MAPPING_ERROR;
+	} else {
+		tlb_addr = paddr;
+	}
+
+	ret = iommu_map(domain, iova, tlb_addr, aligned_size, prot);
+	if (ret) {
+		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
+					 aligned_size, dir, attrs);
+		return DMA_MAPPING_ERROR;
+	}
+
+	return iova;
+}
+EXPORT_SYMBOL_GPL(iommu_bounce_map);
+
+static inline phys_addr_t
+iova_to_tlb_addr(struct iommu_domain *domain, dma_addr_t addr)
+{
+	if (unlikely(!domain->ops || !domain->ops->iova_to_phys))
+		return 0;
+
+	return domain->ops->iova_to_phys(domain, addr);
+}
+
+void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t size,
+			enum dma_data_direction dir, unsigned long attrs)
+{
+	struct iommu_domain *domain;
+	phys_addr_t tlb_addr;
+	size_t aligned_size;
+
+	domain = iommu_get_dma_domain(dev);
+	if (WARN_ON(!domain))
+		return;
+
+	aligned_size = get_aligned_size(domain, iova, size);
+	tlb_addr = iova_to_tlb_addr(domain, iova);
+	if (WARN_ON(!tlb_addr))
+		return;
+
+	iommu_unmap(domain, iova, aligned_size);
+	if (is_swiotlb_buffer(tlb_addr))
+		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
+					 aligned_size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(iommu_bounce_unmap);
+
+void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t size,
+		       enum dma_data_direction dir, enum dma_sync_target target)
+{
+	struct iommu_domain *domain;
+	phys_addr_t tlb_addr;
+
+	domain = iommu_get_dma_domain(dev);
+	if (WARN_ON(!domain))
+		return;
+
+	tlb_addr = iova_to_tlb_addr(domain, addr);
+	if (is_swiotlb_buffer(tlb_addr))
+		swiotlb_tbl_sync_single(dev, tlb_addr, size, dir, target);
+}
+EXPORT_SYMBOL_GPL(iommu_bounce_sync);
+#endif /* CONFIG_IOMMU_BOUNCE_PAGE */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 91af22a344e2..814c0da64692 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -25,6 +25,8 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/swiotlb.h>
+#include <linux/dma-direct.h>
 
 #define IOMMU_READ	(1 << 0)
 #define IOMMU_WRITE	(1 << 1)
@@ -499,6 +501,39 @@ int iommu_sva_set_ops(struct iommu_sva *handle,
 		      const struct iommu_sva_ops *ops);
 int iommu_sva_get_pasid(struct iommu_sva *handle);
 
+#ifdef CONFIG_IOMMU_BOUNCE_PAGE
+dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
+			    phys_addr_t paddr, size_t size,
+			    enum dma_data_direction dir,
+			    unsigned long attrs);
+void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t size,
+			enum dma_data_direction dir, unsigned long attrs);
+void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t size,
+		       enum dma_data_direction dir,
+		       enum dma_sync_target target);
+#else
+static inline
+dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
+			    phys_addr_t paddr, size_t size,
+			    enum dma_data_direction dir,
+			    unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+
+static inline
+void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t size,
+			enum dma_data_direction dir, unsigned long attrs)
+{
+}
+
+static inline
+void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t size,
+		       enum dma_data_direction dir, enum dma_sync_target target)
+{
+}
+#endif /* CONFIG_IOMMU_BOUNCE_PAGE */
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
-- 
2.17.1

