Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35ADC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C330B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfCFGas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:30:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729028AbfCFGap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:45 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0DC2DC7C2CF2F8179E75;
        Wed,  6 Mar 2019 14:30:42 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Mar 2019 14:30:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to add refcount once page is tagged PG_private
Date:   Wed, 6 Mar 2019 14:30:28 +0800
Message-ID: <20190306063028.61455-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Gao Xiang reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202749

f2fs may skip pageout() due to incorrect page reference count.

The problem here is that MM defined the rule [1] very clearly that
once page was set with PG_private flag, we should increment the
refcount in that page, also main flows like pageout(), migrate_page()
will assume there is one additional page reference count if
page_has_private() returns true.

But currently, f2fs won't add/del refcount when changing PG_private
flag. Anyway, f2fs should follow MM's rule to make MM's related flows
running as expected.

[1] https://lore.kernel.org/lkml/2b19b3c4-2bc4-15fa-15cc-27a13e5c7af1@aol.com/

Reported-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- introduce generic function f2fs_{set,clear}_page_private() to wrap related
operations as Jaegeuk suggested.
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       | 23 ++++++++++-------------
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       | 19 +++++++++++++++++++
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/segment.c    |  8 +++-----
 6 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index c65a1e8e1e95..9ce38a0ad2fe 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -406,7 +406,7 @@ static int f2fs_set_meta_page_dirty(struct page *page)
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
-		SetPagePrivate(page);
+		f2fs_set_page_private(page);
 		f2fs_trace_pid(page);
 		return 1;
 	}
@@ -957,7 +957,7 @@ void f2fs_update_dirty_page(struct inode *inode, struct page *page)
 	inode_inc_dirty_pages(inode);
 	spin_unlock(&sbi->inode_lock[type]);
 
-	SetPagePrivate(page);
+	f2fs_set_page_private(page);
 	f2fs_trace_pid(page);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3f3becd46362..14ee7dd0c6bc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2715,8 +2715,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return f2fs_drop_inmem_page(inode, page);
 
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	f2fs_clear_page_private(page);
 }
 
 int f2fs_release_page(struct page *page, gfp_t wait)
@@ -2730,8 +2729,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 		return 0;
 
 	clear_cold_data(page);
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	f2fs_clear_page_private(page);
 	return 1;
 }
 
@@ -2799,12 +2797,8 @@ int f2fs_migrate_page(struct address_space *mapping,
 			return -EAGAIN;
 	}
 
-	/*
-	 * A reference is expected if PagePrivate set when move mapping,
-	 * however F2FS breaks this for maintaining dirty page counts when
-	 * truncating pages. So here adjusting the 'extra_count' make it work.
-	 */
-	extra_count = (atomic_written ? 1 : 0) - page_has_private(page);
+	/* one extra reference was held for atomic_write page */
+	extra_count = atomic_written ? 1 : 0;
 	rc = migrate_page_move_mapping(mapping, newpage,
 				page, mode, extra_count);
 	if (rc != MIGRATEPAGE_SUCCESS) {
@@ -2825,9 +2819,12 @@ int f2fs_migrate_page(struct address_space *mapping,
 		get_page(newpage);
 	}
 
-	if (PagePrivate(page))
-		SetPagePrivate(newpage);
-	set_page_private(newpage, page_private(page));
+	if (PagePrivate(page)) {
+		f2fs_set_page_private(newpage);
+		set_page_private(newpage, page_private(page));
+
+		f2fs_clear_page_private(page);
+	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 103f3686a045..fb647e58edb5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -728,7 +728,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
 		f2fs_clear_page_cache_dirty_tag(page);
 		clear_page_dirty_for_io(page);
-		ClearPagePrivate(page);
+		f2fs_clear_page_private(page);
 		ClearPageUptodate(page);
 		clear_cold_data(page);
 		inode_dec_dirty_pages(dir);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3007759dd2dd..883354777d25 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2835,6 +2835,25 @@ static inline bool is_valid_data_blkaddr(struct f2fs_sb_info *sbi,
 	return true;
 }
 
+static inline void f2fs_set_page_private(struct page *page)
+{
+	if (PagePrivate(page))
+		return;
+
+	get_page(page);
+	SetPagePrivate(page);
+}
+
+static inline void f2fs_clear_page_private(struct page *page)
+{
+	if (!PagePrivate(page))
+		return;
+
+	set_page_private(page, 0);
+	ClearPagePrivate(page);
+	f2fs_put_page(page, 0);
+}
+
 /*
  * file.c
  */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f6ff84e29749..cf1f3dc79671 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1961,7 +1961,7 @@ static int f2fs_set_node_page_dirty(struct page *page)
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
-		SetPagePrivate(page);
+		f2fs_set_page_private(page);
 		f2fs_trace_pid(page);
 		return 1;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e730c334abba..42cc6fecdc36 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -191,8 +191,8 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
 
 	f2fs_trace_pid(page);
 
+	f2fs_set_page_private(page);
 	set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
-	SetPagePrivate(page);
 
 	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
 
@@ -280,8 +280,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 			ClearPageUptodate(page);
 			clear_cold_data(page);
 		}
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
+		f2fs_clear_page_private(page);
 		f2fs_put_page(page, 1);
 
 		list_del(&cur->list);
@@ -370,8 +369,7 @@ void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
 	kmem_cache_free(inmem_entry_slab, cur);
 
 	ClearPageUptodate(page);
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	f2fs_clear_page_private(page);
 	f2fs_put_page(page, 0);
 
 	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
-- 
2.18.0.rc1

