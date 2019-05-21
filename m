Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C364AC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E61521773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY3ZSvFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfEUWkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 18:40:20 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:46521 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfEUWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 18:40:19 -0400
Received: by mail-ot1-f74.google.com with SMTP id a2so236891otk.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hGPKA9QoScUdBbJ7le3fhZSr13IA+IrjO6JtRN49sNw=;
        b=hY3ZSvFrQqrRfKxS7416nT4FjMeOL8gX56biDa7FBpjErp4VxDCH4pKzy9TSMDpPSp
         L91KoEvLZiGceYydSd+7y5Aeq3WoBUGi22u+cftcCgx8Ly1OMXoSwHoZfEl2duWiuS9A
         P6HYV+6+IpetPK70wo+dU6nmMhur0PypRzBcGfNvf6F8BwUWT7gEBxpR/M79ILeRRJpX
         uaGcJZreCrZAgsSPR1uXFfz6Y6Zd98ste9+7s/EOHYs+BtsMmPpJfAS9GWm9tKvnwYXh
         MTYYkFCWEgI2x1VIkHiKz60bcsdSI8OFqDSYYFw8PWj27oynzkO4OvY8lajOcBRbcyFK
         ulkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hGPKA9QoScUdBbJ7le3fhZSr13IA+IrjO6JtRN49sNw=;
        b=W3dT4Z6Qc02dnXReqy88uo0F5RlW0vB5dxLMIkdP2lecpAGUEaZPmGMGQjXXMtQAd7
         zVxHY+pJzr6306jBEsgkseQQ6I6jNy9YJKb9UIY2Aewskk39c2vB200IXtDyeFPlIRLE
         bPX6XNs3gHKB7hJe/WtGyZsXIrv2CswEGttjYLZB/GI1H+nmgQ6HOH8L7E73iC0yltnP
         raZ6GITHbWBj8NNrUc7hVBxktTMeeyMVyJWSfTgzTX6tOeMKsN/04b4Bivl0jxkiibLu
         zwnOWfz+uX3UgBvoZDQJr9ztV5OXkdtMAVtOCtdpvXbMUVhzqeVoHzKX17JcDOESDvZ9
         RNXw==
X-Gm-Message-State: APjAAAUdw9sYbfZdnyHvFpE/YMHEY5SF0SeQUtCUifjZ4LG+CQXtNNzl
        Tpgb8BnZkgc+AvhQI+VTNfgPzGAX/3GI0Nu+Zl0dSQ==
X-Google-Smtp-Source: APXvYqx1uOSBnWtC4Ju8Idb9d0bpSG6Hfy/yeDZ0RBK+IsJMTGchForXcH04lZdBPUuLZRu86OFHcUoIGyEx/SvJk+8lYg==
X-Received: by 2002:aca:cd0a:: with SMTP id d10mr5144145oig.1.1558478418568;
 Tue, 21 May 2019 15:40:18 -0700 (PDT)
Date:   Tue, 21 May 2019 15:40:12 -0700
In-Reply-To: <20190521224013.3782-1-matthewgarrett@google.com>
Message-Id: <20190521224013.3782-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190521224013.3782-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RFC 1/2] security: Support early LSMs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdown module is intended to allow for kernels to be locked down
early in boot - sufficiently early that we don't have the ability to
kmalloc() yet. Add support for early initialisation of some LSMs, and
then add them to the list of names when we do full initialisation later.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/asm-generic/vmlinux.lds.h |  8 +++++-
 include/linux/lsm_hooks.h         |  6 ++++
 include/linux/security.h          |  1 +
 init/main.c                       |  1 +
 security/security.c               | 48 +++++++++++++++++++++++++------
 5 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..e9761ed1f5b3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -208,8 +208,13 @@
 			__start_lsm_info = .;				\
 			KEEP(*(.lsm_info.init))				\
 			__end_lsm_info = .;
+#define EARLY_LSM_TABLE()	. = ALIGN(8);				\
+			__start_early_lsm_info = .;			\
+			KEEP(*(.early_lsm_info.init))			\
+			__end_early_lsm_info = .;
 #else
 #define LSM_TABLE()
+#define EARLY_LSM_TABLE()
 #endif
 
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
@@ -610,7 +615,8 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	EARLYCON_TABLE()						\
-	LSM_TABLE()
+	LSM_TABLE()							\
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 22fc786d723a..1a841d134e05 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2074,12 +2074,18 @@ struct lsm_info {
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
+extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
 #define DEFINE_LSM(lsm)							\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))
 
+#define DEFINE_EARLY_LSM(lsm)						\
+	static struct lsm_info __early_lsm_##lsm			\
+		__used __section(.early_lsm_info.init)			\
+		__aligned(sizeof(unsigned long))
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
  * Assuring the safety of deleting a security module is up to
diff --git a/include/linux/security.h b/include/linux/security.h
index 13537a49ae97..f4363a1339a8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -191,6 +191,7 @@ int unregister_lsm_notifier(struct notifier_block *nb);
 
 /* prototypes */
 extern int security_init(void);
+extern int early_security_init(void);
 
 /* Security operations */
 int security_binder_set_context_mgr(struct task_struct *mgr);
diff --git a/init/main.c b/init/main.c
index e2e80ca3165a..6bdceaaeddbd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -555,6 +555,7 @@ asmlinkage __visible void __init start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
+	early_security_init();
 	setup_arch(&command_line);
 	/*
 	 * Set up the the initial canary and entropy after arch
diff --git a/security/security.c b/security/security.c
index ed9b8cbf21cf..e3a7d4e96541 100644
--- a/security/security.c
+++ b/security/security.c
@@ -37,6 +37,7 @@
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
@@ -281,6 +282,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 static void __init lsm_early_cred(struct cred *cred);
 static void __init lsm_early_task(struct task_struct *task);
 
+static int lsm_append(const char *new, char **result);
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -327,15 +330,11 @@ static void __init ordered_lsm_init(void)
 	kfree(ordered_lsms);
 }
 
-/**
- * security_init - initializes the security framework
- *
- * This should be called early in the kernel initialization sequence.
- */
-int __init security_init(void)
+int __init early_security_init(void)
 {
 	int i;
 	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
+	struct lsm_info *lsm;
 
 	pr_info("Security Framework initializing\n");
 
@@ -343,6 +342,30 @@ int __init security_init(void)
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+		initialize_lsm(lsm);
+	}
+
+	return 0;
+}
+
+/**
+ * security_init - initializes the security framework
+ *
+ * This should be called early in the kernel initialization sequence.
+ */
+int __init security_init(void)
+{
+	struct lsm_info *lsm;
+
+	/* Append the names of the early LSM modules now */
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		if (lsm->enabled)
+			lsm_append(lsm->name, &lsm_names);
+	}
+
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
 
@@ -388,7 +411,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
 	return !strcmp(last, lsm);
 }
 
-static int lsm_append(char *new, char **result)
+static int lsm_append(const char *new, char **result)
 {
 	char *cp;
 
@@ -426,8 +449,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		hooks[i].lsm = lsm;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
-	if (lsm_append(lsm, &lsm_names) < 0)
-		panic("%s - Cannot get early memory.\n", __func__);
+
+	/*
+	 * Don't try to append during early_security_init(), we'll come back
+	 * and fix this up afterwards.
+	 */
+	if (slab_is_available()) {
+		if (lsm_append(lsm, &lsm_names) < 0)
+			panic("%s - Cannot get early memory.\n", __func__);
+	}
 }
 
 int call_lsm_notifier(enum lsm_event event, void *data)
-- 
2.21.0.1020.gf2820cf01a-goog

