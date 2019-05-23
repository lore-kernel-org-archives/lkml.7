Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C973FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8D20863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639149;
	bh=yrq9I9kbVJolOu6Ho7IEvtj0qZVvshXzKESK0C6DOSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SVhU7U0PdwZiVQK5JQvswZ9PCiBu6F5+P9/Jz5tlCqZoKbo0J3luNqWWO3CcT8MYn
	 W7+v6sQax0Lo75w/TP5G2w2bVWYZLV5iUob6bnHA8ZjTCsYj4oY5XJphmizp8TkmZI
	 FbqWQkdC9fqeK/JrjRWbuAuyyH2J4lTxuPrFSr+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbfEWTTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388546AbfEWTTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:19:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4432C2133D;
        Thu, 23 May 2019 19:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639142;
        bh=yrq9I9kbVJolOu6Ho7IEvtj0qZVvshXzKESK0C6DOSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7QZxTY5G+kig/1EmY1BEhtAfi/I8nlUjSm+cr/v6XVvdb7ONT3pEeYmk5eiCND3J
         LqaKOD1vcrV7DJojf9ketjx2AzfmlpBPKumxk72KrCYLU18w7H2WczGY4BvKmUYoj1
         Z/ODr36JS3AJHOqoPJf76rzMwjPhCK8CU81nILho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 093/114] apparmorfs: fix use-after-free on symlink traversal
Date:   Thu, 23 May 2019 21:06:32 +0200
Message-Id: <20190523181739.841945536@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f51dcd0f621caac5380ce90fbbeafc32ce4517ae ]

symlink body shouldn't be freed without an RCU delay.  Switch apparmorfs
to ->destroy_inode() and use of call_rcu(); free both the inode and symlink
body in the callback.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/apparmorfs.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index e09fe4d7307cd..40e3a098f6fb5 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -123,17 +123,22 @@ static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
 	return 0;
 }
 
-static void aafs_evict_inode(struct inode *inode)
+static void aafs_i_callback(struct rcu_head *head)
 {
-	truncate_inode_pages_final(&inode->i_data);
-	clear_inode(inode);
+	struct inode *inode = container_of(head, struct inode, i_rcu);
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
+	free_inode_nonrcu(inode);
+}
+
+static void aafs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, aafs_i_callback);
 }
 
 static const struct super_operations aafs_super_ops = {
 	.statfs = simple_statfs,
-	.evict_inode = aafs_evict_inode,
+	.destroy_inode = aafs_destroy_inode,
 	.show_path = aafs_show_path,
 };
 
-- 
2.20.1



