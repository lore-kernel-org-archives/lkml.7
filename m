Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C116BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E78206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfDPSAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:00:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57494 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDPRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH6-0005Ua-Rz; Tue, 16 Apr 2019 17:53:40 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 03/62] new inode method: ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:41 +0100
Message-Id: <20190416175340.21068-3-viro@ZenIV.linux.org.uk>
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

A lot of ->destroy_inode() instances end with call_rcu() of a callback
that does RCU-delayed part of freeing.  Introduce a new method for
doing just that, with saner signature.

Rules:
->destroy_inode		->free_inode
	f			g		immediate call of f(),
						RCU-delayed call of g()
	f			NULL		immediate call of f(),
						no RCU-delayed calls
	NULL			g		RCU-delayed call of g()
	NULL			NULL		RCU-delayed default freeing

IOW, NULL ->free_inode gives the same behaviour as now.

Note that NULL, NULL is equivalent to NULL, free_inode_nonrcu; we could
mandate the latter form, but that would have very little benefit beyond
making rules a bit more symmetric.  It would break backwards compatibility,
require extra boilerplate and expected semantics for (NULL, NULL) pair
would have no use whatsoever...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/Locking |  2 ++
 Documentation/filesystems/porting | 17 ++++++++++++
 fs/inode.c                        | 54 +++++++++++++++++++++++----------------
 include/linux/fs.h                |  1 +
 4 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index efea228ccd8a..7b20c385cc02 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -118,6 +118,7 @@ set:		exclusive
 --------------------------- super_operations ---------------------------
 prototypes:
 	struct inode *(*alloc_inode)(struct super_block *sb);
+	void (*free_inode)(struct inode *);
 	void (*destroy_inode)(struct inode *);
 	void (*dirty_inode) (struct inode *, int flags);
 	int (*write_inode) (struct inode *, struct writeback_control *wbc);
@@ -139,6 +140,7 @@ locking rules:
 	All may block [not true, see below]
 			s_umount
 alloc_inode:
+free_inode:				called from RCU callback
 destroy_inode:
 dirty_inode:
 write_inode:
diff --git a/Documentation/filesystems/porting b/Documentation/filesystems/porting
index cf43bc4dbf31..9d80f9e0855e 100644
--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -638,3 +638,20 @@ in your dentry operations instead.
 	inode to d_splice_alias() will also do the right thing (equivalent of
 	d_add(dentry, NULL); return NULL;), so that kind of special cases
 	also doesn't need a separate treatment.
+--
+[strongly recommended]
+	take the RCU-delayed parts of ->destroy_inode() into a new method -
+	->free_inode().  If ->destroy_inode() becomes empty - all the better,
+	just get rid of it.  Synchronous work (e.g. the stuff that can't
+	be done from an RCU callback, or any WARN_ON() where we want the
+	stack trace) *might* be movable to ->evict_inode(); however,
+	that goes only for the things that are not needed to balance something
+	done by ->alloc_inode().  IOW, if it's cleaning up the stuff that
+	might have accumulated over the life of in-core inode, ->evict_inode()
+	might be a fit.
+
+	Rules for inode destruction:
+		* if ->destroy_inode() is non-NULL, it gets called
+		* if ->free_inode() is non-NULL, it gets scheduled by call_rcu()
+		* combination of NULL ->destroy_inode and NULL ->free_inode is
+		  treated as NULL/free_inode_nonrcu, to preserve the compatibility.
diff --git a/fs/inode.c b/fs/inode.c
index e9d97add2b36..fb45590d284e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -202,12 +202,28 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 }
 EXPORT_SYMBOL(inode_init_always);
 
+void free_inode_nonrcu(struct inode *inode)
+{
+	kmem_cache_free(inode_cachep, inode);
+}
+EXPORT_SYMBOL(free_inode_nonrcu);
+
+static void i_callback(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+	if (inode->i_sb->s_op->free_inode)
+		inode->i_sb->s_op->free_inode(inode);
+	else
+		free_inode_nonrcu(inode);
+}
+
 static struct inode *alloc_inode(struct super_block *sb)
 {
+	const struct super_operations *ops = sb->s_op;
 	struct inode *inode;
 
-	if (sb->s_op->alloc_inode)
-		inode = sb->s_op->alloc_inode(sb);
+	if (ops->alloc_inode)
+		inode = ops->alloc_inode(sb);
 	else
 		inode = kmem_cache_alloc(inode_cachep, GFP_KERNEL);
 
@@ -215,22 +231,18 @@ static struct inode *alloc_inode(struct super_block *sb)
 		return NULL;
 
 	if (unlikely(inode_init_always(sb, inode))) {
-		if (inode->i_sb->s_op->destroy_inode)
-			inode->i_sb->s_op->destroy_inode(inode);
-		else
-			kmem_cache_free(inode_cachep, inode);
+		if (ops->destroy_inode) {
+			ops->destroy_inode(inode);
+			if (!ops->free_inode)
+				return NULL;
+		}
+		i_callback(&inode->i_rcu);
 		return NULL;
 	}
 
 	return inode;
 }
 
-void free_inode_nonrcu(struct inode *inode)
-{
-	kmem_cache_free(inode_cachep, inode);
-}
-EXPORT_SYMBOL(free_inode_nonrcu);
-
 void __destroy_inode(struct inode *inode)
 {
 	BUG_ON(inode_has_buffers(inode));
@@ -253,20 +265,18 @@ void __destroy_inode(struct inode *inode)
 }
 EXPORT_SYMBOL(__destroy_inode);
 
-static void i_callback(struct rcu_head *head)
-{
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	kmem_cache_free(inode_cachep, inode);
-}
-
 static void destroy_inode(struct inode *inode)
 {
+	const struct super_operations *ops = inode->i_sb->s_op;
+
 	BUG_ON(!list_empty(&inode->i_lru));
 	__destroy_inode(inode);
-	if (inode->i_sb->s_op->destroy_inode)
-		inode->i_sb->s_op->destroy_inode(inode);
-	else
-		call_rcu(&inode->i_rcu, i_callback);
+	if (ops->destroy_inode) {
+		ops->destroy_inode(inode);
+		if (!ops->free_inode)
+			return;
+	}
+	call_rcu(&inode->i_rcu, i_callback);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e7679089..2e9b9f87caca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1903,6 +1903,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *);
+	void (*free_inode)(struct inode *);
 
    	void (*dirty_inode) (struct inode *, int flags);
 	int (*write_inode) (struct inode *, struct writeback_control *wbc);
-- 
2.11.0

