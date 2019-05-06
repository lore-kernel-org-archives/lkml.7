Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39867C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004A620C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154214;
	bh=Hnb7z3+7JBqf/LXbuVAtgRZVI934LRCWUyNEAg07ttQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVjPqPuAvvXrIrrWKT9J95qSky0fWLwGBCgrZP47szEOwsRTrXVet2vzvog6pC4NR
	 xiCEYOftkRh+f4t/n4r3E5wl3ukz5CptfH/ywPaiNee6hdyfCzUZT2KCUzHP8cC5xN
	 SGmuoSwl5pZrjQeLuywWtkkqew+ICrAIDGOzw4qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfEFOuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbfEFOtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:49:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0E0621530;
        Mon,  6 May 2019 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557154179;
        bh=Hnb7z3+7JBqf/LXbuVAtgRZVI934LRCWUyNEAg07ttQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAFf8ULk5aPoDrmm/RMZsHcbxDwIyRb20j4GBjXSLxjNX5wgr4hDA9BngI1pks2BS
         3oKNei4pRsFsXc6SsZRbY1qKA+BQMCXRFm5tpV3IKaHkRUEk8878vLOopEEWJhGYbj
         QxeJfEbBOWocv4BhqhWsUD6iANfqsfNLcFAgEfqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 41/62] debugfs: fix use-after-free on symlink traversal
Date:   Mon,  6 May 2019 16:33:12 +0200
Message-Id: <20190506143054.696253573@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143051.102535767@linuxfoundation.org>
References: <20190506143051.102535767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.1



