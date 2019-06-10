Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D232FC468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00F42089E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ToX2hnaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbfFJNQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:16:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42296 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfFJNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:16:57 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so6810848ior.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 06:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNk3HOCqwDsrkq+M3DdByXFYq0E8aVmGy+Vn0t1wmaY=;
        b=ToX2hnaPH/yjK/yvnjCSobIl6X1PxRHZMTxaYxnc93jtRyxCkM3sfJvZbB3eAFqge5
         z45yC+pgHMwEPckZDsqHcg3+caBoy+JVKU6sBaM7KXnyPck3vnFJCTBeAIu2luYq4rE7
         6jE4cIiKDovZWrh469CXU7kt6U5jlpxxU8KzxA4RSx9XNMVFQTzjfD5PZpFVNN56S/dC
         wfU4+tId3+iEaUkIFgfL12VBZ+n+AqnyyGI/Eri/43BgAjMUircdZ4iNrUmiAACGZ2oD
         UIUXMG9YKUl5xEuoDvNTIlCuEfIufTITNC74w5cX338XdLkR+BuY1t7qATuGZ1QjdeyV
         bZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNk3HOCqwDsrkq+M3DdByXFYq0E8aVmGy+Vn0t1wmaY=;
        b=oOo4JIX1aMRJcd9eJYc7YfZDYxEClc6xFlfBWhmLC1dPexnQtLSbnVgi4pHi+os0V+
         6XbZ0fnOHx6gv8zLodQJ8Zc2VPe8rn34Fr+qV3N9DSisyJeJD+nUI9Y4Ju+tYsYnrXSl
         P1TYV1RxaGh7Q+z+jAqWNcNpTVV9qeiIIE8O9eqX1KQHgpaZgt2r25lv2C7TbsopchLb
         GuqIxlCz5m7VAtd47XLCzea1vB3G087yceUr1MZLkFaAFh/BPcyBhxTMqTgEcK88nf8r
         FtAetArAq+UJISg48WPYnpwGbzK+ocyvkF4ZHI5hExypBM0a4cLFO8Lp/lh3q/ilfMZa
         88vQ==
X-Gm-Message-State: APjAAAXLXs9W5NMidaHoXTFt6HDK6aCw5rLBPxNshK9/gsUVXpcblAPO
        Do/JuyKuHnLMX6FEpavKu5lYRuNkojrv+njku2pP/A==
X-Google-Smtp-Source: APXvYqzarBFbSF1naKHDvaWpGg/Ufru9EOjzFBYFWaY07cg7Q42+dj/GPRcQhIHhjw/DdT+Mn5GafMfhlQuQGHRdbPM=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr37963127ion.65.1560172616087;
 Mon, 10 Jun 2019 06:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
 <20180907144447.GD12788@arm.com> <84b8e874-2a52-274c-4806-968470e66a08@huawei.com>
