Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02501C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E452075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfDPR5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:57:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57632 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbfDPRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHB-0005YG-Nu; Tue, 16 Apr 2019 17:53:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 38/62] ubifs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:16 +0100
Message-Id: <20190416175340.21068-38-viro@ZenIV.linux.org.uk>
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
 fs/ubifs/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 12628184772c..c2307c423638 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -272,19 +272,13 @@ static struct inode *ubifs_alloc_inode(struct super_block *sb)
 	return &ui->vfs_inode;
 };
 
-static void ubifs_i_callback(struct rcu_head *head)
+static void ubifs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	kfree(ui->data);
 	kmem_cache_free(ubifs_inode_slab, ui);
 }
 
-static void ubifs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, ubifs_i_callback);
-}
-
 /*
  * Note, Linux write-back code calls this without 'i_mutex'.
  */
@@ -1977,7 +1971,7 @@ static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
 
 const struct super_operations ubifs_super_operations = {
 	.alloc_inode   = ubifs_alloc_inode,
-	.destroy_inode = ubifs_destroy_inode,
+	.free_inode    = ubifs_free_inode,
 	.put_super     = ubifs_put_super,
 	.write_inode   = ubifs_write_inode,
 	.evict_inode   = ubifs_evict_inode,
-- 
2.11.0

