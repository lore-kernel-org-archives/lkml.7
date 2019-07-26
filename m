Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 04:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A962222BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 04:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfGZEqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 00:46:39 -0400
Received: from foss.arm.com ([217.140.110.172]:37798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGZEqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 00:46:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6593337;
        Thu, 25 Jul 2019 21:46:37 -0700 (PDT)
Received: from [10.163.1.197] (unknown [10.163.1.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CBE13F694;
        Thu, 25 Jul 2019 21:46:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
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
Message-ID: <c3bb0420-584c-de3b-2439-8702bc09595e@arm.com>
Date:   Fri, 26 Jul 2019 10:17:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190725143920.GW363@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2019 08:09 PM, Matthew Wilcox wrote:
> On Thu, Jul 25, 2019 at 12:25:23PM +0530, Anshuman Khandual wrote:
>> This adds a test module which will validate architecture page table helpers
>> and accessors regarding compliance with generic MM semantics expectations.
>> This will help various architectures in validating changes to the existing
>> page table helpers or addition of new ones.
> 
> I think this is a really good idea.
> 
>>  lib/Kconfig.debug       |  14 +++
>>  lib/Makefile            |   1 +
>>  lib/test_arch_pgtable.c | 290 ++++++++++++++++++++++++++++++++++++++++++++++++
> 
> Is this the right place for it?  I worry that lib/ is going to get overloaded
> with test code, and this feels more like mm/ test code.

Sure this can be moved to mm/ but unlike existing test configs there (following)
lets keep some config description in mm/Kconfig. Will probably rename this as
CONFIG_DEBUG_ARCH_PGTABLE_TEST to match other tests.

CONFIG_DEBUG_KMEMLEAK_TEST
CONFIG_DEBUG_RODATA_TEST
CONFIG_MEMTEST

After moving to mm/ directory I guess it does not need a loadable module option.

> 
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE
>> +static void pmd_basic_tests(void)
>> +{
>> +	pmd_t pmd;
>> +
>> +	pmd = mk_pmd(page, prot);
> 
> But 'page' isn't necessarily PMD-aligned.  I don't think we can rely on
> architectures doing the right thing if asked to make a PMD for a randomly
> aligned page.
> 
> How about finding the physical address of something like kernel_init(),

Physical address corresponding to the symbol in the kernel text segment ?

> and using the corresponding pte/pmd/pud/p4d/pgd that encompasses that

So I guess this will help us use pte/pmd/pud/p4d/pgd entries from a real and
present mapping rather then making them up for test purpose. Although we are
not creating real page tables here just wondering if this could some how
affect these real mapping in anyway from some accessors. The current proposal
stays clear from anything real - allocates, evaluates and releases.

Also table entries at pmd/pud/p4d/pgd cannot be operated with accessors in the
test. THP and PUD THP will operate on leaf entries at pmd or pud levels. We need
them as leaf entries created from allocated (aligned) pfns. While determining
pte/pmd/pud/p4d/pgd for kernel_init() some of them will be table entries.

> address?  It's also better to pass in the pfn/page rather than using global
> variables to communicate to the test functions.

Sure those can be allocated and passed from the main function. Just wanted to
avoid page allocation in each individual tests.

> 
>> +	/*
>> +	 * A huge page does not point to next level page table
>> +	 * entry. Hence this must qualify as pmd_bad().
>> +	 */
>> +	WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
> 
> I didn't know that rule.  This is helpful because it gives us somewhere
> to document all these tricksy little rules.

That is another objective this test has which will help settle semantics
in a clear and documented manner.

> 
>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>> +static void pud_basic_tests(void)
> 
> Is this the right ifdef?

IIUC THP at PUD is where the pud_t entries are directly operated upon and the
corresponding accessors are present only when HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
is enabled. Am I missing something here ?
