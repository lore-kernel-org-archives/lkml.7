Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C9C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1717F2182B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbfGPTA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388480AbfGPTA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:00:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B32721841;
        Tue, 16 Jul 2019 19:00:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hnSh7-0006DP-3t; Tue, 16 Jul 2019 15:00:57 -0400
Message-Id: <20190716190057.005853795@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 16 Jul 2019 15:00:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [for-next][PATCH 3/5] tracing: Pass type into tracing_generic_entry_update()
References: <20190716190014.840939538@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

All callers of tracing_generic_entry_update() have to initialize
entry->type, so let's just simply move it inside.
Link: http://lkml.kernel.org/r/20190525165802.25944-2-xiyou.wangcong@gmail.com

Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h    | 1 +
 kernel/trace/trace.c            | 8 ++++----
 kernel/trace/trace_event_perf.c | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731673f7..5c6f2a6c8cd2 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -142,6 +142,7 @@ enum print_line_t {
 enum print_line_t trace_handle_return(struct trace_seq *s);
 
 void tracing_generic_entry_update(struct trace_entry *entry,
+				  unsigned short type,
 				  unsigned long flags,
 				  int pc);
 struct trace_event_file;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 77b9c4ca5faa..6b62e1718548 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -743,8 +743,7 @@ trace_event_setup(struct ring_buffer_event *event,
 {
 	struct trace_entry *ent = ring_buffer_event_data(event);
 
-	tracing_generic_entry_update(ent, flags, pc);
-	ent->type = type;
+	tracing_generic_entry_update(ent, type, flags, pc);
 }
 
 static __always_inline struct ring_buffer_event *
@@ -2312,13 +2311,14 @@ enum print_line_t trace_handle_return(struct trace_seq *s)
 EXPORT_SYMBOL_GPL(trace_handle_return);
 
 void
-tracing_generic_entry_update(struct trace_entry *entry, unsigned long flags,
-			     int pc)
+tracing_generic_entry_update(struct trace_entry *entry, unsigned short type,
+			     unsigned long flags, int pc)
 {
 	struct task_struct *tsk = current;
 
 	entry->preempt_count		= pc & 0xff;
 	entry->pid			= (tsk) ? tsk->pid : 0;
+	entry->type			= type;
 	entry->flags =
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
 		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_OFF : 0) |
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 4629a6104474..0892e38ed6fb 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -416,8 +416,7 @@ void perf_trace_buf_update(void *record, u16 type)
 	unsigned long flags;
 
 	local_save_flags(flags);
-	tracing_generic_entry_update(entry, flags, pc);
-	entry->type = type;
+	tracing_generic_entry_update(entry, type, flags, pc);
 }
 NOKPROBE_SYMBOL(perf_trace_buf_update);
 
-- 
2.20.1


