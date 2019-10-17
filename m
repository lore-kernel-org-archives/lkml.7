Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB5CECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC1D214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440239AbfJQOWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:22:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440135AbfJQOVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11D7DB4EE;
        Thu, 17 Oct 2019 14:21:36 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free pages
Date:   Thu, 17 Oct 2019 16:21:17 +0200
Message-Id: <20191017142123.24245-11-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to soft-offline a free page, we need to first take it off
the buddy allocator.
Once we know is out of reach, we can safely flag it as poisoned.

take_page_off_buddy will be used to take a page meant to be poisoned
off the buddy allocator.
take_page_off_buddy calls break_down_buddy_pages, which splits a
higher-order page in case our page belongs to one.

Once the page is under our control, we call page_set_poison to set it
as poisoned and grab a refcount on it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 20 +++++++++++-----
 mm/page_alloc.c     | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 37b230b8cfe7..1d986580522d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -78,6 +78,15 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_dev_minor);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_mask);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
 
+extern bool take_page_off_buddy(struct page *page);
+
+static void page_handle_poison(struct page *page)
+{
+	SetPageHWPoison(page);
+	page_ref_inc(page);
+	num_poisoned_pages_inc();
+}
+
 static int hwpoison_filter_dev(struct page *p)
 {
 	struct address_space *mapping;
@@ -1830,14 +1839,13 @@ static int soft_offline_in_use_page(struct page *page)
 
 static int soft_offline_free_page(struct page *page)
 {
-	int rc = dissolve_free_huge_page(page);
+	int rc = -EBUSY;
 
-	if (!rc) {
-		if (set_hwpoison_free_buddy_page(page))
-			num_poisoned_pages_inc();
-		else
-			rc = -EBUSY;
+	if (!dissolve_free_huge_page(page) && take_page_off_buddy(page)) {
+		page_handle_poison(page);
+		rc = 0;
 	}
+
 	return rc;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cd1dd0712624..255df0c76a40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8632,6 +8632,74 @@ bool is_free_buddy_page(struct page *page)
 
 #ifdef CONFIG_MEMORY_FAILURE
 /*
+ * Break down a higher-order page in sub-pages, and keep our target out of
+ * buddy allocator.
+ */
+static void break_down_buddy_pages(struct zone *zone, struct page *page,
+				   struct page *target, int low, int high,
+				   struct free_area *area, int migratetype)
+{
+	unsigned long size = 1 << high;
+	struct page *current_buddy, *next_page;
+
+	while (high > low) {
+		area--;
+		high--;
+		size >>= 1;
+
+		if (target >= &page[size]) {
+			next_page = page + size;
+			current_buddy = page;
+		} else {
+			next_page = page;
+			current_buddy = page + size;
+		}
+
+		if (set_page_guard(zone, current_buddy, high, migratetype))
+			continue;
+
+		if (current_buddy != target) {
+			add_to_free_area(current_buddy, area, migratetype);
+			set_page_order(current_buddy, high);
+			page = next_page;
+		}
+	}
+}
+
+/*
+ * Take a page that will be marked as poisoned off the buddy allocator.
+ */
+bool take_page_off_buddy(struct page *page)
+ {
+	struct zone *zone = page_zone(page);
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	unsigned int order;
+	bool ret = false;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	for (order = 0; order < MAX_ORDER; order++) {
+		struct page *page_head = page - (pfn & ((1 << order) - 1));
+		int buddy_order = page_order(page_head);
+		struct free_area *area = &(zone->free_area[buddy_order]);
+
+		if (PageBuddy(page_head) && buddy_order >= order) {
+			unsigned long pfn_head = page_to_pfn(page_head);
+			int migratetype = get_pfnblock_migratetype(page_head,
+		                                                   pfn_head);
+
+			del_page_from_free_area(page_head, area);
+			break_down_buddy_pages(zone, page_head, page, 0,
+		                               buddy_order, area, migratetype);
+			ret = true;
+		        break;
+		 }
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return ret;
+ }
+
+/*
  * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
  * test is performed under the zone lock to prevent a race against page
  * allocation.
-- 
2.12.3

