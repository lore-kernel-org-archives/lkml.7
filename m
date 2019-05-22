Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B94DC072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E205F217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfEVBJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfEVBJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:09:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54453217D9;
        Wed, 22 May 2019 01:09:39 +0000 (UTC)
Date:   Tue, 21 May 2019 21:09:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190521210937.7cc72f2d@oasis.local.home>
In-Reply-To: <20190522003014.1359-1-viktor.rosendahl@gmail.com>
References: <20190521120142.186487e9@gandalf.local.home>
        <20190522003014.1359-1-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 02:30:14 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:
> 
> I can try to add the static branch if you want it though.

Yes, it would need a static branch to prevent overhead.

> 
> best regards,
> 
> Viktor
> ---
>  include/linux/ftrace.h     |  13 +++++
>  kernel/sched/core.c        |   2 +
>  kernel/sched/idle.c        |   2 +
>  kernel/sched/sched.h       |   1 +
>  kernel/trace/trace.c       | 111 ++++++++++++++++++++++++++++++++++++-
>  kernel/trace/trace.h       |  12 ++++
>  kernel/trace/trace_hwlat.c |   4 +-
>  7 files changed, 142 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 25e2995d4a4c..88c76f23277c 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -907,4 +907,17 @@ unsigned long arch_syscall_addr(int nr);
>  
>  #endif /* CONFIG_FTRACE_SYSCALLS */
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +
> +void trace_disable_fsnotify(void);
> +void trace_enable_fsnotify(void);
> +
> +#else
> +
> +#define trace_disable_fsnotify() do { } while (0)
> +#define trace_enable_fsnotify() do { } while (0)
> +
> +#endif
> +
>  #endif /* _LINUX_FTRACE_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427742a9..440cd1a62722 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3374,6 +3374,7 @@ static void __sched notrace __schedule(bool preempt)
>  	struct rq *rq;
>  	int cpu;
>  
> +	trace_disable_fsnotify();

Also, don't use "trace_*" names, I'm trying to reserve them for tracepoints only.

	latency_fsnotify_disable();

perhaps?

>  	cpu = smp_processor_id();
>  	rq = cpu_rq(cpu);
>  	prev = rq->curr;
> @@ -3449,6 +3450,7 @@ static void __sched notrace __schedule(bool preempt)
>  	}
>  
>  	balance_callback(rq);
> +	trace_enable_fsnotify();

	latency_fsnotify_enable();

>  }
>  
>  void __noreturn do_task_dead(void)


> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b52ed1ada0be..e22871d489a5 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -46,6 +46,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delayacct.h>
>  #include <linux/energy_model.h>
> +#include <linux/ftrace.h>
>  #include <linux/init_task.h>
>  #include <linux/kprobes.h>
>  #include <linux/kthread.h>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2c92b3d9ea30..5dcc1147cbcc 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -44,6 +44,8 @@
>  #include <linux/trace.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/rt.h>
> +#include <linux/fsnotify.h>
> +#include <linux/workqueue.h>
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -1481,6 +1483,111 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
>  
>  unsigned long __read_mostly	tracing_thresh;
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +
> +static const struct file_operations tracing_max_lat_fops;
> +static struct workqueue_struct *fsnotify_wq;
> +static DEFINE_PER_CPU(atomic_t, notify_disabled) = ATOMIC_INIT(0);

per cpu atomics is a bit of an overkill. Why the atomic if they are
only used per cpu?

Just make them per cpu, and use things like this_cpu_inc/dec();

> +static DEFINE_PER_CPU(struct llist_head, notify_list);
> +
> +static void trace_fsnotify_workfn(struct work_struct *work)
> +{
> +	struct trace_array *tr = container_of(work, struct trace_array,
> +					      fsnotify_work);
> +	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
> +		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +}
> +
> +static void trace_create_maxlat_file(struct trace_array *tr,
> +				      struct dentry *d_tracer)
> +{
> +	INIT_WORK(&tr->fsnotify_work, trace_fsnotify_workfn);
> +	atomic_set(&tr->notify_pending, 0);
> +	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
> +					      d_tracer, &tr->max_latency,
> +					      &tracing_max_lat_fops);
> +}
> +
> +/*
> + * Disable fsnotify while in scheduler and idle code. Trying wake anything up
> + * from there, such as calling queue_work() is prone to deadlock.
> + */
> +void trace_disable_fsnotify(void)
> +{
> +	int cpu;
> +
> +	cpu = smp_processor_id();
> +	atomic_set(&per_cpu(notify_disabled, cpu), 1);
> +}

This should be a static inline function:

static inline void latency_fsnotify_disable(void)
{
	this_cpu_inc(latency_trace_notify_disable);
}

> +EXPORT_SYMBOL(trace_disable_fsnotify);
> +
> +void trace_enable_fsnotify(void)

Also this needs to be split as a static inline and a function call.

