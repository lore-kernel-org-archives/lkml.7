Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35007C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC712087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN9NKXZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfEQUeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:34:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36007 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfEQUep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:34:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id a17so9583389qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFkvuyFrcUdBjjQHIvZv0C+4O3W71e9w9WG3W0dWYQg=;
        b=MN9NKXZao61ZPdjhZRG8ha0B3DiiyHeObMgEIC7lAobieDNOmDDz06lyFWthi7y/aO
         srpyOqmCGpSULFtz0bxcHA6tprnrxMOPpeLhCsoxnItJbyQyNE6NmqAB5b/iVkSBkdH/
         ykU+bOAh4ewou9dACDPARAnc4SoQwyUI7ljH8ZeVdOi/azAcL95MqGrN67RbqMeaZxrf
         BRmaMaI3UX5XnEMtVVAunbF7n2G+nBypcS6yYOO90f6hTQ51k6iS5NO3rA3leEb6v9Ek
         E96RH3uIBjxgdW/P0GkPr741+WF97O3TeKBZe0zqzdTci8up0hXelcY4GNVyxlILq69A
         y4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFkvuyFrcUdBjjQHIvZv0C+4O3W71e9w9WG3W0dWYQg=;
        b=Fv/0/JQm2plVD9knhrSNwT7JFM0rSJfmhUA1Up1x/6cUyuGfNkVK5bx7dzMKIbZEPk
         3GK8gBh6pnXZDbydpfLF2JAITFBsLmMfC6U5v4r/soYwrDmGL+LVCWeujKFY8W2XisTh
         qE+V7tmmo5HQRAFVOenkeRJBbgHCQFljm3d/G22W8ibFpIxsgjqHudRKAN/Nv/RPIobA
         XrD33bxf2WizO9VOk0z3VRoddKCB7TVPPeFXOdF72ofu57wqQV1jaiK/ArU+/t5R+rG0
         R28By7LGw6OF9D7ALVSgwBLPORoNsIQE7R/UiBDZolDkWj1iwPuImWrcUsGFgRz/bXg/
         ohEw==
X-Gm-Message-State: APjAAAWN5t2bmdDyw28K+qYmXzzmC9xBl7RQjchRQ8jaVQwPlcTqAO5R
        LtAAXpU4RK/931wz0A8lMA==
X-Google-Smtp-Source: APXvYqzkxN0wpz14fsuABSBHT0uIc/Ls6uE9Ftr4lrjpK3wOB1K6Q8OxNgIZNT+xvCtpFUo0gBA6fA==
X-Received: by 2002:ac8:3973:: with SMTP id t48mr50292919qtb.121.1558125284375;
        Fri, 17 May 2019 13:34:44 -0700 (PDT)
Received: from localhost.localdomain ([92.117.189.151])
        by smtp.gmail.com with ESMTPSA id u5sm5499145qtj.95.2019.05.17.13.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 13:34:43 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v4 4/4] ftrace: Add an option for tracing console latencies
Date:   Fri, 17 May 2019 22:34:30 +0200
Message-Id: <20190517203430.6729-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517203430.6729-1-viktor.rosendahl@gmail.com>
References: <20190517203430.6729-1-viktor.rosendahl@gmail.com>
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
 include/linux/irqflags.h     | 21 +++++++++++++++++++++
 kernel/printk/printk.c       |  6 ++++--
 kernel/trace/trace.h         |  1 +
 kernel/trace/trace_irqsoff.c | 12 ++++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)

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
index 17102fd4c136..46ebba6e5fb9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2358,6 +2358,7 @@ void console_unlock(void)
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
 	unsigned long flags;
+	bool cflag;
 	bool do_cond_resched, retry;
 
 	if (console_suspended) {
@@ -2458,9 +2459,10 @@ void console_unlock(void)
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
index f95027813296..31cdc2e4c382 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1257,6 +1257,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
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

