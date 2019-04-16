Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899FCC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6945020880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfDPRx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:53:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57604 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbfDPRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHA-0005XT-O8; Tue, 16 Apr 2019 17:53:44 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 31/62] openpromfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:09 +0100
Message-Id: <20190416175340.21068-31-viro@ZenIV.linux.org.uk>
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
 fs/openpromfs/inode.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 1b2d0d2fe2ee..46655e454c55 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -336,17 +336,11 @@ static struct inode *openprom_alloc_inode(struct super_block *sb)
 	return &oi->vfs_inode;
 }
 
-static void openprom_i_callback(struct rcu_head *head)
+static void openprom_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(op_inode_cachep, OP_I(inode));
 }
 
-static void openprom_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, openprom_i_callback);
-}
-
 static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 {
 	struct inode *inode;
@@ -375,7 +369,7 @@ static int openprom_remount(struct super_block *sb, int *flags, char *data)
 
 static const struct super_operations openprom_sops = {
 	.alloc_inode	= openprom_alloc_inode,
-	.destroy_inode	= openprom_destroy_inode,
+	.free_inode	= openprom_free_inode,
 	.statfs		= simple_statfs,
 	.remount_fs	= openprom_remount,
 };
-- 
2.11.0

