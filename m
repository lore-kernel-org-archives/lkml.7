Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D823AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfCNKNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:13:32 -0400
Received: from ol.sdf.org ([205.166.94.20]:65129 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbfCNKNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:13:32 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2EABZau016183
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Thu, 14 Mar 2019 10:11:35 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2EABZAl015257;
        Thu, 14 Mar 2019 10:11:35 GMT
Date:   Thu, 14 Mar 2019 10:11:35 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903141011.x2EABZAl015257@sdf.org>
To:     andriy.shevchenko@linux.intel.com, lkml@sdf.org, st5pub@yandex.ru
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
Cc:     akpm@linux-foundation.org, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
In-Reply-To: <20190314092958.GV9224@smile.fi.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>,
    <20190309140653.GO9224@smile.fi.intel.com>,
    <201903091553.x29FrfMR018600@sdf.org>,
    <20190314092958.GV9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Mar 2019 at 23:19:49 +0300, Andrey Abramov wrote:
>> Although I'm thinking of:
>>
>> static bool __attribute_const__
>> is_aligned(const void *base, size_t size, unsigned char align)
>> {
>> 	unsigned char lsbits = (unsigned char)size;
>>
>> 	(void)base;
>> #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>> 	lsbits |= (unsigned char)(uintptr_t)base;
>> #endif
>> 	return (lsbits & (align - 1)) == 0;
>> }
>>
>> Any preference?
> I think it would be better.

>> I find "u32s" confusing; I keep reading the "s" as "signed" rather
>> than a plural.
>>
>> How about one of:
>> swap_bytes / swap_ints / swap_longs
>> swap_1 / swap_4 / swap_8
>
> In my opinion "swap_bytes / swap_ints / swap_longs" are the most readable.


On Thu, 14 Mar 2019 at 11:29:58 +0200, Andy Shevchenko wrote:
> On Sat, Mar 09, 2019 at 03:53:41PM +0000, lkml@sdf.org wrote:
>> static bool __attribute_const__
>> is_aligned(const void *base, size_t size, unsigned char align)
>> {
>> 	unsigned char lsbits = (unsigned char)size;
>> #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>> 	(void)base;
>> #else
>> 	lsbits |= (unsigned char)(uintptr_t)base;
>> #endif
>> 	return (lsbits & (align - 1)) == 0;
>> }
>
>> Any preference?
>
> This one looks better in a sense we don't suppress the warnings when it's
> not needed.

>>> For such primitives that operates on top of an arrays we usually
>>> append 's' to the name. Currently the name is misleading.
>>> 
>>> Perhaps u32s_swap().
>> 
>> I don't worry much about the naming of static helper functions.
>> If they were exported, it would be a whole lot more important!
>> 
>> I find "u32s" confusing; I keep reading the "s" as "signed" rather
>> than a plural.
>
> For signedness we use prefixes; for plural, suffixes. I don't see the point of
> confusion. And this is in use in kernel a lot.
>
>> How about one of:
>> swap_bytes / swap_ints / swap_longs
>> swap_1 / swap_4 / swap_8
>
> longs are ambiguous, so I would prefer bit-sized types.

I already implemented Andrey's suggestions, which were the exact
opposite of yours.

Pistols at dawn?


>>>> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>>> 
>>> Why #ifdef is better than if (IS_ENABLED()) ?
>> 
>> Because CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is bool and not
>> tristate.  IS_ENABLED tests for 'y' or 'm' but we don't need it
>> for something that's only on or off.
>
> There is IS_BUILTIN(), though it's a common practice to use IS_ENABLED()
> even for boolean options (I think because of naming of the macro).

Well, as I said earlier, #ifdef is the most common form in the kernel.
It's also the shortest to write, and I like the fact that it slightly
simpler.  (Admittedly, "IS_ENABLED" does not take a lot of brain power
to interpret, but it *is* one more macro that might be hiding magic.)

So I'm not inclined to change it without a substantial reason.
