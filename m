Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FF3C48BE0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E662075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfFVAU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:20:27 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:43999 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbfFVAU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:20:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TUrY3xA_1561162815;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TUrY3xA_1561162815)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 22 Jun 2019 08:20:22 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/2] mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
Date:   Sat, 22 Jun 2019 08:20:08 +0800
Message-Id: <1561162809-59140-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1561162809-59140-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both MPOL_MF_MOVE* and MPOL_MF_STRICT was specified, mbind() should
try best to migrate misplaced pages, if some of the pages could not be
migrated, then return -EIO.

There are three different sub-cases:
1. vma is not migratable
2. vma is migratable, but there are unmovable pages
3. vma is migratable, pages are movable, but migrate_pages() fails

If #1 happens, kernel would just abort immediately, then return -EIO,
after the commit a7f40cfe3b7ada57af9b62fd28430eeb4a7cfcb7 ("mm:
mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified").

If #3 happens, kernel would set policy and migrate pages with best-effort,
but won't rollback the migrated pages and reset the policy back.

Before that commit, they behaves in the same way.  It'd better to keep
their behavior consistent.  But, rolling back the migrated pages and
resetting the policy back sounds not feasible, so just make #1 behave as
same as #3.

Userspace will know that not everything was successfully migrated (via
-EIO), and can take whatever steps it deems necessary - attempt rollback,
determine which exact page(s) are violating the policy, etc.

Make queue_pages_range() return 1 to indicate there are unmovable pages
or vma is not migratable.

The #2 is not handled correctly in the current kernel, the following
patch will fix it.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/mempolicy.c | 86 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 25 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 01600d8..b50039c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -429,11 +429,14 @@ static inline bool queue_pages_required(struct page *page,
 }
 
 /*
- * queue_pages_pmd() has three possible return values:
+ * queue_pages_pmd() has four possible return values:
+ * 2 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
+ *     specified.
  * 1 - pages are placed on the right node or queued successfully.
  * 0 - THP was split.
- * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
- *        page was already on a node that does not follow the policy.
+ * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
+ *        existing page was already on a node that does not follow the
+ *        policy.
  */
 static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 				unsigned long end, struct mm_walk *walk)
@@ -463,7 +466,7 @@ static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
 	/* go to thp migration */
 	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
 		if (!vma_migratable(walk->vma)) {
-			ret = -EIO;
+			ret = 2;
 			goto unlock;
 		}
 
@@ -488,16 +491,29 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	struct queue_pages *qp = walk->private;
 	unsigned long flags = qp->flags;
 	int ret;
+	bool has_unmovable = false;
 	pte_t *pte;
 	spinlock_t *ptl;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
-		if (ret > 0)
+		switch (ret) {
+		/* THP was split, fall through to pte walk */
+		case 0:
+			break;
+		/* Pages are placed on the right node or queued successfully */
+		case 1:
 			return 0;
-		else if (ret < 0)
+		/*
+		 * Met unmovable pages, MPOL_MF_MOVE* & MPOL_MF_STRICT
+		 * were specified.
+		 */
+		case 2:
+			return 1;
+		case -EIO:
 			return ret;
+		}
 	}
 
 	if (pmd_trans_unstable(pmd))
@@ -519,14 +535,21 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!queue_pages_required(page, qp))
 			continue;
 		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
-			if (!vma_migratable(vma))
+			/* MPOL_MF_STRICT must be specified if we get here */
+			if (!vma_migratable(vma)) {
+				has_unmovable |= true;
 				break;
+			}
 			migrate_page_add(page, qp->pagelist, flags);
 		} else
 			break;
 	}
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
+
+	if (has_unmovable)
+		return 1;
+
 	return addr != end ? -EIO : 0;
 }
 
@@ -639,7 +662,13 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
  *
  * If pages found in a given range are on a set of nodes (determined by
  * @nodes and @flags,) it's isolated and queued to the pagelist which is
- * passed via @private.)
+ * passed via @private.
+ *
+ * queue_pages_range() has three possible return values:
+ * 1 - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
+ *     specified.
+ * 0 - queue pages successfully or no misplaced page.
+ * -EIO - there is misplaced page and only MPOL_MF_STRICT was specified.
  */
 static int
 queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
@@ -1182,6 +1211,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	struct mempolicy *new;
 	unsigned long end;
 	int err;
+	int ret;
 	LIST_HEAD(pagelist);
 
 	if (flags & ~(unsigned long)MPOL_MF_VALID)
@@ -1243,26 +1273,32 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (err)
 		goto mpol_out;
 
-	err = queue_pages_range(mm, start, end, nmask,
+	ret = queue_pages_range(mm, start, end, nmask,
 			  flags | MPOL_MF_INVERT, &pagelist);
-	if (!err)
-		err = mbind_range(mm, start, end, new);
-
-	if (!err) {
-		int nr_failed = 0;
 
-		if (!list_empty(&pagelist)) {
-			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
-			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
-			if (nr_failed)
-				putback_movable_pages(&pagelist);
-		}
+	if (ret < 0)
+		err = -EIO;
+	else {
+		err = mbind_range(mm, start, end, new);
 
-		if (nr_failed && (flags & MPOL_MF_STRICT))
-			err = -EIO;
-	} else
-		putback_movable_pages(&pagelist);
+		if (!err) {
+			int nr_failed = 0;
+
+			if (!list_empty(&pagelist)) {
+				WARN_ON_ONCE(flags & MPOL_MF_LAZY);
+				nr_failed = migrate_pages(&pagelist, new_page,
+					NULL, start, MIGRATE_SYNC,
+					MR_MEMPOLICY_MBIND);
+				if (nr_failed)
+					putback_movable_pages(&pagelist);
+			}
+
+			if ((ret > 0) ||
+			    (nr_failed && (flags & MPOL_MF_STRICT)))
+				err = -EIO;
+		} else
+			putback_movable_pages(&pagelist);
+	}
 
 	up_write(&mm->mmap_sem);
  mpol_out:
-- 
1.8.3.1

