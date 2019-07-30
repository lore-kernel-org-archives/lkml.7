Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D7CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B87B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uq+lPiYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfG3Fwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:52:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfG3Fwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lQ9XWeQmmP2B/eiMeXgVV4uJBU5pKgmRyH+iL8uHSEM=; b=uq+lPiYKi3jyFWYRyJc2ZqGofZ
        AfLm7DwXmu4JT8EzoT14gmQsntskqRtuY8G1cnrd/LGbf8XPIjVfgOc8bb9ap9X0V7joXGNksytRi
        zALM22SNoQasN3BLoeBFR/vvCHaXwDoi9ZRyvE3+UeWsboS9MGuTqQ9l97jIiVzC7JdWxUgbDi94Y
        SNudo9geEIfISGK8/w858hjF3tJ5AFspbRUlnzqRM0O4lBbRAx36X7p2UDsP9spKDQweK0rlIxERO
        kDjVa7wlLGqVNCj2hmZofEs7SfZ+60OPJU4FjcxlQ7UvktaV6516z56wix5W6aeIElxYkE9PQKl+5
        u8tqsQjg==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsL3u-0001K2-4x; Tue, 30 Jul 2019 05:52:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] mm: remove the mask variable in hmm_vma_walk_hugetlb_entry
Date:   Tue, 30 Jul 2019 08:51:58 +0300
Message-Id: <20190730055203.28467-9-hch@lst.de>
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

The pagewalk code already passes the value as the hmask parameter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index f26d6abc4ed2..88b77a4a6a1e 100644
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
+	pfn = pte_pfn(entry) + ((start & hmask) >> PAGE_SHIFT);
 	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
 		range->pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				 cpu_flags;
-- 
2.20.1

