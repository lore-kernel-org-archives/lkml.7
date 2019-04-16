Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25990C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC70F206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfDPSAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:00:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57518 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH7-0005VC-Qt; Tue, 16 Apr 2019 17:53:41 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 09/62] befs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:47 +0100
Message-Id: <20190416175340.21068-9-viro@ZenIV.linux.org.uk>
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
 fs/befs/linuxvfs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 4700b4534439..e273850c95af 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -44,7 +44,7 @@ static struct dentry *befs_lookup(struct inode *, struct dentry *,
 				  unsigned int);
 static struct inode *befs_iget(struct super_block *, unsigned long);
 static struct inode *befs_alloc_inode(struct super_block *sb);
-static void befs_destroy_inode(struct inode *inode);
+static void befs_free_inode(struct inode *inode);
 static void befs_destroy_inodecache(void);
 static int befs_symlink_readpage(struct file *, struct page *);
 static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
@@ -64,7 +64,7 @@ static struct dentry *befs_get_parent(struct dentry *child);
 
 static const struct super_operations befs_sops = {
 	.alloc_inode	= befs_alloc_inode,	/* allocate a new inode */
-	.destroy_inode	= befs_destroy_inode, /* deallocate an inode */
+	.free_inode	= befs_free_inode, /* deallocate an inode */
 	.put_super	= befs_put_super,	/* uninit super */
 	.statfs		= befs_statfs,	/* statfs */
 	.remount_fs	= befs_remount,
@@ -281,17 +281,11 @@ befs_alloc_inode(struct super_block *sb)
 	return &bi->vfs_inode;
 }
 
-static void befs_i_callback(struct rcu_head *head)
+static void befs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(befs_inode_cachep, BEFS_I(inode));
 }
 
-static void befs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, befs_i_callback);
-}
-
 static void init_once(void *foo)
 {
 	struct befs_inode_info *bi = (struct befs_inode_info *) foo;
-- 
2.11.0

