Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D6C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC99B20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5DLuXwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfJNTXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:23:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45687 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbfJNTXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:23:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so14677564oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fe8V3WPh91ge7SfOH9HpoY+KfdQyjz/N53J28iGvI2s=;
        b=L5DLuXwjUqbbCtuaYcOives97MnwdQB39I9EjhHI/9l5mS917lU1PD+QRoLsT5jEQj
         XH/X4Xa6HWnYK+n7BN0ruSIUKqvWtru2VlWU8/6I0ZH35vqOzwgk5FOEZ0DpDU4PROj/
         K42/BI/Xifzyedo7kHKJLd+u4hqcDttu0QVQ9bOhMiLjpToGD//Lc7EQFJPRCXk1TbrQ
         IFzt+acEr1vtABYpCl8WSBpfSBCerqNLMN/TTrHIU/wlrKtyzrmrHTw6L0116q9k/s/w
         GG8BsOFWjT3U7hu/Q/1mVqgM+ZhlbI3Res1iz7Ys1lL2uRGtQzbXfApFbtLu0f3iJyG9
         YDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fe8V3WPh91ge7SfOH9HpoY+KfdQyjz/N53J28iGvI2s=;
        b=d8VXDiAgCqUDtbcC41b/tUBiv+ciX7xwpmkHUDrUCbdWZk8Rj4nlNkZFTi0q7nWZuK
         ybsAooLDyp6HW7lLlxkg0IneATEpLBBpUkblFLLtxAjJegLl5fI8wGt7wDIRg53+5+cJ
         OOu/ltAIbHEPW2uwiIcFdR0o4fbGvHi6mLAoP9aHoXA4Hu0thSbS2L1+CqgxXMjfgfnl
         td1tJUEueNKHJJ2q+s5elosEuard9AxJ+uRwX4/MF/3rs/IMXqaSde3XlkQX4+Ql7Gu5
         WAJUvVvKo5OATZ6NORocUAn4AiZ4kPb7aZ3mZk2aAgTglurs4FPFXh0q1z09+wF0j6Pz
         giZA==
X-Gm-Message-State: APjAAAVBBVzn+itIBYllBBXqXhcjCJv2NKHED64UQ/wp0/kk5GXR3YHU
        mpg298bYns9zDjmIrRCLPQ+2ZdPm6rNn/tV4CcrKxg==
X-Google-Smtp-Source: APXvYqwlmHX67AJHXbc7vL/TbWSF5KyscS3/zvQGK3+cqixMYl2ihXiC3eNPBF8CYUFwmBAJx7DT/CyRkDRVfv22PBA=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr25732948oic.70.1571080999447;
 Mon, 14 Oct 2019 12:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <5da2509f.1c69fb81.bb59c.b8e2SMTPIN_ADDED_BROKEN@mx.google.com> <20191014180039.GA89937@google.com>
In-Reply-To: <20191014180039.GA89937@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Oct 2019 21:23:07 +0200
Message-ID: <CANpmjNOD2A1EdGpZNnSRcNRxXim=m1qBAmwtdm3J-B_UFJ4zjg@mail.gmail.com>
Subject: Re: [PATCH] rcu: Fix data-race due to atomic_t copy-by-value
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 at 20:00, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Oct 09, 2019 at 05:57:43PM +0200, Marco Elver wrote:
> > This fixes a data-race where `atomic_t dynticks` is copied by value. The
> > copy is performed non-atomically, resulting in a data-race if `dynticks`
> > is updated concurrently.
> >
> > This data-race was found with KCSAN:
> > ==================================================================
> > BUG: KCSAN: data-race in dyntick_save_progress_counter / rcu_irq_enter
> >
> > write to 0xffff989dbdbe98e0 of 4 bytes by task 10 on cpu 3:
> >  atomic_add_return include/asm-generic/atomic-instrumented.h:78 [inline]
> >  rcu_dynticks_snap kernel/rcu/tree.c:310 [inline]
> >  dyntick_save_progress_counter+0x43/0x1b0 kernel/rcu/tree.c:984
> >  force_qs_rnp+0x183/0x200 kernel/rcu/tree.c:2286
> >  rcu_gp_fqs kernel/rcu/tree.c:1601 [inline]
> >  rcu_gp_fqs_loop+0x71/0x880 kernel/rcu/tree.c:1653
> >  rcu_gp_kthread+0x22c/0x3b0 kernel/rcu/tree.c:1799
> >  kthread+0x1b5/0x200 kernel/kthread.c:255
> >  <snip>
> >
> > read to 0xffff989dbdbe98e0 of 4 bytes by task 154 on cpu 7:
> >  rcu_nmi_enter_common kernel/rcu/tree.c:828 [inline]
> >  rcu_irq_enter+0xda/0x240 kernel/rcu/tree.c:870
> >  irq_enter+0x5/0x50 kernel/softirq.c:347
> >  <snip>
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 7 PID: 154 Comm: kworker/7:1H Not tainted 5.3.0+ #5
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > Workqueue: kblockd blk_mq_run_work_fn
> > ==================================================================
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> I believe Paul has already queued this, but anyway I have reviewed it as well
> and it LGTM.
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you! As an aside, I was wondering if there is a way to disallow
copy-by-value for certain structs, such as atomic_t (in the absence of
constructors). Presumably that'd be useful to have here to just let
the type-system prevent similar cases in future.

