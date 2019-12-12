Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1BC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CB821655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="DzhFO2Cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfLLOEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:04:42 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:57540 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfLLOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:04:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id F285A3F6E0;
        Thu, 12 Dec 2019 15:04:38 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=DzhFO2Cz;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q3s48xuWPFsv; Thu, 12 Dec 2019 15:04:33 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 2F78D3F617;
        Thu, 12 Dec 2019 15:04:30 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 13DC43621B7;
        Thu, 12 Dec 2019 15:04:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1576159470; bh=+81VifpPufQx1Ghf7UgamHghIAtblxqdt1z4rpeKwjw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DzhFO2Czsj4dlxMRNekZ5HARyubeVf/Z0IFsk9SHs7ghuuNJfX/lCADJRkbNKu9Xc
         chbNsFXIChLsKn2EMmrTWPks59Fk6Fc5P78vIRgrPvZQpWVKd2JOGzA2NNOUv4e8Ig
         IMiWhXAy3y1WXfta2R8hBYxsV4ji02fQFhFx/csY=
Subject: Re: [PATCH v16 11/25] mm: pagewalk: Add p4d_entry() and pgd_entry()
To:     Steven Price <steven.price@arm.com>
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
 <a5bb53f1-dd40-f32c-917b-a1ae1a49e5b2@arm.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <16b2ecbc-316a-33f8-ace2-e54cd8001b24@shipmail.org>
