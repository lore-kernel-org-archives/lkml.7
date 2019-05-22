Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1DBC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA7D205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfEVJEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:04:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45462 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfEVJEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:04:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A043A374;
        Wed, 22 May 2019 02:04:37 -0700 (PDT)
Received: from [10.162.43.129] (p8cg001049571a15.blr.arm.com [10.162.43.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4AC23F718;
        Wed, 22 May 2019 02:04:34 -0700 (PDT)
Subject: Re: [PATCH] arm64: break while loop if task had been rescheduled
To:     Tengfei Fan <tengfeif@codeaurora.org>, catalin.marinas@arm.com,
        will.deacon@arm.com
Cc:     mark.rutland@arm.com, marc.zyngier@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tengfei@codeaurora.org
References: <1558430404-4840-1-git-send-email-tengfeif@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f2d62227-4694-d973-cacc-8225e2b2baf4@arm.com>
Date:   Wed, 22 May 2019 14:34:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1558430404-4840-1-git-send-email-tengfeif@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2019 02:50 PM, Tengfei Fan wrote:
> While printing a task's backtrace and this task isn't
> current task, it is possible that task's fp and fp+8
> have the same value, so cannot break the while loop.
> This can break while loop if this task had been
> rescheduled during print this task's backtrace.

This is very confusing. IIUC it suggests that while printing
the backtrace for non-current tasks the do/while loop does not
exit because fp and fp+8 might have the same value ? When would
this happen ? Even in that case the commit message here does not
properly match the change in this patch.

This patch tries to stop printing the stack for non-current tasks
if their state change while there is one dump_backtrace() trying
to print back trace. Dont we have any lock preventing a task in
this situation (while dumping it's backtrace) from running again
or changing state.

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

Should 'saved_state|sp|fp' instead as its applicable to non-current
tasks only.

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

This does not check any explicit task states like 'un-interruptible' or
'running' but instead tracks change from any previously 'saved' state.


> +			 * state before saving the state, then we may print
> +			 * wrong call trace or end up in infinite while loop
> +			 * if *(fp) and *(fp+8) are same. While the situation

Then dump_backtrace() must detect it, should not save it and just abort.


> +			 * will stop print when that task schedule out.

Thats not a reliable solution. AFICS we should not proceed further if
there is a chance of an wrong trace or an infinite loop. Hoping that
the printing will stop when task gets scheduled out does not seem right.

> +			 */
> +			|| cur_sp != thread_saved_sp(tsk)
> +			|| cur_fp != thread_saved_fp(tsk))) {

Why does any of these three mismatches detect the problematic transition
not just the state ?
