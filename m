Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DF8ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D142168B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="VWcUzUgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfIKHtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:49:45 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:23514 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfIKHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:49:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 86F693F6E9;
        Wed, 11 Sep 2019 09:49:41 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=VWcUzUgE;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 18ytgjrsSKhl; Wed, 11 Sep 2019 09:49:36 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A101D3F671;
        Wed, 11 Sep 2019 09:49:32 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 01E0D3600A6;
        Wed, 11 Sep 2019 09:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568188172; bh=RzGKKS4Bp05BsWEWP+aX9IYliv4nwEQmfcOAV0di4dE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VWcUzUgETPQNDpnigqTUT+SyEwR5F3qH+fxULzOut++6Sn/TCnvXzaiTv4IQoyW/z
         1hY47vnfO+njzb2vntVa7WGPdoW69pSA3eXOgSLRVPnMjKMuKKj1H4AAH8gnheYzFx
         IlbYmB6CCCbBtUC4UeuRX7ttFgDnYwyuVA2fHQxw=
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        pv-drivers@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org>
 <10185AAF-BFB8-4193-A20B-B97794FB7E2F@amacapital.net>
 <92171412-eed7-40e9-2554-adb358e65767@shipmail.org>
 <CALCETrWEzctRxiv9AY0hhPGNPhv8k0POCMzMi30Bgh2aPY7R3w@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <76f89b46-7b14-9483-e552-eb52762adca0@shipmail.org>
Date:   Wed, 11 Sep 2019 09:49:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWEzctRxiv9AY0hhPGNPhv8k0POCMzMi30Bgh2aPY7R3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy.

On 9/11/19 6:18 AM, Andy Lutomirski wrote:
> On Tue, Sep 10, 2019 at 12:26 PM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> On 9/10/19 6:11 PM, Andy Lutomirski wrote:
>>>> On Sep 5, 2019, at 8:24 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>>>
>>>>> On Thu, Sep 05, 2019 at 05:21:24PM +0200, Thomas Hellström (VMware) wrote:
>>>>>> On 9/5/19 4:15 PM, Dave Hansen wrote:
>>>>>> Hi Thomas,
>>>>>>
>>>>>> Thanks for the second batch of patches!  These look much improved on all
>>>>>> fronts.
>>>>> Yes, although the TTM functionality isn't in yet. Hopefully we won't have to
>>>>> bother you with those though, since this assumes TTM will be using the dma
>>>>> API.
>>>> Please take a look at dma_mmap_prepare and dma_mmap_fault in this
>>>> branch:
>>>>
>>>>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mmap-improvements
>>>>
>>>> they should allow to fault dma api pages in the page fault handler.  But
>>>> this is totally hot off the press and not actually tested for the last
>>>> few patches.  Note that I've also included your two patches from this
>>>> series to handle SEV.
>>> I read that patch, and it seems like you’ve built in the assumption that all pages in the mapping use identical protection or, if not, that the same fake vma hack that TTM already has is used to fudge around it.  Could it be reworked slightly to avoid this?
>>>
>>> I wonder if it’s a mistake to put the encryption bits in vm_page_prot at all.
>>   From my POW, the encryption bits behave quite similar in behaviour to
>> the caching mode bits, and they're also in vm_page_prot. They're the
>> reason TTM needs to modify the page protection in the fault handler in
>> the first place.
>>
>> The problem seen in TTM is that we want to be able to change the
>> vm_page_prot from the fault handler, but it's problematic since we have
>> the mmap_sem typically only in read mode. Hence the fake vma hack. From
>> what I can tell it's reasonably well-behaved, since pte_modify() skips
>> the bits TTM updates, so mprotect() and mremap() works OK. I think
>> split_huge_pmd may run into trouble, but we don't support it (yet) with
>> TTM.
> One thing I'm confused about: does TTM move individual pages between
> main memory and device memory or does it move whole mappings?  If it
> moves individual pages, then a single mapping could have PTEs from
> dma_alloc_coherent() space and from PCI space.  How can this work with
> vm_page_prot?  I guess you might get lucky and have both have the same
> protection bits, but that seems like an unfortunate thing to rely on.

With TTM, a single vma is completely backed with memory of the same 
type, so all PTEs have the same protection, and mimics that of the 
linear kernel map (if applicable). But the protection is not 
determinable at mmap time, and we may switch protection and backing 
memory at certain points in time where all PTEs are first killed.

>
> As a for-real example, take a look at arch/x86/entry/vdso/vma.c.  The
> "vvar" VMA contains multiple pages that are backed by different types
> of memory.  There's a page of ordinary kernel memory.  Historically
> there was a page of genuine MMIO memory, but that's gone now.  If the
> system is a SEV guest with pvclock enabled, then there's a page of
> decrypted memory.   They all share a VMA, they're instantiated in
> .fault, and there is no hackery involved.  Look at vvar_fault().

So this is conceptually identical to TTM. The difference is that it uses 
vmf_insert_pfn_prot() instead of vmf_insert_mixed() with the vma hack. 
Had there been a vmf_insert_mixed_prot(), the hack in TTM wouldn't be 
needed. I guess providing a vmf_insert_mixed_prot() is a to-do for me to 
pick up.

Having said that, the code you point out is as fragile and suffers from 
the same shortcomings as TTM since
a) Running things like split_huge_pmd() that takes the vm_page_prot and 
applies it to new PTEs will make things break, (although probably never 
applicable in this case).
b) Running mprotect() on that VMA will only work if sme_me_mask is part 
of _PAGE_CHG_MASK (which is addressed in a reliable way in my recent 
patchset),  otherwise, the encryption setting will be overwritten.


>> We could probably get away with a WRITE_ONCE() update of the
>> vm_page_prot before taking the page table lock since
>>
>> a) We're locking out all other writers.
>> b) We can't race with another fault to the same vma since we hold an
>> address space lock ("buffer object reservation")
>> c) When we need to update there are no valid page table entries in the
>> vma, since it only happens directly after mmap(), or after an
>> unmap_mapping_range() with the same address space lock. When another
>> reader (for example split_huge_pmd()) sees a valid page table entry, it
>> also sees the new page protection and things are fine.
>>
>> But that would really be a special case. To solve this properly we'd
>> probably need an additional lock to protect the vm_flags and
>> vm_page_prot, taken after mmap_sem and i_mmap_lock.
>>
> This is all horrible IMO.

I'd prefer to call it fragile and potentially troublesome to maintain.

That distinction is important because if it ever comes to a choice 
between adding a new lock to protect vm_page_prot (and consequently slow 
down the whole vm system) and using the WRITE_ONCE solution in TTM, we 
should know what the implications are. As it turns out previous choices 
in this area actually seem to have opted for the lockless WRITE_ONCE / 
READ_ONCE / ptl solution. See __split_huge_pmd_locked() and 
vma_set_page_prot().

Thanks,
Thomas


