Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB69C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53F7207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfI0HxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31305 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfI0HxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:53:11 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7969C05AA52
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:53:10 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id w8so10669022iod.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 00:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+z967OGKFyzsipkAMvwKR90NL+oBP6ClqcqeupYnwJM=;
        b=C6RwmpEjkaWECYOp1TJeL+CsFzrIr0zgH2PuhzEMTW77i+VoPUuFC8aA65Abhz4h5F
         CDTWIGUQMprzt7IZ2B1z4JFaBjvfnkDjzMsE4kmuJMzR3AE1x7rEfLL6A+NhtHEd2hP6
         HM0Y194EUmcSVed2hhPCUoLDyXjbPcsCp/oidCm+gtfyPRj5ak6S+tXVqS+CPEEiLa8a
         5puVcpEVhIUBmLBP3JfsrpJpGssbGQvuQ2h+aL+WumaidAQMylL881vdDRnVnbAv5y+E
         gIpF/pQzQuCL0inaFiw65/HlubaheI5ac+JLkh9GKFi8/sd8XqGNTuoLcPUsS7qYclKO
         oY9Q==
X-Gm-Message-State: APjAAAUSDFi3SP2t8b71oKmplu6WsFB5Jin0oasoL9vE2NMn05iiLxVh
        66fYD427hoCrc4EFepqNv3h2nILo+/AfERDwE3tH0zL3ZbuUwOssDZ+QnyjElbKNpydJL4Sh8VN
        omsjm5Iszq0wLr1DPbAIgyTVa4xmglZmYAeZeLBuc
X-Received: by 2002:a92:5c13:: with SMTP id q19mr3296382ilb.249.1569570790131;
        Fri, 27 Sep 2019 00:53:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQAC9ocy3CrD0E1lT+wFbJDvNy6gND2zhgtJZP9qoxiBZjNnVGhEx653IsvSSXH18WtvDnbJSa8TQZbQj7HiU=
X-Received: by 2002:a92:5c13:: with SMTP id q19mr3296358ilb.249.1569570789810;
 Fri, 27 Sep 2019 00:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151341.14986-1-kasong@redhat.com> <20190910151341.14986-3-kasong@redhat.com>
 <20190911055618.GA104115@gmail.com> <CACPcB9eZUZ1fCsc1GZs9MJnoqLK9Ld5KEx0_emx8J44Mjcy3WA@mail.gmail.com>
 <20190927054208.GA13426@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190927054208.GA13426@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 27 Sep 2019 15:52:58 +0800
Message-ID: <CACPcB9d+5idm-0r69Qeh3GyGF-wuyie_w1jBL5GRsnxq40Gs6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/kdump: Reserve extra memory when SME or SEV is active
To:     Dave Young <dyoung@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 1:42 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 09/25/19 at 06:36pm, Kairui Song wrote:
> > On Wed, Sep 11, 2019 at 1:56 PM Ingo Molnar <mingo@kernel.org> wrote:
> > > * Kairui Song <kasong@redhat.com> wrote:
> > >
> > > > Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> > > > SWIOTLB will be enabled even if there is less than 4G of memory when SME
> > > > is active, to support DMA of devices that not support address with the
> > > > encrypt bit.
> > > >
> > > > And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> > > > active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
> > > >
> > > > Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> > > > encryption") will always force SWIOTLB to be enabled when SEV is active
> > > > in all cases.
> > > >
> > > > Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> > > > and this is also true for kdump kernel. As a result kdump kernel will
> > > > run out of already scarce pre-reserved memory easily.
> > > >
> > > > So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> > > > kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> > > > is specified or any offset is used. As for the high reservation case, an
> > > > extra low memory region will always be reserved and that is enough for
> > > > SWIOTLB. Else if the offset format is used, user should be fully aware
> > > > of any possible kdump kernel memory requirement and have to organize the
> > > > memory usage carefully.
> > > >
> > > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > > ---
> > > >  arch/x86/kernel/setup.c | 20 +++++++++++++++++---
> > > >  1 file changed, 17 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > > index 71f20bb18cb0..ee6a2f1e2226 100644
> > > > --- a/arch/x86/kernel/setup.c
> > > > +++ b/arch/x86/kernel/setup.c
> > > > @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> > > >                                         unsigned long long *crash_size,
> > > >                                         bool high)
> > > >  {
> > > > -     unsigned long long base, size;
> > > > +     unsigned long long base, size, mem_enc_req = 0;
> > > >
> > > >       base = *crash_base;
> > > >       size = *crash_size;
> > > > @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> > > >       if (high)
> > > >               goto high_reserve;
> > > >
> > > > +     /*
> > > > +      * When SME/SEV is active and not using high reserve,
> > > > +      * it will always required an extra SWIOTLB region.
> > > > +      */
> > > > +     if (mem_encrypt_active())
> > > > +             mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> > > > +
> > > >       base = memblock_find_in_range(CRASH_ALIGN,
> > > > -                                   CRASH_ADDR_LOW_MAX, size,
> > > > +                                   CRASH_ADDR_LOW_MAX,
> > > > +                                   size + mem_enc_req,
> > > >                                     CRASH_ALIGN);
> > >
> >
> > Hi Ingo,
> >
> > I re-read my previous reply, it's long and tedious, let me try to make
> > a more effective reply:
> >
> > > What sizes are we talking about here?
> >
> > The size here is how much memory will be reserved for kdump kernel, to
> > ensure kdump kernel and userspace can run without OOM.
> >
> > >
> > > - What is the possible size range of swiotlb_size_or_default()
> >
> > swiotlb_size_or_default() returns the swiotlb size, it's specified by
> > user using swiotlb=<size>, or default size (64MB)
> >
> > >
> > > - What is the size of CRASH_ADDR_LOW_MAX (the old limit)?
> >
> > It's 4G.
> >
> > >
> > > - Why do we replace one fixed limit with another fixed limit instead of
> > >   accurately sizing the area, with each required feature adding its own
> > >   requirement to the reservation size?
> >
> > It's quite hard to "accurately sizing the area".
> >
> > No way to tell the exact amount of memory kdump needs, we can only estimate.
> > Kdump kernel use different cmdline, drivers and components will have
> > special handling for kdump, and userspace is totally different.
>
> Agreed about your above, but specific this the problem in this patch
> There should be other ways.
>
> First thought about doing generic handling in swiotlb part, and do
> something like kdump_memory_reserve(size) Ingo suggested,  but according
> to you swiotlb init is late, so it can not increase the size, OTOH if
> reserve another region for kdump in swiotlb will cause other issues.
>
> So let's think about other improvement, for example to see if you can
> call kdump_memory_reserve(size) in AMD SME init path, for example in
> mem_encrypt_init(), is it before crashkernel reservation?

Yes, mem_encrypt_init is before the crashkernel reservation.
I think this is a good idea. Will make a V4 patch based on this.

>
> If doable it will be at least cleaner than the code in this patch.
>
> Thanks
> Dave

-- 
Best Regards,
Kairui Song
