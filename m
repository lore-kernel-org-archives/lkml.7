Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B15AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F91C20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfDPSQP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:16:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfDPSQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7678189C31;
        Tue, 16 Apr 2019 18:16:13 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4910B608A4;
        Tue, 16 Apr 2019 18:16:12 +0000 (UTC)
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
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFgsZGsBEAC3l/RVYISY3M0SznCZOv8aWc/bsAgif1H8h0WPDrHnwt1jfFTB26EzhRea
 XQKAJiZbjnTotxXq1JVaWxJcNJL7crruYeFdv7WUJqJzFgHnNM/upZuGsDIJHyqBHWK5X9ZO
 jRyfqV/i3Ll7VIZobcRLbTfEJgyLTAHn2Ipcpt8mRg2cck2sC9+RMi45Epweu7pKjfrF8JUY
 r71uif2ThpN8vGpn+FKbERFt4hW2dV/3awVckxxHXNrQYIB3I/G6mUdEZ9yrVrAfLw5M3fVU
 CRnC6fbroC6/ztD40lyTQWbCqGERVEwHFYYoxrcGa8AzMXN9CN7bleHmKZrGxDFWbg4877zX
 0YaLRypme4K0ULbnNVRQcSZ9UalTvAzjpyWnlnXCLnFjzhV7qsjozloLTkZjyHimSc3yllH7
 VvP/lGHnqUk7xDymgRHNNn0wWPuOpR97J/r7V1mSMZlni/FVTQTRu87aQRYu3nKhcNJ47TGY
 evz/U0ltaZEU41t7WGBnC7RlxYtdXziEn5fC8b1JfqiP0OJVQfdIMVIbEw1turVouTovUA39
 Qqa6Pd1oYTw+Bdm1tkx7di73qB3x4pJoC8ZRfEmPqSpmu42sijWSBUgYJwsziTW2SBi4hRjU
 h/Tm0NuU1/R1bgv/EzoXjgOM4ZlSu6Pv7ICpELdWSrvkXJIuIwARAQABzR9Mb25nbWFuIExv
 bmcgPGxsb25nQHJlZGhhdC5jb20+wsF/BBMBAgApBQJYLGRrAhsjBQkJZgGABwsJCAcDAgEG
 FQgCCQoLBBYCAwECHgECF4AACgkQbjBXZE7vHeYwBA//ZYxi4I/4KVrqc6oodVfwPnOVxvyY
 oKZGPXZXAa3swtPGmRFc8kGyIMZpVTqGJYGD9ZDezxpWIkVQDnKM9zw/qGarUVKzElGHcuFN
 ddtwX64yxDhA+3Og8MTy8+8ZucM4oNsbM9Dx171bFnHjWSka8o6qhK5siBAf9WXcPNogUk4S
 fMNYKxexcUayv750GK5E8RouG0DrjtIMYVJwu+p3X1bRHHDoieVfE1i380YydPd7mXa7FrRl
 7unTlrxUyJSiBc83HgKCdFC8+ggmRVisbs+1clMsK++ehz08dmGlbQD8Fv2VK5KR2+QXYLU0
 rRQjXk/gJ8wcMasuUcywnj8dqqO3kIS1EfshrfR/xCNSREcv2fwHvfJjprpoE9tiL1qP7Jrq
 4tUYazErOEQJcE8Qm3fioh40w8YrGGYEGNA4do/jaHXm1iB9rShXE2jnmy3ttdAh3M8W2OMK
 4B/Rlr+Awr2NlVdvEF7iL70kO+aZeOu20Lq6mx4Kvq/WyjZg8g+vYGCExZ7sd8xpncBSl7b3
 99AIyT55HaJjrs5F3Rl8dAklaDyzXviwcxs+gSYvRCr6AMzevmfWbAILN9i1ZkfbnqVdpaag
 QmWlmPuKzqKhJP+OMYSgYnpd/vu5FBbc+eXpuhydKqtUVOWjtp5hAERNnSpD87i1TilshFQm
 TFxHDzbOwU0EWCxkawEQALAcdzzKsZbcdSi1kgjfce9AMjyxkkZxcGc6Rhwvt78d66qIFK9D
 Y9wfcZBpuFY/AcKEqjTo4FZ5LCa7/dXNwOXOdB1Jfp54OFUqiYUJFymFKInHQYlmoES9EJEU
 yy+2ipzy5yGbLh3ZqAXyZCTmUKBU7oz/waN7ynEP0S0DqdWgJnpEiFjFN4/ovf9uveUnjzB6
 lzd0BDckLU4dL7aqe2ROIHyG3zaBMuPo66pN3njEr7IcyAL6aK/IyRrwLXoxLMQW7YQmFPSw
 drATP3WO0x8UGaXlGMVcaeUBMJlqTyN4Swr2BbqBcEGAMPjFCm6MjAPv68h5hEoB9zvIg+fq
 M1/Gs4D8H8kUjOEOYtmVQ5RZQschPJle95BzNwE3Y48ZH5zewgU7ByVJKSgJ9HDhwX8Ryuia
 79r86qZeFjXOUXZjjWdFDKl5vaiRbNWCpuSG1R1Tm8o/rd2NZ6l8LgcK9UcpWorrPknbE/pm
 MUeZ2d3ss5G5Vbb0bYVFRtYQiCCfHAQHO6uNtA9IztkuMpMRQDUiDoApHwYUY5Dqasu4ZDJk
 bZ8lC6qc2NXauOWMDw43z9He7k6LnYm/evcD+0+YebxNsorEiWDgIW8Q/E+h6RMS9kW3Rv1N
 qd2nFfiC8+p9I/KLcbV33tMhF1+dOgyiL4bcYeR351pnyXBPA66ldNWvABEBAAHCwWUEGAEC
 AA8FAlgsZGsCGwwFCQlmAYAACgkQbjBXZE7vHeYxSQ/+PnnPrOkKHDHQew8Pq9w2RAOO8gMg
 9Ty4L54CsTf21Mqc6GXj6LN3WbQta7CVA0bKeq0+WnmsZ9jkTNh8lJp0/RnZkSUsDT9Tza9r
 GB0svZnBJMFJgSMfmwa3cBttCh+vqDV3ZIVSG54nPmGfUQMFPlDHccjWIvTvyY3a9SLeamaR
 jOGye8MQAlAD40fTWK2no6L1b8abGtziTkNh68zfu3wjQkXk4kA4zHroE61PpS3oMD4AyI9L
 7A4Zv0Cvs2MhYQ4Qbbmafr+NOhzuunm5CoaRi+762+c508TqgRqH8W1htZCzab0pXHRfywtv
 0P+BMT7vN2uMBdhr8c0b/hoGqBTenOmFt71tAyyGcPgI3f7DUxy+cv3GzenWjrvf3uFpxYx4
 yFQkUcu06wa61nCdxXU/BWFItryAGGdh2fFXnIYP8NZfdA+zmpymJXDQeMsAEHS0BLTVQ3+M
 7W5Ak8p9V+bFMtteBgoM23bskH6mgOAw6Cj/USW4cAJ8b++9zE0/4Bv4iaY5bcsL+h7TqQBH
 Lk1eByJeVooUa/mqa2UdVJalc8B9NrAnLiyRsg72Nurwzvknv7anSgIkL+doXDaG21DgCYTD
 wGA5uquIgb8p3/ENgYpDPrsZ72CxVC2NEJjJwwnRBStjJOGQX4lV1uhN1XsZjBbRHdKF2W9g
 weim8xU=
