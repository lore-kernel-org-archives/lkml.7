Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A258C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D828D214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbfIYKgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389655AbfIYKgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:36:49 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E684D89AC7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:36:48 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id w1so8584165ioj.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 03:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdvVuCfFLXjVHxywXEjyNWAMi7Dm8AjJWXCcb/jJKAg=;
        b=nVhtl6HWaXnMfeBzxmSPb6OMEbNlUL54QTtl+zmfFVf3F5Nd/LI8HTa7IkrRtnwt9j
         KEleK0OFnC+dEBJaK7MYw/hjacxGKzOKujzctS1dah4BCxfGv7jFuB+stfI75GfogOeJ
         VlZ60T/FW1JrB4enwTCNj4AsMpI/ZQa1/tABr8Iv7CZXjXxnVSwXpyNQJEsCO5P7eeZA
         Qt4EU5Gc6OOsr1qqDP5NA3T+iVzLw4Guu/dxgkwR3mNR+oayP1cdZ7Wp7mROtUn4VAgX
         toeGxQu/uO69RQeJte6M19Abij9jIquVQmVEWeg3ParprSqy3kN0bvdXw3vzVjEhk7Y5
         erJw==
X-Gm-Message-State: APjAAAVSjAJ2jUfQYgFYRMfiTa8YWwgaYL3Jk34CS5t2/fgP3Jmed/EB
        WBHH1T3BFcz1Q8abz5+J5pT1pOZ0u1xGbWkKW/Qmbo+Ka87KZh4y0mdzVwkRT7FCXiIsmFNqBve
        4jpYiy9mVNR2OMlzpMNnfSjy66A7ej7lKv2V9HBRb
X-Received: by 2002:a6b:14c6:: with SMTP id 189mr9456809iou.202.1569407808281;
        Wed, 25 Sep 2019 03:36:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwnS9lQgCMgWdl29gbqz3gatArNxk8QN2NoOwKwj4dVqJTk2gZr9jeVjroaCsqi73bSKZQwB4ti64TZfA4QHk8=
X-Received: by 2002:a6b:14c6:: with SMTP id 189mr9456782iou.202.1569407807952;
 Wed, 25 Sep 2019 03:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151341.14986-1-kasong@redhat.com> <20190910151341.14986-3-kasong@redhat.com>
 <20190911055618.GA104115@gmail.com>
In-Reply-To: <20190911055618.GA104115@gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 25 Sep 2019 18:36:36 +0800
Message-ID: <CACPcB9eZUZ1fCsc1GZs9MJnoqLK9Ld5KEx0_emx8J44Mjcy3WA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/kdump: Reserve extra memory when SME or SEV is active
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 1:56 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Kairui Song <kasong@redhat.com> wrote:
>
> > Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> > SWIOTLB will be enabled even if there is less than 4G of memory when SME
> > is active, to support DMA of devices that not support address with the
> > encrypt bit.
> >
> > And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> > active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
> >
> > Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> > encryption") will always force SWIOTLB to be enabled when SEV is active
> > in all cases.
> >
> > Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> > and this is also true for kdump kernel. As a result kdump kernel will
> > run out of already scarce pre-reserved memory easily.
> >
> > So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> > kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> > is specified or any offset is used. As for the high reservation case, an
> > extra low memory region will always be reserved and that is enough for
> > SWIOTLB. Else if the offset format is used, user should be fully aware
> > of any possible kdump kernel memory requirement and have to organize the
> > memory usage carefully.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  arch/x86/kernel/setup.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 71f20bb18cb0..ee6a2f1e2226 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> >                                         unsigned long long *crash_size,
> >                                         bool high)
> >  {
> > -     unsigned long long base, size;
> > +     unsigned long long base, size, mem_enc_req = 0;
> >
> >       base = *crash_base;
> >       size = *crash_size;
> > @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> >       if (high)
> >               goto high_reserve;
> >
> > +     /*
> > +      * When SME/SEV is active and not using high reserve,
> > +      * it will always required an extra SWIOTLB region.
> > +      */
> > +     if (mem_encrypt_active())
> > +             mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> > +
> >       base = memblock_find_in_range(CRASH_ALIGN,
> > -                                   CRASH_ADDR_LOW_MAX, size,
> > +                                   CRASH_ADDR_LOW_MAX,
> > +                                   size + mem_enc_req,
> >                                     CRASH_ALIGN);
>

Hi Ingo,

I re-read my previous reply, it's long and tedious, let me try to make
a more effective reply:

> What sizes are we talking about here?

The size here is how much memory will be reserved for kdump kernel, to
ensure kdump kernel and userspace can run without OOM.

>
> - What is the possible size range of swiotlb_size_or_default()

swiotlb_size_or_default() returns the swiotlb size, it's specified by
user using swiotlb=<size>, or default size (64MB)

>
> - What is the size of CRASH_ADDR_LOW_MAX (the old limit)?

It's 4G.

>
> - Why do we replace one fixed limit with another fixed limit instead of
>   accurately sizing the area, with each required feature adding its own
>   requirement to the reservation size?

It's quite hard to "accurately sizing the area".

No way to tell the exact amount of memory kdump needs, we can only estimate.
Kdump kernel use different cmdline, drivers and components will have
special handling for kdump, and userspace is totally different.

>
> I.e. please engineer this into a proper solution instead of just
> modifying it around the edges.
>
> For example have you considered adding some sort of
> kdump_memory_reserve(size) facility, which increases the reservation size
> as something like SWIOTLB gets activated? That would avoid the ugly
> mem_encrypt_active() flag, it would just automagically work.

My first attempt is increase crashkernel memory as swiotlb is
activated. There are problems.

First, SME/SEV is currently the only case that both kernel require
SWIOTLB, for most other case, it's wasting memory.

If we don't care about the memory waste, it has to check/reserve/free
crashkernel memory at three different points:
1. Early boot:
    - crash kernel reserved a region as usual.
2. Right before memblock freeing memoy:
    - If SWIOTLB is activated, crash kernel should reserve another region.
3. After Initcalls:
    - SWIOTLB may get deactivated by initcalls, so need to do a later
check for if we need to release the later reserved region.
It's more complex.

And about a "kdump_memory_reserve(size)" facility, as talked above,
it's hard to know how much kdump needs for now, also hard to find any
user of this.

Please let me know if I failed to make something clear or have any
misunderstanding.

>
> Thanks,
>
>         Ingo



--
Best Regards,
Kairui Song
