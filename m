Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CE4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFC12054F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfDPR7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:59:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57522 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfDPRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH8-0005VI-4N; Tue, 16 Apr 2019 17:53:42 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 10/62] bfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:48 +0100
Message-Id: <20190416175340.21068-10-viro@ZenIV.linux.org.uk>
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
 fs/bfs/inode.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index d136b2aaafb3..dc0cd2aa3d65 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -245,17 +245,11 @@ static struct inode *bfs_alloc_inode(struct super_block *sb)
 	return &bi->vfs_inode;
 }
 
-static void bfs_i_callback(struct rcu_head *head)
+static void bfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(bfs_inode_cachep, BFS_I(inode));
 }
 
-static void bfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, bfs_i_callback);
-}
-
 static void init_once(void *foo)
 {
 	struct bfs_inode_info *bi = foo;
@@ -287,7 +281,7 @@ static void destroy_inodecache(void)
 
 static const struct super_operations bfs_sops = {
 	.alloc_inode	= bfs_alloc_inode,
-	.destroy_inode	= bfs_destroy_inode,
+	.free_inode	= bfs_free_inode,
 	.write_inode	= bfs_write_inode,
 	.evict_inode	= bfs_evict_inode,
 	.put_super	= bfs_put_super,
-- 
2.11.0

