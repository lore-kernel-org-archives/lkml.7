Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E522C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C819521773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcQqaXWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfEUWkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 18:40:23 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:56388 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfEUWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 18:40:22 -0400
Received: by mail-oi1-f201.google.com with SMTP id b10so204207oie.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8SqzjktYdSolKelsIc3Thg9RmyEnmv2PTnsSYE0WIFo=;
        b=jcQqaXWtvQ2h0NJyn6JW+nurPh0CM7Qa8pFiJGNcXJTFKI3DpA5o7ERCvDZa0ALUI1
         6BKSjHD3Q+oqZXoPc8vK+zskEcJG3jEfwkUNRXu1hcIYzP1ARgfqrplNqnQV3Y0ADFLe
         UWgghFXK8vtA5jTQtzH7PdxdyPzEM/+IoHtfDbwSo4VsD4aDk0DOGtQQEdWkd6w912ic
         38WfPbQfuOieRG3/ls7U+vuDQa1CQ0K7dh7K3Ylkz4HyxRxi7pm4mn4s68zbhzRhJQQa
         2brxRcSwoPBr3E2iMUliZ9CUJLTnqgOQyeWvKintWtgcfuGw+XnOz5Ry8Z9F37ULNn15
         9W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8SqzjktYdSolKelsIc3Thg9RmyEnmv2PTnsSYE0WIFo=;
        b=TLGyaVl5Cd1oamkpa5mxpJDbsFbjw9hTvQlAzEMoTpkbSrZiyJVP8oiXgEsN9tu8C4
         gwfWJgsR+LlrZaCSqVaCg3b1HO+lRAD6H3AkXiwCUt92F7jCeRl/FwtMENqxPbpA3/gA
         e4qiYU1bAenbWRSzQgPexkIWyGcbWxom8i151W3toYzWhW8rG3UAhKNSdNE2/zq+/jIj
         IEOxbxTDLMmhIiVnPctlbLzTyB9fFmWJFNIwha69J/MMuDXOvxMiHYOxBrQWaxMw+D1z
         efqfkLltdl/aHOfowJHXkWVjR98CED+UVhNJongcxEkRms1CAizzMM90fjZgkizoPXp6
         Ygog==
X-Gm-Message-State: APjAAAVOdJXT9IArfUNbKiv/qzPELl8yI38RzXQyzwvImPMCkW46XFYZ
        rjdWylszDvOZ5nu64Kaj4kU9io1r+6NLhCiZN3zMdg==
X-Google-Smtp-Source: APXvYqzZAw4VXdyVZVuynhp+UJpQQmV7L3VIA+LOCo4vIXMDk7QfMNeme3W/g6dVs5s3vjQoh0WUG16dacFLPSrost4Nvw==
X-Received: by 2002:aca:c057:: with SMTP id q84mr2894973oif.135.1558478420669;
 Tue, 21 May 2019 15:40:20 -0700 (PDT)
Date:   Tue, 21 May 2019 15:40:13 -0700
In-Reply-To: <20190521224013.3782-1-matthewgarrett@google.com>
Message-Id: <20190521224013.3782-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190521224013.3782-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC 2/2] Add the ability to lock down access to the running kernel image
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Provide a single call to allow kernel code to determine whether the system
should be locked down, thereby disallowing various accesses that might
allow the running kernel image to be changed including the loading of
modules that aren't validly signed with a key we recognise, fiddling with
MSR registers and disallowing hibernation.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 Documentation/ABI/testing/lockdown            |  19 +++
 .../admin-guide/kernel-parameters.txt         |   9 +
 Documentation/admin-guide/lockdown.rst        |  60 +++++++
 include/linux/kernel.h                        |   7 +
 include/linux/lsm_hooks.h                     |   2 +
 include/linux/security.h                      |   6 +-
 security/Kconfig                              |   3 +-
 security/Makefile                             |   2 +
 security/lockdown/Kconfig                     |  46 +++++
 security/lockdown/Makefile                    |   1 +
 security/lockdown/lockdown.c                  | 157 ++++++++++++++++++
 security/security.c                           |   6 +
 12 files changed, 316 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/lockdown
 create mode 100644 Documentation/admin-guide/lockdown.rst
 create mode 100644 security/lockdown/Kconfig
 create mode 100644 security/lockdown/Makefile
 create mode 100644 security/lockdown/lockdown.c

