Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309AEC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82AA20836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="evPyUVFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCIPy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:54:58 -0500
Received: from mx.sdf.org ([205.166.94.20]:61194 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfCIPy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:54:57 -0500
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x29FrgP5007001
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 9 Mar 2019 15:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
        t=1552146828; bh=bQ9irM/uJfpxPrlxxFE0aX6Te0Hsh5KTGyQI5Qd+f3A=;
        h=Date:From:To:Subject:Cc:In-Reply-To:References;
        b=evPyUVFEHYE8qP1ROiJnTCvqWqat5hQEYp1lL+uPdnSPMIVc9UI8u4Mg7fD1qcvex
         X16RgJnAzSEVB7+LtdZE63yVToIKO5A4nLS9IWiYm3qWscAj1B3YYR6gG49v2e567E
         /2NFLAJ/akQz5dr3CtgS6KCdvrauYqXeFs1QxrOE=
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x29FrfMR018600;
        Sat, 9 Mar 2019 15:53:41 GMT
Date:   Sat, 9 Mar 2019 15:53:41 GMT
From:   lkml@sdf.org
Message-Id: <201903091553.x29FrfMR018600@sdf.org>
To:     andriy.shevchenko@linux.intel.com, lkml@sdf.org
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
Cc:     akpm@linux-foundation.org, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        st5pub@yandex.ru
In-Reply-To: <20190309140653.GO9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>,
    <20190309140653.GO9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thnk you for the feedback!

Andy Shevchenko wrote:
> On Thu, Feb 21, 2019 at 06:30:28AM +0000, George Spelvin wrote:
>> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> 
> Why #ifdef is better than if (IS_ENABLED()) ?

Because CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is bool and not
tristate.  IS_ENABLED tests for 'y' or 'm' but we don't need it
for something that's only on or off.

Looking through the kernel, I see both, but #ifdef or #if defined()
are definitely in the majority:

lib/lzo/lzo1x_compress.c:#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(LZO_USE_CTZ64)
lib/siphash.c:#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
lib/string.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
lib/strncpy_from_user.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
lib/zlib_inflate/inffast.c:#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

I see a few IS_ENABLED uses in include/crypto/ and kernel/bpf/.

It makes no real difference; #ifdef is simpler to me.

>> +	(void)base;
> 
> I understand the possible weirdness of the case, but 0 pointer is also good, no?

I don't quite understand the question.  A NULL pointer is aligned
as far as alignment_ok is concerned.  In other words, word accesses to
*NULL will (not) work just as well as byte accesses.

None of this matters because the callers never pass in NULL pointers.

>> +#else
>> +	lsbits |= (unsigned int)(size_t)base;
> 
> Perhaps you meant simple (uintptr_t) here and maybe above as well.

No, I meant to truncate it to the same type as "align".  We only
care about the low few bits; I could have used (unsigned char) just
as well.

My reason or choosing unsigned int rather than unsigned char was
that both x86 and ARM are a tiny bit more efficient at 32-bit
operations (x86 avoids a REX prefix; ARM gates off the high half
of the ALU to save power), but only x86 does byte operations
natively.

Still, compilers know how to promote to word operations, so
maybe using unsigned char would make it clearer to the
reader that "yes, I meant to do that!".

I've changed it to:

static bool __attribute_const__
is_aligned(const void *base, size_t size, unsigned char align)
{
	unsigned char lsbits = (unsigned char)size;
#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
	(void)base;
#else
	lsbits |= (unsigned char)(uintptr_t)base;
#endif
	return (lsbits & (align - 1)) == 0;
}

Although I'm thinking of:

static bool __attribute_const__
is_aligned(const void *base, size_t size, unsigned char align)
{
	unsigned char lsbits = (unsigned char)size;

	(void)base;
#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
	lsbits |= (unsigned char)(uintptr_t)base;
#endif
	return (lsbits & (align - 1)) == 0;
}

Any preference?

>> +#endif
>> +	lsbits &= align - 1;
>> +	return lsbits == 0;
> 
> and this can be one return operation.

It was just to avoid some annoying parentheses because C's precendence
rules and GCC's warnings are fighting me here.  If others prefer
"return (lsbits & (align - 1)) == 0;" I'm happy to change.

>>  static void u32_swap(void *a, void *b, int size)
> 
> For such primitives that operates on top of an arrays we usually append 's' to
> the name. Currently the name is misleading.
> 
> Perhaps u32s_swap().

I don't worry much about the naming of static helper functions.
If they were exported, it would be a whole lot more important!

I find "u32s" confusing; I keep reading the "s" as "signed" rather
than a plural.

How about one of:
swap_bytes / swap_ints / swap_longs
swap_1 / swap_4 / swap_8

> Shouldn't simple memcpy cover these case for both 32- and 64-bit architectures?

This isn't a memcpy, it's a memory *swap*.  To do it with memcpy
requires:
	memcpy(temp_buffer, a, size);
	memcpy(a, b, size);
	memcpy(b, temp_buffer, size);

This is 1.5x as much memory access, and you have to find a large
enough temp_buffer.  (I didn't think a variable-length array on
the stack would make people happy.)

Also, although it is a predictable branch, memcpy() has to check the
alignment of its inputs each call.  The reason for these helpers is
to factor that out.
