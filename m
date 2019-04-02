Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F7C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11E9206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDBUEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDBUES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:04:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3B9030842AC;
        Tue,  2 Apr 2019 20:04:17 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 964335C7B2;
        Tue,  2 Apr 2019 20:04:14 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [RFC PATCH 2/7] trace: Move the trace recursion context enum to trace.h and reuse it
Date:   Tue,  2 Apr 2019 22:03:54 +0200
Message-Id: <831c998455e001f2c5cd45806958f3ba899fd097.1554234787.git.bristot@redhat.com>
In-Reply-To: <cover.1554234787.git.bristot@redhat.com>
References: <cover.1554234787.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 02 Apr 2019 20:04:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both trace and ring buffer code needs to identify in which
context the current code is running to control recursion.

Move the enum in the trace.h, and unify its usage.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Cc: Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 kernel/trace/ring_buffer.c | 25 +++++--------------------
 kernel/trace/trace.h       | 25 +++++++++++++++++++++----
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 41b6f96e5366..fa8cbad2ca88 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -27,6 +27,8 @@
 
 #include <asm/local.h>
 
+#include "trace.h"
+
 static void update_pages_handler(struct work_struct *work);
 
 /*
@@ -428,23 +430,6 @@ struct rb_event_info {
 	int			add_timestamp;
 };
 
-/*
- * Used for which event context the event is in.
- *  NMI     = 0
- *  IRQ     = 1
- *  SOFTIRQ = 2
- *  NORMAL  = 3
- *
- * See trace_recursive_lock() comment below for more details.
- */
-enum {
-	RB_CTX_NMI,
-	RB_CTX_IRQ,
-	RB_CTX_SOFTIRQ,
-	RB_CTX_NORMAL,
-	RB_CTX_MAX
-};
-
 /*
  * head_page == tail_page && head == tail then buffer is empty.
  */
@@ -2704,10 +2689,10 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 	int bit;
 
 	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
-		bit = RB_CTX_NORMAL;
+		bit = TRACE_CTX_NORMAL;
 	else
-		bit = pc & NMI_MASK ? RB_CTX_NMI :
-			pc & HARDIRQ_MASK ? RB_CTX_IRQ : RB_CTX_SOFTIRQ;
+		bit = pc & NMI_MASK ? TRACE_CTX_NMI :
+			pc & HARDIRQ_MASK ? TRACE_CTX_IRQ : TRACE_CTX_SOFTIRQ;
 
 	if (unlikely(val & (1 << (bit + cpu_buffer->nest))))
 		return 1;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d80cee49e0eb..dad2f0cd7208 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -616,20 +616,37 @@ enum {
 
 #define TRACE_CONTEXT_MASK	TRACE_LIST_MAX
 
+/*
+ * Used for which event context the event is in.
+ *  NMI     = 0
+ *  IRQ     = 1
+ *  SOFTIRQ = 2
+ *  NORMAL  = 3
+ *
+ * See trace_recursive_lock() comment for more details.
+ */
+enum {
+	TRACE_CTX_NMI,
+	TRACE_CTX_IRQ,
+	TRACE_CTX_SOFTIRQ,
+	TRACE_CTX_NORMAL,
+	TRACE_CTX_MAX
+};
+
 static __always_inline int trace_get_context_bit(void)
 {
 	int bit;
 
 	if (in_interrupt()) {
 		if (in_nmi())
-			bit = 0;
+			bit = TRACE_CTX_NMI;
 
 		else if (in_irq())
-			bit = 1;
+			bit = TRACE_CTX_IRQ;
 		else
-			bit = 2;
+			bit = TRACE_CTX_SOFTIRQ;
 	} else
-		bit = 3;
+		bit = TRACE_CTX_NORMAL;
 
 	return bit;
 }
-- 
2.20.1