diff --git a/Documentation/ABI/testing/lockdown b/Documentation/ABI/testing/lockdown
new file mode 100644
index 000000000000..5bd51e20917a
--- /dev/null
+++ b/Documentation/ABI/testing/lockdown
@@ -0,0 +1,19 @@
+What:		security/lockdown
+Date:		March 2019
+Contact:	Matthew Garrett <mjg59@google.com>
+Description:
+		If CONFIG_LOCK_DOWN_KERNEL is enabled, the kernel can be
+		moved to a more locked down state at runtime by writing to
+		this attribute. Valid values are:
+
+		integrity:
+			The kernel will disable functionality that allows
+			userland to modify the running kernel image, other
+			than through the loading or execution of appropriately
+			signed objects.
+
+		confidentiality:
+			The kernel will disable all functionality disabled by
+			the integrity mode, but additionally will disable
+			features that potentially permit userland to obtain
+			confidential information stored within the kernel.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91c0251fdb86..594d268d92ba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2213,6 +2213,15 @@
 	lockd.nlm_udpport=M	[NFS] Assign UDP port.
 			Format: <integer>
 
+	lockdown=	[SECURITY]
+			{ integrity | confidentiality }
+			Enable the kernel lockdown feature. If set to
+			integrity, kernel features that allow userland to
+			modify the running kernel are disabled. If set to
+			confidentiality, kernel features that allow userland
+			to extract confidential information from the kernel
+			are also disabled.
+
 	locktorture.nreaders_stress= [KNL]
 			Set the number of locking read-acquisition kthreads.
 			Defaults to being automatically set based on the
diff --git a/Documentation/admin-guide/lockdown.rst b/Documentation/admin-guide/lockdown.rst
new file mode 100644
index 000000000000..d05dcedd20d1
--- /dev/null
+++ b/Documentation/admin-guide/lockdown.rst
@@ -0,0 +1,60 @@
+Kernel lockdown functionality
+-----------------------------
+
+.. CONTENTS
+..
+.. - Overview.
+.. - Enabling Lockdown.
+
+========
+Overview
+========
+
+Traditionally Linux systems have been run with the presumption that a
+process running with full capabilities is effectively equivalent in
+privilege to the kernel itself. The lockdown feature attempts to draw
+a stronger boundary between privileged processes and the kernel,
+increasing the level of trust that can be placed in the kernel even in
+the face of hostile processes.
+
+Lockdown can be run in two modes - integrity and confidentiality. In
+integrity mode, kernel features that allow arbitrary modification of
+the running kernel image are disabled. Confidentiality mode behaves in
+the same way as integrity mode, but also blocks features that
+potentially allow a hostile userland process to extract secret
+information from the kernel.
+
+Note that lockdown depends upon the correct behaviour of the
+kernel. Exploitable vulnerabilities in the kernel may still permit
+arbitrary modification of the kernel or make it possible to disable
+lockdown features.
+
+=================
+Enabling Lockdown
+=================
+
+Lockdown can be enabled in multiple ways.
+
+Kernel configuration
+====================
+
+The kernel can be statically configured by setting either
+CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY or
+CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY. A kernel configured
+with CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY may be booted into
+confidentiality mode using one of the other mechanisms, but otherwise
+the kernel will always boot into the configured mode.
+
+Kernel command line
+===================
+
+Passing lockdown=integrity or lockdown=confidentiality on the kernel
+command line will configure lockdown into the appropriate mode.
+
+Runtime configuration
+=====================
+
+/sys/kernel/security/lockdown will indicate the current lockdown
+state. The system state may be made stricter by writing either
+"integrity" or "confidentiality" into this file, but any attempts to
+make it less strict will fail.
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a7..7ce52151b76c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -340,6 +340,13 @@ static inline void refcount_error_report(struct pt_regs *regs, const char *err)
 { }
 #endif
 
