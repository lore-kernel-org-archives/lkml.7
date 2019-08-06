Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39379C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7FB20818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tzhuPYOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbfHFQGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:06:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387570AbfHFQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CFSretyqs/RdirX2o42+13inYYFm9UN8GL7VmbVQVoQ=; b=tzhuPYOZCfgFbsA9DJibfh/0Jh
        woYpb6mEK7ChEy3EQSIGvnXDPse4koxKMp2IVNjgzLQ6T38WsL385CiPX1vHD2Jucbed+H/5Pu4lp
        H/90sdP/K9vSYZY7RNildl5jevquWCkAzhbCbvPIWLnT8ZyEjqMSz1km+VUCFKhynvVxvf7KPyJzg
        9mcmtQVc/phVgwX4EZ1FmOwnOHVrXcWWe9j1QCmpobC8EUhF4daYBvAmBpQimWumDoicwaVczgeco
        1Y8lm/34Pe/d56aQqfFjYbBd3j92PHqKQzIpa9qOWRMFQHFJdLuWEV9jOHRkdM2ZEkyYHq03VPBtC
        QFOhtlvA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv1ya-0000aD-R6; Tue, 06 Aug 2019 16:06:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] mm: remove the mask variable in hmm_vma_walk_hugetlb_entry
Date:   Tue,  6 Aug 2019 19:05:46 +0300
Message-Id: <20190806160554.14046-9-hch@lst.de>
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

The pagewalk code already passes the value as the hmask parameter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index f26d6abc4ed2..03d37e102e3b 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -771,19 +771,16 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				      struct mm_walk *walk)
 {
 #ifdef CONFIG_HUGETLB_PAGE
-	unsigned long addr = start, i, pfn, mask;
+	unsigned long addr = start, i, pfn;
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
-	struct hstate *h = hstate_vma(vma);
 	uint64_t orig_pfn, cpu_flags;
 	bool fault, write_fault;
 	spinlock_t *ptl;
 	pte_t entry;
 	int ret = 0;
 
-	mask = huge_page_size(h) - 1;
-
 	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
 	entry = huge_ptep_get(pte);
 
@@ -799,7 +796,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 		goto unlock;
 	}
 
-	pfn = pte_pfn(entry) + ((start & mask) >> PAGE_SHIFT);
+	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
 	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
 		range->pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				 cpu_flags;
-- 
2.20.1

