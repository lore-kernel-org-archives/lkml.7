Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26082C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C6C2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfGSOD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfGSOD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:03:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E905F307D90E;
        Fri, 19 Jul 2019 14:03:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 55AC01019616;
        Fri, 19 Jul 2019 14:03:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 19 Jul 2019 16:03:27 +0200 (CEST)
Date:   Fri, 19 Jul 2019 16:03:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190719140325.GA31938@redhat.com>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719110349.GG3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 19 Jul 2019 14:03:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19, Peter Zijlstra wrote:
>
> On Thu, Jul 18, 2019 at 03:18:34PM +0200, Oleg Nesterov wrote:
> >
> > 	$ ./stime 300000
> > 	start=300000000000000
> > 	ut(diff)/st(diff):            299994875 (   0)             300009124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300011124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300013124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300015124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300017124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300019124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300021124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300023124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300025124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300027124 (2000)
> > 	ut(diff)/st(diff):            299994875 (   0)             300029124 (2000)
> > 	ut(diff)/st(diff):            299996875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            299998875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300000875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300002875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300004875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300006875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300008875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300010875 (2000)             300029124 (   0)
> > 	ut(diff)/st(diff):            300012055 (1180)             300029944 ( 820)
> > 	ut(diff)/st(diff):            300012055 (   0)             300031944 (2000)
> > 	ut(diff)/st(diff):            300012055 (   0)             300033944 (2000)
> > 	ut(diff)/st(diff):            300012055 (   0)             300035944 (2000)
> > 	ut(diff)/st(diff):            300012055 (   0)             300037944 (2000)
> >
> > shows the problem even when sum_exec_runtime is not that big: 300000 secs.
> >
> > The new implementation of scale_stime() does the additional div64_u64_rem()
> > in a loop but see the comment, as long it is used by cputime_adjust() this
> > can happen only once.
>
> That only shows something after long long staring :/ There's no words on
> what the output actually means or what would've been expected.

Sorry, I should have explained it in more details,

> Also, your example is incomplete; the below is a test for scale_stime();
> from this we can see that the division results in too large a number,
> but, important for our use-case in cputime_adjust(), it is a step
> function (due to loss in precision) and for every plateau we shift
> runtime into the wrong bucket.

Yes.

> Your proposed function works; but is atrocious,

Agreed,

> esp. on 32bit.

Yes... but lets compare it with the current implementation. To simplify,
lets look at the "less generic" version I showed in reply to this patch:

	static u64 scale_stime(u64 stime, u64 rtime, u64 total)
	{
		u64 res = 0, div, rem;

		if (ilog2(stime) + ilog2(rtime) > 62) {
			div = div64_u64_rem(rtime, total, &rem);
			res += div * stime;
			rtime = rem;

			int shift = ilog2(stime) + ilog2(rtime) - 62;
			if (shift > 0) {
				rtime >>= shift;
				total >>= shift;
				if (!total)
					return res;
			}
		}

		return res + div64_u64(stime * rtime, total);
	}

So, if stime * rtime overflows it does div64_u64() twice while the
current version does a single div_u64() == do_div() (on 32bit).

Even a single div64_u64() is more expensive than do_div() but afaics
a) not too much and b) only if divisor == total doesn't fit in 32bit
and I think this is unlikely.

So I'd say it makes scale_stime() approximately twice more expensive
on 32bit. But hopefully fixe the problem.

> Included below is also an x86_64 implementation in 2 instructions.

But we need the arch-neutral implementation anyway, the code above
is the best I could invent.

But see below!

> I'm still trying see if there's anything saner we can do...

Oh, please, it is not that I like my solution very much, I would like
to see something more clever.

> static noinline u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> {
> 	u64 q;
> 	asm ("mulq %2; divq %3" : "=a" (q) : "a" (a), "rm" (b), "rm" (c) : "rdx");
> 	return q;
> }

Heh. I have to admit that I didn't know that divq divides 128bit by
64bit. gcc calls the __udivti3 intrinsic in this case so I wrongly
came to conclusion this is not simple even on x86_64. Plus the fact
that linux/math64.h only has mul_u64_u64_shr()...

IIUC, the new helper above is not "safe", it generates an exception
if the result doesn't fit in 64bit. But scale_stime() can safely use
it because stime < total.

So may be we can do

	static u64 scale_stime(u64 stime, u64 rtime, u64 total)
	{
		u64 res = 0, div, rem;

		#ifdef mul_u64_u64_div_u64
		return mul_u64_u64_div_u64(stime, rtime, total);
		#endif

		if (ilog2(stime) + ilog2(rtime) > 62) {
			div = div64_u64_rem(rtime, total, &rem);
			res += div * stime;
			rtime = rem;

			int shift = ilog2(stime) + ilog2(rtime) - 62;
			if (shift > 0) {
				rtime >>= shift;
				total >>= shift;
				if (!total)
					return res;
			}
		}

		return res + div64_u64(stime * rtime, total);
	}

?

Oleg.

