Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE8220651
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfDRPPg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRPPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:15:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7167307E059;
        Thu, 18 Apr 2019 15:15:34 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B20695D9C5;
        Thu, 18 Apr 2019 15:15:33 +0000 (UTC)
Subject: Re: [PATCH v4 12/16] locking/rwsem: Enable time-based spinning on
 reader-owned rwsem
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-13-longman@redhat.com>
 <20190418130611.GK4038@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <52aee7c3-b8aa-a617-c1f2-34bc99c72474@redhat.com>
Date:   Thu, 18 Apr 2019 11:15:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190418130611.GK4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 18 Apr 2019 15:15:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2019 09:06 AM, Peter Zijlstra wrote:
> So I really dislike time based spinning, and we've always rejected it
> before.
>
> On Sat, Apr 13, 2019 at 01:22:55PM -0400, Waiman Long wrote:
>
>> +static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
>> +{
>> +	long count = atomic_long_read(&sem->count);
>> +	int reader_cnt = atomic_long_read(&sem->count) >> RWSEM_READER_SHIFT;
>> +
>> +	if (reader_cnt > 30)
>> +		reader_cnt = 30;
>> +	return sched_clock() + ((count & RWSEM_FLAG_WAITERS)
>> +		? 10 * NSEC_PER_USEC + reader_cnt * NSEC_PER_USEC/2
>> +		: 25 * NSEC_PER_USEC);
>> +}
> Urgh, why do you _have_ to write unreadable code :-(

I guess my code writing style is less readable to others. I will try to
write simpler code that will be more readable in the future :-)

>
> static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
> {
> 	long count = atomic_long_read(&sem->count);
> 	u64 delta = 25 * NSEC_PER_USEC;
>
> 	if (count & RWSEM_FLAG_WAITERS) {
> 		int readers = count >> RWSEM_READER_SHIFT;
>
> 		if (readers > 30)
> 			readers = 30;
>
> 		delta = (20 + readers) * NSEC_PER_USEC / 2;
> 	}
>
> 	return sched_clock() + delta;
> }
>
> I don't get it though; the number of current read-owners is independent
> of WAITERS, while the hold time does correspond to it.
>
> So why do we have that WAITERS check in there?

It is not a waiter check, it is checking the number of readers that are
holding the lock. My thinking was that in the wakeup process done by
__rwsem_mark_wake(), the wakeup is done one-by-one. So the more readers
you have, the more time it takes for the last reader to actually wake up
and run its critical section. That is the main reason for that logic.

>
>> @@ -616,6 +678,35 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
>>  		if (taken)
>>  			break;
>>  
>> +		/*
>> +		 * Time-based reader-owned rwsem optimistic spinning
>> +		 */
> This relies on rwsem_spin_on_owner() not actually spinning for
> read-owned.
>

Yes, because there is no task structure to spin on.

>> +		if (wlock && (owner_state == OWNER_READER)) {
>> +			/*
>> +			 * Initialize rspin_threshold when the owner
>> +			 * state changes from non-reader to reader.
>> +			 */
>> +			if (prev_owner_state != OWNER_READER) {
>> +				if (!is_rwsem_spinnable(sem))
>> +					break;
>> +				rspin_threshold = rwsem_rspin_threshold(sem);
>> +				loop = 0;
>> +			}
> This seems fragile, why not to the rspin_threshold thing _once_ at the
> start of this function?
>
> This way it can be reset.

You can have a situation as follows:

Lock owner: R [W] R

So a writer comes in and get the lock before the spinner. You can then
actually spin on that writer. After that a reader come in and steal the
lock, the code above will allows us to reset the timeout period for the
new reader phase.

>> +			/*
>> +			 * Check time threshold every 16 iterations to
>> +			 * avoid calling sched_clock() too frequently.
>> +			 * This will make the actual spinning time a
>> +			 * bit more than that specified in the threshold.
>> +			 */
>> +			else if (!(++loop & 0xf) &&
>> +				 (sched_clock() > rspin_threshold)) {
> Why is calling sched_clock() lots a problem?

Actually I am more concern about the latency introduced by the
sched_clock() call. BTW, I haven't done any measurement myself. Do you
know how much cost the sched_clock() call is?

If the cost is relatively high, the average latency period after the
lock is free and the spinner is ready to do a trylock will increase.

Cheers,
Longman

