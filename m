Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE50AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A7F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCMXQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:16:37 -0400
Received: from mx.sdf.org ([205.166.94.20]:63821 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfCMXQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:16:36 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2DNFGqv001230
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Wed, 13 Mar 2019 23:15:16 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2DNFFg3026947;
        Wed, 13 Mar 2019 23:15:15 GMT
Date:   Wed, 13 Mar 2019 23:15:15 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903132315.x2DNFFg3026947@sdf.org>
To:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        lkml@sdf.org
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, geert@linux-m68k.org, st5pub@yandex.ru
In-Reply-To: <6e08375f-6960-546b-39a6-26ff24a0ce0e@rasmusvillemoes.dk>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>,
    <6e08375f-6960-546b-39a6-26ff24a0ce0e@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your thoughtful comments!

On Wed, 13 Mar 2019 at 23:23:44 +0100, Rasmus Villemoes wrote:
> On 21/02/2019 07.30, George Spelvin wrote:
> + * @align: required aignment (typically 4 or 8)
>
> typo aLignment

Thanks; fixed!

>> + * Returns true if elements can be copied using word loads and stores.
>> + * The size must be a multiple of the alignment, and the base address must
>> + * be if we do not have CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
>
> I wonder if we shouldn't unconditionally require the base to be aligned.
> It of course depends on what exactly 'efficient' means, but if the base
> is not aligned, we know that every single load and store will be
> unaligned, and we're doing lots of them. IIRC even on x86 it's usually
> two cycles instead of one, and even more when we cross a cache line
> boundary (which we do rather often - e.g. in your 40 byte example,
> almost every swap will hit at least one). One could also have some data
> that is naturally 4-byte aligned with an element size that happens to be
> a multiple of 8 bytes; it would be a bit sad to use 8-byte accesses when
> 4-byte would all have been aligned.

Well, a 2-cycle unaligned access is still lots faster than 4 byte accesses.
I think that's a decent interpretation of "EFFICIENT_UNALIGNED_ACCESS":
faster than doing it a byte at a time.  So the change is a net win;
we're just wondering if it could be optimized more.

The 4/8 issue is similar, but not as extreme.  Is one unaligned 64-bit
access faster than two aligned 32-bit accesses?  As you note, it's usually
only twice the cost, so it's no slower, and there's less loop overhead.
So I don't think it's a bad thing here, either.

Re your comments on cache lines, ISTR that x86 can do an unaligned
load with minimal penalty as long as it doesn't cross a cache line:
https://software.intel.com/en-us/articles/reducing-the-impact-of-misaligned-memory-accesses/
So you win on most of the accesses, hopefully enough to pay for the
one unligned access.  Apparently in processors more recent than
the P4 example Intel used above, it's even less:
https://lemire.me/blog/2012/05/31/data-alignment-for-speed-myth-or-reality/

On 32-bit machines, it's actually a 4-byte swap, unrolled twice;
there are no 64-bit memory accesses.  So the concern is only about
8-byte alignment on 64-bit machines.

The great majority of call sites sort structures with pointer or
long members, so are aligned and the question is moot.  I don't
think it's worth overthinking the issue on behalf of the performance
of some rare corner cases.

I have considered doing away with the two word-copy loops and just
having one machine-word-sized loop plus a byte fallback.

>> +	unsigned int lsbits = (unsigned int)size;
>
> Drop that cast.

Actually, in response to an earlier comment, I changed it (and the
type of lsbits) to (unsigned char), to emphasize that I *really* only
care about a handful of low bits.

I know gcc doesn't warn about implicit narrowing casts, but
I prefer to make them explicit for documentation reasons.
"Yes, I really mean to throw away the high bits."

Compilers on machines without native byte operations are very good
at using larger registers and optimizing away mask operations.
(Remember that this is inlined, and "align" is a constant 4 or 8.)
>
>> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>> +	(void)base;
>> +#else
>> +	lsbits |= (unsigned int)(size_t)base;
>
> The kernel usually casts pointers to long or unsigned long. If some
> oddball arch has size_t something other than unsigned long, this would
> give a "warning: cast from pointer to integer of different size". So
> just cast to unsigned long, and drop the cast to unsigned int.

I changed this to uintptr_t and called it good.

>>  static void u32_swap(void *a, void *b, int size)
>>  {
>> -	u32 t = *(u32 *)a;
>> -	*(u32 *)a = *(u32 *)b;
>> -	*(u32 *)b = t;
>> +	size_t n = size;
>> +
>
> Since the callback has int in its prototype (we should fix that globally
> at some point...), might as well use a four-byte local variable, to
> avoid rex prefix on x86-64. So just make that "unsigned" or "u32".

Agreed about the eventual global fix.  If you care, the only places
a non-NULL swap function is passed in are:
- arch/arc/kernel/unwind.c
- arch/powerpc/kernel/module_32.c
- arch/powerpc/kernel/module_64.c
! arch/x86/kernel/unwind_orc.c (2x)
- fs/ocfs2/dir.c
- fs/ocfs2/refcounttree.c (3x)
- fs/ocfs2/xattr.c (3x)
- fs/ubifs/find.c
! kernel/jump_label.c
! lib/extable.c

The ones marked with "-" are simple memory swaps that could (should!)
be replaced with NULL.  The ones marked with "!" actually do
something non-trivial.


Actually, I deliberately used a pointer-sized index, since the loop
uses (a + n) addressing.  Hardware indexed addressing on 64-bit
machines generally (I vaguely recall Aarch64 is an exception)
requires a 64-bit index; using a smaller index requires some masking
or sign-extending.

I thought it was safer to bet that the compiler would figure out
that a non-REX arithmetic operation could be used (cost if wrong,
a 1-byte REX prefix) than to bet that it would feel safe promoting
to 64 bits (cost if wrong: additional instructions).

The problem in both cases is that I changed to a test-for-zero
in the loop and the compiler doesn't know that size is a multiple
of 4, so it may have trouble knowing that this doesn't wrap to
2^64-1.

I could tell it via
	if (n % 4)
		unreachable();

One thing I should do is an intermediate cast through (unsigned int)
so the compiler can avoid a sign extension.  That makes the REX-elision
optimization easier.

> Hm, are we absolutely sure there's no weird .config where some struct
> ends up being empty, yet we still sort an array of them? It's far
> fetched, of course, but perhaps an "if (unlikely(!size)) return;" at the
> start of sort() would be in order. Dunno, I'll leave it to you.

Well, the old generic_swap code also had a test at the bottom and
so would misbehave somewhat, but yeah, this would be a good sanity
check.  Sorting is expensive enough that the cost is trivial.
