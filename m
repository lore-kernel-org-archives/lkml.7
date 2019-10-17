Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABCEFA3736
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92B721848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440192AbfJQOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:21:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:40578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440145AbfJQOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:21:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F446B48D;
        Thu, 17 Oct 2019 14:21:37 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 13/16] mm,hwpoison: Take pages off the buddy when hard-offlining
Date:   Thu, 17 Oct 2019 16:21:20 +0200
Message-Id: <20191017142123.24245-14-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to do as we do now for soft-offline, and take poisoned pages
off the buddy allocator.
Otherwise we could face [1] as well.

[1] https://lore.kernel.org/linux-mm/20190826104144.GA7849@linux/T/#u

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 48eb314598e0..3d491c0d3f91 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -791,6 +791,14 @@ static int me_swapcache_clean(struct page *p, unsigned long pfn)
 		return MF_FAILED;
 }
 
+static int me_huge_free_page(struct page *p)
+{
+	if (page_handle_poison(p, true, false))
+		return MF_RECOVERED;
+	else
+		return MF_FAILED;
+}
+
 /*
  * Huge pages. Needs work.
  * Issues:
@@ -818,8 +826,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 		 */
 		if (PageAnon(hpage))
 			put_page(hpage);
-		dissolve_free_huge_page(p);
-		res = MF_RECOVERED;
+		res = me_huge_free_page(p);
 		lock_page(hpage);
 	}
 
@@ -1145,8 +1152,10 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 			}
 		}
 		unlock_page(head);
-		dissolve_free_huge_page(p);
-		action_result(pfn, MF_MSG_FREE_HUGE, MF_DELAYED);
+		res = me_huge_free_page(p);
+		if (res == MF_FAILED)
+			num_poisoned_pages_dec();
+		action_result(pfn, MF_MSG_FREE_HUGE, res);
 		return 0;
 	}
 
@@ -1307,6 +1316,12 @@ int memory_failure(unsigned long pfn, int flags)
 
 	if (PageHuge(p))
 		return memory_failure_hugetlb(pfn, flags);
+
+	if (is_free_buddy_page(p) && page_handle_poison(p, true, false)) {
+		action_result(pfn, MF_MSG_BUDDY, MF_RECOVERED);
+		return 0;
+	}
+
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
@@ -1328,10 +1343,10 @@ int memory_failure(unsigned long pfn, int flags)
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
 	if (!get_hwpoison_page(p)) {
-		if (is_free_buddy_page(p)) {
-			action_result(pfn, MF_MSG_BUDDY, MF_DELAYED);
+		if (is_free_buddy_page(p) && page_handle_poison(p, true, false)) {
+			action_result(pfn, MF_MSG_BUDDY, MF_RECOVERED);
 			return 0;
-		} else {
+		} else if(!is_free_buddy_page(p)) {
 			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
 			return -EBUSY;
 		}
@@ -1354,8 +1369,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	shake_page(p, 0);
 	/* shake_page could have turned it free. */
-	if (!PageLRU(p) && is_free_buddy_page(p)) {
-		action_result(pfn, MF_MSG_BUDDY_2ND, MF_DELAYED);
+	if (!PageLRU(p) && is_free_buddy_page(p) && page_handle_poison(p, true, false)) {
+		action_result(pfn, MF_MSG_BUDDY_2ND, MF_RECOVERED);
 		return 0;
 	}
 
-- 
2.12.3

