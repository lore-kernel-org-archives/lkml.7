Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E044BCA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AF8222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9sSMfyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505132AbfJRPJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:09:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfJRPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:09:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so1518536wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJDLjD/EIRColwg8HoY5YztYO4bo1iRFSPlFTZN1y8c=;
        b=J9sSMfyqN6L7XYW+2AHS26ZzmYWN0l7Gt0B/iwdhtBDefJUf+xHp7nAjSJE+oi0W4J
         eT/YRvsMfP4Ffpj/6AKmwUxc+tYz5Z3jMu6rKSQLqzyex1slPTaQwcfPDps8hczBiDvN
         50nRrx2O8+t1D95T4nmjiHfc/R34X21jA5HUZ9oDXIaRFv7BksfLFZS/mKEHULRVQGC2
         Eq3GkvmdVSLqFAQH7X1PMsgpip8oUcto/cudGd8MjKhBkB2Pja7SlSd9V+Sm7oQID2sy
         TR6WBOXn2PQksuXrfgobYk/gy/PP/AEfLGlEUH27dFLki7WfwS7tHAGH6hUfq6UCUAbz
         cifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJDLjD/EIRColwg8HoY5YztYO4bo1iRFSPlFTZN1y8c=;
        b=F7bz0FWEuiY5M1lixlRSPOBmZiZtu52VgS+4p01H7sIUobQCD7gt3f7LKKeGuprlAS
         pGQsz5pe6go7gOEz4s0bo8fcQpTHAvsvVw+BimV1WyhuVrPO7VdvqHZsGkfBvzmWOnsg
         aS9kkOUslM0e7iWOEqYe4QfPDHheznXrJ78GHAUSaNQANRkIJJ0G0pllC2Ye9cEdR+ph
         HTJ+fcr6jxudkxzQ598FofF7Y2NWfU6pccigaeKEP2EqwtI69bpOCDc+hj/Lzmll+J47
         xRdzYxSx2WNjSj6bTq28AnepPNQB4HTs0XA/ENMXdzzChE82aBSDd+jq8szLUmq3AM3v
         5Snw==
X-Gm-Message-State: APjAAAUBXPwBBx+90FYLAK667K498edKXuLgmGhmwHJrCAEsM+pB+qtH
        3Rx7eBhnpSgych7hmEmkHg==
X-Google-Smtp-Source: APXvYqwF00Gstmr1i/j1Qfg8oSnGzLw5TYWuswtgS3HspUySm8l5cuKyX83guOfp22GwzF9tbFCqPQ==
X-Received: by 2002:a5d:408f:: with SMTP id o15mr7490760wrp.139.1571411338672;
        Fri, 18 Oct 2019 08:08:58 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id z6sm6035074wro.16.2019.10.18.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 08:08:58 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v10 4/4] ftrace: Add an option for tracing console latencies
Date:   Fri, 18 Oct 2019 17:08:52 +0200
Message-Id: <20191018150852.4322-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018150852.4322-1-viktor.rosendahl@gmail.com>
References: <20191018150852.4322-1-viktor.rosendahl@gmail.com>
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

