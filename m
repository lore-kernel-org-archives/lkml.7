Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154F7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ECA218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117533;
	bh=tff5uGrH/1bHPED0EJUJDAbfpZSRRcamXPQVBN2MA6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DU6Wb5IXfZJxtOouUym2pSQWf+yFXJsoj9f3a4jEUAAJRCgfyeERs7OdnU8xY81nA
	 xKLUxRJHZ4wJhHvAjXsRk+H2QRGNpUyegFMawgk1DA/Djjexksk/3BT4/3cEl6VxYo
	 6bgGvqbXPo5kvJ6P4AEDvbLyuKhJuGgWTfvt53LA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfDXOwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732897AbfDXOwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:52:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A8BE218FD;
        Wed, 24 Apr 2019 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117529;
        bh=tff5uGrH/1bHPED0EJUJDAbfpZSRRcamXPQVBN2MA6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKOmdIVfVpELi5EeeybOSTsmTZu34Jg+XqdjvmtLOS5FwemWohsT2KE5ndA4Ken1D
         2Cd6UjKVmkcnijlRGqpkbAqUVmjjvx8EGXNOqFUy2bnJgTSaFzYvsSkflM4XPYFXkN
         HPYcL/5fXcJ2uOmMVmUM0jvTu8exT23MUAXeA8BE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 06/15] debugfs: fix use-after-free on symlink traversal
Date:   Wed, 24 Apr 2019 10:51:43 -0400
Message-Id: <20190424145152.31351-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145152.31351-1-sashal@kernel.org>
References: <20190424145152.31351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 93b919da64c15b90953f96a536e5e61df896ca57 ]

symlink body shouldn't be freed without an RCU delay.  Switch debugfs to
->destroy_inode() and use of call_rcu(); free both the inode and symlink
body in the callback.  Similar to solution for bpf, only here it's even
more obvious that ->evict_inode() can be dropped.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 22fe11baef2b..3530e1c3ff56 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -164,19 +164,24 @@ static int debugfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void debugfs_evict_inode(struct inode *inode)
+static void debugfs_i_callback(struct rcu_head *head)
 {
-	truncate_inode_pages_final(&inode->i_data);
-	clear_inode(inode);
+	struct inode *inode = container_of(head, struct inode, i_rcu);
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
+	free_inode_nonrcu(inode);
+}
+
+static void debugfs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, debugfs_i_callback);
 }
 
 static const struct super_operations debugfs_super_operations = {
 	.statfs		= simple_statfs,
 	.remount_fs	= debugfs_remount,
 	.show_options	= debugfs_show_options,
-	.evict_inode	= debugfs_evict_inode,
+	.destroy_inode	= debugfs_destroy_inode,
 };
 
 static struct vfsmount *debugfs_automount(struct path *path)
-- 
2.19.1

