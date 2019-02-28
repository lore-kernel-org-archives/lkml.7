Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86392C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4C520C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVVIrZkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbfB1XLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:11:38 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45030 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732514AbfB1XLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:11:37 -0500
Received: by mail-qt1-f201.google.com with SMTP id c9so19958273qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JgzwmpXUZt6KNQDOAKfrLdx7UP057Xc3K0KJM8I4IMs=;
        b=DVVIrZkP305/YQ80uEOQsWtNzj6kMZsbOT77Y3/O6y4jnWKA706AShWWeRUPOEvVIs
         JwbAC62vkjGc8xfNjX2nF9oqF5RJPLeukwduMrSk/aGqMI+HhP31RncMLfLiK9bqG+Ha
         JVPuxqqctAK8A+VqHRyAZdpat8Kn6f6ndBPN9/SxL7r46eY3Qc4L1uXn38i9Twjn0WjF
         X7Hyf7ZmnhUa1rLBdEa8/GEccffWAX0NdB1wgyy30djDxOi3YFASMb7x+/NtSDpwp82n
         wfhaypNF9tUEphiM4coEDdb8anWykzR9BumYdNysIUudxJeRw9sVLOZ+DUo+lvu6kzZx
         pH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JgzwmpXUZt6KNQDOAKfrLdx7UP057Xc3K0KJM8I4IMs=;
        b=aqovjrq93zEZA7CwLnUbaI+zYe/DX8o+nBtKffFRL1UDqly6xSx+0B44mgJDOffy/w
         u56VaOZdkcpJ8QFC5AK3Fo/Muo5DKYzd0G/R5Eq2TwlSjM0X0iC+tGOiI0icpAw5XSux
         Z7EgGbdfniih3oPN4NDg+WPdNylcE3Tzu4+sv5KT1VoGLDGeKMChzKQsQEUN2sCWOWm9
         O8NenE263K2WIfGQiVpkUc29wvuowkNVOrK4Ve0NmSdLd9n5avs7M1fom1mWtH8RfMhs
         n+WbvvfIkdHZ02SI8iA0MgbfSINGOFkNjh1PY2LhU7eJUpcyyFd+ez2Y4MyqxOq5WQtf
         8zPQ==
X-Gm-Message-State: APjAAAU5fOYttxeTe0uLa7liJ9PRn53eChnzH2HmKcTjN1JoTnUkC14P
        mGPR4kAOlkKDyrBRQTL9s1VeDjAiMFisi4bjwjHegw==
X-Google-Smtp-Source: APXvYqw/WqHNm7Mcb0Xep5wNTfVU8b4BVQ0DbPnh49MaRHej1qQNvTejOGaCwVZry3fxwZK61/bZMB46MzI1X6juKTUkJw==
X-Received: by 2002:a0c:f9d0:: with SMTP id j16mr1091866qvo.51.1551395496126;
 Thu, 28 Feb 2019 15:11:36 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:07 -0800
In-Reply-To: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
Message-Id: <20190228231133.210926-1-matthewgarrett@google.com>
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

