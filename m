Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A222FC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795B7206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V344DF0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbfG2PWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:22:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47608 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387925AbfG2PWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=734mJqtkBi3LN0zhuGIgMjFn+GEEE5inKPVe1QAy5/0=; b=V344DF0eHmejI1+FylehubPRA
        ki3FVPGVRK4c/zroRMso6w37G0qm8Y+zZ9UJJBUtFOMokqSPLXbHoa7dj9r3zWLSivRHkAQnG6mqW
        N4tKvuQHPvsTfbFUvPP3p6xK/T27xWtuZqqyzN05fhXF8KkQQJLDYa6/N5xbttr3c8Fyk2ENSvZhJ
        5LrP5A3h2tBLfvI8Bbkx5H2O4JrgWMSdo5pLynuIX5qbctDFCdnDn+Eo5djn0Hz4Juhiq3b8/vg1A
        fOErOByXK0YtMiRXfBZrUu48fv3RPePiHs3zCC4lOifSsZpphxwCieqmvaNuzL5tSdeKRwjw1p8++
        g/NjbWxMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs7Tq-0003Tk-M4; Mon, 29 Jul 2019 15:22:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22B6320AFFE9E; Mon, 29 Jul 2019 17:22:29 +0200 (CEST)
Date:   Mon, 29 Jul 2019 17:22:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, riel@surriel.com,
        luto@kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] sched: Clean up active_mm reference counting
Message-ID: <20190729152229.GG31398@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
 <20190729142450.GE31425@hirez.programming.kicks-ass.net>
 <45546d31-4efb-c303-deae-7c866b0071a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45546d31-4efb-c303-deae-7c866b0071a9@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:16:55AM -0400, Waiman Long wrote:
> On 7/29/19 10:24 AM, Peter Zijlstra wrote:
> > On Mon, Jul 29, 2019 at 10:52:35AM +0200, Peter Zijlstra wrote:
> >
> > ---
> > Subject: sched: Clean up active_mm reference counting
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Mon Jul 29 16:05:15 CEST 2019
> >
> > The current active_mm reference counting is confusing and sub-optimal.
> >
> > Rewrite the code to explicitly consider the 4 separate cases:
> >
> >     user -> user
> >
> > 	When switching between two user tasks, all we need to consider
> > 	is switch_mm().
> >
> >     user -> kernel
> >
> > 	When switching from a user task to a kernel task (which
> > 	doesn't have an associated mm) we retain the last mm in our
> > 	active_mm. Increment a reference count on active_mm.
> >
> >   kernel -> kernel
> >
> > 	When switching between kernel threads, all we need to do is
> > 	pass along the active_mm reference.
> >
> >   kernel -> user
> >
> > 	When switching between a kernel and user task, we must switch
> > 	from the last active_mm to the next mm, hoping of course that
> > 	these are the same. Decrement a reference on the active_mm.
> >
> > The code keeps a different order, because as you'll note, both 'to
> > user' cases require switch_mm().
> >
> > And where the old code would increment/decrement for the 'kernel ->
> > kernel' case, the new code observes this is a neutral operation and
> > avoids touching the reference count.
> 
> I am aware of that behavior which is indeed redundant, but it is not
> what I am trying to fix and so I kind of leave it alone in my patch.

Oh sure; and it's not all that important either. It is jst that every
time I look at that code I get confused.

On top of that, the new is easier to rip the active_mm stuff out of,
which is where it came from.


