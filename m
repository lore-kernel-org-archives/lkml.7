Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184B1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE12205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfLLPSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:18:41 -0500
Received: from foss.arm.com ([217.140.110.172]:50346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbfLLPSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:18:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A6530E;
        Thu, 12 Dec 2019 07:18:40 -0800 (PST)
Received: from [10.37.9.115] (unknown [10.37.9.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB9B63F6CF;
        Thu, 12 Dec 2019 07:18:35 -0800 (PST)
Subject: Re: [PATCH v16 11/25] mm: pagewalk: Add p4d_entry() and pgd_entry()
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Zong Li <zong.li@sifive.com>, "H. Peter Anvin" <hpa@zytor.com>,
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
 <a5bb53f1-dd40-f32c-917b-a1ae1a49e5b2@arm.com>
 <16b2ecbc-316a-33f8-ace2-e54cd8001b24@shipmail.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2cef327b-a16b-f76d-4c3f-bd894332c736@arm.com>
Date:   Thu, 12 Dec 2019 15:18:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <16b2ecbc-316a-33f8-ace2-e54cd8001b24@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 14:04, Thomas Hellström (VMware) wrote:
> On 12/12/19 2:15 PM, Steven Price wrote:
>> On 12/12/2019 11:33, Thomas Hellström (VMware) wrote:
>>> On 12/12/19 12:23 PM, Thomas Hellström (VMware) wrote:
>>>> On 12/6/19 2:53 PM, Steven Price wrote:
>>>>> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
>>>>> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
>>>>> no users. We're about to add users so reintroduce them, along with
>>>>> p4d_entry() as we now have 5 levels of tables.
>>>>>
>>>>> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
>>>>> PUD-sized transparent hugepages") already re-added pud_entry() but with
>>>>> different semantics to the other callbacks. Since there have never
>>>>> been upstream users of this, revert the semantics back to match the
>>>>> other callbacks. This means pud_entry() is called for all entries, not
>>>>> just transparent huge pages.
>>
>> When I wrote that there were no upstream users, which sadly shows how
>> long ago that was :(
>>
>>>> Actually, there are two users of pud_entry(), in hmm.c and since 5.5rc1 also mapping_dirty_helpers.c. The latter one is unproblematic and requires no attention but the one in hmm.c is probably largely untested, and seems to assume it was called outside of the spinlock.
>>>>
>>>> The problem with the current patch is that the hmm pud_entry will traverse also pmds, so that will be done twice now.
>>>>
>>>> In another thread we were discussing a means of rerunning the level (in case of a race), or continuing after a level, based on the return value after the callback. The change was fairly invasive,
>>>>
>>> Hmm. Forgot to remove the above text that appears twice. :(. The correct one is inline below.
>>>
>>>>
>>>>> Tested-by: Zong Li <zong.li@sifive.com>
>>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>>> ---
>>>>>   include/linux/pagewalk.h | 19 +++++++++++++------
>>>>>   mm/pagewalk.c            | 27 ++++++++++++++++-----------
>>>>>   2 files changed, 29 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
>>>>> index 6ec82e92c87f..06790f23957f 100644
>>>>> --- a/include/linux/pagewalk.h
>>>>> +++ b/include/linux/pagewalk.h
>>>>> @@ -8,15 +8,15 @@ struct mm_walk;
>>>>>     /**
>>>>>    * mm_walk_ops - callbacks for walk_page_range
>>>>> - * @pud_entry:        if set, called for each non-empty PUD (2nd-level) entry
>>>>> - *            this handler should only handle pud_trans_huge() puds.
>>>>> - *            the pmd_entry or pte_entry callbacks will be used for
>>>>> - *            regular PUDs.
>>>>> - * @pmd_entry:        if set, called for each non-empty PMD (3rd-level) entry
>>>>> + * @pgd_entry:        if set, called for each non-empty PGD (top-level) entry
>>>>> + * @p4d_entry:        if set, called for each non-empty P4D entry
>>>>> + * @pud_entry:        if set, called for each non-empty PUD entry
>>>>> + * @pmd_entry:        if set, called for each non-empty PMD entry
>>>>>    *            this handler is required to be able to handle
>>>>>    *            pmd_trans_huge() pmds.  They may simply choose to
>>>>>    *            split_huge_page() instead of handling it explicitly.
>>>>> - * @pte_entry:        if set, called for each non-empty PTE (4th-level) entry
>>>>> + * @pte_entry:        if set, called for each non-empty PTE (lowest-level)
>>>>> + *            entry
>>>>>    * @pte_hole:        if set, called for each hole at all levels
>>>>>    * @hugetlb_entry:    if set, called for each hugetlb entry
>>>>>    * @test_walk:        caller specific callback function to determine whether
>>>>> @@ -27,8 +27,15 @@ struct mm_walk;
>>>>>    * @pre_vma:            if set, called before starting walk on a non-null vma.
>>>>>    * @post_vma:           if set, called after a walk on a non-null vma, provided
>>>>>    *                      that @pre_vma and the vma walk succeeded.
>>>>> + *
>>>>> + * p?d_entry callbacks are called even if those levels are folded on a
>>>>> + * particular architecture/configuration.
>>>>>    */
>>>>>   struct mm_walk_ops {
>>>>> +    int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
>>>>> +             unsigned long next, struct mm_walk *walk);
>>>>> +    int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
>>>>> +             unsigned long next, struct mm_walk *walk);
>>>>>       int (*pud_entry)(pud_t *pud, unsigned long addr,
>>>>>                unsigned long next, struct mm_walk *walk);
>>>>>       int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
>>>>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>>>>> index ea0b9e606ad1..c089786e7a7f 100644
>>>>> --- a/mm/pagewalk.c
>>>>> +++ b/mm/pagewalk.c
>>>>> @@ -94,15 +94,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>>>>>           }
>>>>>             if (ops->pud_entry) {
>>>>> -            spinlock_t *ptl = pud_trans_huge_lock(pud, walk->vma);
>>>>> -
>>>>> -            if (ptl) {
>>>>> -                err = ops->pud_entry(pud, addr, next, walk);
>>>>> -                spin_unlock(ptl);
>>>>> -                if (err)
>>>>> -                    break;
>>>>> -                continue;
>>>>> -            }
>>>>> +            err = ops->pud_entry(pud, addr, next, walk);
>>>>> +            if (err)
>>>>> +                break;
>>>>
>>>> Actually, there are two current users of pud_entry(), in hmm.c and since 5.5rc1 also mapping_dirty_helpers.c. The latter one is unproblematic and requires no attention but the one in hmm.c is probably largely untested, and seems to assume it was called outside of the spinlock.
>>
>> Thanks for pointing that out, I guess the simplest fix would be to
>> squash in something like the below which should restore the old
>> behaviour for hmm.c without affecting others.
>>
>> Steve 
> 
> I'm not fully sure that the old behaviour is the correct one, but definitely hmm's pud_entry needs some fixing.
> I'm more concerned with the pagewalk code. With your patch it actually splits all huge puds present in the page-table
> on each page walk which is not what we want.

Good catch - yes that's certainly not ideal.

> One idea would be to add a new member to struct_mm_walk:
> 
> enum page_walk_ret_action {
>      ACTION_SUBTREE = 0,
>      ACTION_CONTINUE = 1,
>      ACTION_AGAIN = 2 /* Only for levels that thave p?d_unstable */
> };
> 
> struct mm_walk {
>      ...
>      enum page_walk_ret_action action; /* or perhaps as an enum */
> };
> 
> 
> if (ops->pud_entry) {
>      walk->action = ACTION_SUBTREE;
>      ...
>      ...
>      ...
>      if (walk->action == ACTION_AGAIN)  /* Callback tried to split huge entry, but failed */
>          goto again;
>      else if (walk->action == ACTION_CONTINUE) /* Done with this subtree. Probably huge entry handled. */
>          continue;
>      /* ACTION_SUBTREE falls through */
> }

I'll have a go at implementing the above - this might also allow removing the test_p?d() callbacks as they can simply return ACTION_CONTINUE.

Steve

> we discussed something similar before on linux-mm, but the idea then was to redefine
> the positive return value of the callback to the action, but that meant changing those existing callbacks that relied on
> a positive return value. The above would be helpful also for pmd_entry.
> 
> /Thomas
> 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

