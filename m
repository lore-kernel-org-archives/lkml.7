Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A39C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E9620862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558007075;
	bh=FXDuVxiBXbsl4QZDdR6w/GeJ6pexSEJO3wfr+1TAQfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohogDYmxsbCGYY3vlNfQmRW1gfnUKmGG6/82tjGr96y6rdYCiHBUe4Sq4Fj+r/kmv
	 3D8ccZugRUQ1H8apguxUaqJTRZnwbYM8enljWvWgqbihd7/BJmPA0xih7hCGzWSWWu
	 gQ+lHwxySUc6/7g+C8AFBkYEOfUC5jI9uS5AKUtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfEPLoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfEPLlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:41:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D2BA216FD;
        Thu, 16 May 2019 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006877;
        bh=FXDuVxiBXbsl4QZDdR6w/GeJ6pexSEJO3wfr+1TAQfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3LvwTK0Iy4KzN6Vs3jGwxjXOt9bmdWjvCUwNZVXyrkFkJueu3ej8KUnvO1ZOcqAZ
         /NG6VW1mVQXgtAIBjpB6rlrpu6au+MOSo2xN14rk2hwYn6ZoJdrgXfL2MBYgEpQjcf
         K2dfzo+p1Yb7lMZ+04fsqt5QJKRaoOJTXnMdN1Wg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/16] apparmorfs: fix use-after-free on symlink traversal
Date:   Thu, 16 May 2019 07:40:59 -0400
Message-Id: <20190516114107.8963-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516114107.8963-1-sashal@kernel.org>
References: <20190516114107.8963-1-sashal@kernel.org>
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
index 0e03377bb83ea..dd746bd69a9b2 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -126,17 +126,22 @@ static int aafs_show_path(struct seq_file *seq, struct dentry *dentry)
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

