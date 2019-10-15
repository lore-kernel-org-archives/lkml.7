Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDF2ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FC920663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 23:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfJOXTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfJOXTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 19:19:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8D0B20663;
        Tue, 15 Oct 2019 23:19:20 +0000 (UTC)
Date:   Tue, 15 Oct 2019 19:19:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH 5/5] tracing: New functions for kernel access to Ftrace
 instances
Message-ID: <20191015191917.6287ba10@gandalf.local.home>
In-Reply-To: <1565805327-579-6-git-send-email-divya.indi@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
        <1565805327-579-6-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 10:55:27 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Adding 2 new functions -
> 1) trace_array_lookup : Look up and return a trace array, given its
> name.
> 2) trace_array_set_clr_event : Enable/disable event recording to the
> given trace array.
> 
> NOTE: trace_array_lookup returns a trace array and also increments the
> reference counter associated with the returned trace array. Make sure to
> call trace_array_put() once the use is done so that the instance can be
> removed at a later time.
> 
> Example use:
> 
> tr = trace_array_lookup("foo-bar");

Should probably be renamed to: trace_array_get_by_name("foo-bar")

As the name should show that it adds a ref count.

But if we make the change I suggested before, where we do not need to
do the put before calling the destroy, we should have:


> if (!tr)
{
> 	tr = trace_array_create("foo-bar");
	trace_array_get(tr);
}


> // Log to tr
> // Enable/disable events to tr
> trace_array_set_clr_event(tr, _THIS_IP,"system","event",1);

What's with the __THIS_IP?


> 
> // Done using tr
> trace_array_put(tr);
> ..
> 
> Also, use trace_array_set_clr_event to enable/disable events to a trace array.
> So now we no longer need to have ftrace_set_clr_event as an exported
> API.
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
>  include/linux/trace.h        |  2 ++
>  include/linux/trace_events.h |  3 ++-
>  kernel/trace/trace.c         | 28 ++++++++++++++++++++++++++++
>  kernel/trace/trace_events.c  | 23 ++++++++++++++++++++++-
>  4 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index 2c782d5..05164bb 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -32,6 +32,8 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
>  struct trace_array *trace_array_create(const char *name);
>  int trace_array_destroy(struct trace_array *tr);
>  void trace_array_put(struct trace_array *tr);
> +struct trace_array *trace_array_lookup(const char *name);
> +
>  #endif	/* CONFIG_TRACING */
>  
>  #endif	/* _LINUX_TRACE_H */
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 8a62731..05a7514 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -540,7 +540,8 @@ extern int trace_define_field(struct trace_event_call *call, const char *type,
>  #define is_signed_type(type)	(((type)(-1)) < (type)1)
>  
>  int trace_set_clr_event(const char *system, const char *event, int set);
> -
> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
> +		const char *event, int set);
>  /*
>   * The double __builtin_constant_p is because gcc will give us an error
>   * if we try to allocate the static variable to fmt if it is not a
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7b6a37a..e394d55 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8514,6 +8514,34 @@ static int instance_rmdir(const char *name)
>  	return ret;
>  }
>  
> +/**
> + * trace_array_lookup - Lookup the trace array, given its name.
> + * @name: The name of the trace array to be looked up.
> + *
> + * Lookup and return the trace array associated with @name.
> + *
> + * NOTE: The reference counter associated with the returned trace array is
> + * incremented to ensure it is not freed when in use. Make sure to call
> + * "trace_array_put" for this trace array when its use is done.
> + */
> +struct trace_array *trace_array_lookup(const char *name)
> +{
> +	struct trace_array *tr;
> +
> +	mutex_lock(&trace_types_lock);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		if (tr->name && strcmp(tr->name, name) == 0) {
> +			tr->ref++;
> +			mutex_unlock(&trace_types_lock);
> +			return tr;
> +		}
> +	}
> +	mutex_unlock(&trace_types_lock);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(trace_array_lookup);
> +
>  static __init void create_trace_instances(struct dentry *d_tracer)
>  {
>  	trace_instance_dir = tracefs_create_instance_dir("instances", d_tracer,
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 2621995..96dd997 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -834,7 +834,6 @@ static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(ftrace_set_clr_event);
>  
>  /**
>   * trace_set_clr_event - enable or disable an event
> @@ -859,6 +858,28 @@ int trace_set_clr_event(const char *system, const char *event, int set)
>  }
>  EXPORT_SYMBOL_GPL(trace_set_clr_event);
>  
> +/**
> + * trace_array_set_clr_event - enable or disable an event for a trace array
> + * @system: system name to match (NULL for any system)
> + * @event: event name to match (NULL for all events, within system)
> + * @set: 1 to enable, 0 to disable

We probably should make this a boolean.

-- Steve

> + *
> + * This is a way for other parts of the kernel to enable or disable
> + * event recording to instances.
> + *
> + * Returns 0 on success, -EINVAL if the parameters do not match any
> + * registered events.
> + */
> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
> +		const char *event, int set)
> +{
> +	if (!tr)
> +		return -ENOENT;
> +
> +	return __ftrace_set_clr_event(tr, NULL, system, event, set);
> +}
> +EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
> +
>  /* 128 should be much more than enough */
>  #define EVENT_BUF_SIZE		127
>  

