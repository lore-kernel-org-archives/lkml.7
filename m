Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DBCC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50A020720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgAHRRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:17:37 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44124 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgAHRRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:17:36 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ipExL-0004JB-Ec; Wed, 08 Jan 2020 10:17:20 -0700
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>,
        Michal Hocko <mhocko@suse.com>
References: <20200107205959.7575-1-logang@deltatee.com>
 <20200107205959.7575-8-logang@deltatee.com>
 <f4c11a37-91dd-a366-7683-4e4cd4bd7e99@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f08ae374-365e-4291-9cf2-d807a45579bb@deltatee.com>
Date:   Wed, 8 Jan 2020 10:17:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f4c11a37-91dd-a366-7683-4e4cd4bd7e99@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: mhocko@suse.com, ebadger@gigaio.com, peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, will@kernel.org, catalin.marinas@arm.com, hch@lst.de, akpm@linux-foundation.org, mhocko@kernel.org, dan.j.williams@intel.com, linux-mm@kvack.org, platform-driver-x86@vger.kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, david@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 7/8] mm/memory_hotplug: Add pgprot_t to mhp_modifiers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-01-08 5:39 a.m., David Hildenbrand wrote:
> On 07.01.20 21:59, Logan Gunthorpe wrote:
>> devm_memremap_pages() is currently used by the PCI P2PDMA code to create
>> struct page mappings for IO memory. At present, these mappings are created
>> with PAGE_KERNEL which implies setting the PAT bits to be WB. However, on
>> x86, an mtrr register will typically override this and force the cache
>> type to be UC-. In the case firmware doesn't set this register it is
>> effectively WB and will typically result in a machine check exception
>> when it's accessed.
>>
>> Other arches are not currently likely to function correctly seeing they
>> don't have any MTRR registers to fall back on.
>>
>> To solve this, add an argument to arch_add_memory() to explicitly
>> set the pgprot value to a specific value.
> 
> You're adding a parameter indirectly by adding it to the structure.
> Maybe "provide a way to specify the pgprot value explicitly to
> arch_add_memory()"
> 
>>
>> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a
> 
> s/is/need/
> 
>> simple change to pass the pgprot_t down to their respective functions
>> which set up the page tables. For x86_32, set the page tables explicitly
> 
> "page table protection" ?
> 
>> using _set_memory_prot() (seeing they are already mapped). For sh, reject
>> anything but PAGE_KERNEL settings -- this should be fine, for now, seeing
>> sh doesn't support ZONE_DEVICE anyway.
>>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  arch/arm64/mm/mmu.c            | 3 ++-
>>  arch/ia64/mm/init.c            | 4 ++++
>>  arch/powerpc/mm/mem.c          | 3 ++-
>>  arch/s390/mm/init.c            | 2 +-
>>  arch/sh/mm/init.c              | 3 +++
>>  arch/x86/mm/init_32.c          | 5 +++++
>>  arch/x86/mm/init_64.c          | 2 +-
>>  include/linux/memory_hotplug.h | 2 ++
>>  mm/memory_hotplug.c            | 2 +-
>>  mm/memremap.c                  | 6 +++---
>>  10 files changed, 24 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 3320406579c3..9b214b0d268f 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1058,7 +1058,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>  
>>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>> -			     size, PAGE_KERNEL, __pgd_pgtable_alloc, flags);
>> +			     size, modifiers->pgprot, __pgd_pgtable_alloc,
>> +			     flags);
>>  
>>  	memblock_clear_nomap(start, size);
>>  
>> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
>> index daf438e08b96..5fd6ae4929c9 100644
>> --- a/arch/ia64/mm/init.c
>> +++ b/arch/ia64/mm/init.c
>> @@ -677,6 +677,10 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  	int ret;
>>  
>>  	ret = __add_pages(nid, start_pfn, nr_pages, modifiers);
>> +	if (modifiers->pgprot != PAGE_KERNEL)
>> +		return -EINVAL;
> 
> ... maybe better "if (WARN_ON_ONCE(...))"
> [...]
> 
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -56,9 +56,11 @@ enum {
>>  /*
>>   * Restrictions for the memory hotplug:
>>   * altmap: alternative allocator for memmap array
>> + * pgprot: page protection flags to apply to newly added page tables
>>   */
>>  struct mhp_modifiers {
>>  	struct vmem_altmap *altmap;
>> +	pgprot_t pgprot;
>>  };
>>  
>>  /*
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 1bb3f92e087d..0888f821af06 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1027,7 +1027,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>>   */
>>  int __ref add_memory_resource(int nid, struct resource *res)
>>  {
>> -	struct mhp_modifiers modifiers = {};
>> +	struct mhp_modifiers modifiers = {.pgprot = PAGE_KERNEL};
> 
> I think we usually use spaces like
> 
> = { .pgprot = PAGE_KERNEL };
> 
> t480s: ~/git/linux virtio-mem-v1 $ git grep "= {\." | wc -l
> 978
> t480s: ~/git/linux virtio-mem-v1 $ git grep "= { " | wc -l
> 35447
> 
>>  	u64 start, size;
>>  	bool new_node = false;
>>  	int ret;
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index e30be8ba706b..45ab4ef0643d 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -163,8 +163,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>>  		 * We do not want any optional features only our own memmap
>>  		 */
>>  		.altmap = pgmap_altmap(pgmap),
>> +		.pgprot = PAGE_KERNEL,
>>  	};
>> -	pgprot_t pgprot = PAGE_KERNEL;
>>  	int error, is_ram;
>>  	bool need_devmap_managed = true;
>>  
>> @@ -252,8 +252,8 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
>>  	if (nid < 0)
>>  		nid = numa_mem_id();
>>  
>> -	error = track_pfn_remap(NULL, &pgprot, PHYS_PFN(res->start), 0,
>> -			resource_size(res));
>> +	error = track_pfn_remap(NULL, &modifiers.pgprot, PHYS_PFN(res->start),
>> +				0, resource_size(res));
>>  	if (error)
>>  		goto err_pfn_remap;
>>  
>>
> 
> The !arch code looks good to me (besides I would prefer "params" instead
> of "modifiers").
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks, I'll make the changes above for v3.

Logan

