Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A0C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C5A214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406719AbfHIMhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:37:50 -0400
Received: from foss.arm.com ([217.140.110.172]:46932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406338AbfHIMhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:37:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6739D1596;
        Fri,  9 Aug 2019 05:37:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EBDE3F706;
        Fri,  9 Aug 2019 05:37:48 -0700 (PDT)
Date:   Fri, 9 Aug 2019 13:37:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH v3 1/3] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20190809123745.GG48423@lakrids.cambridge.arm.com>
References: <20190731071550.31814-1-dja@axtens.net>
 <20190731071550.31814-2-dja@axtens.net>
 <20190808135037.GA47131@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808135037.GA47131@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:50:37PM +0100, Mark Rutland wrote:
> From looking at this for a while, there are a few more things we should
> sort out:
 
> * We can use the split pmd locks (used by both x86 and arm64) to
>   minimize contention on the init_mm ptl. As apply_to_page_range()
>   doesn't pass the corresponding pmd in, we'll have to re-walk the table
>   in the callback, but I suspect that's better than having all vmalloc
>   operations contend on the same ptl.

Just to point out: I was wrong about this. We don't initialise the split
pmd locks for the kernel page tables, so we have to use the init_mm ptl.

I've fixed that up in my kasan/vmalloc branch as below, which works for
me on arm64 (with another patch to prevent arm64 from using early shadow
for the vmalloc area).

Thanks,
Mark.

----

static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr, void *unused)
{
	unsigned long page;
	pte_t pte;

	if (likely(!pte_none(*ptep)))
		return 0;

	page = __get_free_page(GFP_KERNEL);
	if (!page)
		return -ENOMEM;

	memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);

	/*
	 * Ensure poisoning is visible before the shadow is made visible
	 * to other CPUs.
	 */
	smp_wmb();

	spin_lock(&init_mm.page_table_lock);
	if (likely(pte_none(*ptep))) {
		set_pte_at(&init_mm, addr, ptep, pte);
		page = 0;
	}
	spin_unlock(&init_mm.page_table_lock);
	if (page)
		free_page(page);
	return 0;
}

int kasan_populate_vmalloc(unsigned long requested_size, struct vm_struct *area)
{
	unsigned long shadow_start, shadow_end;
	int ret;

	shadow_start = (unsigned long)kasan_mem_to_shadow(area->addr);
	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
	shadow_end = (unsigned long)kasan_mem_to_shadow(area->addr + area->size),
	shadow_end = ALIGN(shadow_end, PAGE_SIZE);

	ret = apply_to_page_range(&init_mm, shadow_start,
				  shadow_end - shadow_start,
				  kasan_populate_vmalloc_pte, NULL);
	if (ret)
		return ret;

	kasan_unpoison_shadow(area->addr, requested_size);

	/*
	 * We have to poison the remainder of the allocation each time, not
	 * just when the shadow page is first allocated, because vmalloc may
	 * reuse addresses, and an early large allocation would cause us to
	 * miss OOBs in future smaller allocations.
	 *
	 * The alternative is to poison the shadow on vfree()/vunmap(). We
	 * don't because the unmapping the virtual addresses should be
	 * sufficient to find most UAFs.
	 */
	requested_size = round_up(requested_size, KASAN_SHADOW_SCALE_SIZE);
	kasan_poison_shadow(area->addr + requested_size,
			    area->size - requested_size,
			    KASAN_VMALLOC_INVALID);

	return 0;
}
