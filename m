Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87632C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660D222DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfHTNSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:18:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729672AbfHTNSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:18:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA972AC8E;
        Tue, 20 Aug 2019 13:18:38 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 2/4] mm, page_owner: record page owner for each subpage
Date:   Tue, 20 Aug 2019 15:18:26 +0200
Message-Id: <20190820131828.22684-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820131828.22684-1-vbabka@suse.cz>
References: <20190820131828.22684-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, page owner info is only recorded for the first page of a high-order
allocation, and copied to tail pages in the event of a split page. With the
plan to keep previous owner info after freeing the page, it would be benefical
to record page owner for each subpage upon allocation. This increases the
overhead for high orders, but that should be acceptable for a debugging option.

The order stored for each subpage is the order of the whole allocation. This
makes it possible to calculate the "head" pfn and to recognize "tail" pages
(quoted because not all high-order allocations are compound pages with true
head and tail pages). When reading the page_owner debugfs file, keep skipping
the "tail" pages so that stats gathered by existing scripts don't get inflated.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_owner.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index addcbb2ae4e4..813fcb70547b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -154,18 +154,23 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	return handle;
 }
 
-static inline void __set_page_owner_handle(struct page_ext *page_ext,
-	depot_stack_handle_t handle, unsigned int order, gfp_t gfp_mask)
+static inline void __set_page_owner_handle(struct page *page,
+	struct page_ext *page_ext, depot_stack_handle_t handle,
+	unsigned int order, gfp_t gfp_mask)
 {
 	struct page_owner *page_owner;
+	int i;
 
-	page_owner = get_page_owner(page_ext);
-	page_owner->handle = handle;
-	page_owner->order = order;
-	page_owner->gfp_mask = gfp_mask;
-	page_owner->last_migrate_reason = -1;
+	for (i = 0; i < (1 << order); i++) {
+		page_owner = get_page_owner(page_ext);
+		page_owner->handle = handle;
+		page_owner->order = order;
+		page_owner->gfp_mask = gfp_mask;
+		page_owner->last_migrate_reason = -1;
+		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 
-	__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
+		page_ext = lookup_page_ext(page + i);
+	}
 }
 
 noinline void __set_page_owner(struct page *page, unsigned int order,
@@ -178,7 +183,7 @@ noinline void __set_page_owner(struct page *page, unsigned int order,
 		return;
 
 	handle = save_stack(gfp_mask);
-	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
+	__set_page_owner_handle(page, page_ext, handle, order, gfp_mask);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
@@ -204,8 +209,11 @@ void __split_page_owner(struct page *page, unsigned int order)
 
 	page_owner = get_page_owner(page_ext);
 	page_owner->order = 0;
-	for (i = 1; i < (1 << order); i++)
-		__copy_page_owner(page, page + i);
+	for (i = 1; i < (1 << order); i++) {
+		page_ext = lookup_page_ext(page + i);
+		page_owner = get_page_owner(page_ext);
+		page_owner->order = 0;
+	}
 }
 
 void __copy_page_owner(struct page *oldpage, struct page *newpage)
@@ -483,6 +491,13 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 		page_owner = get_page_owner(page_ext);
 
+		/*
+		 * Don't print "tail" pages of high-order allocations as that
+		 * would inflate the stats.
+		 */
+		if (!IS_ALIGNED(pfn, 1 << page_owner->order))
+			continue;
+
 		/*
 		 * Access to page_ext->handle isn't synchronous so we should
 		 * be careful to access it.
@@ -562,7 +577,8 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 				continue;
 
 			/* Found early allocated page */
-			__set_page_owner_handle(page_ext, early_handle, 0, 0);
+			__set_page_owner_handle(page, page_ext, early_handle,
+						0, 0);
 			count++;
 		}
 		cond_resched();
-- 
2.22.0

