Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF92EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9112070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfECN4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:56:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfECN4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:56:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AB5858E5B;
        Fri,  3 May 2019 13:56:43 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1966726E5B;
        Fri,  3 May 2019 13:56:42 +0000 (UTC)
Subject: Re: [PATCH-tip v7 09/20] locking/rwsem: Always release wait_lock
 before waking up tasks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-10-longman@redhat.com>
 <20190503133717.GG2623@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2ef40a8d-20c1-461c-394c-75a24d545cb8@redhat.com>
Date:   Fri, 3 May 2019 09:56:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503133717.GG2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 03 May 2019 13:56:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/19 9:37 AM, Peter Zijlstra wrote:
> On Sun, Apr 28, 2019 at 05:25:46PM -0400, Waiman Long wrote:
>
>> +			/*
>> +			 * This waiter may have become first in the wait
>> +			 * list after re-acquring the wait_lock. The
>> +			 * rwsem_first_waiter() test in the main while
>> +			 * loop below will correctly detect that. We do
>> +			 * need to reload count to perform proper trylock
>> +			 * and avoid missed wakeup.
>> +			 */
>> +			count = atomic_long_read(&sem->count);
>> +		}
>>  	} else {
>>  		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
>>  	}
> I've been eyeing that count usage for the past few patches, and this
> here makes me think we should get rid of it.
>
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -400,13 +400,14 @@ static void __rwsem_mark_wake(struct rw_
>   * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
>   * bit is set or the lock is acquired with handoff bit cleared.
>   */
> -static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
> +static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>  					enum writer_wait_state wstate)
>  {
> -	long new;
> +	long count, new;
>  
>  	lockdep_assert_held(&sem->wait_lock);
>  
> +	count = atomic_long_read(&sem->count);
>  	do {
>  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>  
> @@ -760,25 +761,16 @@ rwsem_down_write_slowpath(struct rw_sema
>  			wake_up_q(&wake_q);
>  			wake_q_init(&wake_q);	/* Used again, reinit */
>  			raw_spin_lock_irq(&sem->wait_lock);
> -			/*
> -			 * This waiter may have become first in the wait
> -			 * list after re-acquring the wait_lock. The
> -			 * rwsem_first_waiter() test in the main while
> -			 * loop below will correctly detect that. We do
> -			 * need to reload count to perform proper trylock
> -			 * and avoid missed wakeup.
> -			 */
> -			count = atomic_long_read(&sem->count);
>  		}
>  	} else {
> -		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
> +		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
>  	}
>  
>  wait:
>  	/* wait until we successfully acquire the lock */
>  	set_current_state(state);
>  	for (;;) {
> -		if (rwsem_try_write_lock(count, sem, wstate))
> +		if (rwsem_try_write_lock(sem, wstate))
>  			break;
>  
>  		raw_spin_unlock_irq(&sem->wait_lock);
> @@ -819,7 +811,6 @@ rwsem_down_write_slowpath(struct rw_sema
>  		}
>  
>  		raw_spin_lock_irq(&sem->wait_lock);
> -		count = atomic_long_read(&sem->count);
>  	}
>  	__set_current_state(TASK_RUNNING);
>  	list_del(&waiter.list);

Yes, this is an alternative way of doing it.

Cheers,
Longman

