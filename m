Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB9DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B840218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drkJWTIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCTUwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:52:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38507 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:52:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id h132so2397420vsd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxhqLRTRBI0cD3wr1T34EG/HLsxF9niZHXwzcQ8ow7Y=;
        b=drkJWTIUuDBJ5YIct/pHFtDl1YT/9GKvJvm22mj8x1qKjf5EM0ufpjLUTrvcDHMYj7
         ybD/ZydDI4HKbzzwcvVrKtmdeRCcDwhWgRxxDL7VtQE3Wqa+UxmUpRlVcq6BIy0DncFf
         8CGgpbViZ7yEvLm+r392aBq/eRPZaKsZjKJOicmheUH5kAKzKQEaM10y7gNbpvGl1BOj
         oQOlvnf44LPGy9hHS1Fm2Mrh69zR0z7R6i+pstyStpyyYRnZX4OTy8XoCyhBva9kWucO
         fLUDLLdpj+j1P4EVTgxJVaUsRox3oOSWRT/NuJgTkFHlwQYPq9co+6JVM5xigNiakwym
         ojBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxhqLRTRBI0cD3wr1T34EG/HLsxF9niZHXwzcQ8ow7Y=;
        b=plHxOaM8ytizNFP9+IVFFkf3L4uZWNjtHRD1hMeSjos5O36QWoCfwt25egTdLP26N7
         cQ1pGu3N8/RJhgIKGvJPaZU6z5ID/z6NXhRWoD/G6Z45CbuG/WryiMSQuaaSME15Wi+m
         FRvftixqx4cpMegpQr2jrGu+Lw+PY3yK0WZcnbatQXdwFm7Oxnpd63/8VUOaNj61/YxC
         zac4iM4EsGsZyJGUiQ76eXgKhggYUgMPLKM9eWyx3TiLqeERffxtqXRMsvBWFwelhlw+
         nk7JsWMGSrzA7/t+I6VEzmCwmuB+GjT0m1WfuHpy3bXfLnsxbJR3xlmnyLD9VU+Nd9ee
         XEiA==
X-Gm-Message-State: APjAAAUv/Sg9d33B5znzjuHdbNpsF0osOtDpbGpYgRH6FFM82VlODYdl
        F/0IDNZy/z3pQgyorSAi/IiaqhRDMP4WI/ph5Wfd/A==
X-Google-Smtp-Source: APXvYqzh4IOQv/xgWFalGMcbDHhumCAvpwX0mTBEU3D8pkdh87XGdCEScaKUSC4hzYwGemIKdyI9yBQDUjnSjGB1A0g=
X-Received: by 2002:a67:7e84:: with SMTP id z126mr6218655vsc.165.1553115159312;
 Wed, 20 Mar 2019 13:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net> <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net> <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
