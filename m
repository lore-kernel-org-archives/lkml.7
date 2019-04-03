Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B50DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071252133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfDCR5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:57:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45988 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfDCR5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:57:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF8DA80D;
        Wed,  3 Apr 2019 10:57:07 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AC263F721;
        Wed,  3 Apr 2019 10:57:04 -0700 (PDT)
Subject: Re: [PATCH 2/6] arm64/mm: Enable memory hot remove
To:     Logan Gunthorpe <logang@deltatee.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mark.rutland@arm.com, mhocko@suse.com, david@redhat.com,
        cai@lca.pw, pasha.tatashin@oracle.com,
        Stephen Bates <sbates@raithlin.com>, james.morse@arm.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-3-git-send-email-anshuman.khandual@arm.com>
 <f2ea761c-49b2-88f6-14fa-5aaec57952cb@deltatee.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <85fbfe49-d49e-fd6e-21dd-ff4d9808610b@arm.com>
Date:   Wed, 3 Apr 2019 18:57:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f2ea761c-49b2-88f6-14fa-5aaec57952cb@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 18:32, Logan Gunthorpe wrote:
> 
> 
> On 2019-04-02 10:30 p.m., Anshuman Khandual wrote:
>> Memory removal from an arch perspective involves tearing down two different
>> kernel based mappings i.e vmemmap and linear while releasing related page
>> table pages allocated for the physical memory range to be removed.
>>
>> Define a common kernel page table tear down helper remove_pagetable() which
>> can be used to unmap given kernel virtual address range. In effect it can
>> tear down both vmemap or kernel linear mappings. This new helper is called
>> from both vmemamp_free() and ___remove_pgd_mapping() during memory removal.
>> The argument 'direct' here identifies kernel linear mappings.
>>
>> Vmemmap mappings page table pages are allocated through sparse mem helper
>> functions like vmemmap_alloc_block() which does not cycle the pages through
>> pgtable_page_ctor() constructs. Hence while removing it skips corresponding
>> destructor construct pgtable_page_dtor().
>>
>> While here update arch_add_mempory() to handle __add_pages() failures by
>> just unmapping recently added kernel linear mapping. Now enable memory hot
>> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
>>
>> This implementation is overall inspired from kernel page table tear down
>> procedure on X86 architecture.
> 
> I've been working on very similar things for RISC-V. In fact, I'm
> currently in progress on a very similar stripped down version of
> remove_pagetable(). (Though I'm fairly certain I've done a bunch of
> stuff wrong.)
> 
> Would it be possible to move this work into common code that can be used
> by all arches? Seems like, to start, we should be able to support both
> arm64 and RISC-V... and maybe even x86 too.
> 
> I'd be happy to help integrate and test such functions in RISC-V.

Indeed, I had hoped we might be able to piggyback off generic code for 
this anyway, given that we have generic pagetable code which knows how 
to free process pagetables, and kernel pagetables are also pagetables.

I did actually hack up such a patch[1], and other than 
p?d_none_or_clear_bad() being loud it does actually appear to function 
OK in terms of withstanding repeated add/remove cycles and not crashing, 
but all the pagetable accounting and other stuff I don't really know 
about mean it's probably not viable without a lot more core work.

Robin.

[1] 
http://linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=75934a2c4f737ad9f26903861108d5b0658e86bb
