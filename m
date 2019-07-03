Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BAEC06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6819521852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BlA5dAkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfGCSpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:45:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfGCSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R2IKJDEoBTtrdnvArsNvIg0bEouxs/Ep6eg9PGhct3U=; b=BlA5dAkfa9XMUD9jvGrc0232RZ
        iZAb/Solva5+7b6CeewDjYUi3nVNSc3Y5Vj+XgHfbDmlC0iu05TXVzvkPsP2zIAARSyEp/3hcr1jO
        sNbbIMUpAz7/1ee7T2ZFVL4l5/eeWDXxjn9SrSVxsrHm60pXcTj7Miq1xEyTOj5CkGTSwt9XJgdVd
        9x90lGMU+wCDPzSCMRCB/Bfo9rxv07Aj4hz7ZCfkUdcS/DPpHVLrEfXievanIbqVwcRF70IRpMb2D
        0Ocnxbgl710VUzNX3BNPFhddrHQVm9BDJ7VLcSx7rzf8TH2hoWntc7qJQxEL8IvzBO/8OxF7NRiNA
        87ZsaxZw==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hikFb-0007Bw-7r; Wed, 03 Jul 2019 18:45:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 1/5] mm: return valid info from hmm_range_unregister
Date:   Wed,  3 Jul 2019 11:44:58 -0700
Message-Id: <20190703184502.16234-2-hch@lst.de>
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

Checking range->valid is trivial and has no meaningful cost, but
nicely simplifies the fastpath in typical callers.  Also remove the
hmm_vma_range_done function, which now is a trivial wrapper around
hmm_range_unregister.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |  2 +-
 include/linux/hmm.h                   | 11 +----------
 mm/hmm.c                              |  7 ++++++-
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 8c92374afcf2..9d40114d7949 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -652,7 +652,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		ret = hmm_vma_fault(&svmm->mirror, &range, true);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
-			if (!hmm_vma_range_done(&range)) {
+			if (!hmm_range_unregister(&range)) {
 				mutex_unlock(&svmm->mutex);
 				goto again;
 			}
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index b8a08b2a10ca..6b55e59fd8e3 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -462,7 +462,7 @@ int hmm_range_register(struct hmm_range *range,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift);
-void hmm_range_unregister(struct hmm_range *range);
+bool hmm_range_unregister(struct hmm_range *range);
 long hmm_range_snapshot(struct hmm_range *range);
 long hmm_range_fault(struct hmm_range *range, bool block);
 long hmm_range_dma_map(struct hmm_range *range,
@@ -484,15 +484,6 @@ long hmm_range_dma_unmap(struct hmm_range *range,
  */
 #define HMM_RANGE_DEFAULT_TIMEOUT 1000
 
-/* This is a temporary helper to avoid merge conflict between trees. */
-static inline bool hmm_vma_range_done(struct hmm_range *range)
-{
-	bool ret = hmm_range_valid(range);
-
-	hmm_range_unregister(range);
-	return ret;
-}
-
 /* This is a temporary helper to avoid merge conflict between trees. */
 static inline int hmm_vma_fault(struct hmm_mirror *mirror,
 				struct hmm_range *range, bool block)
diff --git a/mm/hmm.c b/mm/hmm.c
index d48b9283725a..ac238d3f1f4e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -917,11 +917,15 @@ EXPORT_SYMBOL(hmm_range_register);
  *
  * Range struct is used to track updates to the CPU page table after a call to
  * hmm_range_register(). See include/linux/hmm.h for how to use it.
+ *
+ * Return:	%true if the range was still valid at the time of unregistering,
+ *		else %false.
  */
-void hmm_range_unregister(struct hmm_range *range)
+bool hmm_range_unregister(struct hmm_range *range)
 {
 	struct hmm *hmm = range->hmm;
 	unsigned long flags;
+	bool ret = range->valid;
 
 	spin_lock_irqsave(&hmm->ranges_lock, flags);
 	list_del_init(&range->list);
@@ -938,6 +942,7 @@ void hmm_range_unregister(struct hmm_range *range)
 	 */
 	range->valid = false;
 	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
+	return ret;
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
-- 
2.20.1

