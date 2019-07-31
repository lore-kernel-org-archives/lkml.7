Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7F1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CFE206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZCV7mLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfGaWRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:17:39 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:51179 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfGaWRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:36 -0400
Received: by mail-vk1-f202.google.com with SMTP id p196so29966985vke.17
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lAGo2XEfN1Kmsxc7Q91nfXTi8fMC4u4EK30rK7PWIbE=;
        b=FZCV7mLbwgIyfiHg2Uw26K8PzqMs/1VlHh76kTcAH9mnfXS7n/oSsgvblYsFl5auM4
         mBOEFvy28hQLGkmT1c4BZLYH7v0L6tIeCyxfgskIB9st8ur99CzAHj8VpYbqEbfSOcgl
         oNMJxPh+CGcNjgIEiDCLThuyt+DuYEJYYzkozB83eyoL4EAUcqzDzyngBZUHN+Ek+/PA
         fUKYK3gyCrm+tV2dSghSL+ScFBI8kxrLV4nzm9O9pD8hvu++Msi8X++zQZPaeQ3nJIkA
         h1/DwalZk7aHIIyrFM19hqg0RzU6W9pRu+1CCfgn8mlcEsjj1T68cKwEyFLcPECS5+Le
         q39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lAGo2XEfN1Kmsxc7Q91nfXTi8fMC4u4EK30rK7PWIbE=;
        b=tL86VRA59UxVYv3LwzQxPyweJWfY58NgRC9icyVZv9Y6lepEkzlqyHS8L2AH0H2dKQ
         GNAZQVRau/IhIbp9a0npwlh+q8En1uTQ2zvAOkn0Re+LLr08flphtUGjtr5HFblsC6D6
         bZCc6qeLZY2ZDKtJGsb1IdI6TIztbzWuGOvSkbJnhlcGqjiVtWadHjvgYD7SQDJLsjC8
         jVyRx2+87vAM+eOBzJhGe0ipzLr+Y+yivbLJ+7s2M5+SpM7rgxH6ufrpvMC1e7Rtpw+J
         qovsJZk+F83aDhbvMTK/0O40Y/AKoTUvpReINxu1dgWbGI+cy/u92ovjWXocfYJaZYvr
         Fkxg==
X-Gm-Message-State: APjAAAWIiCnyA5ElCHAPf9wRZTPjsmJ5VD9+F1JvW8b9d63EYPe8OE66
        6HbD3ZuPzVRKJY2hsHMGcFSNIeruPmhrhEm0knt85Q==
X-Google-Smtp-Source: APXvYqwG4y0stuCufR4GwC5aczm36WyzPrpRc/G81/aIXNuWHFNCNG8/CzGPDwcxg7tCNmwEPDieuxg7TVbFr1nO5czu5w==
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr78230446vsm.178.1564611455461;
 Wed, 31 Jul 2019 15:17:35 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:15 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 27/29] tracefs: Restrict tracefs when the kernel is locked down
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
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c           | 40 +++++++++++++++++++++++++++++++++++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1387bcd96a79..12a325fb4cbd 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -28,6 +29,23 @@ static struct vfsmount *tracefs_mount;
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
@@ -210,6 +228,12 @@ static int tracefs_apply_options(struct super_block *sb)
 	return 0;
 }
 
+static void tracefs_destroy_inode(struct inode *inode)
+{
+	if (S_ISREG(inode->i_mode))
+		kfree(inode->i_fop);
+}
+
 static int tracefs_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
@@ -236,6 +260,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
+	.destroy_inode  = tracefs_destroy_inode,
 	.show_options	= tracefs_show_options,
 };
 
@@ -372,6 +397,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
 {
+	struct file_operations *proxy_fops;
 	struct dentry *dentry;
 	struct inode *inode;
 
@@ -387,8 +413,20 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (unlikely(!inode))
 		return failed_creating(dentry);
 
+	proxy_fops = kzalloc(sizeof(struct file_operations), GFP_KERNEL);
+	if (unlikely(!proxy_fops)) {
+		iput(inode);
+		return failed_creating(dentry);
+	}
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
2.22.0.770.g0f2c4a37fd-goog

