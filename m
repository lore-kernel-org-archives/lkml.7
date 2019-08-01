Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2116AC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3C6206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfHADCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:02:38 -0400
Received: from foss.arm.com ([217.140.110.172]:57358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfHADCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:02:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36AED344;
        Wed, 31 Jul 2019 20:02:37 -0700 (PDT)
Received: from [10.163.1.81] (unknown [10.163.1.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2A7B3F575;
        Wed, 31 Jul 2019 20:02:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC 2/2] arm64/mm: Enable device memory allocation and free for
 vmemmap mapping
To:     Will Deacon <will@kernel.org>
Cc:     linux-mm@kvack.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1561697083-7329-1-git-send-email-anshuman.khandual@arm.com>
 <1561697083-7329-3-git-send-email-anshuman.khandual@arm.com>
 <20190731161103.kqv3v2xlq4vnyjhp@willie-the-truck>
Message-ID: <349fb6e2-f9f1-c45a-e512-4ac253e2fd3d@arm.com>
Date:   Thu, 1 Aug 2019 08:33:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190731161103.kqv3v2xlq4vnyjhp@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2019 09:41 PM, Will Deacon wrote:
> On Fri, Jun 28, 2019 at 10:14:43AM +0530, Anshuman Khandual wrote:
>> This enables vmemmap_populate() and vmemmap_free() functions to incorporate
>> struct vmem_altmap based device memory allocation and free requests. With
>> this device memory with specific atlmap configuration can be hot plugged
>> and hot removed as ZONE_DEVICE memory on arm64 platforms.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 57 ++++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 37 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 39e18d1..8867bbd 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -735,15 +735,26 @@ int kern_addr_valid(unsigned long addr)
>>  }
>>  
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>> -static void free_hotplug_page_range(struct page *page, size_t size)
>> +static void free_hotplug_page_range(struct page *page, size_t size,
>> +				    struct vmem_altmap *altmap)
>>  {
>> -	WARN_ON(!page || PageReserved(page));
>> -	free_pages((unsigned long)page_address(page), get_order(size));
>> +	if (altmap) {
>> +		/*
>> +		 * vmemmap_populate() creates vmemmap mapping either at pte
>> +		 * or pmd level. Unmapping request at any other level would
>> +		 * be a problem.
>> +		 */
>> +		WARN_ON((size != PAGE_SIZE) && (size != PMD_SIZE));
>> +		vmem_altmap_free(altmap, size >> PAGE_SHIFT);
>> +	} else {
>> +		WARN_ON(!page || PageReserved(page));
>> +		free_pages((unsigned long)page_address(page), get_order(size));
>> +	}
>>  }
>>  
>>  static void free_hotplug_pgtable_page(struct page *page)
>>  {
>> -	free_hotplug_page_range(page, PAGE_SIZE);
>> +	free_hotplug_page_range(page, PAGE_SIZE, NULL);
>>  }
>>  
>>  static void free_pte_table(pmd_t *pmdp, unsigned long addr)
>> @@ -807,7 +818,8 @@ static void free_pud_table(pgd_t *pgdp, unsigned long addr)
>>  }
>>  
>>  static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
>> -				    unsigned long end, bool sparse_vmap)
>> +				    unsigned long end, bool sparse_vmap,
>> +				    struct vmem_altmap *altmap)
> 
> Do you still need the sparse_vmap parameter, or can you just pass a NULL
> altmap pointer when sparse_vmap is false?

Yes, we will still require sparse_vmap parameter because vmemmap mapping
does not necessarily be created only for ZONE_DEVICE range with an altmap.
vmemmap can still be present with altmap as NULL (regular memory and device
memory without altmap) in which cases it will not be possible to
differentiate between linear and vmemmap mapping.
