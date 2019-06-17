Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB908C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A04208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfFQXpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfFQXpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:45:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91AD20861;
        Mon, 17 Jun 2019 23:45:15 +0000 (UTC)
Date:   Mon, 17 Jun 2019 19:45:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH 3/3] tracing: Add 2 new funcs. for kernel access to
 Ftrace instances.
Message-ID: <20190617194514.2f760437@gandalf.local.home>
In-Reply-To: <1560357259-3497-4-git-send-email-divya.indi@oracle.com>
References: <1560357259-3497-1-git-send-email-divya.indi@oracle.com>
        <1560357259-3497-2-git-send-email-divya.indi@oracle.com>
        <1560357259-3497-3-git-send-email-divya.indi@oracle.com>
        <1560357259-3497-4-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 09:34:19 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Adding 2 new functions -
> 1) trace_array_lookup : Look up and return a trace array, given its
> name.
> 2) trace_array_set_clr_event : Enable/disable event recording to the
> given trace array.
> 
> Newly added functions trace_array_lookup and trace_array_create also
> need to increment the reference counter associated with the trace array
> they return. This is to ensure the trace array does not get freed
> while in use by the newly introduced APIs.
> The reference ctr is decremented in the trace_array_destroy.
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
>  include/linux/trace_events.h |  3 +++
>  kernel/trace/trace.c         | 30 +++++++++++++++++++++++++++++-
>  kernel/trace/trace_events.c  | 22 ++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d7b7d85..0cc99a8 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -545,7 +545,10 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
>  struct trace_array *trace_array_create(const char *name);
>  int trace_array_destroy(struct trace_array *tr);
>  int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
> +struct trace_array *trace_array_lookup(const char *name);
>  int trace_set_clr_event(const char *system, const char *event, int set);
> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
> +		const char *event, int set);
>  
>  /*
>   * The double __builtin_constant_p is because gcc will give us an error
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a60dc13..fb70ccc 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8364,6 +8364,8 @@ struct trace_array *trace_array_create(const char *name)
>  
>  	list_add(&tr->list, &ftrace_trace_arrays);
>  
> +	tr->ref++;
> +

Needs a comment for why the ref is incremented.


>  	mutex_unlock(&trace_types_lock);
>  	mutex_unlock(&event_mutex);
>  
> @@ -8385,7 +8387,14 @@ struct trace_array *trace_array_create(const char *name)
>  
>  static int instance_mkdir(const char *name)
>  {
> -	return PTR_ERR_OR_ZERO(trace_array_create(name));
> +	struct trace_array *tr;
> +
> +	tr = trace_array_create(name);
> +	if (IS_ERR(tr))
> +		return PTR_ERR(tr);
> +	trace_array_put(tr);

Need a comment to why we need to do a put here.

> +
> +	return 0;
>  }
>  
>  static int __remove_instance(struct trace_array *tr)
> @@ -8434,6 +8443,7 @@ int trace_array_destroy(struct trace_array *tr)
>  	mutex_lock(&event_mutex);
>  	mutex_lock(&trace_types_lock);
>  
> +	tr->ref--;
>  	ret = __remove_instance(tr);
>  
>  	mutex_unlock(&trace_types_lock);
> @@ -8465,6 +8475,24 @@ static int instance_rmdir(const char *name)
>  	return ret;
>  }
>  

Need a kerneldoc heading here, that also states that if a trace_array
is returned, it requires a call to trace_array_put().


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
> index 445b059..c126d2c 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -859,6 +859,28 @@ int trace_set_clr_event(const char *system, const char *event, int set)
>  }
>  EXPORT_SYMBOL_GPL(trace_set_clr_event);
>  
> +/**
> + * trace_array_set_clr_event - enable or disable an event for a trace array
> + * @system: system name to match (NULL for any system)
> + * @event: event name to match (NULL for all events, within system)
> + * @set: 1 to enable, 0 to disable
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
> +		return -ENODEV;

If we have this, should we get rid of the external use of
ftrace_set_clr_event()?

-- Steve

> +
> +	return __ftrace_set_clr_event(tr, NULL, system, event, set);
> +}
> +EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
> +
>  /* 128 should be much more than enough */
>  #define EVENT_BUF_SIZE		127
>  

