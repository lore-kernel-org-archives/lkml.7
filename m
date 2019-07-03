Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3292EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6D821882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CE+SFJ51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfGCREr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:04:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33778 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCREr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:04:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so1595291pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UmPDjs3GC5y05O+oZrqETNtB8YeU/EW2F2rKy6gZYM=;
        b=CE+SFJ51m98HEAk8kgNmqvYvCWofjk5rGAhF3Elt5bcDGLdmEcucHq00QvIjP89zrX
         hu148gAghEBmxJ8NsPimHOa/aT1biE8OaAaFKWjfHLSqUHAzBkeRx6BhbS7YLKY+XI5s
         Zz9C4shehSMwv2zep4uH9Lx2318mHw/flZj+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UmPDjs3GC5y05O+oZrqETNtB8YeU/EW2F2rKy6gZYM=;
        b=GO/HF0I4IpmJ69Z5PEjCcy8D5xhIT5BuyrW3sqAa/rF7U/IBE3T6IMttSBNl4rsEmN
         dOLGyTOtK/keRZi4YZHbi+xRt1VLaV2GrYTiHKdH/e7cSywaX3iaG7CxOenzvlrAeQHQ
         k0BgbNaKHg2zkEK6op9nxacEbn5in1t57ZzHqTHUwSlyMGZIf7Wx0S8Wr/IOJU9VLhZz
         RODBtzb8Oa/lzNXJdifugiU81Rp29QbaFsy1arcKIj6fpnTO1Vn3PP4FHAgOtUBTS9E9
         Cl+44yrJ+wy8pbpxTiNHqrNirY+VhTI9Tknm/Kvr4N3Wnt9sJsytBobaaXb9677x7UGg
         pDfg==
X-Gm-Message-State: APjAAAVYfouhEynlTedb24bdlpyxGqFRWi6u2y4hh57fp5ko2QfaQ119
        ZoWBkix004O/+rkCTKProbaawQ==
X-Google-Smtp-Source: APXvYqxX1K1OeKVXQOBcW9auPYZkXDcwye8GnP0TxTOWeq4hZJnaeE2iK6rzD5yBrEYcFe8IYYAFqQ==
X-Received: by 2002:a63:6c04:: with SMTP id h4mr7204915pgc.94.1562173486714;
        Wed, 03 Jul 2019 10:04:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u75sm2767289pgb.92.2019.07.03.10.04.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 10:04:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH] kgdb: Don't use a notifier to enter kgdb at panic; call directly
Date:   Wed,  3 Jul 2019 10:03:54 -0700
Message-Id: <20190703170354.217312-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now kgdb/kdb hooks up to debug panics by registering for the
panic notifier.  This works OK except that it means that kgdb/kdb gets
called _after_ the CPUs in the system are taken offline.  That means
that if anything important was happening on those CPUs (like something
that might have contributed to the panic) you can't debug them.

Specifically I ran into a case where I got a panic because a task was
"blocked for more than 120 seconds" which was detected on CPU 2.  I
nicely got shown stack traces in the kernel log for all CPUs including
CPU 0, which was running 'PID: 111 Comm: kworker/0:1H' and was in the
middle of __mmc_switch().

I then ended up at the kdb prompt where switched over to kgdb to try
to look at local variables of the process on CPU 0.  I found that I
couldn't.  Digging more, I found that I had no info on any tasks
running on CPUs other than CPU 2 and that asking kdb for help showed
me "Error: no saved data for this cpu".  This was because all the CPUs
were offline.

Let's move the entry of kdb/kgdb to a direct call from panic() and
stop using the generic notifier.  Putting a direct call in allows us
to order things more properly and it also doesn't seem like we're
breaking any abstractions by calling into the debugger from the panic
function.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/kgdb.h      |  2 ++
 kernel/debug/debug_core.c | 31 +++++++++++--------------------
 kernel/panic.c            |  8 ++++++++
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index fbf144aaa749..b072aeb1fd78 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -326,8 +326,10 @@ extern atomic_t			kgdb_active;
 	(raw_smp_processor_id() == atomic_read(&kgdb_active))
 extern bool dbg_is_early;
 extern void __init dbg_late_init(void);
