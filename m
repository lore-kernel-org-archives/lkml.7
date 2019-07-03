Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572B5C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0DF218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 22:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OpDvh8ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfGCWCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 18:02:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGCWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aR5JFpbAtZwK/e60Yd9Huxe2JebEBXUD/VqFe6j363c=; b=OpDvh8ugx9CCqIn6z/3y1udmC9
        KVHOJ4bsImzFgtZfExFnufvlaVFq0giHc/vuAIxKY0IiLV8hawN4olAqJfcL1gDdEfW57uyU5nj5l
        x3GGSB43dDPINYm/NEWoe96PFuvG+2P/z1Fr7axSCD8q98G6fn0/H5jngAe4xoO/Hqe9fnlPDrQYK
        maGsjZPeEo6lxfX+g7EBD2wrEI05R7gGH9G0i/0CFtnM1uTTiOFnW1vZT+aE3Q3gNb/qwMOnPVVa+
        tpRen6TJqloiQxgbHEfAFv64GJOvH3Z05gcv5LDRyQ7BCWPwdBTu1oVT9mXca+ZqiZNiHRN1JiAaF
        aEarK4YQ==;
Received: from rap-us.hgst.com ([199.255.44.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hinKS-0004Ec-6y; Wed, 03 Jul 2019 22:02:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] nouveau: remove the block parameter to nouveau_range_fault
Date:   Wed,  3 Jul 2019 15:02:11 -0700
Message-Id: <20190703220214.28319-4-hch@lst.de>
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

The parameter is always false, so remove it as well as the -EAGAIN
handling that can only happen for the non-blocking case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 033a9241a14a..9a9f71e4be29 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -491,8 +491,7 @@ static inline bool nouveau_range_done(struct hmm_range *range)
 }
 
 static int
-nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
-		    bool block)
+nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range)
 {
 	long ret;
 
@@ -510,7 +509,7 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct hmm_range *range,
 		return -EAGAIN;
 	}
 
-	ret = hmm_range_fault(range, block);
+	ret = hmm_range_fault(range, true);
 	if (ret <= 0) {
 		if (ret == -EBUSY || !ret) {
 			up_read(&range->vma->vm_mm->mmap_sem);
@@ -697,7 +696,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 		range.values = nouveau_svm_pfn_values;
 		range.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT;
 again:
-		ret = nouveau_range_fault(&svmm->mirror, &range, true);
+		ret = nouveau_range_fault(&svmm->mirror, &range);
 		if (ret == 0) {
 			mutex_lock(&svmm->mutex);
 			if (!nouveau_range_done(&range)) {
-- 
2.20.1

