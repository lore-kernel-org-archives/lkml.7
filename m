Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CB1C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3779C214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfGXNsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:48:19 -0400
Received: from foss.arm.com ([217.140.110.172]:41130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfGXNsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:48:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6868828;
        Wed, 24 Jul 2019 06:48:17 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85F23F71A;
        Wed, 24 Jul 2019 06:48:14 -0700 (PDT)
Subject: Re: [PATCH v9 10/21] mm: Add generic p?d_leaf() macros
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-11-steven.price@arm.com>
 <20190723094113.GA8085@lakrids.cambridge.arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <4366c0d8-6175-88d0-8cf2-938dff56f1ac@arm.com>
Date:   Wed, 24 Jul 2019 14:48:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723094113.GA8085@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 10:41, Mark Rutland wrote:
> On Mon, Jul 22, 2019 at 04:41:59PM +0100, Steven Price wrote:
>> Exposing the pud/pgd levels of the page tables to walk_page_range() means
>> we may come across the exotic large mappings that come with large areas
>> of contiguous memory (such as the kernel's linear map).
>>
>> For architectures that don't provide all p?d_leaf() macros, provide
>> generic do nothing default that are suitable where there cannot be leaf
>> pages that that level.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> Not a big deal, but it would probably make sense for this to be patch 1
> in the series, given it defines the semantic of p?d_leaf(), and they're
> not used until we provide all the architectural implemetnations anyway.

Sure, I'll move it. When it was named p?d_large() this had to come after
some architectures that implement p?d_large() as static inline. But
p?d_leaf() doesn't have that issue.

> It might also be worth pointing out the reasons for this naming, e.g.
> p?d_large() aren't currently generic, and this name minimizes potential
> confusion between p?d_{large,huge}().

Ok, how about:

The name p?d_leaf() is chosen because to minimize the confusion with
existing uses of "large" pages and "huge" pages which do not necessary
mean that the entry is a leaf (for example it may be a set of contiguous
entries that only take 1 TLB slot). For the purpose of walking the page
tables we don't need to know how it will be represented in the TLB, but
we do need to know for sure if it is a leaf of the tree.

>> ---
>>  include/asm-generic/pgtable.h | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>> index 75d9d68a6de7..46275896ca66 100644
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -1188,4 +1188,23 @@ static inline bool arch_has_pfn_modify_check(void)
>>  #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>>  #endif
>>  
>> +/*
>> + * p?d_leaf() - true if this entry is a final mapping to a physical address.
>> + * This differs from p?d_huge() by the fact that they are always available (if
>> + * the architecture supports large pages at the appropriate level) even
>> + * if CONFIG_HUGETLB_PAGE is not defined.
>> + */
> 
> I assume it's only safe to call these on valid entries? I think it would
> be worth calling that out explicitly.

Yes only meaningful on valid entries - I'll add that as a comment.

> Otherwise, this looks sound to me:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks for the review

Steve
