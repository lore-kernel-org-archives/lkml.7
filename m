Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D9C206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367290;
	bh=GaWL7+u9Gm3PsGTD9hfc5R3D6fb31GT0b8Md8Ucp3TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pE9olY0ARu4h0+msbkKEE9SqMq1gxLAbORSlVhkS3KoE53/e1zeDzw0Ls6vygAZrA
	 yk6P03Xw9voqCPkglxqNwf+rpRt8EEv8UlMySLQb0NHbAENQsKCyjABjZvRZBDxtPS
	 ihjYw52XtU7yk78kUx185hDVeHWaaglIzDBjslGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfB1PV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:21:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388555AbfB1PN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F62218FC;
        Thu, 28 Feb 2019 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366834;
        bh=GaWL7+u9Gm3PsGTD9hfc5R3D6fb31GT0b8Md8Ucp3TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skn1NRJ7rZhXy+Oq3z2n7ckRctKocb+y9nKI9YK7qVGV28WC9A+138ZzX+PBmPvlj
         zlPstbYHJKQDmbJZHypHfv+EnFSAkCklQU+jQUmi1wpFn/N9ROl65v7RjBhAnLZVk+
         dwXuA6EixUZTYvBrEfQuN+5o0jdVWydBsBusR4bg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 10/36] debugfs: return error values, not NULL
Date:   Thu, 28 Feb 2019 10:13:11 -0500
Message-Id: <20190228151337.12176-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151337.12176-1-sashal@kernel.org>
References: <20190228151337.12176-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit ff9fb72bc07705c00795ca48631f7fffe24d2c6b ]

When an error happens, debugfs should return an error pointer value, not
NULL.  This will prevent the totally theoretical error where a debugfs
call fails due to lack of memory, returning NULL, and that dentry value
is then passed to another debugfs call, which would end up succeeding,
creating a file at the root of the debugfs tree, but would then be
impossible to remove (because you can not remove the directory NULL).

So, to make everyone happy, always return errors, this makes the users
of debugfs much simpler (they do not have to ever check the return
value), and everyone can rest easy.

Reported-by: Gary R Hook <ghook@amd.com>
Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Michal Hocko <mhocko@kernel.org>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/inode.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index ccfe1e1cb6bc3..0bbe2df9077c6 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -252,8 +252,8 @@ MODULE_ALIAS_FS("debugfs");
  * @parent: a pointer to the parent dentry of the file.
  *
  * This function will return a pointer to a dentry if it succeeds.  If the file
- * doesn't exist or an error occurs, %NULL will be returned.  The returned
- * dentry must be passed to dput() when it is no longer needed.
+ * doesn't exist or an error occurs, %ERR_PTR(-ERROR) will be returned.  The
+ * returned dentry must be passed to dput() when it is no longer needed.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -263,7 +263,7 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 
 	if (IS_ERR(parent))
-		return NULL;
+		return parent;
 
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
@@ -273,10 +273,10 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	inode_unlock(d_inode(parent));
 
 	if (IS_ERR(dentry))
-		return NULL;
+		return dentry;
 	if (!d_really_is_positive(dentry)) {
 		dput(dentry);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	return dentry;
 }
@@ -325,7 +325,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 static struct dentry *end_creating(struct dentry *dentry)
@@ -348,7 +348,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	dentry = start_creating(name, parent);
 
 	if (IS_ERR(dentry))
-		return NULL;
+		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -386,7 +386,8 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -464,7 +465,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -495,7 +497,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -506,7 +509,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
-		return NULL;
+		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -545,7 +548,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
-		return NULL;
+		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -581,8 +584,8 @@ EXPORT_SYMBOL(debugfs_create_automount);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the symbolic
  * link is to be removed (no automatic cleanup happens if your module is
- * unloaded, you are responsible here.)  If an error occurs, %NULL will be
- * returned.
+ * unloaded, you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR)
+ * will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -594,12 +597,12 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	struct inode *inode;
 	char *link = kstrdup(target, GFP_KERNEL);
 	if (!link)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	dentry = start_creating(name, parent);
 	if (IS_ERR(dentry)) {
 		kfree(link);
-		return NULL;
+		return dentry;
 	}
 
 	inode = debugfs_get_inode(dentry->d_sb);
@@ -806,7 +809,9 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 	if (dentry && !IS_ERR(dentry))
 		dput(dentry);
 	unlock_rename(new_dir, old_dir);
-	return NULL;
+	if (IS_ERR(dentry))
+		return dentry;
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(debugfs_rename);
 
-- 
2.19.1

