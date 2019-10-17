Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B6EECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2592F21A49
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440172AbfJQOVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:21:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440119AbfJQOVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D255B496;
        Thu, 17 Oct 2019 14:21:34 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 06/16] mm,hwpoison: Kill put_hwpoison_page
Date:   Thu, 17 Oct 2019 16:21:13 +0200
Message-Id: <20191017142123.24245-7-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After ("4e41a30c6d50: mm: hwpoison: adjust for new thp refcounting"),
put_hwpoison_page got reduced to a put_page.
Let us just use put_page instead.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm.h  |  1 -
 mm/memory-failure.c | 30 +++++++++++++++---------------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a646eb4dc993..d6dca8778cc2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2788,7 +2788,6 @@ enum mf_flags {
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern int unpoison_memory(unsigned long pfn);
-#define put_hwpoison_page(page)	put_page(page)
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5ce634ddf9fa..3e73738a2246 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1107,7 +1107,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
 		num_poisoned_pages_dec();
 		unlock_page(head);
-		put_hwpoison_page(head);
+		put_page(head);
 		return 0;
 	}
 
@@ -1299,7 +1299,7 @@ int memory_failure(unsigned long pfn, int flags)
 					pfn);
 			if (TestClearPageHWPoison(p))
 				num_poisoned_pages_dec();
-			put_hwpoison_page(p);
+			put_page(p);
 			return -EBUSY;
 		}
 		unlock_page(p);
@@ -1353,14 +1353,14 @@ int memory_failure(unsigned long pfn, int flags)
 		pr_err("Memory failure: %#lx: just unpoisoned\n", pfn);
 		num_poisoned_pages_dec();
 		unlock_page(p);
-		put_hwpoison_page(p);
+		put_page(p);
 		return 0;
 	}
 	if (hwpoison_filter(p)) {
 		if (TestClearPageHWPoison(p))
 			num_poisoned_pages_dec();
 		unlock_page(p);
-		put_hwpoison_page(p);
+		put_page(p);
 		return 0;
 	}
 
@@ -1584,9 +1584,9 @@ int unpoison_memory(unsigned long pfn)
 	}
 	unlock_page(page);
 
-	put_hwpoison_page(page);
+	put_page(page);
 	if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1))
-		put_hwpoison_page(page);
+		put_page(page);
 
 	return 0;
 }
@@ -1644,7 +1644,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		/*
 		 * Try to free it.
 		 */
-		put_hwpoison_page(page);
+		put_page(page);
 		shake_page(page, 1);
 
 		/*
@@ -1653,7 +1653,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		ret = __get_any_page(page, pfn, 0);
 		if (ret == 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
-			put_hwpoison_page(page);
+			put_page(page);
 			pr_info("soft_offline: %#lx: unknown non LRU page type %lx (%pGp)\n",
 				pfn, page->flags, &page->flags);
 			return -EIO;
@@ -1676,7 +1676,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	lock_page(hpage);
 	if (PageHWPoison(hpage)) {
 		unlock_page(hpage);
-		put_hwpoison_page(hpage);
+		put_page(hpage);
 		pr_info("soft offline: %#lx hugepage already poisoned\n", pfn);
 		return -EBUSY;
 	}
@@ -1687,7 +1687,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	 * get_any_page() and isolate_huge_page() takes a refcount each,
 	 * so need to drop one here.
 	 */
-	put_hwpoison_page(hpage);
+	put_page(hpage);
 	if (!ret) {
 		pr_info("soft offline: %#lx hugepage failed to isolate\n", pfn);
 		return -EBUSY;
@@ -1736,7 +1736,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	wait_on_page_writeback(page);
 	if (PageHWPoison(page)) {
 		unlock_page(page);
-		put_hwpoison_page(page);
+		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		return -EBUSY;
 	}
@@ -1751,7 +1751,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * would need to fix isolation locking first.
 	 */
 	if (ret == 1) {
-		put_hwpoison_page(page);
+		put_page(page);
 		pr_info("soft_offline: %#lx: invalidated\n", pfn);
 		SetPageHWPoison(page);
 		num_poisoned_pages_inc();
@@ -1771,7 +1771,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	 * Drop page reference which is came from get_any_page()
 	 * successful isolate_lru_page() already took another one.
 	 */
-	put_hwpoison_page(page);
+	put_page(page);
 	if (!ret) {
 		LIST_HEAD(pagelist);
 		/*
@@ -1815,7 +1815,7 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 				pr_info("soft offline: %#lx: non anonymous thp\n", page_to_pfn(page));
 			else
 				pr_info("soft offline: %#lx: thp split failed\n", page_to_pfn(page));
-			put_hwpoison_page(page);
+			put_page(page);
 			return -EBUSY;
 		}
 		unlock_page(page);
@@ -1889,7 +1889,7 @@ int soft_offline_page(struct page *page, int flags)
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		if (flags & MF_COUNT_INCREASED)
-			put_hwpoison_page(page);
+			put_page(page);
 		return -EBUSY;
 	}
 
-- 
2.12.3

