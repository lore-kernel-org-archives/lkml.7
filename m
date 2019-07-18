Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EBAC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F821849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJVURdWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404129AbfGRTpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:45:32 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53889 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404051AbfGRTp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:45:29 -0400
Received: by mail-pg1-f202.google.com with SMTP id t18so7276362pgu.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j3nn5hRZeIqfdvoyAD9pNEqNChax2SmcCFqA2+Cmtpw=;
        b=XJVURdWVOwgODHxQLMjM3byv8DA2jupZcFnfIHo9SFz06XKCreNWN3m2MtPVhRQ53N
         SvieYr+5uEDixvvFLj7q00UDVbZdCDEN2VWIVJWawkd8kKHun/R5tp1uQMu3hwN9L2O9
         z550LTbUWaWeGSSRSAnlOzpI9Pmcf5FMbL9i2sJM8EH41I6URLd5fL6Z4/T1N7CK5Fst
         FV3Cn4Tg3DsoZLci0wstfNgk+RmENOzBP2Q8MNk2IhqUA7Cuih1CdHHMeWwBjCcXIX5F
         WK/UfGuAWKEE000roHFoR6DmPT7Z3E2JnUvBk5PuZeWuYLm7TcDrVJddxAGsRnk4B6sR
         Dh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j3nn5hRZeIqfdvoyAD9pNEqNChax2SmcCFqA2+Cmtpw=;
        b=qLY6UxKZAXunwPJ69MHfFB+8UW3ZPcO9btFuR3CgKW5KbXMhwxDXSoRdJBU9yltypk
         76fyZ3bYjdqlKZF3LLdsLwBNzNHlYEHpwN2ofK6zG0Fp1lt+Fyow1dXDCTh5xV4erLyw
         ULyxFTv5ndK/TmyXMszFaIZezNdrTHPSbLZie2OITQAvY7Xhp5ob6h7NeR8zU8YWv+T3
         x+gBfB9rjNyTRLg1J+jD/pmOba3SLsOrdx5d2UdLNEEmMWrNOji7WiZCD5Wl5Fq4gcRE
         7wLIS3ESTMLxf9rDUFLhp1KKtNEmiHQgoN3+aq6izn0/JnfZbEg4OpI68Wzc4FsjjOJ1
         W6Ag==
X-Gm-Message-State: APjAAAVl1mV+a4RtrHKz1J3CXdLO/3nwZdp3+L4iiWOmiYf4qFLjVGY8
        firAPQfxH9jIsQdizdBjYAlMD5fCs8NItZ83UNdPgw==
X-Google-Smtp-Source: APXvYqwDCQkrtprdzU8GeNmhKe+1ODFIpVY3I637IYrTCiRLMsYudmZs0KuxmblJGsiMtK25EcKySFVFbB7os/Y8v1Za/Q==
X-Received: by 2002:a63:dd0b:: with SMTP id t11mr8877353pgg.410.1563479128402;
 Thu, 18 Jul 2019 12:45:28 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:13 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 27/29] tracefs: Restrict tracefs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
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
 fs/tracefs/inode.c           | 38 +++++++++++++++++++++++++++++++++++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index eeeae0475da9..8a20137e1d8f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -27,6 +28,23 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static int default_open_file(struct inode *inode, struct file *filp)
+{
+	struct dentry *dentry = filp->f_path.dentry;
+	struct file_operations *real_fops;
+	int ret;
+
+	if (!dentry)
+		return -EINVAL;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	real_fops = dentry->d_fsdata;
+	return real_fops->open(inode, filp);
+}
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -221,6 +239,12 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
+static void tracefs_destroy_inode(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		kfree(inode->i_fop);
+}
+
 static int tracefs_remount(struct super_block *sb, int *flags, char *data)
 {
 	int err;
@@ -256,6 +280,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
+	.destroy_inode  = tracefs_destroy_inode,
 	.remount_fs	= tracefs_remount,
 	.show_options	= tracefs_show_options,
 };
@@ -387,6 +412,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
 {
+	struct file_operations *proxy_fops;
 	struct dentry *dentry;
 	struct inode *inode;
 
@@ -402,8 +428,18 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
+	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
+	if (!proxy_fops)
+		return failed_creating(dentry);
+
+	if (!fops)
+		fops = &tracefs_file_operations;
+
+	dentry->d_fsdata = (void *)fops;
+	memcpy(proxy_fops, fops, sizeof(*proxy_fops));
+	proxy_fops->open = default_open_file;
 	inode->i_mode = mode;
-	inode->i_fop = fops ? fops : &tracefs_file_operations;
+	inode->i_fop = proxy_fops;
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
diff --git a/include/linux/security.h b/include/linux/security.h
index d92323b44a3f..807dc0d24982 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -121,6 +121,7 @@ enum lockdown_reason {
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF_READ,
 	LOCKDOWN_PERF,
+	LOCKDOWN_TRACEFS,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 88064ce1c844..173191562047 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -36,6 +36,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
 	[LOCKDOWN_PERF] = "unsafe use of perf",
+	[LOCKDOWN_TRACEFS] = "use of tracefs",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.510.g264f2c817a-goog

