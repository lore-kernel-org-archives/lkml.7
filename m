Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB5C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A73205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfDDBjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfDDBhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:37:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6189E2171F;
        Thu,  4 Apr 2019 01:37:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBrK4-00050H-D6; Wed, 03 Apr 2019 21:37:44 -0400
Message-Id: <20190404013744.301395680@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Apr 2019 21:37:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 08/19] tracing: Add trace_array parameter to create_event_filter()
References: <20190404013721.023858792@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Pass in the trace_array that represents the instance the filter being
changed is in to create_event_filter(). This will allow for error messages
that happen when writing to the filter can be displayed in the proper
instance "error_log" file.

Note, for calls to create_filter() (that was also modified to support
create_event_filter()), that changes filters that do not exist in a instance
(for perf for example), NULL may be passed in, which means that there will
not be any message to log for that filter.

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                |  3 ++-
 kernel/trace/trace_events_filter.c  | 25 ++++++++++++++-----------
 kernel/trace/trace_events_trigger.c |  3 ++-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b711edbef7e7..809c5d7f0064 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1553,7 +1553,8 @@ extern int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 extern void print_subsystem_event_filter(struct event_subsystem *system,
 					 struct trace_seq *s);
 extern int filter_assign_type(const char *type);
-extern int create_event_filter(struct trace_event_call *call,
+extern int create_event_filter(struct trace_array *tr,
+			       struct trace_event_call *call,
 			       char *filter_str, bool set_str,
 			       struct event_filter **filterp);
 extern void free_event_filter(struct event_filter *filter);
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 290d42c59101..2b63930cd3e6 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -920,7 +920,8 @@ static void remove_filter_string(struct event_filter *filter)
 	filter->filter_string = NULL;
 }
 
-static void append_filter_err(struct filter_parse_error *pe,
+static void append_filter_err(struct trace_array *tr,
+			      struct filter_parse_error *pe,
 			      struct event_filter *filter)
 {
 	struct trace_seq *s;
@@ -1607,7 +1608,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		if (err) {
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
-			append_filter_err(pe, filter);
+			append_filter_err(tr, pe, filter);
 		} else
 			event_set_filtered_flag(file);
 
@@ -1719,7 +1720,8 @@ static void create_filter_finish(struct filter_parse_error *pe)
  * information if @set_str is %true and the caller is responsible for
  * freeing it.
  */
-static int create_filter(struct trace_event_call *call,
+static int create_filter(struct trace_array *tr,
+			 struct trace_event_call *call,
 			 char *filter_string, bool set_str,
 			 struct event_filter **filterp)
 {
@@ -1736,17 +1738,18 @@ static int create_filter(struct trace_event_call *call,
 
 	err = process_preds(call, filter_string, *filterp, pe);
 	if (err && set_str)
-		append_filter_err(pe, *filterp);
+		append_filter_err(tr, pe, *filterp);
 	create_filter_finish(pe);
 
 	return err;
 }
 
-int create_event_filter(struct trace_event_call *call,
+int create_event_filter(struct trace_array *tr,
+			struct trace_event_call *call,
 			char *filter_str, bool set_str,
 			struct event_filter **filterp)
 {
-	return create_filter(call, filter_str, set_str, filterp);
+	return create_filter(tr, call, filter_str, set_str, filterp);
 }
 
 /**
@@ -1773,7 +1776,7 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 			kfree((*filterp)->filter_string);
 			(*filterp)->filter_string = NULL;
 		} else {
-			append_filter_err(pe, *filterp);
+			append_filter_err(tr, pe, *filterp);
 		}
 	}
 	create_filter_finish(pe);
@@ -1804,7 +1807,7 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
 		return 0;
 	}
 
-	err = create_filter(call, filter_string, true, &filter);
+	err = create_filter(file->tr, call, filter_string, true, &filter);
 
 	/*
 	 * Always swap the call filter with the new filter
@@ -2060,7 +2063,7 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 	if (event->filter)
 		goto out_unlock;
 
-	err = create_filter(call, filter_str, false, &filter);
+	err = create_filter(NULL, call, filter_str, false, &filter);
 	if (err)
 		goto free_filter;
 
@@ -2209,8 +2212,8 @@ static __init int ftrace_test_event_filter(void)
 		struct test_filter_data_t *d = &test_filter_data[i];
 		int err;
 
-		err = create_filter(&event_ftrace_test_filter, d->filter,
-				    false, &filter);
+		err = create_filter(NULL, &event_ftrace_test_filter,
+				    d->filter, false, &filter);
 		if (err) {
 			printk(KERN_INFO
 			       "Failed to get filter for '%s', err %d\n",
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index cd12ecb66eb9..2a2912cb4533 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -731,7 +731,8 @@ int set_trigger_filter(char *filter_str,
 		goto out;
 
 	/* The filter is for the 'trigger' event, not the triggered event */
-	ret = create_event_filter(file->event_call, filter_str, false, &filter);
+	ret = create_event_filter(file->tr, file->event_call,
+				  filter_str, false, &filter);
 	/*
 	 * If create_event_filter() fails, filter still needs to be freed.
 	 * Which the calling code will do with data->filter.
-- 
2.20.1


