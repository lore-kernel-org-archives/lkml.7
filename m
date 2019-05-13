Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FEC2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrg3AfqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEMVuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:50:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44632 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfEMVuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:50:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so19657403edm.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=isxZOxalCqIQgR18teS6HBBiX9h5vav9beRyCO+k5fg=;
        b=Hrg3AfqPO2a0aMn8m9lLbEmYSpuqgzXBTaDf0CYhWJQg0O9QSg/Rahy1nXG9ZlxI1r
         PpC4wdraxt4INBEy08hU4lEiEE9n0yP1/Mh/VIay8Ocm4U/4y5FpTHv+G+HUOR9qj2+U
         vhtL0BznCnQqe0E8jexIdlrhpliNnxxqvkXlWrMzTXGZTInB42RhS2cUvBuOEhnyvPDL
         uaWmXs7dTt9z9VC3Ju3z1p6reRqXRGaEs5yAIaBeloYQyCl9jKxIbnOtVMQeqrw7QYtP
         EAkaKcGwlWNjz8TopiPndjMSpeq4okX35MdMMHYutmyuiwvFm5sBrT+1/gZtbedZs/bc
         5+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=isxZOxalCqIQgR18teS6HBBiX9h5vav9beRyCO+k5fg=;
        b=fR8BKprY+1q81ZYXTga4t4XkGViqa2yzxFGpVVkO42wsei/Q4CRsSOKq8ymc5Uxyyy
         rFlOl/L7qN83A7TB62JkeUdS3u3yOihS/GKIfg+YzTz6wrdxm9uWNMqlUdDmBxm3Gi6r
         7AXv47VO3aQ5P6yovXmFoSF9OMbhLUxSL3OlN4cbGWvVp3Kp3RTs19qf4d8mvVcSNlIO
         5CGxTuO88uc7IaZN+YjowwgYOPj1gk1O5ssEcGtZE/HaKGdV8fUSBQUV1+1imYeZYUpy
         cG4iIP+lEA//PZdL4dC5+KQ2yZc1JRbtzFL3n36/VnYuk5JHrup1d+kqXxrs+20t3Kek
         GAQA==
X-Gm-Message-State: APjAAAWkm7QxGb0GBLsMtSuZhymGB4SsgqF37lzKPEyNmO2KaudpnUCV
        z59g60DFxdyXX/aGfGAp6A==
X-Google-Smtp-Source: APXvYqxZzhpmFk00bIOCP3TJ8/P6ynDoJ9ceAoDxwB8NiUSP3NTVZDlREnbs2FM3G+lka1+EUevJLQ==
X-Received: by 2002:a17:906:1c51:: with SMTP id l17mr24023098ejg.202.1557784216849;
        Mon, 13 May 2019 14:50:16 -0700 (PDT)
Received: from localhost.localdomain ([92.117.184.230])
        by smtp.gmail.com with ESMTPSA id g11sm4040891eda.42.2019.05.13.14.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 14:50:16 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v3 4/4] ftrace: Add an option for tracing console latencies
Date:   Mon, 13 May 2019 23:50:08 +0200
Message-Id: <20190513215008.11256-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513215008.11256-1-viktor.rosendahl@gmail.com>
References: <20190513215008.11256-1-viktor.rosendahl@gmail.com>
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

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
---
 include/linux/irqflags.h        | 21 +++++++++++++++++++++
 kernel/printk/printk.c          |  6 ++++--
 kernel/trace/trace.h            |  1 +
 kernel/trace/trace_irqsoff.c    | 12 ++++++++++++
 tools/trace/latency-collector.c | 11 +++++------
 5 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..34b0424a32dc 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -68,9 +68,30 @@ do {						\
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
index 02ca827b8fac..3a18b7208399 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2348,6 +2348,7 @@ void console_unlock(void)
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
 	unsigned long flags;
+	bool cflag;
 	bool do_cond_resched, retry;
 
 	if (console_suspended) {
@@ -2448,9 +2449,10 @@ void console_unlock(void)
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
index 3456d6a47a47..ca10ad40f2f8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1250,6 +1250,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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
 
diff --git a/tools/trace/latency-collector.c b/tools/trace/latency-collector.c
index dfc364d7836a..8cf3c74d998f 100644
--- a/tools/trace/latency-collector.c
+++ b/tools/trace/latency-collector.c
@@ -953,10 +953,9 @@ static void show_usage(void)
 
 "The following options are supported:\n"
 "-c, --policy POL\tRun the program with scheduling policy POL. POL can be\n"
-"\t\t\tother, batch, idle, rr or fifo. The default is other.\n"
-"\t\t\tWhen using rr or fifo, be careful to not configure the\n"
-"\t\t\ttracer so that traces are acquired extremely frequently,\n"
-"\t\t\tor you may starve your system.\n\n"
+"\t\t\tother, batch, idle, rr or fifo. The default is rr. When\n"
+"\t\t\tusing rr or fifo, remember that these policies may cause\n"
+"\t\t\tother tasks to experience latencies.\n\n"
 
 "-p, --priority PRI\tRun the program with priority PRI. The acceptable range\n"
 "\t\t\tof PRI depends on the scheduling policy.\n\n"
@@ -1132,10 +1131,10 @@ static void scan_arguments(int argc, char *argv[])
 	}
 
 	if (!sched_policy_set) {
-		sched_policy = SCHED_OTHER;
+		sched_policy = SCHED_RR;
 		sched_policy_set = true;
 		if (!sched_pri_set) {
-			sched_pri = DEFAULT_PRI;
+			sched_pri = RT_DEFAULT_PRI;
 			sched_pri_set = true;
 		}
 	}
-- 
2.17.1

