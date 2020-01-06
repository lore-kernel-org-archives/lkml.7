Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07BBC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C1C2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgAFVUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgAFVT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:19:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CC0214D8;
        Mon,  6 Jan 2020 21:19:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1ioZn4-000MVW-1t; Mon, 06 Jan 2020 16:19:58 -0500
Message-Id: <20200106211957.921104424@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 06 Jan 2020 16:19:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>
Subject: [for-linus][PATCH 2/7] tracing: Define MCOUNT_INSN_SIZE when not defined without direct
 calls
References: <20200106211901.293910946@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In order to handle direct calls along side of function graph tracer, a check
is made to see if the address being traced by the function graph tracer is a
direct call or not. To get the address used by direct callers, the return
address is subtracted by MCOUNT_INSN_SIZE.

For some archs with certain configurations, MCOUNT_INSN_SIZE is undefined
here. But these should not be using direct calls anyway. Just define
MCOUNT_INSN_SIZE to zero in this case.

Link: https://lore.kernel.org/r/202001020219.zvE3vsty%lkp@intel.com

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: ff205766dbbee ("ftrace: Fix function_graph tracer interaction with BPF trampoline")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index a2659735db73..1af321dec0f1 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -96,6 +96,20 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	return 0;
 }
 
+/*
+ * Not all archs define MCOUNT_INSN_SIZE which is used to look for direct
+ * functions. But those archs currently don't support direct functions
+ * anyway, and ftrace_find_rec_direct() is just a stub for them.
+ * Define MCOUNT_INSN_SIZE to keep those archs compiling.
+ */
+#ifndef MCOUNT_INSN_SIZE
+/* Make sure this only works without direct calls */
+# ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+#  error MCOUNT_INSN_SIZE not defined with direct calls enabled
+# endif
+# define MCOUNT_INSN_SIZE 0
+#endif
+
 int function_graph_enter(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
-- 
2.24.0


