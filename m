Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF9CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088082177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrR284Sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfDDAeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:34:07 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:48844 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfDDAeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:34:05 -0400
Received: by mail-qt1-f202.google.com with SMTP id 54so790913qtn.15
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oJN/8vrOD8P2EbLKMtCZWob1U7HL7tDO5O5Qy0qbLZY=;
        b=ZrR284SvWcC7W7DKhrssZkI3UOeYBGUqL32MCAYDqsPO6wWcT70fQ17WUOFw6skt14
         cz9Of0GbzyW5RkL5N0bOWU/UPd/Jt9jpsTPPV6e3jpgNBE6bBMq4h51fDkALLFqPg4oG
         gQ93oDF/DPrxKjE4COy8qk3nV0qDGS7Wb209mnJBR7U73e86HgdnC+2B2WarfuBohgpe
         eWPT05bF/kBEDq6oU1AcSg9rajqGC2V7tGOKGNeyaoKWO0ntauwei7Ups4PU2yf+pHU4
         6nOoS8gk3GS3kvfGxSCLkzw5f+x8DT70rDUabPzitghw7iDMJu5AIazyzvoArmh5bKyy
         z5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oJN/8vrOD8P2EbLKMtCZWob1U7HL7tDO5O5Qy0qbLZY=;
        b=W1tRWIQErNOtftVtP4kqklhC8I9JDNBd4YaS/G4CFePp2zCG+Lcbw4ob17kJbDty0w
         +4BubcSPuzuvyOO4ojkFenpdDn9ZiDHcSPyD95tGh4aMwjN87UC44Unt/7kqUSIsVRhj
         hHUqzofIN7fSQPQUscZgwG+fos53E1FWuzgbPFpu32wyCiJsc8s+F2LkL0hQGYykFGAY
         NqllRUaXo/e6TeeWYyQpwzjaY67egKDHBvpWQ2EVBNFlZPZMCA78Za6niRc/T26jUXYN
         waAZiEsDOaFXiu+J2qk1ivDhwOygrTUPuS/L/oIAwnZPYUj79lgw4DSpTry7QOlnsZ7/
         1GDA==
X-Gm-Message-State: APjAAAVOqxd+tf7mwIObw+J7mlae2rft70uf5WWebpplXW6zu/IHNmWF
        uKq0gqCUckLNY6sPEJmLTLacZBaaCZ0HaBnz2E6T6A==
X-Google-Smtp-Source: APXvYqwIdvzciKq2xx+gIDu8qCgK0TJ3kdOf1zNlqkenTNUc+eQx8nRjGv9C414rQvslhXgFmvvx+DwLAVwXPlUYdnNR/w==
X-Received: by 2002:ac8:1812:: with SMTP id q18mr498916qtj.29.1554338044162;
 Wed, 03 Apr 2019 17:34:04 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:49 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 27/27] tracefs: Restrict tracefs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracefs may release more information about the kernel than desirable, so
restrict it when the kernel is locked down in confidentiality mode by
preventing open().

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7098c49f3693..576327ffd9d1 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -31,6 +31,21 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static int default_open_file(struct inode *inode, struct file *filp)
+{
+	struct dentry *dentry = filp->f_path.dentry;
+	struct file_operations *real_fops;
+
+	if (!dentry)
+		return -EINVAL;
+
+	if (kernel_is_locked_down("tracefs", LOCKDOWN_CONFIDENTIALITY))
+		return -EPERM;
+
+	real_fops = dentry->d_fsdata;
+	return real_fops->open(inode, filp);
+}
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -50,6 +65,13 @@ static const struct file_operations tracefs_file_operations = {
 	.llseek =	noop_llseek,
 };
 
+static const struct file_operations tracefs_proxy_file_operations = {
+	.read =		default_read_file,
+	.write =	default_write_file,
+	.open =		default_open_file,
+	.llseek =	noop_llseek,
+};
+
 static struct tracefs_dir_ops {
 	int (*mkdir)(const char *name);
 	int (*rmdir)(const char *name);
@@ -225,6 +247,12 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
+static void tracefs_destroy_inode(struct inode *inode)
+{
+	if S_ISREG(inode->i_mode)
+		kfree(inode->i_fop);
+}
+
 static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 {
 	int err;
@@ -260,6 +288,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
+	.destroy_inode  = tracefs_destroy_inode,
 	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
 };
@@ -393,6 +422,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 {
 	struct dentry *dentry;
 	struct inode *inode;
+	struct file_operations *proxy_fops;
 
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
@@ -406,8 +436,16 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
+	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
+	if (!proxy_fops)
+		return failed_creating(dentry);
+
+	dentry->d_fsdata = fops ? (void *)fops :
+		(void *)&tracefs_file_operations;
+	memcpy(proxy_fops, dentry->d_fsdata, sizeof(struct file_operations));
+	proxy_fops->open = default_open_file;
 	inode->i_mode = mode;
-	inode->i_fop = fops ? fops : &tracefs_file_operations;
+	inode->i_fop = proxy_fops;
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
-- 
2.21.0.392.gf8f6787159e-goog

