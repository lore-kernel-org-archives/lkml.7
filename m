Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C7BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3984C2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSMBdlNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfCTS3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:29:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57556 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfCTS3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:29:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2KISt9H066770;
        Wed, 20 Mar 2019 18:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=g6nD34vORtFsHjVBwdxnIzkj7qt9fHFCxPXO7AKSTb8=;
 b=JSMBdlNtGgDEi5Xh2oE4xIo1VqLF/40rr+axDozr+kCNvOJrzAO4+qkzP5xUnFI0kz+O
 zzxgQV+ec69vNTKB+M2p2HwzVjutQdoWj3CfAkx2Wi7+qiAlYlseNPNQo7rlYz9TGUHJ
 /CnNwbUnQWpTt5TVFNYRFvVHomI4WNBuC8EKApRe6k5vWioVj8ywoesydwO7DafBVc6J
 b0sqdk26o8tXMbgjJmFFarBb7zy2l/YPfsQy8IS13bPP3yWWHh5Dr4bkevjkkRRZlXcZ
 pcAqABNp+DuBgxLviL62cqlzPhAy8PickUJeMD1kGUMleeiDW0m6mnAchIaIwF/+xz0f og== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r8ssrmdsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 18:29:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2KIT6lX007094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 18:29:07 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2KIT6QP030433;
        Wed, 20 Mar 2019 18:29:06 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 11:29:06 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Joe Jin <joe.jin@oracle.com>, Divya Indi <divya.indi@oracle.com>
Subject: [PATCH] tracing: Kernel access to Ftrace instances
Date:   Wed, 20 Mar 2019 11:28:51 -0700
Message-Id: <1553106531-3281-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553106531-3281-1-git-send-email-divya.indi@oracle.com>
References: <1553106531-3281-1-git-send-email-divya.indi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace provides the feature “instances” that provides the capability to
create multiple Ftrace ring buffers. However, currently these buffers
are created/accessed via userspace only. The kernel APIs providing these
features are not exported, hence cannot be used by other kernel
components.

This patch aims to extend this infrastructure to provide the
flexibility to create/log/remove/ enable-disable existing trace events
to these buffers from within the kernel.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-by: Joe Jin <joe.jin@oracle.com>
---
 kernel/trace/trace.c        | 74 ++++++++++++++++++++++++++++++---------------
 kernel/trace/trace_events.c |  1 +
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c4238b4..eaf163a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2878,6 +2878,7 @@ void trace_printk_init_buffers(void)
 	if (global_trace.trace_buffer.buffer)
 		tracing_start_cmdline_record();
 }
+EXPORT_SYMBOL_GPL(trace_printk_init_buffers);
 
 void trace_printk_start_comm(void)
 {
@@ -3038,6 +3039,7 @@ int trace_array_printk(struct trace_array *tr,
 	va_end(ap);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(trace_array_printk);
 
 __printf(3, 4)
 int trace_array_printk_buf(struct ring_buffer *buffer,
@@ -7832,7 +7834,7 @@ static void update_tracer_options(struct trace_array *tr)
 	mutex_unlock(&trace_types_lock);
 }
 
-static int instance_mkdir(const char *name)
+struct trace_array *trace_array_create(const char *name)
 {
 	struct trace_array *tr;
 	int ret;
@@ -7896,7 +7898,7 @@ static int instance_mkdir(const char *name)
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
-	return 0;
+	return tr;
 
  out_free_tr:
 	free_trace_buffers(tr);
@@ -7908,33 +7910,21 @@ static int instance_mkdir(const char *name)
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
-	return ret;
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(trace_array_create);
 
+static int instance_mkdir(const char *name)
+{
+	return PTR_ERR_OR_ZERO(trace_array_create(name));
 }
 
-static int instance_rmdir(const char *name)
+static int __remove_instance(struct trace_array *tr)
 {
-	struct trace_array *tr;
-	int found = 0;
-	int ret;
 	int i;
 
-	mutex_lock(&event_mutex);
-	mutex_lock(&trace_types_lock);
-
-	ret = -ENODEV;
-	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr->name && strcmp(tr->name, name) == 0) {
-			found = 1;
-			break;
-		}
-	}
-	if (!found)
-		goto out_unlock;
-
-	ret = -EBUSY;
 	if (tr->ref || (tr->current_trace && tr->current_trace->ref))
-		goto out_unlock;
+		return -EBUSY;
 
 	list_del(&tr->list);
 
@@ -7960,10 +7950,46 @@ static int instance_rmdir(const char *name)
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
 	kfree(tr);
+	tr = NULL;
 
-	ret = 0;
+	return 0;
+}
+
+int trace_array_destroy(struct trace_array *tr)
+{
+	int ret;
+
+	if (!tr)
+		return -EINVAL;
+
+	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
+
+	ret = __remove_instance(tr);
+
+	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(trace_array_destroy);
+
+static int instance_rmdir(const char *name)
+{
+	struct trace_array *tr;
+	int ret;
+
+	mutex_lock(&event_mutex);
+	mutex_lock(&trace_types_lock);
+
+	ret = -ENODEV;
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr->name && strcmp(tr->name, name) == 0) {
+			ret = __remove_instance(tr);
+			break;
+		}
+	}
 
- out_unlock:
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 5b3b0c3..81c038e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -832,6 +832,7 @@ static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
 
 /**
  * trace_set_clr_event - enable or disable an event
-- 
1.8.3.1

