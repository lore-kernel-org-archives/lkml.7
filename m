Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725C5C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51251206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfDPR5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:57:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57624 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfDPRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHB-0005Y3-Dl; Tue, 16 Apr 2019 17:53:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 36/62] romfs: convert to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:14 +0100
Message-Id: <20190416175340.21068-36-viro@ZenIV.linux.org.uk>
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
 fs/romfs/super.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 6ccb51993a76..7d580f7c3f1d 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -381,18 +381,11 @@ static struct inode *romfs_alloc_inode(struct super_block *sb)
 /*
  * return a spent inode to the slab cache
  */
-static void romfs_i_callback(struct rcu_head *head)
+static void romfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-
 	kmem_cache_free(romfs_inode_cachep, ROMFS_I(inode));
 }
 
-static void romfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, romfs_i_callback);
-}
-
 /*
  * get filesystem statistics
  */
@@ -439,7 +432,7 @@ static int romfs_remount(struct super_block *sb, int *flags, char *data)
 
 static const struct super_operations romfs_super_ops = {
 	.alloc_inode	= romfs_alloc_inode,
-	.destroy_inode	= romfs_destroy_inode,
+	.free_inode	= romfs_free_inode,
 	.statfs		= romfs_statfs,
 	.remount_fs	= romfs_remount,
 };
-- 
2.11.0

