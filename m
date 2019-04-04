Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8FBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF5420693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbfDDJVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:21:20 -0400
Received: from foss.arm.com ([217.140.101.70]:55428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387703AbfDDJQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D54E8168F;
        Thu,  4 Apr 2019 02:16:53 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 757D73F557;
        Thu,  4 Apr 2019 02:16:50 -0700 (PDT)
Subject: Re: [PATCH 2/6] arm64/mm: Enable memory hot remove
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, mhocko@suse.com, david@redhat.com,
        robin.murphy@arm.com, cai@lca.pw, pasha.tatashin@oracle.com,
        Stephen Bates <sbates@raithlin.com>, james.morse@arm.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-3-git-send-email-anshuman.khandual@arm.com>
 <f2ea761c-49b2-88f6-14fa-5aaec57952cb@deltatee.com>
 <45afb99f-5785-4048-a748-4e0f06b06b31@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <1d1d69d1-06e6-f429-f22b-00ca922a314d@arm.com>
Date:   Thu, 4 Apr 2019 10:16:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <45afb99f-5785-4048-a748-4e0f06b06b31@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 08:07, Anshuman Khandual wrote:
> 
> 
> On 04/03/2019 11:02 PM, Logan Gunthorpe wrote:
>>
>>
>> On 2019-04-02 10:30 p.m., Anshuman Khandual wrote:
>>> Memory removal from an arch perspective involves tearing down two different
>>> kernel based mappings i.e vmemmap and linear while releasing related page
>>> table pages allocated for the physical memory range to be removed.
>>>
>>> Define a common kernel page table tear down helper remove_pagetable() which
>>> can be used to unmap given kernel virtual address range. In effect it can
>>> tear down both vmemap or kernel linear mappings. This new helper is called
>>> from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
>>> The argument 'direct' here identifies kernel linear mappings.
>>>
>>> Vmemmap mappings page table pages are allocated through sparse mem helper
>>> functions like vmemmap_alloc_block() which does not cycle the pages through
>>> pgtable_page_ctor() constructs. Hence while removing it skips corresponding
>>> destructor construct pgtable_page_dtor().
>>>
>>> While here update arch_add_mempory() to handle __add_pages() failures by
>>> just unmapping recently added kernel linear mapping. Now enable memory hot
>>> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
>>>
>>> This implementation is overall inspired from kernel page table tear down
>>> procedure on X86 architecture.
>>
>> I've been working on very similar things for RISC-V. In fact, I'm
>> currently in progress on a very similar stripped down version of
>> remove_pagetable(). (Though I'm fairly certain I've done a bunch of
>> stuff wrong.)
>>
>> Would it be possible to move this work into common code that can be used
>> by all arches? Seems like, to start, we should be able to support both
>> arm64 and RISC-V... and maybe even x86 too.
>>
>> I'd be happy to help integrate and test such functions in RISC-V.
> 
> Sure that will be great. The only impediment is pgtable_page_ctor() for kernel
> linear mapping. This series is based on current arm64 where linear mapping
> pgtable pages go through pgtable_page_ctor() init sequence but that might be
> changing soon. If RISC-V does not have pgtable_page_ctor() init for linear
> mapping and no other arch specific stuff later on we can try to consolidate
> remove_pagetable() atleast for both the architectures.
> 
> Then I wondering whether I can transition pud|pmd_large() to pud|pmd_sect().

The first 10 patches of my generic page walk series[1] adds p?d_large()
as a common feature, so probably best sticking with p?d_large() if this
is going to be common and basing on top of those patches.

[1]
https://lore.kernel.org/lkml/20190403141627.11664-1-steven.price@arm.com/T/

Steve
