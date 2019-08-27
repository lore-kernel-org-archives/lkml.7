Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0A4C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133752173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rlvOGL39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfH0Bk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:40:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46089 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfH0Bk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:40:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id n19so13772534lfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 18:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c62xv5vBM/PnmkjyTRppKCq9KLFp733vzSGNPbBsFlk=;
        b=rlvOGL39It1oYiP4/B4Lmr9eAavaSCnSGWEtEGghKXPvYIsfCR/Hk/O9zgd0wgabGO
         4iGjYgSbEjoXB4RBheoLw3FMWf9vygapiVfnvzt4EJ9J4Z3blkPuD5MeWMNkMIJdI5g0
         TJ3FM/q/0Uq+UjcsiLlF6QCDm6IyjYRjMjdTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c62xv5vBM/PnmkjyTRppKCq9KLFp733vzSGNPbBsFlk=;
        b=CljDfadztr4z30iAKU3TngRBYQRbmT4x0wTrYgVMsE5m88GVy2fXhIAoLWIOBquywm
         avLv276SH+ZeAMIGPgShDPcNxNjfYaOxEksYK4z8NC7FVmxIZm+/pWJfGdZr1RiHOihK
         ihCn4CtI7aKUKM3bP1ZBs/VACbm6r+c5R9WuaWtZHMrvujkd/drekaMIZKhc1ar5OM2H
         Dc7F124eJ60cVi8EARY+738NT1Jwv6DQRVPdeqP/qkfqerH2Fn9o8sebSPx1BDIxSo1+
         DCeFTCcYaViUARQ0sGA0Q6/f1A9Z8w8tPakoLNCYrZhtJLtTzYVmUedQ7TXS98y+9Ouz
         vilw==
X-Gm-Message-State: APjAAAVbpY1o8QSJVzdr+RYCoyAZAes1Bbccr9TWDVyVNFjvuLMAk4Ks
        lgsKGbUce5tKrv7Tc1RKqFmZ5Rg8AP3dZojGP6RQFKGL
X-Google-Smtp-Source: APXvYqwDZdY3/QmkYWHAy/elYElRJ4E+3sVocKeoQ8d8m6jY3tg1/8MgFsQfoClrmT63T5w61utMisTlVc8OZHlsiZQ=
X-Received: by 2002:a19:6d02:: with SMTP id i2mr12359068lfc.191.1566870053709;
 Mon, 26 Aug 2019 18:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <5d648897.1c69fb81.5e60a.fc70@mx.google.com>
In-Reply-To: <5d648897.1c69fb81.5e60a.fc70@mx.google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 26 Aug 2019 21:40:42 -0400
Message-ID: <CAEXW_YRm6VuZjG4u2tkAyihCT4Jd194VP3ZMK=foErtVw_cLcg@mail.gmail.com>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        kernel-team <kernel-team@android.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 9:34 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The dynticks_nmi_nesting counter serves 4 purposes:
>

And actually, I meant 3 purposes ;-) :-P

thanks,

 - Joel


