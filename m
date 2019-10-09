Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2817A206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0aURVBUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfJIRlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:41:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51056 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfJIRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=30zvL17WUhifmX2hcBLj8F5VwlxGK4MB5wNSDqeJSiI=; b=0aURVBUXhcnLbvON8Yp5HrFlw
        NKOvoW08wma5yDaMHv6HyErRkFqhnsxjQfHAPoOAZV6hUP/uXLJYQAMjy3nWDFpY+M5cRQiYGCsJq
        SqVNJ4hKi2a8wM5wZ/js0/twBv+UC6MY3c2TINyTf5Wdc6dEpnBe02QFARtBtmMAAlI3YKcidTZG4
        3/wxG9FETG8ycj4l2UL6hWJuUvgQSAvYQ0fYVmR5X5NDNdPcdaeYikqvhj/vzdxaNfLBxVbH8JBv8
        aYa/RYTbJwfz2X/AgibVxgmeel1CXGi1WAcoruFpMumMcF90X0vmkT/MB60UYpk1fYlxEHvLb5fBO
        OnYMFwRfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIFxm-0006ER-Kt; Wed, 09 Oct 2019 17:41:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 535DB9802E0; Wed,  9 Oct 2019 19:41:24 +0200 (CEST)
Date:   Wed, 9 Oct 2019 19:41:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 05/10] lib/refcount: Improve performance of generic
 REFCOUNT_FULL code
Message-ID: <20191009174124.GD22902@worktop.programming.kicks-ass.net>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-6-will@kernel.org>
 <20191009092508.GH2311@hirez.programming.kicks-ass.net>
 <20191009164433.4dhgsmgkl4pe2nlx@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009164433.4dhgsmgkl4pe2nlx@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 05:44:33PM +0100, Will Deacon wrote:

> > > @@ -224,26 +208,19 @@ static inline void refcount_inc(refcount_t *r)
> > >   */
> > >  static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
> > >  {
> > > +	int old = atomic_fetch_sub_release(i, &r->refs);
> > >  
> > > +	if (old == i) {
> > >  		smp_acquire__after_ctrl_dep();
> > >  		return true;
> > >  	}
> > >  
> > > +	if (unlikely(old - i < 0)) {
> > > +		refcount_set(r, REFCOUNT_SATURATED);
> > > +		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
> > > +	}
> > 
> > I'm failing to see how this preserves REFCOUNT_SATURATED for
> > non-underflow. AFAICT this should have:
> > 
> > 	if (unlikely(old == REFCOUNT_SATURATED || old - i < 0))
> 
> Well spotted! I think we just want:
> 
> 	if (unlikely(old < 0 || old - i < 0))
> 
> here, which is reassuringly similar to the logic in refcount_add() and
> refcount_add_not_zero().

Oh indeed, I missed that saturated was negative. That should work.

> > > +	return false;
> > >  }
> > >  
> > >  /**
> > > @@ -276,9 +253,13 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
> > >   */
> > >  static inline void refcount_dec(refcount_t *r)
> > >  {
> > > +	int old = atomic_fetch_sub_release(1, &r->refs);
> > >  
> > > +	if (unlikely(old <= 1)) {
> > 
> > Idem.
> 
> Hmm, I don't get what you mean with the one, since we're looking at the
> old value. REFCOUNT_SATURATED is negative, so it will do the right thing.

Yep, missed that.

> > > +		refcount_set(r, REFCOUNT_SATURATED);
> > > +		WARN_ONCE(1, "refcount_t: decrement hit 0; leaking memory.\n");
> > > +	}
> > > +}
> > 
> > Also, things like refcount_dec_not_one() might need fixing to preserve
> > REFCOUNT_SATURATED, because they're not expecting that value to actually
> > change, but you do!
> 
> refcount_dec_not_one() already checks for REFCOUNT_SATURATED and, in the
> case of a racing thread setting the saturated value, the cmpxchg() will
> fail if the saturated value is written after the check or the saturated
> value will overwrite the value written by the cmpxchg(). Is there another
> race that you're thinking of?

Hmm, yes. I was afraid that by not recognising SATURATED it'd go wrong,
but now that I try I can't make it go wrong.
