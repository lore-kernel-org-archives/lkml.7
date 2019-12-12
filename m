Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8023DC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD3C21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfLLNPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:15:35 -0500
Received: from foss.arm.com ([217.140.110.172]:46524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfLLNPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:15:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA36030E;
        Thu, 12 Dec 2019 05:15:32 -0800 (PST)
Received: from [10.37.9.115] (unknown [10.37.9.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7D53F718;
        Thu, 12 Dec 2019 05:15:28 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v16 11/25] mm: pagewalk: Add p4d_entry() and pgd_entry()
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Zong Li <zong.li@sifive.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
References: <20191206135316.47703-1-steven.price@arm.com>
 <20191206135316.47703-12-steven.price@arm.com>
 <13280f9e-6f03-e1fd-659a-31462ba185b0@shipmail.org>
 <7fd20e9f-822a-897d-218e-bddf135fd33d@shipmail.org>
Message-ID: <a5bb53f1-dd40-f32c-917b-a1ae1a49e5b2@arm.com>
Date:   Thu, 12 Dec 2019 13:15:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <7fd20e9f-822a-897d-218e-bddf135fd33d@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 11:33, Thomas Hellström (VMware) wrote:
> On 12/12/19 12:23 PM, Thomas Hellström (VMware) wrote:
>> On 12/6/19 2:53 PM, Steven Price wrote:
>>> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
>>> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
>>> no users. We're about to add users so reintroduce them, along with
>>> p4d_entry() as we now have 5 levels of tables.
>>>
>>> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
>>> PUD-sized transparent hugepages") already re-added pud_entry() but with
>>> different semantics to the other callbacks. Since there have never
>>> been upstream users of this, revert the semantics back to match the
>>> other callbacks. This means pud_entry() is called for all entries, not
>>> just transparent huge pages.

When I wrote that there were no upstream users, which sadly shows how
long ago that was :(

>> Actually, there are two users of pud_entry(), in hmm.c and since 
>> 5.5rc1 also mapping_dirty_helpers.c. The latter one is unproblematic 
>> and requires no attention but the one in hmm.c is probably largely 
>> untested, and seems to assume it was called outside of the spinlock.
>>
>> The problem with the current patch is that the hmm pud_entry will 
>> traverse also pmds, so that will be done twice now.
>>
>> In another thread we were discussing a means of rerunning the level 
>> (in case of a race), or continuing after a level, based on the return 
>> value after the callback. The change was fairly invasive,
>>
> Hmm. Forgot to remove the above text that appears twice. :(. The correct 
> one is inline below.
> 
>>
>>> Tested-by: Zong Li <zong.li@sifive.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> ---
>>>   include/linux/pagewalk.h | 19 +++++++++++++------
>>>   mm/pagewalk.c            | 27 ++++++++++++++++-----------
>>>   2 files changed, 29 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
>>> index 6ec82e92c87f..06790f23957f 100644
>>> --- a/include/linux/pagewalk.h
>>> +++ b/include/linux/pagewalk.h
>>> @@ -8,15 +8,15 @@ struct mm_walk;
>>>     /**
>>>    * mm_walk_ops - callbacks for walk_page_range
>>> - * @pud_entry:        if set, called for each non-empty PUD 
>>> (2nd-level) entry
>>> - *            this handler should only handle pud_trans_huge() puds.
>>> - *            the pmd_entry or pte_entry callbacks will be used for
>>> - *            regular PUDs.
>>> - * @pmd_entry:        if set, called for each non-empty PMD 
>>> (3rd-level) entry
>>> + * @pgd_entry:        if set, called for each non-empty PGD 
>>> (top-level) entry
>>> + * @p4d_entry:        if set, called for each non-empty P4D entry
>>> + * @pud_entry:        if set, called for each non-empty PUD entry
>>> + * @pmd_entry:        if set, called for each non-empty PMD entry
>>>    *            this handler is required to be able to handle
>>>    *            pmd_trans_huge() pmds.  They may simply choose to
>>>    *            split_huge_page() instead of handling it explicitly.
>>> - * @pte_entry:        if set, called for each non-empty PTE 
>>> (4th-level) entry
>>> + * @pte_entry:        if set, called for each non-empty PTE 
>>> (lowest-level)
>>> + *            entry
>>>    * @pte_hole:        if set, called for each hole at all levels
>>>    * @hugetlb_entry:    if set, called for each hugetlb entry
>>>    * @test_walk:        caller specific callback function to 
>>> determine whether
>>> @@ -27,8 +27,15 @@ struct mm_walk;
>>>    * @pre_vma:            if set, called before starting walk on a 
>>> non-null vma.
>>>    * @post_vma:           if set, called after a walk on a non-null 
>>> vma, provided
>>>    *                      that @pre_vma and the vma walk succeeded.
>>> + *
>>> + * p?d_entry callbacks are called even if those levels are folded on a
>>> + * particular architecture/configuration.
>>>    */
>>>   struct mm_walk_ops {
>>> +    int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
>>> +             unsigned long next, struct mm_walk *walk);
>>> +    int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
>>> +             unsigned long next, struct mm_walk *walk);
>>>       int (*pud_entry)(pud_t *pud, unsigned long addr,
>>>                unsigned long next, struct mm_walk *walk);
>>>       int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
>>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>>> index ea0b9e606ad1..c089786e7a7f 100644
>>> --- a/mm/pagewalk.c
>>> +++ b/mm/pagewalk.c
>>> @@ -94,15 +94,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned 
>>> long addr, unsigned long end,
>>>           }
>>>             if (ops->pud_entry) {
>>> -            spinlock_t *ptl = pud_trans_huge_lock(pud, walk->vma);
>>> -
>>> -            if (ptl) {
>>> -                err = ops->pud_entry(pud, addr, next, walk);
>>> -                spin_unlock(ptl);
>>> -                if (err)
>>> -                    break;
>>> -                continue;
>>> -            }
>>> +            err = ops->pud_entry(pud, addr, next, walk);
>>> +            if (err)
>>> +                break;
>>
>> Actually, there are two current users of pud_entry(), in hmm.c and 
>> since 5.5rc1 also mapping_dirty_helpers.c. The latter one is 
>> unproblematic and requires no attention but the one in hmm.c is 
>> probably largely untested, and seems to assume it was called outside 
>> of the spinlock.

Thanks for pointing that out, I guess the simplest fix would be to
squash in something like the below which should restore the old
behaviour for hmm.c without affecting others.

Steve

---8<----
diff --git a/mm/hmm.c b/mm/hmm.c
index d379cb6496ae..744b6644d0e4 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -478,19 +478,26 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
  	pmd_t *pmdp;
  	pud_t pud;
  	int ret;
+	spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
+	if (!ptl)
+		return 0;
  
  again:
  	pud = READ_ONCE(*pudp);
-	if (pud_none(pud))
-		return hmm_vma_walk_hole(start, end, walk);
+	if (pud_none(pud)) {
+		ret = hmm_vma_walk_hole(start, end, walk);
+		goto out_unlock;
+	}
  
  	if (pud_huge(pud) && pud_devmap(pud)) {
  		unsigned long i, npages, pfn;
  		uint64_t *pfns, cpu_flags;
  		bool fault, write_fault;
  
-		if (!pud_present(pud))
-			return hmm_vma_walk_hole(start, end, walk);
+		if (!pud_present(pud)) {
+			ret = hmm_vma_walk_hole(start, end, walk);
+			goto out_unlock;
+		}
  
  		i = (addr - range->start) >> PAGE_SHIFT;
  		npages = (end - addr) >> PAGE_SHIFT;
@@ -499,16 +506,20 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
  		cpu_flags = pud_to_hmm_pfn_flags(range, pud);
  		hmm_range_need_fault(hmm_vma_walk, pfns, npages,
  				     cpu_flags, &fault, &write_fault);
-		if (fault || write_fault)
-			return hmm_vma_walk_hole_(addr, end, fault,
-						write_fault, walk);
+		if (fault || write_fault) {
+			ret = hmm_vma_walk_hole_(addr, end, fault,
+						 write_fault, walk);
+			goto out_unlock;
+		}
  
  		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
  		for (i = 0; i < npages; ++i, ++pfn) {
  			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
  					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap))
-				return -EBUSY;
+			if (unlikely(!hmm_vma_walk->pgmap)) {
+				ret = -EBUSY;
+				goto out_unlock;
+			}
  			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
  				  cpu_flags;
  		}
@@ -517,7 +528,8 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
  			hmm_vma_walk->pgmap = NULL;
  		}
  		hmm_vma_walk->last = end;
-		return 0;
+		ret = 0;
+		goto out_unlock;
  	}
  
  	split_huge_pud(walk->vma, pudp, addr);
@@ -529,10 +541,14 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
  		next = pmd_addr_end(addr, end);
  		ret = hmm_vma_walk_pmd(pmdp, addr, next, walk);
  		if (ret)
-			return ret;
+			goto out_unlock;
  	} while (pmdp++, addr = next, addr != end);
  
-	return 0;
+	ret = 0;
+
+out_unlock:
+	spin_unlock(ptl);
+	return ret;
  }
  #else
  #define hmm_vma_walk_pud	NULL
