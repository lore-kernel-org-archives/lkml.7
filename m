Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D30C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E1F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ki48yLXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725267AbfG3FwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:52:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfG3FwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wGT0bIW6ZV4QHMeBIyzrsptb3Nkhx6kX9nD5TRsY+c8=; b=ki48yLXEl1xJO9gV+39wOL1+y4
        wZUPYoqzhuNLoAUej9SJNFqjxYoDfeF+zcoWTFIq79SU2dw9V4rtDFH9JYB6dp5qDlHOfUF6g5GUx
        JPpQ+gBYb9/5cNNU1yw5rxdau5EGWyoD1usdNNwqaDiB2NAzGKDv39L59sbM/rDJL0O/c8V8icRLO
        IDGx1Argn4Mazv1HFxn+KxWQbirB8spS5aq6oofxF4YASh2sIDt4wCApTnUblx5u77wLLZLq+Mq8q
        EkU5EF5o8yTZ2SfJUnTVtafXCPfDL7NTm4L9dySd4Nqc3T4K/jP1nQG6ETC9e6EK/1Vr44X4BbE1V
        nstFkRew==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsL3Z-000154-Lg; Tue, 30 Jul 2019 05:52:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] amdgpu: remove -EAGAIN handling for hmm_range_fault
Date:   Tue, 30 Jul 2019 08:51:51 +0300
Message-Id: <20190730055203.28467-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730055203.28467-1-hch@lst.de>
References: <20190730055203.28467-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hmm_range_fault can only return -EAGAIN if called with the block
argument set to false, so remove the special handling for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 12a59ac83f72..f0821638bbc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -778,7 +778,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	struct hmm_range *range;
 	unsigned long i;
 	uint64_t *pfns;
-	int retry = 0;
 	int r = 0;
 
 	if (!mm) /* Happens during process shutdown */
@@ -822,7 +821,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	hmm_range_register(range, mirror, start,
 			   start + ttm->num_pages * PAGE_SIZE, PAGE_SHIFT);
 
-retry:
 	/*
 	 * Just wait for range to be valid, safe to ignore return value as we
 	 * will use the return value of hmm_range_fault() below under the
@@ -831,24 +829,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT);
 
 	down_read(&mm->mmap_sem);
-
 	r = hmm_range_fault(range, 0);
-	if (unlikely(r < 0)) {
-		if (likely(r == -EAGAIN)) {
-			/*
-			 * return -EAGAIN, mmap_sem is dropped
-			 */
-			if (retry++ < MAX_RETRY_HMM_RANGE_FAULT)
-				goto retry;
-			else
-				pr_err("Retry hmm fault too many times\n");
-		}
-
-		goto out_up_read;
-	}
-
 	up_read(&mm->mmap_sem);
 
+	if (unlikely(r < 0))
+		goto out_free_pfns;
+
 	for (i = 0; i < ttm->num_pages; i++) {
 		pages[i] = hmm_device_entry_to_page(range, pfns[i]);
 		if (unlikely(!pages[i])) {
@@ -864,9 +850,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 
 	return 0;
 
-out_up_read:
-	if (likely(r != -EAGAIN))
-		up_read(&mm->mmap_sem);
 out_free_pfns:
 	hmm_range_unregister(range);
 	kvfree(pfns);
-- 
2.20.1

