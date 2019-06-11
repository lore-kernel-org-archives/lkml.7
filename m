Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB2AC0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3CB21743
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=vmwopensource.org header.i=@vmwopensource.org header.b="vl6XdSWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407060AbfFKS1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:27:16 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:15842 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405802AbfFKS1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:27:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id B3A2940D6F;
        Tue, 11 Jun 2019 20:27:07 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=vmwopensource.org header.i=@vmwopensource.org header.b=vl6XdSWY;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id smfTGIN7o__R; Tue, 11 Jun 2019 20:26:58 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id B2F543F86C;
        Tue, 11 Jun 2019 20:26:57 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 198C3361A96;
        Tue, 11 Jun 2019 20:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vmwopensource.org;
        s=mail; t=1560277617;
        bh=l3W/AqRf84wNp6P4sWXjTRud8TI0AhrSO/bC0PKM5fg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vl6XdSWYGKdFQN7iy2I6478NTemupw3IjgYmmFrjGfarW9AUCkwCHczkOJHx4UA/2
         L1Dz4hmwgBEYT3Z08isg+RMbIw9Oui5bwMskWFMMLeuhAIytZWixxGvFKerujCko3C
         0o5dD+7XGLhFoCpoAA3Z0Lw4LMccKlNHHMGaNQt0=
Subject: Re: [PATCH v4 3/9] mm: Add write-protect and clean utilities for
 address space ranges
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-graphics-maintainer@vmware.com,
        "VMware, Inc." <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
References: <20190611122454.3075-1-thellstrom@vmwopensource.org>
 <20190611122454.3075-4-thellstrom@vmwopensource.org>
 <1CDAE797-4686-4041-938F-DE0456FFF451@gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thellstrom@vmwopensource.org>
Organization: VMware Inc.
Message-ID: <ac0b0ef5-8f76-5e55-2be2-f1860878841a@vmwopensource.org>
Date:   Tue, 11 Jun 2019 20:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1CDAE797-4686-4041-938F-DE0456FFF451@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nadav,

