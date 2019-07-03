Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719A6C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A25F218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ikgrok46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfGCUfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:35:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfGCUfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6wVvKVSMYVfCvl9aNHnGnrJdrKBsm+sQjf5j3JbyT50=; b=ikgrok46t5C4CA+xVVHpukMbk
        5sZjuxLMFP9iZsNr8P3Q8NGRw3DGYCe5+w4j9xMHyjfnK/gOdKUu1JwVZL1moxEZzmly4EYpeT83v
        Ui+0EWqSNA3X1rkLJho1Bv77+qi5IDN9JUFNQcoXAytE/1fJCy/9S8CKYf7sysNV7XmhcgAktbVqw
        LZPXi4SSjCbkn2nNHT+UBtEPPJLEtP7xAuD1iBnnqZ7HFUvR5oKYmEmXVecgPAnbpuZ9wNEVdVcBv
        J88vbzRc7jQBoaz4pSWwxv/my8uX7bTzMq5+VbbRPqguph/wMxHgfezntQDtW05F6y2TsMN/8+RbY
        QvhKhTjFQ==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hilyD-0007KJ-BO; Wed, 03 Jul 2019 20:35:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     bskeggs@redhat.com
Cc:     jglisse@redhat.com, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nouveau: remove bogus uses of DMA_ATTR_SKIP_CPU_SYNC
Date:   Wed,  3 Jul 2019 13:35:13 -0700
Message-Id: <20190703203513.22692-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA_ATTR_SKIP_CPU_SYNC should only be used when the driver manually
performs dma cache maintainance operations using the dma_sync_*
calls.  Nouveau doesn't do that, and generally just assumes DMA
is coherent.  Use plain dma_map_page which doesn't make this code
correct but at least a little less wrong and simpler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index b9ced2e61667..a5d9b537cbaf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -186,9 +186,8 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
 		}
 
 		fault->dma[fault->npages] =
-			dma_map_page_attrs(dev, dpage, 0, PAGE_SIZE,
-					   PCI_DMA_BIDIRECTIONAL,
-					   DMA_ATTR_SKIP_CPU_SYNC);
+			dma_map_page(dev, dpage, 0, PAGE_SIZE,
+				     PCI_DMA_BIDIRECTIONAL);
 		if (dma_mapping_error(dev, fault->dma[fault->npages])) {
 			dst_pfns[i] = MIGRATE_PFN_ERROR;
 			__free_page(dpage);
@@ -706,9 +705,8 @@ nouveau_dmem_migrate_alloc_and_copy(struct vm_area_struct *vma,
 		}
 
 		migrate->dma[migrate->dma_nr] =
-			dma_map_page_attrs(dev, spage, 0, PAGE_SIZE,
-					   PCI_DMA_BIDIRECTIONAL,
-					   DMA_ATTR_SKIP_CPU_SYNC);
+			dma_map_page(dev, spage, 0, PAGE_SIZE,
+				     PCI_DMA_BIDIRECTIONAL);
 		if (dma_mapping_error(dev, migrate->dma[migrate->dma_nr])) {
 			nouveau_dmem_page_free_locked(drm, dpage);
 			dst_pfns[i] = 0;
-- 
2.20.1

