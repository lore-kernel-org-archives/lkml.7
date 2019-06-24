Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F431C48BE9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CFC20673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="C3stD53T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbfFXQq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:46:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41255 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbfFXQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:46:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so15149334qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dhsef0DXwMLnTfzul4MNZNnoCP5EAjbkYqwXluj+GIs=;
        b=C3stD53TQJChuMgybngQrezdMqSavx69brZV0iGEaYmGzEDp4tC2VDTxOod8X2pDAi
         9JLxxIA/Jnd0Jq9XV+qPRfj4vJblxI8LxUCDxp9AD3/+izgDUqiwRSXr0leO0bC70axA
         Ep46hqYl2bjIMh8F0ayhG2Sf3mcCIy/OT6lIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dhsef0DXwMLnTfzul4MNZNnoCP5EAjbkYqwXluj+GIs=;
        b=F8yB7lqUaC2an1o007XETOHKJuE2RJ6/R2yDf2jYHUbvhBetNQ2t9OJL5zjPQBMiRX
         vyl+PeQjp1KbUrPsB9YOlojLMz8aoSfFV6rOc7dMyCZm5GR8Bw7s96Tubb8BfYVzXhBS
         MgDEGheqC+dpN+L/IGI12/z5qd4tjSM4c8I8NcHYMNldUVuObPbD4Z6PHFaIg1r051iI
         tZcMuj0eJMybaobpI2O16um0j9Td1GbmhWuaqqttn6qKXAgUI7eFdMaVvGsEi7ZLo6SN
         QsjBm0MBC6VeRXybRhCq0QKzZagqZkCBkSkmP8OPhK0bB86xhRbTkIzIx6f/HjtCQVEN
         gUOA==
X-Gm-Message-State: APjAAAV932E1Sk5kiGPbf/biVhysNkEZGBtoul7P0RK98IvnOLKI2+Lb
        BdMtr5RUUu46TXDh8WslD+yjfQ==
X-Google-Smtp-Source: APXvYqxELT3NubfmxXxsRfroMDj0dtbDZl3qf27hvVM29BNgP6+od8/hlgL/ki675ch+A2CFFjfyyQ==
X-Received: by 2002:ac8:41d1:: with SMTP id o17mr55923901qtm.17.1561394785988;
        Mon, 24 Jun 2019 09:46:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x10sm7905346qtc.34.2019.06.24.09.46.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 09:46:25 -0700 (PDT)
Date:   Mon, 24 Jun 2019 12:46:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC] rcu: Warn that rcu ktheads cannot be spawned
Message-ID: <20190624164624.GA41314@google.com>
References: <1561364852-5113-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561364852-5113-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:27:32PM +0900, Byungchul Park wrote:
> Hello rcu folks,
> 
> I thought it'd better to announce it if those spawnings fail because of
> !rcu_scheduler_fully_active.
> 
> Of course, with the current code, it never happens though.
> 
> Thoughts?

It seems in the right spirit, but with your patch a warning always fires.
rcu_prepare_cpu() is called multiple times, once from rcu_init() and then
from hotplug paths.

Warning splat stack looks like:

[    0.398767] Call Trace:                                                                                                        
[    0.398775]  rcu_init+0x6aa/0x724                                             
[    0.398779]  start_kernel+0x220/0x4a2                                    
[    0.398780]  ? copy_bootdata+0x12/0xac                                                                                                                                   
[    0.398782]  secondary_startup_64+0xa4/0xb0    


> 
> Thanks,
> Byungchul
> 
> ---8<---
> From 58a33a85c70f82c406319b4752af95cf6ceb73a3 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Mon, 24 Jun 2019 17:08:26 +0900
> Subject: [RFC] rcu: Warn that rcu ktheads cannot be spawned
> 
> In case that rcu ktheads cannot be spawned due to
> !rcu_scheduler_fully_active, it'd be better to anounce it.
> 
> While at it, because the return value of rcu_spawn_one_boost_kthread()
> is not used any longer, changed the return type from int to void.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/tree_plugin.h | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 1102765..7d74193 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1131,7 +1131,7 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
>   * already exist.  We only create this kthread for preemptible RCU.
>   * Returns zero if all is well, a negated errno otherwise.
>   */
> -static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> +static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  {
>  	int rnp_index = rnp - rcu_get_root();
>  	unsigned long flags;
> @@ -1139,25 +1139,24 @@ static int rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
>  	struct task_struct *t;
>  
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
> -		return 0;
> +		return;
>  
> -	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
> -		return 0;
> +	if (rcu_rnp_online_cpus(rnp) == 0)
> +		return;
>  
>  	rcu_state.boost = 1;
>  	if (rnp->boost_kthread_task != NULL)
> -		return 0;
> +		return;
>  	t = kthread_create(rcu_boost_kthread, (void *)rnp,
>  			   "rcub/%d", rnp_index);
>  	if (IS_ERR(t))
> -		return PTR_ERR(t);
> +		return;
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	rnp->boost_kthread_task = t;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	sp.sched_priority = kthread_prio;
>  	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
>  	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
> -	return 0;
>  }
>  
>  static void rcu_cpu_kthread_setup(unsigned int cpu)
> @@ -1264,8 +1263,12 @@ static void __init rcu_spawn_boost_kthreads(void)
>  		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
>  	if (WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec), "%s: Could not start rcub kthread, OOM is now expected behavior\n", __func__))
>  		return;
> +
> +	if (WARN_ON(!rcu_scheduler_fully_active))
> +		return;
> +
>  	rcu_for_each_leaf_node(rnp)
> -		(void)rcu_spawn_one_boost_kthread(rnp);
> +		rcu_spawn_one_boost_kthread(rnp);
>  }
>  
>  static void rcu_prepare_kthreads(int cpu)
> @@ -1273,9 +1276,11 @@ static void rcu_prepare_kthreads(int cpu)
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	struct rcu_node *rnp = rdp->mynode;
>  
> +	if (WARN_ON(!rcu_scheduler_fully_active))
> +		return;
> +
>  	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
> -	if (rcu_scheduler_fully_active)
> -		(void)rcu_spawn_one_boost_kthread(rnp);
> +	rcu_spawn_one_boost_kthread(rnp);
>  }
>  
>  #else /* #ifdef CONFIG_RCU_BOOST */
> @@ -2198,8 +2203,10 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
>   */
>  static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  {
> -	if (rcu_scheduler_fully_active)
> -		rcu_spawn_one_nocb_kthread(cpu);
> +	if (WARN_ON(!rcu_scheduler_fully_active))
> +		return;
> +
> +	rcu_spawn_one_nocb_kthread(cpu);
>  }
>  
>  /*
> -- 
> 1.9.1
> 
