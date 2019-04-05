Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27112146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZT92meut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDEU0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:26:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40314 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEU0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=de0AH5cMYxV/DxIWWoZmP1MVzSoXcTp/ga6eLlyDjhc=; b=ZT92meut+OovvqJjbcDnw5Ilf
        mFK8x/BEC/C96obdUvlBJxak7cO3f6I3XKE89P5cXYcoYX5toTWJ8ZfrnGfx00wPMafJ3oASeFtlw
        M/prI4rcksOFoQcLdS9X/hTttvlC5mZIAGE1BtZtTUEmbefSzPK9uNpbJ7MU5YLiKduHAnELwdfnF
        sAieSlG5UGe4SXTifsLz+227yKuXBpHgi6ngSQ0h6tj/Z06VGstwot5FfCKzFLhK4yc9c6w/+HzMg
        wGWCsNYbWRpl1KMarSC/fA6Qh/KBZ3+o72XmZ3Qu8mNV4LNrBdlCfwx1EUG7szAjAeCttFElPxnkG
        9U3XjdNKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCVPq-0007M2-Tf; Fri, 05 Apr 2019 20:26:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6786B29AB64A1; Fri,  5 Apr 2019 22:26:20 +0200 (CEST)
Date:   Fri, 5 Apr 2019 22:26:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, mingo@elte.hu,
        nelson.dsouza@intel.com, Jiri Olsa <jolsa@redhat.com>,
        tonyj@suse.com
Subject: Re: [PATCH 3/3] perf/x86/intel: force resched when TFA sysctl is
 modified
Message-ID: <20190405202620.GG4038@hirez.programming.kicks-ass.net>
References: <20190404183219.125083-1-eranian@google.com>
 <20190404183219.125083-4-eranian@google.com>
 <20190405071333.GB4038@hirez.programming.kicks-ass.net>
 <CABPqkBTzBYSN_k6FV=iOmmBfZWmG2N9fYHke_MdiCCgO=KFeUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTzBYSN_k6FV=iOmmBfZWmG2N9fYHke_MdiCCgO=KFeUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:00:03AM -0700, Stephane Eranian wrote:

> > > +static void update_tfa_sched(void *ignored)
> > > +{
> > > +     struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > > +     struct pmu *pmu = x86_get_pmu();
> > > +     struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
> > > +     struct perf_event_context *task_ctx = cpuctx->task_ctx;
> > > +
> > > +     /* prevent any changes to the two contexts */
> > > +     perf_ctx_lock(cpuctx, task_ctx);
> > > +
> > > +     /*
> > > +      * check if PMC3 is used
> > > +      * and if so force schedule out for all event types all contexts
> > > +      */
> > > +     if (test_bit(3, cpuc->active_mask))
> > > +             perf_ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
> > > +
> > > +     perf_ctx_unlock(cpuctx, task_ctx);
> >
> > I'm not particularly happy with exporting all that. Can't we create this
> > new perf_ctx_resched() to include the locking and everything. Then the
> > above reduces to:
> >
> >         if (test_bit(3, cpuc->active_mask))
> >                 perf_ctx_resched(cpuctx);
> >
> > And we don't get to export the tricky bits.
> >
> The only reason I exported the locking is to protect
> cpuc->active_mask. But if you
> think there is no race, then sure,  we can just export a new
> perf_ctx_resched() that
> does the locking and invokes the ctx_resched() function.

It doesn't matter if it races, if it was used and isn't anymore, it's
a pointless reschedule, if it isn't used and we don't reschedule, it
cannot be used because we've already set the flag.
