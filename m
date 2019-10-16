Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D50ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2392067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XJKK6FTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbfJPAlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 20:41:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33052 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbfJPAlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:41:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id i76so13184880pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toaWt255ghv6cb+PoJwK8A9VrwzHjs2MDe8R7d2MRtg=;
        b=XJKK6FTiSvwPD9yfCfXLbaZZYVHq609sb1Je1MUsmif01wfAcTfeHTTlI9NbhWDUGR
         JRTKRv0kBOd/MoneyMCVlRzOMP3LLa4LWkF8KjD2hnVoQqV01pWNG4ledERcDcoabppa
         J74MjR23clhinDwzYyp1bjXnQEQWphO0qraeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=toaWt255ghv6cb+PoJwK8A9VrwzHjs2MDe8R7d2MRtg=;
        b=k/FD8xbH2DIocZzxCr/Z/hAEYH7C1tlsJoABuC5NAX98buDcsHFDJLkOwSTtjjsh+2
         UQeHZz7uZJcHd1pV6stbHdG19ITHwW98s8EkdYlRv0OEBPAuqTGadmHdR0VhNjAyoZuQ
         BsdcVntcDhnDnTztS9IRNjzrzruk8vHVlBnGTeVkGxKb84bDq6uvZBR4CH05YqpXIsz6
         0mvRxWBmGbObEKJRpT7iVdT/kNKt1EDNVqUileCY0kgEouMWd23JjWaVkhWJruaI44bs
         50hCPoYpp27FMWDq050Z23oScXiM0ZcDc4KEhYr5Y8QfCxR2m4Nhnyzma8tJ+OvBeEII
         O7nQ==
X-Gm-Message-State: APjAAAXcT6cf4jLy0rq3KmDyBjoqWcD9M+4vRJHS7Ox+dc8GzqSRQ2Rt
        dtrZ1YGsJk9tq5HxcsaftD20yQ==
X-Google-Smtp-Source: APXvYqwFcvaaV36doulgEryuuq7oZbELzlSQ+8b8BE56grIVsffTPuVFvWQbax6XqP4fAMoFiBalkA==
X-Received: by 2002:a17:90a:8a89:: with SMTP id x9mr1504735pjn.95.1571186482247;
        Tue, 15 Oct 2019 17:41:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q33sm22275168pgm.50.2019.10.15.17.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 17:41:21 -0700 (PDT)
Date:   Tue, 15 Oct 2019 20:41:20 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20191016004120.GD89937@google.com>
References: <20191015111910.4496-1-viktor.rosendahl@gmail.com>
 <20191015111910.4496-2-viktor.rosendahl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015111910.4496-2-viktor.rosendahl@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:19:07PM +0200, Viktor Rosendahl (BMW) wrote:
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
> This facility works with the preempt/irqsoff, and wakeup tracers.
> 
> The tracers may call the latency_fsnotify() from places such as
> __schedule() or do_idle(); this makes it impossible to call
> queue_work() directly without risking a deadlock. The same would
> happen with a softirq,  kernel thread or tasklet. For this reason we
> use the irq_work mechanism to call queue_work().
> 
> This patch creates a new workqueue. The reason for doing this is that
> I wanted to use the WQ_UNBOUND and WQ_HIGHPRI flags.  My thinking was
> that WQ_UNBOUND might help with the latency in some important cases.
> 
> If we use:
> 
> queue_work(system_highpri_wq, &tr->fsnotify_work);
> 
> then the work will (almost) always execute on the same CPU but if we are
> unlucky that CPU could be too busy while there could be another CPU in
> the system that would be able to process the work soon enough.
> 
> queue_work_on() could be used to queue the work on another CPU but it
> seems difficult to select the right CPU.
> 
> Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
> ---
>  kernel/trace/trace.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
>  kernel/trace/trace.h | 18 +++++++++++
>  2 files changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6a0ee9178365..523e3e57f1d4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -45,6 +45,9 @@
>  #include <linux/trace.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/rt.h>
> +#include <linux/fsnotify.h>
> +#include <linux/irq_work.h>
> +#include <linux/workqueue.h>
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -1497,6 +1500,74 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
>  }
>  
>  unsigned long __read_mostly	tracing_thresh;
> +static const struct file_operations tracing_max_lat_fops;
> +
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)

Something bothers me. If you dropped support for HWLAT_TRACER as you
mentioned in the cover letter, then why does this #if look for the CONFIG
option?

(and similar comment on the rest of the patch..)

thanks,

 - Joel

> +
> +static struct workqueue_struct *fsnotify_wq;
> +
> +static void latency_fsnotify_workfn(struct work_struct *work)
> +{
> +	struct trace_array *tr = container_of(work, struct trace_array,
> +					      fsnotify_work);
> +	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
> +		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +}
> +
> +static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
> +{
> +	struct trace_array *tr = container_of(iwork, struct trace_array,
> +					      fsnotify_irqwork);
> +	queue_work(fsnotify_wq, &tr->fsnotify_work);
> +}
> +
> +static void trace_create_maxlat_file(struct trace_array *tr,
> +				     struct dentry *d_tracer)
> +{
> +	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
> +	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
> +	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
> +					      d_tracer, &tr->max_latency,
> +					      &tracing_max_lat_fops);
> +}
> +
> +__init static int latency_fsnotify_init(void)
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
> +late_initcall_sync(latency_fsnotify_init);
> +
> +void latency_fsnotify(struct trace_array *tr)
> +{
> +	if (!fsnotify_wq)
> +		return;
> +	/*
> +	 * We cannot call queue_work(&tr->fsnotify_work) from here because it's
> +	 * possible that we are called from __schedule() or do_idle(), which
> +	 * could cause a deadlock.
> +	 */
> +	irq_work_queue(&tr->fsnotify_irqwork);
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
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
>  /*
> @@ -1536,6 +1607,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  
>  	/* record this tasks comm */
>  	tracing_record_cmdline(tsk);
> +	latency_fsnotify(tr);
>  }
>  
>  /**
> @@ -8585,8 +8657,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
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
> index d685c61085c0..2fb9b7353a99 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -16,6 +16,8 @@
>  #include <linux/trace_events.h>
>  #include <linux/compiler.h>
>  #include <linux/glob.h>
> +#include <linux/irq_work.h>
> +#include <linux/workqueue.h>
>  
>  #ifdef CONFIG_FTRACE_SYSCALLS
>  #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
> @@ -264,6 +266,11 @@ struct trace_array {
>  #endif
>  #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>  	unsigned long		max_latency;
> +#ifdef CONFIG_FSNOTIFY
> +	struct dentry		*d_max_latency;
> +	struct work_struct	fsnotify_work;
> +	struct irq_work		fsnotify_irqwork;
> +#endif
>  #endif
>  	struct trace_pid_list	__rcu *filtered_pids;
>  	/*
> @@ -786,6 +793,17 @@ void update_max_tr_single(struct trace_array *tr,
>  			  struct task_struct *tsk, int cpu);
>  #endif /* CONFIG_TRACER_MAX_TRACE */
>  
> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
> +	defined(CONFIG_FSNOTIFY)
> +
> +void latency_fsnotify(struct trace_array *tr);
> +
> +#else
> +
> +static void latency_fsnotify(struct trace_array *tr) { }
> +
> +#endif
> +
>  #ifdef CONFIG_STACKTRACE
>  void __trace_stack(struct trace_array *tr, unsigned long flags, int skip,
>  		   int pc);
> -- 
> 2.17.1
> 