static inline void latency_fsnotify_enable(void)
{
	this_cpu_dec(latency_trace_notify_disable);
	if (static_key_false(&latency_notify_key))
		lantency_fsnotify_process();
}

Have the static_key enabled by the latency tracers that modify the file.

In this file:

void latency_fsontify_process(void)
{

> +{
> +	int cpu;
> +	struct trace_array *tr;
> +	struct llist_head *list;
> +	struct llist_node *node;
> +
> +	cpu = smp_processor_id();
> +	atomic_set(&per_cpu(notify_disabled, cpu), 0);
> +
> +	list = &per_cpu(notify_list, cpu);

	list = &this_cpu_read(notify_list);

-- Steve

> +	for (node = llist_del_first(list); node != NULL;
> +	     node = llist_del_first(list)) {
> +		tr = llist_entry(node, struct trace_array, notify_ll);
> +		atomic_set(&tr->notify_pending, 0);
> +		queue_work(fsnotify_wq, &tr->fsnotify_work);
> +	}
> +}
> +EXPORT_SYMBOL(trace_enable_fsnotify);
> +
> +__init static int trace_maxlat_fsnotify_init(void)
> +{
> +	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
> +				      WQ_UNBOUND | WQ_HIGHPRI, 0);
> +	if (!fsnotify_wq) {
> +		pr_err("Unable to allocate tr_max_lat_wq\n");
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +late_initcall_sync(trace_maxlat_fsnotify_init);
> +
> +void trace_maxlat_fsnotify(struct trace_array *tr)
> +{
> +	int cpu;
> +
> +	if (!fsnotify_wq)
> +		return;
> +
> +	cpu = smp_processor_id();
> +	if (!atomic_read(&per_cpu(notify_disabled, cpu)))
> +		queue_work(fsnotify_wq, &tr->fsnotify_work);
> +	else {
> +		/*
> +		 * notify_pending prevents us from adding the same entry to
> +		 * more than one notify_list. It will get queued in
> +		 * trace_enable_fsnotify()
> +		 */
> +		if (!atomic_xchg(&tr->notify_pending, 1))
> +			llist_add(&tr->notify_ll, &per_cpu(notify_list, cpu));
> +	}
> +}
> +
> +/*
> + * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> + *  defined(CONFIG_FSNOTIFY)
> + */
> +#else
> +
> +#define trace_create_maxlat_file(tr, d_tracer)				\
> +	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
> +			  &tr->max_latency, &tracing_max_lat_fops)
> +
> +#endif
> +
>  #ifdef CONFIG_TRACER_MAX_TRACE
>  /*
>   * Copy the new maximum trace into the separate maximum-trace
> @@ -1519,6 +1626,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  
>  	/* record this tasks comm */
>  	tracing_record_cmdline(tsk);
> +	trace_maxlat_fsnotify(tr);
>  }
>  
>  /**
> @@ -8533,8 +8641,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  	create_trace_options_dir(tr);
>  
>  #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
> -	trace_create_file("tracing_max_latency", 0644, d_tracer,
> -			&tr->max_latency, &tracing_max_lat_fops);
> +	trace_create_maxlat_file(tr, d_tracer);
>  #endif
>  
>  	if (ftrace_create_function_files(tr, d_tracer))
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 1974ce818ddb..f95027813296 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -17,6 +17,7 @@
>  #include <linux/compiler.h>
>  #include <linux/trace_seq.h>
>  #include <linux/glob.h>
> +#include <linux/workqueue.h>
>  
>  #ifdef CONFIG_FTRACE_SYSCALLS
>  #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
> @@ -265,6 +266,12 @@ struct trace_array {
>  #endif
>  #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>  	unsigned long		max_latency;
> +#ifdef CONFIG_FSNOTIFY
> +	struct dentry		*d_max_latency;
> +	struct work_struct	fsnotify_work;
> +	atomic_t		notify_pending;
> +	struct llist_node	notify_ll;
> +#endif
>  #endif
>  	struct trace_pid_list	__rcu *filtered_pids;
>  	/*
> @@ -786,6 +793,11 @@ void update_max_tr_single(struct trace_array *tr,
>  			  struct task_struct *tsk, int cpu);
>  #endif /* CONFIG_TRACER_MAX_TRACE */
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +void trace_maxlat_fsnotify(struct trace_array *tr);
> +#endif
> +
>  #ifdef CONFIG_STACKTRACE
>  void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
>  		   int pc);
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 1e6db9cbe4dc..44a47f81d949 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -254,8 +254,10 @@ static int get_sample(void)
>  		trace_hwlat_sample(&s);
>  
>  		/* Keep a running maximum ever recorded hardware latency */
> -		if (sample > tr->max_latency)
> +		if (sample > tr->max_latency) {
>  			tr->max_latency = sample;
> +			trace_maxlat_fsnotify(tr);
> +		}
>  	}
>  
>  out:

