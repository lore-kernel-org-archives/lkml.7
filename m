Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD2DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C75720651
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qZU7rubJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfHNR4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:56:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfHNR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:56:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHrsli098539;
        Wed, 14 Aug 2019 17:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=StjhRVJT5STPBomYiyWxppKH50oyW+XPLSWOY/dHgAU=;
 b=qZU7rubJNquYxFICZT7Dte85s1QWM2rXTiUNxVub/7BvS49t+FtiaPpCEJzV2P4Bauhn
 FJSAi7cfi2lS1gyDHYARDXh5zqtX5PUEdD5J73+IY3fezYStAla/KeFpNLq0KDKZV5ba
 +AsA0GVoAQOMDZybPI5LLK0MEdK8IzgWfHWEwDxgkVY0yQDcoO9y6YoOC2i2mbtrFC6h
 XlaL4QV4ZgpRI3DU/a1ysRcs4emV4UcusAYIrNm8y9r01tYE8yGCZ/wZ/ukM7SydCJPu
 Wg/X3cGpasJfFFCErgD8VMegQRqXEaq3Pjnv2ZpSc6CDIyfTkgf1tpNAGMWWD+h/3ky8 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjqp84r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHqwDn114053;
        Wed, 14 Aug 2019 17:55:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ucmwhprep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7EHthGj025390;
        Wed, 14 Aug 2019 17:55:43 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 10:55:42 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: [PATCH 5/5] tracing: New functions for kernel access to Ftrace instances
Date:   Wed, 14 Aug 2019 10:55:27 -0700
Message-Id: <1565805327-579-6-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140161
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

Also, use trace_array_set_clr_event to enable/disable events to a trace array.
So now we no longer need to have ftrace_set_clr_event as an exported
API.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 include/linux/trace.h        |  2 ++
 include/linux/trace_events.h |  3 ++-
 kernel/trace/trace.c         | 28 ++++++++++++++++++++++++++++
 kernel/trace/trace_events.c  | 23 ++++++++++++++++++++++-
 4 files changed, 54 insertions(+), 2 deletions(-)

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
index 8a62731..05a7514 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -540,7 +540,8 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
 #define is_signed_type(type)	(((type)(-1)) < (type)1)
 
 int trace_set_clr_event(const char *system, const char *event, int set);
-
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, int set);
 /*
  * The double __builtin_constant_p is because gcc will give us an error
  * if we try to allocate the static variable to fmt if it is not a
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7b6a37a..e394d55 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8514,6 +8514,34 @@ static int instance_rmdir(const char *name)
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
index 2621995..96dd997 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -834,7 +834,6 @@ static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
 
 /**
  * trace_set_clr_event - enable or disable an event
@@ -859,6 +858,28 @@ int trace_set_clr_event(const char *system, const char *event, int set)
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

