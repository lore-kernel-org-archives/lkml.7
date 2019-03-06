Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF33C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD57206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iy/8J0yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCFX7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:59:25 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:37069 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCFX7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:59:24 -0500
Received: by mail-qt1-f201.google.com with SMTP id f24so13517532qte.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1LcLxZZeadXcC/hwYKSoMtkJDQep5r2KsFbSWUW2wE8=;
        b=Iy/8J0yRHPiIt2hYd0U0RM3kg9R26eWWh+SOLOq8mADHY7qZwOuibMK43DHFghczD6
         dGHlYeHj/PiUPNYHSvx9phw9pn8aFFwr7wQLCqRVZRu+2qe9JQ/jLpurg2kZQdfwi/Wk
         9KMAUmoQvEUpsmnvCWw2XOC2wCksC73V1Sqw9RoKV3rE+f3N8dWG4/fiULpnhy4Dtk4I
         rzHQGQjsZbNU4U0Ylk/l3d0ZzKaZnYthZPAoNKpcU6m84M5Lw7rPk/9ZLfoD4fCmAHwr
         UduPZlx3HpnZSGHZl9oq6TXz6VHpSCDtoMe3hzMzXnCZNgck/Rz9zOBBLo8kMfbzhxSN
         pE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1LcLxZZeadXcC/hwYKSoMtkJDQep5r2KsFbSWUW2wE8=;
        b=O6x9NyEFHv/VRRF0YnVxBLSPOrTIIXRQ3zkAAGPSmTjuLhfynsT8Iv/l4bB5VBUtST
         T2AhFAFckPm9TwqXzl6SWe7M6MY0yvqLq2ZJHctdeiO9lXq4/hgH0fmNzAt1T5AwdpL0
         L1MVbJFn4CazLYZJa/bxmESt6OW4opO4azleN6zv9+4OdfBb5dccGB1O7YX5wnV8YSBF
         ir5yiQb0bDA3t819r9nqncLVqioWB+echMo6+lugPvmKhP5995EuP1DEIVJXsmr5PX7Z
         T+yE2oG9x788BJ2t0Dl4r5xTODKNX5FtXOZk72RE7gx8SRfnosHn1QdOfN3A1NJcVADN
         0JsA==
X-Gm-Message-State: APjAAAWUu2Ns+m477t/cbhiF08N3MdY99CFrFjwN3+t/fYG3LdizUGHA
        KsO4cWZtxVk8QZM9x7fJ+5MYg/lmpMRosoz7kBrQOg==
X-Google-Smtp-Source: APXvYqyOBdwvSsdMSp5kQoNI/HEa3TYEz/jWBYpMcJUpgp/H/8TOMhyRjhoIwLNH8ClFacW34Q+fAetK1mRRuNWWVKO8Ug==
X-Received: by 2002:a0c:b91c:: with SMTP id u28mr5949305qvf.45.1551916762437;
 Wed, 06 Mar 2019 15:59:22 -0800 (PST)
Date:   Wed,  6 Mar 2019 15:58:47 -0800
In-Reply-To: <20190306235913.6631-1-matthewgarrett@google.com>
Message-Id: <20190306235913.6631-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
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
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
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

