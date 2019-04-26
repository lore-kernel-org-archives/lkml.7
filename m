Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C419EC4321B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A126B20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDZJLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:11:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:40893 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfDZJLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:11:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 02:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,397,1549958400"; 
   d="scan'208";a="134562177"
Received: from shbuild999.sh.intel.com ([10.239.146.112])
  by orsmga007.jf.intel.com with ESMTP; 26 Apr 2019 02:11:03 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: [PATCH] panic: add an option to replay all the printk message in buffer
Date:   Fri, 26 Apr 2019 17:11:08 +0800
Message-Id: <1556269868-22654-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on panic, kernel will lower the loglevel and print out
pending printk msg only with console_flush_on_panic().

Add an option for users to configure the "panic_print" to replay
all dmesg in buffer, some of which they may have never seen due
to the loglevel setting, which will help panic debugging.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
---
Changelog:
  v5:
    - Use logbuf lock to protect the console log index
      changing, suggested by Petr Mladek

  v4:
    - keep the original console_flush_on_panic() inside
      panic(), as suggested by Petr Mladek

  v3:
    - Solve the compile issue when CONFIG_PRINTK=n, found by
      Andrew Morton
    - Add enum for parameter of console_flush_on_panic()
    - move the printk replay code to console_flush_on_panic()

  v2:
    - Add a new func in printk.c dedicated for the replaying, as
      suggested by Petr Mladek
    - Combine the 2 patches in v1 into one suggested by both Petr
      and Sergey



 Documentation/admin-guide/kernel-parameters.txt |  1 +
 arch/powerpc/kernel/traps.c                     |  2 +-
 include/linux/console.h                         |  7 ++++++-
 kernel/panic.c                                  |  6 +++++-
 kernel/printk/printk.c                          | 12 +++++++++++-
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90..7b15c94 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3135,6 +3135,7 @@
 			bit 2: print timer info
 			bit 3: print locks info if CONFIG_LOCKDEP is on
 			bit 4: print ftrace buffer
+			bit 5: print all printk messages in buffer
 
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1fd45a8..0fb785e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -179,7 +179,7 @@ extern void panic_flush_kmsg_end(void)
 	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(0);
 	debug_locks_off();
-	console_flush_on_panic();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 }
 
 static unsigned long oops_begin(struct pt_regs *regs)
diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3..d09951d 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -166,6 +166,11 @@ struct console {
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
+enum con_flush_mode {
+	CONSOLE_FLUSH_PENDING,
+	CONSOLE_REPLAY_ALL,
+};
+
 extern int add_preferred_console(char *name, int idx, char *options);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
@@ -175,7 +180,7 @@ extern int console_trylock(void);
 extern void console_unlock(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
-extern void console_flush_on_panic(void);
+extern void console_flush_on_panic(enum con_flush_mode mode);
 extern struct tty_driver *console_device(int *);
 extern void console_stop(struct console *);
 extern void console_start(struct console *);
diff --git a/kernel/panic.c b/kernel/panic.c
index 0ae0d73..f795feb 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_TIMER_INFO		0x00000004
 #define PANIC_PRINT_LOCK_INFO		0x00000008
 #define PANIC_PRINT_FTRACE_INFO		0x00000010
+#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -134,6 +135,9 @@ EXPORT_SYMBOL(nmi_panic);
 
 static void panic_print_sys_info(void)
 {
+	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+		console_flush_on_panic(CONSOLE_REPLAY_ALL);
+
 	if (panic_print & PANIC_PRINT_TASK_INFO)
 		show_state();
 
@@ -277,7 +281,7 @@ void panic(const char *fmt, ...)
 	 * panic() is not being callled from OOPS.
 	 */
 	debug_locks_off();
-	console_flush_on_panic();
+	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
 	panic_print_sys_info();
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827..e22b6f3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2525,10 +2525,11 @@ void console_unblank(void)
 
 /**
  * console_flush_on_panic - flush console content on panic
+ * @mode: flush all messages in buffer or just the pending ones
  *
  * Immediately output all pending messages no matter what.
  */
-void console_flush_on_panic(void)
+void console_flush_on_panic(enum con_flush_mode mode)
 {
 	/*
 	 * If someone else is holding the console lock, trylock will fail
@@ -2539,6 +2540,15 @@ void console_flush_on_panic(void)
 	 */
 	console_trylock();
 	console_may_schedule = 0;
+
+	if (mode == CONSOLE_REPLAY_ALL) {
+		unsigned long flags;
+
+		logbuf_lock_irqsave(flags);
+		console_seq = log_first_seq;
+		console_idx = log_first_idx;
+		logbuf_unlock_irqrestore(flags);
+	}
 	console_unlock();
 }
 
-- 
2.7.4

