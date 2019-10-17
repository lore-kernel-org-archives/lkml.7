Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE7FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B9721835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440181AbfJQOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:21:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440125AbfJQOVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 341D0B4FE;
        Thu, 17 Oct 2019 14:21:35 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 08/16] mm,hwpoison: remove flag argument from soft offline functions
Date:   Thu, 17 Oct 2019 16:21:15 +0200
Message-Id: <20191017142123.24245-9-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

The argument @flag no longer affects the behavior of soft_offline_page()
and its variants, so let's remove them.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c |  2 +-
 include/linux/mm.h    |  2 +-
 mm/madvise.c          |  2 +-
 mm/memory-failure.c   | 27 +++++++++++++--------------
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 55907c27075b..b3cae2eb1c4f 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -543,7 +543,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
 	if (!pfn_to_online_page(pfn))
 		return -EIO;
-	ret = soft_offline_page(pfn_to_page(pfn), 0);
+	ret = soft_offline_page(pfn_to_page(pfn));
 	return ret == 0 ? count : ret;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4c2cf2ea9953..0f80a1ce4e86 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2791,7 +2791,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(struct page *page, int flags);
+extern int soft_offline_page(struct page *page);
 
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index b765860a5d04..8a0b1f901d72 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -893,7 +893,7 @@ static int madvise_inject_error(int behavior,
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = soft_offline_page(page, 0);
+			ret = soft_offline_page(page);
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c6b31cf409d3..836d671fb74f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1469,7 +1469,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(pfn_to_page(entry.pfn), entry.flags);
+			soft_offline_page(pfn_to_page(entry.pfn));
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1602,7 +1602,7 @@ static struct page *new_page(struct page *p, unsigned long private)
  * that is not free, and 1 for any other page type.
  * For 1 the page is returned with increased page count, otherwise not.
  */
-static int __get_any_page(struct page *p, unsigned long pfn, int flags)
+static int __get_any_page(struct page *p, unsigned long pfn)
 {
 	int ret;
 
@@ -1629,9 +1629,9 @@ static int __get_any_page(struct page *p, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int get_any_page(struct page *page, unsigned long pfn, int flags)
+static int get_any_page(struct page *page, unsigned long pfn)
 {
-	int ret = __get_any_page(page, pfn, flags);
+	int ret = __get_any_page(page, pfn);
 
 	if (ret == 1 && !PageHuge(page) &&
 	    !PageLRU(page) && !__PageMovable(page)) {
@@ -1644,7 +1644,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 		/*
 		 * Did it turn free?
 		 */
-		ret = __get_any_page(page, pfn, 0);
+		ret = __get_any_page(page, pfn);
 		if (ret == 1 && !PageLRU(page)) {
 			/* Drop page reference which is from __get_any_page() */
 			put_page(page);
@@ -1656,7 +1656,7 @@ static int get_any_page(struct page *page, unsigned long pfn, int flags)
 	return ret;
 }
 
-static int soft_offline_huge_page(struct page *page, int flags)
+static int soft_offline_huge_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1715,7 +1715,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 	return ret;
 }
 
-static int __soft_offline_page(struct page *page, int flags)
+static int __soft_offline_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1795,7 +1795,7 @@ static int __soft_offline_page(struct page *page, int flags)
 	return ret;
 }
 
-static int soft_offline_in_use_page(struct page *page, int flags)
+static int soft_offline_in_use_page(struct page *page)
 {
 	int ret;
 	int mt;
@@ -1825,9 +1825,9 @@ static int soft_offline_in_use_page(struct page *page, int flags)
 	mt = get_pageblock_migratetype(page);
 	set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 	if (PageHuge(page))
-		ret = soft_offline_huge_page(page, flags);
+		ret = soft_offline_huge_page(page);
 	else
-		ret = __soft_offline_page(page, flags);
+		ret = __soft_offline_page(page);
 	set_pageblock_migratetype(page, mt);
 	return ret;
 }
@@ -1848,7 +1848,6 @@ static int soft_offline_free_page(struct page *page)
 /**
  * soft_offline_page - Soft offline a page.
  * @page: page to offline
- * @flags: flags. Same as memory_failure().
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1867,7 +1866,7 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(struct page *page, int flags)
+int soft_offline_page(struct page *page)
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
@@ -1884,11 +1883,11 @@ int soft_offline_page(struct page *page, int flags)
 	}
 
 	get_online_mems();
-	ret = get_any_page(page, pfn, flags);
+	ret = get_any_page(page, pfn);
 	put_online_mems();
 
 	if (ret > 0)
-		ret = soft_offline_in_use_page(page, flags);
+		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
 		ret = soft_offline_free_page(page);
 
-- 
2.12.3

