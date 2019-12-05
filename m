Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C38C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89EB224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfLECGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:06:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbfLECFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:05:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF0622B48;
        Thu,  5 Dec 2019 02:05:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1icgWa-000oCM-I7; Wed, 04 Dec 2019 21:05:48 -0500
Message-Id: <20191205020548.446051018@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 04 Dec 2019 21:05:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 3/3] tracing: Do not create directories if lockdown is in affect
References: <20191205020459.023316620@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If lockdown is disabling tracing on boot up, it prevents the tracing files
from even bering created. But when that happens, there's several places that
will give a warning that the files were not created as that is usually a
sign of a bug.

Add in strategic locations where a check is made to see if tracing is
disabled by lockdown, and if it is, do not go further, and fail silently
(but print that tracing is disabled by lockdown, without doing a WARN_ON()).

Cc: Matthew Garrett <mjg59@google.com>
Fixes: 17911ff38aa5 ("tracing: Add locked_down checks to the open calls of files created for tracefs")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c |  6 ++++++
 kernel/trace/trace.c       | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 66358d66c933..4bf050fcfe3b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -11,6 +11,7 @@
 #include <linux/trace_seq.h>
 #include <linux/spinlock.h>
 #include <linux/irq_work.h>
+#include <linux/security.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kthread.h>	/* for self test */
@@ -5068,6 +5069,11 @@ static __init int test_ringbuffer(void)
 	int cpu;
 	int ret = 0;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS)) {
+		pr_warning("Lockdown is enabled, skipping ring buffer tests\n");
+		return 0;
+	}
+
 	pr_info("Running ring buffer tests...\n");
 
 	buffer = ring_buffer_alloc(RB_TEST_BUFFER_SIZE, RB_FL_OVERWRITE);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 02a23a6e5e00..23459d53d576 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1888,6 +1888,12 @@ int __init register_tracer(struct tracer *type)
 		return -1;
 	}
 
+	if (security_locked_down(LOCKDOWN_TRACEFS)) {
+		pr_warning("Can not register tracer %s due to lockdown\n",
+			   type->name);
+		return -EPERM;
+	}
+
 	mutex_lock(&trace_types_lock);
 
 	tracing_selftest_running = true;
@@ -8789,6 +8795,11 @@ struct dentry *tracing_init_dentry(void)
 {
 	struct trace_array *tr = &global_trace;
 
+	if (security_locked_down(LOCKDOWN_TRACEFS)) {
+		pr_warning("Tracing disabled due to lockdown\n");
+		return ERR_PTR(-EPERM);
+	}
+
 	/* The top level trace array uses  NULL as parent */
 	if (tr->dir)
 		return NULL;
@@ -9231,6 +9242,12 @@ __init static int tracer_alloc_buffers(void)
 	int ring_buf_size;
 	int ret = -ENOMEM;
 
+
+	if (security_locked_down(LOCKDOWN_TRACEFS)) {
+		pr_warning("Tracing disabled due to lockdown\n");
+		return -EPERM;
+	}
+
 	/*
 	 * Make sure we don't accidently add more trace options
 	 * than we have bits for.
-- 
2.24.0


