Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A5FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBB8243B9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dA7r1dbR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EWoJsHuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfE3Bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:38:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41026 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Bit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:38:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50B72604D4; Thu, 30 May 2019 01:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559180328;
        bh=9juO5+fk3lH9CoK/+q+jiu9YWLxmL6m/v8Ar/h/6rRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dA7r1dbR/WcRSYiIEupp6qAHJNrsO95trsbyZTmmzxUsb8Zo0gbeFDSUij5OG2jcX
         +1C4X2XuvcOhWEHoyDQ4e5R6UdBMAUBAx4IHqLKW/znZiORjtMFrdNaH9YygULN8CS
         DL1HkCgLNBzw6azTg5cbNpIiWhXmcOYGe6yti4P0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2DC1B6063A;
        Thu, 30 May 2019 01:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559180327;
        bh=9juO5+fk3lH9CoK/+q+jiu9YWLxmL6m/v8Ar/h/6rRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EWoJsHuymdmKG5M3HXyjC7hFxN7Rb1p2YIhzDx8Mr+c7U2YS4wjOQ3lyeEui+LkV7
         CAZllBM/koJNZi5ewZ0/sW4PUD2WUSJrtMpLq2XHEw9yJ9XPipzmgHX4+u9xtSvkcZ
         udBChGzm9WkNhKVmIfvPoXviQQge/MEFO/cEmUj4=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 30 May 2019 09:38:47 +0800
From:   tengfeif@codeaurora.org
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tengfei@codeaurora.org
Subject: Re: [PATCH] arm64: break while loop if task had been rescheduled
In-Reply-To: <f2d62227-4694-d973-cacc-8225e2b2baf4@arm.com>
References: <1558430404-4840-1-git-send-email-tengfeif@codeaurora.org>
 <f2d62227-4694-d973-cacc-8225e2b2baf4@arm.com>
Message-ID: <253affe7493cb9689e224d74aa182765@codeaurora.org>
X-Sender: tengfeif@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-22 17:04, Anshuman Khandual wrote:
> On 05/21/2019 02:50 PM, Tengfei Fan wrote:
>> While printing a task's backtrace and this task isn't
>> current task, it is possible that task's fp and fp+8
>> have the same value, so cannot break the while loop.
>> This can break while loop if this task had been
>> rescheduled during print this task's backtrace.
> 
> This is very confusing. IIUC it suggests that while printing
> the backtrace for non-current tasks the do/while loop does not
> exit because fp and fp+8 might have the same value ? When would
> this happen ? Even in that case the commit message here does not
> properly match the change in this patch.

In our issue, we got fp=pc=0xFFFFFF8025A13BA0, so cannot exit while
loop in dump_basktrace().
After analyze our issue's dump, we found one task(such as: task A)
is exiting via invoke do_exit() during another task is showing task
A's dumptask. In kernel code, do_exit() and exit_notify are defined
as follows:
void noreturn do_exit(long code)
{
      ......
      exit_notify(tsk, group_dead);
      ......
}
static void exit_notify(struct task_struct *tsk, int group_dead)
{
      ......
}
Because of exit_notify() is a static function, so it is inlined to
do_exit() when compile kernel, so we can get partial assembly code
of do_exit() as follows:
……
{
         bool autoreap;
         struct task_struct *p, *n;
         LIST_HEAD(dead);

         write_lock_irq(&tasklist_lock);
      c10:       90000000        adrp    x0, 0 <tasklist_lock>
      c14:       910003e8        mov     x8, sp
      c18:       91000000        add     x0, x0, #0x0
*/
static void exit_notify(struct task_struct *tsk, int group_dead)
{
         bool autoreap;
         struct task_struct *p, *n;
         LIST_HEAD(dead);
      c1c:       a90023e8        stp     x8, x8, [sp]

         write_lock_irq(&tasklist_lock);
      c20:       94000000        bl      0 <_raw_write_lock_irq>
      c24:       f9435268        ldr     x8, [x19,#1696]
……
 From the code "c14:" and "c1c:", we will find sp's addr value is stored
in sp and sp+8, so sp's vaule equal (sp+8)'s value.
In our issue, there is a chance of fp point sp, so there will be 
fp=pc=fp's
addr value,so code cannot break from while loop in dump_backtrace().

> 
> This patch tries to stop printing the stack for non-current tasks
> if their state change while there is one dump_backtrace() trying
> to print back trace. Dont we have any lock preventing a task in
> this situation (while dumping it's backtrace) from running again
> or changing state.

I haven't found any lock preventing a task in this situation, and I 
think we shouldn't
prevent task running if this task is scheduled.
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
> 
> Should 'saved_state|sp|fp' instead as its applicable to non-current
> tasks only.

'saved_state|sp|fp' only applies to non-current tasks.

> 
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
>> +			 * that has changed state from "saved" state to other
>> +			 * state before hitting the do-while loop but after
>> +			 * saving the current state. If task's current state
> 
> This does not check any explicit task states like 'un-interruptible' or
> 'running' but instead tracks change from any previously 'saved' state.

have updated comments.
> 
> 
>> +			 * not equal the "saved" state, then we may print
>> +			 * wrong call trace or end up in infinite while loop
>> +			 * if *(fp) and *(fp+8) are same. While the situation
> 
> Then dump_backtrace() must detect it, should not save it and just 
> abort.

have updatd commentes.
> 
> 
>> +			 * should be stoped once we found the task's state
    +			 * is changed, so we detect the task's current state,
    +			 * sp and fp in each while.
> 
> Thats not a reliable solution. AFICS we should not proceed further if
> there is a chance of an wrong trace or an infinite loop. Hoping that
> the printing will stop when task gets scheduled out does not seem 
> right.

In this patch, it will break while loop and stop to print backtrace if 
we
find the task's state change or there is a chance of an infinite loop.
> 
>> +			 */
>> +			|| cur_sp != thread_saved_sp(tsk)
>> +			|| cur_fp != thread_saved_fp(tsk))) {
> 
> Why does any of these three mismatches detect the problematic 
> transition
> not just the state ?

1. we can use "cur_state != tsk->state" prevent printing backtrace if 
the task's
    state is changed after "saved" task's state.
2. we can use "cur_sp != thread_saved_sp(tsk)" and "cur_fp != 
thread_saved_fp(tsk)"
    prevent printing backtrace if the task's state is changed before 
"saved" task's
    state. Because the value of "thread_saved_sp(tsk)" and 
"thread_saved_fp(tsk)"
    will not equal "saved" sp(cur_sp) and fp(cur_fp).
