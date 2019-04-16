Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87608C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6477E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfDPR4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:56:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfDPRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHC-0005Yz-R5; Tue, 16 Apr 2019 17:53:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 45/62] rpcpipe: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:23 +0100
Message-Id: <20190416175340.21068-45-viro@ZenIV.linux.org.uk>
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
 net/sunrpc/rpc_pipe.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 69663681bf9d..979d23646e33 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -202,18 +202,11 @@ rpc_alloc_inode(struct super_block *sb)
 }
 
 static void
-rpc_i_callback(struct rcu_head *head)
+rpc_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(rpc_inode_cachep, RPC_I(inode));
 }
 
-static void
-rpc_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, rpc_i_callback);
-}
-
 static int
 rpc_pipe_open(struct inode *inode, struct file *filp)
 {
@@ -1123,7 +1116,7 @@ void rpc_remove_cache_dir(struct dentry *dentry)
  */
 static const struct super_operations s_ops = {
 	.alloc_inode	= rpc_alloc_inode,
-	.destroy_inode	= rpc_destroy_inode,
+	.free_inode	= rpc_free_inode,
 	.statfs		= simple_statfs,
 };
 
-- 
2.11.0

