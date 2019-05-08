Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A50BC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C0020C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 01:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEHBv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 21:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfEHBvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 21:51:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B80E214AF;
        Wed,  8 May 2019 01:51:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOBkP-0005ld-NR; Tue, 07 May 2019 21:51:53 -0400
Message-Id: <20190508015153.611315926@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 07 May 2019 21:51:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [for-next][PATCH 2/3] tracing: Add trace_total_entries() / trace_total_entries_cpu()
References: <20190508015112.818966506@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

These two new exported functions will be used in a future patch by
kdb_ftdump() to quickly skip all but the last few trace entries.

Link: http://lkml.kernel.org/r/20190319171206.97107-2-dianders@chromium.org

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 65 ++++++++++++++++++++++++++++++++++----------
 kernel/trace/trace.h |  3 ++
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2bc18de7f0dc..dcb9adb44be9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3492,34 +3492,69 @@ static void s_stop(struct seq_file *m, void *p)
 	trace_event_read_unlock();
 }
 
+static void
+get_total_entries_cpu(struct trace_buffer *buf, unsigned long *total,
+		      unsigned long *entries, int cpu)
+{
+	unsigned long count;
+
+	count = ring_buffer_entries_cpu(buf->buffer, cpu);
+	/*
+	 * If this buffer has skipped entries, then we hold all
+	 * entries for the trace and we need to ignore the
+	 * ones before the time stamp.
+	 */
+	if (per_cpu_ptr(buf->data, cpu)->skipped_entries) {
+		count -= per_cpu_ptr(buf->data, cpu)->skipped_entries;
+		/* total is the same as the entries */
+		*total = count;
+	} else
+		*total = count +
+			ring_buffer_overrun_cpu(buf->buffer, cpu);
+	*entries = count;
+}
+
 static void
 get_total_entries(struct trace_buffer *buf,
 		  unsigned long *total, unsigned long *entries)
 {
-	unsigned long count;
+	unsigned long t, e;
 	int cpu;
 
 	*total = 0;
 	*entries = 0;
 
 	for_each_tracing_cpu(cpu) {
-		count = ring_buffer_entries_cpu(buf->buffer, cpu);
-		/*
-		 * If this buffer has skipped entries, then we hold all
-		 * entries for the trace and we need to ignore the
-		 * ones before the time stamp.
-		 */
-		if (per_cpu_ptr(buf->data, cpu)->skipped_entries) {
-			count -= per_cpu_ptr(buf->data, cpu)->skipped_entries;
-			/* total is the same as the entries */
-			*total += count;
-		} else
-			*total += count +
-				ring_buffer_overrun_cpu(buf->buffer, cpu);
-		*entries += count;
+		get_total_entries_cpu(buf, &t, &e, cpu);
+		*total += t;
+		*entries += e;
 	}
 }
 
+unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu)
+{
+	unsigned long total, entries;
+
+	if (!tr)
+		tr = &global_trace;
+
+	get_total_entries_cpu(&tr->trace_buffer, &total, &entries, cpu);
+
+	return entries;
+}
+
+unsigned long trace_total_entries(struct trace_array *tr)
+{
+	unsigned long total, entries;
+
+	if (!tr)
+		tr = &global_trace;
+
+	get_total_entries(&tr->trace_buffer, &total, &entries);
+
+	return entries;
+}
+
 static void print_lat_help_header(struct seq_file *m)
 {
 	seq_puts(m, "#                  _------=> CPU#            \n"
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index da00a3d508c1..33f14b9e78b7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -721,6 +721,9 @@ void trace_init_global_iter(struct trace_iterator *iter);
 
 void tracing_iter_reset(struct trace_iterator *iter, int cpu);
 
+unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu);
+unsigned long trace_total_entries(struct trace_array *tr);
+
 void trace_function(struct trace_array *tr,
 		    unsigned long ip,
 		    unsigned long parent_ip,
-- 
2.20.1


