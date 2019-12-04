Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AABDC43215
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2482073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 00:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLDAnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 19:43:06 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41209 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbfLDAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 19:43:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tjr3EVU_1575420174;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tjr3EVU_1575420174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Dec 2019 08:43:01 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: shmem: allow split THP when truncating THP partially
Date:   Wed,  4 Dec 2019 08:42:54 +0800
Message-Id: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when truncating shmem file, if the range is partial of THP
(start or end is in the middle of THP), the pages actually will just get
cleared rather than being freed unless the range cover the whole THP.
Even though all the subpages are truncated (randomly or sequentially),
the THP may still be kept in page cache.  This might be fine for some
usecases which prefer preserving THP.

But, when doing balloon inflation in QEMU, QEMU actually does hole punch
or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
So, when using shmem THP as memory backend QEMU inflation actually doesn't
work as expected since it doesn't free memory.  But, the inflation
usecase really needs get the memory freed.  Anonymous THP will not get
freed right away too but it will be freed eventually when all subpages are
unmapped, but shmem THP would still stay in page cache.

Split THP right away when doing partial hole punch, and if split fails
just clear the page so that read to the hole punched area would return
zero.

Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: * Adopted the comment from Kirill.
    * Dropped fallocate mode flag, THP split is the default behavior.
    * Blended Huge's implementation with my v1 patch. TBH I'm not very keen to
      Hugh's find_get_entries() hack (basically neutral), but without that hack
      we have to rely on pagevec_release() to release extra pins and play with
      goto. This version does in this way. The patch is bigger than Hugh's due
      to extra comments to make the flow clear.

 mm/shmem.c | 120 ++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 37 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 220be9f..1ae0c7f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -806,12 +806,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
+	bool split = false;
+	struct page *page = NULL;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
 
 	pagevec_init(&pvec);
 	index = start;
+retry:
 	while (index < end) {
 		pvec.nr = find_get_entries(mapping, index,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE),
@@ -819,7 +822,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		if (!pvec.nr)
 			break;
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			split = false;
+			page = pvec.pages[i];
 
 			index = indices[i];
 			if (index >= end)
@@ -838,23 +842,24 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (!trylock_page(page))
 				continue;
 
-			if (PageTransTail(page)) {
-				/* Middle of THP: zero out the page */
-				clear_highpage(page);
-				unlock_page(page);
-				continue;
-			} else if (PageTransHuge(page)) {
-				if (index == round_down(end, HPAGE_PMD_NR)) {
+			if (PageTransCompound(page) && !unfalloc) {
+				if (PageHead(page) &&
+				    index != round_down(end, HPAGE_PMD_NR)) {
 					/*
-					 * Range ends in the middle of THP:
-					 * zero out the page
+					 * Fall through when punching whole
+					 * THP.
 					 */
-					clear_highpage(page);
-					unlock_page(page);
-					continue;
+					index += HPAGE_PMD_NR - 1;
+					i += HPAGE_PMD_NR - 1;
+				} else {
+					/*
+					 * Split THP for any partial hole
+					 * punch.
+					 */
+					get_page(page);
+					split = true;
+					goto split;
 				}
-				index += HPAGE_PMD_NR - 1;
-				i += HPAGE_PMD_NR - 1;
 			}
 
 			if (!unfalloc || !PageUptodate(page)) {
@@ -866,9 +871,29 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			unlock_page(page);
 		}
+split:
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
 		cond_resched();
+
+		if (split) {
+			/*
+			 * The pagevec_release() released all extra pins
+			 * from pagevec lookup.  And we hold an extra pin
+			 * and still have the page locked under us.
+			 */
+			if (!split_huge_page(page)) {
+				unlock_page(page);
+				put_page(page);
+				/* Re-lookup page cache from current index */
+				goto retry;
+			}
+
+			/* Fail to split THP, move to next index */
+			unlock_page(page);
+			put_page(page);
+		}
+
 		index++;
 	}
 
@@ -901,6 +926,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		return;
 
 	index = start;
+again:
 	while (index < end) {
 		cond_resched();
 
@@ -916,7 +942,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			continue;
 		}
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			split = false;
+			page = pvec.pages[i];
 
 			index = indices[i];
 			if (index >= end)
@@ -936,30 +963,24 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 			lock_page(page);
 
-			if (PageTransTail(page)) {
-				/* Middle of THP: zero out the page */
-				clear_highpage(page);
-				unlock_page(page);
-				/*
-				 * Partial thp truncate due 'start' in middle
-				 * of THP: don't need to look on these pages
-				 * again on !pvec.nr restart.
-				 */
-				if (index != round_down(end, HPAGE_PMD_NR))
-					start++;
-				continue;
-			} else if (PageTransHuge(page)) {
-				if (index == round_down(end, HPAGE_PMD_NR)) {
+			if (PageTransCompound(page) && !unfalloc) {
+				if (PageHead(page) &&
+				    index != round_down(end, HPAGE_PMD_NR)) {
 					/*
-					 * Range ends in the middle of THP:
-					 * zero out the page
+					 * Fall through when punching whole
+					 * THP.
 					 */
-					clear_highpage(page);
-					unlock_page(page);
-					continue;
+					index += HPAGE_PMD_NR - 1;
+					i += HPAGE_PMD_NR - 1;
+				} else {
+					/*
+					 * Split THP for any partial hole
+					 * punch.
+					 */
+					get_page(page);
+					split = true;
+					goto rescan_split;
 				}
-				index += HPAGE_PMD_NR - 1;
-				i += HPAGE_PMD_NR - 1;
 			}
 
 			if (!unfalloc || !PageUptodate(page)) {
@@ -976,8 +997,33 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			unlock_page(page);
 		}
+rescan_split:
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
+
+		if (split) {
+			/*
+			 * The pagevec_release() released all extra pins
+			 * from pagevec lookup.  And we hold an extra pin
+			 * and still have the page locked under us.
+			 */
+			if (!split_huge_page(page)) {
+				unlock_page(page);
+				put_page(page);
+				/* Re-lookup page cache from current index */
+				goto again;
+			}
+
+			/*
+			 * Split fail, clear the page then move to next
+			 * index.
+			 */
+			clear_highpage(page);
+
+			unlock_page(page);
+			put_page(page);
+		}
+
 		index++;
 	}
 
-- 
1.8.3.1

