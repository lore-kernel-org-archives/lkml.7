Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BAACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9350C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fa4SCjVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfJUKVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:21:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gctGGf6gN1uE/p3OgM+7fZIiQaTfbewCECnuMIfvjcw=; b=Fa4SCjViGkrQdUoDl9oUwXSPh
        ic8/hDm1Xqrgx1fY/lUf2GeCtZDRn5Tmwk2rAw0yGkuC9skapY+0zmbR0a2GAuTOxs81iDMx5Lc7O
        B2ofzcQ/Tt0fct4dL1AEyxWH1E0dINHoWkkx/7yAE+lFS5M1dnKRaqfYa44tHO2JbR+SNBGBqECWb
        8njBKNMhBL9mcDHKAYwF+DAJ/W17vhd+qBe4XS5BIgeVj/eQ4/ur+HDXqsoTK4whS2+XtFNDf/qbC
        NZu1rv2Es/eN6UHl8Q8tkUjHDimkBokOogkGgr2GvtkDkTolw+oPpq+fINGjpIOiRmFaj5w9v/DBR
        AXvp+nu1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMUo9-0002Yt-5b; Mon, 21 Oct 2019 10:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D48E300EBF;
        Mon, 21 Oct 2019 12:20:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1348B202411A1; Mon, 21 Oct 2019 12:20:59 +0200 (CEST)
Date:   Mon, 21 Oct 2019 12:20:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com,
        jolsa@redhat.com, kan.liang@intel.com, songliubraving@fb.com,
        irogers@google.com
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
Message-ID: <20191021102059.GD1800@hirez.programming.kicks-ass.net>
References: <20191018002746.149200-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018002746.149200-1-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:27:46PM -0700, Stephane Eranian wrote:
> This patch complements the following commit:
> 7fa343b7fdc4 ("perf/core: Fix corner case in perf_rotate_context()")
> 
> The fix from Song addresses the consequences of the problem but
> not the cause. This patch fixes the causes and can sit on top of
> Song's patch.

I'm tempted to say the other way around.

Consider the case where you claim fixed2 with a pinned event and then
have another fixed2 in the flexible list. At that point you're _never_
going to run any other flexible events (without Song's patch).

This patch isn't going to help with that. Similarly, Songs patch helps
with your situation where it will allow rotation to resume after you
disable/remove all active events (while you still have pending events).

> This patch fixes a scheduling problem in the core functions of
> perf_events. Under certain conditions, some events would not be
> scheduled even though many counters would be available. This
> is related to multiplexing and is architecture agnostic and
> PMU agnostic (i.e., core or uncore).
> 
> This problem can easily be reproduced when you have two perf
> stat sessions. The first session does not cause multiplexing,
> let's say it is measuring 1 event, E1. While it is measuring,
> a second session starts and causes multiplexing. Let's say it
> adds 6 events, B1-B6. Now, 7 events compete and are multiplexed.
> When the second session terminates, all 6 (B1-B6) events are
> removed. Normally, you'd expect the E1 event to continue to run
> with no multiplexing. However, the problem is that depending on
> the state Of E1 when B1-B6 are removed, it may never be scheduled
> again. If E1 was inactive at the time of removal, despite the
> multiplexing hrtimer still firing, it will not find any active
> events and will not try to reschedule. This is what Song's patch
> fixes. It forces the multiplexing code to consider non-active events.

This; so Song's patch fixes the fundamental problem of the rotation not
working right under certain conditions.

> However, the cause is not addressed. The kernel should not rely on
> the multiplexing hrtimer to unblock inactive events. That timer
> can have abitrary duration in the milliseconds. Until the timer
> fires, counters are available, but no measurable events are using
> them. We do not want to introduce blind spots of arbitrary durations.

This I disagree with -- you don't get a guarantee other than
timer_period/n when you multiplex, and idling the counters until the
next tick doesn't violate that at all.

> This patch addresses the cause of the problem, by checking that,
> when an event is disabled or removed and the context was multiplexing
> events, inactive events gets immediately a chance to be scheduled by
> calling ctx_resched(). The rescheduling is done on  event of equal
> or lower priority types.  With that in place, as soon as a counter
> is freed, schedulable inactive events may run, thereby eliminating
> a blind spot.

Disagreed, Song's patch removed the fundamental blind spot of rotation
completely failing.

This just slightly optimizes counter usage -- at a cost of having to
reprogram the counters more often.

Not saying we shouldn't do this, but this justification is just all
sorts of wrong.
