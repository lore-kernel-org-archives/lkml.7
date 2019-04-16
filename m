Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B48C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD0A206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfDPR6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:58:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57574 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfDPRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH9-0005Wa-HQ; Tue, 16 Apr 2019 17:53:43 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 23/62] hpfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:01 +0100
Message-Id: <20190416175340.21068-23-viro@ZenIV.linux.org.uk>
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
 fs/hpfs/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index f2c3ebcd309c..ed4264bca790 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -238,17 +238,11 @@ static struct inode *hpfs_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
-static void hpfs_i_callback(struct rcu_head *head)
+static void hpfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(hpfs_inode_cachep, hpfs_i(inode));
 }
 
-static void hpfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, hpfs_i_callback);
-}
-
 static void init_once(void *foo)
 {
 	struct hpfs_inode_info *ei = (struct hpfs_inode_info *) foo;
@@ -532,7 +526,7 @@ static int hpfs_show_options(struct seq_file *seq, struct dentry *root)
 static const struct super_operations hpfs_sops =
 {
 	.alloc_inode	= hpfs_alloc_inode,
-	.destroy_inode	= hpfs_destroy_inode,
+	.free_inode	= hpfs_free_inode,
 	.evict_inode	= hpfs_evict_inode,
 	.put_super	= hpfs_put_super,
 	.statfs		= hpfs_statfs,
-- 
2.11.0

