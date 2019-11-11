Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FFAC17447
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372AA2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKKWJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:09:36 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48721 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbfKKWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:09:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Thpy97A_1573510165;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Thpy97A_1573510165)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 06:09:31 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: migrate: handle freed page at the first place
Date:   Tue, 12 Nov 2019 06:09:25 +0800
Message-Id: <1573510165-113395-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing migration if the freed page is met, we just return without
migrating it since it is pointless to migrate a freed page.  But, the
current code did two things before handling freed page:

1. Return -ENOMEM if the page is THP and THP migration is not supported.
2. Allocate target page unconditionally.

Both makes not too much sense.  If we handle freed page at the first place
we don't have to worry about allocating/freeing target page and split
THP at all.

For example (worst case) if we are trying to migrate a freed THP without
THP migration supported, the migrate_pages() would just split the THP then
retry to migrate base pages one by one by pointless allocating and freeing
pages, this is just waste of time.

I didn't run into any actual problem with the current code (or I may
just not notice it yet), it was found by visual inspection.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/migrate.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4fe45d1..ef96997 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1170,13 +1170,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 	int rc = MIGRATEPAGE_SUCCESS;
 	struct page *newpage;
 
-	if (!thp_migration_supported() && PageTransHuge(page))
-		return -ENOMEM;
-
-	newpage = get_new_page(page, private);
-	if (!newpage)
-		return -ENOMEM;
-
 	if (page_count(page) == 1) {
 		/* page was freed from under us. So we are done. */
 		ClearPageActive(page);
@@ -1187,13 +1180,16 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 				__ClearPageIsolated(page);
 			unlock_page(page);
 		}
-		if (put_new_page)
-			put_new_page(newpage, private);
-		else
-			put_page(newpage);
 		goto out;
 	}
 
+	if (!thp_migration_supported() && PageTransHuge(page))
+		return -ENOMEM;
+
+	newpage = get_new_page(page, private);
+	if (!newpage)
+		return -ENOMEM;
+
 	rc = __unmap_and_move(page, newpage, force, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		set_page_owner_migrate_reason(newpage, reason);
-- 
1.8.3.1

