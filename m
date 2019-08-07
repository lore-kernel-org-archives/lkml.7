Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CFBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D81021E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gF6SOcWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbfHGNcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:32:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388624AbfHGNcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bB2BoBz2SztssCwc5liN8vSPUysLmfAwIQzmjRfhZXs=; b=gF6SOcWklxXa2qXqCEmBp7c1gy
        QSimZwvqRq3xZQyN6rqMhEO1cXhkeEv9GLCTC3h8y86G7SAoZb2Elm/kCMcu3nRW8ywt9GfjIDbiD
        C6MpUFSuHNpy8H80HvMxYL8G70mFJbyti9TQDUaN750SgPV2IqxGSRq+YRZz9B6jJaSIcT3nxS5/M
        I0sED2by9rxuikdyXCagau6kunZ1BlCdVdd4jobxZobiZRpcQ/5dX/B+HEQCp4gqAxH//pRjkYpF7
        EyFSNV1G9P9PZxJ0qbcTu+hizNUvWPg9cBVgQ5Z00LSKlaLatV9yo3xhdEswRTIQaaNFMIny3imbk
        OkkNc+1w==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvM35-0008F7-WF; Wed, 07 Aug 2019 13:32:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/29] ia64: remove CONFIG_SWIOTLB ifdefs
Date:   Wed,  7 Aug 2019 16:30:47 +0300
Message-Id: <20190807133049.20893-28-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807133049.20893-1-hch@lst.de>
References: <20190807133049.20893-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SWIOTLB is now unconditionally selected on ia64, so remove the
ifdefs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/dma-mapping.c | 2 --
 arch/ia64/mm/init.c            | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/ia64/kernel/dma-mapping.c b/arch/ia64/kernel/dma-mapping.c
index 53aaa8597920..4a3262795890 100644
--- a/arch/ia64/kernel/dma-mapping.c
+++ b/arch/ia64/kernel/dma-mapping.c
@@ -8,7 +8,6 @@ int iommu_detected __read_mostly;
 const struct dma_map_ops *dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
-#ifdef CONFIG_SWIOTLB
 void *arch_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
@@ -26,4 +25,3 @@ long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
 {
 	return page_to_pfn(virt_to_page(cpu_addr));
 }
-#endif
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index f351dec62ca5..f6928637298e 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -68,7 +68,6 @@ __ia64_sync_icache_dcache (pte_t pte)
 	set_bit(PG_arch_1, &page->flags);	/* mark page as clean */
 }
 
-#ifdef CONFIG_SWIOTLB
 /*
  * Since DMA is i-cache coherent, any (complete) pages that were written via
  * DMA can be marked as "clean" so that lazy_mmu_prot_update() doesn't have to
@@ -83,7 +82,6 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		set_bit(PG_arch_1, &pfn_to_page(pfn)->flags);
 	} while (++pfn <= PHYS_PFN(paddr + size - 1));
 }
-#endif
 
 inline void
 ia64_set_rbs_bot (void)
-- 
2.20.1

