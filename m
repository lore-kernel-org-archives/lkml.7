Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14336C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D523120828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="boBr3bnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCSLGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:06:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39120 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfCSLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aDUQb474lJl6A0Toj8sTsjQtApQ99VaLei1vd61Z9Yo=; b=boBr3bnVuEMACnZ6SvUpq5FNM
        m7wuAztr7rZoahTvV21/Oqo8tvAj613ANwCMaDz/jaGl1XhA6Nc4bwS1n3KAiGR6jayTU7onpJgJL
        Ebq2Xa2KCIW12V6zLdhW3KiD/FzaqpY/XCg1cM/K1Lcf2GLaSKtrWR0+r1zjnqLIza3rJq2VWqQB2
        bZCPRSwqVq57iYS8YHrE3Jh4yRHfIebiIhdxc3I0LWk+WiUUHCZK9lwKPK0QhEiNspElO8kuZp1+q
        x+f56inQrAvjQed21wDthDEcjP8wFAz77WZ+JxZScOM/bjbmz3Z8riMi9UuRMh0dVNzXXQi+Gcmo7
        cnrj1xTsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6CZ5-0008Lr-K5; Tue, 19 Mar 2019 11:05:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E9B123E8CA31; Tue, 19 Mar 2019 12:05:49 +0100 (CET)
Date:   Tue, 19 Mar 2019 12:05:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Message-ID: <20190319110549.GC5996@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:29:25PM -0700, Stephane Eranian wrote:

> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3410,7 +3410,7 @@ tfa_get_event_constraints(struct cpu_hw_
> >         /*
> >          * Without TFA we must not use PMC3.
> >          */
> > -       if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
> > +       if (!allow_tsx_force_abort && test_bit(3, c->idxmsk) && idx >= 0) {
> >                 c = dyn_constraint(cpuc, c, idx);
> >                 c->idxmsk64 &= ~(1ULL << 3);
> >                 c->weight--;
> >
> >

> I was not cc'd on the patch that added  allow_tsx_force_abort, so I

Yeah, that never was public :-( I didn't particularly like that, but
that's the way it is.

> will give some comments here.

> If I understand the goal of the control parameter it is to turn on/off
> the TFA workaround and thus determine whether or not PMC3 is
> available. I don't know why you would need to make this a runtime
> tunable.

Not quite; the control on its own doesn't directly write the MSR. And
even when the work-around is allowed, we'll not set the MSR unless there
is also demand for PMC3.

It is a runtime tunable because boot parameters suck.

> That seems a bit dodgy. But given the code you have here right now, we
> have to deal with it. A sysadmin could flip the control at any time,
> including when PMC3 is already in used by some events. I do not see
> the code that schedules out all the events on all CPUs once PMC3
> becomes unavailable. You cannot just rely on the next context-switch
> or timer tick for multiplexing.

Yeah, meh. You're admin, you can 'fix' it. In practise I don't expect
most people to care about the knob, and the few people that do, should
be able to make it work.
