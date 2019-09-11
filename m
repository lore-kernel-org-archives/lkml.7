Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3028CC4740C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 04:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5021D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 04:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568175518;
	bh=7c7GlzBskBZbL7rcVg8E2DYHT4VS1V6YJLvUXB9+vV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FMqnp8zIaXuKYgEOg9t91Pb1Wa+QiYNoH/3JM3ReoDVzK1LBSMHdjsXAIZJyarNN1
	 bOTm5tJlQi/UxWLzMy3dFvaFXJRK7xiWVszVQKset8Vt17oLI19nqVhDQoXhI3NqKF
	 WuWpGYzJr2MiP1F+Rq91ugFYjIXaeRgqp+YLpucY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfIKESh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 00:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfIKESg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 00:18:36 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED56222BF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 04:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568175515;
        bh=7c7GlzBskBZbL7rcVg8E2DYHT4VS1V6YJLvUXB9+vV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sHU923gADX/4/c2YXRf5CezaTMdKk+H/Ni92tFgJCnANvZuXjbGqL4X8Bj3EZPpZ9
         tatGIfgFzhHKDDlxmVfgYHyLrtpRX1Ix8D32pAMEhlfyVWBBvITPqX00sptKXhnJ7I
         VGCMbBvy/6pFeY5GblQKJbOiO7LGQo9Uexh+Wnjw=
Received: by mail-wm1-f43.google.com with SMTP id n10so1745840wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 21:18:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUGKOQ34yI/01Nm6HgZ7JEHbcME0+Eipp6aEbmmp2rY+BbMecIV
        h4oqJMZkx5rYWUVYxHsskEj0588SD45v19n8Y8lz3A==
X-Google-Smtp-Source: APXvYqwg1qq5dVOWeEEGfJkv7fZ1PKesGKnfSIg+MgwbZJWl8lM+JFjdoxwcXfyPWnGxYJ11xlF3c9dkmgJDG7kwSQA=
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr2250397wmk.161.1568175513734;
 Tue, 10 Sep 2019 21:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190905103541.4161-1-thomas_os@shipmail.org> <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com> <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org> <10185AAF-BFB8-4193-A20B-B97794FB7E2F@amacapital.net>
 <92171412-eed7-40e9-2554-adb358e65767@shipmail.org>
In-Reply-To: <92171412-eed7-40e9-2554-adb358e65767@shipmail.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 10 Sep 2019 21:18:22 -0700
X-Gmail-Original-Message-ID: <CALCETrWEzctRxiv9AY0hhPGNPhv8k0POCMzMi30Bgh2aPY7R3w@mail.gmail.com>
Message-ID: <CALCETrWEzctRxiv9AY0hhPGNPhv8k0POCMzMi30Bgh2aPY7R3w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        pv-drivers@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:26 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> On 9/10/19 6:11 PM, Andy Lutomirski wrote:
> >
> >> On Sep 5, 2019, at 8:24 AM, Christoph Hellwig <hch@infradead.org> wrot=
e:
> >>
> >>> On Thu, Sep 05, 2019 at 05:21:24PM +0200, Thomas Hellstr=C3=B6m (VMwa=
re) wrote:
> >>>> On 9/5/19 4:15 PM, Dave Hansen wrote:
> >>>> Hi Thomas,
> >>>>
> >>>> Thanks for the second batch of patches!  These look much improved on=
 all
> >>>> fronts.
> >>> Yes, although the TTM functionality isn't in yet. Hopefully we won't =
have to
> >>> bother you with those though, since this assumes TTM will be using th=
e dma
> >>> API.
> >> Please take a look at dma_mmap_prepare and dma_mmap_fault in this
> >> branch:
> >>
> >>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dm=
a-mmap-improvements
> >>
> >> they should allow to fault dma api pages in the page fault handler.  B=
ut
> >> this is totally hot off the press and not actually tested for the last
> >> few patches.  Note that I've also included your two patches from this
> >> series to handle SEV.
> > I read that patch, and it seems like you=E2=80=99ve built in the assump=
tion that all pages in the mapping use identical protection or, if not, tha=
t the same fake vma hack that TTM already has is used to fudge around it.  =
Could it be reworked slightly to avoid this?
> >
> > I wonder if it=E2=80=99s a mistake to put the encryption bits in vm_pag=
e_prot at all.
>
>  From my POW, the encryption bits behave quite similar in behaviour to
> the caching mode bits, and they're also in vm_page_prot. They're the
> reason TTM needs to modify the page protection in the fault handler in
> the first place.
>
> The problem seen in TTM is that we want to be able to change the
> vm_page_prot from the fault handler, but it's problematic since we have
> the mmap_sem typically only in read mode. Hence the fake vma hack. From
> what I can tell it's reasonably well-behaved, since pte_modify() skips
> the bits TTM updates, so mprotect() and mremap() works OK. I think
> split_huge_pmd may run into trouble, but we don't support it (yet) with
> TTM.

One thing I'm confused about: does TTM move individual pages between
main memory and device memory or does it move whole mappings?  If it
moves individual pages, then a single mapping could have PTEs from
dma_alloc_coherent() space and from PCI space.  How can this work with
vm_page_prot?  I guess you might get lucky and have both have the same
protection bits, but that seems like an unfortunate thing to rely on.

As a for-real example, take a look at arch/x86/entry/vdso/vma.c.  The
"vvar" VMA contains multiple pages that are backed by different types
of memory.  There's a page of ordinary kernel memory.  Historically
there was a page of genuine MMIO memory, but that's gone now.  If the
system is a SEV guest with pvclock enabled, then there's a page of
decrypted memory.   They all share a VMA, they're instantiated in
.fault, and there is no hackery involved.  Look at vvar_fault().

So, Christoph, can't you restructure your code a bit to compute the
caching and encryption state per page instead of once in
dma_mmap_prepare() and insert the pages accordingly?  You might need
to revert 6d958546ff611c9ae09b181e628c1c5d5da5ebda depending on
exactly how you structure it.

>
> We could probably get away with a WRITE_ONCE() update of the
> vm_page_prot before taking the page table lock since
>
> a) We're locking out all other writers.
> b) We can't race with another fault to the same vma since we hold an
> address space lock ("buffer object reservation")
> c) When we need to update there are no valid page table entries in the
> vma, since it only happens directly after mmap(), or after an
> unmap_mapping_range() with the same address space lock. When another
> reader (for example split_huge_pmd()) sees a valid page table entry, it
> also sees the new page protection and things are fine.
>
> But that would really be a special case. To solve this properly we'd
> probably need an additional lock to protect the vm_flags and
> vm_page_prot, taken after mmap_sem and i_mmap_lock.
>

This is all horrible IMO.
