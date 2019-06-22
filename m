Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD5C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA142168B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hR20jTMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFVAEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:05 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40878 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfFVAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:05 -0400
Received: by mail-pl1-f202.google.com with SMTP id 91so4476651pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fMlhT4fwMMt7iRu5SpyzWIM9hHHfi6c27K0OkZeST/w=;
        b=hR20jTMVzfnPAlv9JegM8qiBiqwD+EZG5g1R1J/R5fWpPtupkfeb0V2LpOIpc0jdTW
         mycqq1p38Fy3vw8TkmbC0YIbLt9wpmBlciL6BrcObPQiSzfqiFU3dyu1v+uVD9NPubku
         YvXpeJSNZ5w+NN83LqMzmSvxi6klBdRC7BTfRsFM9EwVfvgkWBLXE3H7wUESGq+6diLu
         eXBTxDCJ3nQXDBVuf57sSRyG5ivhhzW5qdeGb3qJCsM4Q8hhnrrNtWS0CS+1iKpuYbe/
         cZBf4bUSjYxP0n39VZ4jEsha0mjWXHDylnyEs/aSfQ+4FJiQU2n0tZLcyqg/0WC+U9ec
         gqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fMlhT4fwMMt7iRu5SpyzWIM9hHHfi6c27K0OkZeST/w=;
        b=TXlIqN6dXdpDmqE91ZxFttZtQG8dEVqohYw51mEZpHpnQV+T+GHU+Mv/mV0V9zm6cn
         ESsclJTHACGPhoGTWAdBqkh/jxpFFCURBnaGOavR4TuT6wOkGH2OrMahTPEzcoeHOf5o
         8gad34jUmjy3JRrZR0ac//0VdqJvhVCTzuUQ5nxlj6Pq7kpPV2MaH2AiovkUSXkdiy9Z
         NwCOAYxRkT4YwuwtJNKJVfLailpvGsmqYvP5ECYqW52ogDFbf651tmjWywf2cXlDZpHI
         kZmx0LkaTH2XSDfWBCRya1/eQMmvmIcCYzCzmMyvNUMhM1O8xmmq53Xx+z7G5LdieXsi
         HOdg==
X-Gm-Message-State: APjAAAUpCW8vLV8RLOHE5z1QAKW5XhNQZK8JDdRmGe7N+d51rjW/TxPT
        Fex/r73rCXgWR3TrkmQnANiioknT5AJIG8LkhPPEzA==
X-Google-Smtp-Source: APXvYqyELKYkW92f3mx5I4vwBY+gIiYVgRoC1bFR+V6tTn4vOIUHzxlUziAbrt07IWpMIPz3KF+zewNiFpYvGlGJVYxx0Q==
X-Received: by 2002:a63:4415:: with SMTP id r21mr20620706pga.182.1561161843894;
 Fri, 21 Jun 2019 17:04:03 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:30 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-2-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 01/29] security: Support early LSMs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
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
Early LSMs are initialised in link order and cannot be overridden via
boot parameters, and cannot make use of kmalloc() (since the allocator
isn't initialised yet).

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 include/asm-generic/vmlinux.lds.h |  8 ++++-
 include/linux/lsm_hooks.h         |  6 ++++
 include/linux/security.h          |  1 +
 init/main.c                       |  1 +
 security/security.c               | 50 ++++++++++++++++++++++++++-----
 5 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f8f6f04c4453..e1963352fdb6 100644
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
index a240a3fc5fc4..66fd1eac7a32 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2085,12 +2085,18 @@ struct lsm_info {
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
index 49f2685324b0..1bb6fb2f1523 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -194,6 +194,7 @@ int unregister_lsm_notifier(struct notifier_block *nb);
 
 /* prototypes */
 extern int security_init(void);
+extern int early_security_init(void);
 
 /* Security operations */
 int security_binder_set_context_mgr(struct task_struct *mgr);
diff --git a/init/main.c b/init/main.c
index 598e278b46f7..f3faeb89c75f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -563,6 +563,7 @@ asmlinkage __visible void __init start_kernel(void)
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
+	early_security_init();
 	setup_arch(&command_line);
 	/*
 	 * Set up the the initial canary and entropy after arch
diff --git a/security/security.c b/security/security.c
index 23cbb1a295a3..487e1f3eb2df 100644
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
@@ -327,6 +330,26 @@ static void __init ordered_lsm_init(void)
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
@@ -334,14 +357,18 @@ static void __init ordered_lsm_init(void)
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
@@ -388,7 +415,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
 	return !strcmp(last, lsm);
 }
 
-static int lsm_append(char *new, char **result)
+static int lsm_append(const char *new, char **result)
 {
 	char *cp;
 
@@ -426,8 +453,15 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
2.22.0.410.gd8fdbe21b5-goog

