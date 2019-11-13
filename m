Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA3C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ADB206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j3IQ9uqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKMVTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:19:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40048 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfKMVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:19:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADLHBEN045975;
        Wed, 13 Nov 2019 21:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=H0pVYbXTAw9BYHRTxhW7qBbCP46RKSzyzCEm9+IirCk=;
 b=j3IQ9uqqJ9oaqsSVqWXD+KxeiDrtEAthq4jpNRARIj5tJeNJ8h2NwsmKrd5C40HVFuCW
 dYfa8ZdaTTCEKBzXVd5sQ70bCUU/nQ5dQTbQPjIdpCsc0fDc05EKtr5felJ7leTic+yv
 j/ZOXy1N7RZFOnRPxIREddMFeQYIJn5+VOih4WSreHnMxJwpEzGv1S8hdS9aYdq+TDwd
 mc2ugE2eTEiZg31HI3bte3rhpYS1j/n+JG0IMIlaIG3ryQByduMJbD+LPtOJ9rxwVV1R
 IDrVNZeWDyXYIMUyzsGvXoGFeJppBeq88s1rw9C48tFJdIC9Lfvg1U22TZ6JP8TpIt7K Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w5p3qy6q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:19:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADL3wDq170466;
        Wed, 13 Nov 2019 21:17:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w8g1876bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:17:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADLH0wq015477;
        Wed, 13 Nov 2019 21:17:01 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 13:17:00 -0800
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Joe Jin <joe.jin@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: [PATCH 4/5] tracing: Adding new functions for kernel access to Ftrace instances
Date:   Wed, 13 Nov 2019 13:16:01 -0800
Message-Id: <1573679762-7774-5-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573679762-7774-4-git-send-email-divya.indi@oracle.com>
References: <1573679762-7774-1-git-send-email-divya.indi@oracle.com>
 <1573679762-7774-2-git-send-email-divya.indi@oracle.com>
 <1573679762-7774-3-git-send-email-divya.indi@oracle.com>
 <1573679762-7774-4-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Reviewed-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
 include/linux/trace.h        |  3 +-
 include/linux/trace_events.h |  3 +-
 kernel/trace/trace.c         | 90 +++++++++++++++++++++++++++++++++++---------
 kernel/trace/trace.h         |  1 -
 kernel/trace/trace_events.c  | 27 ++++++++++++-
 5 files changed, 103 insertions(+), 21 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 24fcf07..7fd86d3 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -29,7 +29,8 @@ struct trace_export {
 void trace_printk_init_buffers(void);
 int trace_array_printk(struct trace_array *tr, unsigned long ip,
 		const char *fmt, ...);
-struct trace_array *trace_array_create(const char *name);
+void trace_array_put(struct trace_array *tr);
+struct trace_array *trace_array_get_by_name(const char *name);
 int trace_array_destroy(struct trace_array *tr);
 #endif	/* CONFIG_TRACING */
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 8a62731..3898299 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -540,7 +540,8 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
 
 int trace_set_clr_event(const char *system, const char *event, int set);
-
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, bool enable);
 /*
  * The double __builtin_constant_p is because gcc will give us an error
  * if we try to allocate the static variable to fmt if it is not a
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e0faf81..58be07b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -297,12 +297,24 @@ static void __trace_array_put(struct trace_array *this_tr)
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
 
 int call_filter_check_discard(struct trace_event_call *call, void *rec,
 			      struct ring_buffer *buffer,
@@ -8302,24 +8314,17 @@ static void update_tracer_options(struct trace_array *tr)
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
+
+	mutex_lock(&event_mutex);
 
 	tr->name = kstrdup(name, GFP_KERNEL);
 	if (!tr->name)
@@ -8364,7 +8369,8 @@ struct trace_array *trace_array_create(const char *name)
 
 	list_add(&tr->list, &ftrace_trace_arrays);
 
-	mutex_unlock(&trace_types_lock);
+	tr->ref++;
+
 	mutex_unlock(&event_mutex);
 
 	return tr;
@@ -8375,24 +8381,74 @@ struct trace_array *trace_array_create(const char *name)
 	kfree(tr->name);
 	kfree(tr);
 
- out_unlock:
-	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(trace_array_create);
 
 static int instance_mkdir(const char *name)
 {
-	return PTR_ERR_OR_ZERO(trace_array_create(name));
+	struct trace_array *tr;
+	int ret;
+
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
+	mutex_unlock(&trace_types_lock);
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
index 66ff63e..643faaa 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -338,7 +338,6 @@ enum {
 extern struct mutex trace_types_lock;
 
 extern int trace_array_get(struct trace_array *tr);
-extern void trace_array_put(struct trace_array *tr);
 
 extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
 extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2621995..c58ef22 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -834,7 +834,6 @@ static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
 
 /**
  * trace_set_clr_event - enable or disable an event
@@ -859,6 +858,32 @@ int trace_set_clr_event(const char *system, const char *event, int set)
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
1.8.3.1

