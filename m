Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F7EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D5D206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfDPR5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:57:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57594 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbfDPRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHA-0005XB-Do; Tue, 16 Apr 2019 17:53:44 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 28/62] nilfs2: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:06 +0100
Message-Id: <20190416175340.21068-28-viro@ZenIV.linux.org.uk>
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

kill an extern that went stale 9 years ago, while we are at it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nilfs2/nilfs.h |  2 --
 fs/nilfs2/super.c | 11 ++---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index a2f247b6a209..42395ba52da6 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -252,7 +252,6 @@ int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *, struct nilfs_argv *,
 void nilfs_inode_add_blocks(struct inode *inode, int n);
 void nilfs_inode_sub_blocks(struct inode *inode, int n);
 extern struct inode *nilfs_new_inode(struct inode *, umode_t);
-extern void nilfs_free_inode(struct inode *);
 extern int nilfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
 extern void nilfs_set_inode_flags(struct inode *);
 extern int nilfs_read_inode_common(struct inode *, struct nilfs_inode *);
@@ -289,7 +288,6 @@ static inline int nilfs_mark_inode_dirty_sync(struct inode *inode)
 
 /* super.c */
 extern struct inode *nilfs_alloc_inode(struct super_block *);
-extern void nilfs_destroy_inode(struct inode *);
 
 extern __printf(3, 4)
 void __nilfs_msg(struct super_block *sb, const char *level,
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 26290aa1023f..5729ee86da9a 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -155,21 +155,14 @@ struct inode *nilfs_alloc_inode(struct super_block *sb)
 	return &ii->vfs_inode;
 }
 
-static void nilfs_i_callback(struct rcu_head *head)
+static void nilfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-
 	if (nilfs_is_metadata_file_inode(inode))
 		nilfs_mdt_destroy(inode);
 
 	kmem_cache_free(nilfs_inode_cachep, NILFS_I(inode));
 }
 
-void nilfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, nilfs_i_callback);
-}
-
 static int nilfs_sync_super(struct super_block *sb, int flag)
 {
 	struct the_nilfs *nilfs = sb->s_fs_info;
@@ -686,7 +679,7 @@ static int nilfs_show_options(struct seq_file *seq, struct dentry *dentry)
 
 static const struct super_operations nilfs_sops = {
 	.alloc_inode    = nilfs_alloc_inode,
-	.destroy_inode  = nilfs_destroy_inode,
+	.free_inode     = nilfs_free_inode,
 	.dirty_inode    = nilfs_dirty_inode,
 	.evict_inode    = nilfs_evict_inode,
 	.put_super      = nilfs_put_super,
-- 
2.11.0

