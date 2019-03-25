Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E2FC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBAD2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qtk3Uzax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfCYWKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:04 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:45112 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfCYWKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:02 -0400
Received: by mail-vk1-f202.google.com with SMTP id w71so4718016vkd.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uBzQBnzVBfq8JoUqfbgdJarhJoRvZiKFoNAG2KlTyk0=;
        b=Qtk3UzaxR8cDFWuaaz8d/wTVyGAl498kaKXTG/KzqlRafDY9W5HLqO7xgmwItV/0Wa
         lTEZqoaELaS2yxVnr73TwOvzVkh/Bcdohl7iZ/ErpQdScHMe7/a5TxmVg4CNSJL0Km8k
         fCZEuWsq/x+uDp0bivU6h/KHG2rqVxIjEA8T/CVpuOF834I80pnfni6hEYLrsAziuFrf
         l3Mzx8HeAbu4cBrccafTzMVWnQJUAPu/3G1/S2W4FIEa2M1lD3f726SqJCPDbGH3UDBt
         Jj4P8UxszT/C+eA/BYRdXh33lIckTwYIdE8LSxIQIPMClinFpYcivKeipgi1f4eFpfEH
         Pwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uBzQBnzVBfq8JoUqfbgdJarhJoRvZiKFoNAG2KlTyk0=;
        b=s/BDmuzK5ZV48v1jGbLLRztdyeGZBk+xANoUNJL3EOMTffFHiqndhMcnRrDAfAby3w
         J47E/CxE5VKWtvwRHyG6bk9NHx6dmHgVSHifW1QkbxiUSfErnlZvw3IER0wEJvsqlxDg
         TJ03JiJNW1BszUTcSd7oKB0wuZZHk1w5Bu+yP6/rt9+qeOdzsxeznNCOW13A7cOCvM5b
         qspOsc4lzyT0FnpOlJprb7SAi3OFW+nVqrzN/efPOc1Sl98UIeMCmPyqkpGCwrPz3fCo
         a/8i2U4iCo/k1kezXRbbuC/STkeoHrzzHW373j6JACGwV4ExRZe6v2tlHitRMbXlDMrZ
         s+zg==
X-Gm-Message-State: APjAAAWWAQgLH+sHzUuQy3xruBNee5kHraoXSDlCsIhE5cjPyOoGK32A
        UDRzhU2RljeEzlsqqdzgccoYUlj1Bt3p+uakD+Rdfg==
X-Google-Smtp-Source: APXvYqx6skRlFA8s965pJMOHpGm/nj46vsMi4SOXagjWjUDlePz/v5MBkBMpywFs/eENyhXI5/cmNEwUuIPG9BQdFy1UnA==
X-Received: by 2002:a1f:32c7:: with SMTP id y190mr11385971vky.15.1553551800948;
 Mon, 25 Mar 2019 15:10:00 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:28 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 01/27] Add the ability to lock down access to the running
 kernel image
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        James Morris <james.l.morris@oracle.com>,
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
Acked-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
---
 include/linux/kernel.h   | 17 ++++++++++++
 include/linux/security.h |  9 +++++-
 security/Kconfig         | 15 ++++++++++
 security/Makefile        |  3 ++
 security/lock_down.c     | 60 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 security/lock_down.c

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a7..833bf32ce4e6 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -340,6 +340,23 @@ static inline void refcount_error_report(struct pt_regs *regs, const char *err)
 { }
 #endif
 
+#ifdef CONFIG_LOCK_DOWN_KERNEL
+extern bool __kernel_is_locked_down(const char *what, bool first);
+#else
+static inline bool __kernel_is_locked_down(const char *what, bool first)
+{
+	return false;
+}
+#endif
+
+#define kernel_is_locked_down(what)					\
+	({								\
+		static bool message_given;				\
+		bool locked_down = __kernel_is_locked_down(what, !message_given); \
+		message_given = true;					\
+		locked_down;						\
+	})
+
 /* Internal, do not use. */
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
diff --git a/include/linux/security.h b/include/linux/security.h
index 13537a49ae97..b290946341a4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1798,5 +1798,12 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
-#endif /* ! __LINUX_SECURITY_H */
+#ifdef CONFIG_LOCK_DOWN_KERNEL
+extern void __init init_lockdown(void);
+#else
+static inline void __init init_lockdown(void)
+{
+}
+#endif
 
+#endif /* ! __LINUX_SECURITY_H */
diff --git a/security/Kconfig b/security/Kconfig
index 1d6463fb1450..47dc3403b5af 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -229,6 +229,21 @@ config STATIC_USERMODEHELPER_PATH
 	  If you wish for all usermode helper programs to be disabled,
 	  specify an empty string here (i.e. "").
 
+config LOCK_DOWN_KERNEL
+	bool "Allow the kernel to be 'locked down'"
+	help
+	  Allow the kernel to be locked down. If lockdown support is enabled
+	  and activated, the kernel will impose additional restrictions
+	  intended to prevent uid 0 from being able to modify the running
+	  kernel. This may break userland applications that rely on low-level
+	  access to hardware.
+
+config LOCK_DOWN_KERNEL_FORCE
+        bool "Enable kernel lockdown mode automatically"
+        depends on LOCK_DOWN_KERNEL
+        help
+          Enable the kernel lock down functionality automatically at boot.
+
 source "security/selinux/Kconfig"
 source "security/smack/Kconfig"
 source "security/tomoyo/Kconfig"
diff --git a/security/Makefile b/security/Makefile
index c598b904938f..5ff090149c88 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -32,3 +32,6 @@ obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
 obj-$(CONFIG_INTEGRITY)			+= integrity/
+
+# Allow the kernel to be locked down
+obj-$(CONFIG_LOCK_DOWN_KERNEL)		+= lock_down.o
diff --git a/security/lock_down.c b/security/lock_down.c
new file mode 100644
index 000000000000..18d8776a4d02
--- /dev/null
+++ b/security/lock_down.c
@@ -0,0 +1,60 @@
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
+
+static __ro_after_init bool kernel_locked_down;
+
+/*
+ * Put the kernel into lock-down mode.
+ */
+static void __init lock_kernel_down(const char *where)
+{
+	if (!kernel_locked_down) {
+		kernel_locked_down = true;
+		pr_notice("Kernel is locked down from %s; see man kernel_lockdown.7\n",
+			  where);
+	}
+}
+
+static int __init lockdown_param(char *ignored)
+{
+	lock_kernel_down("command line");
+	return 0;
+}
+
+early_param("lockdown", lockdown_param);
+
+/*
+ * Lock the kernel down from very early in the arch setup.  This must happen
+ * prior to things like ACPI being initialised.
+ */
+void __init init_lockdown(void)
+{
+#ifdef CONFIG_LOCK_DOWN_FORCE
+	lock_kernel_down("Kernel configuration");
+#endif
+}
+
+/**
+ * kernel_is_locked_down - Find out if the kernel is locked down
+ * @what: Tag to use in notice generated if lockdown is in effect
+ */
+bool __kernel_is_locked_down(const char *what, bool first)
+{
+	if (what && first && kernel_locked_down)
+		pr_notice("Lockdown: %s is restricted; see man kernel_lockdown.7\n",
+			  what);
+	return kernel_locked_down;
+}
+EXPORT_SYMBOL(__kernel_is_locked_down);
-- 
2.21.0.392.gf8f6787159e-goog

