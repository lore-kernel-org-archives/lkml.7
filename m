Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C05C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034F4206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfG2IcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:32:16 -0400
Received: from foss.arm.com ([217.140.110.172]:39908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfG2IcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:32:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9CDF337;
        Mon, 29 Jul 2019 01:32:15 -0700 (PDT)
Received: from [10.162.40.126] (p8cg001049571a15.blr.arm.com [10.162.40.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 990293F575;
        Mon, 29 Jul 2019 01:32:11 -0700 (PDT)
Subject: Re: [RFC] mm/pgtable/debug: Add test validating architecture page
 table helpers
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <Mark.Brown@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1564037723-26676-1-git-send-email-anshuman.khandual@arm.com>
 <1564037723-26676-2-git-send-email-anshuman.khandual@arm.com>
 <20190725143920.GW363@bombadil.infradead.org>
 <c3bb0420-584c-de3b-2439-8702bc09595e@arm.com>
 <20190726195457.GI30641@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <10ed1022-a5c0-c80c-c0c9-025bb2307666@arm.com>
Date:   Mon, 29 Jul 2019 14:02:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190726195457.GI30641@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2019 01:24 AM, Matthew Wilcox wrote:
> On Fri, Jul 26, 2019 at 10:17:11AM +0530, Anshuman Khandual wrote:
>>> But 'page' isn't necessarily PMD-aligned.  I don't think we can rely on
>>> architectures doing the right thing if asked to make a PMD for a randomly
>>> aligned page.
>>>
>>> How about finding the physical address of something like kernel_init(),
>>
>> Physical address corresponding to the symbol in the kernel text segment ?
> 
> Yes.  We need the address of something that's definitely memory.
> The stack might be in vmalloc space.  We can't allocate memory from the
> allocator that's PUD-aligned.  This seems like a reasonable approximation
> to something that might work.

Okay sure. What is about vmalloc space being PUD aligned and how that is
problematic here ? Could you please give some details. Just being curious.

> 
>>> and using the corresponding pte/pmd/pud/p4d/pgd that encompasses that
>>
>> So I guess this will help us use pte/pmd/pud/p4d/pgd entries from a real and
>> present mapping rather then making them up for test purpose. Although we are
>> not creating real page tables here just wondering if this could some how
>> affect these real mapping in anyway from some accessors. The current proposal
>> stays clear from anything real - allocates, evaluates and releases.
> 
> I think that's a mistake.  As Russell said, the ARM p*d manipulation
> functions expect to operate on tables, not on individual entries
> constructed on the stack.

Hmm. I assume that it will take care of dual 32 bit entry updates on arm
platform through various helper functions as Russel had mentioned earlier.
After we create page table with p?d_alloc() functions and pick an entry at
each page table level.

> 
> So I think the right thing to do here is allocate an mm, then do the
> pgd_alloc / p4d_alloc / pud_alloc / pmd_alloc / pte_alloc() steps giving
> you real page tables that you can manipulate.
> 
> Then destroy them, of course.  And don't access through them.

mm_alloc() seems like a comprehensive helper to allocate and initialize a
mm_struct. But could we use mm_init() with 'current' in the driver context or we
need to create a dummy task_struct for this purpose. Some initial tests show that
p?d_alloc() and p?d_free() at each level with a fixed virtual address gives p?d_t
entries required at various page table level to test upon.

> 
>>>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>>> +static void pud_basic_tests(void)
>>>
>>> Is this the right ifdef?
>>
>> IIUC THP at PUD is where the pud_t entries are directly operated upon and the
>> corresponding accessors are present only when HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> is enabled. Am I missing something here ?
> 
> Maybe I am.  I thought we could end up operating on PUDs for kernel mappings,
> even without transparent hugepages turned on.

In generic MM ? IIUC except ioremap mapping all other PUD handling for kernel virtual
range is platform specific. All the helpers used in the function pud_basic_tests() are
part of THP and used in mm/huge_memory.c
