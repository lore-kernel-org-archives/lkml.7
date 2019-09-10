Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBAEC49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34D6216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="N6rJrhq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfIJT0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 15:26:55 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:34706 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfIJT0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:26:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 282253FC0A;
        Tue, 10 Sep 2019 21:26:48 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=N6rJrhq8;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W_jrAifXU1wU; Tue, 10 Sep 2019 21:26:45 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E74FB3F9ED;
        Tue, 10 Sep 2019 21:26:43 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 6BC5B3611A2;
        Tue, 10 Sep 2019 21:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568143603; bh=yvs08tYq+zTi96vb4hAXyTxXL+EzYuKm50/B1/vCxcU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N6rJrhq8kggLEUTAMF6RCMPZDhW38W9/3jCmYmKjPPWwn0r08MzxUHwljIFzt6vNI
         zIQXx/CpBpp/CL8kJopZJgIqyo7IpS8oQoYZt0D+1Ls2dx7tf5I+gPVYCwTwSmXY0c
         aI97rIyXMP3kXkokDIkfkNB8qA3fJ9WaqA53RwDw=
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     Andy Lutomirski <luto@amacapital.net>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
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
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <92171412-eed7-40e9-2554-adb358e65767@shipmail.org>
Date:   Tue, 10 Sep 2019 21:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <10185AAF-BFB8-4193-A20B-B97794FB7E2F@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 6:11 PM, Andy Lutomirski wrote:
>
>> On Sep 5, 2019, at 8:24 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>
>>> On Thu, Sep 05, 2019 at 05:21:24PM +0200, Thomas Hellström (VMware) wrote:
>>>> On 9/5/19 4:15 PM, Dave Hansen wrote:
>>>> Hi Thomas,
>>>>
>>>> Thanks for the second batch of patches!  These look much improved on all
>>>> fronts.
>>> Yes, although the TTM functionality isn't in yet. Hopefully we won't have to
>>> bother you with those though, since this assumes TTM will be using the dma
>>> API.
>> Please take a look at dma_mmap_prepare and dma_mmap_fault in this
>> branch:
>>
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mmap-improvements
>>
>> they should allow to fault dma api pages in the page fault handler.  But
>> this is totally hot off the press and not actually tested for the last
>> few patches.  Note that I've also included your two patches from this
>> series to handle SEV.
> I read that patch, and it seems like you’ve built in the assumption that all pages in the mapping use identical protection or, if not, that the same fake vma hack that TTM already has is used to fudge around it.  Could it be reworked slightly to avoid this?
>
> I wonder if it’s a mistake to put the encryption bits in vm_page_prot at all.

 From my POW, the encryption bits behave quite similar in behaviour to 
the caching mode bits, and they're also in vm_page_prot. They're the 
reason TTM needs to modify the page protection in the fault handler in 
the first place.

The problem seen in TTM is that we want to be able to change the 
vm_page_prot from the fault handler, but it's problematic since we have 
the mmap_sem typically only in read mode. Hence the fake vma hack. From 
what I can tell it's reasonably well-behaved, since pte_modify() skips 
the bits TTM updates, so mprotect() and mremap() works OK. I think 
split_huge_pmd may run into trouble, but we don't support it (yet) with 
TTM.

We could probably get away with a WRITE_ONCE() update of the 
vm_page_prot before taking the page table lock since

a) We're locking out all other writers.
b) We can't race with another fault to the same vma since we hold an 
address space lock ("buffer object reservation")
c) When we need to update there are no valid page table entries in the 
vma, since it only happens directly after mmap(), or after an 
unmap_mapping_range() with the same address space lock. When another 
reader (for example split_huge_pmd()) sees a valid page table entry, it 
also sees the new page protection and things are fine.

But that would really be a special case. To solve this properly we'd 
probably need an additional lock to protect the vm_flags and 
vm_page_prot, taken after mmap_sem and i_mmap_lock.

/Thomas




