Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A290121655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLTPif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:38:35 -0500
Received: from foss.arm.com ([217.140.110.172]:52590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfLTPif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:38:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E063D30E;
        Fri, 20 Dec 2019 07:38:34 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069513F6CF;
        Fri, 20 Dec 2019 07:38:33 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steven Price <steven.price@arm.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>
Subject: [PATCH] mm/hmm: Cleanup hmm_vma_walk_pud()/walk_pud_range()
Date:   Fri, 20 Dec 2019 15:38:26 +0000
Message-Id: <20191220153826.24229-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of minor misuses of the page table APIs in
hmm_vma_walk_pud():

If the pud_trans_huge_lock() hasn't been obtained it might be because
the PUD is unstable, so we should retry.

If it has been obtained then there's no need for a READ_ONCE, and the
PUD cannot be pud_none() or !pud_present() so these paths are dead code.

Finally in walk_pud_range(), after a call to split_huge_pud() the code
should check pud_trans_unstable() rather than pud_none() to decide
whether the PUD should be retried.

Suggested-by: Thomas Hellström (VMware) <thomas_os@shipmail.org>
Signed-off-by: Steven Price <steven.price@arm.com>
---
This is based on top of my "Generic page walk and ptdump" series and
fixes some pre-existing bugs spotted by Thomas.

 mm/hmm.c      | 16 +++++-----------
 mm/pagewalk.c |  2 +-
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index a71295e99968..d4aae4dcc6e8 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -480,28 +480,22 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 	int ret = 0;
 	spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
 
-	if (!ptl)
+	if (!ptl) {
+		if (pud_trans_unstable(pudp))
+			walk->action = ACTION_AGAIN;
 		return 0;
+	}
 
 	/* Normally we don't want to split the huge page */
 	walk->action = ACTION_CONTINUE;
 
-	pud = READ_ONCE(*pudp);
-	if (pud_none(pud)) {
-		ret = hmm_vma_walk_hole(start, end, -1, walk);
-		goto out_unlock;
-	}
+	pud = *pudp;
 
 	if (pud_huge(pud) && pud_devmap(pud)) {
 		unsigned long i, npages, pfn;
 		uint64_t *pfns, cpu_flags;
 		bool fault, write_fault;
 
-		if (!pud_present(pud)) {
-			ret = hmm_vma_walk_hole(start, end, -1, walk);
-			goto out_unlock;
-		}
-
 		i = (addr - range->start) >> PAGE_SHIFT;
 		npages = (end - addr) >> PAGE_SHIFT;
 		pfns = &range->pfns[i];
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 5895ce4f1a85..4598f545b869 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -154,7 +154,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 
 		if (walk->vma)
 			split_huge_pud(walk->vma, pud, addr);
-		if (pud_none(*pud))
+		if (pud_trans_unstable(pud))
 			goto again;
 
 		err = walk_pmd_range(pud, addr, next, walk);
-- 
2.20.1

