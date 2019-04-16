Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF76C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfDPSAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:00:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57526 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbfDPRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH8-0005VO-8b; Tue, 16 Apr 2019 17:53:42 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 11/62] bdev: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:49 +0100
Message-Id: <20190416175340.21068-11-viro@ZenIV.linux.org.uk>
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
 fs/block_dev.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 78d3257435c0..9d5fd05dd643 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -789,17 +789,9 @@ static struct inode *bdev_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
-static void bdev_i_callback(struct rcu_head *head)
+static void bdev_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	struct bdev_inode *bdi = BDEV_I(inode);
-
-	kmem_cache_free(bdev_cachep, bdi);
-}
-
-static void bdev_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, bdev_i_callback);
+	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
 
 static void init_once(void *foo)
@@ -839,7 +831,7 @@ static void bdev_evict_inode(struct inode *inode)
 static const struct super_operations bdev_sops = {
 	.statfs = simple_statfs,
 	.alloc_inode = bdev_alloc_inode,
-	.destroy_inode = bdev_destroy_inode,
+	.free_inode = bdev_free_inode,
 	.drop_inode = generic_delete_inode,
 	.evict_inode = bdev_evict_inode,
 };
-- 
2.11.0

