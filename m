Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD89C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC28520854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 00:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfCNADz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 20:03:55 -0400
Received: from mx.sdf.org ([205.166.94.20]:51035 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfCNADz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 20:03:55 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2E03YBx027700
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Thu, 14 Mar 2019 00:03:34 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2E03VZO028625;
        Thu, 14 Mar 2019 00:03:31 GMT
Date:   Thu, 14 Mar 2019 00:03:31 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903140003.x2E03VZO028625@sdf.org>
To:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        lkml@sdf.org
Subject: Re: [PATCH 2/5] lib/sort: Use more efficient bottom-up heapsort variant
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, geert@linux-m68k.org, st5pub@yandex.ru
In-Reply-To: <472510ad-77f9-49e8-4122-52f447cb1c15@rasmusvillemoes.dk>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dbac34c6052fc973fb55df4966981bae24c7cce9.1552097842.git.lkml@sdf.org>,
    <472510ad-77f9-49e8-4122-52f447cb1c15@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 at 23:29:40 +0100, Rasmus Villemoes wrote:
> On 21/02/2019 09.21, George Spelvin wrote:
>> +/**
>> + * parent - given the offset of the child, find the offset of the parent.
>> + * @i: the offset of the heap element whose parent is sought.  Non-zero.
>> + * @lsbit: a precomputed 1-bit mask, equal to "size & -size"
>> + * @size: size of each element
>> + *
>> + * In terms of array indexes, the parent of element j = i/size is simply
>> + * (j-1)/2.  But when working in byte offsets, we can't use implicit
>> + * truncation of integer divides.
>> + *
>> + * Fortunately, we only need one bit of the quotient, not the full divide.
>> + * size has a least significant bit.  That bit will be clear if i is
>> + * an even multiple of size, and set if it's an odd multiple.
>> + *
>> + * Logically, we're doing "if (i & lsbit) i -= size;", but since the
>> + * branch is unpredictable, it's done with a bit of clever branch-free
>> + * code instead.
>> + */
>> +__attribute_const__ __always_inline
>> +static size_t parent(size_t i, unsigned int lsbit, size_t size)
>> +{
>> +	i -= size;
>> +	i -= size & -(i & lsbit);
>> +	return i / 2;
>> +}
>> +
>
> Really nice :) I had to work through this by hand, but it's solid.

Thank you!  Yes, the way the mask doesn't include the low-order bits
that don't matter anyway is a bit subtle.

When the code is subtle, use lots of comments.  The entire reason
for making this a separate helper function is to leave room for
the large comment.

>> +	unsigned const lsbit = size & -size;	/* Used to find parent */
>
> Nit: qualifier before type, "const unsigned". And this sets ZF, so a
> paranoid check for zero size (cf. the other mail) by doing "if (!lsbit)
> return;" is practically free. Though it's probably a bit obscure doing
> it that way...

Actually, this is a personal style thing which I can ignore for the sake
of the kernel, but I believe that it's better to put the qualifier
*after* the type.  This is due to C's pointer declaration syntax.

The standard example of the issue is:

	typedef char *pointer;
	const char *a;
	char const *b;
	char * const c;
	const pointer d;
	pointer const e;

Now, which variables are the same types?

The answer is that a & b are the same (mutable pointer to const
char), and c, d & e are the same (const pointer to mutable char).

I you make a habit of putting the qualifier *after* the type, then
a simple "textual substitution" mental model for the typedef works,
and it's clear that c and e are the same.

It's also clear that b cannot be represented by the typedef because
the const is between "char" and "*", and you obviously can't do that
with the typedef.

But if you put the qualifier first, it's annoying to rememeber why
a and d are not the same type.

So I've deliberately cultivated the style of putting the qualifier
after the type.

But if the kernel prefers it before...

>> +	if (!n)
>> +		return;
>
> I'd make that n <= 1. Shouldn't be much more costly.

(Actually, it's "num <= 1"; n is the pre-multiplied form so
n <= 1 can only happen when sorting one one-byte value.)

I actually thought about this and decided not to bother.  I did it
this way during development to stress the general-case code.  But
should I change it?

=== NEVER MIND ===

I had written a long reply justifying leaving it alone to save one
instruction when the light dawned: I can do *both* tests in one
step with
	size_t n = num * size, a = (num/2) * size;
	unsigned const lsbit = size & -size;	/* Used to find parent */

	if (!a)		/* num < 2 || size == 0 */
		return;

So now everyone's happy.

> Nice!

Thank you.  May I translate that into Acked-by?
