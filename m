Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F15C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7263C217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390682AbfEXKlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:41:53 -0400
Received: from foss.arm.com ([217.140.101.70]:39800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390639AbfEXKlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:41:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2CCC374;
        Fri, 24 May 2019 03:41:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23A643F703;
        Fri, 24 May 2019 03:41:51 -0700 (PDT)
Date:   Fri, 24 May 2019 11:41:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tengfei Fan <tengfeif@codeaurora.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        anshuman.khandual@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tengfei@codeaurora.org
Subject: Re: [PATCH] arm64: break while loop if task had been rescheduled
Message-ID: <20190524104148.GB12796@lakrids.cambridge.arm.com>
References: <1558430404-4840-1-git-send-email-tengfeif@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558430404-4840-1-git-send-email-tengfeif@codeaurora.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 05:20:04PM +0800, Tengfei Fan wrote:
> While printing a task's backtrace and this task isn't
> current task, it is possible that task's fp and fp+8
> have the same value, so cannot break the while loop.
> This can break while loop if this task had been
> rescheduled during print this task's backtrace.

There are a few cases where backtracing can get stuck in an infinite
loop. I'd attempted to address that more generally in my
arm64/robust-stacktrace branch [1].

Looking at tsk->state here is inherently racy, and doesn't solve the
general case, so I'd prefer to avoid that.

Do my patches help you here? If so, I'm happy to rebase those to
v5.2-rc1 and repost.

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/robust-stacktrace

> 
> Signed-off-by: Tengfei Fan <tengfeif@codeaurora.org>
> ---
>  arch/arm64/kernel/traps.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 2975598..9df6e02 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -103,6 +103,9 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  {
>  	struct stackframe frame;
>  	int skip = 0;
> +	long cur_state = 0;
> +	unsigned long cur_sp = 0;
> +	unsigned long cur_fp = 0;
>  
>  	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
>  
> @@ -127,6 +130,9 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  		 */
>  		frame.fp = thread_saved_fp(tsk);
>  		frame.pc = thread_saved_pc(tsk);
> +		cur_state = tsk->state;
> +		cur_sp = thread_saved_sp(tsk);
> +		cur_fp = frame.fp;
>  	}
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	frame.graph = 0;
> @@ -134,6 +140,23 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>  
>  	printk("Call trace:\n");
>  	do {
> +		if (tsk != current && (cur_state != tsk->state
> +			/*
> +			 * We would not be printing backtrace for the task
> +			 * that has changed state from uninterruptible to
> +			 * running before hitting the do-while loop but after
> +			 * saving the current state. If task is in running
> +			 * state before saving the state, then we may print
> +			 * wrong call trace or end up in infinite while loop
> +			 * if *(fp) and *(fp+8) are same. While the situation
> +			 * will stop print when that task schedule out.
> +			 */
> +			|| cur_sp != thread_saved_sp(tsk)
> +			|| cur_fp != thread_saved_fp(tsk))) {
> +			printk("The task:%s had been rescheduled!\n",
> +				tsk->comm);
> +			break;
> +		}
>  		/* skip until specified stack frame */
>  		if (!skip) {
>  			dump_backtrace_entry(frame.pc);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
