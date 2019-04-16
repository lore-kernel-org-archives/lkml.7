Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47BEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E0D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfDPRzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:55:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57682 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbfDPRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHD-0005ZT-KW; Tue, 16 Apr 2019 17:53:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 50/62] afs: switch to use of ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:28 +0100
Message-Id: <20190416175340.21068-50-viro@ZenIV.linux.org.uk>
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

debugging printks left in ->destroy_inode() and so's the
update of inode count; we could take the latter to RCU-delayed
part (would take only moving the check on module exit past
rcu_barrier() there), but debugging output ought to either
stay where it is or go into ->evict_inode()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 5adf012b8e27..bab89763119b 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -33,6 +33,7 @@ static void afs_i_init_once(void *foo);
 static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
+static void afs_free_inode(struct inode *inode);
 static int afs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int afs_show_devname(struct seq_file *m, struct dentry *root);
 static int afs_show_options(struct seq_file *m, struct dentry *root);
@@ -56,6 +57,7 @@ static const struct super_operations afs_super_ops = {
 	.alloc_inode	= afs_alloc_inode,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
+	.free_inode	= afs_free_inode,
 	.evict_inode	= afs_evict_inode,
 	.show_devname	= afs_show_devname,
 	.show_options	= afs_show_options,
@@ -660,11 +662,9 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 	return &vnode->vfs_inode;
 }
 
-static void afs_i_callback(struct rcu_head *head)
+static void afs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	struct afs_vnode *vnode = AFS_FS_I(inode);
-	kmem_cache_free(afs_inode_cachep, vnode);
+	kmem_cache_free(afs_inode_cachep, AFS_FS_I(inode));
 }
 
 /*
@@ -680,7 +680,6 @@ static void afs_destroy_inode(struct inode *inode)
 
 	ASSERTCMP(vnode->cb_interest, ==, NULL);
 
-	call_rcu(&inode->i_rcu, afs_i_callback);
 	atomic_dec(&afs_count_active_inodes);
 }
 
-- 
2.11.0

