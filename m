Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D3FC3A5AA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98AD206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGfPFeph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfIEN0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:26:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34648 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388932AbfIENZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:25:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so2803552wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2yVL8mBemo05QH7CxyB4zOelueafnjrSiUZKuU/Pdo=;
        b=bGfPFephOlzSbyBzIS7ORhaStZVvZV9K+s+w/NnW2+OfIs67r41RWpxkM0dsZ48zNx
         L1IOM7djbgJW9I1Bpi2CV6JZhickV1n/T7jxInZv4sZwbGCYe7RcFC6Y2Ny+/+BlNpAa
         vMU9oNFj7PxA9Sj61iJbQHiiA1tu6L16KJqjYSqGsp3HloEmvczbTmELNcs3jncN+WRL
         ixizMTImxwuwnRskkDC3G6IgMsywVG3UVbZw4KJ64emdqClmfCGRYGv0Q7ldwOkbsggJ
         r2k4fkJ22X0lTdYzSRr5jCuMM4LRfzFjmddEksx8oy/Db1rEUs6u/gHkQ9DiBiKMk291
         lDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j2yVL8mBemo05QH7CxyB4zOelueafnjrSiUZKuU/Pdo=;
        b=c7r0+tTZtlPbVezBAePrLTNezztftm3N6gEwVf1OsBtepkNOJUtljmi6RqnvdXCg5E
         6Qq57OBgib08pKmApYXQAzCWaofXRk/j7qkwshkdEWt8wsGJYhJC3HHd7Z5SdEhj6pYp
         Zr1Z3YJBzVpg2sDjl60w+FgMpbg0kHhc1exfGwb1oRpGlNoutiOv2rwdU8sF3tE7y3XR
         XYJtD//EpLzBdnCPTGGpufD0qlmWf6eBKHW3mIAMLSPs8C7I/oVmE7KEHHh8Ri9wC+OC
         1zhnxWC4s7Kyn4VTxeJByRjWJYPmWjw01HBVlE3uH+84KtKHVtm/HRJ2j9ROAIdSH2Kx
         igLQ==
X-Gm-Message-State: APjAAAX1boN67ZkhnSnMC+muMwaHBzHyxRFxRzWdItAL/zIjuhGjgmRd
        0M9YFvP3jvUxmKGvfpDscA==
X-Google-Smtp-Source: APXvYqzn7fCgGpjKOsRvGBrsEPk4l3oS+9h4BB7hG4NEEiSun19NqhaLsUgLjDMYFvfI5BbVpHiQug==
X-Received: by 2002:a5d:5389:: with SMTP id d9mr2771606wrv.119.1567689956109;
        Thu, 05 Sep 2019 06:25:56 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([212.118.206.70])
        by smtp.gmail.com with ESMTPSA id y3sm8652635wmg.2.2019.09.05.06.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:25:55 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v6 4/4] ftrace: Add an option for tracing console latencies
Date:   Thu,  5 Sep 2019 15:25:48 +0200
Message-Id: <20190905132548.5116-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
References: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
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

