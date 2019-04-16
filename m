Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6704AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE542087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfDPRy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57706 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfDPRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHE-0005a5-HX; Tue, 16 Apr 2019 17:53:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 56/62] jfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:34 +0100
Message-Id: <20190416175340.21068-56-viro@ZenIV.linux.org.uk>
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

synchronous part can be moved to ->evict_inode(), the rest -
->free_inode() fodder

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/jfs/inode.c | 13 +++++++++++++
 fs/jfs/super.c | 24 +++---------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 805ae9e8944a..f2b92b292abe 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -31,6 +31,7 @@
 #include "jfs_extent.h"
 #include "jfs_unicode.h"
 #include "jfs_debug.h"
+#include "jfs_dmap.h"
 
 
 struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
@@ -150,6 +151,8 @@ int jfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 void jfs_evict_inode(struct inode *inode)
 {
+	struct jfs_inode_info *ji = JFS_IP(inode);
+
 	jfs_info("In jfs_evict_inode, inode = 0x%p", inode);
 
 	if (!inode->i_nlink && !is_bad_inode(inode)) {
@@ -173,6 +176,16 @@ void jfs_evict_inode(struct inode *inode)
 	}
 	clear_inode(inode);
 	dquot_drop(inode);
+
+	BUG_ON(!list_empty(&ji->anon_inode_list));
+
+	spin_lock_irq(&ji->ag_lock);
+	if (ji->active_ag != -1) {
+		struct bmap *bmap = JFS_SBI(inode->i_sb)->bmap;
+		atomic_dec(&bmap->db_active[ji->active_ag]);
+		ji->active_ag = -1;
+	}
+	spin_unlock_irq(&ji->ag_lock);
 }
 
 void jfs_dirty_inode(struct inode *inode, int flags)
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 65d8fc87ab11..9454831bbd71 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -124,27 +124,9 @@ static struct inode *jfs_alloc_inode(struct super_block *sb)
 	return &jfs_inode->vfs_inode;
 }
 
-static void jfs_i_callback(struct rcu_head *head)
+static void jfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	struct jfs_inode_info *ji = JFS_IP(inode);
-	kmem_cache_free(jfs_inode_cachep, ji);
-}
-
-static void jfs_destroy_inode(struct inode *inode)
-{
-	struct jfs_inode_info *ji = JFS_IP(inode);
-
-	BUG_ON(!list_empty(&ji->anon_inode_list));
-
-	spin_lock_irq(&ji->ag_lock);
-	if (ji->active_ag != -1) {
-		struct bmap *bmap = JFS_SBI(inode->i_sb)->bmap;
-		atomic_dec(&bmap->db_active[ji->active_ag]);
-		ji->active_ag = -1;
-	}
-	spin_unlock_irq(&ji->ag_lock);
-	call_rcu(&inode->i_rcu, jfs_i_callback);
+	kmem_cache_free(jfs_inode_cachep, JFS_IP(inode));
 }
 
 static int jfs_statfs(struct dentry *dentry, struct kstatfs *buf)
@@ -912,7 +894,7 @@ static int jfs_quota_off(struct super_block *sb, int type)
 
 static const struct super_operations jfs_super_operations = {
 	.alloc_inode	= jfs_alloc_inode,
-	.destroy_inode	= jfs_destroy_inode,
+	.free_inode	= jfs_free_inode,
 	.dirty_inode	= jfs_dirty_inode,
 	.write_inode	= jfs_write_inode,
 	.evict_inode	= jfs_evict_inode,
-- 
2.11.0

