Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D6C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6261F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfEMIhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:37:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48852 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbfEMIhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:37:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9EB15AD;
        Mon, 13 May 2019 01:37:12 -0700 (PDT)
Received: from [10.163.1.137] (unknown [10.163.1.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D63E43F720;
        Mon, 13 May 2019 01:37:03 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] arm64/mm: Enable memory hot remove
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        cai@lca.pw, logang@deltatee.com, ira.weiny@intel.com
References: <1555221553-18845-1-git-send-email-anshuman.khandual@arm.com>
 <bbfc6ede-01b2-2331-112e-fa28bc2591fb@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <67efff12-6d7f-9696-0c34-c9ad11acd297@arm.com>
Date:   Mon, 13 May 2019 14:07:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bbfc6ede-01b2-2331-112e-fa28bc2591fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/13/2019 01:52 PM, David Hildenbrand wrote:
> On 14.04.19 07:59, Anshuman Khandual wrote:
>> This series enables memory hot remove on arm64 after fixing a memblock
>> removal ordering problem in generic __remove_memory(). This is based
>> on the following arm64 working tree.
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
>>
>> Testing:
>>
>> Tested hot remove on arm64 for all 4K, 16K, 64K page config options with
>> all possible VA_BITS and PGTABLE_LEVELS combinations. Build tested on non
>> arm64 platforms.
>>
>> Changes in V2:
>>
>> - Added all received review and ack tags
>> - Split the series from ZONE_DEVICE enablement for better review
>>
>> - Moved memblock re-order patch to the front as per Robin Murphy
>> - Updated commit message on memblock re-order patch per Michal Hocko
>>
>> - Dropped [pmd|pud]_large() definitions
>> - Used existing [pmd|pud]_sect() instead of earlier [pmd|pud]_large()
>> - Removed __meminit and __ref tags as per Oscar Salvador
>> - Dropped unnecessary 'ret' init in arch_add_memory() per Robin Murphy
>> - Skipped calling into pgtable_page_dtor() for linear mapping page table
>>   pages and updated all relevant functions
>>
>> Changes in V1: (https://lkml.org/lkml/2019/4/3/28)
>>
>> Anshuman Khandual (2):
>>   mm/hotplug: Reorder arch_remove_memory() call in __remove_memory()
>>   arm64/mm: Enable memory hot remove
>>
>>  arch/arm64/Kconfig               |   3 +
>>  arch/arm64/include/asm/pgtable.h |   2 +
>>  arch/arm64/mm/mmu.c              | 221 ++++++++++++++++++++++++++++++++++++++-
>>  mm/memory_hotplug.c              |   3 +-
>>  4 files changed, 225 insertions(+), 4 deletions(-)
>>
> 
> What's the progress of this series? I'll need arch_remove_memory() for
> the series
> 
> [PATCH v2 0/8] mm/memory_hotplug: Factor out memory block device handling
> 

Hello David,

I am almost done with the next version with respect to memory hot-remove i.e
arch_remove_memory(). But most of the time was spent addressing concerns with
respect to how memory hot remove is going to impact existing arm64 and generic
code which can concurrently walk or modify init_mm page table. I should be
sending out V3 this week or early next week.

- Anshuman   
