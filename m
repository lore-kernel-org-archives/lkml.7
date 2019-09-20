Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3778CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020EC2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYxF2dlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393455AbfITPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:22:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38416 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392660AbfITPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:22:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so2648547wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XskHS+WdU2Ony2n0NoowY2zadP3U6aF79TWuTmNkbQo=;
        b=VYxF2dlrRdpftddAptDyxjCLQ4q89NWs8DvFnD8xMK4dM8KSE7ua5/jtnzvBQDLfb3
         AakwfIc15b1XfHqGlzb4/50swt4Xb0HYeeV1hxxeyGISQ3RIPwaVlsC+w3t96u9j8Exu
         XXK6NasDRZTfKtECr7UtC4xOEafky20+SEHlpvVghbzxwnAOFEd0Ic5gY+fMQjBtVBkc
         cokdyRf+5obuBWg8ld/H6m0aO9ibWHqLlPRcPb8GRYEIBoc5hoGX9+s/tSHe1EoK7ULa
         DIZ5WNWuWXG30kyiQZYckiBGuC4lmKp/1VQMFRUEtdv9goaj7a/pPdKxs5lu2uNSTajB
         D+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XskHS+WdU2Ony2n0NoowY2zadP3U6aF79TWuTmNkbQo=;
        b=X6k9Ye5K0SIOVDSqIKobnNP8wvu3oOUnAzhiTxiBtbs7iU4OKGU3SjzNC04DO9aeXI
         +VYBLE2HOIfkypsVkopDOWnq7FTNvitA1dYfo8zEN+4gUpuy44EB/umw30xr9ACeMkOD
         1hoPAXT6Az66PWb44Ss5/cEt9W7bgLrq9k2yXPVnv24zxVbUoQorPkz3Hnj4J99Y+vGt
         H85JwuWCI/T+LN+5MsGoqH273ARQKZz/3Py9UqfFEvfHwFOzgqgm5FxB3lyc4J1n3j+5
         /7RVsK5QsMo9Qt+9r3KHKAiL+GQgTMVjXE/zJQQ9cF7dAdfen6/nELrSofWTmhZVO+Oo
         ir1g==
X-Gm-Message-State: APjAAAVxHZHPuopo3lJKQaJrD8mmsGkdPIXaR2M8hRxZqku/algseYsb
        qJ01vH0ItcL3IoSjAA0bHA==
X-Google-Smtp-Source: APXvYqyORye21WeQwZYvkJpG9rY/Rql7/+C3mLppRZF/nJ3V1sbIH/E5e+GWvMZV6bvuLH0Im2MbiA==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr3930026wmj.21.1568992947783;
        Fri, 20 Sep 2019 08:22:27 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id x2sm3152901wrn.81.2019.09.20.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 08:22:27 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v7 4/4] ftrace: Add an option for tracing console latencies
Date:   Fri, 20 Sep 2019 17:22:19 +0200
Message-Id: <20190920152219.12920-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new trace option "console-latency" will enable the latency
tracers to trace the console latencies. Previously this has always been
implicitely disabled. I guess this is because they are considered
to be well known and unavoidable.

However, for some organizations it may nevertheless be desirable to
trace them. Basically, we want to be able to tell that there are
latencies in the system under test because someone has incorrectly
enabled the serial console.

Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
---
 include/linux/irqflags.h     | 22 ++++++++++++++++++++++
 kernel/printk/printk.c       |  6 ++++--
 kernel/trace/trace.h         |  1 +
 kernel/trace/trace_irqsoff.c | 12 ++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

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
index 1888f6a3b694..036460a7e4cd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2359,6 +2359,7 @@ void console_unlock(void)
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
 	unsigned long flags;
+	bool cflag;
 	bool do_cond_resched, retry;
 
 	if (console_suspended) {
@@ -2459,9 +2460,10 @@ void console_unlock(void)
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
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4913ed1138aa..93a8b82c27e4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1262,6 +1262,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
 		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
 		C(LATENCY_FMT,		"latency-format"),	\
+		C(CONSOLE_LATENCY,	"console-latency"),	\
 		C(RECORD_CMD,		"record-cmd"),		\
 		C(RECORD_TGID,		"record-tgid"),		\
 		C(OVERWRITE,		"overwrite"),		\
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index a745b0cee5d3..bc02be207a7a 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -456,6 +456,18 @@ void stop_critical_timings(void)
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 NOKPROBE_SYMBOL(stop_critical_timings);
 
+bool console_tracing_disabled(void)
+{
+	struct trace_array *tr = irqsoff_trace;
+	int pc = preempt_count();
+
+	if (!preempt_trace(pc) && !irq_trace())
+		return false;
+
+	return !(tr->trace_flags & TRACE_ITER_CONSOLE_LATENCY);
+}
+EXPORT_SYMBOL_GPL(console_tracing_disabled);
+
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
 
-- 
2.17.1

