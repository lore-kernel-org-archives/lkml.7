Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675F5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA4F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBT5gyj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfHLECY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 00:02:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39981 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfHLECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 00:02:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id e8so1113792qtp.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/4YnpQhIEZcscEz7uCIGbe6A/Kj16Z9K3vN8c7z419g=;
        b=tBT5gyj2w+9S3FzzabYm9eqPL/FRGIHVoK3/HO/QuWUaZr2kcDDZ4PTHdPfSFK2BGd
         OPVNfb0CdADvleEhQK7qYnWZhBlS6N01jYodJMPEaY9s4O85dU66TtdjkvGXPnMnmP8e
         KdOq7qwnG51CB8dBZaamlmltv11JADM8xxcNDLGboLTy+9X8mxXFdmoohJIWm1W4Wha+
         KwyOwJMvZsX1vhUdyq3eomCKblJuZ/jIK+crYjLS2IHI73fMiAHben/v69hZ8nm19LEs
         kQgP9z68SWRdxqsLzWCFc3PV6gwWakf4rODe3wI+oXMjPbZSjqvo3AABFSgvbaZGlxu9
         Xx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/4YnpQhIEZcscEz7uCIGbe6A/Kj16Z9K3vN8c7z419g=;
        b=pCTOqeeHKvumZKF+NiESGdb1QG2jek41NNG7hJA4y/BjNtZrlBG95vy7uRuTMZIWER
         pDtVB+KTnmtpzCLyjrIbedBECjCozHM9v/WrF2j1IF9brhcE+s4KOmzcsrSc+VBNFMyc
         7L9jhroPGh2AChdSXKZe1Iwm8ALc/3invcSVX3LqbnLxqJEGgCiODa6pjtfQrK2keqj7
         4LSlhjko4zUNE/Z7TGfQXv4uzvu+E+lh7Y3djx7ho/MNZFErmkbtm1Tehg5xlTH7TJ7f
         cAIWmFwL9//EHMgfk+e5TZ0FX3wTLYDGvKoBODNzcYZxyPOe9tDG0QVtpor9OzRt+2mr
         bajg==
X-Gm-Message-State: APjAAAVsh3U7Af0/Faywj8MF97PFZreyIMPAwkRHsC8pPZ93ZS9XmpIG
        QQVuU5tWyGyW30dpwVZkc8Wiw/Poz1AHZrpbLfI=
X-Google-Smtp-Source: APXvYqwrc3cIWWpJ+2sSHHUY3ZXmH5XJfdi0QRJLtjR4lCzkyeuDx29O7pJKAB3qqLP2XAo7s222Z635R/yrBMWckY0=
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr28162850qta.28.1565582542296;
 Sun, 11 Aug 2019 21:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
 <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com> <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
 <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com> <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
 <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com>
In-Reply-To: <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 12 Aug 2019 12:01:49 +0800
Message-ID: <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     greentime.hu@sifive.com, paul.walmsley@sifive.com,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:03=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
>
>
> On 2019-08-09 11:01 a.m., Greentime Hu wrote:
> > Hi Logan,
> >
> > Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=88=
9=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >>
> >>
> >> On 2019-08-08 10:23 p.m., Greentime Hu wrote:
> >>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>> index 3f12b069af1d..208b3e14ccd8 100644
> >>> --- a/arch/riscv/Kconfig
> >>> +++ b/arch/riscv/Kconfig
> >>> @@ -116,7 +116,8 @@ config PGTABLE_LEVELS
> >>>         default 2
> >>>
> >>>  config HAVE_ARCH_PFN_VALID
> >>> -       def_bool y
> >>> +       bool
> >>> +       default !SPARSEMEM_VMEMMAP
> >>>
> >>>  menu "Platform type"
> >>>
> >>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/p=
age.h
> >>> index 8ddb6c7fedac..6991f7a5a4a7 100644
> >>> --- a/arch/riscv/include/asm/page.h
> >>> +++ b/arch/riscv/include/asm/page.h
> >>> @@ -93,16 +93,20 @@ extern unsigned long min_low_pfn;
> >>>  #define virt_to_pfn(vaddr)     (phys_to_pfn(__pa(vaddr)))
> >>>  #define pfn_to_virt(pfn)       (__va(pfn_to_phys(pfn)))
> >>>
> >>> +#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
> >>> +#define pfn_valid(pfn) \
> >>> +       (((pfn) >=3D pfn_base) && (((pfn)-pfn_base) < max_mapnr))
> >>>  #define virt_to_page(vaddr)    (pfn_to_page(virt_to_pfn(vaddr)))
> >>>  #define page_to_virt(page)     (pfn_to_virt(page_to_pfn(page)))
> >>> +#else
> >>> +#define virt_to_page(vaddr)    ((struct page *)((((u64)vaddr -
> >>> va_pa_offset) / PAGE_SIZE) * sizeof(struct page) + VMEMMAP_START))
> >>> +#define page_to_virt(pg)       ((void *)(((((u64)pg - VMEMMAP_START)=
 /
