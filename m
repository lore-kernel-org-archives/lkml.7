Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB20C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0199242E4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e7IC8g7j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UIhRzLqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfE3ClN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:41:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfE3ClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:41:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A667604D4; Thu, 30 May 2019 02:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559184072;
        bh=KZzN8mKGdKvkpGucs4JphPlo8n4hbN/Gg9urLIAqbEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e7IC8g7jbEZyR+Oy5Cm7ksMUi1pUaG272SUfx/BrYxsoB8zBP32jJTpGY+o1dHHwU
         uzF7hy0dmzcIdUNf23Qvv9LZLKvVTXzdTaYdMFJUwm9TF7j9KxIa+h2rOUUMY9BHv5
         2NBkurXSfWtu9LjP6f2HytphCOQxLOvd/VaKdkKI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 973AD604D4;
        Thu, 30 May 2019 02:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559184071;
        bh=KZzN8mKGdKvkpGucs4JphPlo8n4hbN/Gg9urLIAqbEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UIhRzLqN0mLLoPvzy2/rp0Vg6yv0YHzt4vL33AmZl1rDVmProV9LOCUm21CUs2Xp8
         otrP0LuFQLkcNW/hqQwsDT5WH152PerZEaXcNYrBeTHyulj0zamuhooukp10Q/+Dz0
         2inymFXuNAeNo49NrIZz0B1JyyeSCvC4vJZjN+FQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 May 2019 10:41:11 +0800
From:   tengfeif@codeaurora.org
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        anshuman.khandual@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tengfei@codeaurora.org
Subject: Re: [PATCH] arm64: break while loop if task had been rescheduled
In-Reply-To: <20190524104148.GB12796@lakrids.cambridge.arm.com>
References: <1558430404-4840-1-git-send-email-tengfeif@codeaurora.org>
 <20190524104148.GB12796@lakrids.cambridge.arm.com>
Message-ID: <665641d42e21da3466693ac49ac5d40e@codeaurora.org>
X-Sender: tengfeif@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-24 18:41, Mark Rutland wrote:
> On Tue, May 21, 2019 at 05:20:04PM +0800, Tengfei Fan wrote:
>> While printing a task's backtrace and this task isn't
>> current task, it is possible that task's fp and fp+8
>> have the same value, so cannot break the while loop.
>> This can break while loop if this task had been
>> rescheduled during print this task's backtrace.
> 
> There are a few cases where backtracing can get stuck in an infinite
> loop. I'd attempted to address that more generally in my
> arm64/robust-stacktrace branch [1].
> 
> Looking at tsk->state here is inherently racy, and doesn't solve the
> general case, so I'd prefer to avoid that.
> 
> Do my patches help you here? If so, I'm happy to rebase those to
> v5.2-rc1 and repost.

I think your arm64/robust-stacktrace branch [1] can cover my issue, 
please
rebase and reposet

Thanks,
Tengfei Fan

> 
> Thanks,
> Mark.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/robust-stacktrace
> 
>> 
>> Signed-off-by: Tengfei Fan <tengfeif@codeaurora.org>
>> ---
>>  arch/arm64/kernel/traps.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>> 
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 2975598..9df6e02 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -103,6 +103,9 @@ void dump_backtrace(struct pt_regs *regs, struct 
>> task_struct *tsk)
>>  {
>>  	struct stackframe frame;
>>  	int skip = 0;
>> +	long cur_state = 0;
>> +	unsigned long cur_sp = 0;
>> +	unsigned long cur_fp = 0;
>> 
>>  	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
>> 
>> @@ -127,6 +130,9 @@ void dump_backtrace(struct pt_regs *regs, struct 
>> task_struct *tsk)
>>  		 */
>>  		frame.fp = thread_saved_fp(tsk);
>>  		frame.pc = thread_saved_pc(tsk);
>> +		cur_state = tsk->state;
>> +		cur_sp = thread_saved_sp(tsk);
>> +		cur_fp = frame.fp;
>>  	}
>>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>>  	frame.graph = 0;
>> @@ -134,6 +140,23 @@ void dump_backtrace(struct pt_regs *regs, struct 
>> task_struct *tsk)
>> 
>>  	printk("Call trace:\n");
>>  	do {
>> +		if (tsk != current && (cur_state != tsk->state
>> +			/*
>> +			 * We would not be printing backtrace for the task
>> +			 * that has changed state from uninterruptible to
>> +			 * running before hitting the do-while loop but after
>> +			 * saving the current state. If task is in running
>> +			 * state before saving the state, then we may print
>> +			 * wrong call trace or end up in infinite while loop
>> +			 * if *(fp) and *(fp+8) are same. While the situation
>> +			 * will stop print when that task schedule out.
>> +			 */
>> +			|| cur_sp != thread_saved_sp(tsk)
>> +			|| cur_fp != thread_saved_fp(tsk))) {
>> +			printk("The task:%s had been rescheduled!\n",
>> +				tsk->comm);
>> +			break;
>> +		}
>>  		/* skip until specified stack frame */
>>  		if (!skip) {
>>  			dump_backtrace_entry(frame.pc);
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
