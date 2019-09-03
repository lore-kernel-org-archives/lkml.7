Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF6EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48D322CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="oW+6JVM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfICXPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 19:15:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46883 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:15:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so4017544pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0JNFzCpBJEdTemHS45RsytSZ45gxo6jwn6UP6l3k/q8=;
        b=oW+6JVM7aPZ/oqfhrmtJXYQvAfuGgJF4dbb9hL8kr4pZK2F4F6EwJoIjBJ7cw8oBlX
         Bvzfs/LSK+TzZhBZn7kKrT9R+4+htcZ2uy7HX6SdhTwzWczYwgs379bPE/Wb4D35slh7
         UFBTtOd4DnDaEmUbsjxiKcaAzKvOD9GdejDNwBa+xt+CYqMSeaqmgYA2aX/QCwV2ly+L
         7pBaBkXGPO5KmO7F5GrEBc2v4xjZ7CYFa+GAZ5Ny1iqkMW7Ubn7z5PigzPoI5Qo7bahQ
         nBQiZWmZjmETlqZ9J/YqkaK5BsWicDUd27qtMXYAQuBx5lz2snBdq4IVnBYFLBfWEqd4
         N5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0JNFzCpBJEdTemHS45RsytSZ45gxo6jwn6UP6l3k/q8=;
        b=auGwfKH7r+IeYCpqSr3KW6tQnons/2sOl9EsNDPzfJXXwljTk6prRFLHZHWLaxR1Tw
         IvZUaPX7R0OQS3RQTl/1QWy5b0dl/4fHW9gm980axs3VqEF2tA07kCjZpbMch0zTW0h5
         hH4XY/4aC4J1FfeXlDooqgN70OiFMktEv1d5m0+coWeYMaVB/C1xQOkTtnjTcNQd6jPT
         KQzsk9Nn+aDjyN1a5GpHKDkl26eCnhJuDG6yD3tpjv5xSpRT7ZRIvbyo4aDVOtVNcb7q
         mzI2WDihTgCtq5WNUmEDCyFpeiG1ASKBu1UgArX52BeivZPjoJuBeLRO2JH1UAgPh7uu
         jiwg==
X-Gm-Message-State: APjAAAXHbhqlei6wDtty1JJerddZnnP2p7fhC3cRli8I9tAE2JRgf+2k
        e2Uaq8wTbHGtzaFO5rOtlJDgvQ==
X-Google-Smtp-Source: APXvYqwAy6VYf9bqsKAEfzgG8ON4zGp8+yZVa8O65Onr7XLG5rt2+zdJ8t0YJUfd0uch3XZDDrztnQ==
X-Received: by 2002:a17:90a:310:: with SMTP id 16mr1910866pje.100.1567552551831;
        Tue, 03 Sep 2019 16:15:51 -0700 (PDT)
Received: from [10.238.221.122] (129.sub-97-41-131.myvzw.com. [97.41.131.129])
        by smtp.gmail.com with ESMTPSA id s7sm29657053pfb.138.2019.09.03.16.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 16:15:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD memory encryption
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <6d122d62-9c96-4c29-8d06-02f7134e5e2a@shipmail.org>
Date:   Tue, 3 Sep 2019 16:15:47 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3C5DD1B-A33C-417F-BDDC-73120A035EA5@amacapital.net>
References: <20190903131504.18935-1-thomas_os@shipmail.org> <20190903131504.18935-4-thomas_os@shipmail.org> <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com> <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com> <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com> <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org> <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com> <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org> <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com> <44b094c8-63fe-d9e5-1bf4-7da0788caccf@shipmail.org> <6d122d62-9c96-4c29-8d06-02f7134e5e2a@shipmail.org>
To:     =?utf-8?Q? "Thomas_Hellstr=C3=B6m_=28VMware=29" ?= 
        <thomas_os@shipmail.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 3, 2019, at 3:15 PM, Thomas Hellstr=C3=B6m (VMware) <thomas_os@ship=
