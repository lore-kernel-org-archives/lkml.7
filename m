Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82877C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3932166E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558006850;
	bh=o+k7HPVzCEO5SfAAYq7jFgh6ErX8qzJSND4nK+VFqcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I12jt/aCUQU1y0h/EemKkhoiC3GzbsIU6IPUTL8/9mCeJbICM/iMpulI/Rj1NWmMI
	 sTIULcIO8w6ACnGPkvHYEhk+mAUdaBSDzQJsOPbR6bxD8i7IQe9wBNe1J2MirZcWki
	 Yg5MaxIU/K13Wrzh0kahac+lZyYOL9x5XPN7S+SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfEPLkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfEPLkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:40:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A566C20862;
        Thu, 16 May 2019 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006842;
        bh=o+k7HPVzCEO5SfAAYq7jFgh6ErX8qzJSND4nK+VFqcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pACKADwzrn3MOpf+b0YhHHxxzJaeq8i+rT7EH/zTK6W/bdMvpgzHafmMRfaPBJ1LG
         QAQQ9t5qo6zHroGgm8iZbnlXjEpfAFWAXEuNBfOO5zlu3YkH6NXNQlYAVibZDLmUOC
         X8aj+kixuEpxWkM80mcE8IviA1BHuPOXmcrCAEaw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/25] apparmorfs: fix use-after-free on symlink traversal
Date:   Thu, 16 May 2019 07:40:14 -0400
Message-Id: <20190516114029.8682-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516114029.8682-1-sashal@kernel.org>
References: <20190516114029.8682-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

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

