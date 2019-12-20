Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9CBC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EAA24680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLTLsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:48:37 -0500
Received: from foss.arm.com ([217.140.110.172]:49838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfLTLsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:48:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8487B30E;
        Fri, 20 Dec 2019 03:48:36 -0800 (PST)
Received: from [10.1.194.52] (e112269-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3F1C3F719;
        Fri, 20 Dec 2019 03:48:33 -0800 (PST)
Subject: Re: [PATCH v17 01/23] mm: Add generic p?d_leaf() macros
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
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
 <20191218162402.45610-2-steven.price@arm.com>
 <878sn8mtgt.fsf@mpe.ellerman.id.au>
From:   Steven Price <steven.price@arm.com>
Message-ID: <0951d79f-919a-4a9d-00f7-b40be96af118@arm.com>
Date:   Fri, 20 Dec 2019 11:48:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <878sn8mtgt.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2019 11:43, Michael Ellerman wrote:
> Steven Price <steven.price@arm.com> writes:
>> Exposing the pud/pgd levels of the page tables to walk_page_range() means
>> we may come across the exotic large mappings that come with large areas
>> of contiguous memory (such as the kernel's linear map).
>>
>> For architectures that don't provide all p?d_leaf() macros, provide
>> generic do nothing default that are suitable where there cannot be leaf
>> pages at that level. Futher patches will add implementations for
>> individual architectures.
>>
>> The name p?d_leaf() is chosen to minimize the confusion with existing
>> uses of "large" pages and "huge" pages which do not necessary mean that
>> the entry is a leaf (for example it may be a set of contiguous entries
>> that only take 1 TLB slot). For the purpose of walking the page tables
>> we don't need to know how it will be represented in the TLB, but we do
>> need to know for sure if it is a leaf of the tree.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> ---
>>  include/asm-generic/pgtable.h | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
>> index 798ea36a0549..e2e2bef07dd2 100644
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -1238,4 +1238,24 @@ static inline bool arch_has_pfn_modify_check(void)
>>  #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
>>  #endif
>>  
>> +/*
>> + * p?d_leaf() - true if this entry is a final mapping to a physical address.
>> + * This differs from p?d_huge() by the fact that they are always available (if
>> + * the architecture supports large pages at the appropriate level) even
>> + * if CONFIG_HUGETLB_PAGE is not defined.
>> + * Only meaningful when called on a valid entry.
>> + */
>> +#ifndef pgd_leaf
>> +#define pgd_leaf(x)	0
>> +#endif
>> +#ifndef p4d_leaf
>> +#define p4d_leaf(x)	0
>> +#endif
>> +#ifndef pud_leaf
>> +#define pud_leaf(x)	0
>> +#endif
>> +#ifndef pmd_leaf
>> +#define pmd_leaf(x)	0
>> +#endif
> 
> Any reason you made these #defines rather than static inlines?

No strong reason - but these have to be #defines in the arch overrides
so the #ifndef works, so I was being consistent here. I guess a static
inline might avoid warnings although I haven't seen any.

Steve
