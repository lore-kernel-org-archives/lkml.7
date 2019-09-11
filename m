Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251FBC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EB62084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="UnStjuBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfIKPIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:08:47 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:58151 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfIKPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:08:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 4EFA640E8D;
        Wed, 11 Sep 2019 17:08:39 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=UnStjuBW;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K4cCLt3qtFDL; Wed, 11 Sep 2019 17:08:38 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E33AE40E84;
        Wed, 11 Sep 2019 17:08:37 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 546AB3601AA;
        Wed, 11 Sep 2019 17:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568214517; bh=iXS3GPpxTpsS/0BsV1h1Z1UOn1deQj53Xl4MDL0r1Es=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UnStjuBWdFqAiDUOxNAooUYh9qTARPLWsZrAun876cQiysskITkouXSkMiV9hNo9H
         yUQ1AuE1dL883RxQjgOEFYXego1hdN5ij+QaDi4kdMiVubKj0d7SHtsa6oTePemL5g
         iollE2oXywNd3+UsQkcPONkYX234t7/uKfgSe6Qo=
Subject: Re: TTM huge page-faults WAS: Re: [RFC PATCH 1/2] x86: Don't let
 pgprot_modify() change the page encryption bit
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org>
 <10185AAF-BFB8-4193-A20B-B97794FB7E2F@amacapital.net>
 <92171412-eed7-40e9-2554-adb358e65767@shipmail.org>
 <d6da6e46-d283-9efc-52cb-9f2a6b0b7188@amd.com>
 <cace2653-447f-bcdc-2714-142d9dc85787@shipmail.org>
 <ea486b68-7751-e51f-5a59-7e1f145820f4@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <46a21ca5-a395-e644-9eed-77ea26fc871e@shipmail.org>
Date:   Wed, 11 Sep 2019 17:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ea486b68-7751-e51f-5a59-7e1f145820f4@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 4:06 PM, Koenig, Christian wrote:
> Am 11.09.19 um 12:10 schrieb Thomas Hellström (VMware):
> [SNIP]
>>>> The problem seen in TTM is that we want to be able to change the
>>>> vm_page_prot from the fault handler, but it's problematic since we
>>>> have the mmap_sem typically only in read mode. Hence the fake vma
>>>> hack. From what I can tell it's reasonably well-behaved, since
>>>> pte_modify() skips the bits TTM updates, so mprotect() and mremap()
>>>> works OK. I think split_huge_pmd may run into trouble, but we don't
>>>> support it (yet) with TTM.
>>> Ah! I actually ran into this while implementing huge page support for
>>> TTM and never figured out why that doesn't work. Dropped CPU huge page
>>> support because of this.
>> By incident, I got slightly sidetracked the other day and started
>> looking at this as well. Got to the point where I figured out all the
>> hairy alignment issues and actually got huge_fault() calls, but never
>> implemented the handler. I think that's definitely something worth
>> having. Not sure it will work for IO memory, though, (split_huge_pmd
>> will just skip non-page-backed memory) but if we only support
>> VM_SHARED (non COW) vmas there's no reason to split the huge pmds
>> anyway. Definitely something we should have IMO.
> Well our primary use case would be IO memory, cause system memory is
> only optionally allocate as huge page but we nearly always allocate VRAM
> in chunks of at least 2MB because we otherwise get a huge performance
> penalty.

But that system memory option is on by default, right? In any case, a 
request for a huge_fault
would probably need to check that there is actually an underlying 
huge_page and otherwise fallback to ordinary faults.

Another requirement would be for IO memory allocations to be 
PMD_PAGE_SIZE aligned in the mappable aperture, to avoid fallbacks to 
ordinary faults. Probably increasing fragmentation somewhat. (Seems like 
pmd entries can only point to PMD_PAGE_SIZE aligned physical addresses) 
Would that work for you?

>>>> We could probably get away with a WRITE_ONCE() update of the
>>>> vm_page_prot before taking the page table lock since
>>>>
>>>> a) We're locking out all other writers.
>>>> b) We can't race with another fault to the same vma since we hold an
>>>> address space lock ("buffer object reservation")
>>>> c) When we need to update there are no valid page table entries in the
>>>> vma, since it only happens directly after mmap(), or after an
>>>> unmap_mapping_range() with the same address space lock. When another
>>>> reader (for example split_huge_pmd()) sees a valid page table entry,
>>>> it also sees the new page protection and things are fine.
>>> Yeah, that's exactly why I always wondered why we need this hack with
>>> the vma copy on the stack.
>>>
>>>> But that would really be a special case. To solve this properly we'd
>>>> probably need an additional lock to protect the vm_flags and
>>>> vm_page_prot, taken after mmap_sem and i_mmap_lock.
>>> Well we already have a special lock for this: The reservation object. So
>>> memory barriers etc should be in place and I also think we can just
>>> update the vm_page_prot on the fly.
>> I agree. This is needed for huge pages. We should make this change,
>> and perhaps add the justification above as a comment.
> Alternatively we could introduce a new VM_* flag telling users of
> vm_page_prot to just let the pages table entries be filled by faults again

An interesting idea, although we'd lose things like dirty-tracking bits.

/Thomas


>
> Christian.


