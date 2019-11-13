Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80054C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538A1206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ouP52RyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKMVRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:17:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37538 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfKMVR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:17:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADL3u1Q034373;
        Wed, 13 Nov 2019 21:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=n9TGMlGhguTPxZjGnicJ1nMOKR2qSj3bvJciCNeuYu4=;
 b=ouP52RyV7nnAnd7mPvEkR9/c2aFeVjR0L3ygbzEPVUwsc78/6uClFDuCzHyThXcYsVzr
 JBoTQ77S+2aItfYD7B5/dyY6I+ZTEA/DZauaTLDppp2f7BrddiZUeGqL8w9fBocjGuob
 xgVP+J//JpQApXHnmsaOYyzf7bLSfq5G5jXhcLrCBggKXn4VZQAhMBgSWnQyz8x82P2K
 sbAnxIT5aovcBhMNwrwjMN840AcBLp56WL2QA9MkD9bzIWnRT3bD/aXwhX0JhH4eeZe8
 KLC62DCWHSQA+W56246spXUqYz6LkOJHmqAa0XJJig6no5SLituZBPKvDXMRw6da4BpW 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w5p3qy6b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:16:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADL3o6F060057;
        Wed, 13 Nov 2019 21:16:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w8ng4n4w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:16:58 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADLGv6A017761;
        Wed, 13 Nov 2019 21:16:57 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 13:16:57 -0800
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Joe Jin <joe.jin@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: [PATCH 1/5] tracing: Declare newly exported APIs in include/linux/trace.h
Date:   Wed, 13 Nov 2019 13:15:58 -0800
Message-Id: <1573679762-7774-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573679762-7774-1-git-send-email-divya.indi@oracle.com>
References: <1573679762-7774-1-git-send-email-divya.indi@oracle.com>
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
 definitions=main-1911130175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare the newly introduced and exported APIs in the header file -
include/linux/trace.h. Moving previous declarations from
kernel/trace/trace.h to include/linux/trace.h.

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Reviewed-by: Manjunath Patil <manjunath.b.patil@oracle.com>
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

