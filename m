Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D42BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE234216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="geA0DLFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfG3ADf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:03:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54362 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfG3ADV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:03:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNwxWk045861;
        Tue, 30 Jul 2019 00:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=5wXrcq64w7z3OFR+yEPqcH6m5GQOHnUyVqb2GMzYyrU=;
 b=geA0DLFURTnEdvhuFBVOqqqPhsTSXXtAKUKn/eRNo8Eccx0HZ2EHNpqQwTjqz89DOgvu
 grgm8UmfMq/YOuF7Vp8g/N0o9RCnViekurtVTSqXMNjnjlCV6p7B2Jd+lBlUJZKGr1Ta
 3zVr6BRTormbuYNrdkVvDkj6c5uVuqIdkZc6beGdzO+dRGvvSKE9zNmwnecCuVO3CHAa
 n0LNW3OrEHDCrwdECjv7TBzpt/4427SFLX/j4LpxcNuR2aDrXKdn9qg6mlJk2Vo8Tnmj
 k7GWQ+vWFooUqQCZ6bf4/lF/vVFleNwDIeB64fjWrRYjvhR6ET90B8eL6TXzZcJ2TPn8 EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u0ejparbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNvbF3116016;
        Tue, 30 Jul 2019 00:02:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u0bqts9bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:50 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6U02njk028675;
        Tue, 30 Jul 2019 00:02:49 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 17:02:49 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH 5/7] tracing: Handle the trace array ref counter in new functions
Date:   Mon, 29 Jul 2019 17:02:32 -0700
Message-Id: <1564444954-28685-6-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
References: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907290261
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907290261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For functions returning a trace array Eg: trace_array_create(), we need to
increment the reference counter associated with the trace array to ensure it
does not get freed when in use.

Once we are done using the trace array, we need to call
trace_array_put() to make sure we are not holding a reference to it
anymore and the instance/trace array can be removed when required.

Hence, additionally exporting trace_array_put().

Example use:

tr = trace_array_create("foo-bar");
// Use this trace array
// Log to this trace array or enable/disable events to this trace array.
....
....
// tr no longer required
trace_array_put();

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-By: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 include/linux/trace.h |  1 +
 kernel/trace/trace.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 24fcf07..2c782d5 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -31,6 +31,7 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
 		const char *fmt, ...);
 struct trace_array *trace_array_create(const char *name);
 int trace_array_destroy(struct trace_array *tr);
+void trace_array_put(struct trace_array *tr);
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 22bf166..130579b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -297,12 +297,22 @@ static void __trace_array_put(struct trace_array *this_tr)
 	this_tr->ref--;
 }
 
+/**
+ * trace_array_put - Decrement reference counter for the given trace array.
+ * @tr: Trace array for which reference counter needs to decrement.
+ *
+ * NOTE: Functions like trace_array_create increment the reference counter for
+ * the trace array to ensure they do not get freed while in use. Make sure to
+ * call trace_array_put() when the use is done. This will ensure that the
+ * instance can be later removed.
+ */
 void trace_array_put(struct trace_array *this_tr)
 {
 	mutex_lock(&trace_types_lock);
 	__trace_array_put(this_tr);
 	mutex_unlock(&trace_types_lock);
 }
+EXPORT_SYMBOL_GPL(trace_array_put);
 
 int call_filter_check_discard(struct trace_event_call *call, void *rec,
 			      struct ring_buffer *buffer,
@@ -8302,6 +8312,16 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
+/**
+ * trace_array_create - Create a new trace array with the given name.
+ * @name: The name of the trace array to be created.
+ *
+ * Create and return a trace array with given name if it does not exist.
+ *
+ * NOTE: The reference counter associated with the returned trace array is
+ * incremented to ensure it is not freed when in use. Make sure to call
+ * "trace_array_put" for this trace array when its use is done.
+ */
 struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
@@ -8364,6 +8384,8 @@ struct trace_array *trace_array_create(const char *name)
 
 	list_add(&tr->list, &ftrace_trace_arrays);
 
+	tr->ref++;
+
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
@@ -8385,7 +8407,21 @@ struct trace_array *trace_array_create(const char *name)
 
 static int instance_mkdir(const char *name)
 {
-	return PTR_ERR_OR_ZERO(trace_array_create(name));
+	struct trace_array *tr;
+
+	tr = trace_array_create(name);
+	if (IS_ERR(tr))
+		return PTR_ERR(tr);
+
+	/*
+	 * This function does not return a reference to the created trace array,
+	 * so the reference counter is to be 0 when it returns.
+	 * trace_array_create increments the ref counter, decrement it here
+	 * by calling trace_array_put()
+	 */
+	trace_array_put(tr);
+
+	return 0;
 }
 
 static int __remove_instance(struct trace_array *tr)
@@ -8424,6 +8460,11 @@ static int __remove_instance(struct trace_array *tr)
 	return 0;
 }
 
+/*
+ * NOTE: An instance cannot be removed if there is still a reference to it.
+ * Make sure to call "trace_array_put" for a trace array returned by functions
+ * like trace_array_create(), otherwise trace_array_destroy will not succeed.
+ */
 int trace_array_destroy(struct trace_array *this_tr)
 {
 	struct trace_array *tr;
-- 
1.8.3.1

