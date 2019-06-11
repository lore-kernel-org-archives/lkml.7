Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C18C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770D92175B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404803AbfFKPTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:19:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387563AbfFKPTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:19:02 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7293773B8CAD52EBAEAF;
        Tue, 11 Jun 2019 23:19:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 23:18:57 +0800
Subject: Re: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Will Deacon <will.deacon@arm.com>,
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
        "AKASHI Takahiro" <takahiro.akashi@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        Laura Abbott <labbott@redhat.com>,
        "Daniel Vacek" <neelx@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "Kees Cook" <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        "Jia He" <jia.he@hxt-semitech.com>, Jia He <hejianet@gmail.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Philip Derrin <philip@cog.systems>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
 <20180907144447.GD12788@arm.com>
 <84b8e874-2a52-274c-4806-968470e66a08@huawei.com>
 <CAKv+Gu9fd2Y7USDYnQdUuYd9L2OD99kU4A1x1JSF442KN96TTA@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <2de74de9-35b0-5e62-d822-1be59f0ef605@huawei.com>
Date:   Tue, 11 Jun 2019 23:18:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9fd2Y7USDYnQdUuYd9L2OD99kU4A1x1JSF442KN96TTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ard,

Thanks for the reply, please see my comments inline.

On 2019/6/10 21:16, Ard Biesheuvel wrote:
> On Sat, 8 Jun 2019 at 06:22, Hanjun Guo <guohanjun@huawei.com> wrote:
>>
>> Hi Ard, Will,
>>
>> This week we were trying to debug an issue of time consuming in mem_init(),
>> and leading to this similar solution form Jia He, so I would like to bring this
>> thread back, please see my detail test result below.
>>
>> On 2018/9/7 22:44, Will Deacon wrote:
>>> On Thu, Sep 06, 2018 at 01:24:22PM +0200, Ard Biesheuvel wrote:
>>>> On 22 August 2018 at 05:07, Jia He <hejianet@gmail.com> wrote:
>>>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>>>> where possible") optimized the loop in memmap_init_zone(). But it causes
>>>>> possible panic bug. So Daniel Vacek reverted it later.
>>>>>
>>>>> But as suggested by Daniel Vacek, it is fine to using memblock to skip
>>>>> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>>>>>
>>>>> More from what Daniel said:
>>>>> "On arm and arm64, memblock is used by default. But generic version of
>>>>> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
>>>>> not always return the next valid one but skips more resulting in some
>>>>> valid frames to be skipped (as if they were invalid). And that's why
>>>>> kernel was eventually crashing on some !arm machines."
>>>>>
>>>>> About the performance consideration:
>>>>> As said by James in b92df1de5,
>>>>> "I have tested this patch on a virtual model of a Samurai CPU with a
>>>>> sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
>>>>> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
>>>>>
>>>>> Besides we can remain memblock_next_valid_pfn, there is still some room
>>>>> for improvement. After this set, I can see the time overhead of memmap_init
>>>>> is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
>>>>> memory, pagesize 64k). I believe arm server will benefit more if memory is
>>>>> larger than TBs
>>>>>
>>>>
>>>> OK so we can summarize the benefits of this series as follows:
>>>> - boot time on a virtual model of a Samurai CPU drops from 109 to 62 seconds
>>>> - boot time on a QDF2400 arm64 server with 96 GB of RAM drops by ~15
>>>> *milliseconds*
>>>>
>>>> Google was not very helpful in figuring out what a Samurai CPU is and
>>>> why we should care about the boot time of Linux running on a virtual
>>>> model of it, and the 15 ms speedup is not that compelling either.
>>
>> Testing this patch set on top of Kunpeng 920 based ARM64 server, with
>> 384G memory in total, we got the time consuming below
>>
>>              without this patch set      with this patch set
>> mem_init()        13310ms                      1415ms
>>
>> So we got about 8x speedup on this machine, which is very impressive.
>>
> 
> Yes, this is impressive. But does it matter in the grand scheme of
> things? 

It matters for this machine, because it's for storage and there is
a watchdog and the time consuming triggers the watchdog.

> How much time does this system take to arrive at this point
> from power on?

Sorry, I don't have such data, as the arch timer is not initialized
and I didn't see the time stamp at this point, but I read the cycles
from arch timer before and after the time consuming function to get
how much time consumed.

> 
>> The time consuming is related the memory DIMM size and where to locate those
>> memory DIMMs in the slots. In above case, we are using 16G memory DIMM.
>> We also tested 1T memory with 64G size for each memory DIMM on another ARM64
>> machine, the time consuming reduced from 20s to 2s (I think it's related to
>> firmware implementations).
>>
> 
> I agree that this optimization looks good in isolation, but the fact
> that you spotted a bug justifies my skepticism at the time. On the
> other hand, now that we have several independent reports (from you,
> but also from the Renesas folks) that the speedup is worthwhile for
> real world use cases, I think it does make sense to revisit it.

Thank you very much for taking care of this :)

> 
> So what I would like to see is the patch set being proposed again,
> with the new data points added for documentation. Also, the commit
> logs need to crystal clear about how the meaning of PFN validity
> differs between ARM and other architectures, and why the assumptions
> that the optimization is based on are guaranteed to hold.

I think Jia He no longer works for HXT, if don't mind, I can repost
this patch set with Jia He's authority unchanged.

Thanks
Hanjun

