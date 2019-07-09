Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB11BC73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39E72080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="geHws4g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGIOUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:20:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o44H8M7DbbA7NlN9PPoFR5oXaofHHIGAJTgHtziCFiI=; b=geHws4g8BNcf56eW7GNKs8CJYZ
        KrqNaxyzClwfi1P4QbMzUC+KG42C1m4EE0oK81KMnFgupMTc/MUoSz0owi69OMhFogbxESRv79Go1
        cKvCnlOE1gnQuX4faHk63Jrerv8PUKnqItIVZILMLskUOoXqq9t+/4gIERdsMxZkE3Gcj+ALCRHMZ
        c74uaZezAb+SHGvznZiOQ65pVD7ansyEGDXq76sWRGVbEkQIqyoDoZvb54KrL+qXODUEYxBIWnK7i
        nzFmZjiIXAu9HRtIUYuTr60939O2wBkD41xV9HAhR9ymkyHnOmP1ZDPRB7xwyitcWN7OnbtMsmfIA
        rljvew+w==;
Received: from [209.244.105.251] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkqya-0001BQ-Bi; Tue, 09 Jul 2019 14:20:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 1/2] dma-mapping check pfn validity in dma_common_{mmap,get_sgtable}
Date:   Tue,  9 Jul 2019 07:20:10 -0700
Message-Id: <20190709142011.24984-2-hch@lst.de>
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

Check that the pfn returned from arch_dma_coherent_to_pfn refers to
a valid page and reject the mmap / get_sgtable requests otherwise.

Based on the arm implementation of the mmap and get_sgtable methods.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/mapping.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 1f628e7ac709..b945239621d8 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -116,11 +116,16 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 	int ret;
 
 	if (!dev_is_dma_coherent(dev)) {
+		unsigned long pfn;
+
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
 			return -ENXIO;
 
-		page = pfn_to_page(arch_dma_coherent_to_pfn(dev, cpu_addr,
-				dma_addr));
+		/* If the PFN is not valid, we do not have a struct page */
+		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
+		if (!pfn_valid(pfn))
+			return -ENXIO;
+		page = pfn_to_page(pfn);
 	} else {
 		page = virt_to_page(cpu_addr);
 	}
@@ -170,7 +175,11 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (!dev_is_dma_coherent(dev)) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
 			return -ENXIO;
+
+		/* If the PFN is not valid, we do not have a struct page */
 		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
+		if (!pfn_valid(pfn))
+			return -ENXIO;
 	} else {
 		pfn = page_to_pfn(virt_to_page(cpu_addr));
 	}
-- 
2.20.1

