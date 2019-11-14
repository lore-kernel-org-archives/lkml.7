Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA49DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDF92070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKNRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKNRRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:17:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 202EF206F4;
        Thu, 14 Nov 2019 17:17:07 +0000 (UTC)
Date:   Thu, 14 Nov 2019 12:17:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Joe Jin <joe.jin@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: Re: [PATCH 4/5] tracing: Adding new functions for kernel access to
 Ftrace instances
Message-ID: <20191114121701.2a718786@gandalf.local.home>
In-Reply-To: <1573679762-7774-5-git-send-email-divya.indi@oracle.com>
References: <1573679762-7774-1-git-send-email-divya.indi@oracle.com>
        <1573679762-7774-2-git-send-email-divya.indi@oracle.com>
        <1573679762-7774-3-git-send-email-divya.indi@oracle.com>
        <1573679762-7774-4-git-send-email-divya.indi@oracle.com>
        <1573679762-7774-5-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 13:16:01 -0800
Divya Indi <divya.indi@oracle.com> wrote:

> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -297,12 +297,24 @@ static void __trace_array_put(struct trace_array *this_tr)
>  	this_tr->ref--;
>  }
>  
> +/**
> + * trace_array_put - Decrement the reference counter for this trace array.
> + *
> + * NOTE: Use this when we no longer need the trace array returned by
> + * trace_array_get_by_name(). This ensures the trace array can be later
> + * destroyed.
> + *
> + */
>  void trace_array_put(struct trace_array *this_tr)
>  {
> +	if (!this_tr)
> +		return;
> +
>  	mutex_lock(&trace_types_lock);
>  	__trace_array_put(this_tr);
>  	mutex_unlock(&trace_types_lock);
>  }
> +EXPORT_SYMBOL_GPL(trace_array_put);
>  
>  int call_filter_check_discard(struct trace_event_call *call, void *rec,
>  			      struct ring_buffer *buffer,
> @@ -8302,24 +8314,17 @@ static void update_tracer_options(struct trace_array *tr)
>  	mutex_unlock(&trace_types_lock);
>  }
>  
> -struct trace_array *trace_array_create(const char *name)
> +static struct trace_array *trace_array_create(const char *name)
>  {
>  	struct trace_array *tr;
>  	int ret;
>  
> -	mutex_lock(&event_mutex);
> -	mutex_lock(&trace_types_lock);
> -
> -	ret = -EEXIST;
> -	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> -		if (tr->name && strcmp(tr->name, name) == 0)
> -			goto out_unlock;
> -	}
> -
>  	ret = -ENOMEM;
>  	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
>  	if (!tr)
> -		goto out_unlock;
> +		return ERR_PTR(ret);
> +
> +	mutex_lock(&event_mutex);
>  
>  	tr->name = kstrdup(name, GFP_KERNEL);
>  	if (!tr->name)
> @@ -8364,7 +8369,8 @@ struct trace_array *trace_array_create(const char *name)
>  
>  	list_add(&tr->list, &ftrace_trace_arrays);
>  
> -	mutex_unlock(&trace_types_lock);
> +	tr->ref++;
> +
>  	mutex_unlock(&event_mutex);
>  
>  	return tr;
> @@ -8375,24 +8381,74 @@ struct trace_array *trace_array_create(const char *name)
>  	kfree(tr->name);
>  	kfree(tr);
>  
> - out_unlock:
> -	mutex_unlock(&trace_types_lock);
>  	mutex_unlock(&event_mutex);
>  
>  	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL_GPL(trace_array_create);
>  
>  static int instance_mkdir(const char *name)
>  {
> -	return PTR_ERR_OR_ZERO(trace_array_create(name));
> +	struct trace_array *tr;
> +	int ret;
> +
> +	mutex_lock(&trace_types_lock);
> +
> +	ret = -EEXIST;
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		if (tr->name && strcmp(tr->name, name) == 0)
> +			goto out_unlock;
> +	}
> +
> +	tr = trace_array_create(name);


