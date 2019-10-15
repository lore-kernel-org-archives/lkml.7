Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91101C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C0421925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfJONA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfJONA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:00:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F6E2064B;
        Tue, 15 Oct 2019 13:00:56 +0000 (UTC)
Date:   Tue, 15 Oct 2019 09:00:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: fix function type mismatches
Message-ID: <20191015090055.789a0aed@gandalf.local.home>
In-Reply-To: <CABCJKueYhWL_YnkqRW9TtM4sTB50TNjTZ23_4xfpZNy0GwY5VA@mail.gmail.com>
References: <20191007214740.188547-1-samitolvanen@google.com>
        <201910101411.98362BA0@keescook>
        <20191011142650.36404713@gandalf.local.home>
        <CABCJKueYhWL_YnkqRW9TtM4sTB50TNjTZ23_4xfpZNy0GwY5VA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 13:00:09 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Fri, Oct 11, 2019 at 11:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > Unfortunately, this breaks function graph tracing.  
> 
> Thank you for pointing this out. I should have realized this solution
> wouldn't work.
> 
> > Is there a way to do an alias or something that can fix whatever you
> > are trying to fix?  
> 
> Unfortunately, an alias doesn't work in this case either, because the
> compiler still looks at the type of the target function. I'll find
> another way to solve the issue.
> 

Would this work for you?

-- Steve

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dae64600ccbf..33b36b34721b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -111,15 +111,22 @@
 
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
 #define MCOUNT_REC()
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
