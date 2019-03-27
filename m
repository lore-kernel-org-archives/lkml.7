Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DECEC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CDF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uga9u9DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfC0PeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:34:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36950 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfC0PeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:34:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so10107147pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1P+XW260J6fDBBDrcbVUs+PFm/h6L1PKNW6v9ICD81k=;
        b=uga9u9DZYTLWVHCbdDWPJcghCftLLRebCS/RO8b5Ni2aKwyc+nWwVY//jCgld4w6eN
         B97nK9q7cYvrPgttaV1R6yiXJ+WTEA0VUrTQQVPo0/7iydOZWPltiq2w+Kv9BeAGzUGx
         wVw2s4hN7cKeAMMU7JbPDNFT3UykcBf5yvPWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1P+XW260J6fDBBDrcbVUs+PFm/h6L1PKNW6v9ICD81k=;
        b=Nm9m6AjwAi0Qb1U7VJxH+tN+0asev1wbv1TmDhSHtzCgNPWl5LJ/3HeAeWOCZBpU22
         iPXaJtZdmuAplbqiyJfTi3rBnSXG61AZtZZoMOP8/qYXzatwBY7Qn0dmv4GbJG6VQg+6
         zqMBR3MyKMVj8YzsKLNMRFvUZivFBXnkGLcSxFgSXGCdDzQMJndr/W79iJPuwlvWBDVg
         epVXDHgafkkDCARUcs8HYHcudyWkgeAYLxFC3XiqcN2qHp1Y8nIgFX5UKh4l4hbwkBca
         qQizXvaT100Y44dDHRrnwsTQ4GGiFhEn6CdONt6n6BKax7VqaqZuwnpYUOqdENg3Bk8R
         1SCQ==
X-Gm-Message-State: APjAAAWKDmKsuqpr2iQgUYT10qXSIJQEWYdTHN2ceEgGNmTTndbIUSSv
        jVVGd7oPKxyQwCZ6Gyi2IK+eMtQ4J+g=
X-Google-Smtp-Source: APXvYqxXQbBsRF9riy3XHgP7/KslzkwzHO43WrSgDUt9G5zhsfzuPE9alZ6TcGpJ049p2NXMHmYEag==
X-Received: by 2002:a63:3d49:: with SMTP id k70mr18098410pga.447.1553700843713;
        Wed, 27 Mar 2019 08:34:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r11sm1284938pga.87.2019.03.27.08.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 08:34:02 -0700 (PDT)
Date:   Wed, 27 Mar 2019 11:34:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        kernel-team@android.com, rcu@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/4] rcutree: Add checks for dynticks counters in
 rcu_is_cpu_rrupt_from_idle
Message-ID: <20190327153401.GA152912@google.com>
References: <20190326192411.198070-1-joel@joelfernandes.org>
 <20190326192411.198070-2-joel@joelfernandes.org>
 <20190327024751.GV4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327024751.GV4102@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:47:51PM -0700, Paul E. McKenney wrote:
