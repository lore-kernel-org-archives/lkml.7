Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1966DC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C182064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVVH+OGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfGaWQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:16:32 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45690 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbfGaWQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:30 -0400
Received: by mail-pf1-f202.google.com with SMTP id i27so44206058pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=51dHsz2VCo9w+VP1Zvpve034pgyEZM98AQeW9IXg4Ow=;
        b=qVVH+OGRsMSn/LGHzMNz4COc3ENzyPmA4GDLlB9FJxKixdjiPTxaiI4Bpeo7+TfX7P
         4ug4SCfAWimEMtk20uAkeQu7bqBEcBLWUbR0SHXY9qUruSQDsL6YF9JxvmS/+5sL8eOi
         ZzzWlZ2iMAbN6b4IkLzBZPPGC/WbXY5iQu68P81I5MZbdJo1d4f0eOMTOJqIOCWmnDM/
         2CkSweNuMx6OV2v+fJuPDS+gfg/gTw/QNERZZmIJC3lDT0RROgFmwWoIbVnX8uegbNfr
         sr439LCuNbSq3JPmKhqoUMd+rz16eUxkhZ6i+PlwOd5hdIVDr1M4uG2tmCznIvRH9Qx1
         Axlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=51dHsz2VCo9w+VP1Zvpve034pgyEZM98AQeW9IXg4Ow=;
        b=o+8es2SuLUf/bhkWX+oNWHqOmM4IT1xrOx9GhgJDyL6/J0ufG2H373tu3VXHyHlTfs
         Of0XlPphSC8J4NxHtReL4v3sC6F4nfpriXu3flDvrn8eAP3oxnsODnH+ykmICbk1DUGV
         G7ndrv1BoZp9EdEmWDHnsT//B2IEhlGuNcD8+EZ8+vxgrjufPM1bWOo6m4A+Bbhm0Rvu
         APkqQGu7gg6bsmaGRg7qrkJLbL/khLb0rmSGMg2f2NXdej/NQnoO5ITGtK2aLpHdKf0L
         eWTSxmbJpJrFjsMwaZprWw3i/2dA9ruDAR0XySWm1h7XfI6U7KjXJU3krnJAS2dNeCfZ
         ZLpg==
X-Gm-Message-State: APjAAAWcjPBHKmyWxjQXOPiDG2u8BoY9X9HdW28ZLUNPZ7cLP9bLKXAv
        lROl0MqHGfluEDLiblJGLBFNdmt9l37ZvAObNJSQew==
X-Google-Smtp-Source: APXvYqx84GYrBq6uqjqWf+y6nnPUb8miYjP7zdRnus3qjBKLCgc727OBJ0v2dqkTra6tifRXqgzB0LNbi4gBfBT/r2GC6g==
X-Received: by 2002:a63:cb4b:: with SMTP id m11mr42081768pgi.49.1564611388704;
 Wed, 31 Jul 2019 15:16:28 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:49 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 01/29] security: Support early LSMs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdown module is intended to allow for kernels to be locked down
early in boot - sufficiently early that we don't have the ability to
kmalloc() yet. Add support for early initialisation of some LSMs, and
then add them to the list of names when we do full initialisation later.
Early LSMs are initialised in link order and cannot be overridden via
boot parameters, and cannot make use of kmalloc() (since the allocator
isn't initialised yet).

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/asm-generic/vmlinux.lds.h |  8 ++++-
 include/linux/lsm_hooks.h         |  6 ++++
 include/linux/security.h          |  1 +
 init/main.c                       |  1 +
 security/security.c               | 50 ++++++++++++++++++++++++++-----
 5 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cd28f63bfbc7..dae64600ccbf 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -215,8 +215,13 @@
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
@@ -627,7 +632,8 @@
 	ACPI_PROBE_TABLE(timer)						\
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
-	LSM_TABLE()
+	LSM_TABLE()							\
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index df1318d85f7d..aebb0e032072 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2104,12 +2104,18 @@ struct lsm_info {
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
index 5f7441abbf42..66a2fcbe6ab0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -195,6 +195,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
 
 /* prototypes */
 extern int security_init(void);
+extern int early_security_init(void);
 
 /* Security operations */
 int security_binder_set_context_mgr(struct task_struct *mgr);
diff --git a/init/main.c b/init/main.c
index 96f8d5af52d6..565af7b963e1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -593,6 +593,7 @@ asmlinkage __visible void __init start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
+	early_security_init();
 	setup_arch(&command_line);
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
diff --git a/security/security.c b/security/security.c
index 250ee2d76406..90f1e291c800 100644
--- a/security/security.c
+++ b/security/security.c
@@ -33,6 +33,7 @@
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
@@ -277,6 +278,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 static void __init lsm_early_cred(struct cred *cred);
 static void __init lsm_early_task(struct task_struct *task);
 
+static int lsm_append(const char *new, char **result);
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info **lsm;
@@ -323,6 +326,26 @@ static void __init ordered_lsm_init(void)
 	kfree(ordered_lsms);
 }
 
+int __init early_security_init(void)
+{
+	int i;
+	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
+	struct lsm_info *lsm;
+
+	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
+	     i++)
+		INIT_HLIST_HEAD(&list[i]);
+
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+		prepare_lsm(lsm);
+		initialize_lsm(lsm);
+	}
+
+	return 0;
+}
+
 /**
  * security_init - initializes the security framework
  *
@@ -330,14 +353,18 @@ static void __init ordered_lsm_init(void)
  */
 int __init security_init(void)
 {
-	int i;
-	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
+	struct lsm_info *lsm;
 
 	pr_info("Security Framework initializing\n");
 
-	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
-	     i++)
-		INIT_HLIST_HEAD(&list[i]);
+	/*
+	 * Append the names of the early LSM modules now that kmalloc() is
+	 * available
+	 */
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		if (lsm->enabled)
+			lsm_append(lsm->name, &lsm_names);
+	}
 
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
@@ -384,7 +411,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
 	return !strcmp(last, lsm);
 }
 
-static int lsm_append(char *new, char **result)
+static int lsm_append(const char *new, char **result)
 {
 	char *cp;
 
@@ -422,8 +449,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
 
 int call_blocking_lsm_notifier(enum lsm_event event, void *data)
-- 
2.22.0.770.g0f2c4a37fd-goog

