Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B457FC43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4548E21925
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390660AbfIEPn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388711AbfIEPnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9775821927;
        Thu,  5 Sep 2019 15:43:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvE-0007dn-4L; Thu, 05 Sep 2019 11:43:44 -0400
Message-Id: <20190905154344.021926536@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 24/25] tracing: Rename tracing_reset() to tracing_reset_cpu()
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The name tracing_reset() was a misnomer, as it really only reset a single
CPU buffer. Rename it to tracing_reset_cpu() and also make it static and
remove the prototype from trace.h, as it is only used in a single function.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 +++---
 kernel/trace/trace.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3916b72de715..e917aa783675 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1854,7 +1854,7 @@ int __init register_tracer(struct tracer *type)
 	return ret;
 }
 
-void tracing_reset(struct trace_buffer *buf, int cpu)
+static void tracing_reset_cpu(struct trace_buffer *buf, int cpu)
 {
 	struct ring_buffer *buffer = buf->buffer;
 
@@ -4251,7 +4251,7 @@ static int tracing_open(struct inode *inode, struct file *file)
 		if (cpu == RING_BUFFER_ALL_CPUS)
 			tracing_reset_online_cpus(trace_buf);
 		else
-			tracing_reset(trace_buf, cpu);
+			tracing_reset_cpu(trace_buf, cpu);
 	}
 
 	if (file->f_mode & FMODE_READ) {
@@ -6742,7 +6742,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
 				tracing_reset_online_cpus(&tr->max_buffer);
 			else
-				tracing_reset(&tr->max_buffer, iter->cpu_file);
+				tracing_reset_cpu(&tr->max_buffer, iter->cpu_file);
 		}
 		break;
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f08629b8b..26b0a08f3c7d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -677,7 +677,6 @@ trace_buffer_iter(struct trace_iterator *iter, int cpu)
 
 int tracer_init(struct tracer *t, struct trace_array *tr);
 int tracing_is_enabled(void);
-void tracing_reset(struct trace_buffer *buf, int cpu);
 void tracing_reset_online_cpus(struct trace_buffer *buf);
 void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
-- 
2.20.1


