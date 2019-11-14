Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA8DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0AE20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfKNSTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfKNSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F6220870;
        Thu, 14 Nov 2019 18:18:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhK-00018l-Ml; Thu, 14 Nov 2019 13:18:26 -0500
Message-Id: <20191114181826.600517271@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Divya Indi <divya.indi@oracle.com>
Subject: [for-next][PATCH 22/33] tracing: Adding NULL checks for trace_array descriptor pointer
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divya Indi <divya.indi@oracle.com>

As part of commit f45d1225adb0 ("tracing: Kernel access to Ftrace
instances") we exported certain functions. Here, we are adding some additional
NULL checks to ensure safe usage by users of these APIs.

Link: http://lkml.kernel.org/r/1565805327-579-4-git-send-email-divya.indi@oracle.com

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 3 +++
 kernel/trace/trace_events.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fa4f742fc449..79fe4d6ecbd8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3297,6 +3297,9 @@ int trace_array_printk(struct trace_array *tr,
 	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
+	if (!tr)
+		return -ENOENT;
+
 	va_start(ap, fmt);
 	ret = trace_array_vprintk(tr, ip, fmt, ap);
 	va_end(ap);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index fba87d10f0c1..2a3ac2365445 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -793,6 +793,8 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 	char *event = NULL, *sub = NULL, *match;
 	int ret;
 
+	if (!tr)
+		return -ENOENT;
 	/*
 	 * The buf format can be <subsystem>:<event-name>
 	 *  *:<event-name> means any event by that name.
-- 
2.23.0


