Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E6ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72D921848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570639481;
	bh=AwI/z4wczWiCtg8ShmjGpaq6zBQ6QIZtKLOZVcLFXeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y52fl+GxD34uPzXbFfjdCbjVNkNmRyBrbUz+64SiFOWI7425Z7ZoIKZgntavax8/l
	 qd6QEcshplRduRmPJKCBUnbdPCjjNNQtqvdqBLcKNNoRlego6knW8Sr7n89WhorYhM
	 R0A8l7rlVIy+RDeE3oqGp3dNcCqbb3K2HeFevu78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfJIQok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfJIQoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:44:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9F2206BB;
        Wed,  9 Oct 2019 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570639478;
        bh=AwI/z4wczWiCtg8ShmjGpaq6zBQ6QIZtKLOZVcLFXeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHQLYybvUZetIOf0FRMXsjq0FSs91KGXzzaguwUVWZn022CsB2vFu/i4UB/ogTBAV
         yYIxQ6SSlUbEQDrsi2IJoVwRmGobIY2NtM+5eKwRWKxCfztZ/l7PDSrvRMBiiAOUTj
         9BzgZEiwxgoXrFGN2U8f8R7F4EbXl2QFM3QEjbog=
Date:   Wed, 9 Oct 2019 17:44:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 05/10] lib/refcount: Improve performance of generic
 REFCOUNT_FULL code
Message-ID: <20191009164433.4dhgsmgkl4pe2nlx@willie-the-truck>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-6-will@kernel.org>
 <20191009092508.GH2311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009092508.GH2311@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for having another look, even though you don't like it.

On Wed, Oct 09, 2019 at 11:25:08AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 07, 2019 at 04:46:58PM +0100, Will Deacon wrote:
> > Rewrite the generic REFCOUNT_FULL implementation so that the saturation
> > point is moved to INT_MIN / 2. This allows us to defer the sanity checks
> > until after the atomic operation, which removes many uses of cmpxchg()
> > in favour of atomic_fetch_{add,sub}().
> 
> It also radicaly changes behaviour, and afaict is subtly broken, see
> below.

Cheers. Replies below.

> > Some crude perf results obtained from lkdtm show substantially less
> > overhead, despite the checking:
> > 
> >  $ perf stat -r 3 -B -- echo {ATOMIC,REFCOUNT}_TIMING >/sys/kernel/debug/provoke-crash/DIRECT
> > 
> >  # arm64
> >  ATOMIC_TIMING:                                      46.50451 +- 0.00134 seconds time elapsed  ( +-  0.00% )
> >  REFCOUNT_TIMING (REFCOUNT_FULL, mainline):          77.57522 +- 0.00982 seconds time elapsed  ( +-  0.01% )
> >  REFCOUNT_TIMING (REFCOUNT_FULL, this series):       48.7181 +- 0.0256 seconds time elapsed  ( +-  0.05% )
> > 
> >  # x86
> >  ATOMIC_TIMING:                                      31.6225 +- 0.0776 seconds time elapsed  ( +-  0.25% )
> >  REFCOUNT_TIMING (!REFCOUNT_FULL, mainline/x86 asm): 31.6689 +- 0.0901 seconds time elapsed  ( +-  0.28% )
> >  REFCOUNT_TIMING (REFCOUNT_FULL, mainline):          53.203 +- 0.138 seconds time elapsed  ( +-  0.26% )
> >  REFCOUNT_TIMING (REFCOUNT_FULL, this series):       31.7408 +- 0.0486 seconds time elapsed  ( +-  0.15% )
> 
> I would _really_ like words on how this is racy and how it probably
> doesn't matter.

Sure thing, but I'll stick that into include/linux/refcount.h so that
it can sit alongside the other comments in there.

> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Elena Reshetova <elena.reshetova@intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Tested-by: Hanjun Guo <guohanjun@huawei.com>
> > Tested-by: Jan Glauber <jglauber@marvell.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  include/linux/refcount.h | 87 ++++++++++++++++------------------------
> >  1 file changed, 34 insertions(+), 53 deletions(-)
> > 
> > diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> > index e719b5b1220e..7f9aa6511142 100644
> > +++ b/include/linux/refcount.h
> > @@ -47,8 +47,8 @@ static inline unsigned int refcount_read(const refcount_t *r)
> >  #ifdef CONFIG_REFCOUNT_FULL
> >  #include <linux/bug.h>
> >  
> > +#define REFCOUNT_MAX		INT_MAX
> > +#define REFCOUNT_SATURATED	(INT_MIN / 2)
> >  
> >  /*
> >   * Variant of atomic_t specialized for reference counts.
> > @@ -109,25 +109,19 @@ static inline unsigned int refcount_read(const refcount_t *r)
> >   */
> >  static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
> >  {
> > +	int old = refcount_read(r);
> >  
> >  	do {
> > +		if (!old)
> > +			break;
> > +	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
> >  
> > +	if (unlikely(old < 0 || old + i < 0)) {
> 
> So this is obviously racy against itself and other operations.
> Particularly refcount_read(), as the sole API member that actually
> exposes the value, is affected.
> 
> Yes, it shouldn't happen and we'll have trouble if we ever hit this, but
> are all refcount_read() users sane enough to not cause further trouble?

Most refcount_read() users seem to be checking against a value of 0, 1
or 2, so yes, if you overflowed all the way around then you could cause
them to go wrong but I think that's just the same old discussion we've
been having about the impractical race. Given the racy nature of
using the result of refcount_read(), I don't see the saturated value
causing issues here (it will just look like a large refcount value).

There are more general issues around whether or not saturation semantics
can lead to bugs other that memory leaks, but they're not unique to this
patch series.

> > +		refcount_set(r, REFCOUNT_SATURATED);
> > +		WARN_ONCE(1, "refcount_t: saturated; leaking memory.\n");
> > +	}
> >  
> > +	return old;
> >  }
> >  
> >  /**
> > @@ -148,7 +142,13 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
> >   */
> >  static inline void refcount_add(int i, refcount_t *r)
> >  {
> > +	int old = atomic_fetch_add_relaxed(i, &r->refs);
> > +
> > +	WARN_ONCE(!old, "refcount_t: addition on 0; use-after-free.\n");
> 
> This is a change in behaviour vs the old one; the previous verion would
> not change the value this will.

Right. The new algorithm very much performs the bad operation and *then*
checks to see if it was bad, at which point it saturates. That's what
allows us to remove the cmpxchg() loops, but it does so at the cost of
opening up the race where you repeatedly perform operations on the bad
state before anybody has a chance to saturate.

> Is it important, I don't know, but it's not documented.

I'll try to document this too.

> > +	if (unlikely(old <= 0 || old + i <= 0)) {
> > +		refcount_set(r, REFCOUNT_SATURATED);
> > +		WARN_ONCE(old, "refcount_t: saturated; leaking memory.\n");
> > +	}
> >  }
> >  
> >  /**
> 
> > @@ -224,26 +208,19 @@ static inline void refcount_inc(refcount_t *r)
> >   */
> >  static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
> >  {
> > +	int old = atomic_fetch_sub_release(i, &r->refs);
> >  
> > +	if (old == i) {
> >  		smp_acquire__after_ctrl_dep();
> >  		return true;
> >  	}
> >  
> > +	if (unlikely(old - i < 0)) {
> > +		refcount_set(r, REFCOUNT_SATURATED);
> > +		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
> > +	}
> 
> I'm failing to see how this preserves REFCOUNT_SATURATED for
> non-underflow. AFAICT this should have:
> 
> 	if (unlikely(old == REFCOUNT_SATURATED || old - i < 0))

Well spotted! I think we just want:

	if (unlikely(old < 0 || old - i < 0))

here, which is reassuringly similar to the logic in refcount_add() and
refcount_add_not_zero().

> > +	return false;
> >  }
> >  
> >  /**
> > @@ -276,9 +253,13 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
> >   */
> >  static inline void refcount_dec(refcount_t *r)
> >  {
> > +	int old = atomic_fetch_sub_release(1, &r->refs);
> >  
> > +	if (unlikely(old <= 1)) {
> 
> Idem.

Hmm, I don't get what you mean with the one, since we're looking at the
old value. REFCOUNT_SATURATED is negative, so it will do the right thing.

> > +		refcount_set(r, REFCOUNT_SATURATED);
> > +		WARN_ONCE(1, "refcount_t: decrement hit 0; leaking memory.\n");
> > +	}
> > +}
> 
> Also, things like refcount_dec_not_one() might need fixing to preserve
> REFCOUNT_SATURATED, because they're not expecting that value to actually
> change, but you do!

refcount_dec_not_one() already checks for REFCOUNT_SATURATED and, in the
case of a racing thread setting the saturated value, the cmpxchg() will
fail if the saturated value is written after the check or the saturated
value will overwrite the value written by the cmpxchg(). Is there another
race that you're thinking of?

Cheers,

Will
