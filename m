Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FB020989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfEHVJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:09:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:50733 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfEHVJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:09:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 14:09:46 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2019 14:09:46 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] mm: migrate: remove unused mode argument
Date:   Wed,  8 May 2019 15:03:01 -0600
Message-Id: <20190508210301.8472-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migrate_page_move_mapping() doesn't use the mode argument. Remove it
and update callers accordingly.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 fs/aio.c                | 2 +-
 fs/f2fs/data.c          | 2 +-
 fs/iomap.c              | 2 +-
 fs/ubifs/file.c         | 2 +-
 include/linux/migrate.h | 3 +--
 mm/migrate.c            | 7 +++----
 6 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3490d1fa0e16..1a1568861b4e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -425,7 +425,7 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 	BUG_ON(PageWriteback(old));
 	get_page(new);
 
-	rc = migrate_page_move_mapping(mapping, new, old, mode, 1);
+	rc = migrate_page_move_mapping(mapping, new, old, 1);
 	if (rc != MIGRATEPAGE_SUCCESS) {
 		put_page(new);
 		goto out_unlock;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9727944139f2..0eb7a8cd3138 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2801,7 +2801,7 @@ int f2fs_migrate_page(struct address_space *mapping,
 	/* one extra reference was held for atomic_write page */
 	extra_count = atomic_written ? 1 : 0;
 	rc = migrate_page_move_mapping(mapping, newpage,
-				page, mode, extra_count);
+				page, extra_count);
 	if (rc != MIGRATEPAGE_SUCCESS) {
 		if (atomic_written)
 			mutex_unlock(&fi->inmem_lock);
diff --git a/fs/iomap.c b/fs/iomap.c
index abdd18e404f8..f26f4846a00b 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -571,7 +571,7 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 {
 	int ret;
 
-	ret = migrate_page_move_mapping(mapping, newpage, page, mode, 0);
+	ret = migrate_page_move_mapping(mapping, newpage, page, 0);
 	if (ret != MIGRATEPAGE_SUCCESS)
 		return ret;
 
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5d2ffb1a45fc..d906ebc24049 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1481,7 +1481,7 @@ static int ubifs_migrate_page(struct address_space *mapping,
 {
 	int rc;
 
-	rc = migrate_page_move_mapping(mapping, newpage, page, mode, 0);
+	rc = migrate_page_move_mapping(mapping, newpage, page, 0);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index e13d9bf2f9a5..7f04754c7f2b 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -77,8 +77,7 @@ extern void migrate_page_copy(struct page *newpage, struct page *page);
 extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
-		struct page *newpage, struct page *page, enum migrate_mode mode,
-		int extra_count);
+		struct page *newpage, struct page *page, int extra_count);
 #else
 
 static inline void putback_movable_pages(struct list_head *l) {}
diff --git a/mm/migrate.c b/mm/migrate.c
index 663a5449367a..85f46bfcf141 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -397,8 +397,7 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
  * 3 for pages with a mapping and PagePrivate/PagePrivate2 set.
  */
 int migrate_page_move_mapping(struct address_space *mapping,
-		struct page *newpage, struct page *page, enum migrate_mode mode,
-		int extra_count)
+		struct page *newpage, struct page *page, int extra_count)
 {
 	XA_STATE(xas, &mapping->i_pages, page_index(page));
 	struct zone *oldzone, *newzone;
@@ -684,7 +683,7 @@ int migrate_page(struct address_space *mapping,
 
 	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
 
-	rc = migrate_page_move_mapping(mapping, newpage, page, mode, 0);
+	rc = migrate_page_move_mapping(mapping, newpage, page, 0);
 
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
@@ -783,7 +782,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
 		}
 	}
 
-	rc = migrate_page_move_mapping(mapping, newpage, page, mode, 0);
+	rc = migrate_page_move_mapping(mapping, newpage, page, 0);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		goto unlock_buffers;
 
-- 
2.14.4

