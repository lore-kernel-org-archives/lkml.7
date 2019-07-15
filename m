Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9127C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8477720659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaIqn5n2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbfGOUBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:01:25 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42636 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732745AbfGOUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:01:05 -0400
Received: by mail-pf1-f201.google.com with SMTP id 21so10848532pfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tkMY5oaKzsB1Pqxhl3bO3jhBsQDfIdKwMj02mn1y4qc=;
        b=gaIqn5n2zaAML3AcWDxxFLtVKFE2mxwCCzBUkP/chMhNRpUHfCJwX8zK+3rutqXATC
         /cMfRHB6XJz2FZWFr87AFUcsJfzA2tAcBQPMBEnqJuGd1netSwRImF5pTDbRRaR5DAIV
         T1ugwqG7EHCm8uKIueDC8PA/lmKT9LjJ2DTS54K9Vjds/N3jpWykUKk2eqh7d3SC/ydY
         5hPh6oDnA6KdmmHary9oDLdnqgXIqv7Xm9qtC1W/G4jUpfJX0kCApNeRkpiP8lmho0+z
         pT11fdn5YiLqQyPtjadDGcE3q/uH2y/M8ax4lwKLBpRWO0cLUYgEKzii7kaOODHlHEVy
         wI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tkMY5oaKzsB1Pqxhl3bO3jhBsQDfIdKwMj02mn1y4qc=;
        b=mbzirJrvaeyhBeezQy38rBAEzpvne4P8mwDtgWeSuGzEL+P9Muur3zW7yNeuEfk9tj
         zkhWu20/Eu++2oeeFtgJRYPdiO8LzmFXJbrbxhF0ujDYQZ2CjqpIk0gJE9VLbT8FGlVw
         MGQtCdWwly65qg64fyfLl/KQ28bzNDKHjgLQdVvTbK1b4fCByBfa0IGGyuacPNS+7MaG
         iHD6U002EMwiL+GMH3SwveTjak6Ca011+a6thTsmO16BBGq76dDPgDfEmNBXTImw00JL
         28ZlZqmxl6ZFqNijarBA/wrQL13p2TuwcM11Z7TaHGxbTseys5z3QnknviBluq6tY5/M
         9o1Q==
X-Gm-Message-State: APjAAAUP6qp7v0mR+ZH2tdDlWnOyPHuNqFA4ETf5FScwjweQZQgi3TO1
        c+zzal+mR0WBnJvZAyCc4RyywSMzAWWPo4icudfZAQ==
X-Google-Smtp-Source: APXvYqxK0dFi/fS4M8pEnYmQwGYG1r9vWj+oqdoSezkRwICSEdjfjPf9nn5i3PDLYlzh4gi//XvIQfu3ZuuF2/nRph4rPw==
X-Received: by 2002:a65:5082:: with SMTP id r2mr3913629pgp.170.1563220864659;
 Mon, 15 Jul 2019 13:01:04 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:44 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 27/29] tracefs: Restrict tracefs when the kernel is locked down
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
index eeeae0475da9..4c04c0c89514 100644
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
@@ -389,6 +414,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 {
 	struct dentry *dentry;
 	struct inode *inode;
+	struct file_operations *proxy_fops;
 
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
@@ -402,8 +428,18 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
+	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
+	if (!proxy_fops)
+		return failed_creating(dentry);
+
+	if (fops)
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
index 37ef46320ef4..fd7cdbddd814 100644
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

