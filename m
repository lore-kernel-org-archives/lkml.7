Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA3BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB001242AC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 22:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNJdtYlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfE2Wn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 18:43:56 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:51000 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfE2Wnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 18:43:55 -0400
Received: by mail-ot1-f74.google.com with SMTP id g22so1840830otp.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nIbdDpuiUQjZb4OOVtvUELzofH+r331C0gYmQQjTD8s=;
        b=HNJdtYlRXOacnDqZhFy07seNksTSHxkHLKaCslX7zj6rNoT61Fe3agZ9GMweLxm4k1
         KUFhb8uxfLZd6zpKnu5nfY+N5Gcg8QqPi4CmM7CHHCCdK11GbDIuHO7v7Ph8fSjl2vKk
         oSrUC7+UAUj1nIDVX/A0Mr1uB/4SSmSN0UMODku96Eof0v8EvLCyBS3BqeprcAM9s2Q7
         Bki5cgH8N3S4m+el+INbFHbEV80SD9bAh1oiuxG7EWu/XvInbZgyLCZT77qoRCGsh/rs
         Th93kSlraPYtinNoWgj6RXL4YweWmGRqJYAucOHDeUWPd9KjPaBGUgxSpmbPKM45YVkb
         JK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nIbdDpuiUQjZb4OOVtvUELzofH+r331C0gYmQQjTD8s=;
        b=k854ojELn86lfqV85bQWsuFsQJDyMFZDvbl9V9DdzypmyZ1w+HU3HzKyRJp6XrBH09
         k9dpzJNoqi/aL2q4e51oJUgBGWztq7UA1OzKX1tF3oi15gpn4djh7E2F9pL26Lw19+bZ
         eDvI5B+FIFG+Z5ETWFWQBJeV2/ocp5xEnvzrKEy9ZoPwT0YnKCHK+QM6dOAhHOh5Ri0T
         gc0rVPGI8Z0X2SgvojOwVnkXX+6nAjSNnTQ8+Rg8V+pDcCoZgku+B7TFxmUxQwGZXw7c
         yQETOXa9OvWDj9v9OHayLgulRzjUBuRuat1pqfdzKyY4JepT7hHdWpN5ng6c+trcPdM7
         mjeQ==
X-Gm-Message-State: APjAAAXG8j3lNwB8G3shB+jp1LFnCmxywFdOUf8WF1l/y49RSrQHY/Nh
        6mZobflvEIJYyp0WC5pw4Ie8ftBDDYQ=
X-Google-Smtp-Source: APXvYqzcHO7uG6P+zg1K9CqC2JHSf3+xaWgVWc+e+9Xnzfzz5jFVoGyxdER7ys0iGExAmYRdjroxX3SMGsY=
X-Received: by 2002:aca:4208:: with SMTP id p8mr479023oia.105.1559169834858;
 Wed, 29 May 2019 15:43:54 -0700 (PDT)
Date:   Wed, 29 May 2019 15:43:50 -0700
Message-Id: <20190529224350.6460-1-mikewu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] Allow to exclude specific file types in LoadPin
From:   Ke Wu <mikewu@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, Ke Wu <mikewu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel already provide MODULE_SIG and KEXEC_VERIFY_SIG to
make sure loaded kernel module and kernel image are trusted. This
patch adds a kernel command line option "loadpin.exclude" which
allows to exclude specific file types from LoadPin. This is useful
when people want to use different mechanisms to verify module and
kernel image while still use LoadPin to protect the integrity of
other files kernel loads.

Signed-off-by: Ke Wu <mikewu@google.com>
---
 Documentation/admin-guide/LSM/LoadPin.rst | 10 ++++++
 security/loadpin/loadpin.c                | 37 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/admin-guide/LSM/LoadPin.rst b/Documentation/admin-guide/LSM/LoadPin.rst
index 32070762d24c..716ad9b23c9a 100644
--- a/Documentation/admin-guide/LSM/LoadPin.rst
+++ b/Documentation/admin-guide/LSM/LoadPin.rst
@@ -19,3 +19,13 @@ block device backing the filesystem is not read-only, a sysctl is
 created to toggle pinning: ``/proc/sys/kernel/loadpin/enabled``. (Having
 a mutable filesystem means pinning is mutable too, but having the
 sysctl allows for easy testing on systems with a mutable filesystem.)
+
+It's also possible to exclude specific file types from LoadPin using kernel
+command line option "``loadpin.exclude``". By default, all files are
+included, but they can be excluded using kernel command line option such
+as "``loadpin.exclude=kernel-module,kexec-image``". This allows to use
+different mechanisms such as ``CONFIG_MODULE_SIG`` and
+``CONFIG_KEXEC_VERIFY_SIG`` to verify kernel module and kernel image while
+still use LoadPin to protect the integrity of other files kernel loads. The
+full list of valid file types can be found in ``kernel_read_file_str``
+defined in ``include/linux/fs.h``.
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 055fb0a64169..8ee0c58fea40 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -45,6 +45,8 @@ static void report_load(const char *origin, struct file *file, char *operation)
 }
 
 static int enforce = IS_ENABLED(CONFIG_SECURITY_LOADPIN_ENFORCE);
+static char *exclude_read_files[READING_MAX_ID];
+static int ignore_read_file_id[READING_MAX_ID];
 static struct super_block *pinned_root;
 static DEFINE_SPINLOCK(pinned_root_spinlock);
 
@@ -129,6 +131,12 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	struct super_block *load_root;
 	const char *origin = kernel_read_file_id_str(id);
 
+	/* If the file id is excluded, ignore the pinning. */
+	if ((unsigned int)id < READING_MAX_ID && ignore_read_file_id[id]) {
+		report_load(origin, file, "pinning-excluded");
+		return 0;
+	}
+
 	/* This handles the older init_module API that has a NULL file. */
 	if (!file) {
 		if (!enforce) {
@@ -187,10 +195,37 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
+static void parse_exclude(void)
+{
+	int i, j;
+	char *cur;
+
+	for (i = 0; i < ARRAY_SIZE(exclude_read_files); i++) {
+		cur = exclude_read_files[i];
+		if (!cur)
+			break;
+		if (*cur == '\0')
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(kernel_read_file_str); j++) {
+			if (strcmp(cur, kernel_read_file_str[j]) == 0) {
+				pr_info("excluding: %s\n",
+					kernel_read_file_str[j]);
+				ignore_read_file_id[j] = 1;
+				/*
+				 * Can not break, because one read_file_str
+				 * may map to more than on read_file_id.
+				 */
+			}
+		}
+	}
+}
+
 static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
+	parse_exclude();
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
 	return 0;
 }
@@ -203,3 +238,5 @@ DEFINE_LSM(loadpin) = {
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
+module_param_array_named(exclude, exclude_read_files, charp, NULL, 0);
+MODULE_PARM_DESC(exclude, "Exclude pinning specific read file types");
-- 
2.22.0.rc1.257.g3120a18244-goog

