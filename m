Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92B3C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9055D216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfG1Nk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:40:27 -0400
Received: from foss.arm.com ([217.140.110.172]:32796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfG1Nk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:40:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2389C344;
        Sun, 28 Jul 2019 06:40:26 -0700 (PDT)
Received: from [10.163.1.126] (unknown [10.163.1.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD10B3F71A;
        Sun, 28 Jul 2019 06:40:19 -0700 (PDT)
Subject: Re: [PATCH v9 13/21] mm: pagewalk: Add test_p?d callbacks
To:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-14-steven.price@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b74e545f-cbe0-9dd0-004c-5919e5cabb6f@arm.com>
Date:   Sun, 28 Jul 2019 19:11:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190722154210.42799-14-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/22/2019 09:12 PM, Steven Price wrote:
> It is useful to be able to skip parts of the page table tree even when
> walking without VMAs. Add test_p?d callbacks similar to test_walk but
> which are called just before a table at that level is walked. If the
> callback returns non-zero then the entire table is skipped.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  include/linux/mm.h | 11 +++++++++++
>  mm/pagewalk.c      | 24 ++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b22799129128..325a1ca6f820 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1447,6 +1447,11 @@ void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>   *             value means "do page table walk over the current vma,"
>   *             and a negative one means "abort current page table walk
>   *             right now." 1 means "skip the current vma."
> + * @test_pmd:  similar to test_walk(), but called for every pmd.
> + * @test_pud:  similar to test_walk(), but called for every pud.
> + * @test_p4d:  similar to test_walk(), but called for every p4d.
> + *             Returning 0 means walk this part of the page tables,
> + *             returning 1 means to skip this range.
>   * @mm:        mm_struct representing the target process of page table walk
>   * @vma:       vma currently walked (NULL if walking outside vmas)
>   * @private:   private data for callbacks' usage
> @@ -1471,6 +1476,12 @@ struct mm_walk {
>  			     struct mm_walk *walk);
>  	int (*test_walk)(unsigned long addr, unsigned long next,
>  			struct mm_walk *walk);
> +	int (*test_pmd)(unsigned long addr, unsigned long next,
> +			pmd_t *pmd_start, struct mm_walk *walk);
> +	int (*test_pud)(unsigned long addr, unsigned long next,
> +			pud_t *pud_start, struct mm_walk *walk);
> +	int (*test_p4d)(unsigned long addr, unsigned long next,
> +			p4d_t *p4d_start, struct mm_walk *walk);
>  	struct mm_struct *mm;
>  	struct vm_area_struct *vma;
>  	void *private;
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 1cbef99e9258..6bea79b95be3 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -32,6 +32,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  	unsigned long next;
>  	int err = 0;
>  
> +	if (walk->test_pmd) {
> +		err = walk->test_pmd(addr, end, pmd_offset(pud, 0UL), walk);
> +		if (err < 0)
> +			return err;
> +		if (err > 0)
> +			return 0;
> +	}

Though this attempts to match semantics with test_walk() and be comprehensive
just wondering what are the real world situations when page walking need to be
aborted based on error condition at a given page table level.
