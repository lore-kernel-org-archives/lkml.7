Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8402DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5936E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbfDPRzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:55:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57674 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfDPRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHD-0005ZH-AP; Tue, 16 Apr 2019 17:53:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 48/62] ntfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:26 +0100
Message-Id: <20190416175340.21068-48-viro@ZenIV.linux.org.uk>
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

move the synchronous stuff from ->destroy_inode() to ->evict_inode(),
turn the RCU-delayed part into ->free_inode()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ntfs/inode.c | 17 ++++-------------
 fs/ntfs/inode.h |  2 +-
 fs/ntfs/super.c |  2 +-
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index bd3221cbdd95..fb1a2b49a5da 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -332,23 +332,11 @@ struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 	return NULL;
 }
 
-static void ntfs_i_callback(struct rcu_head *head)
+void ntfs_free_big_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
 }
 
-void ntfs_destroy_big_inode(struct inode *inode)
-{
-	ntfs_inode *ni = NTFS_I(inode);
-
-	ntfs_debug("Entering.");
-	BUG_ON(ni->page);
-	if (!atomic_dec_and_test(&ni->count))
-		BUG();
-	call_rcu(&inode->i_rcu, ntfs_i_callback);
-}
-
 static inline ntfs_inode *ntfs_alloc_extent_inode(void)
 {
 	ntfs_inode *ni;
@@ -2287,6 +2275,9 @@ void ntfs_evict_big_inode(struct inode *vi)
 			ni->ext.base_ntfs_ino = NULL;
 		}
 	}
+	BUG_ON(ni->page);
+	if (!atomic_dec_and_test(&ni->count))
+		BUG();
 	return;
 }
 
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index b3c3469de6cb..58c8fd2948d3 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -278,7 +278,7 @@ extern struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
 		u32 name_len);
 
 extern struct inode *ntfs_alloc_big_inode(struct super_block *sb);
-extern void ntfs_destroy_big_inode(struct inode *inode);
+extern void ntfs_free_big_inode(struct inode *inode);
 extern void ntfs_evict_big_inode(struct inode *vi);
 
 extern void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni);
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index bb7159f697f2..887ea8b3b000 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2676,7 +2676,7 @@ static int ntfs_write_inode(struct inode *vi, struct writeback_control *wbc)
  */
 static const struct super_operations ntfs_sops = {
 	.alloc_inode	= ntfs_alloc_big_inode,	  /* VFS: Allocate new inode. */
-	.destroy_inode	= ntfs_destroy_big_inode, /* VFS: Deallocate inode. */
+	.free_inode	= ntfs_free_big_inode, /* VFS: Deallocate inode. */
 #ifdef NTFS_RW
 	.write_inode	= ntfs_write_inode,	/* VFS: Write dirty inode to
 						   disk. */
-- 
2.11.0

