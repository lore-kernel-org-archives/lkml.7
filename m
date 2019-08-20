Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBACDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C17E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ki32HG1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfHTATk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:40 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:46213 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfHTATV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:21 -0400
Received: by mail-qt1-f202.google.com with SMTP id 91so5502705qtf.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E/8lxpa+z9gpk902pktPpF9+LvVfvzv2LPOai6lyIA8=;
        b=ki32HG1Lt+kDZ4xqLXAqrphwvRc6t8Zs3IP8LuTejJP2ls3nnCSqYV+kWDWtD1KJdm
         F+qerCkbZ/mUd9eh1jiWAYlEbOsETYPfSEnVSErV+4Jwpol24+hBCLOMzKwMgBVY9IPz
         AhqRBz/71g7hR4023qfnkTX04kGya2UdaPFAg48yVFbvxf7ThG7LV98r5q9MSiQF2CN0
         X59EsPvMRkSM5nUAtZZA6BYVME312lKGXDJPHyBsA57j9fcmqLyS5lOtYnoPP/DUpZhF
         5iNoDSQt5B5DNMjCS1HYAzFWKRMCpJCXC2HaG67ksSZZKEnwEO9gb+sMmU0PW1vRLwQt
         lgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E/8lxpa+z9gpk902pktPpF9+LvVfvzv2LPOai6lyIA8=;
        b=ZFbnXJHUPwtt42dZ56lSp/QgS3g7W1861K3C4OD/rSatnLxwRcESrNCy+K7O3TQ5ts
         Hux+JCemm6qN0VNffKBecrztDlnjAbkGW0Qt6pAsW0nrqCto8Ff5o3Ga8BWdAIRABTw/
         tUF1vYVGt0HNJCa/idbTQW4ktihtb29MTejXlkvavSrVlQCmwRBcDCeu88D4waCS5bLV
         rau9Wxn7r/0abhpHBg9On7sSvWuBugoGV9zBsU6b/2CB8M9kQ6wIqEaCWcpeb5lyaKF5
         +/r+E8XE+wV+CSMe3VHNnHJo4zwkvd0ZVhzCoU70nr3AS+9PCsnfxGMP9Prg6qrQ4StP
         Fjsg==
X-Gm-Message-State: APjAAAWvI1ZuU3Kz7n9/iPj6woT3v6X7FPaqEA3li5omiClocIEbzBak
        u6QVXy+XHL5FIyup/2IDwi7M0YjDSCb7ZjAqFws2Ng==
X-Google-Smtp-Source: APXvYqztleIRbRcbpXBmYM4c4AJSbmimT9FnLOPfTw/asgECj1CP5qEP9eMAydOT9csQ1LM0G9MECP3GjI1ZtxYAcQF40g==
X-Received: by 2002:a37:dc45:: with SMTP id v66mr23222456qki.24.1566260359977;
 Mon, 19 Aug 2019 17:19:19 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:18:03 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-28-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 27/29] tracefs: Restrict tracefs when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracefs may release more information about the kernel than desirable, so
restrict it when the kernel is locked down in confidentiality mode by
preventing open().

(Fixed by Ben Hutchings to avoid a null dereference in
default_file_open())

Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
---
 fs/tracefs/inode.c           | 42 +++++++++++++++++++++++++++++++++++-
 include/linux/security.h     |  1 +
 security/lockdown/lockdown.c |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index a5bab190a297..761af8ce4015 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 #define TRACEFS_DEFAULT_MODE	0700
 
@@ -27,6 +28,25 @@ static struct vfsmount *tracefs_mount;
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
+	if (!real_fops->open)
+		return 0;
+	return real_fops->open(inode, filp);
+}
+
 static ssize_t default_read_file(struct file *file, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
@@ -221,6 +241,12 @@ static int tracefs_apply_options(struct super_block *sb)
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
@@ -257,6 +283,7 @@ static int tracefs_show_options(struct seq_file *m, struct dentry *root)
 static const struct super_operations tracefs_super_operations = {
 	.statfs		= simple_statfs,
 	.remount_fs	= tracefs_remount,
+	.destroy_inode  = tracefs_destroy_inode,
 	.show_options	= tracefs_show_options,
 };
 
@@ -387,6 +414,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops)
 {
+	struct file_operations *proxy_fops;
 	struct dentry *dentry;
 	struct inode *inode;
 
@@ -402,8 +430,20 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
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
index 152824b6f456..429f9f03372b 100644
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
index edd1fff0147d..84df03b1f5a7 100644
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
2.23.0.rc1.153.gdeed80330f-goog

