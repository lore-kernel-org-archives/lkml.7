Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08C8ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D8C21848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440201AbfJQOVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:21:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440147AbfJQOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B799CB489;
        Thu, 17 Oct 2019 14:21:37 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 14/16] mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
Date:   Thu, 17 Oct 2019 16:21:21 +0200
Message-Id: <20191017142123.24245-15-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is an inconsistency when calling soft-offline from
different paths on a page that is already poisoned.

1) madvise:

        madvise_inject_error skips any poisoned page and continues
        the loop.
        If that was the only page to madvise, it returns 0.

2) /sys/devices/system/memory/:

        Whe calling soft_offline_page_store()->soft_offline_page(),
        we return -EBUSY in case the page is already poisoned.
        This is inconsistent with a) the above example and b)
        memory_failure, where we return 0 if the page was poisoned.

Fix this by dropping the PageHWPoison() check in madvise_inject_error,
and let soft_offline_page return 0 if it finds the page already poisoned.

Please, note that this represents an user-api change, since now the return
error when calling soft_offline_page_store()->soft_offline_page() will be different.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/madvise.c        | 3 ---
 mm/memory-failure.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8a0b1f901d72..9ca48345ce45 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -887,9 +887,6 @@ static int madvise_inject_error(int behavior,
 		 */
 		put_page(page);
 
-		if (PageHWPoison(page))
-			continue;
-
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3d491c0d3f91..c038896bedf0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1767,7 +1767,7 @@ static int __soft_offline_page(struct page *page)
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	if (!PageHuge(page))
@@ -1866,7 +1866,7 @@ int soft_offline_page(struct page *page)
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	get_online_mems();
-- 
2.12.3