> On Tue, Mar 26, 2019 at 03:24:09PM -0400, Joel Fernandes (Google) wrote:
> > In the future we would like to combine the dynticks and dynticks_nesting
> > counters thus leading to simplifying the code. At the moment we cannot
> > do that due to concerns about usermode upcalls appearing to RCU as half
> > of an interrupt. Byungchul tried to do it in [1] but the
> > "half-interrupt" concern was raised. It is half because, what RCU
> > expects is rcu_irq_enter() and rcu_irq_exit() pairs when the usermode
> > exception happens. However, only rcu_irq_enter() is observed. This
> > concern may not be valid anymore, but at least it used to be the case.
> > 
> > Out of abundance of caution, Paul added warnings [2] in the RCU code
> > which if not fired by 2021 may allow us to assume that such
> > half-interrupt scenario cannot happen any more, which can lead to
> > simplification of this code.
> > 
> > Summary of the changes are the following:
> > 
> > (1) In preparation for this combination of counters in the future, we
> > first need to first be sure that rcu_rrupt_from_idle cannot be called
> > from anywhere but a hard-interrupt because previously, the comments
> > suggested otherwise so let us be sure. We discussed this here [3]. We
> > use the services of lockdep to accomplish this.
> > 
> > (2) Further rcu_rrupt_from_idle() is not explicit about how it is using
> > the counters which can lead to weird future bugs. This patch therefore
> > makes it more explicit about the specific counter values being tested
> > 
> > (3) Lastly, we check for counter underflows just to be sure these are
> > not happening, because the previous code in rcu_rrupt_from_idle() was
> > allowing the case where the counters can underflow, and the function
> > would still return true. Now we are checking for specific values so let
> > us be confident by additional checking, that such underflows don't
> > happen. Any case, if they do, we should fix them and the screaming
> > warning is appropriate. All these checks checks are NOOPs if PROVE_RCU
> > and PROVE_LOCKING are disabled.
> > 
> > [1] https://lore.kernel.org/patchwork/patch/952349/
> > [2] Commit e11ec65cc8d6 ("rcu: Add warning to detect half-interrupts")
> > [3] https://lore.kernel.org/lkml/20190312150514.GB249405@google.com/
> > 
> > Cc: byungchul.park@lge.com
> > Cc: kernel-team@android.com
> > Cc: rcu@vger.kernel.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Color me stupid:
> 
> [   48.845724] ------------[ cut here ]------------
> [   48.846619] Not in hardirq as expected
> [   48.847322] WARNING: CPU: 5 PID: 34 at /home/git/linux-2.6-tip/kernel/rcu/tree.c:388 rcu_is_cpu_rrupt_from_idle+0xea/0x110
> [   48.849302] Modules linked in:
> [   48.849869] CPU: 5 PID: 34 Comm: cpuhp/5 Not tainted 5.1.0-rc1+ #1
> [   48.850985] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> [   48.852436] RIP: 0010:rcu_is_cpu_rrupt_from_idle+0xea/0x110
> [   48.853455] Code: 85 c0 0f 85 59 ff ff ff 80 3d 33 55 68 01 00 0f 85 4c ff ff ff 48 c7 c7 48 d8 cc 8e 31 c0 c6 05 1d 55 68 01 01 e8 66 54 f8 ff <0f> 0b e9 30 ff ff ff 65 48 8b 05 df 58 54 72 48 85 c0 0f 94 c0 0f
> [   48.856783] RSP: 0000:ffffbc46802dfdc0 EFLAGS: 00010082
> [   48.857735] RAX: 000000000000001a RBX: 0000000000022b80 RCX: 0000000000000000
> [   48.859028] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8dac906c
> [   48.860313] RBP: ffffbc46802dfe20 R08: 0000000000000001 R09: 0000000000000001
> [   48.861607] R10: 000000007d53d16d R11: ffffbc46802dfb48 R12: ffff9e7d7eb62b80
> [   48.862898] R13: 0000000000000005 R14: ffffffff8dae2ac0 R15: 00000000000000c9
> [   48.864191] FS:  0000000000000000(0000) GS:ffff9e7d7eb40000(0000) knlGS:0000000000000000
> [   48.865663] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   48.866702] CR2: 0000000000000000 CR3: 0000000021022000 CR4: 00000000000006e0
> [   48.867993] Call Trace:
> [   48.868450]  rcu_exp_handler+0x35/0x90
> [   48.869147]  generic_exec_single+0xab/0x100
> [   48.869918]  ? rcu_barrier+0x240/0x240
> [   48.870607]  smp_call_function_single+0x8e/0xd0
> [   48.871441]  rcutree_online_cpu+0x80/0x90
> [   48.872181]  cpuhp_invoke_callback+0xb5/0x890
> [   48.872979]  cpuhp_thread_fun+0x172/0x210
> [   48.873722]  ? cpuhp_thread_fun+0x2a/0x210
> [   48.874474]  smpboot_thread_fn+0x10d/0x160
> [   48.875224]  kthread+0xf3/0x130
> [   48.875804]  ? sort_range+0x20/0x20
> [   48.876446]  ? kthread_cancel_delayed_work_sync+0x10/0x10
> [   48.877445]  ret_from_fork+0x3a/0x50
> [   48.878124] irq event stamp: 734
> [   48.878717] hardirqs last  enabled at (733): [<ffffffff8e4f332d>] _raw_spin_unlock_irqrestore+0x2d/0x40
> [   48.880402] hardirqs last disabled at (734): [<ffffffff8db0110a>] generic_exec_single+0x9a/0x100
> [   48.881986] softirqs last  enabled at (0): [<ffffffff8da5feaf>] copy_process.part.56+0x61f/0x2110
> [   48.883540] softirqs last disabled at (0): [<0000000000000000>]           (null)
> [   48.884840] ---[ end trace 00b4c1d2f816f4ed ]---
> 
> If a CPU invokes generic_exec_single() on itself, the "IPI handler" will
> be invoked directly, triggering your new lockdep check.  Which is a bit
> wasteful.  My thought is to add code to sync_rcu_exp_select_node_cpus()
> to check the CPU with preemption disabled, avoiding the call to
> smp_call_function_single() in that case.
> 
> I have queued all four of your patches, and am trying the fix to
> the caller of smp_call_function_single() shown below.  Thoughts?

Oh interesting. Your fix makes sense. I will go through these paths more as
well since I'm not super familiar with this area of the RCU code. But I had
one small nit below.

Also thanks for pulling the patches, I tested TREE09 and TASKS02 which
disable SMP and both passed.

> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 9c990df880d1..51d61028abf1 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -384,7 +384,13 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
>  			mask_ofl_test |= mask;
>  			continue;
>  		}
> +		preempt_disable();
> +		if (smp_processor_id() == cpu) {

Can be this?
		if (get_cpu() == cpu) {
			put_cpu();
			continue;
		}

> +			preempt_enable();
> +			continue;
> +		}
>  		ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
> +		preempt_enable();

and here:
		put_cpu();

>  		if (!ret) {
>  			mask_ofl_ipi &= ~mask;
>  			continue;
> 

thanks,

 - Joel

