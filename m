Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F79EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4E720891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfDYQ2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfDYQ2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:28:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2712089E;
        Thu, 25 Apr 2019 16:28:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hJhEp-0005Ku-Rv; Thu, 25 Apr 2019 12:28:43 -0400
Message-Id: <20190425162843.751657930@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 25 Apr 2019 12:28:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 2/5] ftrace: Do not process STUB functions in ftrace_ops_list_func()
References: <20190425162808.056301033@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The function_graph tracer has a stub function and its ops flag has the
FTRACE_OPS_FL_STUB set. As the function graph does not use the
ftrace_ops->func pointer but instead is called by a separate part of the
ftrace trampoline. The function_graph tracer still requires to pass in a
ftrace_ops that may also hold the hash of the functions to call. But there's
no reason to test that hash in the function tracing portion. Instead of
testing to see if we should call the stub function, just test if the ops has
FTRACE_OPS_FL_STUB set, and just skip it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bf11e0553450..433a64f49532 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6260,6 +6260,9 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	preempt_disable_notrace();
 
 	do_for_each_ftrace_op(op, ftrace_ops_list) {
+		/* Stub functions don't need to be called nor tested */
+		if (op->flags & FTRACE_OPS_FL_STUB)
+			continue;
 		/*
 		 * Check the following for each ops before calling their func:
 		 *  if RCU flag is set, then rcu_is_watching() must be true
-- 
2.20.1


