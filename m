Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1AAC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6516D20891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfDYQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfDYQ2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:28:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795B520B7C;
        Thu, 25 Apr 2019 16:28:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hJhEq-0005LU-1e; Thu, 25 Apr 2019 12:28:44 -0400
Message-Id: <20190425162843.934775051@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 25 Apr 2019 12:28:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 3/5] function_graph: Have selftest also emulate tr->reset() as it did with
 tr->init()
References: <20190425162808.056301033@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph boot up self test emulates the tr->init() function in
order to add a wrapper around the function graph tracer entry code to test
for lock ups and such. But it does not emulate the tr->reset(), and just
calls the function_graph tracer tr->reset() function which will use its own
fgraph_ops to unregister function tracing with. As the fgraph_ops is
becoming more meaningful with the register_ftrace_graph() and
unregister_ftrace_graph() functions, the two need to be the same. The
emulated tr->init() uses its own fgraph_ops descriptor, which means the
unregister_ftrace_graph() must use the same ftrace_ops, which the selftest
currently does not do. By emulating the tr->reset() as the selftest does
with the tr->init() it will be able to pass the same fgraph_ops descriptor
to the unregister_ftrace_graph() as it did with the register_ftrace_graph().

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 9d402e7fc949..69ee8ef12cee 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -792,7 +792,10 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	/* check the trace buffer */
 	ret = trace_test_buffer(&tr->trace_buffer, &count);
 
-	trace->reset(tr);
+	/* Need to also simulate the tr->reset to remove this fgraph_ops */
+	tracing_stop_cmdline_record();
+	unregister_ftrace_graph(&fgraph_ops);
+
 	tracing_start();
 
 	if (!ret && !count) {
-- 
2.20.1


