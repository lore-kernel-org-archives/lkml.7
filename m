Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DABC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F4A2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDAKr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:47:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:14977 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDAKrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:47:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 03:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="146975622"
Received: from shbuild999.sh.intel.com ([10.239.147.118])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2019 03:47:22 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH 1/2] printk: Add an option to flush all messages on panic
Date:   Mon,  1 Apr 2019 18:48:03 +0800
Message-Id: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current console_flush_on_panic() will only dump the new messages
in buffer, and users may need an opportunity to check all the
messages on panic which could help debugging, as user may haven't
seen the log before panic due to loglevel settings.

Add a flag for console_flush_on_panic() to chose whether to
dump all messages.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/powerpc/kernel/traps.c | 2 +-
 include/linux/console.h     | 2 +-
 kernel/panic.c              | 2 +-
 kernel/printk/printk.c      | 9 ++++++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1fd45a8..58d9580 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -179,7 +179,7 @@ extern void panic_flush_kmsg_end(void)
 	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(0);
 	debug_locks_off();
-	console_flush_on_panic();
+	console_flush_on_panic(false);
 }
 
 static unsigned long oops_begin(struct pt_regs *regs)
diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3..825ecf5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -175,7 +175,7 @@ extern int console_trylock(void);
 extern void console_unlock(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
-extern void console_flush_on_panic(void);
+extern void console_flush_on_panic(bool flush_all);
 extern struct tty_driver *console_device(int *);
 extern void console_stop(struct console *);
 extern void console_start(struct console *);
diff --git a/kernel/panic.c b/kernel/panic.c
index 0ae0d73..fb77e01 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -277,7 +277,7 @@ void panic(const char *fmt, ...)
 	 * panic() is not being callled from OOPS.
 	 */
 	debug_locks_off();
-	console_flush_on_panic();
+	console_flush_on_panic(false);
 
 	panic_print_sys_info();
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827..8ff099b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2525,10 +2525,11 @@ void console_unblank(void)
 
 /**
  * console_flush_on_panic - flush console content on panic
+ * @flush_all:	whether to print all messages in buffer
  *
  * Immediately output all pending messages no matter what.
  */
-void console_flush_on_panic(void)
+void console_flush_on_panic(bool flush_all)
 {
 	/*
 	 * If someone else is holding the console lock, trylock will fail
@@ -2539,6 +2540,12 @@ void console_flush_on_panic(void)
 	 */
 	console_trylock();
 	console_may_schedule = 0;
+
+	/* User may want to see all the printk messages on panic */
+	if (flush_all) {
+		console_seq = log_first_seq;
+		console_idx = log_first_idx;
+	}
 	console_unlock();
 }
 
-- 
2.7.4