> >>> sizeof(struct page)) * PAGE_SIZE) + va_pa_offset))
> >>> +#endif
> >>
> >> This doesn't make sense to me at all. It should always use pfn_to_page=
()
> >> for virt_to_page() and the generic pfn_to_page()/page_to_pfn()
> >> implementations essentially already do what you are doing in a cleaner
> >> way. So I'd be really surprised if this does anything at all.
> >>
> >
> > Thank you for point me out that. I just checked the generic
> > implementation and I should use that one.
> > Sorry I didn't check the generic one and just implement it again.
> > I think the only patch we need is the first part to use generic
> > pfn_valid(). I just tested it and yes it can boot successfully in dts
> > with hole.
> >
> > It will fail in this check ((pfn)-pfn_base) < max_mapnr.
>
> Sounds to me like max_mapnr is not set correctly. See the code in
> setup_bootmem(). Seems like 'mem_size' should be set to the largest
> memory block, not just the one that contains the kernel...
>
>
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 3f12b069af1d..208b3e14ccd8 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -116,7 +116,8 @@ config PGTABLE_LEVELS
> >         default 2
> >
> >  config HAVE_ARCH_PFN_VALID
> > -       def_bool y
> > +       bool
> > +       default !SPARSEMEM_VMEMMAP
> >
> >  menu "Platform type"
> >
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/pag=
e.h
> > index 8ddb6c7fedac..80d28fa1e2eb 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -100,8 +100,10 @@ extern unsigned long min_low_pfn;
> >  #define page_to_bus(page)      (page_to_phys(page))
> >  #define phys_to_page(paddr)    (pfn_to_page(phys_to_pfn(paddr)))
> >
> > +#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
> >  #define pfn_valid(pfn) \
> >         (((pfn) >=3D pfn_base) && (((pfn)-pfn_base) < max_mapnr))
> > +#endif
> >
> >  #define ARCH_PFN_OFFSET                (pfn_base)
>
>
> This patch still makes no sense. I'm not sure why we have an arch
> specific pfn_valid() because it's very similar to the generic one. But
> my guess is there's a reason for it and it's not doing what it is
> supposed when you remove it for the sparsemem case.

It will use another pfn_valid() implementation in
include/linux/mmzone.h if CONFIG_SPARSEMEM and
!CONFIG_HAVE_ARCH_PFN_VALID
It will be this one.

static inline int pfn_valid(unsigned long pfn)
{
        if (pfn_to_section_nr(pfn) >=3D NR_MEM_SECTIONS)
                return 0;
        return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
}

This generic pfn_valid() API can check the pfn is valid or not even if
there a hole in the memory.
For example:
A hole is between 0x100000000 to 0x180000000 (4GB-6GB) in my dts test case.

[    0.000000] In setup_bootmem, pfn_valid(0x180000)=3D1
[    0.000000] In setup_bootmem, pfn_valid(0x80000)=3D1
[    0.000000] In setup_bootmem, pfn_valid(0x80200)=3D1
[    0.000000] In setup_bootmem, pfn_valid(0x80300)=3D1
[    0.000000] In setup_bootmem, pfn_valid(0x160000)=3D0
[    0.000000] In setup_bootmem, pfn_valid(0x17ffff)=3D0
[    0.000000] In setup_bootmem, pfn_valid(0x120000)=3D0
[    0.000000] In setup_bootmem, pfn_valid(0x100000)=3D0
[    0.000000] In setup_bootmem, pfn_valid(0xfffff)=3D1

This generic pfn_valid() could tell the pfn is valid or not.


I think this one is only available for flatmem.
#define pfn_valid(pfn)  (((pfn) >=3D pfn_base) && (((pfn)-pfn_base) < max_m=
apnr))
