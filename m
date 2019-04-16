Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF93C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB87D206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfDPR5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:57:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57614 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbfDPRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHB-0005Xl-2q; Tue, 16 Apr 2019 17:53:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 33/62] qnx4: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:11 +0100
Message-Id: <20190416175340.21068-33-viro@ZenIV.linux.org.uk>
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
 fs/qnx4/inode.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3d46fe302fcb..48c70aa4a3ec 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -28,14 +28,14 @@
 static const struct super_operations qnx4_sops;
 
 static struct inode *qnx4_alloc_inode(struct super_block *sb);
-static void qnx4_destroy_inode(struct inode *inode);
+static void qnx4_free_inode(struct inode *inode);
 static int qnx4_remount(struct super_block *sb, int *flags, char *data);
 static int qnx4_statfs(struct dentry *, struct kstatfs *);
 
 static const struct super_operations qnx4_sops =
 {
 	.alloc_inode	= qnx4_alloc_inode,
-	.destroy_inode	= qnx4_destroy_inode,
+	.free_inode	= qnx4_free_inode,
 	.statfs		= qnx4_statfs,
 	.remount_fs	= qnx4_remount,
 };
@@ -342,17 +342,11 @@ static struct inode *qnx4_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
-static void qnx4_i_callback(struct rcu_head *head)
+static void qnx4_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(qnx4_inode_cachep, qnx4_i(inode));
 }
 
-static void qnx4_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, qnx4_i_callback);
-}
-
 static void init_once(void *foo)
 {
 	struct qnx4_inode_info *ei = (struct qnx4_inode_info *) foo;
-- 
2.11.0

