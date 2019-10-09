Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD14206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uDjTW4Qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfJIJZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:25:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46974 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TpZSGuVnffGqsCbCThcUFWqgddNgRwVLxOV/CSpnttk=; b=uDjTW4Qjx+R6sw5od8sUAH3wG
        KoyBkEFQ0HmWW3rLTTlh5+Qm03XZzYSYAT/3hf0Q3Mwty5LrBknMv9L+V8XgYvATrHt6pM2iDAiY0
        zcz+Uxddxk2COo4S8k7rkEFcFKCcdiP5Eve0e9qNNHxwayf1Y0y+ukqhb20rDmTN/J0Nn85YoHQSu
        KXVvnl7htR789agkS+01O8kcVUtMnv/av+RoLy9zulWjfG8ad1BMT91N88qz8EgqcpjlGOc/uHOYH
        WE+eVZDMS3AkunprBUlHrBSEsP1lLDnwqqpk2Zu/367qCwbRdFHM3zjvvQhnfeZ70sW+djCXHvn+b
        OuYHm5O3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iI8DW-0000bM-IC; Wed, 09 Oct 2019 09:25:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA254305DE2;
        Wed,  9 Oct 2019 11:24:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7412020BCA6A9; Wed,  9 Oct 2019 11:25:08 +0200 (CEST)
Date:   Wed, 9 Oct 2019 11:25:08 +0200
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
Message-ID: <20191009092508.GH2311@hirez.programming.kicks-ass.net>
References: <20191007154703.5574-1-will@kernel.org>
 <20191007154703.5574-6-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007154703.5574-6-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 04:46:58PM +0100, Will Deacon wrote:
> Rewrite the generic REFCOUNT_FULL implementation so that the saturation
> point is moved to INT_MIN / 2. This allows us to defer the sanity checks
> until after the atomic operation, which removes many uses of cmpxchg()
> in favour of atomic_fetch_{add,sub}().

It also radicaly changes behaviour, and afaict is subtly broken, see
below.

> Some crude perf results obtained from lkdtm show substantially less
> overhead, despite the checking:
> 
>  $ perf stat -r 3 -B -- echo {ATOMIC,REFCOUNT}_TIMING >/sys/kernel/debug/provoke-crash/DIRECT
> 
>  # arm64
>  ATOMIC_TIMING:                                      46.50451 +- 0.00134 seconds time elapsed  ( +-  0.00% )
>  REFCOUNT_TIMING (REFCOUNT_FULL, mainline):          77.57522 +- 0.00982 seconds time elapsed  ( +-  0.01% )
>  REFCOUNT_TIMING (REFCOUNT_FULL, this series):       48.7181 +- 0.0256 seconds time elapsed  ( +-  0.05% )
> 
>  # x86
>  ATOMIC_TIMING:                                      31.6225 +- 0.0776 seconds time elapsed  ( +-  0.25% )
>  REFCOUNT_TIMING (!REFCOUNT_FULL, mainline/x86 asm): 31.6689 +- 0.0901 seconds time elapsed  ( +-  0.28% )
>  REFCOUNT_TIMING (REFCOUNT_FULL, mainline):          53.203 +- 0.138 seconds time elapsed  ( +-  0.26% )
>  REFCOUNT_TIMING (REFCOUNT_FULL, this series):       31.7408 +- 0.0486 seconds time elapsed  ( +-  0.15% )

I would _really_ like words on how this is racy and how it probably
doesn't matter.

> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> Tested-by: Jan Glauber <jglauber@marvell.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/refcount.h | 87 ++++++++++++++++------------------------
>  1 file changed, 34 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index e719b5b1220e..7f9aa6511142 100644
> +++ b/include/linux/refcount.h
> @@ -47,8 +47,8 @@ static inline unsigned int refcount_read(const refcount_t *r)
>  #ifdef CONFIG_REFCOUNT_FULL
>  #include <linux/bug.h>
>  
> +#define REFCOUNT_MAX		INT_MAX
> +#define REFCOUNT_SATURATED	(INT_MIN / 2)
>  
>  /*
>   * Variant of atomic_t specialized for reference counts.
> @@ -109,25 +109,19 @@ static inline unsigned int refcount_read(const refcount_t *r)
>   */
>  static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
>  {
> +	int old = refcount_read(r);
>  
>  	do {
> +		if (!old)
> +			break;
> +	} while (!atomic_try_cmpxchg_relaxed(&r->refs, &old, old + i));
>  
> +	if (unlikely(old < 0 || old + i < 0)) {

So this is obviously racy against itself and other operations.
Particularly refcount_read(), as the sole API member that actually
exposes the value, is affected.

Yes, it shouldn't happen and we'll have trouble if we ever hit this, but
are all refcount_read() users sane enough to not cause further trouble?

> +		refcount_set(r, REFCOUNT_SATURATED);
> +		WARN_ONCE(1, "refcount_t: saturated; leaking memory.\n");
> +	}
>  
> +	return old;
>  }
>  
>  /**
> @@ -148,7 +142,13 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
>   */
>  static inline void refcount_add(int i, refcount_t *r)
>  {
> +	int old = atomic_fetch_add_relaxed(i, &r->refs);
> +
> +	WARN_ONCE(!old, "refcount_t: addition on 0; use-after-free.\n");

This is a change in behaviour vs the old one; the previous verion would
not change the value this will.

Is it important, I don't know, but it's not documented.

> +	if (unlikely(old <= 0 || old + i <= 0)) {
> +		refcount_set(r, REFCOUNT_SATURATED);
> +		WARN_ONCE(old, "refcount_t: saturated; leaking memory.\n");
> +	}
>  }
>  
>  /**

> @@ -224,26 +208,19 @@ static inline void refcount_inc(refcount_t *r)
>   */
>  static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
>  {
> +	int old = atomic_fetch_sub_release(i, &r->refs);
>  
> +	if (old == i) {
>  		smp_acquire__after_ctrl_dep();
>  		return true;
>  	}
>  
> +	if (unlikely(old - i < 0)) {
> +		refcount_set(r, REFCOUNT_SATURATED);
> +		WARN_ONCE(1, "refcount_t: underflow; use-after-free.\n");
> +	}

I'm failing to see how this preserves REFCOUNT_SATURATED for
non-underflow. AFAICT this should have:

	if (unlikely(old == REFCOUNT_SATURATED || old - i < 0))

> +	return false;
>  }
>  
>  /**
> @@ -276,9 +253,13 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
>   */
>  static inline void refcount_dec(refcount_t *r)
>  {
> +	int old = atomic_fetch_sub_release(1, &r->refs);
>  
> +	if (unlikely(old <= 1)) {

Idem.

> +		refcount_set(r, REFCOUNT_SATURATED);
> +		WARN_ONCE(1, "refcount_t: decrement hit 0; leaking memory.\n");
> +	}
> +}

Also, things like refcount_dec_not_one() might need fixing to preserve
REFCOUNT_SATURATED, because they're not expecting that value to actually
change, but you do!

