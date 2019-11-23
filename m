Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823F0C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C652067D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKWSNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:13:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfKWSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E52C42071C;
        Sat, 23 Nov 2019 18:12:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZth-000Exr-2r; Sat, 23 Nov 2019 13:12:41 -0500
Message-Id: <20191123181240.959574232@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:11:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 02/10] ftrace: Rename ftrace_graph_stub to ftrace_stub_graph
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ftrace_graph_stub was created and points to ftrace_stub as a way to
assign the functon graph tracer function pointer to a stub function with a
different prototype than what ftrace_stub has and not trigger the C
verifier. The ftrace_graph_stub was created via the linker script
vmlinux.lds.h. Unfortunately, powerpc already uses the name
ftrace_graph_stub for its internal implementation of the function graph
tracer, and even though powerpc would still build, the change via the linker
script broke function tracer on powerpc from working.

By using the name ftrace_stub_graph, which does not exist anywhere else in
the kernel, this should not be a problem.

Link: https://lore.kernel.org/r/1573849732.5937.136.camel@lca.pw

Fixes: b83b43ffc6e4 ("fgraph: Fix function type mismatches of ftrace_graph_return using ftrace_stub")
Reorted-by: Qian Cai <cai@lca.pw>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/asm-generic/vmlinux.lds.h | 8 ++++----
 kernel/trace/fgraph.c             | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0f358be551cd..996db32c491b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -112,7 +112,7 @@
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 #ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
 /*
- * Need to also make ftrace_graph_stub point to ftrace_stub
+ * Need to also make ftrace_stub_graph point to ftrace_stub
  * so that the same stub location may have different protocols
  * and not mess up with C verifiers.
  */
@@ -120,17 +120,17 @@
 			__start_mcount_loc = .;			\
 			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;			\
-			ftrace_graph_stub = ftrace_stub;
+			ftrace_stub_graph = ftrace_stub;
 #else
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
 			__stop_mcount_loc = .;			\
-			ftrace_graph_stub = ftrace_stub;
+			ftrace_stub_graph = ftrace_stub;
 #endif
 #else
 # ifdef CONFIG_FUNCTION_TRACER
-#  define MCOUNT_REC()	ftrace_graph_stub = ftrace_stub;
+#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;
 # else
 #  define MCOUNT_REC()
 # endif
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index fa3ce10d0405..67e0c462b059 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -336,10 +336,10 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
  * Simply points to ftrace_stub, but with the proper protocol.
  * Defined by the linker script in linux/vmlinux.lds.h
  */
-extern void ftrace_graph_stub(struct ftrace_graph_ret *);
+extern void ftrace_stub_graph(struct ftrace_graph_ret *);
 
 /* The callbacks that hook a function */
-trace_func_graph_ret_t ftrace_graph_return = ftrace_graph_stub;
+trace_func_graph_ret_t ftrace_graph_return = ftrace_stub_graph;
 trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
 static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
 
@@ -619,7 +619,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		goto out;
 
 	ftrace_graph_active--;
-	ftrace_graph_return = ftrace_graph_stub;
+	ftrace_graph_return = ftrace_stub_graph;
 	ftrace_graph_entry = ftrace_graph_entry_stub;
 	__ftrace_graph_entry = ftrace_graph_entry_stub;
 	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
-- 
2.24.0