In-Reply-To: <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 20 Mar 2019 13:52:24 -0700
Message-ID: <CABPqkBR3GEOFEohRtBoFbGOZTB3MaSDq+8KmSLs4aFWJ6DE7Ag@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:47 PM Stephane Eranian <eranian@google.com> wrote:
>
> On Tue, Mar 19, 2019 at 11:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Mar 19, 2019 at 10:52:01AM -0700, Stephane Eranian wrote:
> > > > Not quite; the control on its own doesn't directly write the MSR. And
> > > > even when the work-around is allowed, we'll not set the MSR unless there
> > > > is also demand for PMC3.
> > > >
> > > Trying to understand this better here. When the workaround is enabled
> > > (tfa=0), you lose PMC3 and transactions operate normally.
> >
> > > When it is disabled (tfa=1), transactions are all aborted and PMC3 is
> > > available.
> >
> > Right, but we don't expose tfa.
> >
> > > If you are saying that when there is a PMU event requesting PMC3, then
> > > you need PMC3 avail, so you set the MSR so that tfa=1 forcing all
> > > transactions to abort.
> >
> > Right, so when allow_tfa=1 (default), we only set tfa=1 when PMC3 is
> > requested.
> >
> > This has the advantage that,
> >
> >   TSX only workload -> works
> >   perf 4 counteres -> works
> >
> > Only when you need both of them, do you get 'trouble'.
> >
> > > But in that case, you are modifying the execution of the workload when
> > > you are monitoring it, assuming it uses TSX.
> >
> > We assume you are not in fact using TSX, not a lot of code does. If you
> > do use TSX a lot, and you don't want to interfere, you have to set
> > allow_tfa=0 and live with one counter less.
> >
> > Any which way around you turn this stone, it sucks.
> >
> > > You want lowest overhead and no modifications to how the workload
> > > operates, otherwise how representative is the data you are collecting?
> >
> > Sure; but there are no good choices here. This 'fix' will break
> > something. We figured TSX+4-counter-perf was the least common scenario.
> >
> > We konw of people that rely on 4 counter being present; you want to
> > explain to them how when doing an update their program suddently doesn't
> > work anymore?
> >
> > Or you want to default to tfa=1; but then you have to explain to those
> > people relying on TSX why their workload stopped working.
> >
> > > I understand that there is no impact on apps not using TSX, well,
> > > except on context switch where you have to toggle that MSR.
> >
> > There is no additional code in the context switch; only the perf event
> > scheduling code prods at the MSR.
> >
> > > But for workloads using TSX, there is potentially an impact.
> >
> > Yes, well, if you're a TSX _and_ perf user, you now have an extra knob
> > to play with; that's not something I can do anything about. We're forced
> > to make a choice here.
> >
> > > > Yeah, meh. You're admin, you can 'fix' it. In practise I don't expect
> > > > most people to care about the knob, and the few people that do, should
> > > > be able to make it work.
> > >
> > > I don't understand how this can work reliably.
> >
> > > You have a knob to toggle that MSR.
> >
> > No, we don't have this knob.
> >
> > > Then, you have another one inside perf_events
> >
> > Only this knob exists allow_tfa.
> >
> > > and then the sysadmin has to make sure nobody (incl. NMI watchdog) is
> > > using the PMU when this all happens.
> >
> > You're very unlucky if the watchdog runs on PMC3, normally it runs on
> > Fixed1 or something. Esp early after boot. (Remember, we schedule fixed
> > counters first, and then general purpose counters, with a preference for
> > lower counters).
> >
> > Anyway, you can trivially switch it off if you want.
> >
> > > How can this be a practical solution? Am I missing something here?
> >
> > It works just fine; it is unfortunate that we have this interaction but
> > that's not something we can do anything about. We're forced to deal with
> > this.
> >
> Right now, if I do:
>
> echo 0 > /sys/bus/event_source/devices/cpu/allow_tsx_force_abort
>
> Then I don't have the guarantee on when there will be no abort when I
> return from the echo.
> the MSR is accessed only on PMU scheduling. I would expect a sysadmin
> to want some guarantee
> if this is to be switched on/off at runtime. If not, then having a
> boot time option is better in my opinion.
>
> This other bit I noticed is that cpuc->tfa_shadow is used to avoid the
> wrmsr(), but I don't see the
> code that makes sure the init value (0) matches the value of the MSR.
> Is this MSR guarantee to be
> zero on reset? How about on kexec()?
>

Furthermore, depending on what is measured on each CPU, i.e., PMC3 is
used or not,
the TFA may be set to true or false dynamically. So if you have a TSX
workload it may
be impacted depending on which CPU it runs on. I don't think users would like
that approach.


> > But if you're a TSX+perf user, have your boot scripts do:
> >
> >   echo 0 > /sys/bus/event_source/devices/cpu/allow_tsx_force_abort
> >
> > and you'll not use PMC3 and TSX will be 'awesome'. If you don't give a
> > crap about TSX (most people), just boot and be happy.
> >
> > If you do care about TSX+perf and want to dynamically toggle for some
> > reason, you just have to be a little careful.
