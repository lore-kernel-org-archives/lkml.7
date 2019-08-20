Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA41C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA1A2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlxH5uYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfHTASP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:15 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:44856 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfHTASO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:14 -0400
Received: by mail-qk1-f201.google.com with SMTP id o4so5226694qkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i0tvJnPgM16fE/v88Mj7Ir2tHD98e473SFHYbAwN8qU=;
        b=SlxH5uYas+8Abm7SbQD1UL42mj14y/X4v46a1Kndi4jsQz5j91H+emmjpnbnKJqySS
         OqNq0UId1K/QgByJQcuXNTME8U5pe7GBkSZs3Pu8nZ3x4Zi0M29Y4/s3KgjIfFzJTbLo
         jh22sxA3oKcb6oBCsSPQj85hmZAk6DVsiIzPqHT6/FzFm0s6m0Kcp1+WXd5skg9j+9yZ
         gTm6S68VNzGzn+6hDx76u9ibDiVTNc/+69dh8Lqw4kq6U1beKKmMz0/S+/Z29M9nYIoc
         1x4ywaYx0P54AauCOlG2tBZ6t1q5tQI9xFhNZTTficSAnRM3iDCuk7ruvOFb122+JiS2
         E97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i0tvJnPgM16fE/v88Mj7Ir2tHD98e473SFHYbAwN8qU=;
        b=OdLGIqVPN6sKxyXevc9FW2ybLtpIZEyMXmVxE0rdRKFXFT+F8/ctwV/a8kHnq0nw0Y
         C+KSlkJkgTQt00DWHWFWaVyxiEsbGWtJ1TYTJRUjgRrjdAln0npPFRJ5vOm/sMdJkuCd
         oK7PkT208m2d3RElm3tu9SY4ZB3dtHvN6ebFoeMuaH/FqI82MHIRiI0tnUQhqqblysgw
         gL5GZvKVgLaGiF2H06d03m4MXeYjbVSNqD7HIqIQHGAukEX84Q/k2/TkoPi3wTsqJlzV
         lamPndbknVYxoejVMCJf3TMoGGoULkk+L696O3jCeAtoWs7UdIpjAEvPXRiDhIg2oCue
         No/w==
X-Gm-Message-State: APjAAAWvxzGlc5dwGFL+GfIsJlxpvH2F5vyc4XtFIuPLrvYXKt0TOJKm
        bk9Rm/8OGN/iXDD8PA/GR3f1xBlnRGaCjDHQIrFWYw==
X-Google-Smtp-Source: APXvYqyVwptPHKk2lGhsl1pUB9XAtwzz5s8x+rZmR9WdC5AJePpuUYNu/MBTLLOGeKZ2RPDbBkHAPr1bJZ8jjQVydWx2RQ==
X-Received: by 2002:ae9:d8c7:: with SMTP id u190mr7965911qkf.461.1566260292656;
 Mon, 19 Aug 2019 17:18:12 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:37 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 01/29] security: Support early LSMs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

(Fixed by Stephen Rothwell to include a stub to fix builds when
!CONFIG_SECURITY)

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-generic/vmlinux.lds.h |  8 ++++-
 include/linux/lsm_hooks.h         |  6 ++++
 include/linux/security.h          |  6 ++++
 init/main.c                       |  1 +
 security/security.c               | 50 ++++++++++++++++++++++++++-----
 5 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 088987e9a3ea..c1807d14daa3 100644
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
@@ -609,7 +614,8 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	EARLYCON_TABLE()						\
-	LSM_TABLE()
+	LSM_TABLE()							\
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47f58cfb6a19..b02e8bb6654d 100644
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
index 659071c2e57c..c5dd90981c98 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -195,6 +195,7 @@ int unregister_lsm_notifier(struct notifier_block *nb);
 
 /* prototypes */
 extern int security_init(void);
+extern int early_security_init(void);
 
 /* Security operations */
 int security_binder_set_context_mgr(struct task_struct *mgr);
@@ -423,6 +424,11 @@ static inline int security_init(void)
 	return 0;
 }
 
+static inline int early_security_init(void)
+{
+	return 0;
+}
+
 static inline int security_binder_set_context_mgr(struct task_struct *mgr)
 {
 	return 0;
diff --git a/init/main.c b/init/main.c
index 66a196c5e4c3..598effd29a0a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -569,6 +569,7 @@ asmlinkage __visible void __init start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
+	early_security_init();
 	setup_arch(&command_line);
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
diff --git a/security/security.c b/security/security.c
index f493db0bf62a..ef4a0111c8b4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -33,6 +33,7 @@
 
 /* How many LSMs were built into the kernel? */
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+#define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
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
 
 int call_lsm_notifier(enum lsm_event event, void *data)
-- 
2.23.0.rc1.153.gdeed80330f-goog

