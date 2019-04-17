Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEFFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED14217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbfDQQjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbfDQQjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A48463001C93;
        Wed, 17 Apr 2019 16:39:20 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98EA01001E8D;
        Wed, 17 Apr 2019 16:39:19 +0000 (UTC)
Subject: Re: [PATCH v4 07/16] locking/rwsem: Implement lock handoff to prevent
 lock starvation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-8-longman@redhat.com>
 <20190416154937.GL12232@hirez.programming.kicks-ass.net>
 <d10586ae-cd86-2992-766b-1ba4a4807b6a@redhat.com>
 <20190417080549.GA4038@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <5c869d39-571e-11cb-e9eb-5d785562bfd1@redhat.com>
Date:   Wed, 17 Apr 2019 12:39:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190417080549.GA4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 17 Apr 2019 16:39:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2019 04:05 AM, Peter Zijlstra wrote:
> On Tue, Apr 16, 2019 at 02:16:11PM -0400, Waiman Long wrote:
>
>>>> @@ -608,56 +687,63 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
>>>>  	 */
>>>>  	waiter.task = current;
>>>>  	waiter.type = RWSEM_WAITING_FOR_WRITE;
>>>> +	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>>>>  
>>>>  	raw_spin_lock_irq(&sem->wait_lock);
>>>>  
>>>>  	/* account for this before adding a new element to the list */
>>>> +	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
>>>>  
>>>>  	list_add_tail(&waiter.list, &sem->wait_list);
>>>>  
>>>>  	/* we're now waiting on the lock */
>>>> +	if (wstate == WRITER_NOT_FIRST) {
>>>>  		count = atomic_long_read(&sem->count);
>>>>  
>>>>  		/*
>>>> +		 * If there were already threads queued before us and:
>>>> +		 *  1) there are no no active locks, wake the front
>>>> +		 *     queued process(es) as the handoff bit might be set.
>>>> +		 *  2) there are no active writers and some readers, the lock
>>>> +		 *     must be read owned; so we try to wake any read lock
>>>> +		 *     waiters that were queued ahead of us.
>>>>  		 */
>>>> +		if (!RWSEM_COUNT_LOCKED(count))
>>>> +			__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>>>> +		else if (!(count & RWSEM_WRITER_MASK) &&
>>>> +			  (count & RWSEM_READER_MASK))
>>>>  			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
>>> Does the above want to be something like:
>>>
>>> 		if (!(count & RWSEM_WRITER_LOCKED)) {
>>> 			__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK) ?
>>> 					       RWSEM_WAKE_READERS :
>>> 					       RWSEM_WAKE_ANY, &wake_q);
>>> 		}
>> Yes.
>>
>>>> +		else
>>>> +			goto wait;
>>>>  
>>>> +		/*
>>>> +		 * The wakeup is normally called _after_ the wait_lock
>>>> +		 * is released, but given that we are proactively waking
>>>> +		 * readers we can deal with the wake_q overhead as it is
>>>> +		 * similar to releasing and taking the wait_lock again
>>>> +		 * for attempting rwsem_try_write_lock().
>>>> +		 */
>>>> +		wake_up_q(&wake_q);
>>> Hurmph.. the reason we do wake_up_q() outside of wait_lock is such that
>>> those tasks don't bounce on wait_lock. Also, it removes a great deal of
>>> hold-time from wait_lock.
>>>
>>> So I'm not sure I buy your argument here.
>>>
>> Actually, we don't want to release the wait_lock, do wake_up_q() and
>> acquire the wait_lock again as the state would have been changed. I
>> didn't change the comment on this patch, but will reword it to discuss that.
> I don't understand, we've queued ourselves, we're on the list, we're not
> first. How would dropping the lock to try and kick waiters before us be
> a problem?
>
> Sure, once we re-acquire the lock we have to re-avaluate @wstate to see
> if we're first now or not, but we need to do that anyway.
>
> So what is wrong with the below?
>
> --- a/include/linux/sched/wake_q.h
> +++ b/include/linux/sched/wake_q.h
> @@ -51,6 +51,11 @@ static inline void wake_q_init(struct wa
>  	head->lastp = &head->first;
>  }
>  
> +static inline bool wake_q_empty(struct wake_q_head *head)
> +{
> +	return head->first == WAKE_Q_TAIL;
> +}
> +
>  extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
>  extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
>  extern void wake_up_q(struct wake_q_head *head);
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -700,25 +700,22 @@ __rwsem_down_write_failed_common(struct
>  		 *     must be read owned; so we try to wake any read lock
>  		 *     waiters that were queued ahead of us.
>  		 */
> -		if (!(count & RWSEM_LOCKED_MASK))
> -			__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
> -		else if (!(count & RWSEM_WRITER_MASK) &&
> -				(count & RWSEM_READER_MASK))
> -			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
> -		else
> +		if (count & RWSEM_WRITER_LOCKED)
>  			goto wait;
> -		/*
> -		 * The wakeup is normally called _after_ the wait_lock
> -		 * is released, but given that we are proactively waking
> -		 * readers we can deal with the wake_q overhead as it is
> -		 * similar to releasing and taking the wait_lock again
> -		 * for attempting rwsem_try_write_lock().
> -		 */
> -		wake_up_q(&wake_q);
> -		/*
> -		 * Reinitialize wake_q after use.
> -		 */
> -		wake_q_init(&wake_q);
> +
> +		__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK) ?
> +				RWSEM_WAKE_READERS :
> +				RWSEM_WAKE_ANY, &wake_q);
> +
> +		if (!wake_q_empty(&wake_q)) {
> +			raw_spin_unlock_irq(&sem->wait_lock);
> +			wake_up_q(&wake_q);
> +			/* used again, reinit */
> +			wake_q_init(&wake_q);
> +			raw_spin_lock_irq(&sem->wait_lock);
> +			if (rwsem_waiter_is_first(sem, &waiter))
> +				wstate = WRITER_FIRST;
> +		}
>  	} else {
>  		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
>  	}

Yes, we can certainly do that. My point is that I haven't changed the
existing logic regarding that wakeup, I only move it around in the
patch. As it is not related to lock handoff, we can do it as a separate
patch.

Cheers,
Longman

