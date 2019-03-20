Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C21218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjMocSBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCTUrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:47:46 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44783 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:47:42 -0400
Received: by mail-ua1-f68.google.com with SMTP id r21so1239923uan.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ETB6cmcCj3KBLuC5+XEE51LlvnHdqbAufRctEtts7U=;
        b=CjMocSBako73Be6kKHR0FGSHMorgn092yiG8Y38w8+d1XN2nGhZ/j7BCOvwLcQ+PvX
         3p43KYyfC72UFNFkOZ+IPP7CKUAQ7CettsqkN01DOh2I6ibrSWSLLOPZGUTKnybZJ4uB
         5aFn6MCeEEC4ke67vboTEhYxDjPKSk3/2Ek7IqkunV63EWh8ho5DbK3P8S/PaFfn9GNX
         8g+rAUOL+jtU7Vy6YC45B3AILPe51kDSaXCJBv9ZCmXSyg6j4onXWSSMo3hIjazGvkzI
         o0lfqsAEZ1KOSqRNNMB+qQkIFEeVXovwszBYxcg1L2mqTz2juPj9/jxFTmLSK4iCsxIH
         baGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ETB6cmcCj3KBLuC5+XEE51LlvnHdqbAufRctEtts7U=;
        b=UEW3jwBR/DDhL9BdevThr4QpT/3L9YqBOrwtBMqnvejT1FheFyLfbiORoxqMRzLTT9
         ZyyrR6X1leoH2aqO3a1SqhHeLI6yMMwzdsE//EqS0ia/d6D0URhIxwgBkfn/I+pN3kDH
         P4kaUbPgJYTu0wi80Zab3kFSN3csJBMVF5S65d/2838266shp1IeY0Bg4yMMsJQgHO+m
         NmtlI1PCCCHMUaQaywqoTZAxoQaHYXiQFcq27n42xMXLkZS4d+Z+O8923fTbx5i/iyXE
         g8apOlorNdjdXRdEYrIl5/ic2a937fvZPvbxF7Z7aYfkjMq289Ufw/4D+yRqtE7JEFWg
         33Xw==
X-Gm-Message-State: APjAAAU5PiiFletGfb+vJ4+39a8YAbSmG+KHZNSul8BbINdhgiYWa13T
        LrWumF2Ai3jynjcazFjpvrQn7vot3Mpemp++RzLsLA==
X-Google-Smtp-Source: APXvYqwCvzeW2wQE0oWuq/a0rz0045SXnb5K/5NX5MCf9adNKjA/9NSMKZrd+3QZoqVgSPEbd1mTfGIst6+VmqzKHh4=
X-Received: by 2002:ab0:6193:: with SMTP id h19mr5364285uan.47.1553114860767;
 Wed, 20 Mar 2019 13:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net> <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net>
In-Reply-To: <20190319182041.GO5996@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 20 Mar 2019 13:47:28 -0700
Message-ID: <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 11:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 19, 2019 at 10:52:01AM -0700, Stephane Eranian wrote:
> > > Not quite; the control on its own doesn't directly write the MSR. And
> > > even when the work-around is allowed, we'll not set the MSR unless there
> > > is also demand for PMC3.
> > >
> > Trying to understand this better here. When the workaround is enabled
> > (tfa=0), you lose PMC3 and transactions operate normally.
>
> > When it is disabled (tfa=1), transactions are all aborted and PMC3 is
> > available.
>
> Right, but we don't expose tfa.
>
> > If you are saying that when there is a PMU event requesting PMC3, then
> > you need PMC3 avail, so you set the MSR so that tfa=1 forcing all
> > transactions to abort.
>
> Right, so when allow_tfa=1 (default), we only set tfa=1 when PMC3 is
> requested.
>
> This has the advantage that,
>
>   TSX only workload -> works
>   perf 4 counteres -> works
>
> Only when you need both of them, do you get 'trouble'.
>
> > But in that case, you are modifying the execution of the workload when
> > you are monitoring it, assuming it uses TSX.
>
> We assume you are not in fact using TSX, not a lot of code does. If you
> do use TSX a lot, and you don't want to interfere, you have to set
> allow_tfa=0 and live with one counter less.
>
> Any which way around you turn this stone, it sucks.
>
> > You want lowest overhead and no modifications to how the workload
> > operates, otherwise how representative is the data you are collecting?
>
> Sure; but there are no good choices here. This 'fix' will break
> something. We figured TSX+4-counter-perf was the least common scenario.
>
> We konw of people that rely on 4 counter being present; you want to
> explain to them how when doing an update their program suddently doesn't
> work anymore?
>
> Or you want to default to tfa=1; but then you have to explain to those
> people relying on TSX why their workload stopped working.
>
> > I understand that there is no impact on apps not using TSX, well,
> > except on context switch where you have to toggle that MSR.
>
> There is no additional code in the context switch; only the perf event
> scheduling code prods at the MSR.
>
> > But for workloads using TSX, there is potentially an impact.
>
> Yes, well, if you're a TSX _and_ perf user, you now have an extra knob
> to play with; that's not something I can do anything about. We're forced
> to make a choice here.
>
> > > Yeah, meh. You're admin, you can 'fix' it. In practise I don't expect
> > > most people to care about the knob, and the few people that do, should
> > > be able to make it work.
> >
> > I don't understand how this can work reliably.
>
> > You have a knob to toggle that MSR.
>
> No, we don't have this knob.
>
> > Then, you have another one inside perf_events
>
> Only this knob exists allow_tfa.
>
> > and then the sysadmin has to make sure nobody (incl. NMI watchdog) is
> > using the PMU when this all happens.
>
> You're very unlucky if the watchdog runs on PMC3, normally it runs on
> Fixed1 or something. Esp early after boot. (Remember, we schedule fixed
> counters first, and then general purpose counters, with a preference for
> lower counters).
>
> Anyway, you can trivially switch it off if you want.
>
> > How can this be a practical solution? Am I missing something here?
>
> It works just fine; it is unfortunate that we have this interaction but
> that's not something we can do anything about. We're forced to deal with
> this.
>
Right now, if I do:

echo 0 > /sys/bus/event_source/devices/cpu/allow_tsx_force_abort

Then I don't have the guarantee on when there will be no abort when I
return from the echo.
the MSR is accessed only on PMU scheduling. I would expect a sysadmin
to want some guarantee
if this is to be switched on/off at runtime. If not, then having a
boot time option is better in my opinion.

This other bit I noticed is that cpuc->tfa_shadow is used to avoid the
wrmsr(), but I don't see the
code that makes sure the init value (0) matches the value of the MSR.
Is this MSR guarantee to be
zero on reset? How about on kexec()?

> But if you're a TSX+perf user, have your boot scripts do:
>
>   echo 0 > /sys/bus/event_source/devices/cpu/allow_tsx_force_abort
>
> and you'll not use PMC3 and TSX will be 'awesome'. If you don't give a
> crap about TSX (most people), just boot and be happy.
>
> If you do care about TSX+perf and want to dynamically toggle for some
> reason, you just have to be a little careful.
