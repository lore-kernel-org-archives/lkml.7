Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3AD20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfKNSSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfKNSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3162A2086E;
        Thu, 14 Nov 2019 18:18:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhK-00017n-Da; Thu, 14 Nov 2019 13:18:26 -0500
Message-Id: <20191114181826.298951318@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: [for-next][PATCH 20/33] tracing: Declare newly exported APIs in include/linux/trace.h
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divya Indi <divya.indi@oracle.com>

Declare the newly introduced and exported APIs in the header file -
include/linux/trace.h. Moving previous declarations from
kernel/trace/trace.h to include/linux/trace.h.

Link: http://lkml.kernel.org/r/1565805327-579-2-git-send-email-divya.indi@oracle.com

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace.h | 7 +++++++
 kernel/trace/trace.h  | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index b95ffb2188ab..24fcf07812ae 100644
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
index 718eb998c13e..90cba68c8b50 100644
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
@@ -873,8 +874,6 @@ trace_vprintk(unsigned long ip, const char *fmt, va_list args);
 extern int
 trace_array_vprintk(struct trace_array *tr,
 		    unsigned long ip, const char *fmt, va_list args);
-int trace_array_printk(struct trace_array *tr,
-		       unsigned long ip, const char *fmt, ...);
 int trace_array_printk_buf(struct ring_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...);
 void trace_printk_seq(struct trace_seq *s);
@@ -1890,7 +1889,6 @@ extern const char *__start___tracepoint_str[];
 extern const char *__stop___tracepoint_str[];
 
 void trace_printk_control(bool enabled);
-void trace_printk_init_buffers(void);
 void trace_printk_start_comm(void);
 int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
-- 
2.23.0


