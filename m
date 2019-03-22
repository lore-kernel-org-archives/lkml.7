Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F807C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D5A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfCVKhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:37:20 -0400
Received: from foss.arm.com ([217.140.101.70]:41494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfCVKhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D55CB374;
        Fri, 22 Mar 2019 03:37:18 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5DB43F575;
        Fri, 22 Mar 2019 03:37:15 -0700 (PDT)
Subject: Re: [PATCH v5 10/19] mm: pagewalk: Add p4d_entry() and pgd_entry()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190321141953.31960-1-steven.price@arm.com>
 <20190321141953.31960-11-steven.price@arm.com>
 <20190321211510.GA27213@rapoport-lnx>
 <03f5ad0f-2450-c53f-b1e6-d2c0f2d4879c@arm.com>
 <20190322102930.GA24367@rapoport-lnx>
From:   Steven Price <steven.price@arm.com>
Message-ID: <f3ec9d74-f578-117a-6529-469089e46788@arm.com>
Date:   Fri, 22 Mar 2019 10:37:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322102930.GA24367@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 10:29, Mike Rapoport wrote:
> On Fri, Mar 22, 2019 at 10:11:59AM +0000, Steven Price wrote:
>> On 21/03/2019 21:15, Mike Rapoport wrote:
>>> On Thu, Mar 21, 2019 at 02:19:44PM +0000, Steven Price wrote:
>>>> pgd_entry() and pud_entry() were removed by commit 0b1fbfe50006c410
>>>> ("mm/pagewalk: remove pgd_entry() and pud_entry()") because there were
>>>> no users. We're about to add users so reintroduce them, along with
>>>> p4d_entry() as we now have 5 levels of tables.
>>>>
>>>> Note that commit a00cc7d9dd93d66a ("mm, x86: add support for
>>>> PUD-sized transparent hugepages") already re-added pud_entry() but with
>>>> different semantics to the other callbacks. Since there have never
>>>> been upstream users of this, revert the semantics back to match the
>>>> other callbacks. This means pud_entry() is called for all entries, not
>>>> just transparent huge pages.
>>>>
>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>> ---
>>>>  include/linux/mm.h |  9 ++++++---
>>>>  mm/pagewalk.c      | 27 ++++++++++++++++-----------
>>>>  2 files changed, 22 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 76769749b5a5..2983f2396a72 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -1367,10 +1367,9 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>>>>
>>>>  /**
>>>>   * mm_walk - callbacks for walk_page_range
>>>> + * @pgd_entry: if set, called for each non-empty PGD (top-level) entry
>>>> + * @p4d_entry: if set, called for each non-empty P4D (1st-level) entry
>>>
>>> IMHO, p4d implies the 4th level :)
>>
>> You have a good point there... I was simply working back from the
>> existing definitions (below) of PTE:4th, PMD:3rd, PUD:2nd. But it's
>> already somewhat broken by PGD:0th and my cop-out was calling it "top".
>>
>>> I think it would make more sense to start counting from PTE rather than
>>> from PGD. Then it would be consistent across architectures with fewer
>>> levels.
>>
>> It would also be the opposite way round to architectures such as Arm
>> which number their levels, for example [1] refers to levels 0-3 (with 3
>> being PTE in Linux terms).
> 
> By consistent I meant that for architectures with fewer levels we won't be
> describing PTE as level 4 when the architecture only has 2 levels.

Ah I see, although we've apparently been doing that for over a decade
already[2] :)

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e6473092bd9116583ce9ab8cf1b6570e1aa6fc83

>> [1]
>> https://developer.arm.com/docs/100940/latest/translation-tables-in-armv8-a
>>
>> Probably the least confusing thing is to drop the level numbers in
>> brackets since I don't believe they directly match any architecture, and
>> hopefully any user of the page walking code is already familiar with the
>> P?D terms used by the kernel.
> 
> That's a fair assumption :)
> Still, maybe we keep your (top-level) for PGD and use (lowest level) for
> PTE and drop those in the middle?

Yes that's a good compromise.

Thanks,

Steve
