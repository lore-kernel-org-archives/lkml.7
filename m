Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F815C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F29206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rw3D+SzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfG3AD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:03:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbfG3ADV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:03:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNxKAh046010;
        Tue, 30 Jul 2019 00:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Kn8U6rIU5msAsOTmODkxifyAYd/RbQuaiP5BL0MbKLw=;
 b=rw3D+SzUyjG2YJppShG2lJx5VB768B/eyqnwwTkzl2i6XvB0DDew/8CDCRKUHpbiEsqn
 exDmwu6pT5tlApdnTeHcYd6xPd6yyhWuLAlBQ6iX3LopHbXpDLxGJP0TRz7RIXbTg8CP
 ULe7vXFOyjdvog0cayiFd/VyCggBNsh3ocKGfTOfkj+WacZZAUAoETxLzIfrDzf0ryb/
 z6JeICGX0pmTZnbvL1MUdlFoxtt+4Y+Ii89AUCEzu0HcYFHIZaSabIGGb3Zl1zpn2/aF
 STRSBNnuUm4vsl2+9YXlg4U2plzMjKTOn0bAJxEBS2s4v7c5pbCq0ZjZ0L5KXFPQEi58 Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u0ejparbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNvh85019805;
        Tue, 30 Jul 2019 00:02:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u0ee4kv4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:52 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U02pS5012435;
        Tue, 30 Jul 2019 00:02:51 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 17:02:50 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH 6/7] tracing: New functions for kernel access to Ftrace instances
Date:   Mon, 29 Jul 2019 17:02:33 -0700
Message-Id: <1564444954-28685-7-git-send-email-divya.indi@oracle.com>
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

Adding 2 new functions -
1) trace_array_lookup : Look up and return a trace array, given its
name.
2) trace_array_set_clr_event : Enable/disable event recording to the
given trace array.

NOTE: trace_array_lookup returns a trace array and also increments the
reference counter associated with the returned trace array. Make sure to
call trace_array_put() once the use is done so that the instance can be
removed at a later time.

Example use:

tr = trace_array_lookup("foo-bar");
if (!tr)
	tr = trace_array_create("foo-bar");
// Log to tr
// Enable/disable events to tr
trace_array_set_clr_event(tr, _THIS_IP,"system","event",1);

// Done using tr
trace_array_put(tr);
..

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-By: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 include/linux/trace.h        |  2 ++
 include/linux/trace_events.h |  2 ++
 kernel/trace/trace.c         | 28 ++++++++++++++++++++++++++++
 kernel/trace/trace_events.c  | 22 ++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 2c782d5..05164bb 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -32,6 +32,8 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
 struct trace_array *trace_array_create(const char *name);
 int trace_array_destroy(struct trace_array *tr);
 void trace_array_put(struct trace_array *tr);
+struct trace_array *trace_array_lookup(const char *name);
+
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0f874fb..6da3600 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -540,6 +540,8 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
 
 int trace_set_clr_event(const char *system, const char *event, int set);
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, int set);
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 
 /*
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 130579b..fcf42bb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8516,6 +8516,34 @@ static int instance_rmdir(const char *name)
 	return ret;
 }
 
+/**
+ * trace_array_lookup - Lookup the trace array, given its name.
+ * @name: The name of the trace array to be looked up.
+ *
+ * Lookup and return the trace array associated with @name.
+ *
+ * NOTE: The reference counter associated with the returned trace array is
+ * incremented to ensure it is not freed when in use. Make sure to call
+ * "trace_array_put" for this trace array when its use is done.
+ */
+struct trace_array *trace_array_lookup(const char *name)
+{
+	struct trace_array *tr;
+
+	mutex_lock(&trace_types_lock);
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, name) == 0) {
+			tr->ref++;
+			mutex_unlock(&trace_types_lock);
+			return tr;
+		}
+	}
+	mutex_unlock(&trace_types_lock);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(trace_array_lookup);
+
 static __init void create_trace_instances(struct dentry *d_tracer)
 {
 	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 99eb5f8..9ee6b52 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -859,6 +859,28 @@ int trace_set_clr_event(const char *system, const char *event, int set)
 }
 EXPORT_SYMBOL_GPL(trace_set_clr_event);
 
+/**
+ * trace_array_set_clr_event - enable or disable an event for a trace array
+ * @system: system name to match (NULL for any system)
+ * @event: event name to match (NULL for all events, within system)
+ * @set: 1 to enable, 0 to disable
+ *
+ * This is a way for other parts of the kernel to enable or disable
+ * event recording to instances.
+ *
+ * Returns 0 on success, -EINVAL if the parameters do not match any
+ * registered events.
+ */
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, int set)
+{
+	if (!tr)
+		return -ENOENT;
+
+	return __ftrace_set_clr_event(tr, NULL, system, event, set);
+}
+EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
+
 /* 128 should be much more than enough */
 #define EVENT_BUF_SIZE		127
 
-- 
1.8.3.1

