Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C506DFA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1C21D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502711AbfJQOVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:21:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440153AbfJQOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A3DDB488;
        Thu, 17 Oct 2019 14:21:38 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 15/16] mm/hwpoison-inject: Rip off duplicated checks
Date:   Thu, 17 Oct 2019 16:21:22 +0200
Message-Id: <20191017142123.24245-16-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_failure() already performs the same checks, so leave it
to the main routine.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hwpoison-inject.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 0c8cdb80fd7d..fdcca3df4283 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -14,49 +14,22 @@ static struct dentry *hwpoison_dir;
 static int hwpoison_inject(void *data, u64 val)
 {
 	unsigned long pfn = val;
-	struct page *p;
-	struct page *hpage;
-	int err;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!pfn_valid(pfn))
-		return -ENXIO;
-
-	p = pfn_to_page(pfn);
-	hpage = compound_head(p);
-
-	if (!hwpoison_filter_enable)
-		goto inject;
-
-	shake_page(hpage, 0);
-	/*
-	 * This implies unable to support non-LRU pages.
-	 */
-	if (!PageLRU(hpage) && !PageHuge(p))
-		return 0;
-
-	/*
-	 * do a racy check to make sure PG_hwpoison will only be set for
-	 * the targeted owner (or on a free page).
-	 * memory_failure() will redo the check reliably inside page lock.
-	 */
-	err = hwpoison_filter(hpage);
-	if (err)
-		return 0;
-
-inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
 	return memory_failure(pfn, 0);
 }
 
 static int hwpoison_unpoison(void *data, u64 val)
 {
+	unsigned long pfn = val;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	return unpoison_memory(val);
+	return unpoison_memory(pfn);
 }
 
 DEFINE_SIMPLE_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
-- 
2.12.3