Date:   Thu, 12 Dec 2019 15:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a5bb53f1-dd40-f32c-917b-a1ae1a49e5b2@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 2:15 PM, Steven Price wrote:
> On 12/12/2019 11:33, Thomas Hellström (VMware) wrote:
>> On 12/12/19 12:23 PM, Thomas Hellström (VMware) wrote:
>>> On 12/6/19 2:53 PM, Steven Price wrote:
>>>> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
>>>> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
>>>> no users. We're about to add users so reintroduce them, along with
>>>> p4d_entry() as we now have 5 levels of tables.
>>>>
>>>> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
>>>> PUD-sized transparent hugepages") already re-added pud_entry() but 
>>>> with
>>>> different semantics to the other callbacks. Since there have never
>>>> been upstream users of this, revert the semantics back to match the
>>>> other callbacks. This means pud_entry() is called for all entries, not
>>>> just transparent huge pages.
>
> When I wrote that there were no upstream users, which sadly shows how
> long ago that was :(
>
>>> Actually, there are two users of pud_entry(), in hmm.c and since 
>>> 5.5rc1 also mapping_dirty_helpers.c. The latter one is unproblematic 
>>> and requires no attention but the one in hmm.c is probably largely 
>>> untested, and seems to assume it was called outside of the spinlock.
>>>
>>> The problem with the current patch is that the hmm pud_entry will 
>>> traverse also pmds, so that will be done twice now.
>>>
>>> In another thread we were discussing a means of rerunning the level 
>>> (in case of a race), or continuing after a level, based on the 
>>> return value after the callback. The change was fairly invasive,
>>>
>> Hmm. Forgot to remove the above text that appears twice. :(. The 
>> correct one is inline below.
>>
>>>
>>>> Tested-by: Zong Li <zong.li@sifive.com>
>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>> ---
>>>>   include/linux/pagewalk.h | 19 +++++++++++++------
>>>>   mm/pagewalk.c            | 27 ++++++++++++++++-----------
>>>>   2 files changed, 29 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
>>>> index 6ec82e92c87f..06790f23957f 100644
>>>> --- a/include/linux/pagewalk.h
>>>> +++ b/include/linux/pagewalk.h
>>>> @@ -8,15 +8,15 @@ struct mm_walk;
>>>>     /**
>>>>    * mm_walk_ops - callbacks for walk_page_range
>>>> - * @pud_entry:        if set, called for each non-empty PUD 
>>>> (2nd-level) entry
>>>> - *            this handler should only handle pud_trans_huge() puds.
>>>> - *            the pmd_entry or pte_entry callbacks will be used for
>>>> - *            regular PUDs.
>>>> - * @pmd_entry:        if set, called for each non-empty PMD 
>>>> (3rd-level) entry
>>>> + * @pgd_entry:        if set, called for each non-empty PGD 
>>>> (top-level) entry
>>>> + * @p4d_entry:        if set, called for each non-empty P4D entry
>>>> + * @pud_entry:        if set, called for each non-empty PUD entry
>>>> + * @pmd_entry:        if set, called for each non-empty PMD entry
>>>>    *            this handler is required to be able to handle
>>>>    *            pmd_trans_huge() pmds.  They may simply choose to
>>>>    *            split_huge_page() instead of handling it explicitly.
>>>> - * @pte_entry:        if set, called for each non-empty PTE 
>>>> (4th-level) entry
>>>> + * @pte_entry:        if set, called for each non-empty PTE 
>>>> (lowest-level)
>>>> + *            entry
>>>>    * @pte_hole:        if set, called for each hole at all levels
>>>>    * @hugetlb_entry:    if set, called for each hugetlb entry
>>>>    * @test_walk:        caller specific callback function to 
>>>> determine whether
>>>> @@ -27,8 +27,15 @@ struct mm_walk;
>>>>    * @pre_vma:            if set, called before starting walk on a 
>>>> non-null vma.
>>>>    * @post_vma:           if set, called after a walk on a non-null 
>>>> vma, provided
>>>>    *                      that @pre_vma and the vma walk succeeded.
>>>> + *
>>>> + * p?d_entry callbacks are called even if those levels are folded 
>>>> on a
>>>> + * particular architecture/configuration.
>>>>    */
>>>>   struct mm_walk_ops {
>>>> +    int (*pgd_entry)(pgd_t *pgd, unsigned long addr,
>>>> +             unsigned long next, struct mm_walk *walk);
>>>> +    int (*p4d_entry)(p4d_t *p4d, unsigned long addr,
>>>> +             unsigned long next, struct mm_walk *walk);
>>>>       int (*pud_entry)(pud_t *pud, unsigned long addr,
>>>>                unsigned long next, struct mm_walk *walk);
>>>>       int (*pmd_entry)(pmd_t *pmd, unsigned long addr,
>>>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
>>>> index ea0b9e606ad1..c089786e7a7f 100644
>>>> --- a/mm/pagewalk.c
>>>> +++ b/mm/pagewalk.c
>>>> @@ -94,15 +94,9 @@ static int walk_pud_range(p4d_t *p4d, unsigned 
>>>> long addr, unsigned long end,
>>>>           }
>>>>             if (ops->pud_entry) {
>>>> -            spinlock_t *ptl = pud_trans_huge_lock(pud, walk->vma);
>>>> -
>>>> -            if (ptl) {
>>>> -                err = ops->pud_entry(pud, addr, next, walk);
>>>> -                spin_unlock(ptl);
>>>> -                if (err)
>>>> -                    break;
>>>> -                continue;
>>>> -            }
>>>> +            err = ops->pud_entry(pud, addr, next, walk);
>>>> +            if (err)
>>>> +                break;
>>>
>>> Actually, there are two current users of pud_entry(), in hmm.c and 
>>> since 5.5rc1 also mapping_dirty_helpers.c. The latter one is 
>>> unproblematic and requires no attention but the one in hmm.c is 
>>> probably largely untested, and seems to assume it was called outside 
>>> of the spinlock.
>
> Thanks for pointing that out, I guess the simplest fix would be to
> squash in something like the below which should restore the old
> behaviour for hmm.c without affecting others.
>
> Steve 

I'm not fully sure that the old behaviour is the correct one, but definitely hmm's pud_entry needs some fixing.
I'm more concerned with the pagewalk code. With your patch it actually splits all huge puds present in the page-table
on each page walk which is not what we want.

One idea would be to add a new member to struct_mm_walk:

enum page_walk_ret_action {
	ACTION_SUBTREE = 0,
	ACTION_CONTINUE = 1,
	ACTION_AGAIN = 2 /* Only for levels that thave p?d_unstable */
};

struct mm_walk {
	...
	enum page_walk_ret_action action; /* or perhaps as an enum */
};


if (ops->pud_entry) {
	walk->action = ACTION_SUBTREE;
	...
	...
	...
	if (walk->action == ACTION_AGAIN)  /* Callback tried to split huge entry, but failed */
		goto again;
	else if (walk->action == ACTION_CONTINUE) /* Done with this subtree. Probably huge entry handled. */
		continue;
	/* ACTION_SUBTREE falls through */
}

we discussed something similar before on linux-mm, but the idea then was to redefine
the positive return value of the callback to the action, but that meant changing those existing callbacks that relied on
a positive return value. The above would be helpful also for pmd_entry.

/Thomas




