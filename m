Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45347C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B9520663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfDQSrK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbfDQSrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 499B27E459;
        Wed, 17 Apr 2019 18:47:09 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29895608C2;
        Wed, 17 Apr 2019 18:47:08 +0000 (UTC)
Subject: Re: [PATCH v4 09/16] locking/rwsem: Ensure an RT task will not spin
 on reader
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-10-longman@redhat.com>
 <20190417131841.GF4038@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <1c37b8f2-232e-7ced-0483-31c8c6a4ffd1@redhat.com>
Date:   Wed, 17 Apr 2019 14:47:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190417131841.GF4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 17 Apr 2019 18:47:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2019 09:18 AM, Peter Zijlstra wrote:
> On Sat, Apr 13, 2019 at 01:22:52PM -0400, Waiman Long wrote:
>> An RT task can do optimistic spinning only if the lock holder is
>> actually running. If the state of the lock holder isn't known, there
>> is a possibility that high priority of the RT task may block forward
>> progress of the lock holder if it happens to reside on the same CPU.
>> This will lead to deadlock. So we have to make sure that an RT task
>> will not spin on a reader-owned rwsem.
>>
>> When the owner is temporarily set to NULL, it is more tricky to decide
>> if an RT task should stop spinning as it may be a temporary state
>> where another writer may have just stolen the lock which then failed
>> the task's trylock attempt. So one more retry is allowed to make sure
>> that the lock is not spinnable by an RT task.
>>
>> When testing on a 8-socket IvyBridge-EX system, the one additional retry
>> seems to improve locking performance of RT write locking threads under
>> heavy contentions. The table below shows the locking rates (in kops/s)
>> with various write locking threads before and after the patch.
>>
>>     Locking threads     Pre-patch     Post-patch
>>     ---------------     ---------     -----------
>>             4             2,753          2,608
>>             8             2,529          2,520
>>            16             1,727          1,918
>>            32             1,263          1,956
>>            64               889          1,343
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/locking/rwsem.c | 36 +++++++++++++++++++++++++++++-------
>>  1 file changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 2d6850c3e77b..8e19b5141595 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -539,6 +539,8 @@ static noinline enum owner_state rwsem_spin_on_owner(struct rw_semaphore *sem)
>>  static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>>  {
>>  	bool taken = false;
>> +	bool is_rt_task = rt_task(current);
> Arguably this is wrong; a remote CPU could change the scheduling
> atributes of this task while it is spinning. In practise I don't think
> we do that without forcing a reschedule, but in theory we could if we
> find the task is current anyway.

Will move the check back to the main loop.

>> +	int prev_owner_state = OWNER_NULL;
>>  
>>  	preempt_disable();
>>  
>> @@ -556,7 +558,12 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>>  	 *  2) readers own the lock as we can't determine if they are
>>  	 *     actively running or not.
>>  	 */
>> -	while (rwsem_spin_on_owner(sem) & OWNER_SPINNABLE) {
>> +	for (;;) {
>> +		enum owner_state owner_state = rwsem_spin_on_owner(sem);
>> +
>> +		if (!(owner_state & OWNER_SPINNABLE))
>> +			break;
>> +
>>  		/*
>>  		 * Try to acquire the lock
>>  		 */
>> @@ -566,13 +573,28 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>>  		}
>>  
>>  		/*
>> -		 * When there's no owner, we might have preempted between the
>> -		 * owner acquiring the lock and setting the owner field. If
>> -		 * we're an RT task that will live-lock because we won't let
>> -		 * the owner complete.
>> +		 * An RT task cannot do optimistic spinning if it cannot
>> +		 * be sure the lock holder is running or live-lock may
>> +		 * happen if the current task and the lock holder happen
>> +		 * to run in the same CPU.
>> +		 *
>> +		 * When there's no owner or is reader-owned, an RT task
>> +		 * will stop spinning if the owner state is not a writer
>> +		 * at the previous iteration of the loop. This allows the
>> +		 * RT task to recheck if the task that steals the lock is
>> +		 * a spinnable writer. If so, it can keeps on spinning.
>> +		 *
>> +		 * If the owner is a writer, the need_resched() check is
>> +		 * done inside rwsem_spin_on_owner(). If the owner is not
>> +		 * a writer, need_resched() check needs to be done here.
>>  		 */
>> -		if (!sem->owner && (need_resched() || rt_task(current)))
>> -			break;
>> +		if (owner_state != OWNER_WRITER) {
>> +			if (need_resched())
>> +				break;
>> +			if (is_rt_task && (prev_owner_state != OWNER_WRITER))
>> +				break;
>> +		}
>> +		prev_owner_state = owner_state;
>>  
>>  		/*
>>  		 * The cpu_relax() call is a compiler barrier which forces
> This patch confuses me mightily. I mean, I see what it does, but I can't
> figure out why. The Changelog is just one big source of confusion.

Sorry for confusing you. If count and owner are separate, there is a
time lag where the owner is NULL, but the lock is not free yet.
Similarly, the lock could be free but another task may have stolen the
lock if the waiter bit isn't set. In the former case, an extra iteration
gives it more time for the lock holder to release the lock. In the
latter case, if the new lock owner is a writer and set owner in time,
the RT task can keep on spinning. Will clarify that in the commit log
and the comment.

Cheers,
Longman

