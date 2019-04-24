Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3161C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A5E218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbfDXRKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbfDXRKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:10:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4218730ABABA;
        Wed, 24 Apr 2019 17:10:19 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F2B95D704;
        Wed, 24 Apr 2019 17:10:18 +0000 (UTC)
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
 <20190424070959.GE4038@hirez.programming.kicks-ass.net>
 <51589ac0-3e1f-040e-02bf-b6de77cbda1d@redhat.com>
 <20190424170148.GR12232@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <159efb9b-87df-151f-28df-42407592ea3f@redhat.com>
Date:   Wed, 24 Apr 2019 13:10:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424170148.GR12232@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 24 Apr 2019 17:10:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 1:01 PM, Peter Zijlstra wrote:
> On Wed, Apr 24, 2019 at 12:49:05PM -0400, Waiman Long wrote:
>> On 4/24/19 3:09 AM, Peter Zijlstra wrote:
>>> On Tue, Apr 23, 2019 at 03:12:16PM -0400, Waiman Long wrote:
>>>> That is true in general, but doing preempt_disable/enable across
>>>> function boundary is ugly and prone to further problems down the road.
>>> We do worse things in this code, and the thing Linus proposes is
>>> actually quite simple, something like so:
>>>
>>> ---
>>> --- a/kernel/locking/rwsem.c
>>> +++ b/kernel/locking/rwsem.c
>>> @@ -912,7 +904,7 @@ rwsem_down_read_slowpath(struct rw_semap
>>>  			raw_spin_unlock_irq(&sem->wait_lock);
>>>  			break;
>>>  		}
>>> -		schedule();
>>> +		schedule_preempt_disabled();
>>>  		lockevent_inc(rwsem_sleep_reader);
>>>  	}
>>>  
>>> @@ -1121,6 +1113,7 @@ static struct rw_semaphore *rwsem_downgr
>>>   */
>>>  inline void __down_read(struct rw_semaphore *sem)
>>>  {
>>> +	preempt_disable();
>>>  	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
>>>  			&sem->count) & RWSEM_READ_FAILED_MASK)) {
>>>  		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
>>> @@ -1129,10 +1122,12 @@ inline void __down_read(struct rw_semaph
>>>  	} else {
>>>  		rwsem_set_reader_owned(sem);
>>>  	}
>>> +	preempt_enable();
>>>  }
>>>  
>>>  static inline int __down_read_killable(struct rw_semaphore *sem)
>>>  {
>>> +	preempt_disable();
>>>  	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
>>>  			&sem->count) & RWSEM_READ_FAILED_MASK)) {
>>>  		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
>>> @@ -1142,6 +1137,7 @@ static inline int __down_read_killable(s
>>>  	} else {
>>>  		rwsem_set_reader_owned(sem);
>>>  	}
>>> +	preempt_enable();
>>>  	return 0;
>>>  }
>>>  
>> Making that change will help the slowpath to has less preemption points.
> That doesn't matter, right? Either it blocks or it goes through quickly.
>
> If you're worried about a parituclar spot we can easily put in explicit
> preemption points.
>
>> For an uncontended rwsem, this offers no real benefit. Adding
>> preempt_disable() is more complicated than I originally thought.
> I'm not sure I get your objection?
>
>> Maybe we are too paranoid about the possibility of a large number of
>> preemptions happening just at the right moment. If p is the probably of
>> a preemption in the middle of the inc-check-dec sequence, which I have
>> already moved as close to each other as possible. We are talking a
>> probability of p^32768. Since p will be really small, the compound
>> probability will be infinitesimally small.
> Sure; but we run on many millions of machines every second, so the
> actual accumulated chance of it happening eventually is still fairly
> significant.
>
>> So I would like to not do preemption now for the current patchset. We
>> can restart the discussion later on if there is a real concern that it
>> may actually happen. Please let me know if you still want to add
>> preempt_disable() for the read lock.
> I like provably correct schemes over prayers.


I am fine with adding preempt_disable(). I just want confirmation that
you want to have that.


>
> As you noted, distros don't usually ship with PREEMPT=y and therefore
> will not be bothered much by any of this.
>
> The old scheme basically worked by the fact that the total supported
> reader count was higher than the number of addressable pages in the
> system and therefore the overflow could not happen.
>
> We now transition to number of CPUs, and for that we pay a little price
> with PREEMPT=y kernels. Either that or cmpxchg.

I also thought about switching to a cmpxchg loop for PREEMPT=y kernel.
Let start with just preempt_disable() for now. We can evaluate the
cmpxchg loop alternative later on.

Cheers,
Longman