>       (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
>           interrupt nesting level.
>
>       (b) We need to detect half-interrupts till we are sure they're not an
>           issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.
>
>       (c) When a quiescent state report is needed from a nohz_full CPU.
>           The nesting counter detects we are a first level interrupt.
>
> For (a) we can just use dyntick_nesting == 1 to determine this. Only the
> outermost interrupt that interrupted an RCU-idle state can set it to 1.
>
> For (b), this warning condition has not occurred for several kernel
> releases.  But we still keep the warning but change it to use
> in_interrupt() instead of the nesting counter. In a later year, we can
> remove the warning.
>
> For (c), the nest check is not really necessary since forced_tick would
> have been set to true in the outermost interrupt, so the nested/NMI
> interrupts will check forced_tick anyway, and bail.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../Data-Structures/Data-Structures.rst       | 31 +++------
>  Documentation/RCU/stallwarn.txt               |  6 +-
>  kernel/rcu/tree.c                             | 64 +++++++------------
>  kernel/rcu/tree.h                             |  4 +-
>  kernel/rcu/tree_stall.h                       |  4 +-
>  5 files changed, 41 insertions(+), 68 deletions(-)
>
> diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> index 4a48e20a46f2..a5a907f434a1 100644
> --- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> +++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
> @@ -936,10 +936,9 @@ This portion of the rcu_data structure is declared as follows:
>  ::
>
>       1   long dynticks_nesting;
> -     2   long dynticks_nmi_nesting;
> -     3   atomic_t dynticks;
> -     4   bool rcu_need_heavy_qs;
> -     5   bool rcu_urgent_qs;
> +     2   atomic_t dynticks;
> +     3   bool rcu_need_heavy_qs;
> +     4   bool rcu_urgent_qs;
>
>  These fields in the rcu_data structure maintain the per-CPU dyntick-idle
>  state for the corresponding CPU. The fields may be accessed only from
> @@ -948,26 +947,14 @@ the corresponding CPU (and from tracing) unless otherwise stated.
>  The ``->dynticks_nesting`` field counts the nesting depth of process
>  execution, so that in normal circumstances this counter has value zero
>  or one. NMIs, irqs, and tracers are counted by the
> -``->dynticks_nmi_nesting`` field. Because NMIs cannot be masked, changes
> +``->dynticks_nesting`` field as well. Because NMIs cannot be masked, changes
>  to this variable have to be undertaken carefully using an algorithm
>  provided by Andy Lutomirski. The initial transition from idle adds one,
>  and nested transitions add two, so that a nesting level of five is
> -represented by a ``->dynticks_nmi_nesting`` value of nine. This counter
> +represented by a ``->dynticks_nesting`` value of nine. This counter
>  can therefore be thought of as counting the number of reasons why this
> -CPU cannot be permitted to enter dyntick-idle mode, aside from
> -process-level transitions.
> -
> -However, it turns out that when running in non-idle kernel context, the
> -Linux kernel is fully capable of entering interrupt handlers that never
> -exit and perhaps also vice versa. Therefore, whenever the
> -``->dynticks_nesting`` field is incremented up from zero, the
> -``->dynticks_nmi_nesting`` field is set to a large positive number, and
> -whenever the ``->dynticks_nesting`` field is decremented down to zero,
> -the the ``->dynticks_nmi_nesting`` field is set to zero. Assuming that
> -the number of misnested interrupts is not sufficient to overflow the
> -counter, this approach corrects the ``->dynticks_nmi_nesting`` field
> -every time the corresponding CPU enters the idle loop from process
> -context.
> +CPU cannot be permitted to enter dyntick-idle mode. It counts both the
> +process-level and interrupt transitions.
>
>  The ``->dynticks`` field counts the corresponding CPU's transitions to
>  and from either dyntick-idle or user mode, so that this counter has an
> @@ -1000,7 +987,9 @@ code.
>  +-----------------------------------------------------------------------+
>  | Because this would fail in the presence of interrupts whose handlers  |
>  | never return and of handlers that manage to return from a made-up     |
> -| interrupt.                                                            |
> +| interrupt. NOTE: The counters have now been combined however          |
> +| a temporary warning has been left to make sure this condition never   |
> +| occurs.                                                               |
>  +-----------------------------------------------------------------------+
>
>  Additional fields are present for some special-purpose builds, and are
> diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
> index f48f4621ccbc..585f73009a56 100644
> --- a/Documentation/RCU/stallwarn.txt
> +++ b/Documentation/RCU/stallwarn.txt
> @@ -173,8 +173,8 @@ For non-RCU-tasks flavors of RCU, when a CPU detects that it is stalling,
>  it will print a message similar to the following:
>
>         INFO: rcu_sched detected stalls on CPUs/tasks:
> -       2-...: (3 GPs behind) idle=06c/0/0 softirq=1453/1455 fqs=0
> -       16-...: (0 ticks this GP) idle=81c/0/0 softirq=764/764 fqs=0
> +       2-...: (3 GPs behind) idle=06c/0 softirq=1453/1455 fqs=0
> +       16-...: (0 ticks this GP) idle=81c/0 softirq=764/764 fqs=0
>         (detected by 32, t=2603 jiffies, g=7075, q=625)
>
>  This message indicates that CPU 32 detected that CPUs 2 and 16 were both
> @@ -225,7 +225,7 @@ an estimate of the total number of RCU callbacks queued across all CPUs
>  In kernels with CONFIG_RCU_FAST_NO_HZ, more information is printed
>  for each CPU:
>
> -       0: (64628 ticks this GP) idle=dd5/3fffffffffffffff/0 softirq=82/543 last_accelerate: a345/d342 Nonlazy posted: ..D
> +       0: (64628 ticks this GP) idle=dd5/3fffffffffffffff softirq=82/543 last_accelerate: a345/d342 Nonlazy posted: ..D
>
>  The "last_accelerate:" prints the low-order 16 bits (in hex) of the
>  jiffies counter when this CPU last invoked rcu_try_advance_all_cbs()
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 255cd6835526..1465a3e406f8 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -81,7 +81,6 @@
>
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
>         .dynticks_nesting = 1,
> -       .dynticks_nmi_nesting = 0,
>         .dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
>  };
>  struct rcu_state rcu_state = {
> @@ -392,15 +391,9 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>         /* Check for counter underflows */
>         RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
>                          "RCU dynticks_nesting counter underflow!");
> -       RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> -                        "RCU dynticks_nmi_nesting counter underflow/zero!");
>
> -       /* Are we at first interrupt nesting level? */
> -       if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> -               return false;
> -
> -       /* Does CPU appear to be idle from an RCU standpoint? */
> -       return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
> +       /* Are we the outermost interrupt that arrived when RCU was idle? */
> +       return __this_cpu_read(rcu_data.dynticks_nesting) == 1;
>  }
>
>  #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
> @@ -564,11 +557,10 @@ static void rcu_eqs_enter(bool user)
>         struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>
>         /* Entering usermode/idle from interrupt is not handled. These would
> -        * mean usermode upcalls or idle entry happened from interrupts. But,
> -        * reset the counter if we warn.
> +        * mean usermode upcalls or idle exit happened from interrupts. Remove
> +        * the warning by 2020.
>          */
> -       if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> -               WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> +       WARN_ON_ONCE(in_interrupt());
>
>         WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>                      rdp->dynticks_nesting == 0);
> @@ -627,9 +619,8 @@ void rcu_user_enter(void)
>
>  /*
>   * If we are returning from the outermost NMI handler that interrupted an
> - * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
> - * to let the RCU grace-period handling know that the CPU is back to
> - * being RCU-idle.
> + * RCU-idle period, update rdp->dynticks to let the RCU grace-period handling
> + * know that the CPU is back to being RCU-idle.
>   *
>   * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
> @@ -639,16 +630,13 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
>         struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>
>         /*
> -        * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
> +        * Check for ->dynticks_nesting underflow and bad ->dynticks.
>          * (We are exiting an NMI handler, so RCU better be paying attention
>          * to us!)
>          */
>         WARN_ON_ONCE(rdp->dynticks_nesting <= 0);
> -       WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
>         WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
>
> -       WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> -                  rdp->dynticks_nmi_nesting - 1);
>         /*
>          * If the nesting level is not 1, the CPU wasn't RCU-idle, so
>          * leave it in non-RCU-idle state.
> @@ -750,11 +738,10 @@ static void rcu_eqs_exit(bool user)
>         WRITE_ONCE(rdp->dynticks_nesting, 1);
>
>         /* Exiting usermode/idle from interrupt is not handled. These would
> -        * mean usermode upcalls or idle exit happened from interrupts. But,
> -        * reset the counter if we warn.
> +        * mean usermode upcalls or idle exit happened from interrupts. Remove
> +        * the warning by 2020.
>          */
> -       if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> -               WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> +       WARN_ON_ONCE(in_interrupt());
>  }
>
>  /**
> @@ -795,14 +782,13 @@ void rcu_user_exit(void)
>   * rcu_nmi_enter_common - inform RCU of entry to NMI context
>   * @irq: Is this call from rcu_irq_enter?
>   *
> - * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
> - * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
> - * that the CPU is active.  This implementation permits nested NMIs, as
> - * long as the nesting level does not overflow an int.  (You will probably
> - * run out of stack space first.)
> + * If the CPU was idle from RCU's viewpoint, update rdp->dynticks to let the
> + * RCU grace-period handling know that the CPU is active.  This implementation
> + * permits nested NMIs, as long as the nesting level does not overflow a long.
> + * (You will probably run out of stack space first.)
>   *
> - * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> - * with CONFIG_RCU_EQS_DEBUG=y.
> + * If you add or remove a call to rcu_nmi_enter_common(), be sure to test with
> + * CONFIG_RCU_EQS_DEBUG=y.
>   */
>  static __always_inline void rcu_nmi_enter_common(bool irq)
>  {
> @@ -811,15 +797,16 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>
>         /* Complain about underflow. */
>         WARN_ON_ONCE(rdp->dynticks_nesting < 0);
> -       WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
>
>         /*
>          * If idle from RCU viewpoint, atomically increment ->dynticks
> -        * to mark non-idle and increment ->dynticks_nmi_nesting by one.
> -        * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
> -        * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
> +        * to mark non-idle and increment ->dynticks_nesting by one.
> +        * Otherwise, increment ->dynticks_nesting by two.  This means
> +        * if ->dynticks_nesting is equal to one, we are guaranteed
>          * to be in the outermost NMI handler that interrupted an RCU-idle
> -        * period (observation due to Andy Lutomirski).
> +        * period (observation due to Andy Lutomirski). An exception
> +        * is if the interrupt arrived in kernel mode; in this case we would
> +        * be the outermost interrupt but still increment by 2 which is Ok.
>          */
>         if (rcu_dynticks_curr_cpu_in_eqs()) {
>
> @@ -832,8 +819,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>                         rcu_cleanup_after_idle();
>
>                 incby = 1;
> -       } else if (tick_nohz_full_cpu(rdp->cpu) &&
> -                  !rdp->dynticks_nmi_nesting && rdp->rcu_urgent_qs &&
> +       } else if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_urgent_qs &&
>                    !rdp->rcu_forced_tick) {
>                 rdp->rcu_forced_tick = true;
>                 tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
> @@ -846,8 +832,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
>         WRITE_ONCE(rdp->dynticks_nesting, /* Prevent store tearing. */
>                    rdp->dynticks_nesting + incby);
>
> -       WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
> -                  rdp->dynticks_nmi_nesting + 1);
>         barrier();
>  }
>
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 055c31781d3a..ad7d3e31c5cf 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -176,8 +176,8 @@ struct rcu_data {
>
>         /* 3) dynticks interface. */
>         int dynticks_snap;              /* Per-GP tracking for dynticks. */
> -       long dynticks_nesting;          /* Track process nesting level. */
> -       long dynticks_nmi_nesting;      /* Track irq/NMI nesting level. */
> +       long dynticks_nesting;          /* Track dyntick (non-IDLE) nesting
> +                                        * level for kernel entry and interrupt. */
>         atomic_t dynticks;              /* Even value for idle, else odd. */
>         bool rcu_need_heavy_qs;         /* GP old, so heavy quiescent state! */
>         bool rcu_urgent_qs;             /* GP old need light quiescent state. */
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 841ab43f3e60..0676460107d0 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -313,7 +313,7 @@ static void print_cpu_stall_info(int cpu)
>         }
>         print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
>         delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
> -       pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
> +       pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld softirq=%u/%u fqs=%ld %s\n",
>                cpu,
>                "O."[!!cpu_online(cpu)],
>                "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
> @@ -323,7 +323,7 @@ static void print_cpu_stall_info(int cpu)
>                                 "!."[!delta],
>                ticks_value, ticks_title,
>                rcu_dynticks_snap(rdp) & 0xfff,
> -              rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
> +              rdp->dynticks_nesting,
>                rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>                READ_ONCE(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
>                fast_no_hz);
> --
> 2.23.0.187.g17f5b7556c-goog
>
