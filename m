Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B10C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F53204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqZvTaSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfEBShk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:37:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39620 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEBShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:37:40 -0400
Received: by mail-it1-f193.google.com with SMTP id t200so5158303itf.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3bTGTbTE8gGlzRl/POqzvQikyqE1rXFDWwJSoA19kt4=;
        b=NqZvTaSOo7uS4QqtoXCyXNDR4MTzOFCymDIYrBV/xH3OHScHgrHDqiUHPGj/nSPzFd
         K4GHaokfN+BPVUf6IYjKFwjoEPbEyrWttzYY1ZvjO/kzzZDRCyUuDmzE0n4HgIvBWSv7
         GoFdgyAfNXliayepT0vgzm0HOpo9mTF87vHTZjfwe7LGne07W+kOrWJ9XnuLTO2fOEdb
         pNEpBljheyiqrUPD8qVWDu4WgXDL/2GhJm3/ZZA8JmiS8L1zHsggNGt6S8HgP2y03KA3
         /mNcgAyQgwjtPf/tPRRcbV3RTztVYzExIX9xPZVn77ds5goQt+FUq6azcpDZYNOk2vKg
         ycvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3bTGTbTE8gGlzRl/POqzvQikyqE1rXFDWwJSoA19kt4=;
        b=WR+vEDgoCdCkotHVxtNw/sSmSYqIxA+AIEyqi9MjwcVirHkmIYXB8D4qBlrEoQo6Oq
         vD/NFRey8CEEA3QAPErqwE3nxbCLDuJgylBv8KVp9p+I7DvVaeCkLM2edK/rejO/Xsv+
         5dpBurR47l84zFoHTYVLAreKuZp5VprATAGAewEuV5+S+P6rpwMeYZL14eN1AEcRhlaT
         Em8sNUKPXtMB1uuYVTXYa91uiykCVKRMxIJCuB9Ozg67Y+nrycm+tlA5wF1MUoxB9DvJ
         sSFz6cfVZ6rA/ROOxcFgaeDDgUKAFjdbum/zd2/jdJZr/3FHSAvNoiKH9Dq5D542tiQi
         UFKA==
X-Gm-Message-State: APjAAAXpUncf8qsvFUooA+HAmj6WcizrdLTQfhWNch3XYT033qwjGQXv
        pta5YSzod3GSHFUe20Kit+a/t59WEQ==
X-Google-Smtp-Source: APXvYqwXZ9iW3ueXbFsrht124bBnKI982DqtgkNeLPEMOcNcbdz9Iaqu3cxF0+jajH0mXndUhFO+uw==
X-Received: by 2002:a24:4614:: with SMTP id j20mr3344210itb.72.1556822259065;
        Thu, 02 May 2019 11:37:39 -0700 (PDT)
Received: from localhost.localdomain ([92.117.168.44])
        by smtp.gmail.com with ESMTPSA id y62sm4213ita.15.2019.05.02.11.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:37:38 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: Re: [PATCH v2 4/4] ftrace: Add an option for tracing console latencies
Date:   Thu,  2 May 2019 20:37:31 +0200
Message-Id: <20190502183731.9571-1-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501213857.157e3741@oasis.local.home>
References: <20190501213857.157e3741@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of this being turned into a nop, don't have a kconfig option
> but instead have this call into the trace_irqsoff.c code, and depending
> on what the options are, it should stop it. Of course, this would need
> to be smart enough to pair it. Perhaps return the result of
> console_stop_critical_timings() and have that passed to
> console_start_critical_timings(), and only have start do something if
> stop did something. This way the option only needs to disable the stop
> part.

Something like this?

I have only compile tested it so far.

best regards,

Viktor
---
 include/linux/irqflags.h     | 17 +++++++++++++++++
 kernel/printk/printk.c       |  6 ++++--
 kernel/trace/trace.h         |  1 +
 kernel/trace/trace_irqsoff.c | 13 +++++++++++++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..e4f7ebc67a53 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -68,9 +68,26 @@ do {						\
 	defined(CONFIG_PREEMPT_TRACER)
  extern void stop_critical_timings(void);
  extern void start_critical_timings(void);
+ extern bool console_tracing_disabled(void);
+
+#define console_stop_critical_timings(FLAG)		\
+	do {						\
+		FLAG = console_tracing_disabled();	\
+		if (FLAG)				\
+			stop_critical_timings();	\
+	} while(0)
+
+#define console_start_critical_timings(FLAG)		 \
+	do {						 \
+		if (FLAG)				 \
+			start_critical_timings();	 \
+	} while(0)
+
 #else
 # define stop_critical_timings() do { } while (0)
 # define start_critical_timings() do { } while (0)
+# define console_stop_critical_timings(FLAG) do { } while (0)
+# define console_start_critical_timings(FLAG) do { } while (0)
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
index 59dc01ac52fd..3eed4756dba3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1253,6 +1253,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(PRINTK_MSGONLY,	"printk-msg-only"),	\
 		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
 		C(LATENCY_FMT,		"latency-format"),	\
+		C(CONSOLE_LATENCY,	"console-latency"),	\
 		C(RECORD_CMD,		"record-cmd"),		\
 		C(RECORD_TGID,		"record-tgid"),		\
 		C(OVERWRITE,		"overwrite"),		\
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 07a391e845de..659a82209c1e 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -490,6 +490,19 @@ void stop_critical_timings(void)
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
+	return !(tr->trace_flags & CONSOLE_LATENCY);
+}
+
+EXPORT_SYMBOL_GPL(console_tracing_disabled);
+
 #ifdef CONFIG_FUNCTION_TRACER
 static bool function_enabled;
 
-- 
2.17.1

