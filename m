Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833C5C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0FB218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifXnrPew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGCSpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:45:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfGCSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UhdzfqB+ekXr0a76nTnfNFoskUSEXQtkHxxjYnKYjTY=; b=ifXnrPewbD1CglQLGyI4uxM4Bi
        RiD7ef8pTvkaeGMgCXwRB+w7xVgKJnhfkX+crTc4HemDtKC8PGY0IVIqIxKmUFAqHhXGSGoZ/2yek
        rVrVS3JUBKDNluj42cUIdoTxc+MabgCeNPn0FMXxdaQ80U8nDF3epvxhGyQh/BPnY/NrZkwfSNH3b
        SnwTZKxskOMoXVJUq+f0cFgpuylPWmdgEEQVVbdJ2TI5WeVczYMfh0+okClGrDruR9zvWCrK+NaJV
        cBUlIPRXdxbHtCWgA4WUnvt6l3b1E60wpr03FAneVP1Z97WBVpUVfKV0X+ANJl8KMJ8Q3ueBwXlWe
        I3UevQmw==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hikFb-0007FI-Kp; Wed, 03 Jul 2019 18:45:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 3/5] mm: move hmm_vma_fault to nouveau
Date:   Wed,  3 Jul 2019 11:45:00 -0700
Message-Id: <20190703184502.16234-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703184502.16234-1-hch@lst.de>
References: <20190703184502.16234-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hmm_vma_fault is marked as a legacy API to get rid of, but seems to suit
the current nouveau flow.  Move it to the only user in preparation for
fixing a locking bug involving caller and callee.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 54 ++++++++++++++++++++++++++-
 include/linux/hmm.h                   | 54 ---------------------------
 2 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 9d40114d7949..e831f4184a17 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -36,6 +36,13 @@
 #include <linux/sort.h>
 #include <linux/hmm.h>
 
+/*
+ * When waiting for mmu notifiers we need some kind of time out otherwise we
+ * could potentialy wait for ever, 1000ms ie 1s sounds like a long time to
+ * wait already.
+ */
+#define NOUVEAU_RANGE_FAULT_TIMEOUT 1000
+
 struct nouveau_svm {
 	struct nouveau_drm *drm;
 	struct mutex mutex;
@@ -475,6 +482,51 @@ nouveau_svm_fault_cache(struct nouveau_svm *svm,
 		fault->inst, fault->addr, fault->access);
 }
 
+static int
+nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
+		    bool block)
+{
+	long ret;
+
+	/*
+	 * With the old API the driver must set each individual entries with
+	 * the requested flags (valid, write, ...). So here we set the mask to
+	 * keep intact the entries provided by the driver and zero out the
+	 * default_flags.
+	 */
+	range->default_flags = 0;
+	range->pfn_flags_mask = -1UL;
+
+	ret = hmm_range_register(range, mirror,
+				 range->start, range->end,
+				 PAGE_SHIFT);
+	if (ret)
+		return (int)ret;
+
+	if (!hmm_range_wait_until_valid(range, NOUVEAU_RANGE_FAULT_TIMEOUT)) {
+		/*
+		 * The mmap_sem was taken by driver we release it here and
+		 * returns -EAGAIN which correspond to mmap_sem have been
+		 * drop in the old API.
+		 */
+		up_read(&range->vma->vm_mm->mmap_sem);
+		return -EAGAIN;
+	}
+
+	ret = hmm_range_fault(range, block);
+	if (ret <= 0) {
+		if (ret == -EBUSY || !ret) {
+			/* Same as above, drop mmap_sem to match old API. */
+			up_read(&range->vma->vm_mm->mmap_sem);
+			ret = -EBUSY;
+		} else if (ret == -EAGAIN)
+			ret = -EBUSY;
+		hmm_range_unregister(range);
+		return ret;
+	}
+	return 0;
+}
+
 static int
 nouveau_svm_fault(struct nvif_notify *notify)
 {
@@ -649,7 +701,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		range.values = nouveau_svm_pfn_values;
 		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
 again:
-		ret = hmm_vma_fault(&svmm->mirror, &range, true);
+		ret = nouveau_range_fault(&svmm->mirror, &range, true);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
 			if (!hmm_range_unregister(&range)) {
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 6b55e59fd8e3..657606f48796 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -475,60 +475,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 			 dma_addr_t *daddrs,
 			 bool dirty);
 
-/*
- * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
- *
- * When waiting for mmu notifiers we need some kind of time out otherwise we
- * could potentialy wait for ever, 1000ms ie 1s sounds like a long time to
- * wait already.
- */
-#define HMM_RANGE_DEFAULT_TIMEOUT 1000
-
-/* This is a temporary helper to avoid merge conflict between trees. */
-static inline int hmm_vma_fault(struct hmm_mirror *mirror,
-				struct hmm_range *range, bool block)
-{
-	long ret;
-
-	/*
-	 * With the old API the driver must set each individual entries with
-	 * the requested flags (valid, write, ...). So here we set the mask to
-	 * keep intact the entries provided by the driver and zero out the
-	 * default_flags.
-	 */
-	range->default_flags = 0;
-	range->pfn_flags_mask = -1UL;
-
-	ret = hmm_range_register(range, mirror,
-				 range->start, range->end,
-				 PAGE_SHIFT);
-	if (ret)
-		return (int)ret;
-
-	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
-		/*
-		 * The mmap_sem was taken by driver we release it here and
-		 * returns -EAGAIN which correspond to mmap_sem have been
-		 * drop in the old API.
-		 */
-		up_read(&range->vma->vm_mm->mmap_sem);
-		return -EAGAIN;
-	}
-
-	ret = hmm_range_fault(range, block);
-	if (ret <= 0) {
-		if (ret == -EBUSY || !ret) {
-			/* Same as above, drop mmap_sem to match old API. */
-			up_read(&range->vma->vm_mm->mmap_sem);
-			ret = -EBUSY;
-		} else if (ret == -EAGAIN)
-			ret = -EBUSY;
-		hmm_range_unregister(range);
-		return ret;
-	}
-	return 0;
-}
-
 /* Below are for HMM internal use only! Not to be used by device driver! */
 static inline void hmm_mm_init(struct mm_struct *mm)
 {
-- 
2.20.1

