Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870AAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D022077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566992590;
	bh=/kfIuWrpeV2RGSnPwJxYI3y2cDLRw7lVXf8ak9Ergo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R6zr9sy5WBQ6OuI9qYWJN+hJT8aq0ivK40wVBfIblly8hCZjbp9MpvQ9AfOJqBcH0
	 IoOq+jdIzWkEIMYCQsSoHz4xX2C8tdzKVkEMaU1L5DewOdhUGxH1lT2y3b0Ab0n5ly
	 RqM9q+WYEFbOx7AZFS8aBKrCj206z3WWDKs0J71g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfH1LnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:43:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:57820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfH1LnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:43:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 057F3AF2C;
        Wed, 28 Aug 2019 11:43:06 +0000 (UTC)
Date:   Wed, 28 Aug 2019 13:43:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/5] kernel.h: Add non_block_start/end()
Message-ID: <20190828114305.GH28313@dhcp22.suse.cz>
References: <20190826201425.17547-1-daniel.vetter@ffwll.ch>
 <20190826201425.17547-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826201425.17547-4-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-08-19 22:14:23, Daniel Vetter wrote:
> In some special cases we must not block, but there's not a
> spinlock, preempt-off, irqs-off or similar critical section already
> that arms the might_sleep() debug checks. Add a non_block_start/end()
> pair to annotate these.
> 
> This will be used in the oom paths of mmu-notifiers, where blocking is
> not allowed to make sure there's forward progress. Quoting Michal:
> 
> "The notifier is called from quite a restricted context - oom_reaper -
> which shouldn't depend on any locks or sleepable conditionals. The code
> should be swift as well but we mostly do care about it to make a forward
> progress. Checking for sleepable context is the best thing we could come
> up with that would describe these demands at least partially."
> 
> Peter also asked whether we want to catch spinlocks on top, but Michal
> said those are less of a problem because spinlocks can't have an
> indirect dependency upon the page allocator and hence close the loop
> with the oom reaper.
> 
> Suggested by Michal Hocko.
> 
> v2:
> - Improve commit message (Michal)
> - Also check in schedule, not just might_sleep (Peter)
> 
> v3: It works better when I actually squash in the fixup I had lying
> around :-/
> 
> v4: Pick the suggestion from Andrew Morton to give non_block_start/end
> some good kerneldoc comments. I added that other blocking calls like
> wait_event pose similar issues, since that's the other example we
> discussed.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Wei Wang <wvw@google.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Christian König <christian.koenig@amd.com> (v1)
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks and sorry for being mostly silent/slow in discussions here.
ETOOBUSY.

> ---
>  include/linux/kernel.h | 25 ++++++++++++++++++++++++-
>  include/linux/sched.h  |  4 ++++
>  kernel/sched/core.c    | 19 ++++++++++++++-----
>  3 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 4fa360a13c1e..82f84cfe372f 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -217,7 +217,9 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
>   * might_sleep - annotation for functions that can sleep
>   *
>   * this macro will print a stack trace if it is executed in an atomic
> - * context (spinlock, irq-handler, ...).
> + * context (spinlock, irq-handler, ...). Additional sections where blocking is
> + * not allowed can be annotated with non_block_start() and non_block_end()
> + * pairs.
>   *
>   * This is a useful debugging help to be able to catch problems early and not
>   * be bitten later when the calling function happens to sleep when it is not
> @@ -233,6 +235,25 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
>  # define cant_sleep() \
>  	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
>  # define sched_annotate_sleep()	(current->task_state_change = 0)
> +/**
> + * non_block_start - annotate the start of section where sleeping is prohibited
> + *
> + * This is on behalf of the oom reaper, specifically when it is calling the mmu
> + * notifiers. The problem is that if the notifier were to block on, for example,
> + * mutex_lock() and if the process which holds that mutex were to perform a
> + * sleeping memory allocation, the oom reaper is now blocked on completion of
> + * that memory allocation. Other blocking calls like wait_event() pose similar
> + * issues.
> + */
> +# define non_block_start() \
> +	do { current->non_block_count++; } while (0)
> +/**
> + * non_block_end - annotate the end of section where sleeping is prohibited
> + *
> + * Closes a section opened by non_block_start().
> + */
> +# define non_block_end() \
> +	do { WARN_ON(current->non_block_count-- == 0); } while (0)
>  #else
>    static inline void ___might_sleep(const char *file, int line,
>  				   int preempt_offset) { }
> @@ -241,6 +262,8 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
>  # define might_sleep() do { might_resched(); } while (0)
>  # define cant_sleep() do { } while (0)
>  # define sched_annotate_sleep() do { } while (0)
> +# define non_block_start() do { } while (0)
> +# define non_block_end() do { } while (0)
>  #endif
>  
>  #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b6ec130dff9b..e8bb965f5019 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -980,6 +980,10 @@ struct task_struct {
>  	struct mutex_waiter		*blocked_on;
>  #endif
>  
> +#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> +	int				non_block_count;
> +#endif
> +
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	unsigned int			irq_events;
>  	unsigned long			hardirq_enable_ip;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 45dceec209f4..0d01c7994a9a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3752,13 +3752,22 @@ static noinline void __schedule_bug(struct task_struct *prev)
>  /*
>   * Various schedule()-time debugging checks and statistics:
>   */
> -static inline void schedule_debug(struct task_struct *prev)
> +static inline void schedule_debug(struct task_struct *prev, bool preempt)
>  {
>  #ifdef CONFIG_SCHED_STACK_END_CHECK
>  	if (task_stack_end_corrupted(prev))
>  		panic("corrupted stack end detected inside scheduler\n");
>  #endif
>  
> +#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> +	if (!preempt && prev->state && prev->non_block_count) {
> +		printk(KERN_ERR "BUG: scheduling in a non-blocking section: %s/%d/%i\n",
> +			prev->comm, prev->pid, prev->non_block_count);
> +		dump_stack();
> +		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> +	}
> +#endif
> +
>  	if (unlikely(in_atomic_preempt_off())) {
>  		__schedule_bug(prev);
>  		preempt_count_set(PREEMPT_DISABLED);
> @@ -3870,7 +3879,7 @@ static void __sched notrace __schedule(bool preempt)
>  	rq = cpu_rq(cpu);
>  	prev = rq->curr;
>  
> -	schedule_debug(prev);
> +	schedule_debug(prev, preempt);
>  
>  	if (sched_feat(HRTICK))
>  		hrtick_clear(rq);
> @@ -6641,7 +6650,7 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  	rcu_sleep_check();
>  
>  	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
> -	     !is_idle_task(current)) ||
> +	     !is_idle_task(current) && !current->non_block_count) ||
>  	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
>  	    oops_in_progress)
>  		return;
> @@ -6657,8 +6666,8 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  		"BUG: sleeping function called from invalid context at %s:%d\n",
>  			file, line);
>  	printk(KERN_ERR
> -		"in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
> -			in_atomic(), irqs_disabled(),
> +		"in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
> +			in_atomic(), irqs_disabled(), current->non_block_count,
>  			current->pid, current->comm);
>  
>  	if (task_stack_end_corrupted(current))
> -- 
> 2.23.0
> 

-- 
Michal Hocko
SUSE Labs
