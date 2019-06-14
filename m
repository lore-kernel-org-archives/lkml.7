Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1D02133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u7OReZea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfFNOov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:44:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfFNOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PPh+LEJJkGlws2bM8T6WqvI8rRhSUTXZv5KuVG6RfrU=; b=u7OReZeaPTH6LLZqfu0lio/fTq
        Wm5i5uBvEZ7sT7UCF5kStdC/ZqTJrDwkBm+cBz5LQHK3C7+p5kKEUgqqSP5T+CT5v6mjWc813FwqM
        ccfBTNJW7893FHAjQCJWXWbi1qPBnhg5SntdO1Nu4CTxqv9lW2kmCWmBN7zfJrQPHTpHiQUiCFTVV
        l/9GFsIdgxFm3XHS1Tva/g4lI5iEBTVdZV3In5xazHZVxbnkIqX+hF29+x79xgOApQuCZVfdDBjy9
        3zkbZX4/bKtG8xempfi0HSaxIe9PmB9SZF1Yuz/drS2symmous/FFf+Oy3HJ74IDvWe0e2VwCOjhL
        9nLpskow==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbnRY-0005pM-87; Fri, 14 Jun 2019 14:44:40 +0000
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
Subject: [PATCH 1/7] arm-nommu: remove the partial DMA_ATTR_NON_CONSISTENT support
Date:   Fri, 14 Jun 2019 16:44:25 +0200
Message-Id: <20190614144431.21760-2-hch@lst.de>
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

The arm-nommu DMA code supports DMA_ATTR_NON_CONSISTENT allocations, but
does not provide a cache_sync operation.  This means any user of it
will never be able to actually transfer cache ownership and thus cause
coherency bugs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping-nommu.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index f304b10e23a4..bc003df45546 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -39,18 +39,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
 				 unsigned long attrs)
 
 {
-	void *ret;
-
-	/*
-	 * Try generic allocator first if we are advertised that
-	 * consistency is not required.
-	 */
-
-	if (attrs & DMA_ATTR_NON_CONSISTENT)
-		return dma_direct_alloc_pages(dev, size, dma_handle, gfp,
-				attrs);
-
-	ret = dma_alloc_from_global_coherent(size, dma_handle);
+	void *ret = dma_alloc_from_global_coherent(size, dma_handle);
 
 	/*
 	 * dma_alloc_from_global_coherent() may fail because:
@@ -70,16 +59,9 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
 			       void *cpu_addr, dma_addr_t dma_addr,
 			       unsigned long attrs)
 {
-	if (attrs & DMA_ATTR_NON_CONSISTENT) {
-		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
-	} else {
-		int ret = dma_release_from_global_coherent(get_order(size),
-							   cpu_addr);
-
-		WARN_ON_ONCE(ret == 0);
-	}
+	int ret = dma_release_from_global_coherent(get_order(size), cpu_addr);
 
-	return;
+	WARN_ON_ONCE(ret == 0);
 }
 
 static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-- 
2.20.1

