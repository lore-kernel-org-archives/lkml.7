Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9317BC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9982229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfHGT3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbfHGT3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:29:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3129D2086D;
        Wed,  7 Aug 2019 19:29:17 +0000 (UTC)
Date:   Wed, 7 Aug 2019 15:29:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2 v2] tracing/arm64: Have max stack tracer handle the
 case of return address after data
Message-ID: <20190807152915.6ee412b1@gandalf.local.home>
In-Reply-To: <20190807172907.155165959@goodmis.org>
References: <20190807172826.352574408@goodmis.org>
        <20190807172907.155165959@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ I should have added Mark as Cc ]

Dear ARM64 folks,

Are you OK with this patch set?

If so, please ACK.

Should it be marked for stable?

Hmm, I'm starting to think not.

-- Steve


On Wed, 07 Aug 2019 13:28:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Most archs (well at least x86) store the function call return address on the
> stack before storing the local variables for the function. The max stack
> tracer depends on this in its algorithm to display the stack size of each
> function it finds in the back trace.
> 
> Some archs (arm64), may store the return address (from its link register)
> just before calling a nested function. There's no reason to save the link
> register on leaf functions, as it wont be updated. This breaks the algorithm
> of the max stack tracer.
> 
> Add a new define ARCH_RET_ADDR_AFTER_LOCAL_VARS that an architecture may set
> if it stores the return address (link register) after it stores the
> function's local variables, and have the stack trace shift the values of the
> mapped stack size to the appropriate functions.
> 
> Link: 20190802094103.163576-1-jiping.ma2@windriver.com
> 
> Reported-by: Jiping Ma <jiping.ma2@windriver.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/arm64/include/asm/ftrace.h | 13 +++++++++++++
>  kernel/trace/trace_stack.c      | 14 ++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 5ab5200b2bdc..961e98618db4 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -14,6 +14,19 @@
>  #define MCOUNT_ADDR		((unsigned long)_mcount)
>  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
>  
> +/*
> + * Currently, gcc tends to save the link register after the local variables
> + * on the stack. This causes the max stack tracer to report the function
> + * frame sizes for the wrong functions. By defining
> + * ARCH_RET_ADDR_AFTER_LOCAL_VARS, it will tell the stack tracer to expect
> + * to find the return address on the stack after the local variables have
> + * been set up.
> + *
> + * Note, this may change in the future, and we will need to deal with that
> + * if it were to happen.
> + */
> +#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1
> +
>  #ifndef __ASSEMBLY__
>  #include <linux/compat.h>
>  
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 5d16f73898db..40e4a88eea8f 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -158,6 +158,20 @@ static void check_stack(unsigned long ip, unsigned long *stack)
>  			i++;
>  	}
>  
> +#ifdef ARCH_RET_ADDR_AFTER_LOCAL_VARS
> +	/*
> +	 * Some archs will store the link register before calling
> +	 * nested functions. This means the saved return address
> +	 * comes after the local storage, and we need to shift
> +	 * for that.
> +	 */
> +	if (x > 1) {
> +		memmove(&stack_trace_index[0], &stack_trace_index[1],
> +			sizeof(stack_trace_index[0]) * (x - 1));
> +		x--;
> +	}
> +#endif
> +
>  	stack_trace_nr_entries = x;
>  
>  	if (task_stack_end_corrupted(current)) {

