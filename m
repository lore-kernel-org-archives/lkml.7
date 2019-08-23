Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4414B23402
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbfHWCL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:11:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389163AbfHWCL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:11:28 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B48DB550CF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:11:27 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id f5so4122044ioo.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 19:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+ZBnkkc6flUSqLwDF2ju3CQEpll/ZB3gVcng2w0c/E=;
        b=Fip5K0PpE11F1GO5jMj+Bg7e9sh+BaREhBcTiUsptBPQtjnjxk4gACQu4kF2u3wuQa
         mu4xqIBrMJjxv7108182075MQP1dDYjNF4XRgGApOcaGlKwz4lwbxmN68SidCEuLFMi+
         JZ20kIh3uNdtWyA68xnuVWWzoQ4aNflf2xuEqcgHlzV/mq/png1cabqCAPvVbdhgS0NQ
         VwcVi4qAl+bTQcgRMjwsIxoLvjwL8ajAlA33KApFiKEw5Ze3b0zwPQ6Sz+jlF8AgWOMc
         vAALuiWBdti4sAVMUdzvF13SUV6niS3ka4qXJJZmEx2QTV+gQXNc+wGfpOSOU4ObWSxl
         Pdrw==
X-Gm-Message-State: APjAAAXYeqycvX/5KZH+S54MtzzMk6017FFyedCyGUjjImuvntDE4FXa
        zJ6Lme8y5oSoWybcUcCjsbCkdhBQUmJ7QA7tiRJyN7yb/wok6JUvY3CyaOMj9/O7eQXY1mNsunV
        pA+haTSBChsQyTM6a0iRstXgkIXfGju5Vlnla98G5
X-Received: by 2002:a5d:9dd8:: with SMTP id 24mr2841427ioo.249.1566526287069;
        Thu, 22 Aug 2019 19:11:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6TD5jcMGMYhszqvCI11Yg+cgMO/QSdoVkVkKc1A45jKCCcxKMZSfaQ2fkmmZORaURFGVhJlKD4PP/o2Q6l9I=
X-Received: by 2002:a5d:9dd8:: with SMTP id 24mr2841416ioo.249.1566526286821;
 Thu, 22 Aug 2019 19:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190822025328.17151-1-kasong@redhat.com> <ff049b95-92a3-52ab-7ee8-01051a597cff@amd.com>
In-Reply-To: <ff049b95-92a3-52ab-7ee8-01051a597cff@amd.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 23 Aug 2019 10:11:15 +0800
Message-ID: <CACPcB9daWhyvqB_QEvnLuvp5BiZ4cSOoj6KaP8mcSUEiQGFC_w@mail.gmail.com>
Subject: Re: [PATCH] x86/kdump: Reserve extra memory when SME or SEV is active
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 10:35 PM Lendacky, Thomas
<Thomas.Lendacky@amd.com> wrote:
>
> On 8/21/19 9:53 PM, Kairui Song wrote:
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
> >  arch/x86/kernel/setup.c | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index bbe35bf879f5..ed91fa9d9f6e 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -528,7 +528,7 @@ static int __init reserve_crashkernel_low(void)
> >
> >  static void __init reserve_crashkernel(void)
> >  {
> > -     unsigned long long crash_size, crash_base, total_mem;
> > +     unsigned long long crash_size, crash_base, total_mem, mem_enc_req;
> >       bool high = false;
> >       int ret;
> >
> > @@ -550,6 +550,17 @@ static void __init reserve_crashkernel(void)
> >               return;
> >       }
> >
> > +     /*
> > +      * When SME/SEV is active, it will always required an extra SWIOTLB
> > +      * region.
> > +      */
> > +     if (sme_active() || sev_active()) {
>
> You can use mem_encrypt_active() here in place of the two checks.

That's a very good suggestion.

>
> > +             mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> > +             pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
> > +                             (unsigned long)(mem_enc_req >> 20));
>
> There is a point below where you zero out this value, so should this
> be issued later only if mem_enc_req is non-zero?

Yes that's true, but currently if zero out this value when ",high" is
used, then an extra low memory region will be reserved, so this
message will not be very confusing I think? as the required extra
memory is now in the low memory region. And for the "@offset" case
this could be a hint for users. And if the reserve failed due to
enlarged crashkernel size, the user may also be better aware of what
is causing the failure by this message.

>
> Also, looks like one too many tabs.
>
> > +     } else
>
> Since you used braces on the if path, you need braces on the else path.

OK, will fix the code style issues.

>
> Thanks,
> Tom
>
> > +             mem_enc_req = 0;
> > +
> >       /* 0 means: find the address automatically */
> >       if (!crash_base) {
> >               /*
> > @@ -563,11 +574,19 @@ static void __init reserve_crashkernel(void)
> >               if (!high)
> >                       crash_base = memblock_find_in_range(CRASH_ALIGN,
> >                                               CRASH_ADDR_LOW_MAX,
> > -                                             crash_size, CRASH_ALIGN);
> > -             if (!crash_base)
> > +                                             crash_size + mem_enc_req,
> > +                                             CRASH_ALIGN);
> > +             /*
> > +              * For high reservation, an extra low memory for SWIOTLB will
> > +              * always be reserved later, so no need to reserve extra
> > +              * memory for memory encryption case here.
> > +              */
> > +             if (!crash_base) {
> > +                     mem_enc_req = 0;
> >                       crash_base = memblock_find_in_range(CRASH_ALIGN,
> >                                               CRASH_ADDR_HIGH_MAX,
> >                                               crash_size, CRASH_ALIGN);
> > +             }
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> > @@ -583,6 +602,7 @@ static void __init reserve_crashkernel(void)
> >                       return;
> >               }
> >       }
> > +     crash_size += mem_enc_req;
> >       ret = memblock_reserve(crash_base, crash_size);
> >       if (ret) {
> >               pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
> >



-- 
Best Regards,
Kairui Song
