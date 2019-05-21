Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D78C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F174D2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfEUQBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUQBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:01:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D6D21019;
        Tue, 21 May 2019 16:01:44 +0000 (UTC)
Date:   Tue, 21 May 2019 12:01:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190521120142.186487e9@gandalf.local.home>
In-Reply-To: <20190517203430.6729-2-viktor.rosendahl@gmail.com>
References: <20190517203430.6729-1-viktor.rosendahl@gmail.com>
        <20190517203430.6729-2-viktor.rosendahl@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Added Peter and Rafael ]

On Fri, 17 May 2019 22:34:27 +0200
Viktor Rosendahl <viktor.rosendahl@gmail.com> wrote:

> This patch implements the feature that the tracing_max_latency file,
> e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
> notifications through the fsnotify framework when a new latency is
> available.
> 
> One particularly interesting use of this facility is when enabling
> threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
> together with the preempt/irqsoff tracers. This makes it possible to
> implement a user space program that can, with equal probability,
> obtain traces of latencies that occur immediately after each other in
> spite of the fact that the preempt/irqsoff tracers operate in overwrite
> mode.
> 
> This facility works with the hwlat, preempt/irqsoff, and wakeup
> tracers.
> 
> This patch also add four new tracepoints, for entering/exiting
> __schedule() and do_idle(). Those tracepoints are needed to disable
> and enable the notificaton facility because we cannot wake up the
> workqueue from these critical sections without risking a deadlock.
> Similar problems would also arise if we try to schedule a tasklet,
> raise a softirq, or wake up a kernel thread.

Note, you need to add the scheduling and power management maintainers
when adding trace events to their code.

As these trace events become visible to user space, and you only need a
callback to disable fsnotify, it may be better to just have a hard
coded call to disable fsnotify (and have it be a nop when not
configured). We can use a static branch if you want to keep the
overhead down when not enabled, and enable the static branch when you
start these latency tracers.

-- Steve


