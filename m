Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D1EC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3481420891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfDYQ3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfDYQ2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:28:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B973C208E4;
        Thu, 25 Apr 2019 16:28:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hJhEq-0005MS-C0; Thu, 25 Apr 2019 12:28:44 -0400
Message-Id: <20190425162844.270281960@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 25 Apr 2019 12:28:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [for-next][PATCH 5/5] function_graph: Place ftrace_graph_entry_stub() prototype in
 include/linux/ftrace.h
References: <20190425162808.056301033@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

ftrace_graph_entry_stub() is defined in generic code, its prototype should
be in the generic header and not defined throughout architecture specific
code in order to use it.

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/nds32/kernel/ftrace.c  | 1 -
 arch/parisc/kernel/ftrace.c | 1 -
 include/linux/ftrace.h      | 2 ++
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index 8a41372551ff..fd2a54b8cd57 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -7,7 +7,6 @@
 #ifndef CONFIG_DYNAMIC_FTRACE
 extern void (*ftrace_trace_function)(unsigned long, unsigned long,
 				     struct ftrace_ops*, struct pt_regs*);
-extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
 extern void ftrace_graph_caller(void);
 
 noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index e46a4157a894..a28f915993b1 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -51,7 +51,6 @@ void notrace __hot ftrace_function_trampoline(unsigned long parent,
 				unsigned long org_sp_gr3)
 {
 	extern ftrace_func_t ftrace_trace_function;  /* depends on CONFIG_DYNAMIC_FTRACE */
-	extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
 
 	if (ftrace_trace_function != ftrace_stub) {
 		/* struct ftrace_ops *op, struct pt_regs *regs); */
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 730876187344..9b28fce436ca 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -751,6 +751,8 @@ struct ftrace_graph_ret {
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *); /* return */
 typedef int (*trace_func_graph_ent_t)(struct ftrace_graph_ent *); /* entry */
 
+extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 struct fgraph_ops {
-- 
2.20.1


