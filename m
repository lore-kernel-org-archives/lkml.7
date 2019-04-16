Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37FFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF962087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfDPRy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57702 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbfDPRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHE-0005Zz-C5; Tue, 16 Apr 2019 17:53:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 55/62] fuse: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:33 +0100
Message-Id: <20190416175340.21068-55-viro@ZenIV.linux.org.uk>
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

fuse_destroy_inode() is gone - sanity checks that need the stack
trace of the caller get moved into ->evict_inode(), the rest joins
the RCU-delayed part which becomes ->free_inode().

While we are at it, don't just pass the address of what happens
to be the first member of structure to kmem_cache_free() -
get_fuse_inode() is there for purpose and it gives the proper
container_of() use.  No behaviour change, but verifying correctness
is easier that way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/inode.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ec5d9953dfb6..f485d09d14df 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -107,34 +107,30 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	return inode;
 }
 
-static void fuse_i_callback(struct rcu_head *head)
-{
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	kmem_cache_free(fuse_inode_cachep, inode);
-}
-
-static void fuse_destroy_inode(struct inode *inode)
+static void fuse_free_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	if (S_ISREG(inode->i_mode) && !is_bad_inode(inode)) {
-		WARN_ON(!list_empty(&fi->write_files));
-		WARN_ON(!list_empty(&fi->queued_writes));
-	}
+
 	mutex_destroy(&fi->mutex);
 	kfree(fi->forget);
-	call_rcu(&inode->i_rcu, fuse_i_callback);
+	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
 static void fuse_evict_inode(struct inode *inode)
 {
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
 		struct fuse_conn *fc = get_fuse_conn(inode);
-		struct fuse_inode *fi = get_fuse_inode(inode);
 		fuse_queue_forget(fc, fi->forget, fi->nodeid, fi->nlookup);
 		fi->forget = NULL;
 	}
+	if (S_ISREG(inode->i_mode) && !is_bad_inode(inode)) {
+		WARN_ON(!list_empty(&fi->write_files));
+		WARN_ON(!list_empty(&fi->queued_writes));
+	}
 }
 
 static int fuse_remount_fs(struct super_block *sb, int *flags, char *data)
@@ -814,7 +810,7 @@ static const struct export_operations fuse_export_operations = {
 
 static const struct super_operations fuse_super_operations = {
 	.alloc_inode    = fuse_alloc_inode,
-	.destroy_inode  = fuse_destroy_inode,
+	.free_inode     = fuse_free_inode,
 	.evict_inode	= fuse_evict_inode,
 	.write_inode	= fuse_write_inode,
 	.drop_inode	= generic_delete_inode,
-- 
2.11.0

