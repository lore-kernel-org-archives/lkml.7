Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC1CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB7E216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfHFNBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfHFNBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:01:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFB120C01;
        Tue,  6 Aug 2019 13:01:00 +0000 (UTC)
Date:   Tue, 6 Aug 2019 09:00:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jiping Ma <jiping.ma2@windriver.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, takahiro.akashi@linaro.org
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch
 in arm64
Message-ID: <20190806090059.3c106d41@gandalf.local.home>
In-Reply-To: <20190805112524.ajlmouutqckwpqyd@willie-the-truck>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
        <20190802112259.0530a648@gandalf.local.home>
        <20190803082642.GA224541@google.com>
        <20190805112524.ajlmouutqckwpqyd@willie-the-truck>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2019 12:25:25 +0100
Will Deacon <will@kernel.org> wrote:

> This can be read as "subtract 144 bytes (32*4 + 16) from the stack pointer,
> write the frame record there and then update the stack pointer to point at the
> bottom of the newly allocated stack", which means that the array 'a[32]' sits
> directly /above/ the frame record on the stack. However, this is just what my
> GCC happened to do today. When we looked at this back in 2015, there were other
> cases we ended up having to identify with heuristics based on what had been
> observed under various compilers:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393721.html

That's a bit more involved than what I came up with.

> 
> This was deemed to be far too fragile, so we didn't merge it in the end.
> 
> If this is to work reliably, then we need support from the tools. This was
> raised when we first merged support for ftrace, but I'm not sure it went
> anywhere:
> 
> https://gcc.gnu.org/ml/gcc/2016-01/msg00035.html
> 
> So, I completely agree with Steve that we shouldn't be littering the core code
> with #ifdef CONFIG_ARM64, but we probably do need something in the arch backend
> if we're going to do this properly, and that in turn is likely to need a very
> different algorithm from the one currently in use.

So basically it seems that on arm64, gcc only saves the lr when needed
(leaf functions don't need it). And I can even see that if you have
several paths that don't call other functions, why save the lr?

It does seem that doing the slight change makes the current code more
accurate without need for any heuristics.

Here's my patch again, slightly tweaked and Jiping said it solved the
issue for him.

Are you OK with this change?

-- Steve

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 5ab5200b2bdc..13a4832cfb00 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -13,6 +13,7 @@
 #define HAVE_FUNCTION_GRAPH_FP_TEST
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
+#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1
 
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5d16f73898db..40e4a88eea8f 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -158,6 +158,20 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 			i++;
 	}
 
+#ifdef ARCH_RET_ADDR_AFTER_LOCAL_VARS
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
