Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE66C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E255A21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbfKGPHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:07:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:55328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729450AbfKGPHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:07:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84B61B258;
        Thu,  7 Nov 2019 15:07:07 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     rubini@gnudd.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v3 1/2] dma-direct: check for overflows on 32 bit DMA addresses
Date:   Thu,  7 Nov 2019 16:06:44 +0100
Message-Id: <20191107150646.13485-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107150646.13485-1-nsaenzjulienne@suse.de>
References: <20191107150646.13485-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As seen on the new Raspberry Pi 4 and sta2x11's DMA implementation it is
possible for a device configured with 32 bit DMA addresses and a partial
DMA mapping located at the end of the address space to overflow. It
happens when a higher physical address, not DMAable, is translated to
it's DMA counterpart.

For example the Raspberry Pi 4, configurable up to 4 GB of memory, has
an interconnect capable of addressing the lower 1 GB of physical memory
with a DMA offset of 0xc0000000. It transpires that, any attempt to
translate physical addresses higher than the first GB will result in an
overflow which dma_capable() can't detect as it only checks for
addresses bigger then the maximum allowed DMA address.

Fix this by verifying in dma_capable() if the DMA address range provided
is at any point lower than the minimum possible DMA address on the bus.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v2:
  - Cleanup code: use IS_ENABLED, a tmp variable for end, and
    use phys_to_dma().

 include/linux/dma-direct.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index adf993a3bd58..6a18a97b76a8 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -3,8 +3,11 @@
 #define _LINUX_DMA_DIRECT_H 1
 
 #include <linux/dma-mapping.h>
+#include <linux/memblock.h> /* for min_low_pfn */
 #include <linux/mem_encrypt.h>
 
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
+
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
 #else
@@ -24,11 +27,16 @@ static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
+	dma_addr_t end = addr + size - 1;
+
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <=
-		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
+	if (!IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
+	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
+		return false;
+
+	return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
-- 
2.23.0

