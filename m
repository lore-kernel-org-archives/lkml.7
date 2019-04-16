Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325FEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1186D206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfDPR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:59:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57530 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730226AbfDPRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH8-0005VU-Ao; Tue, 16 Apr 2019 17:53:42 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 12/62] cifs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:50 +0100
Message-Id: <20190416175340.21068-12-viro@ZenIV.linux.org.uk>
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
 fs/cifs/cifsfs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index a05bf1d6e1d0..877174761efb 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -315,16 +315,10 @@ cifs_alloc_inode(struct super_block *sb)
 	return &cifs_inode->vfs_inode;
 }
 
-static void cifs_i_callback(struct rcu_head *head)
-{
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	kmem_cache_free(cifs_inode_cachep, CIFS_I(inode));
-}
-
 static void
-cifs_destroy_inode(struct inode *inode)
+cifs_free_inode(struct inode *inode)
 {
-	call_rcu(&inode->i_rcu, cifs_i_callback);
+	kmem_cache_free(cifs_inode_cachep, CIFS_I(inode));
 }
 
 static void
@@ -630,7 +624,7 @@ static int cifs_drop_inode(struct inode *inode)
 static const struct super_operations cifs_super_ops = {
 	.statfs = cifs_statfs,
 	.alloc_inode = cifs_alloc_inode,
-	.destroy_inode = cifs_destroy_inode,
+	.free_inode = cifs_free_inode,
 	.drop_inode	= cifs_drop_inode,
 	.evict_inode	= cifs_evict_inode,
 /*	.delete_inode	= cifs_delete_inode,  */  /* Do not need above
-- 
2.11.0

