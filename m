Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37543C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13FE21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ad6j8D/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfCUMHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:07:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43841 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfCUMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:07:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id v32so6213308qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmLxNvHglUGHNpHUKmRi7iiO4J3SVPDfcA7k8hgaYTo=;
        b=Ad6j8D/FENFz01hanNDFZpe794+GYeb1V9F3BlCHlcumhZQtVg34QkFupg/zCEca+4
         qHY8hcySqKD43FNnCk88GS4UwAopJIte+uStD9LRsfBYrRE2mV+S37epQkuNJyyayV8/
         ha4FC+zytQQ6IUQj6GoRGIvN9mnuTZgtXD/3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmLxNvHglUGHNpHUKmRi7iiO4J3SVPDfcA7k8hgaYTo=;
        b=HKVqw+KGFCd77QeS/79F1PFOmdGXAZ50OGvbt/Ay7EW/YuXYwi1zQkLzuZ/SeWBhHS
         doaPSxNSsenbzlQroNn71xGOORiPeTJMV3mhixHcJJtrNWJBW7VG7JMnZEJ27JwEXstW
         LRWCo3P5ou+ia3Qq42e6539dQRBGWQskiC0qlSUhNSniXgOfXhERwHgNt1l5oqFytF3y
         7tQHkHFcfNxHgpmlTYmCgpXPUNVMNBoVeK27M+hcmbzLRZ7joMP2hct+sblnT2tcgQ90
         qMppqBQzIwRhkgKTFkMxDK3ocnb7U+jbgGtnqcDOtQ8PKhyBEjkaClM7nRxrFQO2BAsp
         vNlw==
X-Gm-Message-State: APjAAAUt6lGRdGsC8Mbx8eMdmq1xh08US9t2eItdu5/PBmTvh+YYutJX
        Jhy5IBfmNju998fwRzxL7ngmHA==
X-Google-Smtp-Source: APXvYqxPzC1Wjh3zAfziZLhhzWEh01AGt5v1yLe2YbUlIFHOzu3LDN/T95y65Ydvx/1As/NI5KR99A==
X-Received: by 2002:ac8:21c7:: with SMTP id 7mr1270433qtz.66.1553170018348;
        Thu, 21 Mar 2019 05:06:58 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id u24sm3102693qku.85.2019.03.21.05.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 05:06:57 -0700 (PDT)
Date:   Thu, 21 Mar 2019 08:06:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, tglx@linutronix.de,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mike Galbraith <bitbucket@online.de>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Allow to eliminate softirq processing from rcutree
Message-ID: <20190321120656.GA61489@google.com>
References: <20190315111130.4902-1-bigeasy@linutronix.de>
 <20190320002613.GA129907@google.com>
 <20190320112835.prq22vsto3ecckff@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320112835.prq22vsto3ecckff@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:28:35PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-03-19 20:26:13 [-0400], Joel Fernandes wrote:
