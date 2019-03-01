Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED48C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC020840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfCAMQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:16:46 -0500
Received: from relay.sw.ru ([185.231.240.75]:44510 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCAMQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:16:45 -0500
Received: from [172.16.25.12] (helo=i7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gzh5j-0004ZX-33; Fri, 01 Mar 2019 15:16:39 +0300
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] mm-remove-zone_lru_lock-function-access-lru_lock-directly-fix
Date:   Fri,  1 Mar 2019 15:16:51 +0300
Message-Id: <20190301121651.7741-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A slightly better version of __split_huge_page();

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/huge_memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4ccac6b32d49..fcf657886b4b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2440,11 +2440,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		pgoff_t end, unsigned long flags)
 {
 	struct page *head = compound_head(page);
-	struct zone *zone = page_zone(head);
+	pg_data_t *pgdat = page_pgdat(head);
 	struct lruvec *lruvec;
 	int i;
 
-	lruvec = mem_cgroup_page_lruvec(head, zone->zone_pgdat);
+	lruvec = mem_cgroup_page_lruvec(head, pgdat);
 
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
@@ -2475,7 +2475,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_unlock(&head->mapping->i_pages);
 	}
 
-	spin_unlock_irqrestore(&page_pgdat(head)->lru_lock, flags);
+	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 
 	remap_page(head);
 
-- 
2.19.2

