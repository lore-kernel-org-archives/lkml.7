Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A11822CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="pkx+xcp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfICWIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:08:38 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:26175 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfICWIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:08:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id A5E7F3FA6C;
        Wed,  4 Sep 2019 00:08:30 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=pkx+xcp7;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vesswdzBSj4G; Wed,  4 Sep 2019 00:08:29 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 4CC3A3F867;
        Wed,  4 Sep 2019 00:08:28 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id BE2E7360160;
        Wed,  4 Sep 2019 00:08:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567548507; bh=PP08vBRpPI309PnHgg45hbLsURQYHx2L5Y1XUs0y6nM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pkx+xcp7hRW0GXq5L6+AefZWEbZg0UOumvBTFZnEqaoGsI8veT+gNordaidfuAVSR
         FIujzRE3rpKodpvIxbxht6Ig9OXw1ylUXalqIMSnaL22ANMUIbkhue7Rhe2PYqta59
         4FvVjoE0Af4SpyxGZ2Fsgsy/eKc99JNsguqTla4Q=
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        pv-drivers@vmware.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org>
 <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
 <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com>
 <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com>
 <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
 <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <44b094c8-63fe-d9e5-1bf4-7da0788caccf@shipmail.org>
Date:   Wed, 4 Sep 2019 00:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 11:46 PM, Andy Lutomirski wrote:
> On Tue, Sep 3, 2019 at 2:05 PM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> On 9/3/19 10:51 PM, Dave Hansen wrote:
>>> On 9/3/19 1:36 PM, Thomas Hellström (VMware) wrote:
>>>> So the question here should really be, can we determine already at mmap
>>>> time whether backing memory will be unencrypted and adjust the *real*
>>>> vma->vm_page_prot under the mmap_sem?
>>>>
>>>> Possibly, but that requires populating the buffer with memory at mmap
>>>> time rather than at first fault time.
>>> I'm not connecting the dots.
>>>
>>> vma->vm_page_prot is used to create a VMA's PTEs regardless of if they
>>> are created at mmap() or fault time.  If we establish a good
>>> vma->vm_page_prot, can't we just use it forever for demand faults?
>> With SEV I think that we could possibly establish the encryption flags
>> at vma creation time. But thinking of it, it would actually break with
>> SME where buffer content can be moved between encrypted system memory
>> and unencrypted graphics card PCI memory behind user-space's back. That
>> would imply killing all user-space encrypted PTEs and at fault time set
>> up new ones pointing to unencrypted PCI memory..
>>
>>> Or, are you concerned that if an attempt is made to demand-fault page
>>> that's incompatible with vma->vm_page_prot that we have to SEGV?
>>>
>>>> And it still requires knowledge whether the device DMA is always
>>>> unencrypted (or if SEV is active).
>>> I may be getting mixed up on MKTME (the Intel memory encryption) and
>>> SEV.  Is SEV supported on all memory types?  Page cache, hugetlbfs,
>>> anonymous?  Or just anonymous?
>> SEV AFAIK encrypts *all* memory except DMA memory. To do that it uses a
>> SWIOTLB backed by unencrypted memory, and it also flips coherent DMA
>> memory to unencrypted (which is a very slow operation and patch 4 deals
>> with caching such memory).
>>
> I'm still lost.  You have some fancy VMA where the backing pages
> change behind the application's back.  This isn't particularly novel
> -- plain old anonymous memory and plain old mapped files do this too.
> Can't you all the insert_pfn APIs and call it a day?  What's so
> special that you need all this magic?  ISTM you should be able to
> allocate memory that's addressable by the device (dma_alloc_coherent()
> or whatever) and then map it into user memory just like you'd map any
> other page.
>
> I feel like I'm missing something here.

Yes, so in this case we use dma_alloc_coherent().

With SEV, that gives us unencrypted pages. (Pages whose linear kernel 
map is marked unencrypted). With SME that (typcially) gives us encrypted 
pages. In both these cases, vm_get_page_prot() returns
an encrypted page protection, which lands in vma->vm_page_prot.

In the SEV case, we therefore need to modify the page protection to 
unencrypted. Hence we need to know whether we're running under SEV and 
therefore need to modify the protection. If not, the user-space PTE 
would incorrectly have the encryption flag set.

/Thomas


