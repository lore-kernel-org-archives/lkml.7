Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2A92086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDAKr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:47:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:14977 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDAKr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:47:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 03:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="146975627"
Received: from shbuild999.sh.intel.com ([10.239.147.118])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2019 03:47:24 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/2] panic: Enable to print out all printk msg in buffer
Date:   Mon,  1 Apr 2019 18:48:04 +0800
Message-Id: <1554115684-26846-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on panic, kernel will lower the loglevel and print out
new printk msg only. With this patch, user can configure the
"panic_print" to see all dmesg in buffer, some of which they may
have never seen due to the loglevel setting.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 kernel/panic.c                                  | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

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
diff --git a/kernel/panic.c b/kernel/panic.c
index fb77e01..afe023e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -51,6 +51,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_TIMER_INFO		0x00000004
 #define PANIC_PRINT_LOCK_INFO		0x00000008
 #define PANIC_PRINT_FTRACE_INFO		0x00000010
+#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -134,6 +135,13 @@ EXPORT_SYMBOL(nmi_panic);
 
 static void panic_print_sys_info(void)
 {
+	bool flush_all_dmesg = false;
+
+	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+		flush_all_dmesg = true;
+
+	console_flush_on_panic(flush_all_dmesg);
+
 	if (panic_print & PANIC_PRINT_TASK_INFO)
 		show_state();
 
@@ -277,7 +285,6 @@ void panic(const char *fmt, ...)
 	 * panic() is not being callled from OOPS.
 	 */
 	debug_locks_off();
-	console_flush_on_panic(false);
 
 	panic_print_sys_info();
 
-- 
2.7.4