mail.org> wrote:
>=20
>> On 9/4/19 12:08 AM, Thomas Hellstr=C3=B6m (VMware) wrote:
>>> On 9/3/19 11:46 PM, Andy Lutomirski wrote:
>>> On Tue, Sep 3, 2019 at 2:05 PM Thomas Hellstr=C3=B6m (VMware)
>>> <thomas_os@shipmail.org> wrote:
>>>> On 9/3/19 10:51 PM, Dave Hansen wrote:
>>>>>> On 9/3/19 1:36 PM, Thomas Hellstr=C3=B6m (VMware) wrote:
>>>>>> So the question here should really be, can we determine already at mm=
ap
>>>>>> time whether backing memory will be unencrypted and adjust the *real*=

>>>>>> vma->vm_page_prot under the mmap_sem?
>>>>>>=20
>>>>>> Possibly, but that requires populating the buffer with memory at mmap=

>>>>>> time rather than at first fault time.
>>>>> I'm not connecting the dots.
>>>>>=20
>>>>> vma->vm_page_prot is used to create a VMA's PTEs regardless of if they=

>>>>> are created at mmap() or fault time.  If we establish a good
>>>>> vma->vm_page_prot, can't we just use it forever for demand faults?
>>>> With SEV I think that we could possibly establish the encryption flags
>>>> at vma creation time. But thinking of it, it would actually break with
>>>> SME where buffer content can be moved between encrypted system memory
>>>> and unencrypted graphics card PCI memory behind user-space's back. That=

>>>> would imply killing all user-space encrypted PTEs and at fault time set=

>>>> up new ones pointing to unencrypted PCI memory..
>>>>=20
>>>>> Or, are you concerned that if an attempt is made to demand-fault page
>>>>> that's incompatible with vma->vm_page_prot that we have to SEGV?
>>>>>=20
>>>>>> And it still requires knowledge whether the device DMA is always
>>>>>> unencrypted (or if SEV is active).
>>>>> I may be getting mixed up on MKTME (the Intel memory encryption) and
>>>>> SEV.  Is SEV supported on all memory types?  Page cache, hugetlbfs,
>>>>> anonymous?  Or just anonymous?
>>>> SEV AFAIK encrypts *all* memory except DMA memory. To do that it uses a=

>>>> SWIOTLB backed by unencrypted memory, and it also flips coherent DMA
>>>> memory to unencrypted (which is a very slow operation and patch 4 deals=

>>>> with caching such memory).
>>>>=20
>>> I'm still lost.  You have some fancy VMA where the backing pages
>>> change behind the application's back.  This isn't particularly novel
>>> -- plain old anonymous memory and plain old mapped files do this too.
>>> Can't you all the insert_pfn APIs and call it a day?  What's so
>>> special that you need all this magic?  ISTM you should be able to
>>> allocate memory that's addressable by the device (dma_alloc_coherent()
>>> or whatever) and then map it into user memory just like you'd map any
>>> other page.
>>>=20
>>> I feel like I'm missing something here.
>>=20
>> Yes, so in this case we use dma_alloc_coherent().
>>=20
>> With SEV, that gives us unencrypted pages. (Pages whose linear kernel map=
 is marked unencrypted). With SME that (typcially) gives us encrypted pages.=
 In both these cases, vm_get_page_prot() returns
>> an encrypted page protection, which lands in vma->vm_page_prot.
>>=20
>> In the SEV case, we therefore need to modify the page protection to unenc=
rypted. Hence we need to know whether we're running under SEV and therefore n=
eed to modify the protection. If not, the user-space PTE would incorrectly h=
ave the encryption flag set.
>>=20

I=E2=80=99m still confused. You got unencrypted pages with an unencrypted PFN=
. Why do you need to fiddle?  You have a PFN, and you=E2=80=99re inserting i=
t with vmf_insert_pfn().  This should just work, no?  There doesn=E2=80=99t s=
eem to be any real funny business in dma_mmap_attrs() or dma_common_mmap().

But, reading this, I have more questions:

Can=E2=80=99t you get rid of cvma by using vmf_insert_pfn_prot()?

Would it make sense to add a vmf_insert_dma_page() to directly do exactly wh=
at you=E2=80=99re trying to do?

And a broader question just because I=E2=80=99m still confused: why isn=E2=80=
=99t the encryption bit in the PFN?  The whole SEV/SME system seems like it=E2=
=80=99s trying a bit to hard to be fully invisible to the kernel.=
