Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E092DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C586520727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfKNSTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbfKNSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F37D20740;
        Thu, 14 Nov 2019 18:18:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhJ-00015D-MH; Thu, 14 Nov 2019 13:18:25 -0500
Message-Id: <20191114181825.571439393@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 15/33] ftrace: Add information on number of page groups allocated
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Looking for ways to shrink the size of the dyn_ftrace structure, knowing the
information about how many pages and the number of groups of those pages, is
useful in working out the best ways to save on memory.

This adds one info print on how many groups of pages were used to allocate
the ftrace dyn_ftrace structures, and also shows the number of pages and
groups in the dyn_ftrace_total_info (which is used for debugging).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 14 ++++++++++++++
 kernel/trace/trace.c  | 21 +++++++++++++++------
 kernel/trace/trace.h  |  2 ++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9456346ec66..d2d488c43a6a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2991,6 +2991,8 @@ static void ftrace_shutdown_sysctl(void)
 
 static u64		ftrace_update_time;
 unsigned long		ftrace_update_tot_cnt;
+unsigned long		ftrace_number_of_pages;
+unsigned long		ftrace_number_of_groups;
 
 static inline int ops_traces_mod(struct ftrace_ops *ops)
 {
@@ -3115,6 +3117,9 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 		goto again;
 	}
 
+	ftrace_number_of_pages += 1 << order;
+	ftrace_number_of_groups++;
+
 	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
 	pg->size = cnt;
 
@@ -3170,6 +3175,8 @@ ftrace_allocate_pages(unsigned long num_to_init)
 		start_pg = pg->next;
 		kfree(pg);
 		pg = start_pg;
+		ftrace_number_of_pages -= 1 << order;
+		ftrace_number_of_groups--;
 	}
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
 	return NULL;
@@ -6173,6 +6180,8 @@ void ftrace_release_mod(struct module *mod)
 		free_pages((unsigned long)pg->records, order);
 		tmp_page = pg->next;
 		kfree(pg);
+		ftrace_number_of_pages -= 1 << order;
+		ftrace_number_of_groups--;
 	}
 }
 
@@ -6514,6 +6523,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 			*last_pg = pg->next;
 			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
 			free_pages((unsigned long)pg->records, order);
+			ftrace_number_of_pages -= 1 << order;
+			ftrace_number_of_groups--;
 			kfree(pg);
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
@@ -6569,6 +6580,9 @@ void __init ftrace_init(void)
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
 
+	pr_info("ftrace: allocated %ld pages with %ld groups\n",
+		ftrace_number_of_pages, ftrace_number_of_groups);
+
 	set_ftrace_early_filters();
 
 	return;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a0ee9178365..5ea8c7c0f2d7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7583,14 +7583,23 @@ static ssize_t
 tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 		  size_t cnt, loff_t *ppos)
 {
-	unsigned long *p = filp->private_data;
-	char buf[64]; /* Not too big for a shallow stack */
+	ssize_t ret;
+	char *buf;
 	int r;
 
-	r = scnprintf(buf, 63, "%ld", *p);
-	buf[r++] = '\n';
+	/* 256 should be plenty to hold the amount needed */
+	buf = kmalloc(256, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	r = scnprintf(buf, 256, "%ld pages:%ld groups: %ld\n",
+		      ftrace_update_tot_cnt,
+		      ftrace_number_of_pages,
+		      ftrace_number_of_groups);
+
+	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	kfree(buf);
+	return ret;
 }
 
 static const struct file_operations tracing_dyn_info_fops = {
@@ -8782,7 +8791,7 @@ static __init int tracer_init_tracefs(void)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	trace_create_file("dyn_ftrace_total_info", 0444, d_tracer,
-			&ftrace_update_tot_cnt, &tracing_dyn_info_fops);
+			NULL, &tracing_dyn_info_fops);
 #endif
 
 	create_trace_instances(d_tracer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d685c61085c0..8b590f10bc72 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -804,6 +804,8 @@ extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern unsigned long ftrace_update_tot_cnt;
+extern unsigned long ftrace_number_of_pages;
+extern unsigned long ftrace_number_of_groups;
 void ftrace_init_trace_array(struct trace_array *tr);
 #else
 static inline void ftrace_init_trace_array(struct trace_array *tr) { }
-- 
2.23.0