Thanks,
-- Marco

> thanks,
>
>  - Joel
>
>
> > ---
> >  include/trace/events/rcu.h |  4 ++--
> >  kernel/rcu/tree.c          | 11 ++++++-----
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 694bd040cf51..fdd31c5fd126 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -442,7 +442,7 @@ TRACE_EVENT_RCU(rcu_fqs,
> >   */
> >  TRACE_EVENT_RCU(rcu_dyntick,
> >
> > -     TP_PROTO(const char *polarity, long oldnesting, long newnesting, atomic_t dynticks),
> > +     TP_PROTO(const char *polarity, long oldnesting, long newnesting, int dynticks),
> >
> >       TP_ARGS(polarity, oldnesting, newnesting, dynticks),
> >
> > @@ -457,7 +457,7 @@ TRACE_EVENT_RCU(rcu_dyntick,
> >               __entry->polarity = polarity;
> >               __entry->oldnesting = oldnesting;
> >               __entry->newnesting = newnesting;
> > -             __entry->dynticks = atomic_read(&dynticks);
> > +             __entry->dynticks = dynticks;
> >       ),
> >
> >       TP_printk("%s %lx %lx %#3x", __entry->polarity,
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 81105141b6a8..62e59596a30a 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -576,7 +576,7 @@ static void rcu_eqs_enter(bool user)
> >       }
> >
> >       lockdep_assert_irqs_disabled();
> > -     trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, rdp->dynticks);
> > +     trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
> >       WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> >       rdp = this_cpu_ptr(&rcu_data);
> >       do_nocb_deferred_wakeup(rdp);
> > @@ -649,14 +649,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >        * leave it in non-RCU-idle state.
> >        */
> >       if (rdp->dynticks_nmi_nesting != 1) {
> > -             trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > +             trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
> > +                               atomic_read(&rdp->dynticks));
> >               WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> >                          rdp->dynticks_nmi_nesting - 2);
> >               return;
> >       }
> >
> >       /* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> > -     trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, rdp->dynticks);
> > +     trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> >       WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> >
> >       if (irq)
> > @@ -743,7 +744,7 @@ static void rcu_eqs_exit(bool user)
> >       rcu_dynticks_task_exit();
> >       rcu_dynticks_eqs_exit();
> >       rcu_cleanup_after_idle();
> > -     trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, rdp->dynticks);
> > +     trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
> >       WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> >       WRITE_ONCE(rdp->dynticks_nesting, 1);
> >       WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> > @@ -827,7 +828,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> >       }
> >       trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> >                         rdp->dynticks_nmi_nesting,
> > -                       rdp->dynticks_nmi_nesting + incby, rdp->dynticks);
> > +                       rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
> >       WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
> >                  rdp->dynticks_nmi_nesting + incby);
> >       barrier();
> > --
> > 2.23.0.581.g78d2f28ef7-goog
> >
> >
