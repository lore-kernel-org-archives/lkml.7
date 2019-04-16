Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35F8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8632087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfDPR6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:58:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57590 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfDPRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHA-0005X5-9Z; Tue, 16 Apr 2019 17:53:44 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 27/62] nfs{,4}: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:05 +0100
Message-Id: <20190416175340.21068-27-viro@ZenIV.linux.org.uk>
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
 fs/nfs/inode.c     | 10 ++--------
 fs/nfs/internal.h  |  2 +-
 fs/nfs/nfs4super.c |  2 +-
 fs/nfs/super.c     |  2 +-
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 414a90d48493..f61af8307dc8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2055,17 +2055,11 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(nfs_alloc_inode);
 
-static void nfs_i_callback(struct rcu_head *head)
+void nfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(nfs_inode_cachep, NFS_I(inode));
 }
-
-void nfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, nfs_i_callback);
-}
-EXPORT_SYMBOL_GPL(nfs_destroy_inode);
+EXPORT_SYMBOL_GPL(nfs_free_inode);
 
 static inline void nfs4_init_once(struct nfs_inode *nfsi)
 {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index c7cf23ae6597..331a0504eaf8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -381,7 +381,7 @@ int nfs_check_flags(int);
 /* inode.c */
 extern struct workqueue_struct *nfsiod_workqueue;
 extern struct inode *nfs_alloc_inode(struct super_block *sb);
-extern void nfs_destroy_inode(struct inode *);
+extern void nfs_free_inode(struct inode *);
 extern int nfs_write_inode(struct inode *, struct writeback_control *);
 extern int nfs_drop_inode(struct inode *);
 extern void nfs_clear_inode(struct inode *);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 6fb7cb6b3f4b..689977e148cb 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -50,7 +50,7 @@ struct file_system_type nfs4_referral_fs_type = {
 
 static const struct super_operations nfs4_sops = {
 	.alloc_inode	= nfs_alloc_inode,
-	.destroy_inode	= nfs_destroy_inode,
+	.free_inode	= nfs_free_inode,
 	.write_inode	= nfs4_write_inode,
 	.drop_inode	= nfs_drop_inode,
 	.statfs		= nfs_statfs,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 23790c7b2289..aec4e2c4b02f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -309,7 +309,7 @@ struct file_system_type nfs_xdev_fs_type = {
 
 const struct super_operations nfs_sops = {
 	.alloc_inode	= nfs_alloc_inode,
-	.destroy_inode	= nfs_destroy_inode,
+	.free_inode	= nfs_free_inode,
 	.write_inode	= nfs_write_inode,
 	.drop_inode	= nfs_drop_inode,
 	.statfs		= nfs_statfs,
-- 
2.11.0

