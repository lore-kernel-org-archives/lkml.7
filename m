Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEBBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD6720C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qZW70f9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbfHFQGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:06:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387640AbfHFQGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mqfjTQaTTQFNSro/hN6gkYpjLV3E2bwnPvulWJTlCQk=; b=qZW70f9CDkLcMchhuvgQXFX1hB
        gk0dQRjjzMNkOXpQ1vj/+CZf+DGdkKL4wy9lfG80WezxLzvgoBIi65VwKPxRO7XZvSGu4lkfJvtpO
        YLB+2QpTOftupd6T5+u5wIWRCdr7UNLJV9pI2yGFI17FzFotQ9rc45MMEuT6B4ZuXTSOCdG8lIElC
        zh1luwoZ5mTRukbW+Ku/WPNKTQRqYa226GtVA3dqqlnKiykhAF/jkll9ZPoFo+gRfPjqymMQitRIQ
        EbyGZEvR37jYfqmSXzrxeXNhYxuKZ/JVcMkmWceWLyjt1pnZa/P8rF90JPLdFdMkz1Y9M89sHhy44
        fGQB1PQQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1yV-0000Ys-M1; Tue, 06 Aug 2019 16:06:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] mm: remove superflous arguments from hmm_range_register
Date:   Tue,  6 Aug 2019 19:05:44 +0300
Message-Id: <20190806160554.14046-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The start, end and page_shift values are all saved in the range
structure, so we might as well use that for argument passing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 Documentation/vm/hmm.rst                |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  7 +++++--
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  5 ++---
 include/linux/hmm.h                     |  6 +-----
 mm/hmm.c                                | 20 +++++---------------
 5 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index ddcb5ca8b296..e63c11f7e0e0 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -222,7 +222,7 @@ The usage pattern is::
       range.flags = ...;
       range.values = ...;
       range.pfn_shift = ...;
-      hmm_range_register(&range);
+      hmm_range_register(&range, mirror);
 
       /*
        * Just wait for range to be valid, safe to ignore return value as we
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f0821638bbc6..71d6e7087b0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -818,8 +818,11 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 				0 : range->flags[HMM_PFN_WRITE];
 	range->pfn_flags_mask = 0;
 	range->pfns = pfns;
-	hmm_range_register(range, mirror, start,
-			   start + ttm->num_pages * PAGE_SIZE, PAGE_SHIFT);
+	range->page_shift = PAGE_SHIFT;
+	range->start = start;
+	range->end = start + ttm->num_pages * PAGE_SIZE;
+
+	hmm_range_register(range, mirror);
 
 	/*
 	 * Just wait for range to be valid, safe to ignore return value as we
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 98072fd48cf7..41fad4719ac6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -492,9 +492,7 @@ nouveau_range_fault(struct nouveau_svmm *svmm, struct hmm_range *range)
 	range->default_flags = 0;
 	range->pfn_flags_mask = -1UL;
 
-	ret = hmm_range_register(range, &svmm->mirror,
-				 range->start, range->end,
-				 PAGE_SHIFT);
+	ret = hmm_range_register(range, &svmm->mirror);
 	if (ret) {
 		up_read(&svmm->mm->mmap_sem);
 		return (int)ret;
@@ -682,6 +680,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			 args.i.p.addr + args.i.p.size, fn - fi);
 
 		/* Have HMM fault pages within the fault window to the GPU. */
+		range.page_shift = PAGE_SHIFT;
 		range.start = args.i.p.addr;
 		range.end = args.i.p.addr + args.i.p.size;
 		range.pfns = args.phys;
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 59be0aa2476d..c5b51376b453 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -400,11 +400,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
-int hmm_range_register(struct hmm_range *range,
-		       struct hmm_mirror *mirror,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned page_shift);
+int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror);
 void hmm_range_unregister(struct hmm_range *range);
 
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 3a3852660757..926735a3aef9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -843,35 +843,25 @@ static void hmm_pfns_clear(struct hmm_range *range,
  * hmm_range_register() - start tracking change to CPU page table over a range
  * @range: range
  * @mm: the mm struct for the range of virtual address
- * @start: start virtual address (inclusive)
- * @end: end virtual address (exclusive)
- * @page_shift: expect page shift for the range
+ *
  * Return: 0 on success, -EFAULT if the address space is no longer valid
  *
  * Track updates to the CPU page table see include/linux/hmm.h
  */
-int hmm_range_register(struct hmm_range *range,
-		       struct hmm_mirror *mirror,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned page_shift)
+int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror)
 {
-	unsigned long mask = ((1UL << page_shift) - 1UL);
+	unsigned long mask = ((1UL << range->page_shift) - 1UL);
 	struct hmm *hmm = mirror->hmm;
 	unsigned long flags;
 
 	range->valid = false;
 	range->hmm = NULL;
 
-	if ((start & mask) || (end & mask))
+	if ((range->start & mask) || (range->end & mask))
 		return -EINVAL;
-	if (start >= end)
+	if (range->start >= range->end)
 		return -EINVAL;
 
-	range->page_shift = page_shift;
-	range->start = start;
-	range->end = end;
-
 	/* Prevent hmm_release() from running while the range is valid */
 	if (!mmget_not_zero(hmm->mm))
 		return -EFAULT;
-- 
2.20.1

