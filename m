Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0DEC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E492187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562138232;
	bh=sU/JZZhXq3QoOX9/LPmBEfsxp7HMIOox/WOxhmMO+6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vsN3T8j7UHMxlKZgUt5bjRloh/+s1RZmj+hQJXrEz0Wh0MdeUCnd4PvfKyIPGWwll
	 ZEZVoY+kJuH91RVA9GSZOALCrqmBF2/rX/DPhih2ON69YIVQCl8JyqA3SF+ZdemtdZ
	 XRTOPvcSFbBoKYu47HqCegY0Xqop0orLb8lrCCCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfGCHRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfGCHRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:17:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CD82187F;
        Wed,  3 Jul 2019 07:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562138229;
        bh=sU/JZZhXq3QoOX9/LPmBEfsxp7HMIOox/WOxhmMO+6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEHMJEPI6l29NCEh4w6cg9vx1WBbEHKsqtO5xa8E1hypCkIXYY1k99KNiTe/6/W9G
         5ViAKfb9nCqEeeAoO5yNPRi6mOWj0wU89EEnsqsEHlZUPDp1qkCWjceFh0FyUXIUyg
         VbV6UcG1P3CHbdKj7rTBDDEYYyKD+sHi8di97I/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] debugfs: log errors when something goes wrong
Date:   Wed,  3 Jul 2019 09:16:53 +0200
Message-Id: <20190703071653.2799-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190703071653.2799-1-gregkh@linuxfoundation.org>
References: <20190703071653.2799-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it is not recommended that debugfs calls be checked, it was pointed
out that major errors should still be logged somewhere so that
developers and users have a chance to figure out what went wrong.  To
help with this, error logging has been added to the debugfs core so that
it is not needed to be present in every individual file that calls
debugfs.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/inode.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f04c8475d9a1..7f43c8acfcbf 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -2,8 +2,9 @@
 /*
  *  inode.c - part of debugfs, a tiny little debug file system
  *
- *  Copyright (C) 2004 Greg Kroah-Hartman <greg@kroah.com>
+ *  Copyright (C) 2004,2019 Greg Kroah-Hartman <greg@kroah.com>
  *  Copyright (C) 2004 IBM Inc.
+ *  Copyright (C) 2019 Linux Foundation <gregkh@linuxfoundation.org>
  *
  *  debugfs is for people to use instead of /proc or /sys.
  *  See ./Documentation/core-api/kernel-api.rst for more details.
@@ -294,8 +295,10 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 
 	error = simple_pin_fs(&debug_fs_type, &debugfs_mount,
 			      &debugfs_mount_count);
-	if (error)
+	if (error) {
+		pr_err("Unable to pin filesystem for file '%s'\n", name);
 		return ERR_PTR(error);
+	}
 
 	/* If the parent is not specified, we create it in the root.
 	 * We need the root dentry to do this, which is in the super
@@ -309,6 +312,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	dentry = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
 		dput(dentry);
+		pr_err("File '%s' already present!\n", name);
 		dentry = ERR_PTR(-EEXIST);
 	}
 
@@ -351,8 +355,11 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
+	if (unlikely(!inode)) {
+		pr_err("out of free dentries, can not create file '%s'\n",
+		       name);
 		return failed_creating(dentry);
+	}
 
 	inode->i_mode = mode;
 	inode->i_private = data;
@@ -513,8 +520,11 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
+	if (unlikely(!inode)) {
+		pr_err("out of free dentries, can not create directory '%s'\n",
+		       name);
 		return failed_creating(dentry);
+	}
 
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_op = &simple_dir_inode_operations;
@@ -552,8 +562,11 @@ struct dentry *debugfs_create_automount(const char *name,
 		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
-	if (unlikely(!inode))
+	if (unlikely(!inode)) {
+		pr_err("out of free dentries, can not create automount '%s'\n",
+		       name);
 		return failed_creating(dentry);
+	}
 
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
@@ -608,6 +621,8 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode)) {
+		pr_err("out of free dentries, can not create symlink '%s'\n",
+		       name);
 		kfree(link);
 		return failed_creating(dentry);
 	}
-- 
2.22.0