Organization: Red Hat
Message-ID: <d10586ae-cd86-2992-766b-1ba4a4807b6a@redhat.com>
Date:   Tue, 16 Apr 2019 14:16:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190416154937.GL12232@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 16 Apr 2019 18:16:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/2019 11:49 AM, Peter Zijlstra wrote:
> On Sat, Apr 13, 2019 at 01:22:50PM -0400, Waiman Long wrote:
>
>> +#define RWSEM_COUNT_HANDOFF(c)	((c) & RWSEM_FLAG_HANDOFF)
>> +#define RWSEM_COUNT_LOCKED_OR_HANDOFF(c)	\
>> +	((c) & (RWSEM_LOCK_MASK|RWSEM_FLAG_HANDOFF))
> Like said before, I also made these go away.

Yes, my refactored patches will remove all those trivial macros.

>
>> @@ -245,6 +274,8 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>>  	struct rwsem_waiter *waiter, *tmp;
>>  	long oldcount, woken = 0, adjustment = 0;
>>  
>> +	lockdep_assert_held(&sem->wait_lock);
>> +
>>  	/*
>>  	 * Take a peek at the queue head waiter such that we can determine
>>  	 * the wakeup(s) to perform.
>> @@ -276,6 +307,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>>  		adjustment = RWSEM_READER_BIAS;
>>  		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
>>  		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
>> +			/*
>> +			 * Initiate handoff to reader, if applicable.
>> +			 */
>> +			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
>> +			    time_after(jiffies, waiter->timeout)) {
>> +				adjustment -= RWSEM_FLAG_HANDOFF;
>> +				lockevent_inc(rwsem_rlock_handoff);
>> +			}
> 			/*
> 			 * When we've been waiting 'too' long (for
> 			 * writers to give up the lock) request a
> 			 * HANDOFF to force the issue.
> 			 */
>
> ?

