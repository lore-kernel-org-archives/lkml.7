Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ACFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E21217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbfGYQ0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:26:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41407 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387917AbfGYQ0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:26:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 748D330B9BF6;
        Thu, 25 Jul 2019 16:26:39 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D89BC1017E3F;
        Thu, 25 Jul 2019 16:26:37 +0000 (UTC)
Subject: Re: [PATCH-tip] locking/rwsem: Make handoff writer optimistically
 spin on owner
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190625143913.24154-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <abe71078-91b1-e4dd-878c-4a53d9349ecc@redhat.com>
Date:   Thu, 25 Jul 2019 12:26:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625143913.24154-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 25 Jul 2019 16:26:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/19 10:39 AM, Waiman Long wrote:
> When the handoff bit is set by a writer, no other tasks other than
> the setting writer itself is allowed to acquire the lock. If the
> to-be-handoff'ed writer goes to sleep, there will be a wakeup latency
> period where the lock is free, but no one can acquire it. That is less
> than ideal.
>
> To reduce that latency, the handoff writer will now optimistically spin
> on the owner if it happens to be a on-cpu writer. It will spin until
> it releases the lock and the to-be-handoff'ed writer can then acquire
> the lock immediately without any delay. Of course, if the owner is not
> a on-cpu writer, the to-be-handoff'ed writer will have to sleep anyway.
>
> The optimistic spinning code is also modified to not stop spinning
> when the handoff bit is set. This will prevent an occasional setting of
> handoff bit from causing a bunch of optimistic spinners from entering
> into the wait queue causing significant reduction in throughput.
>
> On a 1-socket 22-core 44-thread Skylake system, the AIM7 shared_memory
> workload was run with 7000 users. The throughput (jobs/min) of the
> following kernels were as follows:
>
>  1) 5.2-rc6
>     - 8,092,486
>  2) 5.2-rc6 + tip's rwsem patches
>     - 7,567,568
>  3) 5.2-rc6 + tip's rwsem patches + this patch
>     - 7,954,545
>
> Using perf-record(1), the %cpu time used by rwsem_down_write_slowpath(),
> rwsem_down_write_failed() and their callees for the 3 kernels were 1.70%,
> 5.46% and 2.08% respectively.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 37524a47f002..5e022fbdb2bb 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -720,11 +720,12 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
>  
>  	rcu_read_lock();
>  	for (;;) {
> -		if (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF) {
> -			state = OWNER_NONSPINNABLE;
> -			break;
> -		}
> -
> +		/*
> +		 * When a waiting writer set the handoff flag, it may spin
> +		 * on the owner as well. Once that writer acquires the lock,
> +		 * we can spin on it. So we don't need to quit even when the
> +		 * handoff bit is set.
> +		 */
>  		new = rwsem_owner_flags(sem, &new_flags);
>  		if ((new != owner) || (new_flags != flags)) {
>  			state = rwsem_owner_state(new, new_flags, nonspinnable);
> @@ -970,6 +971,13 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>  {
>  	return false;
>  }
> +
> +static inline int
> +rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
> +{
> +	return 0;
> +}
> +#define OWNER_NULL	1
>  #endif
>  
>  /*
> @@ -1190,6 +1198,18 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  
>  		raw_spin_unlock_irq(&sem->wait_lock);
>  
> +		/*
> +		 * After setting the handoff bit and failing to acquire
> +		 * the lock, attempt to spin on owner to accelerate lock
> +		 * transfer. If the previous owner is a on-cpu writer and it
> +		 * has just released the lock, OWNER_NULL will be returned.
> +		 * In this case, we attempt to acquire the lock again
> +		 * without sleeping.
> +		 */
> +		if ((wstate == WRITER_HANDOFF) &&
> +		    (rwsem_spin_on_owner(sem, 0) == OWNER_NULL))
> +			goto trylock_again;
> +
>  		/* Block until there are no active lockers. */
>  		for (;;) {
>  			if (signal_pending_state(state, current))
> @@ -1224,7 +1244,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  				break;
>  			}
>  		}
> -
> +trylock_again:
>  		raw_spin_lock_irq(&sem->wait_lock);
>  	}
>  	__set_current_state(TASK_RUNNING);

Any comment on this patch?

Cheers,
Longman

