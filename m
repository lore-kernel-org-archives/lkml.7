Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E41C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EEB21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558435603;
	bh=QG1eZwyycnH4wggKV/FPYI6zwO4ITj+m1kljotJjWME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XBU+C48mlO/OEDbVvKADouG61o1X7DkdJ7Gs+ZgGQlp3SVWlwK9bmCLD70FoiTMkp
	 hPHrzk9TcK5xJkzeOUK0lei2P0BUR816Y0XqP6tY5yPHnj5qvKL+25Rp2eG1B7N0iD
	 je1DDOwmLhOEXgfRu6G3AlEYP4NVejzcX9v6B6qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfEUKqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:46:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:39740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfEUKqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:46:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4AB4BAF1C;
        Tue, 21 May 2019 10:46:39 +0000 (UTC)
Date:   Tue, 21 May 2019 12:46:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
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
Subject: Re: [PATCH] kernel.h: Add non_block_start/end()
Message-ID: <20190521104638.GO32329@dhcp22.suse.cz>
References: <20190521100611.10089-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521100611.10089-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-05-19 12:06:11, Daniel Vetter wrote:
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
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

I like this in general. The implementation looks reasonable to me but I
didn't check deeply enough to give my R-by or A-by.

> ---
>  include/linux/kernel.h | 10 +++++++++-
>  include/linux/sched.h  |  4 ++++
>  kernel/sched/core.c    | 19 ++++++++++++++-----
>  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 74b1ee9027f5..b5f2c2ff0eab 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -214,7 +214,9 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
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
> @@ -230,6 +232,10 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
>  # define cant_sleep() \
>  	do { __cant_sleep(__FILE__, __LINE__, 0); } while (0)
>  # define sched_annotate_sleep()	(current->task_state_change = 0)
> +# define non_block_start() \
> +	do { current->non_block_count++; } while (0)
> +# define non_block_end() \
> +	do { WARN_ON(current->non_block_count-- == 0); } while (0)
>  #else
>    static inline void ___might_sleep(const char *file, int line,
>  				   int preempt_offset) { }
> @@ -238,6 +244,8 @@ extern void __cant_sleep(const char *file, int line, int preempt_offset);
>  # define might_sleep() do { might_resched(); } while (0)
>  # define cant_sleep() do { } while (0)
>  # define sched_annotate_sleep() do { } while (0)
> +# define non_block_start() do { } while (0)
> +# define non_block_end() do { } while (0)
>  #endif
>  
>  #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 11837410690f..7f5b293e72df 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -908,6 +908,10 @@ struct task_struct {
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
> index 102dfcf0a29a..ed7755a28465 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3264,13 +3264,22 @@ static noinline void __schedule_bug(struct task_struct *prev)
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
> @@ -3377,7 +3386,7 @@ static void __sched notrace __schedule(bool preempt)
>  	rq = cpu_rq(cpu);
>  	prev = rq->curr;
>  
> -	schedule_debug(prev);
> +	schedule_debug(prev, preempt);
>  
>  	if (sched_feat(HRTICK))
>  		hrtick_clear(rq);
> @@ -6102,7 +6111,7 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  	rcu_sleep_check();
>  
>  	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
> -	     !is_idle_task(current)) ||
> +	     !is_idle_task(current) && !current->non_block_count) ||
>  	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
>  	    oops_in_progress)
>  		return;
> @@ -6118,8 +6127,8 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
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
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
