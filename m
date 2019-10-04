Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40618C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18008207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbfJDPNV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389086AbfJDPNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:13:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95BCB21D81;
        Fri,  4 Oct 2019 15:13:19 +0000 (UTC)
Date:   Fri, 4 Oct 2019 11:13:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191004111318.1083d205@gandalf.local.home>
In-Reply-To: <761c5baf-598d-c2da-bd3e-2a669bf16b50@redhat.com>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.166658077@infradead.org>
        <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
        <20191002182106.GC4643@worktop.programming.kicks-ass.net>
        <20191003181045.7fb1a5b3@gandalf.local.home>
        <7b4196a4-b6e1-7e55-c3e1-a02d97c262c7@redhat.com>
        <20191004094014.72a990ee@gandalf.local.home>
        <761c5baf-598d-c2da-bd3e-2a669bf16b50@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019 16:44:35 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 04/10/2019 15:40, Steven Rostedt wrote:
> > On Fri, 4 Oct 2019 10:10:47 +0200
> > Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> >   
> >> [ In addition ]
> >>
> >> Currently, ftrace_rec entries are ordered inside the group of functions, but
> >> "groups of function" are not ordered. So, the current int3 handler does a (*):
> >>
> >> for_each_group_of_functions:
> >> 	check if the ip is in the range    ----> n by the number of groups.
> >> 		do a bsearch.		   ----> log(n) by the numbers of entry
> >> 					         in the group.
> >>
> >> If, instead, it uses an ordered vector, the complexity would be log(n) by the
> >> total number of entries, which is better. So, how bad is the idea of:  
> > BTW, I'm currently rewriting the grouping of the vectors, in order to
> > shrink the size of each dyn_ftrace_rec (as we discussed at Kernel
> > Recipes). I can make the groups all sorted in doing so, thus we can
> > load the sorted if that's needed, without doing anything special.
> >   
> 
> Good! if you do they sorted and store the amount of entries in a variable, we
> can have things done for a future "optimized" version.
> 

You mean something like this?

-- Steve


From 9b85c08d796dc953cf9b9331d1aed4c3052b09b9 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Tue, 1 Oct 2019 14:38:07 -0400
Subject: [PATCH] ftrace: Add information on number of page groups allocated

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
index c4cc048eb594..244e2d9083a6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2860,6 +2860,8 @@ static void ftrace_shutdown_sysctl(void)
 
 static u64		ftrace_update_time;
 unsigned long		ftrace_update_tot_cnt;
+unsigned long		ftrace_number_of_pages;
+unsigned long		ftrace_number_of_groups;
 
 static inline int ops_traces_mod(struct ftrace_ops *ops)
 {
@@ -2984,6 +2986,9 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 		goto again;
 	}
 
+	ftrace_number_of_pages += 1 << order;
+	ftrace_number_of_groups++;
+
 	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
 	pg->size = cnt;
 
@@ -3039,6 +3044,8 @@ ftrace_allocate_pages(unsigned long num_to_init)
 		start_pg = pg->next;
 		kfree(pg);
 		pg = start_pg;
+		ftrace_number_of_pages -= 1 << order;
+		ftrace_number_of_groups--;
 	}
 	pr_info("ftrace: FAILED to allocate memory for functions\n");
 	return NULL;
@@ -5788,6 +5795,8 @@ void ftrace_release_mod(struct module *mod)
 		free_pages((unsigned long)pg->records, order);
 		tmp_page = pg->next;
 		kfree(pg);
+		ftrace_number_of_pages -= 1 << order;
+		ftrace_number_of_groups--;
 	}
 }
 
@@ -6129,6 +6138,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 			*last_pg = pg->next;
 			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
 			free_pages((unsigned long)pg->records, order);
+			ftrace_number_of_pages -= 1 << order;
+			ftrace_number_of_groups--;
 			kfree(pg);
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
@@ -6184,6 +6195,9 @@ void __init ftrace_init(void)
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
 
+	pr_info("ftrace: allocated %ld pages with %ld groups\n",
+		ftrace_number_of_pages, ftrace_number_of_groups);
+
 	set_ftrace_early_filters();
 
 	return;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e917aa783675..bb41a70c5189 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7548,14 +7548,23 @@ static ssize_t
 tracing_read_dyn_info(struct file *filp, char __user *ubuf,
 		  size_t cnt, loff_t *ppos)
 {
-	unsigned long *p = filp->private_data;
-	char buf[64]; /* Not too big for a shallow stack */
+	unsigned long *p = ftrace_update_tot_cnt;
+	ssize_t ret;
+	char *buf;
 	int r;
 
-	r = scnprintf(buf, 63, "%ld", *p);
-	buf[r++] = '\n';
+	r = snprintf(NULL, 0, "%ld pages:%d groups: %d\n");
+	r++;
+	buf = kmalloc(r, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	r = scnprintf(buf, r, "%ld pages:%d groups: %d\n",
+		ftrace_update_tot_cnt,
+		ftrace_number_of_pages,
+		ftrace_number_of_groups);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
 static const struct file_operations tracing_dyn_info_fops = {
@@ -8747,7 +8756,7 @@ static __init int tracer_init_tracefs(void)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	trace_create_file("dyn_ftrace_total_info", 0444, d_tracer,
-			&ftrace_update_tot_cnt, &tracing_dyn_info_fops);
+			NULL, &tracing_dyn_info_fops);
 #endif
 
 	create_trace_instances(d_tracer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f801d154ff6a..f6f92a6c5cec 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -802,6 +802,8 @@ extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern unsigned long ftrace_update_tot_cnt;
+extern unsigned long ftrace_number_of_pages;
+extern unsigned long ftrace_number_of_groups;
 void ftrace_init_trace_array(struct trace_array *tr);
 #else
 static inline void ftrace_init_trace_array(struct trace_array *tr) { }
-- 
2.20.1

