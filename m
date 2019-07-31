Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD68C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6A206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbfGaPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:05:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbfGaPFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:05:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 567CF206B8;
        Wed, 31 Jul 2019 15:05:19 +0000 (UTC)
Date:   Wed, 31 Jul 2019 11:05:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: [GIT PULL] tracing: Minor fixes for v5.3-rc2
Message-ID: <20190731110517.4e065b29@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Two minor fixes:

 - Fix trace event header include guards, as several did not match
   the #define to the #ifdef

 - Remove a redundant test to ftrace_graph_notrace_addr() that
   was accidentally added.


Please pull the latest trace-v5.3-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.3-rc2

Tag SHA1: 720001864d680862b4e2b218a1f6e61e5a1f0d38
Head SHA1: 6c77221df96177da0520847ce91e33f539fb8b2d


Changbin Du (1):
      fgraph: Remove redundant ftrace_graph_notrace_addr() test

Masahiro Yamada (1):
      tracing: Fix header include guards in trace event headers

----
 include/trace/events/dma_fence.h     |  2 +-
 include/trace/events/napi.h          |  4 ++--
 include/trace/events/qdisc.h         |  4 ++--
 include/trace/events/tegra_apb_dma.h |  4 ++--
 kernel/trace/trace_functions_graph.c | 17 +++++++----------
 5 files changed, 14 insertions(+), 17 deletions(-)
---------------------------
diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
index 2212adda8f77..64e92d56c6a8 100644
--- a/include/trace/events/dma_fence.h
+++ b/include/trace/events/dma_fence.h
@@ -2,7 +2,7 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM dma_fence
 
-#if !defined(_TRACE_FENCE_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_TRACE_DMA_FENCE_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_DMA_FENCE_H
 
 #include <linux/tracepoint.h>
diff --git a/include/trace/events/napi.h b/include/trace/events/napi.h
index f3a12566bed0..6678cf8b235b 100644
--- a/include/trace/events/napi.h
+++ b/include/trace/events/napi.h
@@ -3,7 +3,7 @@
 #define TRACE_SYSTEM napi
 
 #if !defined(_TRACE_NAPI_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_NAPI_H_
+#define _TRACE_NAPI_H
 
 #include <linux/netdevice.h>
 #include <linux/tracepoint.h>
@@ -38,7 +38,7 @@ TRACE_EVENT(napi_poll,
 
 #undef NO_DEV
 
-#endif /* _TRACE_NAPI_H_ */
+#endif /* _TRACE_NAPI_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index 60d0d8bd336d..0d1a9ebf55ba 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -2,7 +2,7 @@
 #define TRACE_SYSTEM qdisc
 
 #if !defined(_TRACE_QDISC_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_QDISC_H_
+#define _TRACE_QDISC_H
 
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
@@ -44,7 +44,7 @@ TRACE_EVENT(qdisc_dequeue,
 		  __entry->txq_state, __entry->packets, __entry->skbaddr )
 );
 
-#endif /* _TRACE_QDISC_H_ */
+#endif /* _TRACE_QDISC_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/include/trace/events/tegra_apb_dma.h b/include/trace/events/tegra_apb_dma.h
index 0818f6286110..971cd02d2daf 100644
--- a/include/trace/events/tegra_apb_dma.h
+++ b/include/trace/events/tegra_apb_dma.h
@@ -1,5 +1,5 @@
 #if !defined(_TRACE_TEGRA_APB_DMA_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_TEGRA_APM_DMA_H
+#define _TRACE_TEGRA_APB_DMA_H
 
 #include <linux/tracepoint.h>
 #include <linux/dmaengine.h>
@@ -55,7 +55,7 @@ TRACE_EVENT(tegra_dma_isr,
 	TP_printk("%s: irq %d\n",  __get_str(chan), __entry->irq)
 );
 
-#endif /*  _TRACE_TEGRADMA_H */
+#endif /* _TRACE_TEGRA_APB_DMA_H */
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 69ebf3c2f1b5..78af97163147 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -137,6 +137,13 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT))
 		return 0;
 
+	/*
+	 * Do not trace a function if it's filtered by set_graph_notrace.
+	 * Make the index of ret stack negative to indicate that it should
+	 * ignore further functions.  But it needs its own ret stack entry
+	 * to recover the original index in order to continue tracing after
+	 * returning from the function.
+	 */
 	if (ftrace_graph_notrace_addr(trace->func)) {
 		trace_recursion_set(TRACE_GRAPH_NOTRACE_BIT);
 		/*
@@ -155,16 +162,6 @@ int trace_graph_entry(struct ftrace_graph_ent *trace)
 	if (ftrace_graph_ignore_irqs())
 		return 0;
 
-	/*
-	 * Do not trace a function if it's filtered by set_graph_notrace.
-	 * Make the index of ret stack negative to indicate that it should
-	 * ignore further functions.  But it needs its own ret stack entry
-	 * to recover the original index in order to continue tracing after
-	 * returning from the function.
-	 */
-	if (ftrace_graph_notrace_addr(trace->func))
-		return 1;
-
 	/*
 	 * Stop here if tracing_threshold is set. We only write function return
 	 * events to the ring buffer.
