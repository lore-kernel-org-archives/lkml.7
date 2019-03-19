Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33272082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gZD75jZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCSSUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:20:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfCSSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=juRymJ+iEoeCdxC0HbfdiOGoZJfUK9Hyu6zHygcR+y4=; b=gZD75jZXzhc47l6ILkv0/Jzor
        jBPM1b/a/uHfUUqq9tMgltTHwFwJw6j3+Mbb5iDviHXStKgNvvTEQa4chAmV4Qh7W+9ftft6xDqD5
        6rBv9lOLkuCy62AFx3MZ1Vhm/t5G3zgC68sAQy91ah1sCzKlI88xITbSF+WUMVbSnszKZBdP6INaU
        VG1+zSsjORoiEYyMJBcskO4SWTkD5KRDryQZ0dFKZyCSe1UaV+zF/bdYe5DMGL17+d7bpgAemDm45
        NFCxtL1h0KcyekteavL963tD3ogGqT4mAp3T1nXlE/a55vXvPHBm9fznD834mnBi0/Y9R4YxfmbyC
        z80G1GowQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6JLv-0002Ot-1J; Tue, 19 Mar 2019 18:20:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60955284934F3; Tue, 19 Mar 2019 19:20:41 +0100 (CET)
Date:   Tue, 19 Mar 2019 19:20:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Message-ID: <20190319182041.GO5996@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net>
 <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:52:01AM -0700, Stephane Eranian wrote:
> > Not quite; the control on its own doesn't directly write the MSR. And
> > even when the work-around is allowed, we'll not set the MSR unless there
> > is also demand for PMC3.
> >
> Trying to understand this better here. When the workaround is enabled
> (tfa=0), you lose PMC3 and transactions operate normally.

> When it is disabled (tfa=1), transactions are all aborted and PMC3 is
> available.

Right, but we don't expose tfa.

> If you are saying that when there is a PMU event requesting PMC3, then
> you need PMC3 avail, so you set the MSR so that tfa=1 forcing all
> transactions to abort.

Right, so when allow_tfa=1 (default), we only set tfa=1 when PMC3 is
requested.

This has the advantage that,

  TSX only workload -> works
  perf 4 counteres -> works

Only when you need both of them, do you get 'trouble'.

> But in that case, you are modifying the execution of the workload when
> you are monitoring it, assuming it uses TSX.

We assume you are not in fact using TSX, not a lot of code does. If you
do use TSX a lot, and you don't want to interfere, you have to set
allow_tfa=0 and live with one counter less.

Any which way around you turn this stone, it sucks.

> You want lowest overhead and no modifications to how the workload
> operates, otherwise how representative is the data you are collecting?

Sure; but there are no good choices here. This 'fix' will break
something. We figured TSX+4-counter-perf was the least common scenario.

We konw of people that rely on 4 counter being present; you want to
explain to them how when doing an update their program suddently doesn't
work anymore?

Or you want to default to tfa=1; but then you have to explain to those
people relying on TSX why their workload stopped working.

> I understand that there is no impact on apps not using TSX, well,
> except on context switch where you have to toggle that MSR.

There is no additional code in the context switch; only the perf event
scheduling code prods at the MSR.

> But for workloads using TSX, there is potentially an impact.

Yes, well, if you're a TSX _and_ perf user, you now have an extra knob
to play with; that's not something I can do anything about. We're forced
to make a choice here.

> > Yeah, meh. You're admin, you can 'fix' it. In practise I don't expect
> > most people to care about the knob, and the few people that do, should
> > be able to make it work.
> 
> I don't understand how this can work reliably.

> You have a knob to toggle that MSR.

No, we don't have this knob.

> Then, you have another one inside perf_events

Only this knob exists allow_tfa.

> and then the sysadmin has to make sure nobody (incl. NMI watchdog) is
> using the PMU when this all happens.

You're very unlucky if the watchdog runs on PMC3, normally it runs on
Fixed1 or something. Esp early after boot. (Remember, we schedule fixed
counters first, and then general purpose counters, with a preference for
lower counters).

Anyway, you can trivially switch it off if you want.

> How can this be a practical solution? Am I missing something here?

It works just fine; it is unfortunate that we have this interaction but
that's not something we can do anything about. We're forced to deal with
this.

But if you're a TSX+perf user, have your boot scripts do:

  echo 0 > /sys/bus/event_source/devices/cpu/allow_tsx_force_abort

and you'll not use PMC3 and TSX will be 'awesome'. If you don't give a
crap about TSX (most people), just boot and be happy.

If you do care about TSX+perf and want to dynamically toggle for some
reason, you just have to be a little careful.
