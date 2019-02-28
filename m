Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A84C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2431F20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367916;
	bh=1IIk6XIx7k+qSdumUby1AWzknyn7Bvt2OsBKS3zjzrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KdxziVI9pkiSVO/2KIgPewAGYLBvh1TMC/mE+QKwR39qE4OUkFksH8/Ez1IPVICBm
	 aqubumdsMkrwZvAt988AGSoZVCMHjJfkl0mYdzDIXfL4wKLeNO/xIvETG0t8wSvTrN
	 sO5A0z4PzRMuJWQUHW39LbZ47EJD8+LMLq4lOmg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbfB1Pbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:31:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387444AbfB1PJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:09:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7629218CD;
        Thu, 28 Feb 2019 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366546;
        bh=1IIk6XIx7k+qSdumUby1AWzknyn7Bvt2OsBKS3zjzrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWH8rPGmY2g6vZceNQa1GTW6WIbGe/uuLCjt977mNqBCWOkQs+eHQqM9Wq/xLQcwx
         pnsiSAlxfKyvaBMdZZs6fVzHPVRJb6TcAvJTeqs93ggydJ0Ugq2NH9g3MqMbL28/kX
         o1viGmb4mEX9QdPJWD0smDQRdbvuFEH0gAo7IJGw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 34/81] debugfs: return error values, not NULL
Date:   Thu, 28 Feb 2019 10:07:26 -0500
Message-Id: <20190228150813.10256-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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
index 41ef452c1fcfb..b16f8035b1af7 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -254,8 +254,8 @@ MODULE_ALIAS_FS("debugfs");
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
@@ -265,17 +265,17 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 
 	if (IS_ERR(parent))
-		return NULL;
+		return parent;
 
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
 	dentry = lookup_one_len_unlocked(name, parent, strlen(name));
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
@@ -324,7 +324,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 static struct dentry *end_creating(struct dentry *dentry)
@@ -347,7 +347,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
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
@@ -827,7 +830,9 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
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

