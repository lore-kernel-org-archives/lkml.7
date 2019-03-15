Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0953EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB15D21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfCOHpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:45:24 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:52677 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfCOHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:45:24 -0400
X-Greylist: delayed 794 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2019 03:45:23 EDT
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 15 Mar 2019 16:45:21 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO ?10.177.222.33?) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 15 Mar 2019 16:45:20 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        rostedt@goodmis.org, luto@kernel.org, kernel-team@lge.com
References: <20180829222021.GA29944@linux.vnet.ibm.com>
 <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
 <20190311133939.GA29747@google.com> <20190315073138.GB15148@X58A-UD3R>
Message-ID: <eea72fb5-c25d-746a-fa48-6d04c8d5d1af@lge.com>
Date:   Fri, 15 Mar 2019 16:44:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190315073138.GB15148@X58A-UD3R>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2019 04:31 PM, Byungchul Park wrote:
> On Mon, Mar 11, 2019 at 09:39:39AM -0400, Joel Fernandes wrote:
>> On Wed, Aug 29, 2018 at 03:20:34PM -0700, Paul E. McKenney wrote:
>>> RCU's dyntick-idle code is written to tolerate half-interrupts, that it,
>>> either an interrupt that invokes rcu_irq_enter() but never invokes the
>>> corresponding rcu_irq_exit() on the one hand, or an interrupt that never
>>> invokes rcu_irq_enter() but does invoke the "corresponding" rcu_irq_exit()
>>> on the other.  These things really did happen at one time, as evidenced
>>> by this ca-2011 LKML post:
>>>
>>> http://lkml.kernel.org/r/20111014170019.GE2428@linux.vnet.ibm.com
>>>
>>> The reason why RCU tolerates half-interrupts is that usermode helpers
>>> used exceptions to invoke a system call from within the kernel such that
>>> the system call did a normal return (not a return from exception) to
>>> the calling context.  This caused rcu_irq_enter() to be invoked without
>>> a matching rcu_irq_exit().  However, usermode helpers have since been
>>> rewritten to make much more housebroken use of workqueues, kernel threads,
>>> and do_execve(), and therefore should no longer produce half-interrupts.
>>> No one knows of any other source of half-interrupts, but then again,
>>> no one seems insane enough to go audit the entire kernel to verify that
>>> half-interrupts really are a relic of the past.
>>>
>>> This commit therefore adds a pair of WARN_ON_ONCE() calls that will
>>> trigger in the presence of half interrupts, which the code will continue
>>> to handle correctly.  If neither of these WARN_ON_ONCE() trigger by
>>> mid-2021, then perhaps RCU can stop handling half-interrupts, which
>>> would be a considerable simplification.
>> Hi Paul and everyone,
>> I was thinking some more about this patch and whether we can simplify this code
>> much in 2021. Since 2021 is a bit far away, I thought working on it in again to
>> keep it fresh in memory is a good idea ;-)
>>
>> To me it seems we cannot easily combine the counters (dynticks_nesting and
>> dynticks_nmi_nesting) even if we confirmed that there is no possibility of a
>> half-interrupt scenario (assuming simplication means counter combining like
>> Byungchul tried to do in https://goo.gl/X1U77X). The reason is because these
>> 2 counters need to be tracked separately as they are used differently in the
>> following function:
> Hi Joel and Paul,
>
> I always love the way to logically approach problems so I'm a fan of
> all your works :) But I'm JUST curious about something here. Why can't
> we combine them the way I tried even if we confirm no possibility of
> half-interrupt? IMHO, the only thing we want to know through calling
> rcu_is_cpu_rrupt_from_idle() is whether the interrupt comes from
> RCU-idle or not - of course assuming the caller context always be an
> well-defined interrupt context like e.g. the tick handler.
>
> So the function can return true if the caller is within a RCU-idle
> region except a well-known single interrupt nested.
>
> Of course, now that we cannot confirm it yet, the crowbar is necessary.
> But does it still have a problem even after confirming it? Why? What am
> I missing? Could you explain why for me? :(


Did you also want to consider the case the function is called from 
others than
well-known interrupt contexts? If yes, then I agree with you, there doesn't
seem to be the kind of code and it's not a good idea to let the function be
called generally though.


> Thanks,
> Byungchul
>
>> static int rcu_is_cpu_rrupt_from_idle(void)
>> {
>>          return __this_cpu_read(rcu_data.dynticks_nesting) <= 0 &&
>>                 __this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 1;
>> }
>>
>> dynticks_nesting actually tracks if we entered/exited idle or user mode.
>>
>> dynticks_nmi_nesting tracks if we entered/exited interrupts.
>>
>> We have to do the "dynticks_nmi_nesting <= 1" check because
>> rcu_is_cpu_rrupt_from_idle() can possibly be called from an interrupt itself
>> (like timer) so we discount 1 interrupt, and, the "dynticks_nesting <= 0"
>> check is because the CPU MUST be in user or idle for the check to return
>> true. We can't really combine these two into one counter then I think because
>> they both convey different messages.
>>
>> The only simplication we can do, is probably the "crowbar" updates to
>> dynticks_nmi_nesting can be removed from rcu_eqs_enter/exit once we confirm
>> no more half-interrupts are possible. Which might still be a worthwhile thing
>> to do (while still keeping both counters separate).
>>
>> However, I think we could combine the counters and lead to simplying the code
>> in case we implement rcu_is_cpu_rrupt_from_idle differently such that it does
>> not need the counters but NOHZ_FULL may take issue with that since it needs
>> rcu_user_enter->rcu_eqs_enter to convey that the CPU is "RCU"-idle.
>>
>> Actually, I had another question... rcu_user_enter() is a NOOP in !NOHZ_FULL config.
>> In this case I was wondering if the the warning Paul added (in the patch I'm replying to)
>> will really get fired for half-interrupts. The vast majority of the systems I believe are
>> NOHZ_IDLE not NOHZ_FULL.
>> This is what a half-interrupt really looks like right? Please correct me if I'm wrong:
>> rcu_irq_enter()   [half interrupt causes an exception and thus rcu_irq_enter]
>> rcu_user_enter()  [due to usermode upcall]
>> rcu_user_exit()
>> (no more rcu_irq_exit() - hence half an interrupt)
>>
>> But the rcu_user_enter()/exit is a NOOP in some configs, so will the warning in
>> rcu_eqs_e{xit,nter} really do anything?
>>
>> Or was the idea with adding the new warnings, that they would fire the next
>> time rcu_idle_enter/exit is called? Like for example:
>>
>> rcu_irq_enter()   [This is due to half-interrupt]
>> rcu_idle_enter()  [Eventually we enter the idle loop at some point
>> 		   after the half-interrupt and the rcu_eqs_enter()
>> 		   would "crowbar" the dynticks_nmi_nesting counter to 0].
>>
>> thanks!
>>
>>   - Joel
>>
>>> Reported-by: Steven Rostedt <rostedt@goodmis.org>
>>> Reported-by: Joel Fernandes <joel@joelfernandes.org>
>>> Reported-by: Andy Lutomirski <luto@kernel.org>
>>> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>> ---
>>>   kernel/rcu/tree.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index dc041c2afbcc..d2b6ade692c9 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -714,6 +714,7 @@ static void rcu_eqs_enter(bool user)
>>>   	struct rcu_dynticks *rdtp;
>>>   
>>>   	rdtp = this_cpu_ptr(&rcu_dynticks);
>>> +	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
>>>   	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0);
>>>   	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>>>   		     rdtp->dynticks_nesting == 0);
>>> @@ -895,6 +896,7 @@ static void rcu_eqs_exit(bool user)
>>>   	trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
>>>   	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>>>   	WRITE_ONCE(rdtp->dynticks_nesting, 1);
>>> +	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting);
>>>   	WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
>>>   }
>>>   
>>> -- 
>>> 2.17.1
>>>

