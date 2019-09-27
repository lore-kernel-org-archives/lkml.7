Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50D0206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 05:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfI0FmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 01:42:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfI0FmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 01:42:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13A20307D962;
        Fri, 27 Sep 2019 05:42:16 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDF9760BF4;
        Fri, 27 Sep 2019 05:42:11 +0000 (UTC)
Date:   Fri, 27 Sep 2019 13:42:08 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] x86/kdump: Reserve extra memory when SME or SEV
 is active
Message-ID: <20190927054208.GA13426@dhcp-128-65.nay.redhat.com>
References: <20190910151341.14986-1-kasong@redhat.com>
 <20190910151341.14986-3-kasong@redhat.com>
 <20190911055618.GA104115@gmail.com>
 <CACPcB9eZUZ1fCsc1GZs9MJnoqLK9Ld5KEx0_emx8J44Mjcy3WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9eZUZ1fCsc1GZs9MJnoqLK9Ld5KEx0_emx8J44Mjcy3WA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 27 Sep 2019 05:42:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/19 at 06:36pm, Kairui Song wrote:
> On Wed, Sep 11, 2019 at 1:56 PM Ingo Molnar <mingo@kernel.org> wrote:
> > * Kairui Song <kasong@redhat.com> wrote:
> >
> > > Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> > > SWIOTLB will be enabled even if there is less than 4G of memory when SME
> > > is active, to support DMA of devices that not support address with the
> > > encrypt bit.
> > >
> > > And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> > > active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
> > >
> > > Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> > > encryption") will always force SWIOTLB to be enabled when SEV is active
> > > in all cases.
> > >
> > > Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> > > and this is also true for kdump kernel. As a result kdump kernel will
> > > run out of already scarce pre-reserved memory easily.
> > >
> > > So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> > > kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> > > is specified or any offset is used. As for the high reservation case, an
> > > extra low memory region will always be reserved and that is enough for
> > > SWIOTLB. Else if the offset format is used, user should be fully aware
> > > of any possible kdump kernel memory requirement and have to organize the
> > > memory usage carefully.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > ---
> > >  arch/x86/kernel/setup.c | 20 +++++++++++++++++---
> > >  1 file changed, 17 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > > index 71f20bb18cb0..ee6a2f1e2226 100644
> > > --- a/arch/x86/kernel/setup.c
> > > +++ b/arch/x86/kernel/setup.c
> > > @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> > >                                         unsigned long long *crash_size,
> > >                                         bool high)
> > >  {
> > > -     unsigned long long base, size;
> > > +     unsigned long long base, size, mem_enc_req = 0;
> > >
> > >       base = *crash_base;
> > >       size = *crash_size;
> > > @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
> > >       if (high)
> > >               goto high_reserve;
> > >
> > > +     /*
> > > +      * When SME/SEV is active and not using high reserve,
> > > +      * it will always required an extra SWIOTLB region.
> > > +      */
> > > +     if (mem_encrypt_active())
> > > +             mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> > > +
> > >       base = memblock_find_in_range(CRASH_ALIGN,
> > > -                                   CRASH_ADDR_LOW_MAX, size,
> > > +                                   CRASH_ADDR_LOW_MAX,
> > > +                                   size + mem_enc_req,
> > >                                     CRASH_ALIGN);
> >
> 
> Hi Ingo,
> 
> I re-read my previous reply, it's long and tedious, let me try to make
> a more effective reply:
> 
> > What sizes are we talking about here?
> 
> The size here is how much memory will be reserved for kdump kernel, to
> ensure kdump kernel and userspace can run without OOM.
> 
> >
> > - What is the possible size range of swiotlb_size_or_default()
> 
> swiotlb_size_or_default() returns the swiotlb size, it's specified by
> user using swiotlb=<size>, or default size (64MB)
> 
> >
> > - What is the size of CRASH_ADDR_LOW_MAX (the old limit)?
> 
> It's 4G.
> 
> >
> > - Why do we replace one fixed limit with another fixed limit instead of
> >   accurately sizing the area, with each required feature adding its own
> >   requirement to the reservation size?
> 
> It's quite hard to "accurately sizing the area".
> 
> No way to tell the exact amount of memory kdump needs, we can only estimate.
> Kdump kernel use different cmdline, drivers and components will have
> special handling for kdump, and userspace is totally different.

Agreed about your above, but specific this the problem in this patch
There should be other ways.

First thought about doing generic handling in swiotlb part, and do
something like kdump_memory_reserve(size) Ingo suggested,  but according
to you swiotlb init is late, so it can not increase the size, OTOH if
reserve another region for kdump in swiotlb will cause other issues. 

So let's think about other improvement, for example to see if you can
call kdump_memory_reserve(size) in AMD SME init path, for example in
mem_encrypt_init(), is it before crashkernel reservation? 

If doable it will be at least cleaner than the code in this patch.

Thanks
Dave
