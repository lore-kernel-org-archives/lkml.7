Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7682087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfDPRzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:55:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57686 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfDPRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHD-0005Za-NF; Tue, 16 Apr 2019 17:53:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 51/62] btrfs: use ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:29 +0100
Message-Id: <20190416175340.21068-51-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

a lot of stuff remains in ->destroy_inode()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/ctree.h | 1 +
 fs/btrfs/inode.c | 7 ++-----
 fs/btrfs/super.c | 1 +
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b3642367a595..5260a9263d73 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3267,6 +3267,7 @@ void btrfs_evict_inode(struct inode *inode);
 int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc);
 struct inode *btrfs_alloc_inode(struct super_block *sb);
 void btrfs_destroy_inode(struct inode *inode);
+void btrfs_free_inode(struct inode *inode);
 int btrfs_drop_inode(struct inode *inode);
 int __init btrfs_init_cachep(void);
 void __cold btrfs_destroy_cachep(void);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 82fdda8ff5ab..aeb31c2dc14e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9206,9 +9206,8 @@ void btrfs_test_destroy_inode(struct inode *inode)
 }
 #endif
 
-static void btrfs_i_callback(struct rcu_head *head)
+void btrfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
 }
 
@@ -9234,7 +9233,7 @@ void btrfs_destroy_inode(struct inode *inode)
 	 * created.
 	 */
 	if (!root)
-		goto free;
+		return;
 
 	while (1) {
 		ordered = btrfs_lookup_first_ordered_extent(inode, (u64)-1);
@@ -9252,8 +9251,6 @@ void btrfs_destroy_inode(struct inode *inode)
 	btrfs_qgroup_check_reserved_leak(inode);
 	inode_tree_del(inode);
 	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
-free:
-	call_rcu(&inode->i_rcu, btrfs_i_callback);
 }
 
 int btrfs_drop_inode(struct inode *inode)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 120e4340792a..236f812091a3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2298,6 +2298,7 @@ static const struct super_operations btrfs_super_ops = {
 	.show_devname	= btrfs_show_devname,
 	.alloc_inode	= btrfs_alloc_inode,
 	.destroy_inode	= btrfs_destroy_inode,
+	.free_inode	= btrfs_free_inode,
 	.statfs		= btrfs_statfs,
 	.remount_fs	= btrfs_remount,
 	.freeze_fs	= btrfs_freeze,
-- 
2.11.0

