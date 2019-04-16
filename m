Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FA6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973502087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfDPRyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57638 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbfDPRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHB-0005YM-TP; Tue, 16 Apr 2019 17:53:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 39/62] udf: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:17 +0100
Message-Id: <20190416175340.21068-39-viro@ZenIV.linux.org.uk>
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
 fs/udf/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index ffd8038ff728..f64691f2168a 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -161,17 +161,11 @@ static struct inode *udf_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
-static void udf_i_callback(struct rcu_head *head)
+static void udf_free_in_core_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(udf_inode_cachep, UDF_I(inode));
 }
 
-static void udf_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, udf_i_callback);
-}
-
 static void init_once(void *foo)
 {
 	struct udf_inode_info *ei = (struct udf_inode_info *)foo;
@@ -206,7 +200,7 @@ static void destroy_inodecache(void)
 /* Superblock operations */
 static const struct super_operations udf_sb_ops = {
 	.alloc_inode	= udf_alloc_inode,
-	.destroy_inode	= udf_destroy_inode,
+	.free_inode	= udf_free_in_core_inode,
 	.write_inode	= udf_write_inode,
 	.evict_inode	= udf_evict_inode,
 	.put_super	= udf_put_super,
-- 
2.11.0

