Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB289C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA38721479
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153358;
	bh=hljp+ch+ecoaQHcffwwaeNdZOy52z8Z9nCFkAW0YfVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cnt9Z682UhIaVzwJgPHtkQhs0IxbZWZH8BNTiHT5o94DDuuLHlVDnfPGROiIBKCFF
	 HkJ3A4W76E2TZEGyvQiFCLnHw7BK0SEABgTHKTtdr6JHyATF4YOpEPVvHTaZRuKjdA
	 I94b415VdFdB8Z7Nyq1oHdxDO+8YlWpgXmA2/vBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfEFOf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfEFOfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:35:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50419204EC;
        Mon,  6 May 2019 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153352;
        bh=hljp+ch+ecoaQHcffwwaeNdZOy52z8Z9nCFkAW0YfVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0CxH65HSv3t3xwGXN7hum0IsFGaidwbCoZysWtqxSvNnD3fU8lVVx3CJHzG9Ujto
         MnYPvPb+9lVu5oSpsV27FXkY/cFEm7PeZWsqBl6PYecFAAcistOSvvjRjBCjeHvG8V
         GeomSUZwNiukznIIuf3UGYy9fwTL35IdraBHpIDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 057/122] debugfs: fix use-after-free on symlink traversal
Date:   Mon,  6 May 2019 16:31:55 +0200
Message-Id: <20190506143100.115753154@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
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
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 fs/debugfs/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 29c68c5d44d5..c4a4fc6f1a95 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -163,19 +163,24 @@ static int debugfs_show_options(struct seq_file *m, struct dentry *root)
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
 
 static void debugfs_release_dentry(struct dentry *dentry)
-- 
2.20.1



