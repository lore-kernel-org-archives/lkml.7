Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B43C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A33218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJKcgq2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfJIOvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:51:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42668 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:51:22 -0400
Received: by mail-ed1-f68.google.com with SMTP id y91so2281809ede.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dm4M9uK9mKzWNZjUUbbJt1yeuLljxo5ejZPu2BC83M4=;
        b=SJKcgq2ihghim/W7kVfmBmNqh79wLmu4103r0DbiMKwiRtP8hHl4SnGH4yFP/8wG7u
         c0Q1r+Y9bnuoMZL6tWAJl52p9wensFYCBVmSiV/ghDbbpH7B5TCmE9xxUA0aKv3S3Ioo
         PbXA5z3VZli1iGQW8rRNf+pctvByJug9EAOyeE4x6M+cJBVjYVSVZ5qvkWLaort4Xq3W
         qttdN6eFHmKFVo6HdjK7/27cZkwZFyxnHIPF8KQUR5ZTY15KKLnoVPcfmRG4rtHZMe/r
         yyub9eFCood8G+gN73j2Mxp3FQYtCxARiGuJQ06OjPjXwpOjxa4RmHWivOwtdD0Tf8CT
         V1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm4M9uK9mKzWNZjUUbbJt1yeuLljxo5ejZPu2BC83M4=;
        b=FnI5BUZ3KeaH9S4bI/wkVqJsTcD3yTfypR8clON5Otn2D5JHZtnv5NmPUxtw1AeBsP
         Xb5WahMiEVYvk2t+92G2B2NpsSniuXfw5A3NQgJeS9kh5nHTZly4X4cNrGarbKOyQ3Qm
         Tbsh+i8kgUcMYMwe1Zy9l2aSz1kCD54dyaZUp3dQRUQf82k1faLSrL21N+W78BUSM/qh
         NG1DaaIZZU9a6UTPgO60+LO8VpsAQzh+jgPO6SAT7Cfqr+Yt/bvAb/cQILoWicyBdrx6
         /dDmgoMAjZ4kdsKe7A+r9zt7QK90kLC2EQsJXJ+JeRruieDvJpIEuMGRO6BOfewsnb1m
         gRUw==
X-Gm-Message-State: APjAAAURdCC0Uzs1R01rF6UQ9xU7WS48+49imrGD5HCLcvr3loCFGDhu
        bUHm5j9JOTXjCrBV3xjCDsdg7BP+yyBEHp6OrEUPXG8=
X-Google-Smtp-Source: APXvYqyvhpB9GnuLNHg5HldXBlWLYT5rq27yj/Qq42UJRJr/lyubDc/7zYyqwil9FcitKPYxd1FONV4gtdUsLxJpnjE=
X-Received: by 2002:a17:906:2410:: with SMTP id z16mr3256611eja.120.1570632678183;
 Wed, 09 Oct 2019 07:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191008220824.7911-1-viktor.rosendahl@gmail.com>
 <20191008220824.7911-5-viktor.rosendahl@gmail.com> <20191009141114.GC143258@google.com>
