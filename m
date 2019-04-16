Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ECFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B362087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfDPRxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:53:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57506 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH7-0005Ut-CC; Tue, 16 Apr 2019 17:53:41 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 06/62] 9p: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:44 +0100
Message-Id: <20190416175340.21068-6-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/v9fs_vfs.h  |  2 +-
 fs/9p/vfs_inode.c | 10 ++--------
 fs/9p/vfs_super.c |  4 ++--
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index aaee1e6584e6..60cd4ba04afc 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -58,7 +58,7 @@ extern const struct file_operations v9fs_mmap_file_operations_dotl;
 extern struct kmem_cache *v9fs_inode_cache;
 
 struct inode *v9fs_alloc_inode(struct super_block *sb);
-void v9fs_destroy_inode(struct inode *inode);
+void v9fs_free_inode(struct inode *inode);
 struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 72b779bc0942..24050e866e64 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -253,21 +253,15 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 }
 
 /**
- * v9fs_destroy_inode - destroy an inode
+ * v9fs_free_inode - destroy an inode
  *
  */
 
-static void v9fs_i_callback(struct rcu_head *head)
+void v9fs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(v9fs_inode_cache, V9FS_I(inode));
 }
 
-void v9fs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, v9fs_i_callback);
-}
-
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev)
 {
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index d13d35cf69c0..67d1b965adcd 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -344,7 +344,7 @@ static int v9fs_write_inode_dotl(struct inode *inode,
 
 static const struct super_operations v9fs_super_ops = {
 	.alloc_inode = v9fs_alloc_inode,
-	.destroy_inode = v9fs_destroy_inode,
+	.free_inode = v9fs_free_inode,
 	.statfs = simple_statfs,
 	.evict_inode = v9fs_evict_inode,
 	.show_options = v9fs_show_options,
@@ -354,7 +354,7 @@ static const struct super_operations v9fs_super_ops = {
 
 static const struct super_operations v9fs_super_ops_dotl = {
 	.alloc_inode = v9fs_alloc_inode,
-	.destroy_inode = v9fs_destroy_inode,
+	.free_inode = v9fs_free_inode,
 	.statfs = v9fs_statfs,
 	.drop_inode = v9fs_drop_inode,
 	.evict_inode = v9fs_evict_inode,
-- 
2.11.0

