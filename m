Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6263F2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NinukQJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfCMVXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:23:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41685 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfCMVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:23:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id n14so2818686edv.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wrt/WCPT0yrKsK2Eic7Qk4Uza1tKcrwjoi89q3pq764=;
        b=NinukQJEOymFrU0Rn0Tq0Jtlbx3tz5rKb5+bCJZi/pbOK6de6fGHeyyALub+/835eD
         BVpG+XW22wtY4zPvvqL6T2Z1I1IfbWOu+UjLdDwTQrXS1Kr7nbE65PchskCpEvidzmOy
         oFHUEcTh6dTBs+GSvT48iEH4AqxhEXO9XKYq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wrt/WCPT0yrKsK2Eic7Qk4Uza1tKcrwjoi89q3pq764=;
        b=f3ypdXFnfs0npGaZRTS9GeJ4MhAXWNPQCkBXmcCK3jdwqP3YvFXUOmqFhIxBjug2Nc
         QilHQsesKIHQi/dRddugizGpgU2GXSXX20tD7WtYBY0tCRbIIjykWf/YtDp5MZze3h2M
         rhP7JhCBfYE4nlhg1dFCeCPSa9AJf1rDmahiCqIzB42n2sZNVC5bnF5r/ij25SIP/hws
         kUuLDwLQNEp4xhZFN8TeDMkPtEnPptgFLmV+5ZGdOXlNGA3gEquQCrZa5F6/7NKnc9E7
         QNVp/Eea7ld4sL1t35ey5Lhe6zNAsg+Qqyvki4sF5Uls38sgFWMJ+QWKCfgyLd+f3lMe
         Pxow==
X-Gm-Message-State: APjAAAXVwzJD0fJ5ndhqxmivnzbV2FWLtONqwVRUK2CvuNEpUfXUkhJe
        h5H1JZb3L+0wvmTOvYDZdVRoWg==
X-Google-Smtp-Source: APXvYqzBtNlzjswJrFWM6H6y7fg1txyQRoNcx/uoQibc/vmSaCODtqneKMROLgcZrBT0fRTwU7KG1g==
X-Received: by 2002:a50:bdc3:: with SMTP id z3mr9107714edh.111.1552512226744;
        Wed, 13 Mar 2019 14:23:46 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id d11sm678797eja.23.2019.03.13.14.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 14:23:46 -0700 (PDT)
Subject: Re: [PATCH 1/5] lib/sort: Make swap functions more generic
To:     George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1552097842.git.lkml@sdf.org>
 <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6e08375f-6960-546b-39a6-26ff24a0ce0e@rasmusvillemoes.dk>
Date:   Wed, 13 Mar 2019 22:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <dc6cc09e71f8687ff2ef4cbfc2b11accc9aba8aa.1552097842.git.lkml@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 07.30, George Spelvin wrote:
> Rather than u32_swap and u64_swap working on 4- and 8-byte objects
> directly, let them handle any multiple of 4 or 8 bytes.  This speeds
> up most users of sort() by avoiding fallback to the byte copy loop.
> 
> Despite what commit ca96ab859ab4 ("lib/sort: Add 64 bit swap function")
> claims, very few users of sort() sort pointers (or pointer-sized
> objects); most sort structures containing at least two words.
> (E.g. drivers/acpi/fan.c:acpi_fan_get_fps() sorts an array of 40-byte
> struct acpi_fan_fps.)
> 
> x86-64 code size 872 -> 885 bytes (+8)
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> ---
>  lib/sort.c | 117 +++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 96 insertions(+), 21 deletions(-)
> 
> diff --git a/lib/sort.c b/lib/sort.c
> index d6b7a202b0b6..dff2ab2e196e 100644
> --- a/lib/sort.c
> +++ b/lib/sort.c
> @@ -11,35 +11,110 @@
>  #include <linux/export.h>
>  #include <linux/sort.h>
>  
> -static int alignment_ok(const void *base, int align)
> +/**
> + * alignment_ok - is this pointer & size okay for word-wide copying?
> + * @base: pointer to data
> + * @size: size of each element
> + * @align: required aignment (typically 4 or 8)
> + *

typo aLignment

> + * Returns true if elements can be copied using word loads and stores.
> + * The size must be a multiple of the alignment, and the base address must
> + * be if we do not have CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> + *

I wonder if we shouldn't unconditionally require the base to be aligned.
It of course depends on what exactly 'efficient' means, but if the base
is not aligned, we know that every single load and store will be
unaligned, and we're doing lots of them. IIRC even on x86 it's usually
two cycles instead of one, and even more when we cross a cache line
boundary (which we do rather often - e.g. in your 40 byte example,
almost every swap will hit at least one). One could also have some data
that is naturally 4-byte aligned with an element size that happens to be
a multiple of 8 bytes; it would be a bit sad to use 8-byte accesses when
4-byte would all have been aligned.

> + * For some reason, gcc doesn't know to optimize "if (a & mask || b & mask)"
> + * to "if ((a | b) & mask)", so we do that by hand.
> + */
> +static bool __attribute_const__
> +alignment_ok(const void *base, size_t size, unsigned int align)
>  {
> -	return IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ||
> -		((unsigned long)base & (align - 1)) == 0;
> +	unsigned int lsbits = (unsigned int)size;

Drop that cast.

> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	(void)base;
> +#else
> +	lsbits |= (unsigned int)(size_t)base;

The kernel usually casts pointers to long or unsigned long. If some
oddball arch has size_t something other than unsigned long, this would
give a "warning: cast from pointer to integer of different size". So
just cast to unsigned long, and drop the cast to unsigned int.

If you do drop CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, this all becomes
much simpler, of course

lsbits = size | (unsigned long)base;

> +#endif
> +	lsbits &= align - 1;
> +	return lsbits == 0;
>  }
>  
> +/**
> + * u32_swap - swap two elements in 32-bit chunks
> + * @a, @b: pointers to the elements
> + * @size: element size (must be a multiple of 4)
> + *
> + * Exchange the two objects in memory.  This exploits base+index addressing,
> + * which basically all CPUs have, to minimize loop overhead computations.
> + *
> + * For some reason, on x86 gcc 7.3.0 adds a redundant test of n at the
> + * bottom of the loop, even though the zero flag is stil valid from the
> + * subtract (since the intervening mov instructions don't alter the flags).
> + * Gcc 8.1.0 doesn't have that problem.
> + */
>  static void u32_swap(void *a, void *b, int size)
>  {
> -	u32 t = *(u32 *)a;
> -	*(u32 *)a = *(u32 *)b;
> -	*(u32 *)b = t;
> +	size_t n = size;
> +

Since the callback has int in its prototype (we should fix that globally
at some point...), might as well use a four-byte local variable, to
avoid rex prefix on x86-64. So just make that "unsigned" or "u32".

> +	do {
> +		u32 t = *(u32 *)(a + (n -= 4));
> +		*(u32 *)(a + n) = *(u32 *)(b + n);
> +		*(u32 *)(b + n) = t;
> +	} while (n);
>  }

Hm, are we absolutely sure there's no weird .config where some struct
ends up being empty, yet we still sort an array of them? It's far
fetched, of course, but perhaps an "if (unlikely(!size)) return;" at the
start of sort() would be in order. Dunno, I'll leave it to you.

Rasmus
