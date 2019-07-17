Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09920C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA31B2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfGQVEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:04:01 -0400
Received: from out4437.biz.mail.alibaba.com ([47.88.44.37]:17389 "EHLO
        out4437.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbfGQVEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:04:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TX91ZqP_1563397435;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX91ZqP_1563397435)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jul 2019 05:03:58 +0800
Subject: Re: [v3 PATCH 1/2] mm: thp: make transhuge_vma_suitable available for
 anonymous THP
To:     Hugh Dickins <hughd@google.com>
Cc:     kirill.shutemov@linux.intel.com, mhocko@suse.com, vbabka@suse.cz,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560401041-32207-2-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1907171207080.1177@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <85d8060b-76ab-76d8-1fc5-496e07378722@linux.alibaba.com>
Date:   Wed, 17 Jul 2019 14:03:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1907171207080.1177@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/19 12:43 PM, Hugh Dickins wrote:
> On Thu, 13 Jun 2019, Yang Shi wrote:
>
>> The transhuge_vma_suitable() was only available for shmem THP, but
>> anonymous THP has the same check except pgoff check.  And, it will be
>> used for THP eligible check in the later patch, so make it available for
>> all kind of THPs.  This also helps reduce code duplication slightly.
>>
>> Since anonymous THP doesn't have to check pgoff, so make pgoff check
>> shmem vma only.
> Yes, I think you are right to avoid the pgoff check on anonymous.
> I had originally thought that it would work out okay even with the
> pgoff check on anonymous, and usually it would: but could give the
> wrong answer on an mremap-moved anonymous area.
>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: David Rientjes <rientjes@google.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Almost Acked-by me, but there's one nit I'd much prefer to change:
> sorry for being such a late nuisance...
>
>> ---
>>   mm/huge_memory.c |  2 +-
>>   mm/internal.h    | 25 +++++++++++++++++++++++++
>>   mm/memory.c      | 13 -------------
>>   3 files changed, 26 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9f8bce9..4bc2552 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -691,7 +691,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>   	struct page *page;
>>   	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>   
>> -	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
>> +	if (!transhuge_vma_suitable(vma, haddr))
>>   		return VM_FAULT_FALLBACK;
>>   	if (unlikely(anon_vma_prepare(vma)))
>>   		return VM_FAULT_OOM;
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 9eeaf2b..7f096ba 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -555,4 +555,29 @@ static inline bool is_migrate_highatomic_page(struct page *page)
>>   
>>   void setup_zone_pageset(struct zone *zone);
>>   extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
>> +static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>> +		unsigned long haddr)
>> +{
>> +	/* Don't have to check pgoff for anonymous vma */
>> +	if (!vma_is_anonymous(vma)) {
>> +		if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
>> +			(vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
>> +			return false;
>> +	}
>> +
>> +	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
>> +		return false;
>> +	return true;
>> +}
>> +#else
>> +static inline bool transhuge_vma_suitable(struct vma_area_struct *vma,
>> +		unsigned long haddr)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>   #endif	/* __MM_INTERNAL_H */
> ... maybe I'm just not much of a fan of mm/internal.h (where at last you
> find odd bits and pieces which you had expected to find elsewhere), and
> maybe others will disagree: but I'd say transhuge_vma_suitable() surely
> belongs in include/linux/huge_mm.h, near __transparent_hugepage_enabled().
>
> But then your correct use of vma_is_anonymous() gets more complicated:
> because that declaration is over in include/linux/mm.h; and although
> linux/mm.h includes linux/huge_mm.h, vma_is_anonymous() comes lower down.
>
> However... linux/mm.h's definition of vma_set_anonymous() comes higher
> up, and it would make perfect sense to move vma_is_anonymous up to just
> after vma_set_anonymous(), wouldn't it?  Should vma_is_shmem() and
> vma_is_stack_for_current() declarations move with it? Probably yes:
> they make more sense near vma_is_anonymous() than where they were.

Thanks for the thorough instructions. Will fix this in v4.

>
> Hugh
>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 96f1d47..2286424 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3205,19 +3205,6 @@ static vm_fault_t pte_alloc_one_map(struct vm_fault *vmf)
>>   }
>>   
>>   #ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
>> -
>> -#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
>> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>> -		unsigned long haddr)
>> -{
>> -	if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
>> -			(vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
>> -		return false;
>> -	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
>> -		return false;
>> -	return true;
>> -}
>> -
>>   static void deposit_prealloc_pte(struct vm_fault *vmf)
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>> -- 
>> 1.8.3.1

