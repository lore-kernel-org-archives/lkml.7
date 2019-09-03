Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAC6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069BC23402
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq86JrfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfICN0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:26:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36639 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbfICN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:26:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id p13so18303964wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uQfXXPmaySsKcKFMsH7JK/GSTBUYGHwwGurARhdivYI=;
        b=dq86JrfG2/2vkHKyLGKlIsAPXPljZ5m+dD01MCtnRm44FY875/a+15jynX+AJWnmW1
         V0o36XI/AlJe/g360sc/FhR/qVgpgWYbGUTYvAsI0aYE7LKNPAIKtI81cvvYbDHrYA9G
         jRlXnyjOyq/2iX/tD60KNn/Wt3Wb8LL1iPDgMvVpKp1tF98ThAinWyHJbj4q3HVJbyVP
         Kbh0M9oPFvclguvKVKdJ+sxVqrDTWjOlenVSKtEjqhQawvJbitSjn1n07zpOUsUp5Nad
         E+xqCSfXrtpvO/uqyW2sPhkCzZyNmF40S9biOLEMLmMF8z7PSK3pRn87lOKWarRuV48O
         vs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uQfXXPmaySsKcKFMsH7JK/GSTBUYGHwwGurARhdivYI=;
        b=NIfBAWk1/s0JIUdKzKXMaDJUVAXcw4PRtJ+TIBgKa5vqFVmp4G3bObsR7cksKSTfu3
         JQxVseMRN3AgVSezo3BremIFWqsHT/i1LQsvHC824QhTcU+WY2MDY7RbNQJpS10sKp5D
         XI+ZCAS070KBKNh/ELzr82N8LsUuChoGE47pW44nA6JJWXKfgr1LA6cFMs2MrJB425RP
         eC9/hEXxtGw5NJAOS1EhLY8Plp//fSyQpPSH+DT89lfMkVOcj5bDs7PpwXycudlX2t9p
         vKq/XqLzByu795ORfMBkR5Zm0Q0uVw5i31c5JpJCuDULmF4ce0kZP49BLkqOA+rv27Um
         mgAQ==
X-Gm-Message-State: APjAAAUj8VFhKFFD2AbSUByZNnDNXNM1Vmuz+JUxfO1rhW8+XZ80WqaM
        VQna1rtXsmiYaTRUORC4Wg==
X-Google-Smtp-Source: APXvYqxtpthYsuSWk5zTznNIC/Y4+rH2Obl9pYQRmQ9zCQzg7lpwkw6xnCFKwmrHPjubaST8YAUTMw==
X-Received: by 2002:a7b:cd17:: with SMTP id f23mr43865964wmj.177.1567517188512;
        Tue, 03 Sep 2019 06:26:28 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id w9sm3906668wra.15.2019.09.03.06.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 06:26:28 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v5 4/4] ftrace: Add an option for tracing console latencies
Date:   Tue,  3 Sep 2019 15:26:02 +0200
Message-Id: <20190903132602.3440-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
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
index d9f83b2aaa71..8e4c9736a801 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1266,6 +1266,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
 		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
 		C(LATENCY_FMT,		"latency-format"),	\
+		C(CONSOLE_LATENCY,	"console-latency"),	\
 		C(RECORD_CMD,		"record-cmd"),		\
 		C(RECORD_TGID,		"record-tgid"),		\
 		C(OVERWRITE,		"overwrite"),		\
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 29403a83a5f0..c8d17c4c1c91 100644
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

