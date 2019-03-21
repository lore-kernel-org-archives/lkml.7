Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E66C10F0D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E715218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfCUUDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:03:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:5164 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbfCUUC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:02:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 13:02:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="309246237"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2019 13:02:56 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/5] mm: Split handling old page for migration
Date:   Thu, 21 Mar 2019 14:01:54 -0600
Message-Id: <20190321200157.29678-3-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190321200157.29678-1-keith.busch@intel.com>
References: <20190321200157.29678-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor unmap_and_move() handling for the new page into a separate
function from locking and preparing the old page.

No functional change here: this is just making it easier to reuse this
part of the page migration from contexts that already locked the old page.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 mm/migrate.c | 115 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 61 insertions(+), 54 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ac6f4939bb59..705b320d4b35 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1000,57 +1000,14 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 	return rc;
 }
 
-static int __unmap_and_move(struct page *page, struct page *newpage,
-				int force, enum migrate_mode mode)
+static int __unmap_and_move_locked(struct page *page, struct page *newpage,
+				   enum migrate_mode mode)
 {
 	int rc = -EAGAIN;
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(page);
 
-	if (!trylock_page(page)) {
-		if (!force || mode == MIGRATE_ASYNC)
-			goto out;
-
-		/*
-		 * It's not safe for direct compaction to call lock_page.
-		 * For example, during page readahead pages are added locked
-		 * to the LRU. Later, when the IO completes the pages are
-		 * marked uptodate and unlocked. However, the queueing
-		 * could be merging multiple pages for one bio (e.g.
-		 * mpage_readpages). If an allocation happens for the
-		 * second or third page, the process can end up locking
-		 * the same page twice and deadlocking. Rather than
-		 * trying to be clever about what pages can be locked,
-		 * avoid the use of lock_page for direct compaction
-		 * altogether.
-		 */
-		if (current->flags & PF_MEMALLOC)
-			goto out;
-
-		lock_page(page);
-	}
-
-	if (PageWriteback(page)) {
-		/*
-		 * Only in the case of a full synchronous migration is it
-		 * necessary to wait for PageWriteback. In the async case,
-		 * the retry loop is too short and in the sync-light case,
-		 * the overhead of stalling is too much
-		 */
-		switch (mode) {
-		case MIGRATE_SYNC:
-		case MIGRATE_SYNC_NO_COPY:
-			break;
-		default:
-			rc = -EBUSY;
-			goto out_unlock;
-		}
-		if (!force)
-			goto out_unlock;
-		wait_on_page_writeback(page);
-	}
-
 	/*
 	 * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
 	 * we cannot notice that anon_vma is freed while we migrates a page.
@@ -1077,11 +1034,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	 * This is much like races on refcount of oldpage: just don't BUG().
 	 */
 	if (unlikely(!trylock_page(newpage)))
-		goto out_unlock;
+		goto out;
 
 	if (unlikely(!is_lru)) {
 		rc = move_to_new_page(newpage, page, mode);
-		goto out_unlock_both;
+		goto out_unlock;
 	}
 
 	/*
@@ -1100,7 +1057,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		VM_BUG_ON_PAGE(PageAnon(page), page);
 		if (page_has_private(page)) {
 			try_to_free_buffers(page);
-			goto out_unlock_both;
+			goto out_unlock;
 		}
 	} else if (page_mapped(page)) {
 		/* Establish migration ptes */
@@ -1110,22 +1067,19 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
 		page_was_mapped = 1;
 	}
-
 	if (!page_mapped(page))
 		rc = move_to_new_page(newpage, page, mode);
 
 	if (page_was_mapped)
 		remove_migration_ptes(page,
 			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false);
-
-out_unlock_both:
-	unlock_page(newpage);
 out_unlock:
+	unlock_page(newpage);
 	/* Drop an anon_vma reference if we took one */
+out:
 	if (anon_vma)
 		put_anon_vma(anon_vma);
-	unlock_page(page);
-out:
+
 	/*
 	 * If migration is successful, decrease refcount of the newpage
 	 * which will not free the page because new page owner increased
@@ -1141,7 +1095,60 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		else
 			putback_lru_page(newpage);
 	}
+	return rc;
+}
+
+static int __unmap_and_move(struct page *page, struct page *newpage,
+				int force, enum migrate_mode mode)
+{
+	int rc = -EAGAIN;
+
+	if (!trylock_page(page)) {
+		if (!force || mode == MIGRATE_ASYNC)
+			goto out;
+
+		/*
+		 * It's not safe for direct compaction to call lock_page.
+		 * For example, during page readahead pages are added locked
+		 * to the LRU. Later, when the IO completes the pages are
+		 * marked uptodate and unlocked. However, the queueing
+		 * could be merging multiple pages for one bio (e.g.
+		 * mpage_readpages). If an allocation happens for the
+		 * second or third page, the process can end up locking
+		 * the same page twice and deadlocking. Rather than
+		 * trying to be clever about what pages can be locked,
+		 * avoid the use of lock_page for direct compaction
+		 * altogether.
+		 */
+		if (current->flags & PF_MEMALLOC)
+			goto out;
+
+		lock_page(page);
+	}
 
+	if (PageWriteback(page)) {
+		/*
+		 * Only in the case of a full synchronous migration is it
+		 * necessary to wait for PageWriteback. In the async case,
+		 * the retry loop is too short and in the sync-light case,
+		 * the overhead of stalling is too much
+		 */
+		switch (mode) {
+		case MIGRATE_SYNC:
+		case MIGRATE_SYNC_NO_COPY:
+			break;
+		default:
+			rc = -EBUSY;
+			goto out_unlock;
+		}
+		if (!force)
+			goto out_unlock;
+		wait_on_page_writeback(page);
+	}
+	rc = __unmap_and_move_locked(page, newpage, mode);
+out_unlock:
+	unlock_page(page);
+out:
 	return rc;
 }
 
-- 
2.14.4

