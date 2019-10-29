Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE98CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE762067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUSJJ6Yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390761AbfJ2RJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:09:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46599 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390716AbfJ2RJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:09:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id w8so11607197lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K88yaieKvcCeNpugsGLmfxIwpDDi0ZtEXOdEH+qf0fA=;
        b=KUSJJ6YqudPa6QLkK/BK60Zl842G3MRsmv2DW5kvVHh4p/kDenZrhnrEbOmPdTzvgw
         I8q1/6MQu6/LALbcoU8JqLT1S4P2VX78KCleLVqTouQ0Yep8qgOoUplT/Aed8C3clRzT
         m577opm7GhHFmdRVSaPLRsdevIt0u8rs4iJXrxs+edkSysqasOxDGMu/VbTZXc0Yn9+d
         VvOSHMNffEegB9CJmgKqrdO1UX29UB+Im+zXSj771bYCexPVTJb4ZHUleCOsl/7IGvj3
         D6Yc7zFZhHKDNA/gTRqyTeiOppfjROeADIOrgchGq06tNoigUixu7W0712Zs9nGPCrY9
         U95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K88yaieKvcCeNpugsGLmfxIwpDDi0ZtEXOdEH+qf0fA=;
        b=INUNyR83OFOL6vjTlkInXImLnl9UyZs1oJGCmkbgPlYNVfb/0eE5iAxdKe7M4TQTI4
         A71jQicC+YHWsOAHv17A0zXs69EO6M7s93MpgxDBJ7KcFhSJJHRZqGcwgtW9ZjqtEduq
         KEaAnS6XA7LSAgcb/qS8fUrFIYbbFoeGjYQDwCwZkv+7d0/XicgNTakrRNuffWfPO5xI
         0F+lMREnpJ9ZKJt+CLYmyPYrdzv/ISpXXo2wN1FNiKxeOVqEwfvb3jy4rPYbmcFZ6nBy
         DAWoDP5G+r4NuXzabfbUZt4OvsXHEKE2ovPSVgBOLg7OiVqGQXTuOrDN5gC0mNSrh/eD
         UorQ==
X-Gm-Message-State: APjAAAX4PtgIPvfvIf0IKB8Z+rn+ZZLmyP4c5XfiklVAnXvuZ4ghK2ew
        ZEiP69f35PeueSd88S9vugnVKqV5taHqxqhfO+LpHA==
X-Google-Smtp-Source: APXvYqyJcslMrIOGNYE0X47a9sPVBXQLcpeAkCnxS1526iUdAKdcOTDZhZpnoBc4H7DFjrEOMOciu/zXkA+EWlIXABY=
X-Received: by 2002:a2e:96c1:: with SMTP id d1mr3590291ljj.87.1572368985549;
 Tue, 29 Oct 2019 10:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net> <20191029153615.GP4114@hirez.programming.kicks-ass.net>
 <CAKfTPtD79VE+gqffpBAGd39bJKe7ao+jbmVSQ7PtS=dky0Wx6g@mail.gmail.com>
 <20191029164955.GO4131@hirez.programming.kicks-ass.net> <CAKfTPtDByO5xZaA1zHb-0WLq3PaodByfbnH0RkJjf+jn0O81-Q@mail.gmail.com>
In-Reply-To: <CAKfTPtDByO5xZaA1zHb-0WLq3PaodByfbnH0RkJjf+jn0O81-Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Oct 2019 18:09:34 +0100
Message-ID: <CAKfTPtD-MD74Je7R1eURfrusCci9xt4dPVE0YLuAN4jWXcdEog@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 18:00, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 29 Oct 2019 at 17:50, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 29, 2019 at 05:20:56PM +0100, Vincent Guittot wrote:
> > > On Tue, 29 Oct 2019 at 16:36, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, Oct 29, 2019 at 07:55:26AM -0700, Doug Smythies wrote:
> > > >
> > > > > I only know that the call to the intel_pstate driver doesn't
> > > > > happen, and that it is because cfs_rq_is_decayed returns TRUE.
> > > > > So, I am asserting that the request is not actually decayed, and
> > > > > should not have been deleted.
> > > >
> > > > So what cfs_rq_is_decayed() does is allow a cgroup's cfs_rq to be
> > > > removed from the list.
> > > >
> > > > Once it is removed, that cfs_rq will no longer be checked in the
> > > > update_blocked_averages() loop. Which means done has less chance of
> > > > getting false. Which in turn means that it's more likely
> > > > rq->has_blocked_load becomes 0.
> > > >
> > > > Which all sounds good.
> > > >
> > > > Can you please trace what keeps the CPU awake?
> > >
> > > I think that the sequence below is what intel pstate driver was using
> > >
> > > rt/dl task wakes up and run for some times
> > > rt/dl pelt signal is no more null so periodic decay happens.
> > >
> > > before optimization update_cfs_rq_load_avg() for root cfs_rq was
> > > called even if pelt was null,
> > > which calls cfs_rq_util_change,  which calls intel pstate
> > >
> > > after optimization its no more called.
> >
> > Not calling cfs_rq_util_change() when it doesn't change, seems like the
> > right thing. Why would intel_pstate want it called when it doesn't
> > change?
>
> Yes I agree
>
> My original thought was that either irq/rt ordl pelt signals was used
> to set frequency and it needs to be called to decrease this freq while
> pelt signals was decaying but it doesn't seem to use it but only needs
> to be called from time to time

Apart from Doug's problem, we have 2 possible problems with the
current update_blocked_averages()
1- irq, dl and rt are updated after cfs but it is the cfs update that
will call schedutil for updating the frequency which means that this
is done with old irq/rt/dl value. we should change the order and start
with irq/rt and dl
2- when cfs is null but not irq/rt or dl, we decay the values but we
never call schedutil to update the freq accordingly. The impact is
probably minimal because only irq and timer can really run without
call schedutil to update frequency but this can happen.

I'm going to prepare some patches
