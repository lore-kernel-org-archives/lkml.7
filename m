Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62906ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4441221848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440211AbfJQOWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:22:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440097AbfJQOVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F88DB4C5;
        Thu, 17 Oct 2019 14:21:38 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 16/16] mm, soft-offline: convert parameter to pfn
Date:   Thu, 17 Oct 2019 16:21:23 +0200
Message-Id: <20191017142123.24245-17-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Currently soft_offline_page() receives struct page, and its sibling
memory_failure() receives pfn. This discrepancy looks weird and makes
precheck on pfn validity tricky. So let's align them.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c |  7 +------
 include/linux/mm.h    |  2 +-
 mm/madvise.c          |  2 +-
 mm/memory-failure.c   | 17 +++++++++--------
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b3cae2eb1c4f..b510b4d176c9 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -538,12 +538,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	if (!pfn_valid(pfn))
-		return -ENXIO;
-	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
-	if (!pfn_to_online_page(pfn))
-		return -EIO;
-	ret = soft_offline_page(pfn_to_page(pfn));
+	ret = soft_offline_page(pfn);
 	return ret == 0 ? count : ret;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0f80a1ce4e86..40722854d357 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2791,7 +2791,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(struct page *page);
+extern int soft_offline_page(unsigned long pfn);
 
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index 9ca48345ce45..f83b7d4c68c1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -890,7 +890,7 @@ static int madvise_inject_error(int behavior,
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = soft_offline_page(page);
+			ret = soft_offline_page(pfn);
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c038896bedf0..bfecb61fc064 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1521,7 +1521,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(pfn_to_page(entry.pfn));
+			soft_offline_page(entry.pfn);
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1834,7 +1834,7 @@ static int soft_offline_free_page(struct page *page)
 
 /**
  * soft_offline_page - Soft offline a page.
- * @page: page to offline
+ * @pfn: pfn to soft-offline
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1853,16 +1853,17 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(struct page *page)
+int soft_offline_page(unsigned long pfn)
 {
 	int ret;
-	unsigned long pfn = page_to_pfn(page);
+	struct page *page;
 
-	if (is_zone_device_page(page)) {
-		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
-				pfn);
+	if (!pfn_valid(pfn))
+		return -ENXIO;
+	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
+	page = pfn_to_online_page(pfn);
+	if (!page)
 		return -EIO;
-	}
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-- 
2.12.3

