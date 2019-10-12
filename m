Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D716C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08DB20679
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ic3TEmp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfJLTQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:16:18 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49538 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfJLTQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:16:17 -0400
Received: by mail-pf1-f202.google.com with SMTP id i28so10213126pfq.16
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XBcGefgr1yRisxJT4NE2JQJYpjj8lNWOfHcCyIG9KpI=;
        b=ic3TEmp3rq98da85M0YYxffLPJvBhxV5otcPnbDFdiP+s7Ef//5umgryYUQiJhRRVc
         FT4Jo2Q1EgG3q99Fgn0tEZnoIJq2F1Llk+odHuy81UCsDt4oKoBRd7vjPcAtRTjpukXs
         fN98NDbm4+rlXNgAoBJ4uzE05o6FTuVkKPVbVulo3cdZM+xt1U6m1GWenQXYhFxiGS31
         oOGM3xpxZUqkui0wZMby25jHolu5GkruCZEN3GPddD7J3xnPuWEOEJqfT7mullE9HB82
         Dzo5lzCc7D/Ns/zuEqEjrMCIh6RPg70YAXULNkgiWhsCW7QF3o+3C4s7isky1arH81Io
         wohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XBcGefgr1yRisxJT4NE2JQJYpjj8lNWOfHcCyIG9KpI=;
        b=AUYhX1YEnG4IDn6O9jVHJedhLFq/8L2amWRls1q55qXs7VVIxc0CjH/5jZ6zPBRoVe
         29IDTTFhr5fHEn+ogTHJSwmjn3MnCUlAffa8qktXG3NVqRRSkljkbb/ZFpLZNytrWj6p
         aou+5sV0xduUe53QafO1Miz+BkLYR+O76Vl3eF230Iq53AYQQvhJ3p4NSZolH4ez1oFG
         vvBrFB39PkIb1AJ6VeuKhcspqy2i8Moq6baxji2tXFr4wIXiJPPuEeFLWqecXeHy8yi0
         oBGig5IH4iKRBygrvLaluzuKuvlLmoELAlLmt/1os07MmNfzigfjFHwGFwj5zVKjXzt3
         /YfQ==
X-Gm-Message-State: APjAAAVAzgM07oEQZbIV9Hwhv3oGHttaQE0RJ8mATcDLQphj31yklP8p
        JzS5SdI3m0Lo4BPTxRgK7vm5B0epI9s=
X-Google-Smtp-Source: APXvYqyjtLhKOlLs/X/TM4D1BsJHFx6ZCWxIVVOSH2sl3Mizifjdv2koxAijNACLcV4zc532tKNHFwEaKX8=
X-Received: by 2002:a63:383:: with SMTP id 125mr24098053pgd.41.1570907774844;
 Sat, 12 Oct 2019 12:16:14 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:15:57 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-3-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 2/7] Add a concept of a "secure" anonymous file
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A secure anonymous file is one we hooked up to its own inode (as
opposed to the shared inode we use for non-secure anonymous files). A
new selinux hook gives security modules a chance to initialize, label,
and veto the creation of these secure anonymous files. Security
modules had limit ability to interact with non-secure anonymous files
due to all of these files sharing a single inode.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/anon_inodes.c          | 45 ++++++++++++++++++++++++++++++---------
 include/linux/lsm_hooks.h |  8 +++++++
 include/linux/security.h  |  2 ++
 security/security.c       |  8 +++++++
 4 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index caa36019afca..d68d76523ad3 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,6 +55,23 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
