Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A55ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 23:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D6520659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 23:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390180AbfJOXEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387708AbfJOXEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 19:04:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D643A20659;
        Tue, 15 Oct 2019 23:04:38 +0000 (UTC)
Date:   Tue, 15 Oct 2019 19:04:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH 4/5] tracing: Handle the trace array ref counter in new
 functions
Message-ID: <20191015190436.65c8c7a3@gandalf.local.home>
In-Reply-To: <1565805327-579-5-git-send-email-divya.indi@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
        <1565805327-579-5-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for taking so long to getting to these patches.

On Wed, 14 Aug 2019 10:55:26 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> For functions returning a trace array Eg: trace_array_create(), we need to
> increment the reference counter associated with the trace array to ensure it
> does not get freed when in use.
> 
> Once we are done using the trace array, we need to call
> trace_array_put() to make sure we are not holding a reference to it
> anymore and the instance/trace array can be removed when required.

I think it would be more in line with other parts of the kernel if we
don't need to do the trace_array_put() before calling
trace_array_destroy().

That is, if we make the following change:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5ff206ce259e..ae12aac21c6c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8527,9 +8527,11 @@ static int __remove_instance(struct trace_array *tr)
 {
 	int i;
 
-	if (tr->ref || (tr->current_trace && tr->current_trace->ref))
+	if (tr->ref > 1 || (tr->current_trace && tr->current_trace->ref))
 		return -EBUSY;
 
+	WARN_ON_ONCE(tr->ref != 1);
+
 	list_del(&tr->list);
 
 	/* Disable all the flags that were enabled coming in */

> 
> Hence, additionally exporting trace_array_put().
> 
> Example use:
> 
> tr = trace_array_create("foo-bar");
> // Use this trace array
> // Log to this trace array or enable/disable events to this trace array.
> ....
> ....
> // tr no longer required
> trace_array_put();
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> ---
>  include/linux/trace.h |  1 +
>  kernel/trace/trace.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index 24fcf07..2c782d5 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -31,6 +31,7 @@ int trace_array_printk(struct trace_array *tr, unsigned long ip,
>  		const char *fmt, ...);
>  struct trace_array *trace_array_create(const char *name);
>  int trace_array_destroy(struct trace_array *tr);
> +void trace_array_put(struct trace_array *tr);
>  #endif	/* CONFIG_TRACING */
>  
>  #endif	/* _LINUX_TRACE_H */
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 22bf166..7b6a37a 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -297,12 +297,22 @@ static void __trace_array_put(struct trace_array *this_tr)
>  	this_tr->ref--;
>  }
>  
> +/**
> + * trace_array_put - Decrement reference counter for the given trace array.
> + * @tr: Trace array for which reference counter needs to decrement.
> + *
> + * NOTE: Functions like trace_array_create increment the reference counter for
> + * the trace array to ensure they do not get freed while in use. Make sure to
> + * call trace_array_put() when the use is done. This will ensure that the
> + * instance can be later removed.
> + */
>  void trace_array_put(struct trace_array *this_tr)
>  {
>  	mutex_lock(&trace_types_lock);
>  	__trace_array_put(this_tr);
>  	mutex_unlock(&trace_types_lock);
>  }
> +EXPORT_SYMBOL_GPL(trace_array_put);
>  
>  int call_filter_check_discard(struct trace_event_call *call, void *rec,
>  			      struct ring_buffer *buffer,
> @@ -8302,6 +8312,16 @@ static void update_tracer_options(struct trace_array *tr)
>  	mutex_unlock(&trace_types_lock);
>  }
>  
> +/**
> + * trace_array_create - Create a new trace array with the given name.
> + * @name: The name of the trace array to be created.
> + *
> + * Create and return a trace array with given name if it does not exist.
> + *
> + * NOTE: The reference counter associated with the returned trace array is
> + * incremented to ensure it is not freed when in use. Make sure to call
> + * "trace_array_put" for this trace array when its use is done.
> + */
>  struct trace_array *trace_array_create(const char *name)
>  {
>  	struct trace_array *tr;
> @@ -8364,6 +8384,8 @@ struct trace_array *trace_array_create(const char *name)
>  
>  	list_add(&tr->list, &ftrace_trace_arrays);
>  
> +	tr->ref++;
> +
>  	mutex_unlock(&trace_types_lock);
>  	mutex_unlock(&event_mutex);
>  
> @@ -8385,7 +8407,19 @@ struct trace_array *trace_array_create(const char *name)
>  
>  static int instance_mkdir(const char *name)
>  {
> -	return PTR_ERR_OR_ZERO(trace_array_create(name));
> +	struct trace_array *tr;
> +
> +	tr = trace_array_create(name);
> +	if (IS_ERR(tr))
> +		return PTR_ERR(tr);
> +
> +	/* This function does not return a reference to the created trace array,
> +	 * so the reference counter is to be 0 when it returns.
> +	 * trace_array_create increments the ref counter, decrement it here
> +	 * by calling trace_array_put() */
> +	trace_array_put(tr);
> +

If we make it that the destroy needs tr->ref == 1, we can remove the
above.

> +	return 0;
>  }
>  
>  static int __remove_instance(struct trace_array *tr)
> @@ -8424,6 +8458,11 @@ static int __remove_instance(struct trace_array *tr)
>  	return 0;
>  }
>  
> +/*
> + * NOTE: An instance cannot be removed if there is still a reference to it.
> + * Make sure to call "trace_array_put" for a trace array returned by functions
> + * like trace_array_create(), otherwise trace_array_destroy will not succeed.
> + */

And remove the above comment too.

-- Steve

>  int trace_array_destroy(struct trace_array *this_tr)
>  {
>  	struct trace_array *tr;