+extern void kgdb_panic(const char *msg);
 #else /* ! CONFIG_KGDB */
 #define in_dbg_master() (0)
 #define dbg_late_init()
+static inline void kgdb_panic(const char *msg) {}
 #endif /* ! CONFIG_KGDB */
 #endif /* _KGDB_H_ */
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 5cc608de6883..b26bf06cff9e 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -896,30 +896,25 @@ static struct sysrq_key_op sysrq_dbg_op = {
 };
 #endif
 
-static int kgdb_panic_event(struct notifier_block *self,
-			    unsigned long val,
-			    void *data)
+void kgdb_panic(const char *msg)
 {
+	if (!kgdb_io_module_registered)
+		return;
+
 	/*
-	 * Avoid entering the debugger if we were triggered due to a panic
-	 * We don't want to get stuck waiting for input from user in such case.
-	 * panic_timeout indicates the system should automatically
+	 * We don't want to get stuck waiting for input from user if
+	 * "panic_timeout" indicates the system should automatically
 	 * reboot on panic.
 	 */
 	if (panic_timeout)
-		return NOTIFY_DONE;
+		return;
 
 	if (dbg_kdb_mode)
-		kdb_printf("PANIC: %s\n", (char *)data);
+		kdb_printf("PANIC: %s\n", msg);
+
 	kgdb_breakpoint();
-	return NOTIFY_DONE;
 }
 
-static struct notifier_block kgdb_panic_event_nb = {
-       .notifier_call	= kgdb_panic_event,
-       .priority	= INT_MAX,
-};
-
 void __weak kgdb_arch_late(void)
 {
 }
@@ -968,8 +963,6 @@ static void kgdb_register_callbacks(void)
 			kgdb_arch_late();
 		register_module_notifier(&dbg_module_load_nb);
 		register_reboot_notifier(&dbg_reboot_notifier);
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &kgdb_panic_event_nb);
 #ifdef CONFIG_MAGIC_SYSRQ
 		register_sysrq_key('g', &sysrq_dbg_op);
 #endif
@@ -983,16 +976,14 @@ static void kgdb_register_callbacks(void)
 static void kgdb_unregister_callbacks(void)
 {
 	/*
-	 * When this routine is called KGDB should unregister from the
-	 * panic handler and clean up, making sure it is not handling any
+	 * When this routine is called KGDB should unregister from
+	 * handlers and clean up, making sure it is not handling any
 	 * break exceptions at the time.
 	 */
 	if (kgdb_io_module_registered) {
 		kgdb_io_module_registered = 0;
 		unregister_reboot_notifier(&dbg_reboot_notifier);
 		unregister_module_notifier(&dbg_module_load_nb);
-		atomic_notifier_chain_unregister(&panic_notifier_list,
-					       &kgdb_panic_event_nb);
 		kgdb_arch_exit();
 #ifdef CONFIG_MAGIC_SYSRQ
 		unregister_sysrq_key('g', &sysrq_dbg_op);
diff --git a/kernel/panic.c b/kernel/panic.c
index 4d9f55bf7d38..e2971168b059 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -12,6 +12,7 @@
 #include <linux/debug_locks.h>
 #include <linux/sched/debug.h>
 #include <linux/interrupt.h>
+#include <linux/kgdb.h>
 #include <linux/kmsg_dump.h>
 #include <linux/kallsyms.h>
 #include <linux/notifier.h>
@@ -219,6 +220,13 @@ void panic(const char *fmt, ...)
 		dump_stack();
 #endif
 
+	/*
+	 * If kgdb is enabled, give it a chance to run before we stop all
+	 * the other CPUs or else we won't be able to debug processes left
+	 * running on them.
+	 */
+	kgdb_panic(buf);
+
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
-- 
2.22.0.410.gd8fdbe21b5-goog