Sure.

>
>> +
>>  			atomic_long_sub(adjustment, &sem->count);
> Can we change this to: atomic_long_add() please? The below loop that
> wakes all remaining readers does use add(), so it is a bit 'weird' to
> have the adjustment being negated on handover.
>
>>  			return;
>>  		}
>> @@ -324,6 +364,12 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>>  		adjustment -= RWSEM_FLAG_WAITERS;
>>  	}
>>  
>> +	/*
>> +	 * Clear the handoff flag
>> +	 */
> Right, but that is a trivial comment in the 'increment i' style, it
> clearly states what the code does, but completely fails to elucidate the
> code.
>
> Maybe:
>
> 	/*
> 	 * When we've woken a reader, we no longer need to force writers
> 	 * to give up the lock and we can clear HANDOFF.
> 	 */
>
> And I suppose this is required if we were the pickup of the handoff set
> above, but is there a guarantee that the HANDOFF was not set by a
> writer?

I can change the comment. The handoff bit is always cleared in
rwsem_try_write_lock() when the lock is successfully acquire. Will add a
comment to document that.

>
>> +	if (woken && RWSEM_COUNT_HANDOFF(atomic_long_read(&sem->count)))
>> +		adjustment -= RWSEM_FLAG_HANDOFF;
>> +
>>  	if (adjustment)
>>  		atomic_long_add(adjustment, &sem->count);
>>  }
>> @@ -332,22 +378,42 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>>   * This function must be called with the sem->wait_lock held to prevent
>>   * race conditions between checking the rwsem wait list and setting the
>>   * sem->count accordingly.
>> + *
>> + * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
>> + * bit is set or the lock is acquired.
>>   */
>> +static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
>> +					enum writer_wait_state wstate)
>>  {
>>  	long new;
>>  
> 	lockdep_assert_held(&sem->wait_lock);

Sure.

>
>> +retry:
>> +	if (RWSEM_COUNT_LOCKED(count)) {
>> +		if (RWSEM_COUNT_HANDOFF(count) || (wstate != WRITER_HANDOFF))
>> +			return false;
>> +		/*
>> +		 * The lock may become free just before setting handoff bit.
>> +		 * It will be simpler if atomic_long_or_return() is available.
>> +		 */
>> +		atomic_long_or(RWSEM_FLAG_HANDOFF, &sem->count);
>> +		count = atomic_long_read(&sem->count);
>> +		goto retry;
>> +	}
>> +
>> +	if ((wstate == WRITER_NOT_FIRST) && RWSEM_COUNT_HANDOFF(count))
>>  		return false;
>>  
>> +	new = (count & ~RWSEM_FLAG_HANDOFF) + RWSEM_WRITER_LOCKED -
>> +	      (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
>>  
>>  	if (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new)) {
>>  		rwsem_set_owner(sem);
>>  		return true;
>>  	}
>>  
>> +	if (unlikely((wstate == WRITER_HANDOFF) && !RWSEM_COUNT_HANDOFF(count)))
>> +		goto retry;
>> +
>>  	return false;
>>  }
> This function gives me heartburn. Don't you just feel something readable
> trying to struggle free from that?
>
> See, if you first write that function in the form:
>
> 	long new;
>
> 	do {
> 		new = count | RWSEM_WRITER_LOCKED;
>
> 		if (count & RWSEM_LOCK_MASK)
> 			return false;
>
> 		if (list_is_singular(&sem->wait_list))
> 			new &= ~RWSEM_FLAG_WAITERS;
>
> 	} while (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
>
> 	rwsem_set_owner(sem);
> 	return true;
>
> And then add the HANDOFF bits like:
>
> 	long new;
>
> 	do {
> +		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>
> +		new = (count | RWSEM_WRITER_LOCKED) & ~RWSEM_FLAG_HANDOFF;
>
> 		if (count & RWSEM_LOCK_MASK) {
> +			if (has_handoff && wstate != WRITER_HANDOFF)
> +				return false;
> 			new |= RWSEM_FLAG_HANDOFF;
> 		}
>
> +		if (has_handoff && wstate == WRITER_NOT_FIRST)
> +			return false;
>
> 		if (list_is_singular(&sem->wait_list))
> 			new &= ~RWSEM_FLAG_WAITERS;
>
> 	} while (atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
>
> 	rwsem_set_owner(sem);
> 	return true;
>
> it almost looks like sensible code.

Yes, it looks much better. I don't like that piece of code myself. I am
sorry that I didn't spend the time to make the code more sane.

Thanks for your suggestion. Will modify it accordingly.

>>  
>> @@ -359,7 +425,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
>>  {
>>  	long count = atomic_long_read(&sem->count);
>>  
>> -	while (!RWSEM_COUNT_LOCKED(count)) {
>> +	while (!RWSEM_COUNT_LOCKED_OR_HANDOFF(count)) {
>>  		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
>>  					count + RWSEM_WRITER_LOCKED)) {
> RWSEM_WRITER_LOCKED really should be RWSEM_FLAG_WRITER or something like
> that, and since it is a flag, that really should've been | not +.

Sure.

>>  			rwsem_set_owner(sem);
>> @@ -498,6 +564,16 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>>  }
>>  #endif
>>  
>> +/*
>> + * This is safe to be called without holding the wait_lock.
>> + */
>> +static inline bool
>> +rwsem_waiter_is_first(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
>> +{
>> +	return list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
>> +			== waiter;
> Just bust the line limit on that, this is silly. If you feel strongly
> about the 80 char thing, we could do:
>
> #define rwsem_first_waiter(sem) \
> 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
>
> and use that in both locations. (and one could even write the
> list_for_each_entry_safe() loop in the form:
>
> 	while (!list_empty(&sem->wait_list)) {
> 		entry = rwsem_first_waiter(sem);
>
> 		...
>
> 		list_del();
>
> 		...
> 	}
>
> Although I suppose that gets you confused later on where you want to
> wake more readers still... I'll get there,.. eventually.

Yes, it is a good idea.

>> +}
>> +
>>  /*
>>   * Wait for the read lock to be granted
>>   */
>> @@ -510,16 +586,18 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
>>  
>>  	waiter.task = current;
>>  	waiter.type = RWSEM_WAITING_FOR_READ;
>> +	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>>  
>>  	raw_spin_lock_irq(&sem->wait_lock);
>>  	if (list_empty(&sem->wait_list)) {
>>  		/*
>>  		 * In case the wait queue is empty and the lock isn't owned
>> +		 * by a writer or has the handoff bit set, this reader can
>> +		 * exit the slowpath and return immediately as its
>> +		 * RWSEM_READER_BIAS has already been set in the count.
>>  		 */
>> +		if (!(atomic_long_read(&sem->count) &
>> +		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
>>  			raw_spin_unlock_irq(&sem->wait_lock);
>>  			rwsem_set_reader_owned(sem);
>>  			lockevent_inc(rwsem_rlock_fast);
>> @@ -567,7 +645,8 @@ __rwsem_down_read_failed_common(struct rw_semaphore *sem, int state)
>>  out_nolock:
>>  	list_del(&waiter.list);
>>  	if (list_empty(&sem->wait_list))
>> +		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
>> +				   &sem->count);
> If you split the line, this wants { }.

OK.

>>  	raw_spin_unlock_irq(&sem->wait_lock);
>>  	__set_current_state(TASK_RUNNING);
>>  	lockevent_inc(rwsem_rlock_fail);
>> @@ -593,7 +672,7 @@ static inline struct rw_semaphore *
>>  __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
>>  {
>>  	long count;
>> +	enum writer_wait_state wstate;
>>  	struct rwsem_waiter waiter;
>>  	struct rw_semaphore *ret = sem;
>>  	DEFINE_WAKE_Q(wake_q);
>> @@ -608,56 +687,63 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
>>  	 */
>>  	waiter.task = current;
>>  	waiter.type = RWSEM_WAITING_FOR_WRITE;
>> +	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>>  
>>  	raw_spin_lock_irq(&sem->wait_lock);
>>  
>>  	/* account for this before adding a new element to the list */
>> +	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
>>  
>>  	list_add_tail(&waiter.list, &sem->wait_list);
>>  
>>  	/* we're now waiting on the lock */
>> +	if (wstate == WRITER_NOT_FIRST) {
>>  		count = atomic_long_read(&sem->count);
>>  
>>  		/*
>> +		 * If there were already threads queued before us and:
>> +		 *  1) there are no no active locks, wake the front
>> +		 *     queued process(es) as the handoff bit might be set.
>> +		 *  2) there are no active writers and some readers, the lock
>> +		 *     must be read owned; so we try to wake any read lock
>> +		 *     waiters that were queued ahead of us.
>>  		 */
>> +		if (!RWSEM_COUNT_LOCKED(count))
>> +			__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
>> +		else if (!(count & RWSEM_WRITER_MASK) &&
>> +			  (count & RWSEM_READER_MASK))
>>  			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
> That RWSEM_WRITER_MASK is another layer of obfustaction we can do
> without.

The RWSEM_WRITER_MASK macro is added to prepare for the later patch that
merge owner into count where RWSEM_WRITER_LOCK will be different.

> Does the above want to be something like:
>
> 		if (!(count & RWSEM_WRITER_LOCKED)) {
> 			__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK) ?
> 					       RWSEM_WAKE_READERS :
> 					       RWSEM_WAKE_ANY, &wake_q);
> 		}

Yes.

>> +		else
>> +			goto wait;
>>  
>> +		/*
>> +		 * The wakeup is normally called _after_ the wait_lock
>> +		 * is released, but given that we are proactively waking
>> +		 * readers we can deal with the wake_q overhead as it is
>> +		 * similar to releasing and taking the wait_lock again
>> +		 * for attempting rwsem_try_write_lock().
>> +		 */
>> +		wake_up_q(&wake_q);
> Hurmph.. the reason we do wake_up_q() outside of wait_lock is such that
> those tasks don't bounce on wait_lock. Also, it removes a great deal of
> hold-time from wait_lock.
>
> So I'm not sure I buy your argument here.
>

Actually, we don't want to release the wait_lock, do wake_up_q() and
acquire the wait_lock again as the state would have been changed. I
didn't change the comment on this patch, but will reword it to discuss that.

>> +		/*
>> +		 * Reinitialize wake_q after use.
>> +		 */
> Or:
> 		/* we need wake_q again below, reinitialize */
>

Sure.

>> +		wake_q_init(&wake_q);
>>  	} else {
>>  		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
>>  	}
>>  
>> +wait:
>>  	/* wait until we successfully acquire the lock */
>>  	set_current_state(state);
>>  	while (true) {
>> +		if (rwsem_try_write_lock(count, sem, wstate))
>>  			break;
>> +
>>  		raw_spin_unlock_irq(&sem->wait_lock);
>>  
>>  		/* Block until there are no active lockers. */
>> +		for (;;) {
>>  			if (signal_pending_state(state, current))
>>  				goto out_nolock;
>>  
>> @@ -665,9 +751,34 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
>>  			lockevent_inc(rwsem_sleep_writer);
>>  			set_current_state(state);
>>  			count = atomic_long_read(&sem->count);
>> +
>> +			if ((wstate == WRITER_NOT_FIRST) &&
>> +			    rwsem_waiter_is_first(sem, &waiter))
>> +				wstate = WRITER_FIRST;
>> +
>> +			if (!RWSEM_COUNT_LOCKED(count))
>> +				break;
>> +
>> +			/*
>> +			 * An RT task sets the HANDOFF bit immediately.
>> +			 * Non-RT task will wait a while before doing so.
> Again, this describes what we already read the code to do; but doesn't
> add anything.

Will remove that.

>> +			 *
>> +			 * The setting of the handoff bit is deferred
>> +			 * until rwsem_try_write_lock() is called.
>> +			 */
>> +			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
>> +			    time_after(jiffies, waiter.timeout))) {
>> +				wstate = WRITER_HANDOFF;
>> +				lockevent_inc(rwsem_wlock_handoff);
>> +				/*
>> +				 * Break out to call rwsem_try_write_lock().
>> +				 */
> Another exceedingly useful comment.
>
>> +				break;
>> +			}
>> +		}
>>  
>>  		raw_spin_lock_irq(&sem->wait_lock);
>> +		count = atomic_long_read(&sem->count);
>>  	}
>>  	__set_current_state(TASK_RUNNING);
>>  	list_del(&waiter.list);
>> @@ -680,6 +791,12 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
>>  	__set_current_state(TASK_RUNNING);
>>  	raw_spin_lock_irq(&sem->wait_lock);
>>  	list_del(&waiter.list);
>> +	/*
>> +	 * If handoff bit has been set by this waiter, make sure that the
>> +	 * clearing of it is seen by others before proceeding.
>> +	 */
>> +	if (unlikely(wstate == WRITER_HANDOFF))
>> +		atomic_long_add_return(-RWSEM_FLAG_HANDOFF,  &sem->count);
> _AGAIN_ no explanation what so ff'ing ever.
>
> And why add_return() if you ignore the return value.
>

OK, will remove those.

>>  	if (list_empty(&sem->wait_list))
>>  		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
> And you could've easily combined the two flags in a single andnot op.

That is true, but the nolock case is rarely executed. That is why I opt
for simplicity than more complicated but faster code.

Cheers,
Longman

