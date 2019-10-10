Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B91DC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375E6206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKQe7WMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfJJPHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:07:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33626 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJJPHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:07:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so8377133wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WUDm5zaFSbVu0zV8h5brUsLKlZDD8nubj8jchHL8uiI=;
        b=mKQe7WMl7WbrbvrR9sv6El1Eia4u2TAQY8VBeAFdGGjDfvhHf0R6aT+I8nxRN6a6Qz
         /sBhxJ2Uw/jPmSS7NjLHeMz02RkpHKi0celaoAgmtZTfjy8ivNUsiwqcOLoO3Gfo0wKi
         9zI7/ZJnrclP8rovCwS5OQgWl6b6BVTxHdS9Rw4pGKRwqjNU6GMALzSjCXhzY2mqRv4/
         KxjPmbyAOEE+ZIZ195oefa541R8tTGV2GMe6ss/xGadNUcfioI8K7YUYy0fHqMkHJ2rA
         nmu/Vs8ntPSMK4AYNc7GthaaFwD4gwGJ9Y1NRf5yXqqdcnmYRLyJGg+lj9tPU1DGtB50
         eC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WUDm5zaFSbVu0zV8h5brUsLKlZDD8nubj8jchHL8uiI=;
        b=okYMIt7IyWLMUQRTrH4UOPmYOrFawtQ5XZMHstOTRc9F6jApWUJwuyAX6yW8PO2r87
         bpmQeIzH4ydYHzEjr8YQqXcW3bet0PoaCqI/shZiUbsGkHiz8iwFpCm9wxhiu7gB+R5T
         wCTVKskjoJHK75U5zaNxUxjFZNTct+tOK0WV0XmBSgZVrY7LwyAlL04QpoDkUq/yffCI
         Lh0r+0NvQEbyvyHx+eI/5MMg6SiKZ15q8cbVwZZ2cv1ZM0o3EpMANNkt/nHstsNTV+1K
         dI9MXBrKEUEcKlcF/wQdOWmMRIWFhNxSQGIME+2pGmzFDFBrsZynfJUrVg2bWDrzQn7E
         LUTA==
X-Gm-Message-State: APjAAAUlxudz31+5Llf98nL/4lLQ3vmsxveU82c2vAyWEBefmbsGracV
        17/qWg1ov6eD7P1xXPJnCpO1JQ==
X-Google-Smtp-Source: APXvYqy2VkQGbfL4jZPGzf9WRuO/jriBF5av5PQvo0WnR2Qdx8QI3WPmJJsFt0oGa21EtnGX/1Gttg==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr9300842wrv.177.1570720057665;
        Thu, 10 Oct 2019 08:07:37 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id y186sm10500048wmb.41.2019.10.10.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 08:07:36 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:07:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] kdb: Fix "btc <cpu>" crash if the CPU didn't
 round up
Message-ID: <20191010150735.dhrj3pbjgmjrdpwr@holly.lan>
References: <20190925200220.157670-1-dianders@chromium.org>
 <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid>
 <20191007135459.lj3qc2tqzcv3xcia@holly.lan>
 <CAD=FV=Vqj9JqGCQX_Foij8EkFtSy8r2wB3uoXNae6PECwNV+CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vqj9JqGCQX_Foij8EkFtSy8r2wB3uoXNae6PECwNV+CQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:34:55PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Oct 7, 2019 at 6:55 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Wed, Sep 25, 2019 at 01:02:19PM -0700, Douglas Anderson wrote:
