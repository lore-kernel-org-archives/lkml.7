Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE33C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A735E2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117741;
	bh=P5cMsm+lgjxwbG1JVA3HQOf7GE0Pc5JvTYfPJ/z+bWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k+MQzFEvTv3s/Qzwvn36R1VvQBuHpFlh8n8pDLl0XBH2a3BiYuKsKP+ZPAx7l+RFI
	 hcCYXmrxtEYKHcFeNhN7kEhppA+QGNmf5DSdYxhql2FJ130YpKSj5EPEx4QjPyWLdm
	 q9iKwU1nSxuTGV2Bj49JT/4oif2UCkWY7hUhPLV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfDXOuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732690AbfDXOut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFCC218FC;
        Wed, 24 Apr 2019 14:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117448;
        bh=P5cMsm+lgjxwbG1JVA3HQOf7GE0Pc5JvTYfPJ/z+bWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEQIhlvIB8BfM2YMFVt4BCxtjuhCTABK46dJzzJHbM7bpJbpymaPef3t5mLDEwVDn
         sKUaJ6AAtVqCD8O2n52l+4xHmRQVwh+MGUgPB4EXqWIwYPfSqsXgR9uCeWnz0OOJ6t
         wjl7B6VmIcvRWPzYtf/CkZRkzYKTFRXJOWIYCdCo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 15/28] debugfs: fix use-after-free on symlink traversal
Date:   Wed, 24 Apr 2019 10:49:59 -0400
Message-Id: <20190424145012.30886-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
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
index 77e9cd7a0137..20ee612017bf 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -170,19 +170,24 @@ static int debugfs_show_options(struct seq_file *m, struct dentry *root)
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

