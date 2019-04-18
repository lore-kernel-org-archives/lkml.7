Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAA7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7264A214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611190;
	bh=5ZmvG3bRoN2B0+9M9bgfjB4bPga69aRBeLvRE+VuVDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UfSOpktf41bqQecmAWVkMHvlvbivUW3jYI6Ln791qFzvHFNt2eF9FOdGyUhqW+R3K
	 Yvp1ObtkiGVLezYepHgGSXPYPY+1pxbvFVsT2OQ8TD6TKdy7ZCsDQnUF7RVgxeBaSn
	 hT0ZH4zBMpkNdhi8/8ryy2RRx9TcVlUIEVX832zE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392013AbfDRSNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391819AbfDRSNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:13:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85FD1206B6;
        Thu, 18 Apr 2019 18:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611184;
        bh=5ZmvG3bRoN2B0+9M9bgfjB4bPga69aRBeLvRE+VuVDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lC75xoGcmc0xcCdJK9MVAVv6xJuyJCBRNUJZJaG6MviWt3VQ1AWDiyUDDgY2C7J3y
         ONuzZ8bN+2NFp/P+TZZMJCPMkub000oRVCRKvOq+nWHzu31KbpuB5xLg012RKg4NsZ
         J7ErVczY6ZMXr6hFc3hexuW1Een5cTgFhlPqBeOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 90/93] f2fs: fix to add refcount once page is tagged PG_private
Date:   Thu, 18 Apr 2019 19:58:08 +0200
Message-Id: <20190418160445.835859903@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 240a59156d9bcfabceddb66be449e7b32fb5dc4a ]

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       | 21 ++++++++-------------
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       | 21 +++++++++++++++++++++
 fs/f2fs/node.c       |  2 +-
 fs/f2fs/segment.c    |  9 +++------
 6 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ccccf0ce2f06..7743fa83b895 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -406,7 +406,7 @@ static int f2fs_set_meta_page_dirty(struct page *page)
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
-		SetPagePrivate(page);
+		f2fs_set_page_private(page, 0);
 		f2fs_trace_pid(page);
 		return 1;
 	}
@@ -957,7 +957,7 @@ void f2fs_update_dirty_page(struct inode *inode, struct page *page)
 	inode_inc_dirty_pages(inode);
 	spin_unlock(&sbi->inode_lock[type]);
 
-	SetPagePrivate(page);
+	f2fs_set_page_private(page, 0);
 	f2fs_trace_pid(page);
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f91d8630c9a2..c99aab23efea 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2711,8 +2711,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return f2fs_drop_inmem_page(inode, page);
 
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	f2fs_clear_page_private(page);
 }
 
 int f2fs_release_page(struct page *page, gfp_t wait)
@@ -2726,8 +2725,7 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 		return 0;
 
 	clear_cold_data(page);
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	f2fs_clear_page_private(page);
 	return 1;
 }
 
@@ -2795,12 +2793,8 @@ int f2fs_migrate_page(struct address_space *mapping,
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
@@ -2821,9 +2815,10 @@ int f2fs_migrate_page(struct address_space *mapping,
 		get_page(newpage);
 	}
 
-	if (PagePrivate(page))
-		SetPagePrivate(newpage);
-	set_page_private(newpage, page_private(page));
+	if (PagePrivate(page)) {
+		f2fs_set_page_private(newpage, page_private(page));
+		f2fs_clear_page_private(page);
+	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
 		migrate_page_copy(newpage, page);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 50d0d36280fa..99a6063c2327 100644
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
index 279bc00489cc..6d9186a6528c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2825,6 +2825,27 @@ static inline bool is_valid_data_blkaddr(struct f2fs_sb_info *sbi,
 	return true;
 }
 
+static inline void f2fs_set_page_private(struct page *page,
+						unsigned long data)
+{
+	if (PagePrivate(page))
+		return;
+
+	get_page(page);
+	SetPagePrivate(page);
+	set_page_private(page, data);
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
index f6ff84e29749..3f99ab288695 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1961,7 +1961,7 @@ static int f2fs_set_node_page_dirty(struct page *page)
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
-		SetPagePrivate(page);
+		f2fs_set_page_private(page, 0);
 		f2fs_trace_pid(page);
 		return 1;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e1b1d390b329..b6c8b0696ef6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -191,8 +191,7 @@ void f2fs_register_inmem_page(struct inode *inode, struct page *page)
 
 	f2fs_trace_pid(page);
 
-	set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
-	SetPagePrivate(page);
+	f2fs_set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
 
 	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
 
@@ -280,8 +279,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 			ClearPageUptodate(page);
 			clear_cold_data(page);
 		}
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
+		f2fs_clear_page_private(page);
 		f2fs_put_page(page, 1);
 
 		list_del(&cur->list);
@@ -370,8 +368,7 @@ void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
 	kmem_cache_free(inmem_entry_slab, cur);
 
 	ClearPageUptodate(page);
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	f2fs_clear_page_private(page);
 	f2fs_put_page(page, 0);
 
 	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
-- 
2.19.1



