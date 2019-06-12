Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153C6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BE8215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3i9BlIkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438224AbfFLQfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:35:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38890 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438250AbfFLQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:35:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CGXeL1180963;
        Wed, 12 Jun 2019 16:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=OZ07ptOy2B80GlbT6lz5k/wWg5JkWZcAoOSiGptgXoI=;
 b=3i9BlIkAgbpRW4KMrJFF9FVpB9aV6hrBUlUPolA2nBEAg5/HXhH0kpu9dzfwmo6/P9FQ
 uagMawXS8M+FkxYw/3Gfjg53hn3zq83vDGnx1EykNKBX5I4Z1QOwTa4r2z4BVOKKKbYT
 aar1NwqtxnMXMGVNJdgwBwTo+OU0YdwqcCS1ZNzkxrIRjVIUx88X1iUvxnCTb8d3edMK
 e3m7snvEwDXYyi5GjtFw05DWVUzpIXv0wj7hTBxaFKcK2PgSiduLNOZeAh5MfXL5L7s8
 yee+jPe7u5snkCX1+uya0zCp6gdh60fc3Mf/aQOtmh98x3c1lvoya2Ht7yWa+WTUbzrn cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t05nqvn9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 16:34:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CGXJ5H113164;
        Wed, 12 Jun 2019 16:34:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t024v2urq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 16:34:57 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5CGYukW025982;
        Wed, 12 Jun 2019 16:34:56 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 09:34:56 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Divya Indi <divya.indi@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: [PATCH 3/3] tracing: Add 2 new funcs. for kernel access to Ftrace instances.
Date:   Wed, 12 Jun 2019 09:34:19 -0700
Message-Id: <1560357259-3497-4-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560357259-3497-3-git-send-email-divya.indi@oracle.com>
References: <1560357259-3497-1-git-send-email-divya.indi@oracle.com>
 <1560357259-3497-2-git-send-email-divya.indi@oracle.com>
 <1560357259-3497-3-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding 2 new functions -
1) trace_array_lookup : Look up and return a trace array, given its
name.
2) trace_array_set_clr_event : Enable/disable event recording to the
given trace array.

Newly added functions trace_array_lookup and trace_array_create also
need to increment the reference counter associated with the trace array
they return. This is to ensure the trace array does not get freed
while in use by the newly introduced APIs.
The reference ctr is decremented in the trace_array_destroy.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
---
 include/linux/trace_events.h |  3 +++
 kernel/trace/trace.c         | 30 +++++++++++++++++++++++++++++-
 kernel/trace/trace_events.c  | 22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d7b7d85..0cc99a8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -545,7 +545,10 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
 struct trace_array *trace_array_create(const char *name);
 int trace_array_destroy(struct trace_array *tr);
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+struct trace_array *trace_array_lookup(const char *name);
 int trace_set_clr_event(const char *system, const char *event, int set);
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, int set);
 
 /*
  * The double __builtin_constant_p is because gcc will give us an error
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a60dc13..fb70ccc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8364,6 +8364,8 @@ struct trace_array *trace_array_create(const char *name)
 
 	list_add(&tr->list, &ftrace_trace_arrays);
 
+	tr->ref++;
+
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
@@ -8385,7 +8387,14 @@ struct trace_array *trace_array_create(const char *name)
 
 static int instance_mkdir(const char *name)
 {
-	return PTR_ERR_OR_ZERO(trace_array_create(name));
+	struct trace_array *tr;
+
+	tr = trace_array_create(name);
+	if (IS_ERR(tr))
+		return PTR_ERR(tr);
+	trace_array_put(tr);
+
+	return 0;
 }
 
 static int __remove_instance(struct trace_array *tr)
@@ -8434,6 +8443,7 @@ int trace_array_destroy(struct trace_array *tr)
 	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 
+	tr->ref--;
 	ret = __remove_instance(tr);
 
 	mutex_unlock(&trace_types_lock);
@@ -8465,6 +8475,24 @@ static int instance_rmdir(const char *name)
 	return ret;
 }
 
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
index 445b059..c126d2c 100644
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
+		return -ENODEV;
+
+	return __ftrace_set_clr_event(tr, NULL, system, event, set);
+}
+EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
+
 /* 128 should be much more than enough */
 #define EVENT_BUF_SIZE		127
 
-- 
1.8.3.1

