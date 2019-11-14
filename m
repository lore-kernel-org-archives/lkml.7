Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4522C20718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKNQ0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:26:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKNQ0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:26:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD35720715;
        Thu, 14 Nov 2019 16:26:13 +0000 (UTC)
Date:   Thu, 14 Nov 2019 11:26:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH v2] fgraph: Fix function type mismatches of
 ftrace_graph_return using ftrace_stub
Message-ID: <20191114112612.3937f281@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The C compiler is allowing more checks to make sure that function pointers
are assigned to the correct prototype function. Unfortunately, the function
graph tracer uses a special name with its assigned ftrace_graph_return
function pointer that maps to a stub function used by the function tracer
(ftrace_stub). The ftrace_graph_return variable is compared to the
ftrace_stub in some archs to know if the function graph tracer is enabled or
not. This means we can not just simply create a new function stub that
compares it without modifying all the archs.

Instead, have the linker script create a function_graph_stub that maps to
ftrace_stub, and this way we can define the prototype for it to match the
prototype of ftrace_graph_return, and make the compiler checks all happy!

Link: http://lkml.kernel.org/r/20191015090055.789a0aed@gandalf.local.home

Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

Changes from v1:

  When I ran this through the ktest crosstests.conf, it failed on
  superh, as superh uses the vmlinux.lds file from the kernel for
  its compression, it requires that it has a ftrace_stub() function
  defined there too.


 arch/sh/boot/compressed/misc.c    |  5 +++++
 include/asm-generic/vmlinux.lds.h | 17 ++++++++++++++---
 kernel/trace/fgraph.c             | 11 ++++++++---
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index c15cac9251b9..e69ec12cbbe6 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -111,6 +111,11 @@ void __stack_chk_fail(void)
 	error("stack-protector: Kernel stack is corrupted\n");
 }
 
+/* Needed because vmlinux.lds.h references this */
+void ftrace_stub(void)
+{
+}
+
 #ifdef CONFIG_SUPERH64
 #define stackalign	8
 #else
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dae64600ccbf..0f358be551cd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -111,18 +111,29 @@
 
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 #ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
+/*
+ * Need to also make ftrace_graph_stub point to ftrace_stub
+ * so that the same stub location may have different protocols
+ * and not mess up with C verifiers.
+ */
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__patchable_function_entries))	\
-			__stop_mcount_loc = .;
+			__stop_mcount_loc = .;			\
+			ftrace_graph_stub = ftrace_stub;
 #else
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
-			__stop_mcount_loc = .;
+			__stop_mcount_loc = .;			\
+			ftrace_graph_stub = ftrace_stub;
 #endif
 #else
-#define MCOUNT_REC()
+# ifdef CONFIG_FUNCTION_TRACER
+#  define MCOUNT_REC()	ftrace_graph_stub = ftrace_stub;
+# else
+#  define MCOUNT_REC()
+# endif
 #endif
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 7950a0356042..fa3ce10d0405 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -332,9 +332,14 @@ int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
 	return 0;
 }
 
+/*
+ * Simply points to ftrace_stub, but with the proper protocol.
+ * Defined by the linker script in linux/vmlinux.lds.h
+ */
+extern void ftrace_graph_stub(struct ftrace_graph_ret *);
+
 /* The callbacks that hook a function */
-trace_func_graph_ret_t ftrace_graph_return =
-			(trace_func_graph_ret_t)ftrace_stub;
+trace_func_graph_ret_t ftrace_graph_return = ftrace_graph_stub;
 trace_func_graph_ent_t ftrace_graph_entry = ftrace_graph_entry_stub;
 static trace_func_graph_ent_t __ftrace_graph_entry = ftrace_graph_entry_stub;
 
@@ -614,7 +619,7 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		goto out;
 
 	ftrace_graph_active--;
-	ftrace_graph_return = (trace_func_graph_ret_t)ftrace_stub;
+	ftrace_graph_return = ftrace_graph_stub;
 	ftrace_graph_entry = ftrace_graph_entry_stub;
 	__ftrace_graph_entry = ftrace_graph_entry_stub;
 	ftrace_shutdown(&graph_ops, FTRACE_STOP_FUNC_RET);
-- 
2.20.1

