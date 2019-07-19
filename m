Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E8FC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB342184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MybL6hYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfGSLD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:03:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51318 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfGSLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ektPQaxXs6X1vhzay4uj2GbPRXw14MzGICe4sxmW7Tg=; b=MybL6hYzxP04wv627JH/mH/E+
        EOO8yoqN3cwAx6ZKcP99QBHaO5tOKaL2utYEs33LfeYlIKLWCeytP6bvac4ZxnWnpvDEHBw6swzVX
        bqCPDL1B+vT9klYYihI1lwE/lPPuKftYAScNpkk72ORoxGFh1Cgd2hpKG8fo31HGlEeClmomt8xf4
        vOqTZQd7f34587h8QnxtAIZGRk/nDxw+1q91mGbV5LpEUIXgc8o5vSb22yE9Daax6NgcB6LKGO+6z
        aVgpqGzEUrX4wnej2rlleQ78z3YyiXF3vkx2WytLWwIfKfbB/JlyF2p0u+8n84fJ2968tH3tA7I0p
        iBOCOeBaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoQg3-0006UA-Mb; Fri, 19 Jul 2019 11:03:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E9BC20197A71; Fri, 19 Jul 2019 13:03:49 +0200 (CEST)
Date:   Fri, 19 Jul 2019 13:03:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190719110349.GG3419@hirez.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718131834.GA22211@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 03:18:34PM +0200, Oleg Nesterov wrote:
> People report that utime and stime from /proc/<pid>/stat become very wrong
> when the numbers are big enough. In particular, the monitored application
> can run all the time in user-space but only stime grows.
> 
> This is because scale_stime() is very inaccurate. It tries to minimize the
> relative error, but the absolute error can be huge.
> 
> Andrew wrote the test-case:
> 
> 	int main(int argc, char **argv)
> 	{
> 	    struct task_cputime c;
> 	    struct prev_cputime p;
> 	    u64 st, pst, cst;
> 	    u64 ut, put, cut;
> 	    u64 x;
> 	    int i = -1; // one step not printed
> 
> 	    if (argc != 2)
> 	    {
> 		printf("usage: %s <start_in_seconds>\n", argv[0]);
> 		return 1;
> 	    }
> 	    x = strtoull(argv[1], NULL, 0) * SEC;
> 	    printf("start=%lld\n", x);
> 
> 	    p.stime = 0;
> 	    p.utime = 0;
> 
> 	    while (i++ < NSTEPS)
> 	    {
> 		x += STEP;
> 		c.stime = x;
> 		c.utime = x;
> 		c.sum_exec_runtime = x + x;
> 		pst = cputime_to_clock_t(p.stime);
> 		put = cputime_to_clock_t(p.utime);
> 		cputime_adjust(&c, &p, &ut, &st);
> 		cst = cputime_to_clock_t(st);
> 		cut = cputime_to_clock_t(ut);
> 		if (i)
> 		    printf("ut(diff)/st(diff): %20lld (%4lld)  %20lld (%4lld)\n",
> 			cut, cut - put, cst, cst - pst);
> 	    }
> 	}
> 
> For example,
> 
> 	$ ./stime 300000
> 	start=300000000000000
> 	ut(diff)/st(diff):            299994875 (   0)             300009124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300011124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300013124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300015124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300017124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300019124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300021124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300023124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300025124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300027124 (2000)
> 	ut(diff)/st(diff):            299994875 (   0)             300029124 (2000)
> 	ut(diff)/st(diff):            299996875 (2000)             300029124 (   0)
> 	ut(diff)/st(diff):            299998875 (2000)             300029124 (   0)
> 	ut(diff)/st(diff):            300000875 (2000)             300029124 (   0)
> 	ut(diff)/st(diff):            300002875 (2000)             300029124 (   0)
> 	ut(diff)/st(diff):            300004875 (2000)             300029124 (   0)
> 	ut(diff)/st(diff):            300006875 (2000)             300029124 (   0)
> 	ut(diff)/st(diff):            300008875 (2000)             300029124 (   0)
> 	ut(diff)/st(diff):            300010875 (2000)             300029124 (   0)
> 	ut(diff)/st(diff):            300012055 (1180)             300029944 ( 820)
> 	ut(diff)/st(diff):            300012055 (   0)             300031944 (2000)
> 	ut(diff)/st(diff):            300012055 (   0)             300033944 (2000)
> 	ut(diff)/st(diff):            300012055 (   0)             300035944 (2000)
> 	ut(diff)/st(diff):            300012055 (   0)             300037944 (2000)
> 
> shows the problem even when sum_exec_runtime is not that big: 300000 secs.
> 
> The new implementation of scale_stime() does the additional div64_u64_rem()
> in a loop but see the comment, as long it is used by cputime_adjust() this
> can happen only once.

That only shows something after long long staring :/ There's no words on
what the output actually means or what would've been expected.

Also, your example is incomplete; the below is a test for scale_stime();
from this we can see that the division results in too large a number,
but, important for our use-case in cputime_adjust(), it is a step
function (due to loss in precision) and for every plateau we shift
runtime into the wrong bucket.

Your proposed function works; but is atrocious, esp. on 32bit. That
said, before we 'fixed' it, it had similar horrible divisions in, see
commit 55eaa7c1f511 ("sched: Avoid cputime scaling overflow").

Included below is also an x86_64 implementation in 2 instructions.

I'm still trying see if there's anything saner we can do...

---
#include <stdio.h>
#include <stdlib.h>

#define   noinline                      __attribute__((__noinline__))

typedef unsigned long long u64;
typedef unsigned int u32;

