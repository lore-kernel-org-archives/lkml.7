Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF6CC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64AD22ADC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfGXG6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:58:19 -0400
Received: from foss.arm.com ([217.140.110.172]:35974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfGXG6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:58:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C16728;
        Tue, 23 Jul 2019 23:58:18 -0700 (PDT)
Received: from [10.163.1.197] (unknown [10.163.1.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4743F694;
        Wed, 24 Jul 2019 00:00:16 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V6 RESEND 0/3] arm64/mm: Enable memory hot remove
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com, mhocko@suse.com,
        ira.weiny@intel.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, james.morse@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com
References: <1563171470-3117-1-git-send-email-anshuman.khandual@arm.com>
 <20190723105636.GA5004@lakrids.cambridge.arm.com>
Message-ID: <a69ed426-98ff-32ed-82ce-8216dd56daba@arm.com>
Date:   Wed, 24 Jul 2019 12:28:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723105636.GA5004@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/23/2019 04:26 PM, Mark Rutland wrote:
> Hi Anshuman,

Hello Mark,

> 
> On Mon, Jul 15, 2019 at 11:47:47AM +0530, Anshuman Khandual wrote:
>> This series enables memory hot remove on arm64 after fixing a memblock
>> removal ordering problem in generic try_remove_memory() and a possible
>> arm64 platform specific kernel page table race condition. This series
>> is based on linux-next (next-20190712).
>>
>> Concurrent vmalloc() and hot-remove conflict:
>>
>> As pointed out earlier on the v5 thread [2] there can be potential conflict
>> between concurrent vmalloc() and memory hot-remove operation. This can be
>> solved or at least avoided with some possible methods. The problem here is
>> caused by inadequate locking in vmalloc() which protects installation of a
>> page table page but not the walk or the leaf entry modification.
>>
>> Option 1: Making locking in vmalloc() adequate
>>
>> Current locking scheme protects installation of page table pages but not the
>> page table walk or leaf entry creation which can conflict with hot-remove.
>> This scheme is sufficient for now as vmalloc() works on mutually exclusive
>> ranges which can proceed concurrently only if their shared page table pages
>> can be created while inside the lock. It achieves performance improvement
>> which will be compromised if entire vmalloc() operation (even if with some
>> optimization) has to be completed under a lock.
>>
>> Option 2: Making sure hot-remove does not happen during vmalloc()
>>
>> Take mem_hotplug_lock in read mode through [get|put]_online_mems() constructs
>> for the entire duration of vmalloc(). It protects from concurrent memory hot
>> remove operation and does not add any significant overhead to other concurrent
>> vmalloc() threads. It solves the problem in right way unless we do not want to
>> extend the usage of mem_hotplug_lock in generic MM.
>>
>> Option 3: Memory hot-remove does not free (conflicting) page table pages
>>
>> Don't not free page table pages (if any) for vmemmap mappings after unmapping
>> it's virtual range. The only downside here is that some page table pages might
>> remain empty and unused until next memory hot-add operation of the same memory
>> range.
>>
>> Option 4: Dont let vmalloc and vmemmap share intermediate page table pages
>>
>> The conflict does not arise if vmalloc and vmemap range do not share kernel
>> page table pages to start with. If such placement can be ensured in platform
>> kernel virtual address layout, this problem can be successfully avoided.
>>
>> There are two generic solutions (Option 1 and 2) and two platform specific
>> solutions (Options 2 and 3). This series has decided to go with (Option 3)

s/Option 2 and 3/Option 3 and 4/

>> which requires minimum changes while self-contained inside the functionality.
> 
> ... while also leaking memory, right?

This is not a memory leak. In the worst case where an empty page table page could
have been freed after parts of it's kernel virtual range span's vmemmap mapping has
been taken down still remains attached to the higher level page table entry. This
empty page table page will be completely reusable during future vmalloc() allocations
or vmemmap mapping for newly hot added memory in overlapping memory range. It is just
an empty data structure sticking around which could (probably would) be reused later.
This problem will not scale and get worse because its part of kernel page table not
user process which could get multiplied. Its a small price we are paying to remain
safe from a vmalloc() and memory hot remove potential collisions on the kernel page
table. IMHO that is fair enough.

> 
> In my view, option 2 or 4 would have been preferable. Were there

I would say option 2 is the ideal solution where we make sure that each vmalloc()
instance is protected against concurrent memory hot remove through a read side lock
via [get|put]_online_mems().

Option 4 is very much platform specific and each platform has to make sure that they
remain compliant all the time which is not ideal. Its is also an a work around which
avoids the problem and does not really fix it.

> specific technical reasons to not go down either of those routes? I'm

Option 2 will require wider agreement as it involves a very critical hot-path vmalloc()
which can affect many workloads. IMHO Option 4 is neither optimal and not does it solve
the problem correctly. Like this approach it just avoids it but unlike this touches upon
another code area.

> not sure that minimizing changes is the right rout given that this same
> problem presumably applies to other architectures, which will need to be
> fixed.

Yes this needs to be fixed but we can get there one step at a time. vmemmap tear
down process can start freeing empty page table pages when this gets solved. But
why should it prevent entire memory hot remove functionality from being available.

> 
> Do we know why we aren't seeing issues on other architectures? e.g. is
> the issue possible but rare (and hence not reported), or masked by
> something else (e.g. the layout of the kernel VA space)?

I would believe so but we can only get more insights from respective architecture folks.

> 
> I'd like to solve the underyling issue before we start adding new
> functionality.

The entire memory hot-remove functionality from the platform perspective has four
primary functions.

1. Tear down linear mapping
2. Tear down vmemmap mapping
3. Free empty kernel page table pages after tearing down linear mapping
4. Free empty kernel page table pages after tearing down vmemmap mapping

This particular issue mentioned before prevents just the last function (4) which
in the worst case will retain some empty page tables pages erstwhile holding vmemmap
mapping in the kernel page table but otherwise provides complete memory hot remove
functionality.

Why should all these remaining memory hot-remove functions be prevented from being
available for use ? The remaining set of functions (1-3) do not create any side affects
or introduce any new bugs. Also function (4) is not tightly coupled with rest of the
functions (1-3) and anyways will be unlocked independently when the particular issue
gets resolved. The point I am trying to make here is they are not tightly coupled
and perceiving them that way blocks remaining memory hot-remove functionality from
being available.

> 
>> Testing:
>>
>> Memory hot remove has been tested on arm64 for 4K, 16K, 64K page config
>> options with all possible CONFIG_ARM64_VA_BITS and CONFIG_PGTABLE_LEVELS
>> combinations. Its only build tested on non-arm64 platforms.
> 
> Could you please share how you've tested this?
> 
> Having instructions so that I could reproduce this locally would be very
> helpful.

Please find the series rebased on v5.3-rc1 along with test patches which
enable sysfs interfaces for memory hot add and remove used for testing.

git://linux-arm.org/linux-anshuman.git (memory_hotremove/v6_resend_v5.3-rc1)

Sample Testing Procedure:

echo offline > /sys/devices/system/memory/auto_online_blocks
echo 0x680000000 > /sys/devices/system/memory/probe
echo online_movable > /sys/devices/system/memory/memory26/state
echo 0x680000000 > /sys/devices/system/memory/unprobe

Writing into unprobe trigger offlining first followed by actual memory removal.

NOTE:

This assumes that 0x680000000 is valid memory block starting physical address
and memory26 gets created because of the preceding memory hot addition. Please
use appropriate values based on your local setup. Let me know how it goes and
if I could provide more information.

- Anshuman
