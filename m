Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD8BC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816022168B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfJMRoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 13:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfJMRoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 13:44:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D9820869;
        Sun, 13 Oct 2019 17:44:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iJhuk-00020W-ON; Sun, 13 Oct 2019 13:44:18 -0400
Message-Id: <20191013174418.637633186@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 13 Oct 2019 13:43:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 04/11] tracing: Have trace events system open call tracing_open_generic_tr()
References: <20191013174342.381019558@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of having the trace events system open call open code the taking of
the trace_array descriptor (with trace_array_get()) and then calling
trace_open_generic(), have it use the tracing_open_generic_tr() that does
the combination of the two. This requires making tracing_open_generic_tr()
global.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace.h        |  1 +
 kernel/trace/trace_events.c | 17 +++--------------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fa7d813b04c6..94f1b9124939 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4156,7 +4156,7 @@ bool tracing_is_disabled(void)
  * Open and update trace_array ref count.
  * Must have the current trace_array passed to it.
  */
-static int tracing_open_generic_tr(struct inode *inode, struct file *filp)
+int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f801d154ff6a..854dbf4050f8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -681,6 +681,7 @@ void tracing_reset_online_cpus(struct trace_buffer *buf);
 void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
+int tracing_open_generic_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b89cdfe20bc1..9613a757c902 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1440,28 +1440,17 @@ static int system_tr_open(struct inode *inode, struct file *filp)
 	struct trace_array *tr = inode->i_private;
 	int ret;
 
-	if (tracing_is_disabled())
-		return -ENODEV;
-
-	if (trace_array_get(tr) < 0)
-		return -ENODEV;
-
 	/* Make a temporary dir that has no system but points to tr */
 	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
-	if (!dir) {
-		trace_array_put(tr);
+	if (!dir)
 		return -ENOMEM;
-	}
-
-	dir->tr = tr;
 
-	ret = tracing_open_generic(inode, filp);
+	ret = tracing_open_generic_tr(inode, filp);
 	if (ret < 0) {
-		trace_array_put(tr);
 		kfree(dir);
 		return ret;
 	}
-
+	dir->tr = tr;
 	filp->private_data = dir;
 
 	return 0;
-- 
2.23.0


