Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60215C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CEB21738
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfGPH2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 03:28:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbfGPH2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:28:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92EF9B122;
        Tue, 16 Jul 2019 07:28:32 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>,
        Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] printk/panic: Access the main printk log in panic() only when safe
Date:   Tue, 16 Jul 2019 09:28:04 +0200
Message-Id: <20190716072805.22445-2-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190716072805.22445-1-pmladek@suse.com>
References: <20190716072805.22445-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel tries hard to store and show printk messages when panicking. Even
logbuf_lock gets re-initialized when only one CPU is running after
smp_send_stop().

Unfortunately, smp_send_stop() might fail on architectures that do not
use NMI as a fallback. Then printk log buffer might stay locked and
a deadlock is almost inevitable.

Now, printk_safe_flush_on_panic() is safe because it accesses the main
log buffer only when the lock is available. But kmgs_dump() and
console_unlock() callers might still cause a deadlock.

A better approach is to move printk lock busting into a separate function.
And call all dependent operations only when the lock is not blocked.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h      |  6 ++++++
 kernel/panic.c              | 49 +++++++++++++++++++++++++++------------------
 kernel/printk/printk_safe.c | 35 ++++++++++++++++++++------------
 3 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cefd374c47b1..4d15a0eda9c6 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -202,6 +202,7 @@ __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack(void) __cold;
+extern int printk_bust_lock_safe(void);
 extern void printk_safe_init(void);
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
@@ -269,6 +270,11 @@ static inline void dump_stack(void)
 {
 }
 
+static inline int printk_bust_lock_safe(void)
+{
+	return 0;
+}
+
 static inline void printk_safe_init(void)
 {
 }
diff --git a/kernel/panic.c b/kernel/panic.c
index 4d9f55bf7d38..aa50cdb75022 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -155,6 +155,26 @@ static void panic_print_sys_info(void)
 		ftrace_dump(DUMP_ALL);
 }
 
+/* Try hard to make the messages visible on the console. */
+void panic_console_dump(void)
+{
+#ifdef CONFIG_VT
+	unblank_screen();
+#endif
+	console_unblank();
+
+	/*
+	 * We may have ended up stopping the CPU holding the lock (in
+	 * smp_send_stop()) while still having some valuable data in the console
+	 * buffer.  Try to acquire the lock then release it regardless of the
+	 * result.  The release will also print the buffers out.  Locks debug
+	 * should be disabled to avoid reporting bad unlock balance when
+	 * panic() is not being callled from OOPS.
+	 */
+	debug_locks_off();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -169,6 +189,7 @@ void panic(const char *fmt, ...)
 	va_list args;
 	long i, i_next = 0, len;
 	int state = 0;
+	int printk_blocked;
 	int old_cpu, this_cpu;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
@@ -253,8 +274,11 @@ void panic(const char *fmt, ...)
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
 	/* Call flush even twice. It tries harder with a single online CPU */
-	printk_safe_flush_on_panic();
-	kmsg_dump(KMSG_DUMP_PANIC);
+	printk_blocked = printk_bust_lock_safe();
+	if (!printk_blocked) {
+		printk_safe_flush_on_panic();
+		kmsg_dump(KMSG_DUMP_PANIC);
+	}
 
 	/*
 	 * If you doubt kdump always works fine in any situation,
@@ -268,23 +292,10 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-#ifdef CONFIG_VT
-	unblank_screen();
-#endif
-	console_unblank();
-
-	/*
-	 * We may have ended up stopping the CPU holding the lock (in
-	 * smp_send_stop()) while still having some valuable data in the console
-	 * buffer.  Try to acquire the lock then release it regardless of the
-	 * result.  The release will also print the buffers out.  Locks debug
-	 * should be disabled to avoid reporting bad unlock balance when
-	 * panic() is not being callled from OOPS.
-	 */
-	debug_locks_off();
-	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
-
-	panic_print_sys_info();
+	if (!printk_blocked) {
+		panic_console_dump();
+		panic_print_sys_info();
+	}
 
 	if (!panic_blink)
 		panic_blink = no_blink;
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index b4045e782743..71d4b763f811 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -253,6 +253,26 @@ void printk_safe_flush(void)
 	}
 }
 
+/**
+ * printk_try_bust_lock - make printk log accessible when safe
+ *
+ * Return 0 when the log is accessible. Return -EWOULDBLOCK when
+ * it is not safe and likely to cause a deadlock.
+ */
+int printk_bust_lock_safe(void)
+{
+	if (!raw_spin_is_locked(&logbuf_lock))
+		return 0;
+
+	if (num_online_cpus() == 1) {
+		debug_locks_off();
+		raw_spin_lock_init(&logbuf_lock);
+		return 0;
+	}
+
+	return -EWOULDBLOCK;
+}
+
 /**
  * printk_safe_flush_on_panic - flush all per-cpu nmi buffers when the system
  *	goes down.
@@ -265,19 +285,8 @@ void printk_safe_flush(void)
  */
 void printk_safe_flush_on_panic(void)
 {
-	/*
-	 * Make sure that we could access the main ring buffer.
-	 * Do not risk a double release when more CPUs are up.
-	 */
-	if (raw_spin_is_locked(&logbuf_lock)) {
-		if (num_online_cpus() > 1)
-			return;
-
-		debug_locks_off();
-		raw_spin_lock_init(&logbuf_lock);
-	}
-
-	printk_safe_flush();
+	if (printk_bust_lock_safe() == 0)
+		printk_safe_flush();
 }
 
 #ifdef CONFIG_PRINTK_NMI
-- 
2.16.4

