Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABE5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43D52075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfDPRzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:55:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57724 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfDPRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHF-0005aZ-45; Tue, 16 Apr 2019 17:53:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 61/62] sockfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:39 +0100
Message-Id: <20190416175340.21068-61-viro@ZenIV.linux.org.uk>
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

we do have an RCU-delayed part there already (freeing the wq),
so it's not like the pipe situation; moreover, it might be
worth considering coallocating wq with the rest of struct sock_alloc.
->sk_wq in struct sock would remain a pointer as it is, but
the object it normally points to would be coallocated with
struct socket...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 8255f5bda0aa..6953a049fb82 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -263,12 +263,12 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
-static void sock_destroy_inode(struct inode *inode)
+static void sock_free_inode(struct inode *inode)
 {
 	struct socket_alloc *ei;
 
 	ei = container_of(inode, struct socket_alloc, vfs_inode);
-	kfree_rcu(ei->socket.wq, rcu);
+	kfree(ei->socket.wq);
 	kmem_cache_free(sock_inode_cachep, ei);
 }
 
@@ -293,7 +293,7 @@ static void init_inodecache(void)
 
 static const struct super_operations sockfs_ops = {
 	.alloc_inode	= sock_alloc_inode,
-	.destroy_inode	= sock_destroy_inode,
+	.free_inode	= sock_free_inode,
 	.statfs		= simple_statfs,
 };
 
-- 
2.11.0

