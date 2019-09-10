Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22745C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B442089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393764AbfIJKbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:31:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:59420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392448AbfIJKax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:30:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02ADFB008;
        Tue, 10 Sep 2019 10:30:50 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 10/10] mm,hwpoison: Use hugetlb_replace_page to replace free hugetlb pages
Date:   Tue, 10 Sep 2019 12:30:16 +0200
Message-Id: <20190910103016.14290-11-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190910103016.14290-1-osalvador@suse.de>
References: <20190910103016.14290-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When soft offlining a free hugtlb, try first to allocate a new hugetlb
to the pool and pass the old state to the new one by move_hugetlb_state().
Either we succeed or not, we dissolve the poisoned hugetlb page.

Worst-scenario case is that we cannot allocate a new fresh hugetlb page
as a replacement.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c        | 16 ++++++++++++++++
 mm/memory-failure.c | 34 ++++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 139e1c05c9a1..d0844aec7531 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5154,3 +5154,19 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 		spin_unlock(&hugetlb_lock);
 	}
 }
+
+#ifdef CONFIG_MEMORY_FAILURE
+int hugetlb_replace_page(struct page *page, int reason)
+{
+	int nid = page_to_nid(page);
+	struct hstate *h = page_hstate(page);
+	struct page *new_page;
+
+	new_page = alloc_huge_page_nodemask(h, nid, &node_states[N_MEMORY]);
+	if (!new_page)
+		return -ENOMEM;
+
+	move_hugetlb_state(page, new_page, reason);
+	return 0;
+}
+#endif
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 03f07015a106..fe73fe19c6e9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -79,6 +79,7 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_flags_mask);
 EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
 
 extern bool take_page_off_buddy(struct page *page);
+extern int hugetlb_replace_page(struct page *page, int reason);
 
 static bool page_set_poison(struct page *page)
 {
@@ -1804,16 +1805,37 @@ static int soft_offline_in_use_page(struct page *page)
 	return __soft_offline_page(page);
 }
 
+static int soft_offline_free_huge_page(struct page *page)
+{
+	struct page *hpage = compound_head(page);
+
+	/*
+	 * Try to add a new hugetlb page to the pool
+	 */
+	if (hugetlb_replace_page(hpage, MR_MEMORY_FAILURE))
+		return -EBUSY;
+
+	/*
+	 * Remove old hugetlb from the pool
+	 */
+	if (!page_set_poison(hpage))
+		return -EBUSY;
+
+	return 0;
+}
+
 static int soft_offline_free_page(struct page *page)
 {
-	int rc = dissolve_free_huge_page(page);
+	int rc = -EBUSY;
 
-	if (!rc) {
-		if (take_page_off_buddy(page))
+	if (PageHuge(page))
+		rc = soft_offline_free_huge_page(page);
+	else
+		if (take_page_off_buddy(page)) {
 			page_set_poison(page);
-		else
-			rc = -EBUSY;
-	}
+			rc = 0;
+		}
+
 	return rc;
 }
 
-- 
2.12.3

