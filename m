Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2661C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEC52173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCSSgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:36:08 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46444 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfCSSgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:36:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TN96ovN_1553020556;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TN96ovN_1553020556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Mar 2019 02:36:05 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     chrubis@suse.cz, vbabka@suse.cz, kirill@shutemov.name,
        osalvador@suse.de, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified
Date:   Wed, 20 Mar 2019 02:35:56 +0800
Message-Id: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MPOL_MF_STRICT was specified and an existing page was already
on a node that does not follow the policy, mbind() should return -EIO.
But commit 6f4576e3687b ("mempolicy: apply page table walker on
queue_pages_range()") broke the rule.

And, commit c8633798497c ("mm: mempolicy: mbind and migrate_pages
support thp migration") didn't return the correct value for THP mbind()
too.

If MPOL_MF_STRICT is set, ignore vma_migratable() to make sure it reaches
queue_pages_to_pte_range() or queue_pages_pmd() to check if an existing
page was already on a node that does not follow the policy.  And,
non-migratable vma may be used, return -EIO too if MPOL_MF_MOVE or
MPOL_MF_MOVE_ALL was specified.

Tested with https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c

Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
Reported-by: Cyril Hrubis <chrubis@suse.cz>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: stable@vger.kernel.org
Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/mempolicy.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index abe7a67..401c817 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -447,6 +447,13 @@ static inline bool queue_pages_required(struct page *page,
 	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
 }
 
+/*
+ * The queue_pages_pmd() may have three kind of return value.
+ * 1 - pages are placed on he right node or queued successfully.
+ * 0 - THP get split.
+ * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
+ *        page was already on a node that does not follow the policy.
+ */
 static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
 {
@@ -456,7 +463,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	unsigned long flags;
 
 	if (unlikely(is_pmd_migration_entry(*pmd))) {
-		ret = 1;
+		ret = -EIO;
 		goto unlock;
 	}
 	page = pmd_page(*pmd);
@@ -473,8 +480,15 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	ret = 1;
 	flags = qp->flags;
 	/* go to thp migration */
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+		if (!vma_migratable(walk->vma)) {
+			ret = -EIO;
+			goto unlock;
+		}
+
 		migrate_page_add(page, qp->pagelist, flags);
+	} else
+		ret = -EIO;
 unlock:
 	spin_unlock(ptl);
 out:
@@ -499,8 +513,10 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
-		if (ret)
+		if (ret > 0)
 			return 0;
+		else if (ret < 0)
+			return ret;
 	}
 
 	if (pmd_trans_unstable(pmd))
@@ -521,11 +537,16 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 		if (!queue_pages_required(page, qp))
 			continue;
-		migrate_page_add(page, qp->pagelist, flags);
+		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
+			if (!vma_migratable(vma))
+				break;
+			migrate_page_add(page, qp->pagelist, flags);
+		} else
+			break;
 	}
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
-	return 0;
+	return addr != end ? -EIO : 0;
 }
 
 static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
@@ -595,7 +616,12 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 	unsigned long endvma = vma->vm_end;
 	unsigned long flags = qp->flags;
 
-	if (!vma_migratable(vma))
+	/*
+	 * Need check MPOL_MF_STRICT to return -EIO if possible
+	 * regardless of vma_migratable
+	 */ 
+	if (!vma_migratable(vma) &&
+	    !(flags & MPOL_MF_STRICT))
 		return 1;
 
 	if (endvma > end)
@@ -622,7 +648,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 	}
 
 	/* queue pages from current vma */
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+	if (flags & MPOL_MF_VALID)
 		return 0;
 	return 1;
 }
-- 
1.8.3.1

