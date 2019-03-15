Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D3AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ABC218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KdLUAQVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfCOXgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:36:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41054 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCOXgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:36:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2FNXprk157704;
        Fri, 15 Mar 2019 23:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=uDpsaOrNRLkjdQP9pDjrPY9kgJxV0EZ+pEZ60Tfte0Y=;
 b=KdLUAQVBh8jgWBJaqcxb2mepPs/AfT428xekoByNFrjgNak42iuQxTh69ABIYMO1k/of
 WqSiVjyACZapgMcbmYs/lRR2t3IIPbLJ3NeJcIZSUvZqOSkjAITUhm4oBhbqOmlmpWzk
 HRN78k7VuZKKMgm0BOhtuokjppdp8q5oc8ixO449Vtb+HLhDDdPnmnklXgNXkQagFKUj
 KLlWD7xUiNJSTeIEurLWgE/ybxUk0CQzIkIhbKdBbgkDZo5C7Oq1XZ9FiFNAugQiD4yA
 gGhpbTN8Fi+pbmAVrQwppfZHt7CLsZ7Dv7kT7JZLbUq0XqCNFOYfnfxOR+RP/M60wQ2N Yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2r464s1che-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 23:35:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2FNZcGV030926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 23:35:39 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2FNZcW3031539;
        Fri, 15 Mar 2019 23:35:38 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Mar 2019 23:35:38 +0000
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: [PATCH] tracing: Kernel access to ftrace instances
Date:   Fri, 15 Mar 2019 16:35:25 -0700
Message-Id: <1552692925-17240-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1552692925-17240-1-git-send-email-divya.indi@oracle.com>
References: <1552692925-17240-1-git-send-email-divya.indi@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9196 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903150160
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
---
 kernel/trace/trace.c        | 72 +++++++++++++++++++++++++++++----------------
 kernel/trace/trace_events.c |  1 +
 2 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c4238b4..a5e7e51 100644
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
-
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
+	
 	if (tr->ref || (tr->current_trace && tr->current_trace->ref))
-		goto out_unlock;
+		return -EBUSY;
 
 	list_del(&tr->list);
 
@@ -7961,9 +7951,41 @@ static int instance_rmdir(const char *name)
 	kfree(tr->name);
 	kfree(tr);
 
-	ret = 0;
+	return 0;
+}
 
- out_unlock:
+int trace_array_destroy(struct trace_array *tr)
+{
+	int ret;
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
+	
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

