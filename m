Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35396C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DA820856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oCkiz/QQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfILWRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:17:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45264 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILWRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:17:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so14165750pgm.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WbOa0cPNOoH+jD3y2QgypHsixfYguecwmUjeLdNlTFo=;
        b=oCkiz/QQezLL30xW4MAvHDngeR4d2rrLJOU67yUOFlY6VQI0fvdta5gZI7UZb4dbrX
         LzY0A2u96JssC6JnBRPlYay2kqasN1L8BdSyHF8PXF0tIcGQBUFxi296awc8Uvq5U6Fw
         HICZhgp4p00DqaRl3zQYDrOesCBtfIE6zbBVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WbOa0cPNOoH+jD3y2QgypHsixfYguecwmUjeLdNlTFo=;
        b=H1E3qysKI6NFJTp5RTuwZsJQRxggXdnd/CW9zs87151M/lPsAgM1yoBeE9JdDk4RbK
         QJMW/wPbFIAitWhFyM5QEntuqZgjQzHQh2UkSBr/vw/j0ojI8gabE6VAKkHXUWiug/eJ
         9tBcUj6nasz4YPyXhSNGc9c99pjkCVgd9UMu++W2YmlJnC37a5hNKNY/+d/huktorOvy
         ABrGI4Wd3PKzr1dORk7ZdR0UNgiRu5oIcCdx5wdDQxns1ZadIbLJ965hVKwehNo77Fgi
         R13NdCdmJhfexnaxTJdueVWtT192LKAIEmyYWysAl0OapeTMBxn6DpTJE3I+NtF/5Q9w
         kGfA==
X-Gm-Message-State: APjAAAWQNJ2mh1o1hpOOGVx2JCDIFbxcI8R2Qv1UTDJUn2zKJAKDckEg
        gJNydOKBmz1WSD6l09oPFNQnbg==
X-Google-Smtp-Source: APXvYqwf9wGaXxd0doEeeLLKTtMbud/XWlc7oldAIqCmPqPISoCGrjv8tFH7ePZ9AVx/1HFIBM9Kgw==
X-Received: by 2002:a63:524f:: with SMTP id s15mr38136805pgl.2.1568326628442;
        Thu, 12 Sep 2019 15:17:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u10sm14457616pfm.71.2019.09.12.15.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 15:17:07 -0700 (PDT)
Date:   Thu, 12 Sep 2019 18:17:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 5/5] rcutorture: Avoid problematic critical section
 nesting on RT
Message-ID: <20190912221706.GC150506@google.com>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-6-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911165729.11178-6-swood@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 05:57:29PM +0100, Scott Wood wrote:
> rcutorture was generating some nesting scenarios that are not
> reasonable.  Constrain the state selection to avoid them.
> 
> Example #1:
> 
> 1. preempt_disable()
> 2. local_bh_disable()
> 3. preempt_enable()
> 4. local_bh_enable()
> 
> On PREEMPT_RT, BH disabling takes a local lock only when called in
> non-atomic context.  Thus, atomic context must be retained until after BH
> is re-enabled.  Likewise, if BH is initially disabled in non-atomic
> context, it cannot be re-enabled in atomic context.
> 
> Example #2:
> 
> 1. rcu_read_lock()
> 2. local_irq_disable()
> 3. rcu_read_unlock()
> 4. local_irq_enable()

If I understand correctly, these examples are not unrealistic in the real
world unless RCU is used in the scheduler.

> 
> If the thread is preempted between steps 1 and 2,
> rcu_read_unlock_special.b.blocked will be set, but it won't be
> acted on in step 3 because IRQs are disabled.  Thus, reporting of the
> quiescent state will be delayed beyond the local_irq_enable().

Yes, with consolidated RCU this can happen but AFAIK it has not seen to be a
problem since deferred QS reporting will happen take care of it, which can
also happen from subsequent rcu_read_unlock_special().

> For now, these scenarios will continue to be tested on non-PREEMPT_RT
> kernels, until debug checks are added to ensure that they are not
> happening elsewhere.

Are you seeing real issues that need this patch? It would be good to not
complicate rcutorture if not needed.

thanks,

 - Joel


> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> v3: Limit to RT kernels, and remove one constraint that, while it
> is bad on both RT and non-RT (missing a schedule), does not oops or
> otherwise prevent using rcutorture.  It wolud be added once debug checks
> are implemented.
> 
>  kernel/rcu/rcutorture.c | 96 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 82 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index efaa5b3f4d3f..ecb82cc432af 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -60,10 +60,13 @@
>  #define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
>  #define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
>  #define RCUTORTURE_RDR_RCU	 0x20	/*  ... entering another RCU reader. */
> -#define RCUTORTURE_RDR_NBITS	 6	/* Number of bits defined above. */
> +#define RCUTORTURE_RDR_ATOM_BH	 0x40	/*  ... disabling bh while atomic */
> +#define RCUTORTURE_RDR_ATOM_RBH	 0x80	/*  ... RBH while atomic */
> +#define RCUTORTURE_RDR_NBITS	 8	/* Number of bits defined above. */
>  #define RCUTORTURE_MAX_EXTEND	 \
>  	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
> -	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
> +	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED | \
> +	 RCUTORTURE_RDR_ATOM_BH | RCUTORTURE_RDR_ATOM_RBH)
>  #define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
>  					/* Must be power of two minus one. */
>  #define RCUTORTURE_RDR_MAX_SEGS (RCUTORTURE_RDR_MAX_LOOPS + 3)
> @@ -1092,31 +1095,52 @@ static void rcutorture_one_extend(int *readstate, int newstate,
>  	WARN_ON_ONCE((idxold >> RCUTORTURE_RDR_SHIFT) > 1);
>  	rtrsp->rt_readstate = newstate;
>  
> -	/* First, put new protection in place to avoid critical-section gap. */
> +	/*
> +	 * First, put new protection in place to avoid critical-section gap.
> +	 * Disable preemption around the ATOM disables to ensure that
> +	 * in_atomic() is true.
> +	 */
>  	if (statesnew & RCUTORTURE_RDR_BH)
>  		local_bh_disable();
> +	if (statesnew & RCUTORTURE_RDR_RBH)
> +		rcu_read_lock_bh();
>  	if (statesnew & RCUTORTURE_RDR_IRQ)
>  		local_irq_disable();
>  	if (statesnew & RCUTORTURE_RDR_PREEMPT)
>  		preempt_disable();
> -	if (statesnew & RCUTORTURE_RDR_RBH)
> -		rcu_read_lock_bh();
>  	if (statesnew & RCUTORTURE_RDR_SCHED)
>  		rcu_read_lock_sched();
> +	preempt_disable();
> +	if (statesnew & RCUTORTURE_RDR_ATOM_BH)
> +		local_bh_disable();
> +	if (statesnew & RCUTORTURE_RDR_ATOM_RBH)
> +		rcu_read_lock_bh();
> +	preempt_enable();
>  	if (statesnew & RCUTORTURE_RDR_RCU)
>  		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
>  
> -	/* Next, remove old protection, irq first due to bh conflict. */
> +	/*
> +	 * Next, remove old protection, in decreasing order of strength
> +	 * to avoid unlock paths that aren't safe in the stronger
> +	 * context.  Disable preemption around the ATOM enables in
> +	 * case the context was only atomic due to IRQ disabling.
> +	 */
> +	preempt_disable();
>  	if (statesold & RCUTORTURE_RDR_IRQ)
>  		local_irq_enable();
> -	if (statesold & RCUTORTURE_RDR_BH)
> +	if (statesold & RCUTORTURE_RDR_ATOM_BH)
>  		local_bh_enable();
> +	if (statesold & RCUTORTURE_RDR_ATOM_RBH)
> +		rcu_read_unlock_bh();
> +	preempt_enable();
>  	if (statesold & RCUTORTURE_RDR_PREEMPT)
>  		preempt_enable();
> -	if (statesold & RCUTORTURE_RDR_RBH)
> -		rcu_read_unlock_bh();
>  	if (statesold & RCUTORTURE_RDR_SCHED)
>  		rcu_read_unlock_sched();
> +	if (statesold & RCUTORTURE_RDR_BH)
> +		local_bh_enable();
> +	if (statesold & RCUTORTURE_RDR_RBH)
> +		rcu_read_unlock_bh();
>  	if (statesold & RCUTORTURE_RDR_RCU)
>  		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
>  
> @@ -1152,6 +1176,12 @@ static int rcutorture_extend_mask_max(void)
>  	int mask = rcutorture_extend_mask_max();
>  	unsigned long randmask1 = torture_random(trsp) >> 8;
>  	unsigned long randmask2 = randmask1 >> 3;
> +	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> +	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
> +	unsigned long nonatomic_bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
> +	unsigned long atomic_bhs = RCUTORTURE_RDR_ATOM_BH |
> +				   RCUTORTURE_RDR_ATOM_RBH;
> +	unsigned long tmp;
>  
>  	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
>  	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
> @@ -1159,11 +1189,49 @@ static int rcutorture_extend_mask_max(void)
>  		mask = mask & randmask2;
>  	else
>  		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
> -	/* Can't enable bh w/irq disabled. */
> -	if ((mask & RCUTORTURE_RDR_IRQ) &&
> -	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
> -	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
> -		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
> +
> +	/*
> +	 * Can't enable bh w/irq disabled.
> +	 */
> +	tmp = atomic_bhs | nonatomic_bhs;
> +	if (mask & RCUTORTURE_RDR_IRQ)
> +		mask |= oldmask & tmp;
> +
> +	/*
> +	 * Ideally these sequences would be detected in debug builds
> +	 * (regardless of RT), but until then don't stop testing
> +	 * them on non-RT.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL)) {
> +		/*
> +		 * Can't release the outermost rcu lock in an irq disabled
> +		 * section without preemption also being disabled, if irqs
> +		 * had ever been enabled during this RCU critical section
> +		 * (could leak a special flag and delay reporting the qs).
> +		 */
> +		if ((oldmask & RCUTORTURE_RDR_RCU) &&
> +		    (mask & RCUTORTURE_RDR_IRQ) &&
> +		    !(mask & preempts))
> +			mask |= RCUTORTURE_RDR_RCU;
> +
> +		/* Can't modify atomic bh in non-atomic context */
> +		if ((oldmask & atomic_bhs) && (mask & atomic_bhs) &&
> +		    !(mask & preempts_irq)) {
> +			mask |= oldmask & preempts_irq;
> +			if (mask & RCUTORTURE_RDR_IRQ)
> +				mask |= oldmask & tmp;
> +		}
> +		if ((mask & atomic_bhs) && !(mask & preempts_irq))
> +			mask |= RCUTORTURE_RDR_PREEMPT;
> +
> +		/* Can't modify non-atomic bh in atomic context */
> +		tmp = nonatomic_bhs;
> +		if (oldmask & preempts_irq)
> +			mask &= ~tmp;
> +		if ((oldmask | mask) & preempts_irq)
> +			mask |= oldmask & tmp;
> +	}
> +
>  	return mask ?: RCUTORTURE_RDR_RCU;
>  }
>  
> -- 
> 1.8.3.1
> 
