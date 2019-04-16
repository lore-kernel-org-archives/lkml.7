Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724EEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4706A2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfDPRza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:55:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57710 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbfDPRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHE-0005aB-KI; Tue, 16 Apr 2019 17:53:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 57/62] overlayfs: make use of ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:35 +0100
Message-Id: <20190416175340.21068-57-viro@ZenIV.linux.org.uk>
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

synchronous parts are left in ->destroy_inode()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/super.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 0116735cc321..5ec4fc2f5d7e 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -190,11 +190,13 @@ static struct inode *ovl_alloc_inode(struct super_block *sb)
 	return &oi->vfs_inode;
 }
 
-static void ovl_i_callback(struct rcu_head *head)
+static void ovl_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
+	struct ovl_inode *oi = OVL_I(inode);
 
-	kmem_cache_free(ovl_inode_cachep, OVL_I(inode));
+	kfree(oi->redirect);
+	mutex_destroy(&oi->lock);
+	kmem_cache_free(ovl_inode_cachep, oi);
 }
 
 static void ovl_destroy_inode(struct inode *inode)
@@ -207,10 +209,6 @@ static void ovl_destroy_inode(struct inode *inode)
 		ovl_dir_cache_free(inode);
 	else
 		iput(oi->lowerdata);
-	kfree(oi->redirect);
-	mutex_destroy(&oi->lock);
-
-	call_rcu(&inode->i_rcu, ovl_i_callback);
 }
 
 static void ovl_free_fs(struct ovl_fs *ofs)
@@ -377,6 +375,7 @@ static int ovl_remount(struct super_block *sb, int *flags, char *data)
 
 static const struct super_operations ovl_super_operations = {
 	.alloc_inode	= ovl_alloc_inode,
+	.free_inode	= ovl_free_inode,
 	.destroy_inode	= ovl_destroy_inode,
 	.drop_inode	= generic_delete_inode,
 	.put_super	= ovl_put_super,
-- 
2.11.0

