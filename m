Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DF3C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F4220B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfJILAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:00:05 -0400
Received: from foss.arm.com ([217.140.110.172]:59884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfJILAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:00:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95A0428;
        Wed,  9 Oct 2019 04:00:04 -0700 (PDT)
Received: from [10.1.196.133] (unknown [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0BA93F703;
        Wed,  9 Oct 2019 04:00:01 -0700 (PDT)
Subject: Re: [PATCH v11 14/22] mm: pagewalk: Add 'depth' parameter to pte_hole
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20191007153822.16518-1-steven.price@arm.com>
 <20191007153822.16518-15-steven.price@arm.com>
 <20191007161049.GA13229@ziepe.ca>
 <6e570d6d-b29f-f4cb-1eb9-6ff6cab15a2e@arm.com>
 <20191007181113.GC13229@ziepe.ca>
From:   Steven Price <steven.price@arm.com>
Message-ID: <7baa4861-eb68-5dcb-137b-482a3b5f52a6@arm.com>
Date:   Wed, 9 Oct 2019 12:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191007181113.GC13229@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 19:11, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2019 at 05:20:30PM +0100, Steven Price wrote:
>> On 07/10/2019 17:10, Jason Gunthorpe wrote:
>>> On Mon, Oct 07, 2019 at 04:38:14PM +0100, Steven Price wrote:
>>>> diff --git a/mm/hmm.c b/mm/hmm.c
>>>> index 902f5fa6bf93..34fe904dd417 100644
>>>> +++ b/mm/hmm.c
>>>> @@ -376,7 +376,7 @@ static void hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
>>>>  }
>>>>  
>>>>  static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
>>>> -			     struct mm_walk *walk)
>>>> +			     __always_unused int depth, struct mm_walk *walk)
>>>
>>> It this __always_unused on function arguments something we are doing
>>> now?
>>
>> $ git grep __always_unused | wc -l
>> 191
>>
>> It's elsewhere in the kernel tree. It seems like a good way of both
>> documenting and silencing compiler warnings. But I'm open to other
>> suggestions.
> 
> The normal kernel build doesn't generate warnings for unused function
> parameters because there are alot of false positives, IIRC. So, seems
> weird to see things like this.
> 
>>> Can we have negative depth? Should it be unsigned?
>>
>> As per the documentation added in this patch:
>>
>>  * @pte_hole:	if set, called for each hole at all levels,
>>  *		depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD
>>  *		4:PTE. Any folded depths (where PTRS_PER_P?D is equal
>>  *		to 1) are skipped.
>>
>> So it's signed to allow "-1" in the cases where pte_hole is called
>> without knowing the actual depth. This is used in the function
>> walk_page_test() because it don't walk the actual page tables, but is
>> called on a VMA instead. This means that there may not be a single depth
>> for the range provided.
> 
> So are the depth values below OK? I would have expected -1 by this
> definition

Good spot - that indeed was very sloppy of me. In these cases the value
is ignored, but -1 would indeed have been a better value to use. I'll
fix that up.

Thanks,

Steve

>>>>  {
>>>>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>>>>  	struct hmm_range *range = hmm_vma_walk->range;
>>>> @@ -564,7 +564,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>>>>  again:
>>>>  	pmd = READ_ONCE(*pmdp);
>>>>  	if (pmd_none(pmd))
>>>> -		return hmm_vma_walk_hole(start, end, walk);
>>>> +		return hmm_vma_walk_hole(start, end, 0, walk);
>>>>  
>>>>  	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
>>>>  		bool fault, write_fault;
>>>> @@ -666,7 +666,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>>>>  again:
>>>>  	pud = READ_ONCE(*pudp);
>>>>  	if (pud_none(pud))
>>>> -		return hmm_vma_walk_hole(start, end, walk);
>>>> +		return hmm_vma_walk_hole(start, end, 0, walk);
>>>>  
>>>>  	if (pud_huge(pud) && pud_devmap(pud)) {
>>>>  		unsigned long i, npages, pfn;
>>>> @@ -674,7 +674,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>>>>  		bool fault, write_fault;
>>>>  
>>>>  		if (!pud_present(pud))
>>>> -			return hmm_vma_walk_hole(start, end, walk);
>>>> +			return hmm_vma_walk_hole(start, end, 0, walk);
>>>>  
>>>>  		i = (addr - range->start) >> PAGE_SHIFT;
>>>>  		npages = (end - addr) >> PAGE_SHIFT;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

