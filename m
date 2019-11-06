Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C940C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023872178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWGF1s/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbfKFUoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:44:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfKFUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iSrhiQhFfjSXyzhJaY1L4Dc+Lzu/cN+fNwVAPe1EPWM=; b=jWGF1s/KuczzQ8ZtZg5G3IcO5
        k0aSAgY+BPE/8QyyKHwu6eRGHvdIzCIdU5+WHFf8oMizH9sgqUOiL6cDZgVmpBOW6V3TQJCDbUs2q
        LqTOMnu5VPEIL27vcUSRk7kDCf9p1LBfGkVY81AiTzd0qUQ2aL0Ayi2TgPSjo5O+WMDQqETEj0ac+
        xNWodAdsymx6XtE3NzwQ2y/X01up+ZbF6EsbS2zTqX8Q+Bfqc8ROYusrcfhk5cOASjwBa+uUJE6Sc
        1U3CI4nsBmaOKT6Z1LKdH7VU24U/HAyRW5fD0fqfcMr3tQoq2MDylH7A0VTeRCvyctNlxSyYg8kAA
        CnGLCqppQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSSA9-0005Ee-47; Wed, 06 Nov 2019 20:44:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30C44980DF5; Wed,  6 Nov 2019 21:44:19 +0100 (CET)
Date:   Wed, 6 Nov 2019 21:44:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6] perf: Sharing PMU counters across compatible events
Message-ID: <20191106204419.GI3079@worktop.programming.kicks-ass.net>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
 <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
 <98A6264C-B833-4930-95A0-2A3186519D87@fb.com>
 <20191105201623.GG3079@worktop.programming.kicks-ass.net>
 <23D48724-55B7-45A3-A77A-56BAD57937F9@fb.com>
 <20191106091458.GS4131@hirez.programming.kicks-ass.net>
 <168F3761-98CF-4E91-B911-ECB9FCD68F0C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168F3761-98CF-4E91-B911-ECB9FCD68F0C@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:40:29PM +0000, Song Liu wrote:
> > On Nov 6, 2019, at 1:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> >> OTOH, non-cgroup event could also be inactive. For example, when we have 
> >> to rotate events, we may schedule slave before master. 
> > 
> > Right, although I suppose in that case you can do what you did in your
> > patch here. If someone did IOC_DISABLE on the master, we'd have to
> > re-elect a master -- obviously (and IOC_ENABLE).
> 
> Re-elect master on IOC_DISABLE is good. But we still need work for ctx
> rotation. Otherwise, we need keep the master on at all time. 

I meant to says that for the rotation case we can do as you did here, if
we do add() on a slave, add the master if it wasn't add()'ed yet.

> >> And if the master is in an event group, it will be more complicated...
> > 
> > Hurmph, do you actually have that use-case? And yes, this one is tricky.
> > 
> > Would it be sufficient if we disallow group events to be master (but
> > allow them to be slaves) ?
> 
> Maybe we can solve this with an extra "first_active" pointer in perf_event.
> first_active points to the first event that being added by event_pmu_add(). 
> Then we need something like:
> 
> event_pmu_add(event)
> {
> 	if (event->dup_master->first_active) {
> 		/* sync with first_active */
> 	} else {
> 		/* this event will be the first_active */
> 		event->dup_master->first_active = event;
> 		pmu->add(event);
> 	}
> }

I'm confused on what exactly you're trying to solve with the
first_active thing. The problem with the group event as master is that
you then _must_ schedule the whole group, which is obviously difficult.

> >> If we do GFP_ATOMIC in perf_event_alloc(), maybe with an extra option, we
> >> don't need the tmp_master hack. So we only allocate master when we will 
> >> use it. 
> > 
> > You can't, that's broken on -RT. ctx->lock is a raw_spinlock_t and
> > allocator locks are spinlock_t.
> 
> How about we add another step in __perf_install_in_context(), like
> 
> __perf_install_in_context()
> {
> 	bool alloc_master;
> 
> 	perf_ctx_lock();
> 	alloc_master = find_new_sharing(event, ctx);
> 	perf_ctx_unlock();
> 	
> 	if (alloc_master)
> 		event->dup_master = perf_event_alloc();
> 	/* existing logic of __perf_install_in_context() */
> 
> }
> 
> In this way, we only allocate the master event when necessary, and it
> is outside of the locks. 

It's still broken on -RT, because __perf_install_in_context() is in
hardirq context (IPI) and the allocator locks are spinlock_t.

