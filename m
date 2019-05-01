Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB00FC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5ECF20651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8FDvEIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEAUhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:37:09 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54968 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfEAUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:37:07 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so617043ite.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJmQqngy1kQ8htwLJJdrVCRzBO7USlbxqkr4yKsGTHE=;
        b=c8FDvEIlshjmRi2UFmd+Txl5np8+zlT32h28+ynagC44DbXiW8Op7/h1cMDTjVdg0X
         X74uIhFCv6P4rNkU7r6YD0HvnyoHFUiZtHtstq7MCWkHX9St+hw6PTyJAE8FSTHdoR5H
         XbvyR92o+d5q5FqFOcUdW/wE5YD0GjBqOYeZxdfZzceWfpqwgAn4lUJxGN3KByUg61Yd
         Blp/sGxM9JYTlhO4+HOo9ljrf+6D5+JZ3QE4FH1XigQDKstc/zTri7qtCzAHtc+KPKB7
         jlmBLKtHB3c4KA+QWIbPDOu0gxXKNSxaO7TDf4L4EBVfE9oC/mKK9TgAIhzXjF7sMfxk
         88dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJmQqngy1kQ8htwLJJdrVCRzBO7USlbxqkr4yKsGTHE=;
        b=lIXcvAfkaycRkyXvzj24MtHujSbRaKoNwKFtzKesyoIobUmZU3uZ+tmYWvpRzjXv4K
         TKbUHUl2w5sOSeCxnPVnsjAbRpytYLZQ6BD7sO5kp661rhkInP1P+p81K7Fz9epmU5t6
         4D4LedhWYZrrOLMF/EZ2PzfV0bgeYAj3a+xB6vVo0Io6DgYzR+/Ex1x4yKVfWUKUP9K8
         f4DznVlFTAMJRvQIEEwr49nCn8VVU329LSLqZVTpd4yhl23NhghNTm3U+sUWLj+OjnMh
         jAvOJ10Du0qTnvUwbnoAwvqaiq3qs8LBkRSeOSf1zsvoU079EkgpWDTSVG+1tDsEY7VB
         bXBQ==
X-Gm-Message-State: APjAAAWejdkkf1nQNOBNoIHyRenYa49CbZFmC2KguE+A0UsgMt3vRS8t
        NVGPzX0F6veb8ZmwB/5s/A==
X-Google-Smtp-Source: APXvYqwMmPH97bUefsZYgVAo0DPX/XXTTCECXXP5cWPRS/+7jq8MavOYLQOWT3lG8cou/5SRLXoKeg==
X-Received: by 2002:a24:3613:: with SMTP id l19mr9515881itl.75.1556743026431;
        Wed, 01 May 2019 13:37:06 -0700 (PDT)
Received: from localhost.localdomain ([92.117.183.162])
        by smtp.gmail.com with ESMTPSA id u16sm9323998iol.66.2019.05.01.13.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 13:37:05 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v2 4/4] ftrace: Add an option for tracing console latencies
Date:   Wed,  1 May 2019 22:36:50 +0200
Message-Id: <20190501203650.29548-5-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501203650.29548-1-viktor.rosendahl@gmail.com>
References: <20190501203650.29548-1-viktor.rosendahl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new option CONFIG_TRACE_CONSOLE_LATENCY will enable the latency
tracers to trace the console latencies. Previously this has always been
implicitely disabled. I guess this is because they are considered
to be well known and unavoidable.

However, for some organizations it may nevertheless be desirable to
trace them. Basically, we want to be able to tell that there are
latencies in the system under test because someone has incorrectly
enabled the serial console.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
---
 include/linux/irqflags.h | 13 +++++++++++++
 kernel/printk/printk.c   |  5 +++--
 kernel/trace/Kconfig     | 11 +++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 21619c92c377..791bee718448 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -73,6 +73,19 @@ do {						\
 # define start_critical_timings() do { } while (0)
 #endif
 
+#ifdef CONFIG_TRACE_CONSOLE_LATENCY
+
+#define console_stop_critical_timings()  do {} while (0)
+#define console_start_critical_timings() do {} while (0)
+
+#else /* !CONFIG_TRACE_CONSOLE_LATENCY */
+
+/* don't trace print latency */
+#define console_stop_critical_timings()  stop_critical_timings()
+#define console_start_critical_timings() start_critical_timings()
+
+#endif /* !CONFIG_TRACE_CONSOLE_LATENCY */
+
 /*
  * Wrap the arch provided IRQ routines to provide appropriate checks.
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827b8fac..710e87f61158 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2448,9 +2448,10 @@ void console_unlock(void)
 		 */
 		console_lock_spinning_enable();
 
-		stop_critical_timings();	/* don't trace print latency */
+		/* don't trace print latency if it's disabled */
+		console_stop_critical_timings();
 		call_console_drivers(ext_text, ext_len, text, len);
-		start_critical_timings();
+		console_start_critical_timings();
 
 		if (console_lock_spinning_disable_and_check()) {
 			printk_safe_exit_irqrestore(flags);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e5e8f2a0199e..f168d100d4fb 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -244,6 +244,17 @@ config PREEMPT_TRACER
 	  modification of /sys/kernel/debug/tracing/trace through the inotify
 	  interface.
 
+	config TRACE_CONSOLE_LATENCY
+	bool "Do not turn off latency tracing for the console"
+	default n
+	depends on IRQSOFF_TRACER || PREEMPT_TRACER
+	help
+	  Some of the console drivers will cause long unavoidable
+	  latencies because they are slow and need to print immediately
+	  in a serialized manner. Because of this their latencies are not
+	  traced by default. This option will change behavior so that
+	  they are traced.
+
 config SCHED_TRACER
 	bool "Scheduling Latency Tracer"
 	select GENERIC_TRACER
-- 
2.17.1

