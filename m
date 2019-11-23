Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97186C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768B120720
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKWSNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfKWSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A271E2072E;
        Sat, 23 Nov 2019 18:12:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZth-000F0H-Pr; Sat, 23 Nov 2019 13:12:41 -0500
Message-Id: <20191123181241.684687713@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:12:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Divya Indi <divya.indi@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: [for-next][PATCH 07/10] tracing: Adding new functions for kernel access to Ftrace instances
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divya Indi <divya.indi@oracle.com>

Adding 2 new functions -
1) struct trace_array *trace_array_get_by_name(const char *name);

Return pointer to a trace array with given name. If it does not exist,
create and return pointer to the new trace array.

2) int trace_array_set_clr_event(struct trace_array *tr,
const char *system ,const char *event, bool enable);

Enable/Disable events to this trace array.

Additionally,
- To handle reference counters, export trace_array_put()
- Due to introduction of the above 2 new functions, we no longer need to
  export - ftrace_set_clr_event & trace_array_create APIs.

Link: http://lkml.kernel.org/r/1574276919-11119-2-git-send-email-divya.indi@oracle.com

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace.h        |  3 +-
 include/linux/trace_events.h |  3 +-
 kernel/trace/trace.c         | 96 ++++++++++++++++++++++++++++--------
 kernel/trace/trace.h         |  1 -
 kernel/trace/trace_events.c  | 27 +++++++++-
 5 files changed, 106 insertions(+), 24 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 24fcf07812ae..7fd86d3c691f 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -29,7 +29,8 @@ struct trace_array;
 void trace_printk_init_buffers(void);
 int trace_array_printk(struct trace_array *tr, unsigned long ip,
 		const char *fmt, ...);
-struct trace_array *trace_array_create(const char *name);
+void trace_array_put(struct trace_array *tr);
+struct trace_array *trace_array_get_by_name(const char *name);
 int trace_array_destroy(struct trace_array *tr);
 #endif	/* CONFIG_TRACING */
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 60a41b7069dd..4c6e15605766 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -555,7 +555,8 @@ extern int trace_event_get_offsets(struct trace_event_call *call);
 
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
-
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, bool enable);
 /*
  * The double __builtin_constant_p is because gcc will give us an error
  * if we try to allocate the static variable to fmt if it is not a
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 42659ce6ac0c..02a23a6e5e00 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -301,12 +301,24 @@ static void __trace_array_put(struct trace_array *this_tr)
 	this_tr->ref--;
 }
 
+/**
+ * trace_array_put - Decrement the reference counter for this trace array.
+ *
+ * NOTE: Use this when we no longer need the trace array returned by
+ * trace_array_get_by_name(). This ensures the trace array can be later
+ * destroyed.
+ *
+ */
 void trace_array_put(struct trace_array *this_tr)
 {
+	if (!this_tr)
+		return;
+
 	mutex_lock(&trace_types_lock);
 	__trace_array_put(this_tr);
 	mutex_unlock(&trace_types_lock);
 }
+EXPORT_SYMBOL_GPL(trace_array_put);
 
 int tracing_check_open_get_tr(struct trace_array *tr)
 {
@@ -8437,24 +8449,15 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
-struct trace_array *trace_array_create(const char *name)
+static struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
 	int ret;
 
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
-
-	ret = -EEXIST;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0)
-			goto out_unlock;
-	}
-
 	ret = -ENOMEM;
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
-		goto out_unlock;
+		return ERR_PTR(ret);
 
 	tr->name = kstrdup(name, GFP_KERNEL);
 	if (!tr->name)
@@ -8499,8 +8502,8 @@ struct trace_array *trace_array_create(const char *name)
 
 	list_add(&tr->list, &ftrace_trace_arrays);
 
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
+	tr->ref++;
+
 
 	return tr;
 
@@ -8510,24 +8513,77 @@ struct trace_array *trace_array_create(const char *name)
 	kfree(tr->name);
 	kfree(tr);
 
- out_unlock:
-	mutex_unlock(&trace_types_lock);
-	mutex_unlock(&event_mutex);
-
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(trace_array_create);
 
 static int instance_mkdir(const char *name)
 {
-	return PTR_ERR_OR_ZERO(trace_array_create(name));
+	struct trace_array *tr;
+	int ret;
+
+	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
+
+	ret = -EEXIST;
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, name) == 0)
+			goto out_unlock;
+	}
+
+	tr = trace_array_create(name);
+
+	ret = PTR_ERR_OR_ZERO(tr);
+
+out_unlock:
+	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
+	return ret;
+}
+
+/**
+ * trace_array_get_by_name - Create/Lookup a trace array, given its name.
+ * @name: The name of the trace array to be looked up/created.
+ *
+ * Returns pointer to trace array with given name.
+ * NULL, if it cannot be created.
+ *
+ * NOTE: This function increments the reference counter associated with the
+ * trace array returned. This makes sure it cannot be freed while in use.
+ * Use trace_array_put() once the trace array is no longer needed.
+ *
+ */
+struct trace_array *trace_array_get_by_name(const char *name)
+{
+	struct trace_array *tr;
+
+	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, name) == 0)
+			goto out_unlock;
+	}
+
+	tr = trace_array_create(name);
+
+	if (IS_ERR(tr))
+		tr = NULL;
+out_unlock:
+	if (tr)
+		tr->ref++;
+
+	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
+	return tr;
 }
+EXPORT_SYMBOL_GPL(trace_array_get_by_name);
 
 static int __remove_instance(struct trace_array *tr)
 {
 	int i;
 
-	if (tr->ref || (tr->current_trace && tr->current_trace->ref))
+	/* Reference counter for a newly created trace array = 1. */
+	if (tr->ref > 1 || (tr->current_trace && tr->current_trace->ref))
 		return -EBUSY;
 
 	list_del(&tr->list);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2df8aed6a8f0..ca7fccafbcbb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -345,7 +345,6 @@ extern struct list_head ftrace_trace_arrays;
 extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
-extern void trace_array_put(struct trace_array *tr);
 extern int tracing_check_open_get_tr(struct trace_array *tr);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2a3ac2365445..6b3a69e9aa6a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -827,7 +827,6 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
 
 /**
  * trace_set_clr_event - enable or disable an event
@@ -852,6 +851,32 @@ int trace_set_clr_event(const char *system, const char *event, int set)
 }
 EXPORT_SYMBOL_GPL(trace_set_clr_event);
 
+/**
+ * trace_array_set_clr_event - enable or disable an event for a trace array.
+ * @tr: concerned trace array.
+ * @system: system name to match (NULL for any system)
+ * @event: event name to match (NULL for all events, within system)
+ * @enable: true to enable, false to disable
+ *
+ * This is a way for other parts of the kernel to enable or disable
+ * event recording.
+ *
+ * Returns 0 on success, -EINVAL if the parameters do not match any
+ * registered events.
+ */
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, bool enable)
+{
+	int set;
+
+	if (!tr)
+		return -ENOENT;
+
+	set = (enable == true) ? 1 : 0;
+	return __ftrace_set_clr_event(tr, NULL, system, event, set);
+}
+EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
+
 /* 128 should be much more than enough */
 #define EVENT_BUF_SIZE		127
 
-- 
2.24.0


