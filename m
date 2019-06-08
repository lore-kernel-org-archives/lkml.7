Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ECDC468C1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96907205ED
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfFHEWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 00:22:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37806 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbfFHEWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 00:22:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A743C53F4D0FF13F8075;
        Sat,  8 Jun 2019 12:22:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 8 Jun 2019
 12:22:22 +0800
Subject: Re: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
To:     Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, Jia He <hejianet@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Petr Tesarik <ptesarik@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "AKASHI Takahiro" <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Vacek <neelx@redhat.com>, Mel Gorman <mgorman@suse.de>,
        "Vladimir Murzin" <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Philip Derrin" <philip@cog.systems>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        "Jia He" <jia.he@hxt-semitech.com>,
        Kemi Wang <kemi.wang@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
 <20180907144447.GD12788@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <84b8e874-2a52-274c-4806-968470e66a08@huawei.com>
Date:   Sat, 8 Jun 2019 12:22:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180907144447.GD12788@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard, Will,

This week we were trying to debug an issue of time consuming in mem_init(),
and leading to this similar solution form Jia He, so I would like to bring this
thread back, please see my detail test result below.

On 2018/9/7 22:44, Will Deacon wrote:
> On Thu, Sep 06, 2018 at 01:24:22PM +0200, Ard Biesheuvel wrote:
>> On 22 August 2018 at 05:07, Jia He <hejianet@gmail.com> wrote:
>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>> where possible") optimized the loop in memmap_init_zone(). But it causes
>>> possible panic bug. So Daniel Vacek reverted it later.
>>>
>>> But as suggested by Daniel Vacek, it is fine to using memblock to skip
>>> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>>>
>>> More from what Daniel said:
>>> "On arm and arm64, memblock is used by default. But generic version of
>>> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
>>> not always return the next valid one but skips more resulting in some
>>> valid frames to be skipped (as if they were invalid). And that's why
>>> kernel was eventually crashing on some !arm machines."
>>>
>>> About the performance consideration:
>>> As said by James in b92df1de5,
>>> "I have tested this patch on a virtual model of a Samurai CPU with a
>>> sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
>>> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
>>>
>>> Besides we can remain memblock_next_valid_pfn, there is still some room
>>> for improvement. After this set, I can see the time overhead of memmap_init
>>> is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
>>> memory, pagesize 64k). I believe arm server will benefit more if memory is
>>> larger than TBs
>>>
>>
>> OK so we can summarize the benefits of this series as follows:
>> - boot time on a virtual model of a Samurai CPU drops from 109 to 62 seconds
>> - boot time on a QDF2400 arm64 server with 96 GB of RAM drops by ~15
>> *milliseconds*
>>
>> Google was not very helpful in figuring out what a Samurai CPU is and
>> why we should care about the boot time of Linux running on a virtual
>> model of it, and the 15 ms speedup is not that compelling either.

Testing this patch set on top of Kunpeng 920 based ARM64 server, with
384G memory in total, we got the time consuming below

             without this patch set      with this patch set
mem_init()        13310ms                      1415ms

So we got about 8x speedup on this machine, which is very impressive.

The time consuming is related the memory DIMM size and where to locate those
memory DIMMs in the slots. In above case, we are using 16G memory DIMM.
We also tested 1T memory with 64G size for each memory DIMM on another ARM64
machine, the time consuming reduced from 20s to 2s (I think it's related to
firmware implementations).

>>
>> Apologies to Jia that it took 11 revisions to reach this conclusion,
>> but in /my/ opinion, tweaking the fragile memblock/pfn handling code
>> for this reason is totally unjustified, and we're better off
>> disregarding these patches.

Indeed this patch set has a bug, For exampe, if we have 3 regions which
is [a, b] [c, d] [e, f] if address of pfn is bigger than the end address of
last region, we will increase early_region_idx to count of region, which is
out of bound of the regions. Fixed by patch below,

 mm/memblock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 8279295..8283bf0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1252,13 +1252,17 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
 		if (pfn >= start_pfn && pfn < end_pfn)
 			return pfn;

-		early_region_idx++;
+		/* try slow path */
+		if (++early_region_idx == type->cnt)
+			goto slow_path;
+
 		next_start_pfn = PFN_DOWN(regions[early_region_idx].base);

 		if (pfn >= end_pfn && pfn <= next_start_pfn)
 			return next_start_pfn;
 	}

+slow_path:
 	/* slow path, do the binary searching */
 	do {
 		mid = (right + left) / 2;

As the really impressive speedup on our ARM64 server system, could you reconsider
this patch set for merge? if you want more data I'm willing to clarify and give
more test.

Thanks
Hanjun

