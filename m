Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC2DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DA22075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfDPR4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:56:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57670 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbfDPRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHD-0005ZB-4U; Tue, 16 Apr 2019 17:53:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 47/62] securityfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:25 +0100
Message-Id: <20190416175340.21068-47-viro@ZenIV.linux.org.uk>
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
 security/inode.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 421dd72b5876..aacc4dabba7d 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -27,22 +27,16 @@
 static struct vfsmount *mount;
 static int mount_count;
 
-static void securityfs_i_callback(struct rcu_head *head)
+static void securityfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
 	free_inode_nonrcu(inode);
 }
 
-static void securityfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, securityfs_i_callback);
-}
-
 static const struct super_operations securityfs_super_operations = {
 	.statfs		= simple_statfs,
-	.destroy_inode	= securityfs_destroy_inode,
+	.free_inode	= securityfs_free_inode,
 };
 
 static int fill_super(struct super_block *sb, void *data, int silent)
-- 
2.11.0

