Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55470C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E942075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfDPRxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:53:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57502 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDPRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH7-0005Un-5i; Tue, 16 Apr 2019 17:53:41 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 05/62] erofs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:43 +0100
Message-Id: <20190416175340.21068-5-viro@ZenIV.linux.org.uk>
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
 drivers/staging/erofs/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 15c784fba879..700cbd460807 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -57,9 +57,8 @@ static struct inode *alloc_inode(struct super_block *sb)
 	return &vi->vfs_inode;
 }
 
-static void i_callback(struct rcu_head *head)
+static void free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	struct erofs_vnode *vi = EROFS_V(inode);
 
 	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
@@ -71,11 +70,6 @@ static void i_callback(struct rcu_head *head)
 	kmem_cache_free(erofs_inode_cachep, vi);
 }
 
-static void destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, i_callback);
-}
-
 static int superblock_read(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
@@ -668,7 +662,7 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 const struct super_operations erofs_sops = {
 	.put_super = erofs_put_super,
 	.alloc_inode = alloc_inode,
-	.destroy_inode = destroy_inode,
+	.free_inode = free_inode,
 	.statfs = erofs_statfs,
 	.show_options = erofs_show_options,
 	.remount_fs = erofs_remount,
-- 
2.11.0

