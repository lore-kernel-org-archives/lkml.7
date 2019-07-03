Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A70C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220FF218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QkYiGjbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfGCWCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:02:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfGCWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TH7ilSpN+2j82AKqVSfBr/e3/+W2L5xJvYOO3yTY4Is=; b=QkYiGjbMBjTGLVROOh+GRbmRJb
        MyoPGFJE+6teMNn9c5SEVHNaLJh/dDNSFYCEY+IvBJKEGW9ohDBcsp6CVPN0VrZ0J7fDngCYsPSv4
        CTcFISy34r27v4v0H03+M4tT46hjxR7FS9ebz/zaYpADue3mFBLXKkQiySiYo0OXMfYuIEZSyIeYM
        BCuxayLeVqoTiSZtVLEC80SQUqJFqA/SAdaH6UO6w3Q1gsl//cwPUe6JlfqruSzJ+jjOQ7dz9kSgZ
        fn9KEBBzwR+rePovn050pvLCHNfewpmtkFC8H0ZPqp/ZOMDz4QtUvPdjcKRyVJo7D+Wq8Gx7oUV5c
        ydw5RV1w==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hinKS-0004Eh-Da; Wed, 03 Jul 2019 22:02:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] nouveau: unlock mmap_sem on all errors from nouveau_range_fault
Date:   Wed,  3 Jul 2019 15:02:12 -0700
Message-Id: <20190703220214.28319-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703220214.28319-1-hch@lst.de>
References: <20190703220214.28319-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently nouveau_svm_fault expects nouveau_range_fault to never unlock
mmap_sem, but the latter unlocks it for a random selection of error
codes. Fix this up by always unlocking mmap_sem for non-zero return
values in nouveau_range_fault, and only unlocking it in the caller
for successful returns.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 9a9f71e4be29..d97d862e8b7d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -501,8 +501,10 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 	ret = hmm_range_register(range, mirror,
 				 range->start, range->end,
 				 PAGE_SHIFT);
-	if (ret)
+	if (ret) {
+		up_read(&range->vma->vm_mm->mmap_sem);
 		return (int)ret;
+	}
 
 	if (!hmm_range_wait_until_valid(range, NOUVEAU_RANGE_FAULT_TIMEOUT)) {
 		up_read(&range->vma->vm_mm->mmap_sem);
@@ -511,11 +513,9 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 
 	ret = hmm_range_fault(range, true);
 	if (ret <= 0) {
-		if (ret == -EBUSY || !ret) {
-			up_read(&range->vma->vm_mm->mmap_sem);
-			ret = -EBUSY;
-		} else if (ret == -EAGAIN)
+		if (ret == 0)
 			ret = -EBUSY;
+		up_read(&range->vma->vm_mm->mmap_sem);
 		hmm_range_unregister(range);
 		return ret;
 	}
@@ -713,8 +713,8 @@ nouveau_svm_fault(struct nvif_notify *notify)
 						NULL);
 			svmm->vmm->vmm.object.client->super = false;
 			mutex_unlock(&svmm->mutex);
+			up_read(&svmm->mm->mmap_sem);
 		}
-		up_read(&svmm->mm->mmap_sem);
 
 		/* Cancel any faults in the window whose pages didn't manage
 		 * to keep their valid bit, or stay writeable when required.
-- 
2.20.1

