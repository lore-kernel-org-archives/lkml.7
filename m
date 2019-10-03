Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977BAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5850821A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J49N9JM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfJCKXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:23:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39240 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfJCKXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:23:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so1777385qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LtMK7Cq1E4KLaIv3SopDdw+33I8RpOxXp1hAtRM+T5I=;
        b=J49N9JM8GH32byD1cd+gd+Ac6cT2BruaoIomX/wksBT4JWGeMSv767HGKNHm7rRlTe
         wuBAOI3VnGVrldhBFKLdZOEbRE18AZwzvm12OFO/VY5zHzCxhaSlPVDV3THie5vAFnrq
         cSQ1fKiz4LnsPRcKbP0jcYgMBcKNfC1BhBvJDoX4Ec9fwibD7/E5AzWiDMBCNnsfMEei
         e8N/jjB8wgrGWR59N/gErbRw0U/5jVZdxmSApyJEQYVncnggSVbfbUd3uw4yyt2TS8mE
         mhqvZ8kinTw5auxTcnAFe+vwNploWdiC9FwqmgpJXU9jn60NCnNj/SWMtbGjkm2rjj4p
         VFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LtMK7Cq1E4KLaIv3SopDdw+33I8RpOxXp1hAtRM+T5I=;
        b=odryGIArWeAAKQuUJww0h4F+vTf/RTJ+znRICi6qjo6ceiYJSfBmvtU9UBlIvx2p9H
         Q+xMLUBDkMBHYtPOZdm71Eu6LFqfR8U3D+91Hm6EimUuNXMLz42pzh4QyftNLKfVL7rN
         WPPMNwFL+plLaTp2KukGd61+m6WRXnMrkFkHJMGNxp0G685SoEHhHozVk5O6hemw6epD
         HqUklwv9Pe0Q2O1Ds1TQWCooE+MrQGrxa6OEET+BdAcAIMSIyQZvOb4Z+dlzfmDryw5y
         AwKo2X0NsnjczSpVXRgDthVvAgChP7cVTfTBwbn8JqG1SfgcZf8YSY6a/o4xX6QEoGw0
         8kog==
X-Gm-Message-State: APjAAAUkQ4BuperZ82mI+TDJTOy460EXplNrafTa1iOLy+Drgw8WlgFG
        9Cv5z2+Zo7VYCGOVQwXnuLoMHhc=
X-Google-Smtp-Source: APXvYqxYl7VNjZ8l2Cl6b9vVIxOk/XRoNNy94Z1hjKqN1J1WEztBDHmQv06Mbuid55DGglZB/hirlg==
X-Received: by 2002:a37:ba86:: with SMTP id k128mr3464289qkf.402.1570098202486;
        Thu, 03 Oct 2019 03:23:22 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.186.151])
        by smtp.googlemail.com with ESMTPSA id j4sm1098443qkf.116.2019.10.03.03.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 03:23:21 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: Re: [PATCH v7 1/4] ftrace: Implement fs notification for
 tracing_max_latency
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
 <20190920152219.12920-2-viktor.rosendahl@gmail.com>
 <20191002003203.GA161396@google.com>