You just changed the locking order here, which can cause a deadlock.
You can't take event_mutex after taking trace_types_lock. I applied
this, booted with lockdep enabled, loaded your sample module and
triggered this:


 e1000e: em1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
 IPv6: ADDRCONF(NETDEV_CHANGE): em1: link becomes ready
 L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
 
 ======================================================
 WARNING: possible circular locking dependency detected
 5.4.0-rc6-test+ #23 Not tainted
 ------------------------------------------------------
 modprobe/1569 is trying to acquire lock:
 ffffffff90677a80 (event_mutex){+.+.}, at: trace_array_create+0x47/0x230
 
 but task is already holding lock:
 ffffffff90674660 (trace_types_lock){+.+.}, at: trace_array_get_by_name+0x13/0x80
 
 which lock already depends on the new lock.
 
 
 the existing dependency chain (in reverse order) is:
 
 -> #1 (trace_types_lock){+.+.}:
        __mutex_lock+0x95/0x920
        trace_add_event_call+0x23/0xd0
        trace_probe_register_event_call+0x22/0x50
        trace_kprobe_create+0x681/0xa90
        create_or_delete_trace_kprobe+0xd/0x30
        trace_run_command+0x72/0x90
        kprobe_trace_self_tests_init+0x53/0x41c
        do_one_initcall+0x5d/0x314
        kernel_init_freeable+0x218/0x2dd
        kernel_init+0xa/0x100
        ret_from_fork+0x3a/0x50
 
 -> #0 (event_mutex){+.+.}:
        __lock_acquire+0xd17/0x14c0
        lock_acquire+0x9e/0x190
        __mutex_lock+0x95/0x920
        trace_array_create+0x47/0x230
        trace_array_get_by_name+0x4c/0x80
        sample_trace_array_init+0x12/0xfa8 [sample_trace_array]
        do_one_initcall+0x5d/0x314
        do_init_module+0x5a/0x220
        load_module+0x2172/0x2480
        __do_sys_finit_module+0xa8/0x110
        do_syscall_64+0x60/0x210
        entry_SYSCALL_64_after_hwframe+0x49/0xbe
 
 other info that might help us debug this:
 
  Possible unsafe locking scenario:
 
        CPU0                    CPU1
        ----                    ----
   lock(trace_types_lock);
                                lock(event_mutex);
                                lock(trace_types_lock);
   lock(event_mutex);
 
  *** DEADLOCK ***
 
 1 lock held by modprobe/1569:
  #0: ffffffff90674660 (trace_types_lock){+.+.}, at: trace_array_get_by_name+0x13/0x80
 
 stack backtrace:
 CPU: 2 PID: 1569 Comm: modprobe Not tainted 5.4.0-rc6-test+ #23
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 Call Trace:
  dump_stack+0x85/0xc0
  check_noncircular+0x172/0x190
  ? find_held_lock+0x2d/0x90
  __lock_acquire+0xd17/0x14c0
  lock_acquire+0x9e/0x190
  ? trace_array_create+0x47/0x230
  __mutex_lock+0x95/0x920
  ? trace_array_create+0x47/0x230
  ? fs_reclaim_release.part.99+0x5/0x20
  ? trace_array_create+0x47/0x230
  ? trace_array_create+0x2d/0x230
  ? rcu_read_lock_sched_held+0x52/0x80
  ? trace_array_create+0x47/0x230
  trace_array_create+0x47/0x230
  trace_array_get_by_name+0x4c/0x80
  ? trace_event_define_fields_sample_event+0x58/0x58 [sample_trace_array]
  sample_trace_array_init+0x12/0xfa8 [sample_trace_array]
  do_one_initcall+0x5d/0x314
  ? rcu_read_lock_sched_held+0x52/0x80
  ? kmem_cache_alloc_trace+0x278/0x2b0
  do_init_module+0x5a/0x220
  load_module+0x2172/0x2480
  ? vfs_read+0x11d/0x140
  ? __do_sys_finit_module+0xa8/0x110
  __do_sys_finit_module+0xa8/0x110
  do_syscall_64+0x60/0x210
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x7f6ba89b0efd
 Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5b 7f 0c 00 f7 d8 64 89 01 48

-- Steve

> +
> +	ret = PTR_ERR_OR_ZERO(tr);
> +
> +out_unlock:
> +	mutex_unlock(&trace_types_lock);
> +	return ret;
> +}
> +
> +/**
> + * trace_array_get_by_name - Create/Lookup a trace array, given its name.
> + * @name: The name of the trace array to be looked up/created.
> + *
> + * Returns pointer to trace array with given name.
> + * NULL, if it cannot be created.
> + *
> + * NOTE: This function increments the reference counter associated with the
> + * trace array returned. This makes sure it cannot be freed while in use.
> + * Use trace_array_put() once the trace array is no longer needed.
> + *
> + */
> +struct trace_array *trace_array_get_by_name(const char *name)
> +{
> +	struct trace_array *tr;
> +
> +	mutex_lock(&trace_types_lock);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> +		if (tr->name && strcmp(tr->name, name) == 0)
> +			goto out_unlock;
> +	}
> +
> +	tr = trace_array_create(name);
> +
> +	if (IS_ERR(tr))
> +		tr = NULL;
> +out_unlock:
> +	if (tr)
> +		tr->ref++;
> +	mutex_unlock(&trace_types_lock);
> +	return tr;
>  }
> +EXPORT_SYMBOL_GPL(trace_array_get_by_name);
>  
>  static int __remove_instance(struct trace_array *tr)
>  {
>  	int i;
>  
> -	if (tr->ref || (tr->current_trace && tr->current_trace->ref))
> +	/* Reference counter for a newly created trace array = 1. */
> +	if (tr->ref > 1 || (tr->current_trace && tr->current_trace->ref))
>  		return -EBUSY;
>  
>  	list_del(&tr->list);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 66ff63e..643faaa 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -338,7 +338,6 @@ enum {
>  extern struct mutex trace_types_lock;
>  
>  extern int trace_array_get(struct trace_array *tr);
> -extern void trace_array_put(struct trace_array *tr);
>  
>  extern int tracing_set_time_stamp_abs(struct trace_array *tr, bool abs);
>  extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 2621995..c58ef22 100644
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
> @@ -859,6 +858,32 @@ int trace_set_clr_event(const char *system, const char *event, int set)
>  }
>  EXPORT_SYMBOL_GPL(trace_set_clr_event);
>  
> +/**
> + * trace_array_set_clr_event - enable or disable an event for a trace array.
> + * @tr: concerned trace array.
> + * @system: system name to match (NULL for any system)
> + * @event: event name to match (NULL for all events, within system)
> + * @enable: true to enable, false to disable
> + *
> + * This is a way for other parts of the kernel to enable or disable
> + * event recording.
> + *
> + * Returns 0 on success, -EINVAL if the parameters do not match any
> + * registered events.
> + */
> +int trace_array_set_clr_event(struct trace_array *tr, const char *system,
> +		const char *event, bool enable)
> +{
> +	int set;
> +
> +	if (!tr)
> +		return -ENOENT;
> +
> +	set = (enable == true) ? 1 : 0;
> +	return __ftrace_set_clr_event(tr, NULL, system, event, set);
> +}
> +EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
> +
>  /* 128 should be much more than enough */
>  #define EVENT_BUF_SIZE		127
>  

