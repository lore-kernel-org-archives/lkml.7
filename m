Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C929C218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAsLSfXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbfB1XLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:11:11 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:35699 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732771AbfB1XLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:11:11 -0500
Received: by mail-io1-f74.google.com with SMTP id s9so16999492ioj.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JgzwmpXUZt6KNQDOAKfrLdx7UP057Xc3K0KJM8I4IMs=;
        b=dAsLSfXKyGPDbouXPHYH7fcKODImrwXNQePsf+wCZ+qJwU7tMD1lpoJtzkrPa4pVD2
         JWIHq4euZwKPAsUus5g0jCU9AOXfE4c6Lyfi58DZHmWmqnxSUmzFn5hw/jbkXCkdGJu7
         HOjlUGqDfMtuSvkgY54QZtrQ/eak3eOXEAqareVRpM5GmExq4/0DRQybRuQ/NpkWeuLS
         NnccSbCIUpMNwLq3HnLFivAqKGS7dcMJxs5kY9lfpIbUTjVF/3xotZOGaDMiCIB4I4pi
         yKWhdaOtZXfiLWcDIsoJ08S1/GX5n+w5PxH2EWFt9IQ9hX0pRq+PgrMlFimdipdlLp2P
         ytaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JgzwmpXUZt6KNQDOAKfrLdx7UP057Xc3K0KJM8I4IMs=;
        b=snggzq2RXH6CNkIS2gGnW389ZqeDnxEgZPO0l/XyfZXol6S1GzJGDn/CEdaJu2U1Kr
         D6qv+agvWqSYbUpbO8ZnZf5qPrzPx1v2NNa7PBLkagti+DuhJm7Yxr3U6cNsGYBxaL6L
         8JxE/NdhR3yFNYQQutw+WR3jbk4n3QITHlJcFNwfjnDR2MBNfUdULJB95iEJL+wpYiuq
         9V05KyAHKOU9LR01rrHuAYNfrWBxcTZCaUBHIOP4ACKU9ELC6iVP3t+h8TdDqLMDx7Zg
         zbHgnlJ4kP+P9EzBbpHX5iO6CnTfJxaoJEuCwEhGRkTDknPmPA074w37l3NYMafXZLej
         lcUw==
X-Gm-Message-State: APjAAAVjGIYPHSwbcFwmbZ4BZrVUXWxUQbtFo6jpLTKDXT5fqhfcWUAa
        Cfc0WlCV8AjF2d3DZDE3uqQRj3YTNmcr3jYKKOKRnA==
X-Google-Smtp-Source: AHgI3IY6NNUBdt5MkW6pSZcmTm5A+kECbiKydGPISbLnqOl3M90zVJgeT7wYgwxiXGnopf7j8KJFHFZ4i5W4j5Z+Iq5XbA==
X-Received: by 2002:a24:d083:: with SMTP id m125mr1455178itg.5.1551395470150;
 Thu, 28 Feb 2019 15:11:10 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:10:41 -0800
In-Reply-To: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
Message-Id: <20190228231107.209611-1-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 01/27] Add the ability to lock down access to the running
 kernel image
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
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
---
 include/linux/kernel.h   | 17 ++++++++++++
 include/linux/security.h |  9 +++++-
 security/Kconfig         | 15 ++++++++++
 security/Makefile        |  3 ++
 security/lock_down.c     | 59 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 1 deletion(-)
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
index dbfb5a66babb..35f0be540e0b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1793,5 +1793,12 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
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
index e4fe2f3c2c65..c2aff0006de2 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -230,6 +230,21 @@ config STATIC_USERMODEHELPER_PATH
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
index 4d2d3782ddef..507ac8c520ce 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -30,3 +30,6 @@ obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
 obj-$(CONFIG_INTEGRITY)			+= integrity/
+
+# Allow the kernel to be locked down
+obj-$(CONFIG_LOCK_DOWN_KERNEL)		+= lock_down.o
diff --git a/security/lock_down.c b/security/lock_down.c
new file mode 100644
index 000000000000..13a8228c1034
--- /dev/null
+++ b/security/lock_down.c
@@ -0,0 +1,59 @@
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
2.21.0.352.gf09ad66450-goog

