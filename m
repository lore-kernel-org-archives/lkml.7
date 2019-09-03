Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2900C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7107216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfICIIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:08:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfICIIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:08:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1114868C325B8D4E5E53;
        Tue,  3 Sep 2019 16:08:23 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 16:08:15 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <sunqiuyang@huawei.com>
Subject: [PATCH 1/1] mm/migrate: fix list corruption in migration of non-LRU movable pages
Date:   Tue, 3 Sep 2019 16:27:46 +0800
Message-ID: <20190903082746.20736-1-sunqiuyang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiuyang Sun <sunqiuyang@huawei.com>

Currently, after a page is migrated, it
1) has its PG_isolated flag cleared in move_to_new_page(), and
2) is deleted from its LRU list (cc->migratepages) in unmap_and_move().
However, between steps 1) and 2), the page could be isolated by another
thread in isolate_movable_page(), and added to another LRU list, leading
to list_del corruption later.

This patch fixes the bug by moving list_del into the critical section
protected by lock_page(), so that a page will not be isolated again before
it has been deleted from its LRU list.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 mm/migrate.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a42858d..c58a606 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1124,6 +1124,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
+	if (rc != -EAGAIN)
+		list_del(&page->lru);
 	unlock_page(page);
 out:
 	/*
@@ -1190,6 +1192,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 			put_new_page(newpage, private);
 		else
 			put_page(newpage);
+		list_del(&page->lru);
 		goto out;
 	}
 
@@ -1200,14 +1203,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 out:
 	if (rc != -EAGAIN) {
 		/*
-		 * A page that has been migrated has all references
-		 * removed and will be freed. A page that has not been
-		 * migrated will have kepts its references and be
-		 * restored.
-		 */
-		list_del(&page->lru);
-
-		/*
 		 * Compaction can migrate also non-LRU pages which are
 		 * not accounted to NR_ISOLATED_*. They can be recognized
 		 * as __PageMovable
-- 
1.8.3.1

