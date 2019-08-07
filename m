Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E512231F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbfHGQfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730128AbfHGQe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:34:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F5222305;
        Wed,  7 Aug 2019 16:34:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hvOtq-0007nb-GQ; Wed, 07 Aug 2019 12:34:54 -0400
Message-Id: <20190807163454.392141426@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 07 Aug 2019 12:34:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] tracing: Document the stack trace algorithm in the comments
References: <20190807163401.570339297@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As the max stack tracer algorithm is not that easy to understand from the
code, add comments that explain the algorithm and mentions how
ARCH_RET_ADDR_AFTER_LOCAL_VARS affects it.

Link: http://lkml.kernel.org/r/20190806123455.487ac02b@gandalf.local.home

Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_stack.c | 98 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 40e4a88eea8f..7a9a62834af9 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -53,6 +53,104 @@ static void print_max_stack(void)
 	}
 }
 
+/*
+ * The stack tracer looks for a maximum stack at each call from a function. It
+ * registers a callback from ftrace, and in that callback it examines the stack
+ * size. It determines the stack size from the variable passed in, which is the
+ * address of a local variable in the stack_trace_call() callback function.
+ * The stack size is calculated by the address of the local variable to the top
+ * of the current stack. If that size is smaller than the currently saved max
+ * stack size, nothing more is done.
+ *
+ * If the size of the stack is greater than the maximum recorded size, then the
+ * following algorithm takes place.
+ *
+ * For architectures (like x86) that store the function's return address before
+ * saving the function's local variables, the stack will look something like
+ * this:
+ *
+ *   [ top of stack ]
+ *    0: sys call entry frame
+ *   10: return addr to entry code
+ *   11: start of sys_foo frame
+ *   20: return addr to sys_foo
+ *   21: start of kernel_func_bar frame
+ *   30: return addr to kernel_func_bar
+ *   31: [ do trace stack here ]
+ *
+ * The save_stack_trace() is called returning all the functions it finds in the
+ * current stack. Which would be (from the bottom of the stack to the top):
+ *
+ *   return addr to kernel_func_bar
+ *   return addr to sys_foo
+ *   return addr to entry code
+ *
+ * Now to figure out how much each of these functions' local variable size is,
+ * a search of the stack is made to find these values. When a match is made, it
+ * is added to the stack_dump_trace[] array. The offset into the stack is saved
+ * in the stack_trace_index[] array. The above example would show:
+ *
+ *        stack_dump_trace[]        |   stack_trace_index[]
+ *        ------------------        +   -------------------
+ *  return addr to kernel_func_bar  |          30
+ *  return addr to sys_foo          |          20
+ *  return addr to entry            |          10
+ *
+ * The print_max_stack() function above, uses these values to print the size of
+ * each function's portion of the stack.
+ *
+ *  for (i = 0; i < nr_entries; i++) {
+ *     size = i == nr_entries - 1 ? stack_trace_index[i] :
+ *                    stack_trace_index[i] - stack_trace_index[i+1]
+ *     print "%d %d %d %s\n", i, stack_trace_index[i], size, stack_dump_trace[i]);
+ *  }
+ *
+ * The above shows
+ *
+ *     depth size  location
+ *     ----- ----  --------
+ *  0    30   10   kernel_func_bar
+ *  1    20   10   sys_foo
+ *  2    10   10   entry code
+ *
+ * Now for architectures that might save the return address after the functions
+ * local variables (saving the link register before calling nested functions),
+ * this will cause the stack to look a little different:
+ *
+ * [ top of stack ]
+ *  0: sys call entry frame
+ * 10: start of sys_foo_frame
+ * 19: return addr to entry code << lr saved before calling kernel_func_bar
+ * 20: start of kernel_func_bar frame
+ * 29: return addr to sys_foo_frame << lr saved before calling next function
+ * 30: [ do trace stack here ]
+ *
+ * Although the functions returned by save_stack_trace() may be the same, the
+ * placement in the stack will be different. Using the same algorithm as above
+ * would yield:
+ *
+ *        stack_dump_trace[]        |   stack_trace_index[]
+ *        ------------------        +   -------------------
+ *  return addr to kernel_func_bar  |          30
+ *  return addr to sys_foo          |          29
+ *  return addr to entry            |          19
+ *
+ * Where the mapping is off by one:
+ *
+ *   kernel_func_bar stack frame size is 29 - 19 not 30 - 29!
+ *
+ * To fix this, if the architecture sets ARCH_RET_ADDR_AFTER_LOCAL_VARS the
+ * values in stack_trace_index[] are shifted by one to and the number of
+ * stack trace entries is decremented by one.
+ *
+ *        stack_dump_trace[]        |   stack_trace_index[]
+ *        ------------------        +   -------------------
+ *  return addr to kernel_func_bar  |          20
+ *  return addr to sys_foo          |          19
+ *
+ * Although the entry function is not displayed, the first function (sys_foo)
+ * will still include the stack size of it.
+ */
 static void check_stack(unsigned long ip, unsigned long *stack)
 {
 	unsigned long this_size, flags; unsigned long *p, *top, *start;
-- 
2.20.1


