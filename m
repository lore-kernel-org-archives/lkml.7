Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2251FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA274206E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfLCQ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfLCQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:27:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166BE2068E;
        Tue,  3 Dec 2019 16:27:32 +0000 (UTC)
Date:   Tue, 3 Dec 2019 11:27:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        kaushalk@codeaurora.org
Subject: Re: [PATCH] trace: circular dependency for trace_types_lock and
 event_mutex
Message-ID: <20191203112730.77b334f6@gandalf.local.home>
In-Reply-To: <0101016ecc80a1fa-27cc3e87-c16d-4cd6-b3c6-9c893010fdef-000000@us-west-2.amazonses.com>
References: <0101016ecc80a1fa-27cc3e87-c16d-4cd6-b3c6-9c893010fdef-000000@us-west-2.amazonses.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Prateek,

Thanks for the patch. Note, I think a better subject is:

 tracing: Fix lock inversion caused by trace_event_enable_tgid_record()


On Tue, 3 Dec 2019 16:03:32 +0000
Prateek Sood <prsood@codeaurora.org> wrote:

>        Task T2                             Task T3
> trace_options_core_write()            subsystem_open()
> 
>  mutex_lock(trace_types_lock)           mutex_lock(event_mutex)
> 
>  set_tracer_flag()
> 
>    trace_event_enable_tgid_record()       mutex_lock(trace_types_lock)
> 
>     mutex_lock(event_mutex)
> 
> This gives a circular dependency deadlock between trace_types_lock and
> event_mutex. To fix this invert the usage of trace_types_lock and event_mutex
> in trace_options_core_write(). This keeps the sequence of lock usage consistent.
> 
> Change-Id: I3752a77c59555852c2241f7775ec4a1960c15c15

What's this Change-Id? Something internal?

I'll be adding:

 Link: http://lkml.kernel.org/r/0101016ecc80a1fa-27cc3e87-c16d-4cd6-b3c6-9c893010fdef-000000@us-west-2.amazonses.com

I'll test this out, and probably even add a stable tag.

-- Steve



> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> ---
>  kernel/trace/trace.c              | 6 ++++++
>  kernel/trace/trace_events.c       | 8 ++++----
>  kernel/trace/trace_irqsoff.c      | 4 ++++
>  kernel/trace/trace_sched_wakeup.c | 4 ++++
>  4 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6a0ee91..2c09aa1 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4590,6 +4590,8 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
>  
>  int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
>  {
> +	lockdep_assert_held(&event_mutex);
> +
>  	/* do nothing if flag is already set */
>  	if (!!(tr->trace_flags & mask) == !!enabled)
>  		return 0;
> @@ -4657,6 +4659,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
>  
>  	cmp += len;
>  
> +	mutex_lock(&event_mutex);
>  	mutex_lock(&trace_types_lock);
>  
>  	ret = match_string(trace_options, -1, cmp);
> @@ -4667,6 +4670,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
>  		ret = set_tracer_flag(tr, 1 << ret, !neg);
>  
>  	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>  
>  	/*
>  	 * If the first trailing whitespace is replaced with '\0' by strstrip,
> @@ -7972,9 +7976,11 @@ static void get_tr_index(void *data, struct trace_array **ptr,
>  	if (val != 0 && val != 1)
>  		return -EINVAL;
>  
> +	mutex_lock(&event_mutex);
>  	mutex_lock(&trace_types_lock);
>  	ret = set_tracer_flag(tr, 1 << index, val);
>  	mutex_unlock(&trace_types_lock);
> +	mutex_unlock(&event_mutex);
>  
>  	if (ret < 0)
>  		return ret;
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index fba87d1..995061b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -320,7 +320,8 @@ void trace_event_enable_cmd_record(bool enable)
>  	struct trace_event_file *file;
>  	struct trace_array *tr;
>  
> -	mutex_lock(&event_mutex);
> +	lockdep_assert_held(&event_mutex);
> +
>  	do_for_each_event_file(tr, file) {
>  
>  		if (!(file->flags & EVENT_FILE_FL_ENABLED))
> @@ -334,7 +335,6 @@ void trace_event_enable_cmd_record(bool enable)
>  			clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
>  		}
>  	} while_for_each_event_file();
> -	mutex_unlock(&event_mutex);
>  }
>  
>  void trace_event_enable_tgid_record(bool enable)
> @@ -342,7 +342,8 @@ void trace_event_enable_tgid_record(bool enable)
>  	struct trace_event_file *file;
>  	struct trace_array *tr;
>  
> -	mutex_lock(&event_mutex);
> +	lockdep_assert_held(&event_mutex);
> +
>  	do_for_each_event_file(tr, file) {
>  		if (!(file->flags & EVENT_FILE_FL_ENABLED))
>  			continue;
> @@ -356,7 +357,6 @@ void trace_event_enable_tgid_record(bool enable)
>  				  &file->flags);
>  		}
>  	} while_for_each_event_file();
> -	mutex_unlock(&event_mutex);
>  }
>  
>  static int __ftrace_event_enable_disable(struct trace_event_file *file,
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index a745b0c..887cdb5 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -560,8 +560,10 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
>  	save_flags = tr->trace_flags;
>  
>  	/* non overwrite screws up the latency tracers */
> +	mutex_lock(&event_mutex);
>  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
>  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
> +	mutex_unlock(&event_mutex);
>  
>  	tr->max_latency = 0;
>  	irqsoff_trace = tr;
> @@ -586,8 +588,10 @@ static void __irqsoff_tracer_reset(struct trace_array *tr)
>  
>  	stop_irqsoff_tracer(tr, is_graph(tr));
>  
> +	mutex_lock(&event_mutex);
>  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
>  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
> +	mutex_unlock(&event_mutex);
>  	ftrace_reset_array_ops(tr);
>  
>  	irqsoff_busy = false;
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index 5e43b96..0bc67d1 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -671,8 +671,10 @@ static int __wakeup_tracer_init(struct trace_array *tr)
>  	save_flags = tr->trace_flags;
>  
>  	/* non overwrite screws up the latency tracers */
> +	mutex_lock(&event_mutex);
>  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
>  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
> +	mutex_unlock(&event_mutex);
>  
>  	tr->max_latency = 0;
>  	wakeup_trace = tr;
> @@ -722,8 +724,10 @@ static void wakeup_tracer_reset(struct trace_array *tr)
>  	/* make sure we put back any tasks we are tracing */
>  	wakeup_reset(tr);
>  
> +	mutex_lock(&event_mutex);
>  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
>  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
> +	mutex_unlock(&event_mutex);
>  	ftrace_reset_array_ops(tr);
>  	wakeup_busy = false;
>  }

