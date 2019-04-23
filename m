Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BAD214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hH5/OGm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfDWORZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:17:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWORY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LwDMKW3KiHAJQhbF3sZdK50FH5LnCoDJmafz9ZETAYk=; b=hH5/OGm3EcKPa1Ov10cYydUq6C
        8HRjBrFVX6JA0KJ95wX6zVVXNbMjy/cu2MN5A6nwfUj2nLSMkb00AjHmU/SSuhhuwPh02IHimXC7E
        XIfF7bSl2nPPeWbEU8OIruFiNOYiapXOFkdGsFVOEN7wk39somgJe+4CiFmHp16jNHpT0fa9d24yy
        KOMQVD1DBQFt9mwLcRavDBWkffuWJ6DJPSQPCHV9ZMfuaYFPa+NHCGAHe0ZUOYR+ibSMsfVcaiNMp
        dMQoT59YWY86CvUGBzbdXXyJK11/4Yj4uoSXIu6qdGRlqxh94hEIQUD+IFHHuylC9OJxc3afbnJxL
        dRA/tJzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIwEW-0001Df-Ur; Tue, 23 Apr 2019 14:17:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA09B29C23850; Tue, 23 Apr 2019 16:17:14 +0200 (CEST)
Date:   Tue, 23 Apr 2019 16:17:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
Message-ID: <20190423141714.GO11158@hirez.programming.kicks-ass.net>
References: <20190418135151.GB12232@hirez.programming.kicks-ass.net>
 <d931916b-41f5-f12d-8c38-0cccbc00a301@redhat.com>
 <20190418144036.GE12232@hirez.programming.kicks-ass.net>
 <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
 <20190419102647.GP7905@worktop.programming.kicks-ass.net>
 <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 05:07:56PM -0400, Waiman Long wrote:

> How about the following chunks to disable preemption temporarily for the
> increment-check-decrement sequence?
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index dd92b1a93919..4cc03ac66e13 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -250,6 +250,8 @@ do { \
>  #define preempt_enable_notrace()               barrier()
>  #define preemptible()                          0
>  
> +#define __preempt_disable_nop  /* preempt_disable() is nop */
> +
>  #endif /* CONFIG_PREEMPT_COUNT */
>  
>  #ifdef MODULE
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 043fd29b7534..54029e6af17b 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -256,11 +256,64 @@ static inline struct task_struct
> *rwsem_get_owner(struct r
>         return (struct task_struct *) (cowner
>                 ? cowner | (sowner & RWSEM_NONSPINNABLE) : sowner);
>  }
> +
> +/*
> + * If __preempt_disable_nop is defined, calling preempt_disable() and
> + * preempt_enable() directly is the most efficient way. Otherwise, it may
> + * be more efficient to disable and enable interrupt instead for disabling
> + * preemption tempoarily.
> + */
> +#ifdef __preempt_disable_nop
> +#define disable_preemption()   preempt_disable()
> +#define enable_preemption()    preempt_enable()
> +#else
> +#define disable_preemption()   local_irq_disable()
> +#define enable_preemption()    local_irq_enable()
> +#endif

I'm not aware of an architecture where disabling interrupts is faster
than disabling preemption.

> +/*
> + * When the owner task structure pointer is merged into couunt, less bits
> + * will be available for readers. Therefore, there is a very slight chance
> + * that the reader count may overflow. We try to prevent that from
> happening
> + * by checking for the MS bit of the count and failing the trylock attempt
> + * if this bit is set.
> + *
> + * With preemption enabled, there is a remote possibility that preemption
> + * can happen in the narrow timing window between incrementing and
> + * decrementing the reader count and the task is put to sleep for a
> + * considerable amount of time. If sufficient number of such unfortunate
> + * sequence of events happen, we may still overflow the reader count.
> + * To avoid such possibility, we have to disable preemption for the
> + * whole increment-check-decrement sequence.
> + *
> + * The function returns true if there are too many readers and the count
> + * has already been properly decremented so the reader must go directly
> + * into the wait list.
> + */
> +static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
> +{
> +       bool wait = false;      /* Wait now flag */
> +
> +       disable_preemption();
> +       *cnt = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
> &sem->count);
> +       if (unlikely(*cnt < 0)) {
> +               atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> +               wait = true;
> +       }
> +       enable_preemption();
> +       return wait;
> +}
>  #else /* !CONFIG_RWSEM_OWNER_COUNT */

This also means you have to ensure CONFIG_NR_CPUS < 32K for
RWSEM_OWNER_COUNT.

>  static inline struct task_struct *rwsem_get_owner(struct rw_semaphore *sem)
>  {
>         return READ_ONCE(sem->owner);
>  }
> +
> +static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
> +{
> +       *cnt = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
> &sem->count);
> +       return false;
> +}
>  #endif /* CONFIG_RWSEM_OWNER_COUNT */
>  
>  /*
> @@ -981,32 +1034,18 @@ static inline void clear_wr_nonspinnable(struct
> rw_semaph
>   * Wait for the read lock to be granted
>   */
>  static struct rw_semaphore __sched *
> -rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
> +rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, const
> bool wait)
>  {
> -       long adjustment = -RWSEM_READER_BIAS;
> +       long count, adjustment = -RWSEM_READER_BIAS;
>         bool wake = false;
>         struct rwsem_waiter waiter;
>         DEFINE_WAKE_Q(wake_q);
>  
> -       if (unlikely(count < 0)) {
> +       if (unlikely(wait)) {
>                 /*
> -                * The sign bit has been set meaning that too many active
> -                * readers are present. We need to decrement reader count &
> -                * enter wait queue immediately to avoid overflowing the
> -                * reader count.
> -                *
> -                * As preemption is not disabled, there is a remote
> -                * possibility that preemption can happen in the narrow
> -                * timing window between incrementing and decrementing
> -                * the reader count and the task is put to sleep for a
> -                * considerable amount of time. If sufficient number
> -                * of such unfortunate sequence of events happen, we
> -                * may still overflow the reader count. It is extremely
> -                * unlikey, though. If this is a concern, we should consider
> -                * disable preemption during this timing window to make
> -                * sure that such unfortunate event will not happen.
> +                * The reader count has already been decremented and the
> +                * reader should go directly into the wait list now.
>                  */
> -               atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
>                 adjustment = 0;
>                 goto queue;
>         }
> @@ -1358,11 +1397,12 @@ static struct rw_semaphore
> *rwsem_downgrade_wake(struct
>   */
>  inline void __down_read(struct rw_semaphore *sem)
>  {
> -       long tmp = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
> -                                                &sem->count);
> +       long tmp;
> +       bool wait;
>  
> +       wait = rwsem_read_trylock(sem, &tmp);
>         if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
> -               rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, tmp);
> +               rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, wait);
>                 DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
>         } else {
>                 rwsem_set_reader_owned(sem);

I think I prefer that function returning/taking the bias/adjustment
value instead of a bool, if it is all the same.