In-Reply-To: <84b8e874-2a52-274c-4806-968470e66a08@huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Jun 2019 15:16:43 +0200
Message-ID: <CAKv+Gu9fd2Y7USDYnQdUuYd9L2OD99kU4A1x1JSF442KN96TTA@mail.gmail.com>
Subject: Re: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Petr Tesarik <ptesarik@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Vacek <neelx@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Jia He <jia.he@hxt-semitech.com>, Jia He <hejianet@gmail.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Philip Derrin <philip@cog.systems>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2019 at 06:22, Hanjun Guo <guohanjun@huawei.com> wrote:
>
> Hi Ard, Will,
>
> This week we were trying to debug an issue of time consuming in mem_init(),
> and leading to this similar solution form Jia He, so I would like to bring this
> thread back, please see my detail test result below.
>
> On 2018/9/7 22:44, Will Deacon wrote:
> > On Thu, Sep 06, 2018 at 01:24:22PM +0200, Ard Biesheuvel wrote:
> >> On 22 August 2018 at 05:07, Jia He <hejianet@gmail.com> wrote:
> >>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> >>> where possible") optimized the loop in memmap_init_zone(). But it causes
> >>> possible panic bug. So Daniel Vacek reverted it later.
> >>>
> >>> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> >>> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> >>>
> >>> More from what Daniel said:
> >>> "On arm and arm64, memblock is used by default. But generic version of
> >>> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> >>> not always return the next valid one but skips more resulting in some
> >>> valid frames to be skipped (as if they were invalid). And that's why
> >>> kernel was eventually crashing on some !arm machines."
> >>>
> >>> About the performance consideration:
> >>> As said by James in b92df1de5,
> >>> "I have tested this patch on a virtual model of a Samurai CPU with a
> >>> sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
> >>> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
> >>>
> >>> Besides we can remain memblock_next_valid_pfn, there is still some room
> >>> for improvement. After this set, I can see the time overhead of memmap_init
> >>> is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
> >>> memory, pagesize 64k). I believe arm server will benefit more if memory is
> >>> larger than TBs
> >>>
> >>
> >> OK so we can summarize the benefits of this series as follows:
> >> - boot time on a virtual model of a Samurai CPU drops from 109 to 62 seconds
> >> - boot time on a QDF2400 arm64 server with 96 GB of RAM drops by ~15
> >> *milliseconds*
> >>
> >> Google was not very helpful in figuring out what a Samurai CPU is and
> >> why we should care about the boot time of Linux running on a virtual
> >> model of it, and the 15 ms speedup is not that compelling either.
>
> Testing this patch set on top of Kunpeng 920 based ARM64 server, with
> 384G memory in total, we got the time consuming below
>
>              without this patch set      with this patch set
> mem_init()        13310ms                      1415ms
>
> So we got about 8x speedup on this machine, which is very impressive.
>

Yes, this is impressive. But does it matter in the grand scheme of
things? How much time does this system take to arrive at this point
from power on?

> The time consuming is related the memory DIMM size and where to locate those
> memory DIMMs in the slots. In above case, we are using 16G memory DIMM.
> We also tested 1T memory with 64G size for each memory DIMM on another ARM64
> machine, the time consuming reduced from 20s to 2s (I think it's related to
> firmware implementations).
>

I agree that this optimization looks good in isolation, but the fact
that you spotted a bug justifies my skepticism at the time. On the
other hand, now that we have several independent reports (from you,
but also from the Renesas folks) that the speedup is worthwhile for
real world use cases, I think it does make sense to revisit it.

So what I would like to see is the patch set being proposed again,
with the new data points added for documentation. Also, the commit
logs need to crystal clear about how the meaning of PFN validity
differs between ARM and other architectures, and why the assumptions
that the optimization is based on are guaranteed to hold.



> >>
> >> Apologies to Jia that it took 11 revisions to reach this conclusion,
> >> but in /my/ opinion, tweaking the fragile memblock/pfn handling code
> >> for this reason is totally unjustified, and we're better off
> >> disregarding these patches.
>
> Indeed this patch set has a bug, For exampe, if we have 3 regions which
> is [a, b] [c, d] [e, f] if address of pfn is bigger than the end address of
> last region, we will increase early_region_idx to count of region, which is
> out of bound of the regions. Fixed by patch below,
>
>  mm/memblock.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 8279295..8283bf0 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1252,13 +1252,17 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>                 if (pfn >= start_pfn && pfn < end_pfn)
>                         return pfn;
>
> -               early_region_idx++;
> +               /* try slow path */
> +               if (++early_region_idx == type->cnt)
> +                       goto slow_path;
> +
>                 next_start_pfn = PFN_DOWN(regions[early_region_idx].base);
>
>                 if (pfn >= end_pfn && pfn <= next_start_pfn)
>                         return next_start_pfn;
>         }
>
> +slow_path:
>         /* slow path, do the binary searching */
>         do {
>                 mid = (right + left) / 2;
>
> As the really impressive speedup on our ARM64 server system, could you reconsider
> this patch set for merge? if you want more data I'm willing to clarify and give
> more test.
>
