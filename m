Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE9CC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B229127B4B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfFCNjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:39:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfFCNjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:39:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1E8215A2;
        Mon,  3 Jun 2019 06:39:21 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 233183F246;
        Mon,  3 Jun 2019 06:39:19 -0700 (PDT)
Subject: Re: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, mojha@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <20190602011253.GA6167@linux.ibm.com>
 <20190603083848.GB3436@hirez.programming.kicks-ass.net>
 <20190603114455.GA16119@lakrids.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ea4887fb-cc77-59d4-3ba7-a59f5237ca40@arm.com>
Date:   Mon, 3 Jun 2019 15:39:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603114455.GA16119@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 1:44 PM, Mark Rutland wrote:
> On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:
>> On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
>>> Scheduling-clock interrupts can arrive late in the CPU-offline process,
>>> after idle entry and the subsequent call to cpuhp_report_idle_dead().
>>> Once execution passes the call to rcu_report_dead(), RCU is ignoring
>>> the CPU, which results in lockdep complaints when the interrupt handler
>>> uses RCU:
>>
>>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>>> index 448efc06bb2d..3b33d83b793d 100644
>>> --- a/kernel/cpu.c
>>> +++ b/kernel/cpu.c
>>> @@ -930,6 +930,7 @@ void cpuhp_report_idle_dead(void)
>>>   	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>>>   
>>>   	BUG_ON(st->state != CPUHP_AP_OFFLINE);
>>> +	local_irq_disable();
>>>   	rcu_report_dead(smp_processor_id());
>>>   	st->state = CPUHP_AP_IDLE_DEAD;
>>>   	udelay(1000);
>>
>> Urgh... I'd almost suggest we do something like the below.
>>
>>
>> But then I started looking at the various arch_cpu_idle_dead()
>> implementations and ran into arm's implementation, which is calling
>> complete() where generic code already established this isn't possible
>> (see for example cpuhp_report_idle_dead()).
> 
> IIRC, that should have been migrated over to cpu_report_death(), as
> arm64 was in commit:
> 
>    05981277a4de1ad6 ("arm64: Use common outgoing-CPU-notification code")
> 
> ... but it looks like Paul's patch to do so [1] fell through the cracks;
> I'm not aware of any reason that shouldn't have been taken.
>    
> [1] https://lore.kernel.org/lkml/1431467407-1223-8-git-send-email-paulmck@linux.vnet.ibm.com/
> 
> Paul, do you want to resend that?

Please do. We're carrying this patch out-of-tree for while now in our 
EAS integration to get cpu hotplug tests passing on TC2 (arm).

-- Dietmar