Message-ID: <ea371a1e-2916-7d6d-5ffa-3b1decb4e458@gmail.com>
Date:   Thu, 3 Oct 2019 12:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002003203.GA161396@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 2:32 AM, Joel Fernandes wrote:
> Some nits, but others looks good:
> 
> On Fri, Sep 20, 2019 at 05:22:16PM +0200, Viktor Rosendahl (BMW) wrote:
>> This patch implements the feature that the tracing_max_latency file,
>> e.g. /sys/kernel/debug/tracing/tracing_max_latency will receive
>> notifications through the fsnotify framework when a new latency is
>> available.
>>
>> One particularly interesting use of this facility is when enabling
>> threshold tracing, through /sys/kernel/debug/tracing/tracing_thresh,
>> together with the preempt/irqsoff tracers. This makes it possible to
>> implement a user space program that can, with equal probability,
>> obtain traces of latencies that occur immediately after each other in
>> spite of the fact that the preempt/irqsoff tracers operate in overwrite
>> mode.
>>
>> This facility works with the hwlat, preempt/irqsoff, and wakeup
>> tracers.
>>
>> The tracers may call the latency_fsnotify() from places such as
>> __schedule() or do_idle(); this makes it impossible to call
>> queue_work() directly without risking a deadlock. The same would
>> happen with a softirq,  kernel thread or tasklet. For this reason we
>> use the irq_work mechanism to call queue_work().
>>
>> This patch creates a new workqueue. The reason for doing this is that
>> I wanted to use the WQ_UNBOUND and WQ_HIGHPRI flags.  My thinking was
>> that WQ_UNBOUND might help with the latency in some important cases.
>>
>> If we use:
>>
>> queue_work(system_highpri_wq, &tr->fsnotify_work);
>>
>> then the work will (almost) always execute on the same CPU but if we are
>> unlucky that CPU could be too busy while there could be another CPU in
>> the system that would be able to process the work soon enough.
>>
>> queue_work_on() could be used to queue the work on another CPU but it
>> seems difficult to select the right CPU.
>>
>> Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
>> ---
>>   kernel/trace/trace.c       | 75 +++++++++++++++++++++++++++++++++++++-
>>   kernel/trace/trace.h       | 18 +++++++++
>>   kernel/trace/trace_hwlat.c |  4 +-
>>   3 files changed, 94 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 947ba433865f..2d2150bf0d42 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -44,6 +44,9 @@
>>   #include <linux/trace.h>
>>   #include <linux/sched/clock.h>
>>   #include <linux/sched/rt.h>
>> +#include <linux/fsnotify.h>
>> +#include <linux/irq_work.h>
>> +#include <linux/workqueue.h>
>>   
>>   #include "trace.h"
>>   #include "trace_output.h"
>> @@ -1480,6 +1483,74 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
>>   
>>   unsigned long __read_mostly	tracing_thresh;
>>   
>> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
>> +	defined(CONFIG_FSNOTIFY)
>> +
>> +static const struct file_operations tracing_max_lat_fops;
>> +static struct workqueue_struct *fsnotify_wq;
>> +
>> +static void latency_fsnotify_workfn(struct work_struct *work)
>> +{
>> +	struct trace_array *tr = container_of(work, struct trace_array,
>> +					      fsnotify_work);
>> +	fsnotify(tr->d_max_latency->d_inode, FS_MODIFY,
>> +		 tr->d_max_latency->d_inode, FSNOTIFY_EVENT_INODE, NULL, 0);
>> +}
>> +
>> +static void latency_fsnotify_workfn_irq(struct irq_work *iwork)
>> +{
>> +	struct trace_array *tr = container_of(iwork, struct trace_array,
>> +					      fsnotify_irqwork);
>> +	queue_work(fsnotify_wq, &tr->fsnotify_work);
>> +}
>> +
>> +static void trace_create_maxlat_file(struct trace_array *tr,
>> +				     struct dentry *d_tracer)
>> +{
>> +	INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
>> +	init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
>> +	tr->d_max_latency = trace_create_file("tracing_max_latency", 0644,
>> +					      d_tracer, &tr->max_latency,
>> +					      &tracing_max_lat_fops);
>> +}
>> +
>> +__init static int latency_fsnotify_init(void)
>> +{
>> +	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
>> +				      WQ_UNBOUND | WQ_HIGHPRI, 0);
>> +	if (!fsnotify_wq) {
>> +		pr_err("Unable to allocate tr_max_lat_wq\n");
>> +		return -ENOMEM;
>> +	}
>> +	return 0;
>> +}
>> +
>> +late_initcall_sync(latency_fsnotify_init);
>> +
>> +void latency_fsnotify(struct trace_array *tr)
>> +{
>> +	if (!fsnotify_wq)
>> +		return;
>> +	/*
>> +	 * We cannot call queue_work(&tr->fsnotify_work) from here because it's
>> +	 * possible that we are called from __schedule() or do_idle(), which
>> +	 * could cause a deadlock.
>> +	 */
>> +	irq_work_queue(&tr->fsnotify_irqwork);
>> +}
>> +
>> +/*
>> + * (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
>> + *  defined(CONFIG_FSNOTIFY)
>> + */
>> +#else
>> +
>> +#define trace_create_maxlat_file(tr, d_tracer)				\
>> +	trace_create_file("tracing_max_latency", 0644, d_tracer,	\
>> +			  &tr->max_latency, &tracing_max_lat_fops)
> 
> I would forward declare tracing_max_lat_fops here as well like you are doing
> in the #if section. This has 2 advantages:
> 
> 1. It keeps it consistent with the #if block.
> 2. It prevents future breakages where trace_create_maxlat_file() might be
>     called before tracing_max_lat_fops is defined.
> 

