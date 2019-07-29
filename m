Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA5EC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CF92171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UOK0LNoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfG2O3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:29:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG2O3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KRhSWVqqlsL4sNnqiKki+hdwEXJ8VTEYKaUDLbMamPM=; b=UOK0LNoApFOGwvTn+Y/XD3jBnG
        TRfhIqboSv8iqXv6omeWkilEGsmxKwQhoeVgR9UwVkpnbiS/E1ecOTCAqXTao8qWeYkvykFlXFDK/
        Ye5pIUMH+Ium1hxsiHtJ8/DyYvvHVnb673b0Q1ak9Biu2jXuy2gNUEP+jaVRTxUqOUnvjDE6IuKbu
        iEbtj/LsXhOByx+dgF6Sv3TpkO9E88HNVVuMBM12gNDgGZtDbAE9gUqgPsBxGBPNiA/8fP7mpHFRn
        qcYcymO5NouySz7CZywQqyMe/t/hyPLhwBjO/65i84oIlD1Z/999t1DYXQH9Z9WD65qRbBOoShss/
        8doBh/yw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6e9-0006K6-NS; Mon, 29 Jul 2019 14:29:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] nouveau: factor out dmem fence completion
Date:   Mon, 29 Jul 2019 17:28:38 +0300
Message-Id: <20190729142843.22320-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729142843.22320-1-hch@lst.de>
References: <20190729142843.22320-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the end of fencing logic from the two migration routines.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 33 ++++++++++++--------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index d469bc334438..21052a4aaf69 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -133,6 +133,19 @@ static void nouveau_dmem_page_free(struct page *page)
 	spin_unlock(&chunk->lock);
 }
 
+static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
+{
+	if (fence) {
+		nouveau_fence_wait(*fence, true, false);
+		nouveau_fence_unref(fence);
+	} else {
+		/*
+		 * FIXME wait for channel to be IDLE before calling finalizing
+		 * the hmem object.
+		 */
+	}
+}
+
 static void
 nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
 				  const unsigned long *src_pfns,
@@ -236,15 +249,7 @@ nouveau_dmem_fault_finalize_and_map(struct nouveau_dmem_fault *fault)
 {
 	struct nouveau_drm *drm = fault->drm;
 
-	if (fault->fence) {
-		nouveau_fence_wait(fault->fence, true, false);
-		nouveau_fence_unref(&fault->fence);
-	} else {
-		/*
-		 * FIXME wait for channel to be IDLE before calling finalizing
-		 * the hmem object below (nouveau_migrate_hmem_fini()).
-		 */
-	}
+	nouveau_dmem_fence_done(&fault->fence);
 
 	while (fault->npages--) {
 		dma_unmap_page(drm->dev->dev, fault->dma[fault->npages],
@@ -748,15 +753,7 @@ nouveau_dmem_migrate_finalize_and_map(struct nouveau_migrate *migrate)
 {
 	struct nouveau_drm *drm = migrate->drm;
 
-	if (migrate->fence) {
-		nouveau_fence_wait(migrate->fence, true, false);
-		nouveau_fence_unref(&migrate->fence);
-	} else {
-		/*
-		 * FIXME wait for channel to be IDLE before finalizing
-		 * the hmem object below (nouveau_migrate_hmem_fini()) ?
-		 */
-	}
+	nouveau_dmem_fence_done(&migrate->fence);
 
 	while (migrate->dma_nr--) {
 		dma_unmap_page(drm->dev->dev, migrate->dma[migrate->dma_nr],
-- 
2.20.1

