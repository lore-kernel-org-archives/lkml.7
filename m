Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47298C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C2B20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YdwWvJbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfJGXfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:35:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34424 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfJGXfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:35:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so13298085oii.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cd5fANmNO/0+yv+k6MZCYY0xb+xh97NDSvs/PRVUuA=;
        b=YdwWvJbiGSiDm8IZxHceGHTAS9JW3OYfxUTlkKSq1r3cvnhHkHaF7M4ycA0UmFnHqV
         TlZxb1RUyOakVqAsaGGJaZdwnFm2erSeFF289kuoYj+274xdo/AKAjIRq0+3LplZtTbH
         ydvhhkiRz5Yxyc2IIIDIS1tZPH7g/DpbYi7kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cd5fANmNO/0+yv+k6MZCYY0xb+xh97NDSvs/PRVUuA=;
        b=DudAUOMGfvx0dgL+qbxt5d5bSHWHgKFIk4pBWkQvQocn/2BelLoc25ct/1b2o+XqQi
         JiscB5n1PeS/DDngZqTLGM0FkZQMzwzGIS/NiUUEnrVtwBBzJrgr+N7odG1dZUbWLrme
         +meoLX2NsYKHSxjZPDsNdJNXuiMdvvFsY2vDR6mfpaKCPLbA9C5LXG1nI3mP+flJoB+z
         WEJOwBwMNliUEnhUytREOf8bKkX55xTM93ZEjm/jtqD1+7bTvhKxBqoAtAxOlQ6fyKF0
         HO04lN2HZWQ9tqcTeyYcsczcVtp6NhHBlzrYNDCRqzr+YZcHPfxKejQohGBsY0Wq+Bxf
         bd8w==
X-Gm-Message-State: APjAAAWk8ayup2DgxXF57GdFLUpkLm5G8QNJbScXTyWwBA2lQwkYjTXA
        UBr3LyMCAjbHXmTXxxFGJ/nJ8xGk0E4=
X-Google-Smtp-Source: APXvYqwYp3CM6GAsCwXNKdUHOzXhCT7SoVrf5jPt+lLZ5kd1p0aJJYPdAe5dRD4y3z0AVCaBI7nybA==
X-Received: by 2002:aca:c505:: with SMTP id v5mr1419577oif.79.1570491309008;
        Mon, 07 Oct 2019 16:35:09 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id 60sm5019560oto.27.2019.10.07.16.35.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 16:35:08 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id b19so32633540iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 16:35:08 -0700 (PDT)
X-Received: by 2002:a92:d7ce:: with SMTP id g14mr17815393ilq.269.1570491307637;
 Mon, 07 Oct 2019 16:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190925200220.157670-1-dianders@chromium.org>
 <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid> <20191007135459.lj3qc2tqzcv3xcia@holly.lan>
