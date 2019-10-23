Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DE6CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B7721D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IAXJcfjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403898AbfJWJiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:38:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbfJWJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=08h2Fac4binfde4ottD+HQZVrVOQxbpKLsAB927oEJs=; b=IAXJcfjgK/GUlvRiGaRoOru2V
        Glp2+FLESPHbp6mucnf59vda8jyHelKbFehC5EQYpU27itgefobVbQrlQxeuf4EJVDbgDuXs6j0/f
        08cWrdLvUP+DcTFL/lsvdrnwpOiqKOA7M8y1Zcx6XZr78RZVxECvOzIQASWb1xoMflPaWAMs7BNn2
        BzfkayP70VSySTwFe0P0tczGubWh6ODHWxHx1V2iRFSmTqj+DaZF4x3ffvQTIwDFnewCXBfgi+2hY
        mIqpNiNNOTXQx6Qi1NwgyjbV1TN+Y5AW64+RRebJSIuB0HLqYNfcnAT4+4sKI5tUSKFkza5FToqVa
        BAaavjnWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iND5b-00088E-9O; Wed, 23 Oct 2019 09:37:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7448D300EBF;
        Wed, 23 Oct 2019 11:36:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36F492B1C6361; Wed, 23 Oct 2019 11:37:57 +0200 (CEST)
Date:   Wed, 23 Oct 2019 11:37:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
Message-ID: <20191023093757.GR1817@hirez.programming.kicks-ass.net>
References: <20191018002746.149200-1-eranian@google.com>
 <20191021100558.GC1800@hirez.programming.kicks-ass.net>
 <CABPqkBRgBegcdNHtXUqkdfJUASjuUYnSkh_cNeqfoO4wF7tnFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRgBegcdNHtXUqkdfJUASjuUYnSkh_cNeqfoO4wF7tnFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:06:43AM -0700, Stephane Eranian wrote:
> On Mon, Oct 21, 2019 at 3:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Oct 17, 2019 at 05:27:46PM -0700, Stephane Eranian wrote:

> > > +      * others removed. There is a way to get removed and not be disabled first.
> > > +      */
> > > +     if (ctx->rotate_necessary && ctx->nr_events) {
> > > +             int type = get_event_type(event);
> > > +             /*
> > > +              * In case we removed a pinned event, then we need to
> > > +              * resched for both pinned and flexible events. The
> > > +              * opposite is not true. A pinned event can never be
> > > +              * inactive due to multiplexing.
> > > +              */
> > > +             if (type & EVENT_PINNED)
> > > +                     type |= EVENT_FLEXIBLE;
> > > +             ctx_resched(cpuctx, cpuctx->task_ctx, type);
> > > +     }
> >
> > What you're relying on is that ->rotate_necessary implies ->is_active
> > and there's pending events. And if we tighten ->rotate_necessary you can
> > remove the && ->nr_events.
> >
> Imagine I have 6 events and 4 counters and I do delete them all before
> the timer expires.  Then, I can be in a situation where
> rotate_necessary is still true and yet have no more events in the
> context. That is because only ctx_sched_out() clears rotate_necessary,
> IIRC. So that is why there is the && nr_events. Now, calling
> ctx_resched() with no events wouldn't probably cause any harm, just
> wasted work.

> So if by tightening, I am guessing you mean clearing rotate_necessary
> earlier. But that would be tricky because the only reliable way of
> clearing it is when you know you are about the reschedule everything.
> Removing an event by itself may not be enough to eliminate
> multiplexing.

I think you're over-thinking things. The thing you test 'ctx->nr_events'
has a clear place where it drops to 0.

If we add

	ctx->nr_events--;
+	if (!ctx->nr_events && ctx->rotate_necessary)
+		ctx->rotate_necessary = 0;

to list_del_event(), we can get rid of that.

Further, since we set it on reschedule, I propose you change the above
like:

	if (ctx->rotate_necessary) {
		int type = get_event_type(event);
		/*
		 * comment..
		 */
		if (type & EVENT_PINNED)
			type |= EVENT_FLEXIBLE;
+		/*
+		 * Will be reset by ctx_resched()'s flexible_sched_in().
+		 */
+		ctx->rotate_necessary = 0;
		ctx_resched(cpuctx, cpuctx->task_ctx, type);
	}

Then rotate_necessary will be tight.
