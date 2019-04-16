Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEB0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF2120880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfDPR6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:58:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57580 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfDPRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHA-0005Wq-0g; Tue, 16 Apr 2019 17:53:44 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 25/62] jffs2: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:03 +0100
Message-Id: <20190416175340.21068-25-viro@ZenIV.linux.org.uk>
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
 fs/jffs2/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 05d892c79339..af4aa6599473 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -44,20 +44,14 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 	return &f->vfs_inode;
 }
 
-static void jffs2_i_callback(struct rcu_head *head)
+static void jffs2_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 
 	kfree(f->target);
 	kmem_cache_free(jffs2_inode_cachep, f);
 }
 
-static void jffs2_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, jffs2_i_callback);
-}
-
 static void jffs2_i_init_once(void *foo)
 {
 	struct jffs2_inode_info *f = foo;
@@ -258,7 +252,7 @@ static int jffs2_remount_fs(struct super_block *sb, int *flags, char *data)
 static const struct super_operations jffs2_super_operations =
 {
 	.alloc_inode =	jffs2_alloc_inode,
-	.destroy_inode =jffs2_destroy_inode,
+	.free_inode =	jffs2_free_inode,
 	.put_super =	jffs2_put_super,
 	.statfs =	jffs2_statfs,
 	.remount_fs =	jffs2_remount_fs,
-- 
2.11.0