> > > @@ -2769,19 +2782,121 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
> > >  {
> > >  	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> > >  		return;
> > > -	if (likely(!rcu_state.boost)) {
> > > -		rcu_do_batch(rdp);
> > > -		return;
> > > -	}
> > > -	invoke_rcu_callbacks_kthread();
> > > +	rcu_do_batch(rdp);
> > 
> > Looks like a nice change, but one question...
> > 
> > Consider the case where rcunosoftirq boot option is not passed.
> > 
> > Before, if RCU_BOOST=y, then callbacks would be invoked in rcuc threads if
> > possible, by those threads being woken up from within the softirq context
> > (in invoke_rcu_callbacks).
> > 
> > Now, if RCU_BOOST=y, then callbacks would only be invoked in softirq context
> > and not in the threads at all. Because rcu_softirq_enabled = false, so the
> > path executes:
> >   rcu_read_unlock_special() ->
> >         raise_softirq_irqsoff() ->
> >                 rcu_process_callbacks_si() ->
> >                         rcu_process_callbacks() ->
> >                                 invoke_rcu_callbacks() ->
> >                                         rcu_do_batch()
> > 
> > This seems like a behavioral change to me. This makes the callbacks always
> > execute from the softirq context and not the threads when boosting is
> > configured. IMO in the very least, such behavioral change should be
> > documented in the change.
> > 
> > One way to fix this I think could be, if boosting is enabled, then set
> > rcu_softirq_enabled to false by default so the callbacks are still executed
> > in the rcuc threads.
> > 
> > Did I miss something? Sorry if I did, thanks!
> 
> So with all the swaps and reorder we talking about this change:
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0a719f726e149..82810483bfc6c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2306,20 +2306,6 @@ static void rcu_core_si(struct softirq_action *h)
>  	rcu_core();
>  }
>  
> -/*
> - * Schedule RCU callback invocation.  If the running implementation of RCU
> - * does not support RCU priority boosting, just do a direct call, otherwise
> - * wake up the per-CPU kernel kthread.  Note that because we are running
> - * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
> - * cannot disappear out from under us.
> - */
> -static void invoke_rcu_callbacks(struct rcu_data *rdp)
> -{
> -	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> -		return;
> -	rcu_do_batch(rdp);
> -}
> -
>  static void rcu_wake_cond(struct task_struct *t, int status)
>  {
>  	/*
> @@ -2330,6 +2316,19 @@ static void rcu_wake_cond(struct task_struct *t, int status)
>  		wake_up_process(t);
>  }
>  
> +static void invoke_rcu_core_kthread(void)
> +{
> +	struct task_struct *t;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> +	t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> +	if (t != NULL && t != current)
> +		rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> +	local_irq_restore(flags);
> +}
> +
>  static bool rcu_softirq_enabled = true;
>  
>  static int __init rcunosoftirq_setup(char *str)
> @@ -2339,26 +2338,33 @@ static int __init rcunosoftirq_setup(char *str)
>  }
>  __setup("rcunosoftirq", rcunosoftirq_setup);
>  
> +/*
> + * Schedule RCU callback invocation.  If the running implementation of RCU
> + * does not support RCU priority boosting, just do a direct call, otherwise
> + * wake up the per-CPU kernel kthread.  Note that because we are running
> + * on the current CPU with softirqs disabled, the rcu_cpu_kthread_task
> + * cannot disappear out from under us.
> + */
> +static void invoke_rcu_callbacks(struct rcu_data *rdp)
> +{
> +	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
> +		return;
> +	if (rcu_state.boost || rcu_softirq_enabled)
> +		invoke_rcu_core_kthread();

Here shouldn't it be this?
	if (rcu_state.boost || !rcu_softirq_enabled)

Also the rcu/dev branch has the following hunk where we unconditionally
invoke rcu_do_batch even when boosting which would still have the issue I
pointed. I would suggest Sebastian to post the latest v4 or v5 with all diff
squashed, and then we do another round of review with latest patch, thanks!

	@@ -2306,18 +2320,110 @@ static void invoke_rcu_callbacks(struct rcu_data *rdp)
 {
 	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
 		return;
-	if (likely(!rcu_state.boost)) {
-		rcu_do_batch(rdp);
-		return;
-	}
-	invoke_rcu_callbacks_kthread();
+	rcu_do_batch(rdp);
+}
+

thanks,

 - Joel


> +	rcu_do_batch(rdp);
> +}
> +
>  /*
>   * Wake up this CPU's rcuc kthread to do RCU core processing.
>   */
>  static void invoke_rcu_core(void)
>  {
> -	unsigned long flags;
> -	struct task_struct *t;
> -
>  	if (!cpu_online(smp_processor_id()))
>  		return;
> -	if (rcu_softirq_enabled) {
> +	if (rcu_softirq_enabled)
>  		raise_softirq(RCU_SOFTIRQ);
> -	} else {
> -		local_irq_save(flags);
> -		__this_cpu_write(rcu_data.rcu_cpu_has_work, 1);
> -		t = __this_cpu_read(rcu_data.rcu_cpu_kthread_task);
> -		if (t != NULL && t != current)
> -			rcu_wake_cond(t, __this_cpu_read(rcu_data.rcu_cpu_kthread_status));
> -		local_irq_restore(flags);
> -	}
> +	else
> +		invoke_rcu_core_kthread();
>  }
>  
>  static void rcu_cpu_kthread_park(unsigned int cpu)
> @@ -2426,7 +2432,8 @@ static int __init rcu_spawn_core_kthreads(void)
>  		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
>  	if (!IS_ENABLED(CONFIG_RCU_BOOST) && !rcu_softirq_enabled)
>  		return 0;
> -	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__);
> +	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
> +		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
>  	return 0;
>  }
>  early_initcall(rcu_spawn_core_kthreads);
> -- 
> 2.20.1
> 
> >  - Joel
> 
> Sebastian