In-Reply-To: <20191007135459.lj3qc2tqzcv3xcia@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Oct 2019 16:34:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vqj9JqGCQX_Foij8EkFtSy8r2wB3uoXNae6PECwNV+CQ@mail.gmail.com>
Message-ID: <CAD=FV=Vqj9JqGCQX_Foij8EkFtSy8r2wB3uoXNae6PECwNV+CQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kdb: Fix "btc <cpu>" crash if the CPU didn't round up
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 7, 2019 at 6:55 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Sep 25, 2019 at 01:02:19PM -0700, Douglas Anderson wrote:
> >
> > I noticed that when I did "btc <cpu>" and the CPU I passed in hadn't
> > rounded up that I'd crash.  I was going to copy the same fix from
> > commit 162bc7f5afd7 ("kdb: Don't back trace on a cpu that didn't round
> > up") into the "not all the CPUs" case, but decided it'd be better to
> > clean things up a little bit.
> >
> > This consolidates the two code paths.  It is _slightly_ wasteful in in
> > that the checks for "cpu" being too small or being offline isn't
> > really needed when we're iterating over all online CPUs, but that
> > really shouldn't hurt.  Better to have the same code path.
> >
> > While at it, eliminate at least one slightly ugly (and totally
> > needless) recursive use of kdb_parse().
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Patch ("kdb: Fix "btc <cpu>" crash if the CPU...") new for v3.
> >
> > Changes in v2: None
> >
> >  kernel/debug/kdb/kdb_bt.c | 61 ++++++++++++++++++++++-----------------
> >  1 file changed, 34 insertions(+), 27 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> > index 120fc686c919..d9af139f9a31 100644
> > --- a/kernel/debug/kdb/kdb_bt.c
> > +++ b/kernel/debug/kdb/kdb_bt.c
> > @@ -101,6 +101,27 @@ kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
> >       return 0;
> >  }
> >
> > +static void
> > +kdb_bt_cpu(unsigned long cpu)
> > +{
> > +     struct task_struct *kdb_tsk;
> > +
> > +     if (cpu >= num_possible_cpus() || !cpu_online(cpu)) {
> > +             kdb_printf("WARNING: no process for cpu %ld\n", cpu);
> > +             return;
> > +     }
> > +
> > +     /* If a CPU failed to round up we could be here */
> > +     kdb_tsk = KDB_TSK(cpu);
> > +     if (!kdb_tsk) {
> > +             kdb_printf("WARNING: no task for cpu %ld\n", cpu);
> > +             return;
> > +     }
> > +
> > +     kdb_set_current_task(kdb_tsk);
> > +     kdb_bt1(kdb_tsk, ~0UL, false);
> > +}
> > +
> >  int
> >  kdb_bt(int argc, const char **argv)
> >  {
> > @@ -161,7 +182,6 @@ kdb_bt(int argc, const char **argv)
> >       } else if (strcmp(argv[0], "btc") == 0) {
> >               unsigned long cpu = ~0;
> >               struct task_struct *save_current_task = kdb_current_task;
> > -             char buf[80];
> >               if (argc > 1)
> >                       return KDB_ARGCOUNT;
> >               if (argc == 1) {
> > @@ -169,35 +189,22 @@ kdb_bt(int argc, const char **argv)
> >                       if (diag)
> >                               return diag;
> >               }
> > -             /* Recursive use of kdb_parse, do not use argv after
> > -              * this point */
> > -             argv = NULL;
> >               if (cpu != ~0) {
> > -                     if (cpu >= num_possible_cpus() || !cpu_online(cpu)) {
> > -                             kdb_printf("no process for cpu %ld\n", cpu);
> > -                             return 0;
> > -                     }
> > -                     sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
> > -                     kdb_parse(buf);
> > -                     return 0;
> > -             }
> > -             kdb_printf("btc: cpu status: ");
> > -             kdb_parse("cpu\n");
> > -             for_each_online_cpu(cpu) {
> > -                     void *kdb_tsk = KDB_TSK(cpu);
> > -
> > -                     /* If a CPU failed to round up we could be here */
> > -                     if (!kdb_tsk) {
> > -                             kdb_printf("WARNING: no task for cpu %ld\n",
> > -                                        cpu);
> > -                             continue;
> > +                     kdb_bt_cpu(cpu);
> > +             } else {
> > +                     /*
> > +                      * Recursive use of kdb_parse, do not use argv after
> > +                      * this point.
> > +                      */
> > +                     argv = NULL;
> > +                     kdb_printf("btc: cpu status: ");
> > +                     kdb_parse("cpu\n");
> > +                     for_each_online_cpu(cpu) {
> > +                             kdb_bt_cpu(cpu);
> > +                             touch_nmi_watchdog();
> >                       }
> > -
> > -                     sprintf(buf, "btt 0x%px\n", kdb_tsk);
> > -                     kdb_parse(buf);
> > -                     touch_nmi_watchdog();
> > +                     kdb_set_current_task(save_current_task);
> >               }
> > -             kdb_set_current_task(save_current_task);
>
> Why does this move out into only one of the conditional branches?
> Don't both of the above paths modify the current task?

The old code has a "return 0 in the case that "cpu != ~0", so this
basically matches the prior behavior in restoring the current task for
a "btc" but not leaving the current task changed in the case of "btc
<cpu>".  Thus my patch doesn't actually change the existing behavior,
but I guess that it does make the control flow simpler so it's easier
to understand what the behavior is.  ;-)

Reading through other control flows of the various backtrace commands,
it looks like it is intentional to leave the current task changed when
you explicitly do an action on that task (or a CPU).

Actually, though, it wasn't clear to me that it ever made sense for
any of these commands to implicitly leave the current task changed.
If you agree, I can send a follow-up patch to change this behavior.

-Doug