+enum lockdown_level {
+	LOCKDOWN_NONE,
+	LOCKDOWN_INTEGRITY,
+	LOCKDOWN_CONFIDENTIALITY,
+	LOCKDOWN_MAX,
+};
+
 /* Internal, do not use. */
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1a841d134e05..0377d8ee6454 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1781,6 +1781,7 @@ union security_list_options {
 	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
+	int (*locked_down)(const char *where, enum lockdown_level level);
 };
 
 struct security_hook_heads {
@@ -2016,6 +2017,7 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+	struct hlist_head locked_down;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index f4363a1339a8..87102694b033 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -384,6 +384,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_is_locked_down(const char *where, enum lockdown_level level);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1173,6 +1174,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+static inline int security_is_locked_down(const char *where, enum lockdown_level level)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
@@ -1800,4 +1805,3 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
 #endif /* CONFIG_BPF_SYSCALL */
 
 #endif /* ! __LINUX_SECURITY_H */
-
diff --git a/security/Kconfig b/security/Kconfig
index 1d6463fb1450..c35aa72103df 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -236,12 +236,13 @@ source "security/apparmor/Kconfig"
 source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
+source "security/lockdown/Kconfig"
 
 source "security/integrity/Kconfig"
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
+	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/Makefile b/security/Makefile
index c598b904938f..be1dd9d2cb2f 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,6 +11,7 @@ subdir-$(CONFIG_SECURITY_APPARMOR)	+= apparmor
 subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
+subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -27,6 +28,7 @@ obj-$(CONFIG_SECURITY_APPARMOR)		+= apparmor/
 obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
+obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 
 # Object integrity file lists
diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
new file mode 100644
index 000000000000..431cd2b9a14e
--- /dev/null
+++ b/security/lockdown/Kconfig
@@ -0,0 +1,46 @@
+config SECURITY_LOCKDOWN_LSM
+	bool "Basic module for enforcing kernel lockdown"
+	depends on SECURITY
+	help
+	  Build support for an LSM that enforces a coarse kernel lockdown
+	  behaviour.
+
+config SECURITY_LOCKDOWN_LSM_EARLY
+        bool "Enable lockdown LSM early in init"
+	depends on SECURITY_LOCKDOWN_LSM
+	help
+	  Enable the lockdown LSM early in boot. This is necessary in order
+	  to ensure that lockdown enforcement can be carried out on kernel
+	  boot parameters that are otherwise parsed before the security
+	  subsystem is fully initialised.
+
+choice
+	prompt "Kernel default lockdown mode"
+	default LOCK_DOWN_KERNEL_FORCE_NONE
+	depends on SECURITY_LOCKDOWN_LSM
+	help
+	  The kernel can be configured to default to differing levels of
+	  lockdown.
+
+config LOCK_DOWN_KERNEL_FORCE_NONE
+       bool "None"
+       help
+          No lockdown functionality is enabled by default. Lockdown may be
+	  enabled via the kernel commandline or /sys/kernel/security/lockdown.
+
+config LOCK_DOWN_KERNEL_FORCE_INTEGRITY
+       bool "Integrity"
+       help
+         The kernel runs in integrity mode by default. Features that allow
+	 the kernel to be modified at runtime are disabled.
+
+config LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
+       bool "Confidentiality"
+       help
+         The kernel runs in confidentiality mode by default. Features that
+	 allow the kernel to be modified at runtime or that permit userland
+	 code to read confidential material held inside the kernel are
+	 disabled.
+
+endchoice
+
diff --git a/security/lockdown/Makefile b/security/lockdown/Makefile
new file mode 100644
index 000000000000..e3634b9017e7
--- /dev/null
+++ b/security/lockdown/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SECURITY_LOCKDOWN_LSM) += lockdown.o
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
new file mode 100644
index 000000000000..6c707492344b
--- /dev/null
+++ b/security/lockdown/lockdown.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Lock down the kernel
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/security.h>
+#include <linux/export.h>
+#include <linux/lsm_hooks.h>
+
+static enum lockdown_level kernel_locked_down;
+
+char *lockdown_levels[LOCKDOWN_MAX] = {"none", "integrity", "confidentiality"};
+
+/*
+ * Put the kernel into lock-down mode.
+ */
+static int lock_kernel_down(const char *where, enum lockdown_level level)
+{
+	if (kernel_locked_down >= level)
+		return -EPERM;
+
+	kernel_locked_down = level;
+	pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
+		  where);
+	return 0;
+}
+
+static int __init lockdown_param(char *level)
+{
+	if (!level)
+		return -EINVAL;
+
+	if (strcmp(level, "integrity") == 0)
+		lock_kernel_down("command line", LOCKDOWN_INTEGRITY);
+	else if (strcmp(level, "confidentiality") == 0)
+		lock_kernel_down("command line", LOCKDOWN_CONFIDENTIALITY);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+early_param("lockdown", lockdown_param);
+
+/**
+ * lockdown_is_locked_down - Find out if the kernel is locked down
+ * @what: Tag to use in notice generated if lockdown is in effect
+ */
+static int lockdown_is_locked_down(const char *what, enum lockdown_level level)
+{
+	if ((kernel_locked_down >= level) && what)
+		pr_notice("Lockdown: %s is restricted; see man kernel_lockdown.7\n",
+			  what);
+	return (kernel_locked_down >= level);
+}
+
+static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
+};
+
+static int __init lockdown_lsm_init(void)
+{
+#if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
+	lock_kernel_down("Kernel configuration", LOCKDOWN_INTEGRITY);
+#elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
+	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY);
+#endif
+	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
+			   "lockdown");
+	return 0;
+}
+
+static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
+			     loff_t *ppos)
+{
+	char temp[80];
+	int i, offset=0;
+
+	for (i = LOCKDOWN_NONE; i < LOCKDOWN_MAX; i++) {
+		if (lockdown_levels[i]) {
+			const char *label = lockdown_levels[i];
+
+			if (kernel_locked_down == i)
+				offset += sprintf(temp+offset, "[%s] ", label);
+			else
+				offset += sprintf(temp+offset, "%s ", label);
+		}
+	}
+
+	/* Convert the last space to a newline if needed. */
+	if (offset > 0)
+		temp[offset-1] = '\n';
+
+	return simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+}
+
+static ssize_t lockdown_write(struct file *file, const char __user *buf,
+			      size_t n, loff_t *ppos)
+{
+	char *state;
+	int i, len, err = -EINVAL;
+
+	state = memdup_user_nul(buf, n);
+	if (IS_ERR(state))
+		return PTR_ERR(state);
+
+	len = strlen(state);
+	if (len && state[len-1] == '\n') {
+		state[len-1] = '\0';
+		len--;
+	}
+
+	for (i = 0; i < LOCKDOWN_MAX; i++) {
+		const char *label = lockdown_levels[i];
+
+		if (label && !strcmp(state, label))
+			err = lock_kernel_down("securityfs", i);
+	}
+
+	kfree(state);
+	return err ? err : n;
+}
+
+static const struct file_operations lockdown_ops = {
+	.read  = lockdown_read,
+	.write = lockdown_write,
+};
+
+static int __init lockdown_secfs_init(void)
+{
+	struct dentry *dentry;
+
+	dentry = securityfs_create_file("lockdown", 0600, NULL, NULL,
+					&lockdown_ops);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	return 0;
+}
+
+core_initcall(lockdown_secfs_init);
+
+#ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
+DEFINE_EARLY_LSM(lockdown) = {
+#else
+DEFINE_LSM(lockdown) = {
+#endif
+	.name = "lockdown",
+	.init = lockdown_lsm_init,
+};
diff --git a/security/security.c b/security/security.c
index e3a7d4e96541..73ccf3be55bf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2370,3 +2370,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 	call_void_hook(bpf_prog_free_security, aux);
 }
 #endif /* CONFIG_BPF_SYSCALL */
+
+int security_is_locked_down(const char *where, enum lockdown_level level)
+{
+	return call_int_hook(locked_down, 0, where, level);
+}
+EXPORT_SYMBOL(security_is_locked_down);
-- 
2.21.0.1020.gf2820cf01a-goog

