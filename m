Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C4C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FA12089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="O71ZZZYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfIKKK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:10:28 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:40280 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfIKKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:10:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id B58023F83F;
        Wed, 11 Sep 2019 12:10:24 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="O71ZZZYV";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cjPnNEQH7o4U; Wed, 11 Sep 2019 12:10:23 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 88D913F838;
        Wed, 11 Sep 2019 12:10:21 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B1E233601AA;
        Wed, 11 Sep 2019 12:10:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568196621; bh=O+WFacO8LkYZdAVKiWt+E7uv69sjpf0qYY4jHLX9jcs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O71ZZZYV7VMDsK0EwDguVfzwg6Ow42jbyj71uKdKEVds7ezFVuYWYPyMbZnglbgXM
         nQNLrdzksE1NId8PB4XmDp8MTSBSTkLwieS2q907KAo2TZK860ohPEbwLT+Gw89LY6
         nS65tVMswln2/GZZ2wrxs7SnfAboPGRsdTHJ/B04=
Subject: TTM huge page-faults WAS: Re: [RFC PATCH 1/2] x86: Don't let
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
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <cace2653-447f-bcdc-2714-142d9dc85787@shipmail.org>
Date:   Wed, 11 Sep 2019 12:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d6da6e46-d283-9efc-52cb-9f2a6b0b7188@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

removing people that are probably not interested from CC
adding dri-devel

On 9/11/19 11:08 AM, Koenig, Christian wrote:
> Am 10.09.19 um 21:26 schrieb Thomas Hellström (VMware):
>> On 9/10/19 6:11 PM, Andy Lutomirski wrote:
>>>> On Sep 5, 2019, at 8:24 AM, Christoph Hellwig <hch@infradead.org>
>>>> wrote:
>>>>
>>>>> On Thu, Sep 05, 2019 at 05:21:24PM +0200, Thomas Hellström (VMware)
>>>>> wrote:
>>>>>> On 9/5/19 4:15 PM, Dave Hansen wrote:
>>>>>> Hi Thomas,
>>>>>>
>>>>>> Thanks for the second batch of patches!  These look much improved
>>>>>> on all
>>>>>> fronts.
>>>>> Yes, although the TTM functionality isn't in yet. Hopefully we
>>>>> won't have to
>>>>> bother you with those though, since this assumes TTM will be using
>>>>> the dma
>>>>> API.
>>>> Please take a look at dma_mmap_prepare and dma_mmap_fault in this
>>>> branch:
>>>>
>>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mmap-improvements
>>>>
>>>> they should allow to fault dma api pages in the page fault handler.
>>>> But
>>>> this is totally hot off the press and not actually tested for the last
>>>> few patches.  Note that I've also included your two patches from this
>>>> series to handle SEV.
>>> I read that patch, and it seems like you’ve built in the assumption
>>> that all pages in the mapping use identical protection or, if not,
>>> that the same fake vma hack that TTM already has is used to fudge
>>> around it.  Could it be reworked slightly to avoid this?
>>>
>>> I wonder if it’s a mistake to put the encryption bits in vm_page_prot
>>> at all.
>>  From my POW, the encryption bits behave quite similar in behaviour to
>> the caching mode bits, and they're also in vm_page_prot. They're the
>> reason TTM needs to modify the page protection in the fault handler in
>> the first place.
>>
>> The problem seen in TTM is that we want to be able to change the
>> vm_page_prot from the fault handler, but it's problematic since we
>> have the mmap_sem typically only in read mode. Hence the fake vma
>> hack. From what I can tell it's reasonably well-behaved, since
>> pte_modify() skips the bits TTM updates, so mprotect() and mremap()
>> works OK. I think split_huge_pmd may run into trouble, but we don't
>> support it (yet) with TTM.
> Ah! I actually ran into this while implementing huge page support for
> TTM and never figured out why that doesn't work. Dropped CPU huge page
> support because of this.

By incident, I got slightly sidetracked the other day and started 
looking at this as well. Got to the point where I figured out all the 
hairy alignment issues and actually got huge_fault() calls, but never 
implemented the handler. I think that's definitely something worth 
having. Not sure it will work for IO memory, though, (split_huge_pmd 
will just skip non-page-backed memory) but if we only support VM_SHARED 
(non COW) vmas there's no reason to split the huge pmds anyway. 
Definitely something we should have IMO.

>> We could probably get away with a WRITE_ONCE() update of the
>> vm_page_prot before taking the page table lock since
>>
>> a) We're locking out all other writers.
>> b) We can't race with another fault to the same vma since we hold an
>> address space lock ("buffer object reservation")
>> c) When we need to update there are no valid page table entries in the
>> vma, since it only happens directly after mmap(), or after an
>> unmap_mapping_range() with the same address space lock. When another
>> reader (for example split_huge_pmd()) sees a valid page table entry,
>> it also sees the new page protection and things are fine.
> Yeah, that's exactly why I always wondered why we need this hack with
> the vma copy on the stack.
>
>> But that would really be a special case. To solve this properly we'd
>> probably need an additional lock to protect the vm_flags and
>> vm_page_prot, taken after mmap_sem and i_mmap_lock.
> Well we already have a special lock for this: The reservation object. So
> memory barriers etc should be in place and I also think we can just
> update the vm_page_prot on the fly.

I agree. This is needed for huge pages. We should make this change, and 
perhaps add the justification above as a comment.

/Thomas

> Christian.
>
>> /Thomas
>>
>>
>>
>>

