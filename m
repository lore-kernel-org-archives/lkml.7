Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF4AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAAC2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfJJLfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:35:09 -0400
Received: from foss.arm.com ([217.140.110.172]:57414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfJJLfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:35:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5983E28;
        Thu, 10 Oct 2019 04:35:08 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 776873F68E;
        Thu, 10 Oct 2019 04:35:05 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:34:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, mark.rutland@arm.com, david@redhat.com,
        cai@lca.pw, logang@deltatee.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com, steve.capper@arm.com, broonie@kernel.org,
        valentin.schneider@arm.com, Robin.Murphy@arm.com,
        steven.price@arm.com, suzuki.poulose@arm.com, ira.weiny@intel.com
Subject: Re: [PATCH V9 2/2] arm64/mm: Enable memory hot remove
Message-ID: <20191010113433.GI28269@mbp>
References: <1570609308-15697-1-git-send-email-anshuman.khandual@arm.com>
 <1570609308-15697-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570609308-15697-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Wed, Oct 09, 2019 at 01:51:48PM +0530, Anshuman Khandual wrote:
> +static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
> +				    unsigned long end, bool free_mapped)
> +{
> +	unsigned long next;
> +	pmd_t *pmdp, pmd;
> +
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		pmdp = pmd_offset(pudp, addr);
> +		pmd = READ_ONCE(*pmdp);
> +		if (pmd_none(pmd))
> +			continue;
> +
> +		WARN_ON(!pmd_present(pmd));
> +		if (pmd_sect(pmd)) {
> +			pmd_clear(pmdp);
> +			flush_tlb_kernel_range(addr, next);

The range here could be a whole PMD_SIZE. Since we are invalidating a
single block entry, one TLBI should be sufficient:

			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

> +			if (free_mapped)
> +				free_hotplug_page_range(pmd_page(pmd),
> +							PMD_SIZE);
> +			continue;
> +		}
> +		WARN_ON(!pmd_table(pmd));
> +		unmap_hotplug_pte_range(pmdp, addr, next, free_mapped);
> +	} while (addr = next, addr < end);
> +}
> +
> +static void unmap_hotplug_pud_range(pgd_t *pgdp, unsigned long addr,
> +				    unsigned long end, bool free_mapped)
> +{
> +	unsigned long next;
> +	pud_t *pudp, pud;
> +
> +	do {
> +		next = pud_addr_end(addr, end);
> +		pudp = pud_offset(pgdp, addr);
> +		pud = READ_ONCE(*pudp);
> +		if (pud_none(pud))
> +			continue;
> +
> +		WARN_ON(!pud_present(pud));
> +		if (pud_sect(pud)) {
> +			pud_clear(pudp);
> +			flush_tlb_kernel_range(addr, next);
			^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

[...]
> +static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
> +				 unsigned long end, unsigned long floor,
> +				 unsigned long ceiling)
> +{
> +	pte_t *ptep, pte;
> +	unsigned long i, start = addr;
> +
> +	do {
> +		ptep = pte_offset_kernel(pmdp, addr);
> +		pte = READ_ONCE(*ptep);
> +		WARN_ON(!pte_none(pte));
> +	} while (addr += PAGE_SIZE, addr < end);

So this loop is just a sanity check (pte clearing having been done by
the unmap loops). That's fine, maybe a comment for future reference.

> +
> +	if (!pgtable_range_aligned(start, end, floor, ceiling, PMD_MASK))
> +		return;
> +
> +	ptep = pte_offset_kernel(pmdp, 0UL);
> +	for (i = 0; i < PTRS_PER_PTE; i++) {
> +		if (!pte_none(READ_ONCE(ptep[i])))
> +			return;
> +	}

We could do with a comment for this loop along the lines of:

	Check whether we can free the pte page if the rest of the
	entries are empty. Overlap with other regions have been handled
	by the floor/ceiling check.

Apart from the comments above, the rest of the patch looks fine. Once
fixed:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Mark Rutland mentioned at some point that, as a preparatory patch to
this series, we'd need to make sure we don't hot-remove memory already
given to the kernel at boot. Any plans here?

Thanks.

-- 
Catalin
