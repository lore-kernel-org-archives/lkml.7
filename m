Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9186BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBB621874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404321AbfHHRY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404281AbfHHRY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:24:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E963F217F4;
        Thu,  8 Aug 2019 17:24:56 +0000 (UTC)
Date:   Thu, 8 Aug 2019 13:24:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiping Ma <jiping.ma2@windriver.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] tracing/arm64: Have max stack tracer handle the
 case of return address after data
Message-ID: <20190808132455.5fa2c660@gandalf.local.home>
In-Reply-To: <20190808171153.6j56h4hlcpcl5trz@willie-the-truck>
References: <20190807172826.352574408@goodmis.org>
        <20190807172907.155165959@goodmis.org>
        <20190808162825.7klpu3ffza5zxwrt@willie-the-truck>
        <20190808123632.0dd1a58c@gandalf.local.home>
        <20190808171153.6j56h4hlcpcl5trz@willie-the-truck>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019 18:11:53 +0100
Will Deacon <will@kernel.org> wrote:

> > We could make it more descriptive of what it will do and not the reason
> > for why it is done...
> > 
> > 
> >   ARCH_FTRACE_SHIFT_STACK_TRACER  
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks Will!

Here's the official patch.

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Most archs (well at least x86) store the function call return address on the
stack before storing the local variables for the function. The max stack
tracer depends on this in its algorithm to display the stack size of each
function it finds in the back trace.

Some archs (arm64), may store the return address (from its link register)
just before calling a nested function. There's no reason to save the link
register on leaf functions, as it wont be updated. This breaks the algorithm
of the max stack tracer.

Add a new define ARCH_RET_ADDR_AFTER_LOCAL_VARS that an architecture may set
if it stores the return address (link register) after it stores the
function's local variables, and have the stack trace shift the values of the
mapped stack size to the appropriate functions.

Link: 20190802094103.163576-1-jiping.ma2@windriver.com

Reported-by: Jiping Ma <jiping.ma2@windriver.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/include/asm/ftrace.h | 13 +++++++++++++
 kernel/trace/trace_stack.c      | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 5ab5200b2bdc..d48667b04c41 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -14,6 +14,19 @@
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
+/*
+ * Currently, gcc tends to save the link register after the local variables
+ * on the stack. This causes the max stack tracer to report the function
+ * frame sizes for the wrong functions. By defining
+ * ARCH_FTRACE_SHIFT_STACK_TRACER, it will tell the stack tracer to expect
+ * to find the return address on the stack after the local variables have
+ * been set up.
+ *
+ * Note, this may change in the future, and we will need to deal with that
+ * if it were to happen.
+ */
+#define ARCH_FTRACE_SHIFT_STACK_TRACER 1
+
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
 
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5d16f73898db..642a850af81a 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -158,6 +158,20 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
+#ifdef ARCH_FTRACE_SHIFT_STACK_TRACER
+	/*
+	 * Some archs will store the link register before calling
+	 * nested functions. This means the saved return address
+	 * comes after the local storage, and we need to shift
+	 * for that.
+	 */
+	if (x > 1) {
+		memmove(&stack_trace_index[0], &stack_trace_index[1],
+			sizeof(stack_trace_index[0]) * (x - 1));
+		x--;
+	}
+#endif
+
 	stack_trace_nr_entries = x;
 
 	if (task_stack_end_corrupted(current)) {
-- 
2.20.1