Good catch. I think I will just move the forward declaration in the #if
section so that it is immediately before the #if section, since shorter
is nicer and it seems weird to repeat the same line twice.

>> +
>> +#endif
>> +
>>   #ifdef CONFIG_TRACER_MAX_TRACE
>>   /*
>>    * Copy the new maximum trace into the separate maximum-trace
>> @@ -1518,6 +1589,7 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>>   
>>   	/* record this tasks comm */
>>   	tracing_record_cmdline(tsk);
>> +	latency_fsnotify(tr);
>>   }
>>   
>>   /**
>> @@ -8550,8 +8622,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>>   	create_trace_options_dir(tr);
>>   
>>   #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>> -	trace_create_file("tracing_max_latency", 0644, d_tracer,
>> -			&tr->max_latency, &tracing_max_lat_fops);
>> +	trace_create_maxlat_file(tr, d_tracer);
>>   #endif
>>   
>>   	if (ftrace_create_function_files(tr, d_tracer))
>> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
>> index 005f08629b8b..4913ed1138aa 100644
>> --- a/kernel/trace/trace.h
>> +++ b/kernel/trace/trace.h
>> @@ -16,6 +16,8 @@
>>   #include <linux/trace_events.h>
>>   #include <linux/compiler.h>
>>   #include <linux/glob.h>
>> +#include <linux/irq_work.h>
>> +#include <linux/workqueue.h>
>>   
>>   #ifdef CONFIG_FTRACE_SYSCALLS
>>   #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
>> @@ -264,6 +266,11 @@ struct trace_array {
>>   #endif
>>   #if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
>>   	unsigned long		max_latency;
>> +#ifdef CONFIG_FSNOTIFY
>> +	struct dentry		*d_max_latency;
>> +	struct work_struct	fsnotify_work;
>> +	struct irq_work		fsnotify_irqwork;
>> +#endif
>>   #endif
>>   	struct trace_pid_list	__rcu *filtered_pids;
>>   	/*
>> @@ -785,6 +792,17 @@ void update_max_tr_single(struct trace_array *tr,
>>   			  struct task_struct *tsk, int cpu);
>>   #endif /* CONFIG_TRACER_MAX_TRACE */
>>   
>> +#if (defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)) && \
>> +	defined(CONFIG_FSNOTIFY)
>> +
>> +void latency_fsnotify(struct trace_array *tr);
>> +
>> +#else
>> +
>> +#define latency_fsnotify(tr)     do { } while (0)
> 
> Please define the NOOP as a function so that compiler checks the arguments.
> 
> So:
> static void latency_fsnotify(struct trace_array *tr) { }

Ok, I will fix it in the next iteration.

best regards,

Viktor

> 
> Other than these nits, the patch looks fine to me.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> thanks,
> 
>   - Joel
>   
> 

