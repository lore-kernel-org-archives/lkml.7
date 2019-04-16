Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB8DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA0C2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfDPR4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:56:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57666 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfDPRxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:48 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHC-0005Z5-VY; Tue, 16 Apr 2019 17:53:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 46/62] apparmor: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:24 +0100
Message-Id: <20190416175340.21068-46-viro@ZenIV.linux.org.uk>
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
 security/apparmor/apparmorfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index b9298d2e8165..9ab5613fe07c 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -123,22 +123,16 @@ static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
 	return 0;
 }
 
-static void aafs_i_callback(struct rcu_head *head)
+static void aafs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
 	free_inode_nonrcu(inode);
 }
 
-static void aafs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, aafs_i_callback);
-}
-
 static const struct super_operations aafs_super_ops = {
 	.statfs = simple_statfs,
-	.destroy_inode = aafs_destroy_inode,
+	.free_inode = aafs_free_inode,
 	.show_path = aafs_show_path,
 };
 
-- 
2.11.0

