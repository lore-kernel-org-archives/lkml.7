Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C959C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB3B2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKNSYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:24:44 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:37550 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbfKNSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:24:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ti522SS_1573755869;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Ti522SS_1573755869)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Nov 2019 02:24:40 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] mm: migrate: handle freed page at the first place
Date:   Fri, 15 Nov 2019 02:24:29 +0800
Message-Id: <1573755869-106954-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing migration if the freed page is met, we just return without
migrating it since it is pointless to migrate a freed page.  But, the
current code allocates target page unconditionally before handling freed
page, if the page is freed, the newly allocated will be just freed.  It
doesn't make too much sense and is just a waste of time although
migrating freed page is rare.

So, handle freed page at the before that to avoid unnecessary page
allocation and free.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: * Keep thp migration support check before handling freed page per Michal Hocko
    * Fixed the build warning reported by 0-day

 mm/migrate.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4fe45d1..a8f87cb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1168,15 +1168,11 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 				   enum migrate_reason reason)
 {
 	int rc = MIGRATEPAGE_SUCCESS;
-	struct page *newpage;
+	struct page *newpage = NULL;
 
 	if (!thp_migration_supported() && PageTransHuge(page))
 		return -ENOMEM;
 
-	newpage = get_new_page(page, private);
-	if (!newpage)
-		return -ENOMEM;
-
 	if (page_count(page) == 1) {
 		/* page was freed from under us. So we are done. */
 		ClearPageActive(page);
@@ -1187,13 +1183,13 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 				__ClearPageIsolated(page);
 			unlock_page(page);
 		}
-		if (put_new_page)
-			put_new_page(newpage, private);
-		else
-			put_page(newpage);
 		goto out;
 	}
 
+	newpage = get_new_page(page, private);
+	if (!newpage)
+		return -ENOMEM;
+
 	rc = __unmap_and_move(page, newpage, force, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		set_page_owner_migrate_reason(newpage, reason);
-- 
1.8.3.1

