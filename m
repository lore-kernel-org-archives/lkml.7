Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E568C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7288220644
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DAL1H9X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfGXGxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:53:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGXGxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OKQjQZNsY1fevItiyMnAbjI1iamy6YdinwRbq9yBGVU=; b=DAL1H9X37yVytHCPB4G34fgHgw
        f4KZFwd9A4d0cKrfI1i7CUJCG840Ln0mEXPdeYL44trM7bHs9qwiHbF3TxxesmvA1fQZMCVdAGThz
        xtwIzl+2xTdBFdk13/H3mgXI4jmkC54OsNOAeU/WscWj8k7rXOcn4o1pVkTc+cVJxW81/EkoywxsA
        mz/Q6TH9iCrd0DdEL67eyjr8RW7uD8RdDPIt7i/GfCybmcD3VJJ7TKRgHPYZeTfjlrdpFVi6sUDnm
        GaJ9+tkhmgc5dIRddICKPRVHZnbLP5QjyZTFXUc1SXOrAo4nsgnuivXn1T4osetkxmYSwdWjkGwox
        SwYGjFuQ==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqB9G-0004Jk-1l; Wed, 24 Jul 2019 06:53:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] nouveau: unlock mmap_sem on all errors from nouveau_range_fault
Date:   Wed, 24 Jul 2019 08:52:55 +0200
Message-Id: <20190724065258.16603-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724065258.16603-1-hch@lst.de>
References: <20190724065258.16603-1-hch@lst.de>
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
 drivers/gpu/drm/nouveau/nouveau_svm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index e3097492b4ad..a835cebb6d90 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -495,8 +495,10 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 	ret = hmm_range_register(range, mirror,
 				 range->start, range->end,
 				 PAGE_SHIFT);
-	if (ret)
+	if (ret) {
+		up_read(&range->vma->vm_mm->mmap_sem);
 		return (int)ret;
+	}
 
 	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
 		up_read(&range->vma->vm_mm->mmap_sem);
@@ -505,10 +507,9 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 
 	ret = hmm_range_fault(range, true);
 	if (ret <= 0) {
-		if (ret == -EBUSY || !ret) {
-			up_read(&range->vma->vm_mm->mmap_sem);
+		if (ret == 0)
 			ret = -EBUSY;
-		}
+		up_read(&range->vma->vm_mm->mmap_sem);
 		hmm_range_unregister(range);
 		return ret;
 	}
@@ -706,8 +707,8 @@ nouveau_svm_fault(struct nvif_notify *notify)
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