> 
> If a notification event would happen in the forbidden sections, we
> schedule the fsnotify work as soon as we have exited
> do_idle()/__schedule().
> 
> Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
> ---
>  include/trace/events/power.h |  40 +++++++++
>  include/trace/events/sched.h |  40 +++++++++
>  kernel/sched/core.c          |   2 +
>  kernel/sched/idle.c          |   2 +
>  kernel/trace/trace.c         | 168 ++++++++++++++++++++++++++++++++++-
>  kernel/trace/trace.h         |  12 +++
>  kernel/trace/trace_hwlat.c   |   4 +-
>  7 files changed, 265 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index f7aece721aed..40ab747274bd 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -40,6 +40,46 @@ DEFINE_EVENT(cpu, cpu_idle,
>  	TP_ARGS(state, cpu_id)
>  );
>  
> +/*
> + * Tracepoint for entering do_idle():
> + */
> +TRACE_EVENT(do_idle_enter,
> +
> +	TP_PROTO(int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(int, cpu)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +	),
> +
> +	TP_printk("cpu=%d", __entry->cpu)
> +);
> +
> +/*
> + * Tracepoint for exiting do_idle():
> + */
> +TRACE_EVENT(do_idle_exit,
> +
> +	TP_PROTO(int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(int, cpu)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +	),
> +
> +	TP_printk("cpu=%d", __entry->cpu)
> +);
> +
>  TRACE_EVENT(powernv_throttle,
>  
>  	TP_PROTO(int chip_id, const char *reason, int pmax),
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index c8c7c7efb487..a1a1befea1c1 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -183,6 +183,46 @@ TRACE_EVENT(sched_switch,
>  		__entry->next_comm, __entry->next_pid, __entry->next_prio)
>  );
>  
> +/*
> + * Tracepoint for entering __schedule():
> + */
> +TRACE_EVENT(sched_schedule_enter,
> +
> +	TP_PROTO(int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(int, cpu)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +	),
> +
> +	TP_printk("cpu=%d", __entry->cpu)
> +);
> +
> +/*
> + * Tracepoint for exiting __schedule():
> + */
> +TRACE_EVENT(sched_schedule_exit,
> +
> +	TP_PROTO(int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(int, cpu)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +	),
> +
> +	TP_printk("cpu=%d", __entry->cpu)
> +);
> +
>  /*
>   * Tracepoint for a task being migrated:
>   */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 102dfcf0a29a..c9d86fcc48f5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3374,6 +3374,7 @@ static void __sched notrace __schedule(bool preempt)
>  	int cpu;
>  
>  	cpu = smp_processor_id();
> +	trace_sched_schedule_enter(cpu);
>  	rq = cpu_rq(cpu);
>  	prev = rq->curr;
>  
> @@ -3448,6 +3449,7 @@ static void __sched notrace __schedule(bool preempt)
>  	}
>  
>  	balance_callback(rq);
> +	trace_sched_schedule_exit(cpu);
>  }
>  
>  void __noreturn do_task_dead(void)
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f5516bae0c1b..e328e045c6e8 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -224,6 +224,7 @@ static void cpuidle_idle_call(void)
>  static void do_idle(void)
>  {
>  	int cpu = smp_processor_id();
> +	trace_do_idle_enter(cpu);
>  	/*
>  	 * If the arch has a polling bit, we maintain an invariant:
>  	 *
> @@ -287,6 +288,7 @@ static void do_idle(void)
>  
>  	if (unlikely(klp_patch_pending(current)))
>  		klp_update_patch_state(current);
> +	trace_do_idle_exit(cpu);
>  }
>  
>  bool cpu_in_idle(unsigned long pc)
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2c92b3d9ea30..72ac53a47b1e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -44,6 +44,10 @@
>  #include <linux/trace.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/rt.h>
> +#include <linux/fsnotify.h>
> +#include <linux/workqueue.h>
> +#include <trace/events/power.h>
> +#include <trace/events/sched.h>
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -1481,6 +1485,166 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
>  
>  unsigned long __read_mostly	tracing_thresh;
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +
> +static const struct file_operations tracing_max_lat_fops;
> +static struct workqueue_struct *fsnotify_wq;
> +static DEFINE_PER_CPU(unsigned int, notify_disabled) = 1;
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
> +static inline void notrace trace_disable_fsnotify(void)
> +{
> +	int cpu;
> +	unsigned long flags;
> +
> +	raw_local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	per_cpu(notify_disabled, cpu) = 1;
> +	raw_local_irq_restore(flags);
> +}
> +
> +static inline void notrace trace_enable_fsnotify(void)
> +{
> +	int cpu;
> +	struct trace_array *tr;
> +	struct llist_head *list;
> +	struct llist_node *node;
> +	unsigned long flags;
> +
> +	raw_local_irq_save(flags);
> +	cpu = smp_processor_id();
> +	per_cpu(notify_disabled, cpu) = 0;
> +	raw_local_irq_restore(flags);
> +
> +	if (!per_cpu(notify_disabled, cpu)) {
> +		list = &per_cpu(notify_list, cpu);
> +		for (node = llist_del_first(list); node != NULL;
> +		     node = llist_del_first(list)) {
> +			tr = llist_entry(node, struct trace_array, notify_ll);
> +			atomic_set(&tr->notify_pending, 0);
> +			queue_work(fsnotify_wq, &tr->fsnotify_work);
> +		}
> +	}
> +}
> +
> +static void notrace probe_sched_enter(void *nihil, int cpu)
> +{
> +	trace_disable_fsnotify();
> +}
> +
> +static void notrace probe_sched_exit(void *nihil, int cpu)
> +{
> +	trace_enable_fsnotify();
> +}
> +
> +__init static int trace_maxlat_fsnotify_init(void)
> +{
> +	int ret;
> +
> +	ret = register_trace_sched_schedule_enter(probe_sched_enter, NULL);
> +	if (ret) {
> +		pr_info("tracing_max_latency: Could not activate tracepoint probe to sched_schedule_enter\n");
> +		return ret;
> +	}
> +
> +	ret = register_trace_sched_schedule_exit(probe_sched_exit, NULL);
> +	if (ret) {
> +		pr_info("tracing_max_latency: Could not activate tracepoint probe to sched_schedule_exit\n");
> +		goto fail_deprobe_sched_enter;
> +	}
> +
> +	ret = register_trace_do_idle_enter(probe_sched_enter, NULL);
> +	if (ret) {
> +		pr_info("tracing_max_latency: Could not activate tracepoint probe to do_idle_enter\n");
> +		goto fail_deprobe_sched_exit;
> +	}
> +
> +	ret = register_trace_do_idle_exit(probe_sched_exit, NULL);
> +	if (ret) {
> +		pr_info("tracing_max_latency: Could not activate tracepoint probe to do_idle_exit\n");
> +		goto fail_deprobe_idle_enter;
> +	}
> +
> +	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
> +				      WQ_UNBOUND | WQ_HIGHPRI, 0);
> +	if (fsnotify_wq)
> +		return 0;
> +
> +	ret = -ENOMEM;
> +
> +	pr_err("Unable to allocate tr_max_lat_wq\n");
> +
> +	unregister_trace_do_idle_exit(probe_sched_exit, NULL);
> +
> +fail_deprobe_idle_enter:
> +	unregister_trace_do_idle_enter(probe_sched_enter, NULL);
> +
> +fail_deprobe_sched_exit:
> +	unregister_trace_sched_schedule_exit(probe_sched_exit, NULL);
> +
> +fail_deprobe_sched_enter:
> +	unregister_trace_sched_schedule_enter(probe_sched_enter, NULL);
> +	return ret;
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
> +	if (!per_cpu(notify_disabled, cpu))
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
> @@ -1519,6 +1683,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  
>  	/* record this tasks comm */
>  	tracing_record_cmdline(tsk);
> +	trace_maxlat_fsnotify(tr);
>  }
>  
>  /**
> @@ -8533,8 +8698,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
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

