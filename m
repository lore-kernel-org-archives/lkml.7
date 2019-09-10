Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355DBC49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F5D21A4C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393717AbfIJKax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:59368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393685AbfIJKav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:30:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8374FAE5E;
        Tue, 10 Sep 2019 10:30:49 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 03/10] mm,hwpoison-inject: don't pin for hwpoison_filter
Date:   Tue, 10 Sep 2019 12:30:09 +0200
Message-Id: <20190910103016.14290-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190910103016.14290-1-osalvador@suse.de>
References: <20190910103016.14290-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Another memory error injection interface debugfs:hwpoison/corrupt-pfn
also takes bogus refcount for hwpoison_filter(). It's justified
because this does a coarse filter, expecting that memory_failure()
redoes the check for sure.

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hwpoison-inject.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 5b7430bd83a6..0c8cdb80fd7d 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -26,11 +26,6 @@ static int hwpoison_inject(void *data, u64 val)
 
 	p = pfn_to_page(pfn);
 	hpage = compound_head(p);
-	/*
-	 * This implies unable to support free buddy pages.
-	 */
-	if (!get_hwpoison_page(p))
-		return 0;
 
 	if (!hwpoison_filter_enable)
 		goto inject;
@@ -40,23 +35,20 @@ static int hwpoison_inject(void *data, u64 val)
 	 * This implies unable to support non-LRU pages.
 	 */
 	if (!PageLRU(hpage) && !PageHuge(p))
-		goto put_out;
+		return 0;
 
 	/*
-	 * do a racy check with elevated page count, to make sure PG_hwpoison
-	 * will only be set for the targeted owner (or on a free page).
+	 * do a racy check to make sure PG_hwpoison will only be set for
+	 * the targeted owner (or on a free page).
 	 * memory_failure() will redo the check reliably inside page lock.
 	 */
 	err = hwpoison_filter(hpage);
 	if (err)
-		goto put_out;
+		return 0;
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
-	return memory_failure(pfn, MF_COUNT_INCREASED);
-put_out:
-	put_hwpoison_page(p);
-	return 0;
+	return memory_failure(pfn, 0);
 }
 
 static int hwpoison_unpoison(void *data, u64 val)
-- 
2.12.3

