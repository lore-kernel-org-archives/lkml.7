Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45269C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2439421906
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfJGJSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:18:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfJGJSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:18:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20F32AC28;
        Mon,  7 Oct 2019 09:18:34 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 3/3] mm, page_owner: rename flag indicating that page is allocated
Date:   Mon,  7 Oct 2019 11:18:08 +0200
Message-Id: <20191007091808.7096-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007091808.7096-1-vbabka@suse.cz>
References: <20191007091808.7096-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 37389167a281 ("mm, page_owner: keep owner info when freeing the page")
has introduced a flag PAGE_EXT_OWNER_ACTIVE to indicate that page is tracked as
being allocated.  Kirill suggested naming it PAGE_EXT_OWNER_ALLOCATED to make it
more clear, as "active is somewhat loaded term for a page".

Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/page_ext.h |  2 +-
 mm/page_owner.c          | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 5e856512bafb..cfce186f0c4e 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -18,7 +18,7 @@ struct page_ext_operations {
 
 enum page_ext_flags {
 	PAGE_EXT_OWNER,
-	PAGE_EXT_OWNER_ACTIVE,
+	PAGE_EXT_OWNER_ALLOCATED,
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
 	PAGE_EXT_YOUNG,
 	PAGE_EXT_IDLE,
diff --git a/mm/page_owner.c b/mm/page_owner.c
index de1916ac3e24..e327bcd0380e 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -152,7 +152,7 @@ void __reset_page_owner(struct page *page, unsigned int order)
 	if (unlikely(!page_ext))
 		return;
 	for (i = 0; i < (1 << order); i++) {
-		__clear_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
+		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 		page_owner = get_page_owner(page_ext);
 		page_owner->free_handle = handle;
 		page_ext = page_ext_next(page_ext);
@@ -173,7 +173,7 @@ static inline void __set_page_owner_handle(struct page *page,
 		page_owner->gfp_mask = gfp_mask;
 		page_owner->last_migrate_reason = -1;
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
-		__set_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
+		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 
 		page_ext = page_ext_next(page_ext);
 	}
@@ -247,7 +247,7 @@ void __copy_page_owner(struct page *oldpage, struct page *newpage)
 	 * the new page, which will be freed.
 	 */
 	__set_bit(PAGE_EXT_OWNER, &new_ext->flags);
-	__set_bit(PAGE_EXT_OWNER_ACTIVE, &new_ext->flags);
+	__set_bit(PAGE_EXT_OWNER_ALLOCATED, &new_ext->flags);
 }
 
 void pagetypeinfo_showmixedcount_print(struct seq_file *m,
@@ -307,7 +307,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 			if (unlikely(!page_ext))
 				continue;
 
-			if (!test_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags))
+			if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
 				continue;
 
 			page_owner = get_page_owner(page_ext);
@@ -422,7 +422,7 @@ void __dump_page_owner(struct page *page)
 		return;
 	}
 
-	if (test_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags))
+	if (test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
 		pr_alert("page_owner tracks the page as allocated\n");
 	else
 		pr_alert("page_owner tracks the page as freed\n");
@@ -512,7 +512,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		 * Although we do have the info about past allocation of free
 		 * pages, it's not relevant for current memory usage.
 		 */
-		if (!test_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags))
+		if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
 			continue;
 
 		page_owner = get_page_owner(page_ext);
-- 
2.23.0

