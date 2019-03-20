Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B622184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MpoauaZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfCTNLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:11:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50634 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfCTNLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jeIj4B9pcP7Jeqqk1m83TzJVxuwYdDjsG8OSNJ5tKs8=; b=MpoauaZQfygHILKiOwe9z4fiA
        qnxBtAPO0V02UnONTb2ry++2rpzQvNsSkHAhJKqqtCL8VtnOT03aYyJx9gfpie+q08HFbIesNMj1y
        VxwpTM3ESUoYYefOAtdBt8zW2HiM1z99fj1Mw4lqQlMVAXAHSpwSAAuMv0LaX5UlQJgej3vGsYsx4
        oEZYtroVf8bGBsO16VbL8pYQZihEO8r6vineR9wLQ7YJNnVpCk6klP0mw2Gmxlz4eugdRBVvUNCYK
        rFJS1m6ET4yvTeLTuGaRbSDYtkvPgfncO33Vpf3LbfrUWZGzqv6JwqEKeIrJbMlMMiQd81ZqF3tV7
        U1rIhtb2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6azu-0002s5-Im; Wed, 20 Mar 2019 13:11:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2533D2391A9C9; Wed, 20 Mar 2019 14:11:08 +0100 (CET)
Date:   Wed, 20 Mar 2019 14:11:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [RFC][PATCH 7/8] perf/x86: Optimize x86_schedule_events()
Message-ID: <20190320131108.GG6058@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130706.061994422@infradead.org>
 <CABPqkBSH5UBaV7+0JKgr4YmEke8Tu4Hry9GAFYT5C_gsncqf3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSH5UBaV7+0JKgr4YmEke8Tu4Hry9GAFYT5C_gsncqf3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:55:16PM -0700, Stephane Eranian wrote:
> On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > @@ -858,8 +864,20 @@ int x86_schedule_events(struct cpu_hw_ev
> >                 x86_pmu.start_scheduling(cpuc);
> >
> >         for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
> > -               c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
> > -               cpuc->event_constraint[i] = c;
> > +               c = cpuc->event_constraint[i];
> > +
> > +               /*
> > +                * Request constraints for new events; or for those events that
> > +                * have a dynamic constraint due to the HT workaround -- for
> > +                * those the constraint can change due to scheduling activity
> > +                * on the other sibling.
> > +                */
> > +               if (!c || ((c->flags & PERF_X86_EVENT_DYNAMIC) &&
> > +                          is_ht_workaround_active(cpuc))) {
> > +
> > +                       c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
> > +                       cpuc->event_constraint[i] = c;
> > +               }

> On this one, I think there may be a problem with events with
> shared_regs constraints.

Hmm...

> Constraint is dynamic as it depends on other events which share the
> same MSR, yet it is not marked as DYNAMIC.

it returns &emptyconstraint or a table constraint, depending on register
state.

> But this may be okay because these other events are all on the same
> CPU and thus scheduled during the same ctx_sched_in(). Yet with the
> swapping in intel_alt_er(), we need to double-check that we cannot
> reuse a constraint which could be stale.

> I believe this is okay, just double-check.

I'm not sure I see a problem.

So if we're the first event on a shared register, we claim the register
and scheduling succeeds (barring other constraints).

If we're the second event on a shared register (and have conflicting
register state), we get the empty constraint. This _will_ cause
scheduling to fail. We'll not cache the state and punt it back to the
core code.

So no future scheduling pass will come to see a shared reg constraint
that could've changed.

Now, there is indeed the intel_alt_er() thing, which slightly
complicates this; then suppose we schedule an event on RSP0, another on
RSP1, then remove the RSP0 one. Even in that case, the remaining RSP1
event will not change its constraint, since intel_fixup_er() rewrites
the event to be a native RSP1 event.

So that too reduces to the prior case.


That said; I have simplified the above condition to:

@@ -858,8 +858,17 @@ int x86_schedule_events(struct cpu_hw_ev
 		x86_pmu.start_scheduling(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
-		c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
-		cpuc->event_constraint[i] = c;
+		c = cpuc->event_constraint[i];
+
+		/*
+		 * Request constraints for new events; or for those events that
+		 * have a dynamic constraint -- for those the constraint can
+		 * change due to external factors (sibling state, allow_tfa).
+		 */
+		if (!c || (c->flags & PERF_X86_EVENT_DYNAMIC)) {
+			c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
+			cpuc->event_constraint[i] = c;
+		}
 
 		wmin = min(wmin, c->weight);
 		wmax = max(wmax, c->weight);

Because any dynamic event can change from one moment to the next.