> > >
> > > I noticed that when I did "btc <cpu>" and the CPU I passed in hadn't
> > > rounded up that I'd crash.  I was going to copy the same fix from
> > > commit 162bc7f5afd7 ("kdb: Don't back trace on a cpu that didn't round
> > > up") into the "not all the CPUs" case, but decided it'd be better to
> > > clean things up a little bit.
> > >
> > > This consolidates the two code paths.  It is _slightly_ wasteful in in
> > > that the checks for "cpu" being too small or being offline isn't
> > > really needed when we're iterating over all online CPUs, but that
> > > really shouldn't hurt.  Better to have the same code path.
> > >
> > > While at it, eliminate at least one slightly ugly (and totally
> > > needless) recursive use of kdb_parse().
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > > Changes in v3:
> > > - Patch ("kdb: Fix "btc <cpu>" crash if the CPU...") new for v3.
> > >
> > > Changes in v2: None
> > >
> > >  kernel/debug/kdb/kdb_bt.c | 61 ++++++++++++++++++++++-----------------
> > >  1 file changed, 34 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> > > index 120fc686c919..d9af139f9a31 100644
> > > --- a/kernel/debug/kdb/kdb_bt.c
> > > +++ b/kernel/debug/kdb/kdb_bt.c
> > > @@ -101,6 +101,27 @@ kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
> > >       return 0;
> > >  }
> > >
> > > +static void
> > > +kdb_bt_cpu(unsigned long cpu)
> > > +{
> > > +     struct task_struct *kdb_tsk;
> > > +
> > > +     if (cpu >= num_possible_cpus() || !cpu_online(cpu)) {
> > > +             kdb_printf("WARNING: no process for cpu %ld\n", cpu);
> > > +             return;
> > > +     }
> > > +
> > > +     /* If a CPU failed to round up we could be here */
> > > +     kdb_tsk = KDB_TSK(cpu);
> > > +     if (!kdb_tsk) {
> > > +             kdb_printf("WARNING: no task for cpu %ld\n", cpu);
> > > +             return;
> > > +     }
> > > +
> > > +     kdb_set_current_task(kdb_tsk);
> > > +     kdb_bt1(kdb_tsk, ~0UL, false);
> > > +}
> > > +
> > >  int
> > >  kdb_bt(int argc, const char **argv)
> > >  {
> > > @@ -161,7 +182,6 @@ kdb_bt(int argc, const char **argv)
> > >       } else if (strcmp(argv[0], "btc") == 0) {
> > >               unsigned long cpu = ~0;
> > >               struct task_struct *save_current_task = kdb_current_task;
> > > -             char buf[80];
> > >               if (argc > 1)
> > >                       return KDB_ARGCOUNT;
> > >               if (argc == 1) {
> > > @@ -169,35 +189,22 @@ kdb_bt(int argc, const char **argv)
> > >                       if (diag)
> > >                               return diag;
> > >               }
> > > -             /* Recursive use of kdb_parse, do not use argv after
> > > -              * this point */
> > > -             argv = NULL;
> > >               if (cpu != ~0) {
> > > -                     if (cpu >= num_possible_cpus() || !cpu_online(cpu)) {
> > > -                             kdb_printf("no process for cpu %ld\n", cpu);
> > > -                             return 0;
> > > -                     }
> > > -                     sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
> > > -                     kdb_parse(buf);
> > > -                     return 0;
> > > -             }
> > > -             kdb_printf("btc: cpu status: ");
> > > -             kdb_parse("cpu\n");
> > > -             for_each_online_cpu(cpu) {
> > > -                     void *kdb_tsk = KDB_TSK(cpu);
> > > -
> > > -                     /* If a CPU failed to round up we could be here */
> > > -                     if (!kdb_tsk) {
> > > -                             kdb_printf("WARNING: no task for cpu %ld\n",
> > > -                                        cpu);
> > > -                             continue;
> > > +                     kdb_bt_cpu(cpu);
> > > +             } else {
> > > +                     /*
> > > +                      * Recursive use of kdb_parse, do not use argv after
> > > +                      * this point.
> > > +                      */
> > > +                     argv = NULL;
> > > +                     kdb_printf("btc: cpu status: ");
> > > +                     kdb_parse("cpu\n");
> > > +                     for_each_online_cpu(cpu) {
> > > +                             kdb_bt_cpu(cpu);
> > > +                             touch_nmi_watchdog();
> > >                       }
> > > -
> > > -                     sprintf(buf, "btt 0x%px\n", kdb_tsk);
> > > -                     kdb_parse(buf);
> > > -                     touch_nmi_watchdog();
> > > +                     kdb_set_current_task(save_current_task);
> > >               }
> > > -             kdb_set_current_task(save_current_task);
> >
> > Why does this move out into only one of the conditional branches?
> > Don't both of the above paths modify the current task?
> 
> The old code has a "return 0 in the case that "cpu != ~0", so this
> basically matches the prior behavior in restoring the current task for
> a "btc" but not leaving the current task changed in the case of "btc
> <cpu>".  Thus my patch doesn't actually change the existing behavior,
> but I guess that it does make the control flow simpler so it's easier
> to understand what the behavior is.  ;-)

Point taken. Horrific though it may be ;-) .


> Reading through other control flows of the various backtrace commands,
> it looks like it is intentional to leave the current task changed when
> you explicitly do an action on that task (or a CPU).
> 
> Actually, though, it wasn't clear to me that it ever made sense for
> any of these commands to implicitly leave the current task changed.
> If you agree, I can send a follow-up patch to change this behavior.

Personally I don't like implicit changes of state but I might need a bit
more thinking to agree (or disagree ;-) ).


Daniel.
