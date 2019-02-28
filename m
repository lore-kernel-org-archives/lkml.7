Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2801D218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfB1Ifv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:35:51 -0500
Received: from relay.sw.ru ([185.231.240.75]:57915 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbfB1Ift (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:35:49 -0500
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gzHAJ-0008R2-PM; Thu, 28 Feb 2019 11:35:39 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 1/4] mm/workingset: remove unused @mapping argument in workingset_eviction()
Date:   Thu, 28 Feb 2019 11:33:26 +0300
Message-Id: <20190228083329.31892-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

workingset_eviction() doesn't use and never did use the @mapping argument.
Remove it.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
---

Changes since v1:
 - s/@mapping/@page->mapping in comment
 - Acks

 include/linux/swap.h | 2 +-
 mm/vmscan.c          | 2 +-
 mm/workingset.c      | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 649529be91f2..fc50e21b3b88 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -307,7 +307,7 @@ struct vma_swap_readahead {
 };
 
 /* linux/mm/workingset.c */
-void *workingset_eviction(struct address_space *mapping, struct page *page);
+void *workingset_eviction(struct page *page);
 void workingset_refault(struct page *page, void *shadow);
 void workingset_activation(struct page *page);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ac4806f0f332..a9852ed7b97f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -952,7 +952,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		 */
 		if (reclaimed && page_is_file_cache(page) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
-			shadow = workingset_eviction(mapping, page);
+			shadow = workingset_eviction(page);
 		__delete_from_page_cache(page, shadow);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
 
diff --git a/mm/workingset.c b/mm/workingset.c
index dcb994f2acc2..0bedf67502d5 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -215,13 +215,12 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 
 /**
  * workingset_eviction - note the eviction of a page from memory
- * @mapping: address space the page was backing
  * @page: the page being evicted
  *
- * Returns a shadow entry to be stored in @mapping->i_pages in place
+ * Returns a shadow entry to be stored in @page->mapping->i_pages in place
  * of the evicted @page so that a later refault can be detected.
  */
-void *workingset_eviction(struct address_space *mapping, struct page *page)
+void *workingset_eviction(struct page *page)
 {
 	struct pglist_data *pgdat = page_pgdat(page);
 	struct mem_cgroup *memcg = page_memcg(page);
-- 
2.19.2

