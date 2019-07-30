Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E95C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6AE216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jt5OWAIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfG3ADk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:03:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36772 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbfG3ADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:03:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNwrOS162454;
        Tue, 30 Jul 2019 00:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=GTTsI3hpmzv6xCZNf1ZA/IXD4/gevv4MHq+lAe5XQeo=;
 b=Jt5OWAItE5LzxetmSmKAJTDlVmN9fEN5FdBs+b4L1OLWRYJteXe4G74U+f+2z9nF+B/Z
 1gLkDOQ78QH5gsAk7uD3IOt42IHwi4D5WJre0JtDR4Tr1JXl2dqgA3WwaY1qQS6mOOkf
 dR0A2g3vcPoTWijhv7BfA1fvIR/YXguq3Qr8/1iPFddDE3B6P7wbTsJ1qiPViGPX1qOr
 guPvZWAlVmPcPS4dLhTRLDGFC5zOuLPQ5bE30ijX65VUHwaRRii4HPM79Yj+xGRbp6VN
 DUa0G0LFpeeS6Q2lTTc7ZvNAXQADswF0IISIbhtY+pPYuDWImP63wNxe4pG8UVvB4J1I 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u0f8qtpgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNvbef019532;
        Tue, 30 Jul 2019 00:02:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u0ee4kv30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:47 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U02kqG012418;
        Tue, 30 Jul 2019 00:02:46 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 17:02:46 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH 2/7] tracing: Declare newly exported APIs in include/linux/trace.h
Date:   Mon, 29 Jul 2019 17:02:29 -0700
Message-Id: <1564444954-28685-3-git-send-email-divya.indi@oracle.com>
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

Declare the newly introduced and exported APIs in the header file -
include/linux/trace.h. Moving previous declarations from
kernel/trace/trace.h to include/linux/trace.h.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-By: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 include/linux/trace.h | 7 +++++++
 kernel/trace/trace.h  | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index b95ffb2..24fcf07 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -24,6 +24,13 @@ struct trace_export {
 int register_ftrace_export(struct trace_export *export);
 int unregister_ftrace_export(struct trace_export *export);
 
+struct trace_array;
+
+void trace_printk_init_buffers(void);
+int trace_array_printk(struct trace_array *tr, unsigned long ip,
+		const char *fmt, ...);
+struct trace_array *trace_array_create(const char *name);
+int trace_array_destroy(struct trace_array *tr);
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f086..66ff63e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -11,6 +11,7 @@
 #include <linux/mmiotrace.h>
 #include <linux/tracepoint.h>
 #include <linux/ftrace.h>
+#include <linux/trace.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/trace_seq.h>
 #include <linux/trace_events.h>
@@ -852,8 +853,6 @@ extern int trace_selftest_startup_branch(struct tracer *trace,
 extern int
 trace_array_vprintk(struct trace_array *tr,
 		    unsigned long ip, const char *fmt, va_list args);
-int trace_array_printk(struct trace_array *tr,
-		       unsigned long ip, const char *fmt, ...);
 int trace_array_printk_buf(struct ring_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...);
 void trace_printk_seq(struct trace_seq *s);
@@ -1869,7 +1868,6 @@ extern int trace_event_enable_disable(struct trace_event_file *file,
 extern const char *__stop___tracepoint_str[];
 
 void trace_printk_control(bool enabled);
-void trace_printk_init_buffers(void);
 void trace_printk_start_comm(void);
 int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
-- 
1.8.3.1