+struct inode *anon_inode_make_secure_inode(const char *name,
+					   const struct file_operations *fops)
+{
+	struct inode *inode;
+	int error;
+	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	if (IS_ERR(inode))
+		return ERR_PTR(PTR_ERR(inode));
+	inode->i_flags &= ~S_PRIVATE;
+	error =	security_inode_init_security_anon(inode, name, fops);
+	if (error) {
+		iput(inode);
+		return ERR_PTR(error);
+	}
+	return inode;
+}
+
 /**
  * anon_inode_getfile2 - creates a new file instance by hooking it up to
  *                       an anonymous inode, and a dentry that describe
@@ -72,7 +89,9 @@ static struct file_system_type anon_inode_fs_type = {
  * hence saving memory and avoiding code duplication for the file/inode/dentry
  * setup.  Returns the newly created file* or an error pointer.
  *
- * anon_inode_flags must be zero.
+ * If anon_inode_flags contains ANON_INODE_SECURE, create a new inode
+ * and enable security checks for it. Otherwise, attach a new file to
+ * a singleton placeholder inode with security checks disabled.
  */
 struct file *anon_inode_getfile2(const char *name,
 				 const struct file_operations *fops,
@@ -81,17 +100,23 @@ struct file *anon_inode_getfile2(const char *name,
 	struct inode *inode;
 	struct file *file;
 
-	if (anon_inode_flags)
+	if (anon_inode_flags & ~ANON_INODE_SECURE)
 		return ERR_PTR(-EINVAL);
 
-	inode =	anon_inode_inode;
-	if (IS_ERR(inode))
-		return ERR_PTR(-ENODEV);
-	/*
-	 * We know the anon_inode inode count is always
-	 * greater than zero, so ihold() is safe.
-	 */
-	ihold(inode);
+	if (anon_inode_flags & ANON_INODE_SECURE) {
+		inode =	anon_inode_make_secure_inode(name, fops);
+		if (IS_ERR(inode))
+			return ERR_PTR(PTR_ERR(inode));
+	} else {
+		inode =	anon_inode_inode;
+		if (IS_ERR(inode))
+			return ERR_PTR(-ENODEV);
+		/*
+		 * We know the anon_inode inode count is always
+		 * greater than zero, so ihold() is safe.
+		 */
+		ihold(inode);
+	}
 
 	if (fops->owner && !try_module_get(fops->owner)) {
 		file = ERR_PTR(-ENOENT);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a3763247547c..3744ce9e9172 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -215,6 +215,10 @@
  *	Returns 0 if @name and @value have been successfully set,
  *	-EOPNOTSUPP if no security attribute is needed, or
  *	-ENOMEM on memory allocation failure.
+ * @inode_init_security_anon:
+ *      Set up a secure anonymous inode.
+ *	Returns 0 on success. Returns -EPERM if	the security module denies
+ *	the creation of this inode.
  * @inode_create:
  *	Check permission to create a regular file.
  *	@dir contains inode structure of the parent of the new file.
@@ -1552,6 +1556,9 @@ union security_list_options {
 					const struct qstr *qstr,
 					const char **name, void **value,
 					size_t *len);
+	int (*inode_init_security_anon)(struct inode *inode,
+					const char *name,
+					const struct file_operations *fops);
 	int (*inode_create)(struct inode *dir, struct dentry *dentry,
 				umode_t mode);
 	int (*inode_link)(struct dentry *old_dentry, struct inode *dir,
@@ -1876,6 +1883,7 @@ struct security_hook_heads {
 	struct hlist_head inode_alloc_security;
 	struct hlist_head inode_free_security;
 	struct hlist_head inode_init_security;
+	struct hlist_head inode_init_security_anon;
 	struct hlist_head inode_create;
 	struct hlist_head inode_link;
 	struct hlist_head inode_unlink;
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d612d27..5b6f7e0de577 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -315,6 +315,8 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_inode_init_security_anon(struct inode *inode, const char *name,
+				      const struct file_operations *fops);
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len);
diff --git a/security/security.c b/security/security.c
index 1bc000f834e2..c87695f66413 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1001,6 +1001,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+int
+security_inode_init_security_anon(struct inode *inode,
+				  const char *name,
+				  const struct file_operations *fops)
+{
+	return call_int_hook(inode_init_security_anon, 0, inode, name, fops);
+}
+
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
-- 
2.23.0.700.g56cf767bdb-goog

