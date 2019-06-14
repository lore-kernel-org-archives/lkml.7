Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D65C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A031D2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jMCi+UGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfFNOo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:44:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfFNOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FikfEnli7xC3lWxMo+lrSP8bukYq9kMRpBEiMtrt4/8=; b=jMCi+UGNulu+sLWA3p7lmnVzIu
        8tg1b4N89gHYYqIp7VN1qjjGT1kdHaoXPo9PFciOiveCQKhbEZ0HwwLdHN/lfh8BsC2KDllTyxWVt
        /WBG8sXigMo3SZb6jMSGAul5g1Rtpxf58hNKCxmDLHTap+JOkoMX8CX5U46kQp818Yc7zxT449bvt
        WPetfy9Mvq5j0wl+sIaUvALnCf9h5pWCEh4fVtPmAtdzLFlAa981kSK7S2iOBnEkLI2mxdP+kuege
        d37W3Oqew9mcoHxcxKMWWbymrqJWuTGGPk13ipyllLMxtA7t++cJWoHEQXa/NoOE24CeA9wQZH1ia
        eSBCHtOg==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbnRb-0005pn-PS; Fri, 14 Jun 2019 14:44:44 +0000
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
Subject: [PATCH 2/7] arc: remove the partial DMA_ATTR_NON_CONSISTENT support
Date:   Fri, 14 Jun 2019 16:44:26 +0200
Message-Id: <20190614144431.21760-3-hch@lst.de>
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

The arc DMA code supports DMA_ATTR_NON_CONSISTENT allocations, but does
not provide a cache_sync operation.  This means any user of it will
never be able to actually transfer cache ownership and thus cause
coherency bugs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/mm/dma.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 1525ac00fd02..9832928f896d 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -24,7 +24,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	struct page *page;
 	phys_addr_t paddr;
 	void *kvaddr;
-	bool need_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
 
 	/*
 	 * __GFP_HIGHMEM flag is cleared by upper layer functions
@@ -46,14 +45,10 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * A coherent buffer needs MMU mapping to enforce non-cachability.
 	 * kvaddr is kernel Virtual address (0x7000_0000 based).
 	 */
-	if (need_coh) {
-		kvaddr = ioremap_nocache(paddr, size);
-		if (kvaddr == NULL) {
-			__free_pages(page, order);
-			return NULL;
-		}
-	} else {
-		kvaddr = (void *)(u32)paddr;
+	kvaddr = ioremap_nocache(paddr, size);
+	if (kvaddr == NULL) {
+		__free_pages(page, order);
+		return NULL;
 	}
 
 	/*
@@ -66,9 +61,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * Currently flush_cache_vmap nukes the L1 cache completely which
 	 * will be optimized as a separate commit
 	 */
-	if (need_coh)
-		dma_cache_wback_inv(paddr, size);
-
+	dma_cache_wback_inv(paddr, size);
 	return kvaddr;
 }
 
@@ -78,9 +71,7 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	phys_addr_t paddr = dma_handle;
 	struct page *page = virt_to_page(paddr);
 
-	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
-		iounmap((void __force __iomem *)vaddr);
-
+	iounmap((void __force __iomem *)vaddr);
 	__free_pages(page, get_order(size));
 }
 
-- 
2.20.1

