Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8AFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F4221835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbMM+r5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfJHWIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:08:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39344 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfJHWIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:08:41 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so475179qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cc1mgqSFsnASi0kexgUwgUG8R6ufIfMJvS3HAT07t0k=;
        b=KbMM+r5Jq9+pe29EPXYf9jm216IRZ0INejsD5aX9mEruhzgPQVAoWyLo2y5rgRaUAl
         9m0yyccuB0iJCJ/zVqCSeUQWUQiEshDAzvzrPu/E9soyJqI1OraSi5DjZ3s3sIR1+r74
         6o2NbqvARw3Xm+JHeekIi2+/mXXRYX2iZBJm0DDhWSZAM3StZ1dQ0vS4ZnTTS4syIf+9
         SKlYcdwzJvF+XQoGgE/lhiI6gWszEh8YFMucALoxkFWdx43ojdR9zestMpLo6YLMLB1m
         4ukNvy1cF6KX9R7zPtrGlPdPhoAyQohhaE6zUihno9Adp/mFl4etFXifHvSzZyJ8PWtR
         ABOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cc1mgqSFsnASi0kexgUwgUG8R6ufIfMJvS3HAT07t0k=;
        b=pTYEgdwBjIRtdGgcQ6EbMkXclTHmPwpeAcODfuNIPGr6HrMPhnl8mZ01uYQQbSX3of
         5sQnO1sAe+43uhWobrRRnovTnN8784NDU9wV2+SMiGfP3dA3lCbildEdXN2pCut2xEI4
         8QO0apbyXs0EI6eA/2xYjIvQ7crfhZf+LzPHU4p9Hlusnxpq4F0ZSjUoG0z08BtSVIgu
         +FhwUn2Q+/uQuFH+i/MgPmDf+nQZxpzrWxWpjVLR9ihut4zI0iUUx+ZTda0yBX4MKVQw
         UprZy5Md10kyZL2/EUsJybnx98rD3HsQM070z8s5vxVP6oW4SCs1cBQ5+fN+zWgFAPNd
         xBWQ==
X-Gm-Message-State: APjAAAVd7WlI80ncm1Fo3y64p/oVfywxUMId4d/EmMFKOlHovn+t2WlF
        1LdcYkfCYrG/4KOsb0tn6ht2DfE=
X-Google-Smtp-Source: APXvYqxZouJAAp1raTUWavrNijD6/PLMJxsKw3IBgDcjCWHPeqQjHrle7rGuIRjlOjT/BkFfvbbZng==
X-Received: by 2002:ac8:16eb:: with SMTP id y40mr154251qtk.67.1570572519547;
        Tue, 08 Oct 2019 15:08:39 -0700 (PDT)
Received: from localhost.localdomain ([92.117.168.143])
        by smtp.gmail.com with ESMTPSA id m19sm42346qke.22.2019.10.08.15.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 15:08:38 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v8 4/4] ftrace: Add an option for tracing console latencies
Date:   Wed,  9 Oct 2019 00:08:24 +0200
Message-Id: <20191008220824.7911-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008220824.7911-1-viktor.rosendahl@gmail.com>
References: <20191008220824.7911-1-viktor.rosendahl@gmail.com>
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
 kernel/trace/trace_irqsoff.c | 18 ++++++++++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

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
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 591c7a873235..10d12c8f7f77 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1261,6 +1261,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
 		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
 		C(LATENCY_FMT,		"latency-format"),	\
+		C(CONSOLE_LATENCY,	"console-latency"),	\
 		C(RECORD_CMD,		"record-cmd"),		\
 		C(RECORD_TGID,		"record-tgid"),		\
 		C(OVERWRITE,		"overwrite"),		\
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index a745b0cee5d3..576e2162114e 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -456,6 +456,24 @@ void stop_critical_timings(void)
 EXPORT_SYMBOL_GPL(stop_critical_timings);
 NOKPROBE_SYMBOL(stop_critical_timings);
 
+bool console_tracing_disabled(void)
+{
+	struct trace_array *tr = irqsoff_trace;
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
+	return !(tr->trace_flags & TRACE_ITER_CONSOLE_LATENCY);
+}
+EXPORT_SYMBOL_GPL(console_tracing_disabled);
+
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
 
-- 
2.17.1

