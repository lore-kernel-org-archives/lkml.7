Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2048FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CC321835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvFufmcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfJOLTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:19:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37764 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfJOLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:19:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id p14so23356804wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJDLjD/EIRColwg8HoY5YztYO4bo1iRFSPlFTZN1y8c=;
        b=VvFufmcKjRgKS+OYLvvjAaOmyYGU3AMEcUtKz/v8TwOwXIvGpjDjqMfbZwaJkTj8uV
         cat0Snerxhdy+eDmboy5vuq/pc4XrTzomQnSsMrShpRTG9KZUAMKV9yfEV90EYasl00q
         Alr7X/z46Jx2JWhT9aGk0VMwOw4TECLF4QuCy/MOXQWsWZBt0TOBbEiYRqI+ws7lW5gH
         eqangALn9yzGC7CUWt+e7uCSJ4Zo52Tx1FtSH+yU+wfd8vHaWAG8mesC12G3yRU9A86+
         AgghRMSw4lmhk8UT+eYsQcrQVFso/XurvqUNr3UMKXJbvyWXHcxC6NXVOV+6oFfdYcLi
         RLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJDLjD/EIRColwg8HoY5YztYO4bo1iRFSPlFTZN1y8c=;
        b=qX/aclcnGXwWnASwtgP3GAgNbUWI6fMzjcF7N/PL2jirZt+X9eNLVcBwve19ATZkUV
         vrsdBkcGBAEZMfF+Om6ps6+b4v5U6ZivCprPXVuCjZuYtfL5dDlptbDVN+uCouCQjz/V
         BObrn8x8zZQplAHLvtQxr0uCK6FYMHoDYkZHX5uNSpCAiCXL481zafiTFcH7PCPiJG4t
         NMSizL94lotPWSTliXjDupFj6MN9DxPlO+9camCO8NBQIrZ1IfUOse0iWb05FNMbA9kB
         CCaOZ/UkRf1/kmVhWQjZw398hkibzVbF3nL+3pgtq/8ZOwfDUotewZ6pUPHwhmI8STlf
         IzPw==
X-Gm-Message-State: APjAAAW5qPUxvUciBHnDQt5LLGbSamaaqh9rbGj0gG/7rJ0a11RWeHmM
        Vs6D40XswcfaX1lHP55tDQ==
X-Google-Smtp-Source: APXvYqy5NOQUYrbb1+1GmEw80RjOkZ/mm0y70M5AgbvXY3HrrWPB8pP9jzYgVfYw5xIW8eJpP3/xzg==
X-Received: by 2002:a5d:46d2:: with SMTP id g18mr13330873wrs.245.1571138358237;
        Tue, 15 Oct 2019 04:19:18 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([212.118.206.70])
        by smtp.gmail.com with ESMTPSA id l9sm18487303wme.45.2019.10.15.04.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:19:17 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v9 4/4] ftrace: Add an option for tracing console latencies
Date:   Tue, 15 Oct 2019 13:19:10 +0200
Message-Id: <20191015111910.4496-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015111910.4496-1-viktor.rosendahl@gmail.com>
References: <20191015111910.4496-1-viktor.rosendahl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new kernel parameter "trace_console_latency" will enable the latency
tracers to trace the console latencies. Previously this has always been
implicitely disabled. I guess this is because they are considered to be
well known and unavoidable.

However, for some organizations it may nevertheless be desirable to
trace them. Basically, we want to be able to tell that there are
latencies in the system under test because someone has incorrectly
enabled the serial console.

Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 include/linux/irqflags.h                      | 22 +++++++++++++
 kernel/printk/printk.c                        |  6 ++--
 kernel/trace/trace_irqsoff.c                  | 32 +++++++++++++++++++
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a84a83f8881e..3f96a380c528 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4768,6 +4768,10 @@
 	trace_buf_size=nn[KMG]
 			[FTRACE] will set tracing buffer size on each cpu.
 
+	trace_console_latency=[0|1]
+			[FTRACE] Trace the console latencies if 1 is given. Do
+			not trace the latencies if 0 or no parameter is given.
+
 	trace_event=[event-list]
 			[FTRACE] Set and start specified trace events in order
 			to facilitate early boot debugging. The event-list is a
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..3de891723331 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -13,6 +13,7 @@
 #define _LINUX_TRACE_IRQFLAGS_H
 
 #include <linux/typecheck.h>
+#include <linux/types.h>
 #include <asm/irqflags.h>
 
 /* Currently trace_softirqs_on/off is used only by lockdep */
@@ -68,9 +69,30 @@ do {						\
 	defined(CONFIG_PREEMPT_TRACER)
  extern void stop_critical_timings(void);
  extern void start_critical_timings(void);
+ extern bool console_tracing_disabled(void);
+
+# define console_stop_critical_timings(flag)		\
+	do {						\
+		typecheck(bool, flag);			\
+		flag = console_tracing_disabled();	\
+		if (flag)				\
+			stop_critical_timings();	\
+	} while (0)
+
+# define console_start_critical_timings(flag)		 \
+	do {						 \
+		typecheck(bool, flag);			 \
+		if (flag)				 \
+			start_critical_timings();	 \
+	} while (0)
+
 #else
 # define stop_critical_timings() do { } while (0)
 # define start_critical_timings() do { } while (0)
+# define console_stop_critical_timings(flag)	\
+	do { typecheck(bool, flag); } while (0)
+# define console_start_critical_timings(flag)	\
+	do { typecheck(bool, flag); } while (0)
 #endif
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ca65327a6de8..f27e96273453 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2369,6 +2369,7 @@ void console_unlock(void)
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
 	unsigned long flags;
+	bool cflag;
 	bool do_cond_resched, retry;
 
 	if (console_suspended) {
@@ -2469,9 +2470,10 @@ void console_unlock(void)
 		 */
 		console_lock_spinning_enable();
 
-		stop_critical_timings();	/* don't trace print latency */
+		/* don't trace print latency if it's disabled */
+		console_stop_critical_timings(cflag);
 		call_console_drivers(ext_text, ext_len, text, len);
-		start_critical_timings();
+		console_start_critical_timings(cflag);
 
 		if (console_lock_spinning_disable_and_check()) {
 			printk_safe_exit_irqrestore(flags);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index a745b0cee5d3..84876192cc73 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -14,6 +14,7 @@
 #include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ftrace.h>
+#include <linux/init.h>
 #include <linux/kprobes.h>
 
 #include "trace.h"
@@ -456,6 +457,37 @@ void stop_critical_timings(void)
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 NOKPROBE_SYMBOL(stop_critical_timings);
 
+static bool no_console_latency __read_mostly = true;
+
+static int __init trace_console_latency(char *str)
+{
+	int param;
+
+	get_option(&str, &param);
+	no_console_latency = !(param == 1);
+
+	return 0;
+}
+
+early_param("trace_console_latency", trace_console_latency);
+
+bool console_tracing_disabled(void)
+{
+	int pc = preempt_count();
+
+	/*
+	 * If tracing is disabled, then the question of whether to trace console
+	 * latencies is moot. By always returning false here we save the caller
+	 * the calls to start/stop_critical_timings(). These calls would not do
+	 * anything anyway.
+	 */
+	if (!preempt_trace(pc) && !irq_trace())
+		return false;
+
+	return no_console_latency;
+}
+EXPORT_SYMBOL_GPL(console_tracing_disabled);
+
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
 
-- 
2.17.1

