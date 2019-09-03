Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568EF21883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="gzAlelyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfICWPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:15:34 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:12727 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICWPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:15:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id AAA2C3F671;
        Wed,  4 Sep 2019 00:15:31 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=gzAlelyj;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mux16M2QUtvF; Wed,  4 Sep 2019 00:15:30 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 41A923F40A;
        Wed,  4 Sep 2019 00:15:27 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A05D8360160;
        Wed,  4 Sep 2019 00:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567548926; bh=nIA64ocI+n5D4OB+HLLwxnXOxaEz/oh4I3ffyVh/4nI=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=gzAlelyj5XfF8b0pUv5ucT29pTfUWzHP+CHn+fdiPmCWMNfcMMYM/NgEKnnzNigLa
         rXY9n015AJAntQ8+AkhcwiR3QzM+/D4MknyfY0yLeZU4v8NM8DZwIDYXOa5Dx3p3RL
         7/OtoeIHgTVIiPT7kVVZla9sAEl+lsHl9M83Z7vc=
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
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
 <44b094c8-63fe-d9e5-1bf4-7da0788caccf@shipmail.org>
Organization: VMware Inc.
Message-ID: <6d122d62-9c96-4c29-8d06-02f7134e5e2a@shipmail.org>
Date:   Wed, 4 Sep 2019 00:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <44b094c8-63fe-d9e5-1bf4-7da0788caccf@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 12:08 AM, Thomas Hellström (VMware) wrote:
> On 9/3/19 11:46 PM, Andy Lutomirski wrote:
>> On Tue, Sep 3, 2019 at 2:05 PM Thomas Hellström (VMware)
>> <thomas_os@shipmail.org> wrote:
>>> On 9/3/19 10:51 PM, Dave Hansen wrote:
>>>> On 9/3/19 1:36 PM, Thomas Hellström (VMware) wrote:
>>>>> So the question here should really be, can we determine already at 
>>>>> mmap
>>>>> time whether backing memory will be unencrypted and adjust the *real*
>>>>> vma->vm_page_prot under the mmap_sem?
>>>>>
>>>>> Possibly, but that requires populating the buffer with memory at mmap
>>>>> time rather than at first fault time.
>>>> I'm not connecting the dots.
>>>>
>>>> vma->vm_page_prot is used to create a VMA's PTEs regardless of if they
>>>> are created at mmap() or fault time.  If we establish a good
>>>> vma->vm_page_prot, can't we just use it forever for demand faults?
>>> With SEV I think that we could possibly establish the encryption flags
>>> at vma creation time. But thinking of it, it would actually break with
>>> SME where buffer content can be moved between encrypted system memory
>>> and unencrypted graphics card PCI memory behind user-space's back. That
>>> would imply killing all user-space encrypted PTEs and at fault time set
>>> up new ones pointing to unencrypted PCI memory..
>>>
>>>> Or, are you concerned that if an attempt is made to demand-fault page
>>>> that's incompatible with vma->vm_page_prot that we have to SEGV?
>>>>
>>>>> And it still requires knowledge whether the device DMA is always
>>>>> unencrypted (or if SEV is active).
>>>> I may be getting mixed up on MKTME (the Intel memory encryption) and
>>>> SEV.  Is SEV supported on all memory types?  Page cache, hugetlbfs,
>>>> anonymous?  Or just anonymous?
>>> SEV AFAIK encrypts *all* memory except DMA memory. To do that it uses a
>>> SWIOTLB backed by unencrypted memory, and it also flips coherent DMA
>>> memory to unencrypted (which is a very slow operation and patch 4 deals
>>> with caching such memory).
>>>
>> I'm still lost.  You have some fancy VMA where the backing pages
>> change behind the application's back.  This isn't particularly novel
>> -- plain old anonymous memory and plain old mapped files do this too.
>> Can't you all the insert_pfn APIs and call it a day?  What's so
>> special that you need all this magic?  ISTM you should be able to
>> allocate memory that's addressable by the device (dma_alloc_coherent()
>> or whatever) and then map it into user memory just like you'd map any
>> other page.
>>
>> I feel like I'm missing something here.
>
> Yes, so in this case we use dma_alloc_coherent().
>
> With SEV, that gives us unencrypted pages. (Pages whose linear kernel 
> map is marked unencrypted). With SME that (typcially) gives us 
> encrypted pages. In both these cases, vm_get_page_prot() returns
> an encrypted page protection, which lands in vma->vm_page_prot.
>
> In the SEV case, we therefore need to modify the page protection to 
> unencrypted. Hence we need to know whether we're running under SEV and 
> therefore need to modify the protection. If not, the user-space PTE 
> would incorrectly have the encryption flag set.
>
> /Thomas
>
>
And, of course, had we not been "fancy", we could have used 
dma_mmap_coherent(), which in theory should set up the correct 
user-space page protection. But now we're moving stuff around so we can't.

/Thomas