static noinline u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
{
	u64 q;
	asm ("mulq %2; divq %3" : "=a" (q) : "a" (a), "rm" (b), "rm" (c) : "rdx");
	return q;
}

static u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder);

static inline u64 div_u64(u64 dividend, u32 divisor)
{
	u32 remainder;
	return div_u64_rem(dividend, divisor, &remainder);
}

static __always_inline int fls(unsigned int x)
{
	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
}

#if 0
static u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
{
	union {
		u64 v64;
		u32 v32[2];
	} d = { dividend };
	u32 upper;

	upper = d.v32[1];
	d.v32[1] = 0;
	if (upper >= divisor) {
		d.v32[1] = upper / divisor;
		upper %= divisor;
	}
	asm ("divl %2" : "=a" (d.v32[0]), "=d" (*remainder) :
		"rm" (divisor), "0" (d.v32[0]), "1" (upper));
	return d.v64;
}
static u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
{
	u32 high = divisor >> 32;
	u64 quot;

	if (high == 0) {
		u32 rem32;
		quot = div_u64_rem(dividend, divisor, &rem32);
		*remainder = rem32;
	} else {
		int n = fls(high);
		quot = div_u64(dividend >> n, divisor >> n);

		if (quot != 0)
			quot--;

		*remainder = dividend - quot * divisor;
		if (*remainder >= divisor) {
			quot++;
			*remainder -= divisor;
		}
	}

	return quot;
}
static u64 div64_u64(u64 dividend, u64 divisor)
{
	u32 high = divisor >> 32;
	u64 quot;

	if (high == 0) {
		quot = div_u64(dividend, divisor);
	} else {
		int n = fls(high);
		quot = div_u64(dividend >> n, divisor >> n);

		if (quot != 0)
			quot--;
		if ((dividend - quot * divisor) >= divisor)
			quot++;
	}

	return quot;
}
#else
static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
{
	*remainder = dividend % divisor;
	return dividend / divisor;
}
static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
{
	*remainder = dividend % divisor;
	return dividend / divisor;
}
static inline u64 div64_u64(u64 dividend, u64 divisor)
{
	return dividend / divisor;
}
#endif

static __always_inline int fls64(u64 x)
{
	int bitpos = -1;
	/*
	 * AMD64 says BSRQ won't clobber the dest reg if x==0; Intel64 says the
	 * dest reg is undefined if x==0, but their CPU architect says its
	 * value is written to set it to the same as before.
	 */
	asm("bsrq %1,%q0"
	    : "+r" (bitpos)
	    : "rm" (x));
	return bitpos + 1;
}

static inline int ilog2(u64 n)
{
	return fls64(n) - 1;
}

#define swap(a, b) \
	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)

static noinline u64 scale_stime(u64 stime, u64 rtime, u64 total)
{
	u64 scaled;

	for (;;) {
		/* Make sure "rtime" is the bigger of stime/rtime */
		if (stime > rtime)
			swap(rtime, stime);

		/* Make sure 'total' fits in 32 bits */
		if (total >> 32)
			goto drop_precision;

		/* Does rtime (and thus stime) fit in 32 bits? */
		if (!(rtime >> 32))
			break;

		/* Can we just balance rtime/stime rather than dropping bits? */
		if (stime >> 31)
			goto drop_precision;

		/* We can grow stime and shrink rtime and try to make them both fit */
		stime <<= 1;
		rtime >>= 1;
		continue;

drop_precision:
		/* We drop from rtime, it has more bits than stime */
		rtime >>= 1;
		total >>= 1;
	}

	/*
	 * Make sure gcc understands that this is a 32x32->64 multiply,
	 * followed by a 64/32->64 divide.
	 */
	scaled = div_u64((stime * rtime), total);
	return scaled;
}

static noinline u64 oleg(u64 stime, u64 rtime, u64 total)
{
	u64 res = 0, div, rem;
	/* can stime * rtime overflow ? */
	while (ilog2(stime) + ilog2(rtime) > 62) {
		if (stime > rtime)
			swap(rtime, stime);
		if (rtime >= total) {
			/*
			 * (rtime * stime) / total is equal to
			 *
			 *      (rtime / total) * stime +
			 *      (rtime % total) * stime / total
			 *
			 * if nothing overflows. Can the 1st multiplication
			 * overflow? Yes, but we do not care: this can only
			 * happen if the end result can't fit in u64 anyway.
			 *
			 * So the code below does
			 *
			 *      res += (rtime / total) * stime;
			 *      rtime = rtime % total;
			 */
			div = div64_u64_rem(rtime, total, &rem);
			res += div * stime;
			rtime = rem;
			continue;
		}
		/* drop precision */
		rtime >>= 1;
		total >>= 1;
		if (!total)
			return res;
	}
	return res + div64_u64(stime * rtime, total);
}

#define SEC	1000000000ULL

int main(int argc, char **argv)
{
	u64 u, s;
	u64 x;
	int i = -1; // one step not printed
	if (argc != 2)
	{
		printf("usage: %s <start_in_seconds>\n", argv[0]);
		return 1;
	}
	x = strtoull(argv[1], NULL, 0) * SEC;
	printf("start=%lld\n", x);

	for (i=0; i<50; i++, x += 2000) {
		printf("%lld = %lld * %lld / %lld\n", mul_u64_u64_div_u64(x, x+x, x+x), x, x+x, x+x);
		printf("%lld = %lld * %lld / %lld\n", scale_stime(x, x+x, x+x), x, x+x, x+x);
		printf("%lld = %lld * %lld / %lld\n", oleg(x, x+x, x+x), x, x+x, x+x);
		printf("---\n");
	}
}