On 6/11/19 7:21 PM, Nadav Amit wrote:
>> On Jun 11, 2019, at 5:24 AM, Thomas Hellström (VMware) <thellstrom@vmwopensource.org> wrote:
>>
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
> [ snip ]
>
>> +/**
>> + * apply_pt_wrprotect - Leaf pte callback to write-protect a pte
>> + * @pte: Pointer to the pte
>> + * @token: Page table token, see apply_to_pfn_range()
>> + * @addr: The virtual page address
>> + * @closure: Pointer to a struct pfn_range_apply embedded in a
>> + * struct apply_as
>> + *
>> + * The function write-protects a pte and records the range in
>> + * virtual address space of touched ptes for efficient range TLB flushes.
>> + *
>> + * Return: Always zero.
>> + */
>> +static int apply_pt_wrprotect(pte_t *pte, pgtable_t token,
>> +			      unsigned long addr,
>> +			      struct pfn_range_apply *closure)
>> +{
>> +	struct apply_as *aas = container_of(closure, typeof(*aas), base);
>> +	pte_t ptent = *pte;
>> +
>> +	if (pte_write(ptent)) {
>> +		pte_t old_pte = ptep_modify_prot_start(aas->vma, addr, pte);
>> +
>> +		ptent = pte_wrprotect(old_pte);
>> +		ptep_modify_prot_commit(aas->vma, addr, pte, old_pte, ptent);
>> +		aas->total++;
>> +		aas->start = min(aas->start, addr);
>> +		aas->end = max(aas->end, addr + PAGE_SIZE);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * struct apply_as_clean - Closure structure for apply_as_clean
>> + * @base: struct apply_as we derive from
>> + * @bitmap_pgoff: Address_space Page offset of the first bit in @bitmap
>> + * @bitmap: Bitmap with one bit for each page offset in the address_space range
>> + * covered.
>> + * @start: Address_space page offset of first modified pte relative
>> + * to @bitmap_pgoff
>> + * @end: Address_space page offset of last modified pte relative
>> + * to @bitmap_pgoff
>> + */
>> +struct apply_as_clean {
>> +	struct apply_as base;
>> +	pgoff_t bitmap_pgoff;
>> +	unsigned long *bitmap;
>> +	pgoff_t start;
>> +	pgoff_t end;
>> +};
>> +
>> +/**
>> + * apply_pt_clean - Leaf pte callback to clean a pte
>> + * @pte: Pointer to the pte
>> + * @token: Page table token, see apply_to_pfn_range()
>> + * @addr: The virtual page address
>> + * @closure: Pointer to a struct pfn_range_apply embedded in a
>> + * struct apply_as_clean
>> + *
>> + * The function cleans a pte and records the range in
>> + * virtual address space of touched ptes for efficient TLB flushes.
>> + * It also records dirty ptes in a bitmap representing page offsets
>> + * in the address_space, as well as the first and last of the bits
>> + * touched.
>> + *
>> + * Return: Always zero.
>> + */
>> +static int apply_pt_clean(pte_t *pte, pgtable_t token,
>> +			  unsigned long addr,
>> +			  struct pfn_range_apply *closure)
>> +{
>> +	struct apply_as *aas = container_of(closure, typeof(*aas), base);
>> +	struct apply_as_clean *clean = container_of(aas, typeof(*clean), base);
>> +	pte_t ptent = *pte;
>> +
>> +	if (pte_dirty(ptent)) {
>> +		pgoff_t pgoff = ((addr - aas->vma->vm_start) >> PAGE_SHIFT) +
>> +			aas->vma->vm_pgoff - clean->bitmap_pgoff;
>> +		pte_t old_pte = ptep_modify_prot_start(aas->vma, addr, pte);
>> +
>> +		ptent = pte_mkclean(old_pte);
>> +		ptep_modify_prot_commit(aas->vma, addr, pte, old_pte, ptent);
>> +
>> +		aas->total++;
>> +		aas->start = min(aas->start, addr);
>> +		aas->end = max(aas->end, addr + PAGE_SIZE);
>> +
>> +		__set_bit(pgoff, clean->bitmap);
>> +		clean->start = min(clean->start, pgoff);
>> +		clean->end = max(clean->end, pgoff + 1);
>> +	}
>> +
>> +	return 0;
> Usually, when a PTE is write-protected, or when a dirty-bit is cleared, the
> TLB flush must be done while the page-table lock for that specific table is
> taken (i.e., within apply_pt_clean() and apply_pt_wrprotect() in this case).
>
> Otherwise, in the case of apply_pt_clean() for example, another core might
> shortly after (before the TLB flush) write to the same page whose PTE was
> changed. The dirty-bit in such case might not be set, and the change get
> lost.

Hmm. Let's assume that was the case, we have two possible situations:

A: pt_clean

1. That core's TLB entry is invalid. It will set the PTE dirty bit and 
continue. The dirty bit will probably remain set after the TLB flush.
2. That core's TLB entry is valid. It will just continue. The dirty bit 
will remain clear after the TLB flush.

But I fail to see how having the TLB flush within the page table lock 
would help in this case. Since the writing core will never attempt to 
take it? In any case, if such a race occurs, the corresponding bit in 
the bitmap would have been set and we've recorded that the page is dirty.

B: wrprotect situation, the situation is a bit different:

1. That core's TLB entry is invalid. It will read the PTE, cause a fault 
and block in mkwrite() on an external address space lock which is held 
over this operation. (Is it this situation that is your main concern?)
2. That core's TLB entry is valid. It will just continue regardless of 
any locks.

For both mkwrite() and dirty() if we act on the recorded pages *after* 
the TLB flush, we're OK. The difference is that just after the TLB flush 
there should be no write-enabled PTEs in the write-protect case, but 
there may be dirty PTEs in the pt_clean case. Something that is 
mentioned in the docs already.

>
> Does this function regards a certain use-case in which deferring the TLB
> flushes is fine? If so, assertions and documentation of the related
> assumption would be useful.

If I understand your comment correctly, the page table lock is sometimes 
used as the lock in B1, blocking a possible software fault until the TLB 
flush has happened.  Here we assume an external address space lock taken 
both around the wrprotect operation and in mkwrite(). Would it be OK if 
I add comments about the necessity of an external lock to the doc? Ok 
with a follow-up patch?

Thanks,
Thomas


