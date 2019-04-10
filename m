Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA92EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A4A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfDJPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:33:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:23739 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDJPd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:33:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 08:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="134596113"
Received: from shbuild888.sh.intel.com ([10.239.147.114])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2019 08:33:55 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] panic: add an option to replay all the printk message in buffer
Date:   Wed, 10 Apr 2019 23:37:18 +0800
Message-Id: <20190410153718.22905-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on panic, kernel will lower the loglevel and print out
new printk msg only with console_flush_on_panic().

Add an option for users to configure the "panic_print" to see
all dmesg in buffer, some of which they may have never seen due
to the loglevel setting, which will help debugging too.

Thanks to Petr Mladek as somes codes come directly from the sample
code in his review comments.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  v2:
    - Add a new func in printk.c dedicated for the replaying, as
      suggested by Petr Mladekand
    - Combine the 2 patches in v1 into one suggested by both Petr
      and Sergey

 Documentation/admin-guide/kernel-parameters.txt |  1 +
 include/linux/console.h                         |  1 +
 kernel/panic.c                                  |  5 +++
 kernel/printk/printk.c                          | 46 ++++++++++++++++++++-----
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..7b15c9442325 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3135,6 +3135,7 @@
 			bit 2: print timer info
 			bit 3: print locks info if CONFIG_LOCKDEP is on
 			bit 4: print ftrace buffer
+			bit 5: print all printk messages in buffer
 
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3d7bab..42f611a6b7ea 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -176,6 +176,7 @@ extern void console_unlock(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
 extern void console_flush_on_panic(void);
+extern void console_replay_on_panic(void);
 extern struct tty_driver *console_device(int *);
 extern void console_stop(struct console *);
 extern void console_start(struct console *);
diff --git a/kernel/panic.c b/kernel/panic.c
index 0ae0d7332f12..5a3b7e302c8e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_TIMER_INFO		0x00000004
 #define PANIC_PRINT_LOCK_INFO		0x00000008
 #define PANIC_PRINT_FTRACE_INFO		0x00000010
+#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -134,6 +135,10 @@ EXPORT_SYMBOL(nmi_panic);
 
 static void panic_print_sys_info(void)
 {
+	/* Replay existing messages before adding other sys info. */
+	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+		console_replay_on_panic();
+
 	if (panic_print & PANIC_PRINT_TASK_INFO)
 		show_state();
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827b8fac..97aab099d22a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -269,6 +269,9 @@ EXPORT_SYMBOL(console_set_on_cmdline);
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
 
+/* Whether to print all messages in buffer */
+static int console_replay;
+
 enum con_msg_format_flags {
 	MSG_FORMAT_DEFAULT	= 0,
 	MSG_FORMAT_SYSLOG	= (1 << 0),
@@ -2386,21 +2389,32 @@ void console_unlock(void)
 
 	for (;;) {
 		struct printk_log *msg;
+		int reset_idx = 0;
 		size_t ext_len = 0;
-		size_t len;
+		size_t len = 0;
 
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
+
 		if (console_seq < log_first_seq) {
 			len = sprintf(text,
 				      "** %llu printk messages dropped **\n",
 				      log_first_seq - console_seq);
 
 			/* messages are gone, move to first one */
+			reset_idx = 1;
+		}
+
+		if (console_replay) {
+			len += sprintf(text + len,
+				       "Replaying the entire log:\n");
+			reset_idx = 1;
+			console_replay = 0;
+		}
+
+		if (reset_idx) {
 			console_seq = log_first_seq;
 			console_idx = log_first_idx;
-		} else {
-			len = 0;
 		}
 skip:
 		if (console_seq == log_next_seq)
@@ -2523,12 +2537,7 @@ void console_unblank(void)
 	console_unlock();
 }
 
-/**
- * console_flush_on_panic - flush console content on panic
- *
- * Immediately output all pending messages no matter what.
- */
-void console_flush_on_panic(void)
+static void __flush_on_panic(int replay)
 {
 	/*
 	 * If someone else is holding the console lock, trylock will fail
@@ -2539,9 +2548,28 @@ void console_flush_on_panic(void)
 	 */
 	console_trylock();
 	console_may_schedule = 0;
+	console_replay = replay ? 1 : 0;
 	console_unlock();
 }
 
+/**
+ * console_flush_on_panic - flush console content on panic
+ *
+ * Immediately output all pending messages no matter what.
+ */
+void console_flush_on_panic(void)
+{
+	__flush_on_panic(0);
+}
+
+/**
+ * console_replay_on_panic - replay all messages in buffer on panic
+ */
+void console_replay_on_panic(void)
+{
+	__flush_on_panic(1);
+}
+
 /*
  * Return the console tty driver structure and its associated index
  */
-- 
2.14.1

