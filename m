Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF484C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8B0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfGWJ5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:57:54 -0400
Received: from foss.arm.com ([217.140.110.172]:52008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbfGWJ5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:57:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D39B8337;
        Tue, 23 Jul 2019 02:57:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 639E93F71A;
        Tue, 23 Jul 2019 02:57:50 -0700 (PDT)
Date:   Tue, 23 Jul 2019 10:57:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 19/21] mm: Add generic ptdump
Message-ID: <20190723095747.GB8085@lakrids.cambridge.arm.com>
References: <20190722154210.42799-1-steven.price@arm.com>
 <20190722154210.42799-20-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722154210.42799-20-steven.price@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 04:42:08PM +0100, Steven Price wrote:
> Add a generic version of page table dumping that architectures can
> opt-in to
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

[...]

> +#ifdef CONFIG_KASAN
> +/*
> + * This is an optimization for KASAN=y case. Since all kasan page tables
> + * eventually point to the kasan_early_shadow_page we could call note_page()
> + * right away without walking through lower level page tables. This saves
> + * us dozens of seconds (minutes for 5-level config) while checking for
> + * W+X mapping or reading kernel_page_tables debugfs file.
> + */
> +static inline bool kasan_page_table(struct ptdump_state *st, void *pt,
> +				    unsigned long addr)
> +{
> +	if (__pa(pt) == __pa(kasan_early_shadow_pmd) ||
> +#ifdef CONFIG_X86
> +	    (pgtable_l5_enabled() &&
> +			__pa(pt) == __pa(kasan_early_shadow_p4d)) ||
> +#endif
> +	    __pa(pt) == __pa(kasan_early_shadow_pud)) {
> +		st->note_page(st, addr, 5, pte_val(kasan_early_shadow_pte[0]));
> +		return true;
> +	}
> +	return false;

Having you tried this with CONFIG_DEBUG_VIRTUAL?

The kasan_early_shadow_pmd is a kernel object rather than a linear map
object, so you should use __pa_symbol for that.

It's a bit horrid to have to test multiple levels in one function; can't
we check the relevant level inline in each of the test_p?d funcs?

They're optional anyway, so they only need to be defined for
CONFIG_KASAN.

Thanks,
Mark.

> +}
> +#else
> +static inline bool kasan_page_table(struct ptdump_state *st, void *pt,
> +				    unsigned long addr)
> +{
> +	return false;
> +}
> +#endif
> +
> +static int ptdump_test_p4d(unsigned long addr, unsigned long next,
> +			   p4d_t *p4d, struct mm_walk *walk)
> +{
> +	struct ptdump_state *st = walk->private;
> +
> +	if (kasan_page_table(st, p4d, addr))
> +		return 1;
> +	return 0;
> +}
> +static int ptdump_test_pud(unsigned long addr, unsigned long next,
> +			   pud_t *pud, struct mm_walk *walk)
> +{
> +	struct ptdump_state *st = walk->private;
> +
> +	if (kasan_page_table(st, pud, addr))
> +		return 1;
> +	return 0;
> +}
> +
> +static int ptdump_test_pmd(unsigned long addr, unsigned long next,
> +			   pmd_t *pmd, struct mm_walk *walk)
> +{
> +	struct ptdump_state *st = walk->private;
> +
> +	if (kasan_page_table(st, pmd, addr))
> +		return 1;
> +	return 0;
> +}
> +
> +static int ptdump_hole(unsigned long addr, unsigned long next,
> +		       struct mm_walk *walk)
> +{
> +	struct ptdump_state *st = walk->private;
> +
> +	st->note_page(st, addr, -1, 0);
> +
> +	return 0;
> +}
> +
> +void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm)
> +{
> +	struct mm_walk walk = {
> +		.mm		= mm,
> +		.pgd_entry	= ptdump_pgd_entry,
> +		.p4d_entry	= ptdump_p4d_entry,
> +		.pud_entry	= ptdump_pud_entry,
> +		.pmd_entry	= ptdump_pmd_entry,
> +		.pte_entry	= ptdump_pte_entry,
> +		.test_p4d	= ptdump_test_p4d,
> +		.test_pud	= ptdump_test_pud,
> +		.test_pmd	= ptdump_test_pmd,
> +		.pte_hole	= ptdump_hole,
> +		.private	= st
> +	};
> +	const struct ptdump_range *range = st->range;
> +
> +	down_read(&mm->mmap_sem);
> +	while (range->start != range->end) {
> +		walk_page_range(range->start, range->end, &walk);
> +		range++;
> +	}
> +	up_read(&mm->mmap_sem);
> +
> +	/* Flush out the last page */
> +	st->note_page(st, 0, 0, 0);
> +}
> -- 
> 2.20.1
> 
