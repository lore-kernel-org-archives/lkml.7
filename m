Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF69C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F572075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfDPRzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:55:17 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57720 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfDPRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHE-0005aT-VT; Tue, 16 Apr 2019 17:53:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 60/62] orangefs: make use of ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:38 +0100
Message-Id: <20190416175340.21068-60-viro@ZenIV.linux.org.uk>
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
 fs/orangefs/super.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index dfaee90d30bd..3784f7e8b603 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -124,11 +124,9 @@ static struct inode *orangefs_alloc_inode(struct super_block *sb)
 	return &orangefs_inode->vfs_inode;
 }
 
-static void orangefs_i_callback(struct rcu_head *head)
+static void orangefs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
-	kmem_cache_free(orangefs_inode_cache, orangefs_inode);
+	kmem_cache_free(orangefs_inode_cache, ORANGEFS_I(inode));
 }
 
 static void orangefs_destroy_inode(struct inode *inode)
@@ -138,8 +136,6 @@ static void orangefs_destroy_inode(struct inode *inode)
 	gossip_debug(GOSSIP_SUPER_DEBUG,
 			"%s: deallocated %p destroying inode %pU\n",
 			__func__, orangefs_inode, get_khandle_from_ino(inode));
-
-	call_rcu(&inode->i_rcu, orangefs_i_callback);
 }
 
 /*
@@ -299,6 +295,7 @@ void fsid_key_table_finalize(void)
 
 static const struct super_operations orangefs_s_ops = {
 	.alloc_inode = orangefs_alloc_inode,
+	.free_inode = orangefs_free_inode,
 	.destroy_inode = orangefs_destroy_inode,
 	.drop_inode = generic_delete_inode,
 	.statfs = orangefs_statfs,
-- 
2.11.0

