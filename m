Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510FCC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BA62146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLTPfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:35:50 -0500
Received: from foss.arm.com ([217.140.110.172]:52522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfLTPft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:35:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD9CA30E;
        Fri, 20 Dec 2019 07:35:47 -0800 (PST)
Received: from [10.1.194.52] (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7EB3F6CF;
        Fri, 20 Dec 2019 07:35:45 -0800 (PST)
Subject: Re: [PATCH v17 11/23] mm: pagewalk: Add p4d_entry() and pgd_entry()
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20191218162402.45610-1-steven.price@arm.com>
 <20191218162402.45610-12-steven.price@arm.com>
 <9ea2f1a2-5ec0-c21c-e725-334b6bf2886d@shipmail.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b7962b93-4ef2-b0d9-e66c-1fc401afc360@arm.com>
Date:   Fri, 20 Dec 2019 15:35:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9ea2f1a2-5ec0-c21c-e725-334b6bf2886d@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2019 14:25, Thomas Hellström (VMware) wrote:
> Hi, Steven,
> 
> 
> On 12/18/19 5:23 PM, Steven Price wrote:
>> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
>> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
>> no users. We're about to add users so reintroduce them, along with
>> p4d_entry() as we now have 5 levels of tables.
>>
>> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
>> PUD-sized transparent hugepages") already re-added pud_entry() but with
>> different semantics to the other callbacks. This commit reverts the
>> semantics back to match the other callbacks.
>>
>> To support hmm.c which now uses the new semantics of pud_entry() a new
>> member ('action') of struct mm_walk is added which allows the callbacks
>> to either descend (ACTION_SUBTREE, the default), skip (ACTION_CONTINUE)
>> or repeat the callback (ACTION_AGAIN). hmm.c is then updated to call
>> pud_trans_huge_lock() itself and make use of the splitting/retry logic
>> of the core code.
>>
>> After this change pud_entry() is called for all entries, not just
>> transparent huge pages.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> I have a couple of comments that are actually mostly related to
> pre-existing bugs, but that affect code that are touched by this patch.
> 
> Perhaps this is most cleanly addressed by a follow-up patch. Up to you
> to decide.
> 
> Since these problems are pre-existing,
> 
> Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>

Thanks, I'll send out an extra patch with these changes.

Steve

> Thanks,
> 
> Thomas
> 
> 
>> ---
>>   include/linux/pagewalk.h | 34 ++++++++++++++++++++-----
>>   mm/hmm.c                 | 55 ++++++++++++++++++++++------------------
>>   mm/pagewalk.c            | 50 +++++++++++++++++++++++++-----------
>>   3 files changed, 94 insertions(+), 45 deletions(-)
>>
>> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
>> index 6ec82e92c87f..aa6a0b63964e 100644
>> --- a/include/linux/pagewalk.h
>> +++ b/include/linux/pagewalk.h
>> @@ -8,15 +8,15 @@ struct mm_walk;
>>     /**
>>    * mm_walk_ops - callbacks for walk_page_range
>> - * @pud_entry:        if set, called for each non-empty PUD
>> (2nd-level) entry
>> - *            this handler should only handle pud_trans_huge() puds.
>> - *            the pmd_entry or pte_entry callbacks will be used for
>> - *            regular PUDs.
>> - * @pmd_entry:        if set, called for each non-empty PMD
>> (3rd-level) entry
>> + * @pgd_entry:        if set, called for each non-empty PGD
>> (top-level) entry
>> + * @p4d_entry:        if set, called for each non-empty P4D entry
>> + * @pud_entry:        if set, called for each non-empty PUD entry
>> + * @pmd_entry:        if set, called for each non-empty PMD entry
>>    *            this handler is required to be able to handle
>>    *            pmd_trans_huge() pmds.  They may simply choose to
>>    *            split_huge_page() instead of handling it explicitly.
>> - * @pte_entry:        if set, called for each non-empty PTE
>> (4th-level) entry
>> + * @pte_entry:        if set, called for each non-empty PTE
>> (lowest-level)
>> + *            entry
>>    * @pte_hole:        if set, called for each hole at all levels
>>    * @hugetlb_entry:    if set, called for each hugetlb entry
>>    * @test_walk:        caller specific callback function to determine
>> whether
>> @@ -27,8 +27,15 @@ struct mm_walk;
>>    * @pre_vma:            if set, called before starting walk on a
>> non-null vma.
>>    * @post_vma:           if set, called after a walk on a non-null
>> vma, provided
>>    *                      that @pre_vma and the vma walk succeeded.
>> + *
>> + * p?d_entry callbacks are called even if those levels are folded on a
>> + * particular architecture/configuration.
>>    */
>>   struct mm_walk_ops {
>> +    int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
>> +             unsigned long next, struct mm_walk *walk);
>> +    int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
>> +             unsigned long next, struct mm_walk *walk);
>>       int (*pud_entry)(pud_t *pud, unsigned long addr,
>>                unsigned long next, struct mm_walk *walk);
>>       int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
>> @@ -47,11 +54,25 @@ struct mm_walk_ops {
>>       void (*post_vma)(struct mm_walk *walk);
>>   };
>>   +/*
>> + * Action for pud_entry / pmd_entry callbacks.
>> + * ACTION_SUBTREE is the default
>> + */
>> +enum page_walk_action {
>> +    /* Descend to next level, splitting huge pages if needed and
>> possible */
>> +    ACTION_SUBTREE = 0,
>> +    /* Continue to next entry at this level (ignoring any subtree) */
>> +    ACTION_CONTINUE = 1,
>> +    /* Call again for this entry */
>> +    ACTION_AGAIN = 2
>> +};
>> +
>>   /**
>>    * mm_walk - walk_page_range data
>>    * @ops:    operation to call during the walk
>>    * @mm:        mm_struct representing the target process of page
>> table walk
>>    * @vma:    vma currently walked (NULL if walking outside vmas)
>> + * @action:    next action to perform (see enum page_walk_action)
>>    * @private:    private data for callbacks' usage
>>    *
>>    * (see the comment on walk_page_range() for more details)
>> @@ -60,6 +81,7 @@ struct mm_walk {
>>       const struct mm_walk_ops *ops;
>>       struct mm_struct *mm;
>>       struct vm_area_struct *vma;
>> +    enum page_walk_action action;
>>       void *private;
>>   };
>>   diff --git a/mm/hmm.c b/mm/hmm.c
>> index d379cb6496ae..05241c82e05c 100644
>> --- a/mm/hmm.c
>> +++ b/mm/hmm.c
>> @@ -477,20 +477,30 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>> unsigned long start, unsigned long end,
>>       unsigned long addr = start, next;
>>       pmd_t *pmdp;
>>       pud_t pud;
>> -    int ret;
>> +    int ret = 0;
>> +    spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
>> +
>> +    if (!ptl)
>> +        return 0;
> 
> Since if we didn't get the PTL here, the pud might be unstable in which
> case we want to retry:
> 
> if (!ptl) {
>     if (pud_trans_unstable(pudp))
>         walk->action = ACTION_AGAIN;
>     return 0;
> }
> 
> 
>> +
>> +    /* Normally we don't want to split the huge page */
>> +    walk->action = ACTION_CONTINUE;
>>   -again:
>>       pud = READ_ONCE(*pudp);
> 
> We have the lock now, so READ_ONCE could probably be a simple dereference.
> 
>> -    if (pud_none(pud))
>> -        return hmm_vma_walk_hole(start, end, walk);
>> +    if (pud_none(pud)) {
>> +        ret = hmm_vma_walk_hole(start, end, walk);
>> +        goto out_unlock;
>> +    }
> 
> pud_trans_huge_lock() successful return means pud_none() is always false.
> 
> 
>>         if (pud_huge(pud) && pud_devmap(pud)) {
>>           unsigned long i, npages, pfn;
>>           uint64_t *pfns, cpu_flags;
>>           bool fault, write_fault;
>>   -        if (!pud_present(pud))
>> -            return hmm_vma_walk_hole(start, end, walk);
>> +        if (!pud_present(pud)) {
>> +            ret = hmm_vma_walk_hole(start, end, walk);
>> +            goto out_unlock;
>> +        }
> 
> Can't see !pud_present happening either after a succesful
> pud_trans_huge_lock().
> 
>>             i = (addr - range->start) >> PAGE_SHIFT;
>>           npages = (end - addr) >> PAGE_SHIFT;
>> @@ -499,16 +509,20 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>> unsigned long start, unsigned long end,
>>           cpu_flags = pud_to_hmm_pfn_flags(range, pud);
>>           hmm_range_need_fault(hmm_vma_walk, pfns, npages,
>>                        cpu_flags, &fault, &write_fault);
>> -        if (fault || write_fault)
>> -            return hmm_vma_walk_hole_(addr, end, fault,
>> -                        write_fault, walk);
>> +        if (fault || write_fault) {
>> +            ret = hmm_vma_walk_hole_(addr, end, fault,
>> +                         write_fault, walk);
>> +            goto out_unlock;
>> +        }
>>             pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>>           for (i = 0; i < npages; ++i, ++pfn) {
>>               hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
>>                             hmm_vma_walk->pgmap);
>> -            if (unlikely(!hmm_vma_walk->pgmap))
>> -                return -EBUSY;
>> +            if (unlikely(!hmm_vma_walk->pgmap)) {
>> +                ret = -EBUSY;
>> +                goto out_unlock;
>> +            }
>>               pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
>>                     cpu_flags;
>>           }
>> @@ -517,22 +531,15 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>> unsigned long start, unsigned long end,
>>               hmm_vma_walk->pgmap = NULL;
>>           }
>>           hmm_vma_walk->last = end;
>> -        return 0;
>> +        goto out_unlock;
>>       }
>>   -    split_huge_pud(walk->vma, pudp, addr);
>> -    if (pud_none(*pudp))
>> -        goto again;
>> +    /* Ask for the PUD to be split */
>> +    walk->action = ACTION_SUBTREE;
>>   -    pmdp = pmd_offset(pudp, addr);
>> -    do {
>> -        next = pmd_addr_end(addr, end);
>> -        ret = hmm_vma_walk_pmd(pmdp, addr, next, walk);
>> -        if (ret)
>> -            return ret;
>> -    } while (pmdp++, addr = next, addr != end);
>> -
>> -    return 0;
>> +out_unlock:
>> +    spin_unlock(ptl);
>> +    return ret;
>>   }
>>   #else
>>   #define hmm_vma_walk_pud    NULL
>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>> index ea0b9e606ad1..690af44609e2 100644
>> --- a/mm/pagewalk.c
>> +++ b/mm/pagewalk.c
>> @@ -46,6 +46,9 @@ static int walk_pmd_range(pud_t *pud, unsigned long
>> addr, unsigned long end,
>>                   break;
>>               continue;
>>           }
>> +
>> +        walk->action = ACTION_SUBTREE;
>> +
>>           /*
>>            * This implies that each ->pmd_entry() handler
>>            * needs to know about pmd_trans_huge() pmds
>> @@ -55,16 +58,21 @@ static int walk_pmd_range(pud_t *pud, unsigned
>> long addr, unsigned long end,
>>           if (err)
>>               break;
>>   +        if (walk->action == ACTION_AGAIN)
>> +            goto again;
>> +
>>           /*
>>            * Check this here so we only break down trans_huge
>>            * pages when we _need_ to
>>            */
>> -        if (!ops->pte_entry)
>> +        if (walk->action == ACTION_CONTINUE ||
>> +            !(ops->pte_entry))
>>               continue;
>>             split_huge_pmd(walk->vma, pmd, addr);
>>           if (pmd_trans_unstable(pmd))
>>               goto again;
>> +
>>           err = walk_pte_range(pmd, addr, next, walk);
>>           if (err)
>>               break;
>> @@ -93,24 +101,25 @@ static int walk_pud_range(p4d_t *p4d, unsigned
>> long addr, unsigned long end,
>>               continue;
>>           }
>>   -        if (ops->pud_entry) {
>> -            spinlock_t *ptl = pud_trans_huge_lock(pud, walk->vma);
>> +        walk->action = ACTION_SUBTREE;
>>   -            if (ptl) {
>> -                err = ops->pud_entry(pud, addr, next, walk);
>> -                spin_unlock(ptl);
>> -                if (err)
>> -                    break;
>> -                continue;
>> -            }
>> -        }
>> +        if (ops->pud_entry)
>> +            err = ops->pud_entry(pud, addr, next, walk);
>> +        if (err)
>> +            break;
>> +
>> +        if (walk->action == ACTION_AGAIN)
>> +            goto again;
>> +
>> +        if (walk->action == ACTION_CONTINUE ||
>> +            !(ops->pmd_entry || ops->pte_entry))
>> +            continue;
>>             split_huge_pud(walk->vma, pud, addr);
>>           if (pud_none(*pud))
> 
> Here we should really have
> 
> if (pud_trans_unstable(pud))
> 
> Thanks,
> 
> Thomas
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