In-Reply-To: <20191009141114.GC143258@google.com>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Date:   Wed, 9 Oct 2019 16:51:07 +0200
Message-ID: <CAPQh3wP93yF4R4LOabmBf8zqTgM7ZVT=_eZRPwgq5WKEESjnyw@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] ftrace: Add an option for tracing console latencies
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den ons 9 okt. 2019 kl 16:11 skrev Joel Fernandes <joel@joelfernandes.org>:
>
> On Wed, Oct 09, 2019 at 12:08:24AM +0200, Viktor Rosendahl (BMW) wrote:
> > This new trace option "console-latency" will enable the latency
> > tracers to trace the console latencies. Previously this has always been
> > implicitely disabled. I guess this is because they are considered
> > to be well known and unavoidable.
> >
> > However, for some organizations it may nevertheless be desirable to
> > trace them. Basically, we want to be able to tell that there are
> > latencies in the system under test because someone has incorrectly
> > enabled the serial console.
> >
> > Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
> > ---
> >  include/linux/irqflags.h     | 22 ++++++++++++++++++++++
> >  kernel/printk/printk.c       |  6 ++++--
> >  kernel/trace/trace.h         |  1 +
> >  kernel/trace/trace_irqsoff.c | 18 ++++++++++++++++++
> >  4 files changed, 45 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> > index 21619c92c377..3de891723331 100644
> > --- a/include/linux/irqflags.h
> > +++ b/include/linux/irqflags.h
> > @@ -13,6 +13,7 @@
> >  #define _LINUX_TRACE_IRQFLAGS_H
> >
> >  #include <linux/typecheck.h>
> > +#include <linux/types.h>
> >  #include <asm/irqflags.h>
> >
> >  /* Currently trace_softirqs_on/off is used only by lockdep */
> > @@ -68,9 +69,30 @@ do {                                               \
> >       defined(CONFIG_PREEMPT_TRACER)
> >   extern void stop_critical_timings(void);
> >   extern void start_critical_timings(void);
> > + extern bool console_tracing_disabled(void);
> > +
> > +# define console_stop_critical_timings(flag)         \
> > +     do {                                            \
> > +             typecheck(bool, flag);                  \
> > +             flag = console_tracing_disabled();      \
> > +             if (flag)                               \
> > +                     stop_critical_timings();        \
> > +     } while (0)
> > +
> > +# define console_start_critical_timings(flag)                 \
> > +     do {                                             \
> > +             typecheck(bool, flag);                   \
> > +             if (flag)                                \
> > +                     start_critical_timings();        \
> > +     } while (0)
> > +
> >  #else
> >  # define stop_critical_timings() do { } while (0)
> >  # define start_critical_timings() do { } while (0)
> > +# define console_stop_critical_timings(flag) \
> > +     do { typecheck(bool, flag); } while (0)
> > +# define console_start_critical_timings(flag)        \
> > +     do { typecheck(bool, flag); } while (0)
> >  #endif
> >
> >  /*
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index ca65327a6de8..f27e96273453 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2369,6 +2369,7 @@ void console_unlock(void)
> >       static char ext_text[CONSOLE_EXT_LOG_MAX];
> >       static char text[LOG_LINE_MAX + PREFIX_MAX];
> >       unsigned long flags;
> > +     bool cflag;
> >       bool do_cond_resched, retry;
> >
> >       if (console_suspended) {
> > @@ -2469,9 +2470,10 @@ void console_unlock(void)
> >                */
> >               console_lock_spinning_enable();
> >
> > -             stop_critical_timings();        /* don't trace print latency */
> > +             /* don't trace print latency if it's disabled */
> > +             console_stop_critical_timings(cflag);
> >               call_console_drivers(ext_text, ext_len, text, len);
> > -             start_critical_timings();
> > +             console_start_critical_timings(cflag);
> >
> >               if (console_lock_spinning_disable_and_check()) {
> >                       printk_safe_exit_irqrestore(flags);
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 591c7a873235..10d12c8f7f77 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -1261,6 +1261,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
> >               C(PRINTK_MSGONLY,       "printk-msg-only"),     \
> >               C(CONTEXT_INFO,         "context-info"),   /* Print pid/cpu/time */ \
> >               C(LATENCY_FMT,          "latency-format"),      \
> > +             C(CONSOLE_LATENCY,      "console-latency"),     \
> >               C(RECORD_CMD,           "record-cmd"),          \
> >               C(RECORD_TGID,          "record-tgid"),         \
> >               C(OVERWRITE,            "overwrite"),           \
> > diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> > index a745b0cee5d3..576e2162114e 100644
> > --- a/kernel/trace/trace_irqsoff.c
> > +++ b/kernel/trace/trace_irqsoff.c
> > @@ -456,6 +456,24 @@ void stop_critical_timings(void)
> >  EXPORT_SYMBOL_GPL(stop_critical_timings);
> >  NOKPROBE_SYMBOL(stop_critical_timings);
> >
> > +bool console_tracing_disabled(void)
> > +{
> > +     struct trace_array *tr = irqsoff_trace;
> > +     int pc = preempt_count();
> > +
> > +     /*
> > +      * If tracing is disabled, then the question of whether to trace console
> > +      * latencies is moot. By always returning false here we save the caller
> > +      * the calls to start/stop_critical_timings(). These calls would not do
> > +      * anything anyway.
> > +      */
>
> I thought you were going to drop this patch, or at least I had suggested so
> but did not hear a reply from you: https://lkml.org/lkml/2019/10/3/464
>

Apologies, I should have replied there but I have been a bit busy the
last few days with other topics, and I felt a bit indecisive about
that point, so I just sloppily addressed the issue in the cover letter
of this new series:

"I have retained the fourth patch, although it was suggested that is becoming
obsolete soon. I have retained it only because I do not know the status of
the code that will make it obsolete. It's the last patch of the series and
if there indeed is some code that will remove the latency issues from the
printk code, then of course it makes sense to drop it. The first three patches
will work without it."

I thought that, since it's the last in the series, it would be
possible for maintainers to just take the first three if the last one
is not wanted.

For me it solves a rather important problem though, so if the code
that will make it obsolete isn't available for some time, then perhaps
it should be considered as a temporary solution.

Of course, if there is a commitment to never remove any knobs from
/sys/kernel/debug/tracing/trace_options, then I can easily understand
that it's not wanted as a temporary fix.

best regards,

Viktor

> Thanks for adding the comments though.
>
> Steve, what do you think about this patch? I am worried the extra flag may go
> obsolete at some point if the console latencies are fixed and we have yet
> another knob.
>
> thanks,
>
>  - Joel
>
> > +     if (!preempt_trace(pc) && !irq_trace())
> > +             return false;
> > +
> > +     return !(tr->trace_flags & TRACE_ITER_CONSOLE_LATENCY);
> > +}
> > +EXPORT_SYMBOL_GPL(console_tracing_disabled);
> > +
> >  #ifdef CONFIG_FUNCTION_TRACER
> >  static bool function_enabled;
> >
> > --
> > 2.17.1
> >
