Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2553C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4FD2196E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778611;
	bh=1xmyzwQAzoyVvQOqY0GRDWplegq/1md/Px3CgQEdzOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2hVeKYQtdZ8U58tmDIcRABGlAAMsbd58NVu70jf1siYMA5ZCuklPcxfbpJ0DRyhYs
	 pTaGtIFmBjl8XR0gQXBoylJ/27F7OOj2osyCHVPu8mBe/F1tne4M70Wo4dZc+j49OS
	 l62HVG6Lv+hz1/r72f3Qyz0rKGKjile1ZWo10xr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfI2Rgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbfI2Rgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:36:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4549D21925;
        Sun, 29 Sep 2019 17:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778608;
        bh=1xmyzwQAzoyVvQOqY0GRDWplegq/1md/Px3CgQEdzOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yht8BfqetXoLOtXv+ha5RvsSZI0pZSqxEa7bUbw5rGGylUcwgMMfXm5ll6NaWwaa6
         WIzSf+PtpPGVCj53pfxmMn5KzSQtWyciDw/siKQskjeLPUkgaeA2xL80cuKnbuy3+4
         aBIszCeUyP4oR2eQ0A5gf3R5WgkjxqanP4ZwNEEM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 11/13] hypfs: Fix error number left in struct pointer member
Date:   Sun, 29 Sep 2019 13:36:21 -0400
Message-Id: <20190929173625.10003-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173625.10003-1-sashal@kernel.org>
References: <20190929173625.10003-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit b54c64f7adeb241423cd46598f458b5486b0375e ]

In hypfs_fill_super(), if hypfs_create_update_file() fails,
sbi->update_file is left holding an error number.  This is passed to
hypfs_kill_super() which doesn't check for this.

Fix this by not setting sbi->update_value until after we've checked for
error.

Fixes: 24bbb1faf3f0 ("[PATCH] s390_hypfs filesystem")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: linux-s390@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/hypfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 2a17123130d30..224aeda1e8ccf 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -267,7 +267,7 @@ static int hypfs_show_options(struct seq_file *s, struct dentry *root)
 static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *root_inode;
-	struct dentry *root_dentry;
+	struct dentry *root_dentry, *update_file;
 	int rc = 0;
 	struct hypfs_sb_info *sbi;
 
@@ -298,9 +298,10 @@ static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
 		rc = hypfs_diag_create_files(root_dentry);
 	if (rc)
 		return rc;
-	sbi->update_file = hypfs_create_update_file(root_dentry);
-	if (IS_ERR(sbi->update_file))
-		return PTR_ERR(sbi->update_file);
+	update_file = hypfs_create_update_file(root_dentry);
+	if (IS_ERR(update_file))
+		return PTR_ERR(update_file);
+	sbi->update_file = update_file;
 	hypfs_update_update(sb);
 	pr_info("Hypervisor filesystem mounted\n");
 	return 0;
-- 
2.20.1

