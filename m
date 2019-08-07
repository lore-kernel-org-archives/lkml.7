Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA82C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB98217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 02:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfHGCSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 22:18:18 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57605 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728706AbfHGCSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 22:18:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TYr3obk_1565144286;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TYr3obk_1565144286)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 07 Aug 2019 10:18:13 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, cai@lca.pw,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v5 PATCH 2/4] mm: move mem_cgroup_uncharge out of __page_cache_release()
Date:   Wed,  7 Aug 2019 10:17:55 +0800
Message-Id: <1565144277-36240-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565144277-36240-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1565144277-36240-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later patch would make THP deferred split shrinker memcg aware, but
it needs page->mem_cgroup information in THP destructor, which is called
after mem_cgroup_uncharge() now.

So, move mem_cgroup_uncharge() from __page_cache_release() to compound
page destructor, which is called by both THP and other compound pages
except HugeTLB.  And call it in __put_single_page() for single order
page.

Suggested-by: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Qian Cai <cai@lca.pw>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/page_alloc.c | 1 +
 mm/swap.c       | 2 +-
 mm/vmscan.c     | 6 ++----
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index df02a88..1d1c5d3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -670,6 +670,7 @@ static void bad_page(struct page *page, const char *reason,
 
 void free_compound_page(struct page *page)
 {
+	mem_cgroup_uncharge(page);
 	__free_pages_ok(page, compound_order(page));
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index ae30039..d4242c8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -71,12 +71,12 @@ static void __page_cache_release(struct page *page)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
 	__ClearPageWaiters(page);
-	mem_cgroup_uncharge(page);
 }
 
 static void __put_single_page(struct page *page)
 {
 	__page_cache_release(page);
+	mem_cgroup_uncharge(page);
 	free_unref_page(page);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index dbdc46a..b1b5e5f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1490,10 +1490,9 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		 * Is there need to periodically free_page_list? It would
 		 * appear not as the counts should be low
 		 */
-		if (unlikely(PageTransHuge(page))) {
-			mem_cgroup_uncharge(page);
+		if (unlikely(PageTransHuge(page)))
 			(*get_compound_page_dtor(page))(page);
-		} else
+		else
 			list_add(&page->lru, &free_pages);
 		continue;
 
@@ -1914,7 +1913,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&pgdat->lru_lock);
-				mem_cgroup_uncharge(page);
 				(*get_compound_page_dtor(page))(page);
 				spin_lock_irq(&pgdat->lru_lock);
 			} else
-- 
1.8.3.1

