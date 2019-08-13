Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3701EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC449206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZA3B/v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfHMGEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:04:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45263 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfHMGEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:04:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id m2so4978757qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kCmBiJ0kCEzEIDZtsH26fXgwFDBAorRDLIt0W+si88A=;
        b=AZA3B/v1Xtb9RwFK5FrEZ1HH/uPKBwg6B249Hgj8mRlr+RjXmOu31q/faX9H3fqrZk
         t4Dq0wYMAjBkvKAZLHVXKA3nUo6J3FnpxqZWgNzZaLEcOQ3kVovOmDmHR9WXXltUq42W
         Bwt0g0WvZRkXKlUvms8qz0IbkWQHlrjt+tmGMKyYfRHhEGsjityf/VCI7LXmLTQpDq6o
         WACJQi3YKIPho2UFt/ZodbCBZ/np8GkDDLWF/YMJMTARaVmCTH+lYO7ZJbv5bTRaSQGi
         Q5mh1YVkwVI3dpLzIVX7iPYvvjVIdUqQqWcVY8XvGEPkyFuLAW2T9W6yJAtEVKuBx9bv
         WPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kCmBiJ0kCEzEIDZtsH26fXgwFDBAorRDLIt0W+si88A=;
        b=tQUNkBUEdjqWcCzc+Sy7Y6l9n1DfcTv0FmyNVGREaLRSnFPsGrRXwhC6/CGS2cvkAD
         IrjacfVpYJkHC5XlRtywDZMadJp2zanNvJob5TX87vGKzHm7IH+3fdCJNfLn2IkiTRRT
         HGbinBRkoVRqKROLUH1cAfCwn96qa+d/u4D3TI+dl3PdtmZPjtAI94cXTzgL+vERjOco
         XpSTBKPd6CcwYsCQUioaPsFKRZ09c++pb+RIX5rAJ/EuDgmSvUrKKJeXCIEesO5bzJqo
         I9lF2dmQq5rFLnEdvLXQPhSdHkxDnjPPDRyVmTw/dFkwAMuxGIsTUw+Kt+SDGgmOMSKT
         Ngpg==
X-Gm-Message-State: APjAAAXIu9/tqkowJbW4OusX4+IPRoLbmTDRuHn3tNBdmsTBPZ7tbV3j
        AF9QUoutHH8IzJHdNDJZNnCCNsEAEx5CdR46QMI=
X-Google-Smtp-Source: APXvYqyH/NWYJDzDaG4Z8jd8TA7s5eatl7O+F/CojK+rCtjNMPsWUSL76cQZLdr0VKapFEGjXg5Wmr2rrM7SvVZmVH4=
X-Received: by 2002:a05:620a:696:: with SMTP id f22mr27745166qkh.232.1565676291623;
 Mon, 12 Aug 2019 23:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
 <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com> <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
 <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com> <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
 <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com> <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
 <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com>
In-Reply-To: <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 13 Aug 2019 14:04:14 +0800
Message-ID: <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     greentime.hu@sifive.com, paul.walmsley@sifive.com,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Olof Johansson <olof@lixom.net>,
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

Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8812=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:52=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 2019-08-11 10:01 p.m., Greentime Hu wrote:
> > Hi Logan,
> >
> > Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=88=
10=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:03=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >>
> >>
> >> On 2019-08-09 11:01 a.m., Greentime Hu wrote:
> >>> Hi Logan,
> >>>
> >>> Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=
=889=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:47=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>>>
> >>>>
> >>>>
> >>>> On 2019-08-08 10:23 p.m., Greentime Hu wrote:
> >>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >>>>> index 3f12b069af1d..208b3e14ccd8 100644
> >>>>> --- a/arch/riscv/Kconfig
> >>>>> +++ b/arch/riscv/Kconfig
> >>>>> @@ -116,7 +116,8 @@ config PGTABLE_LEVELS
> >>>>>         default 2
> >>>>>
> >>>>>  config HAVE_ARCH_PFN_VALID
> >>>>> -       def_bool y
> >>>>> +       bool
> >>>>> +       default !SPARSEMEM_VMEMMAP
> >>>>>
> >>>>>  menu "Platform type"
> >>>>>
> >>>>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm=
/page.h
> >>>>> index 8ddb6c7fedac..6991f7a5a4a7 100644
> >>>>> --- a/arch/riscv/include/asm/page.h
> >>>>> +++ b/arch/riscv/include/asm/page.h
> >>>>> @@ -93,16 +93,20 @@ extern unsigned long min_low_pfn;
> >>>>>  #define virt_to_pfn(vaddr)     (phys_to_pfn(__pa(vaddr)))
> >>>>>  #define pfn_to_virt(pfn)       (__va(pfn_to_phys(pfn)))
> >>>>>
> >>>>> +#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
> >>>>> +#define pfn_valid(pfn) \
> >>>>> +       (((pfn) >=3D pfn_base) && (((pfn)-pfn_base) < max_mapnr))
> >>>>>  #define virt_to_page(vaddr)    (pfn_to_page(virt_to_pfn(vaddr)))
> >>>>>  #define page_to_virt(page)     (pfn_to_virt(page_to_pfn(page)))
> >>>>> +#else
> >>>>> +#define virt_to_page(vaddr)    ((struct page *)((((u64)vaddr -
> >>>>> va_pa_offset) / PAGE_SIZE) * sizeof(struct page) + VMEMMAP_START))
> >>>>> +#define page_to_virt(pg)       ((void *)(((((u64)pg - VMEMMAP_STAR=
T) /
> >>>>> sizeof(struct page)) * PAGE_SIZE) + va_pa_offset))
> >>>>> +#endif
> >>>>
> >>>> This doesn't make sense to me at all. It should always use pfn_to_pa=
ge()
> >>>> for virt_to_page() and the generic pfn_to_page()/page_to_pfn()
> >>>> implementations essentially already do what you are doing in a clean=
er
> >>>> way. So I'd be really surprised if this does anything at all.
> >>>>
> >>>
> >>> Thank you for point me out that. I just checked the generic
> >>> implementation and I should use that one.
> >>> Sorry I didn't check the generic one and just implement it again.
> >>> I think the only patch we need is the first part to use generic
> >>> pfn_valid(). I just tested it and yes it can boot successfully in dts
> >>> with hole.
> >>>
> >>> It will fail in this check ((pfn)-pfn_base) < max_mapnr.
> >>
> >> Sounds to me like max_mapnr is not set correctly. See the code in
> >> setup_bootmem(). Seems like 'mem_size' should be set to the largest
> >> memory block, not just the one that contains the kernel...
> >>
> >>
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
> >>> index 8ddb6c7fedac..80d28fa1e2eb 100644
> >>> --- a/arch/riscv/include/asm/page.h
> >>> +++ b/arch/riscv/include/asm/page.h
> >>> @@ -100,8 +100,10 @@ extern unsigned long min_low_pfn;
> >>>  #define page_to_bus(page)      (page_to_phys(page))
> >>>  #define phys_to_page(paddr)    (pfn_to_page(phys_to_pfn(paddr)))
> >>>
> >>> +#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
> >>>  #define pfn_valid(pfn) \
> >>>         (((pfn) >=3D pfn_base) && (((pfn)-pfn_base) < max_mapnr))
> >>> +#endif
> >>>
> >>>  #define ARCH_PFN_OFFSET                (pfn_base)
> >>
> >>
> >> This patch still makes no sense. I'm not sure why we have an arch
> >> specific pfn_valid() because it's very similar to the generic one. But
> >> my guess is there's a reason for it and it's not doing what it is
> >> supposed when you remove it for the sparsemem case.
> >
> > It will use another pfn_valid() implementation in
> > include/linux/mmzone.h if CONFIG_SPARSEMEM and
> > !CONFIG_HAVE_ARCH_PFN_VALID
> > It will be this one.
> >
> > static inline int pfn_valid(unsigned long pfn)
> > {
> >         if (pfn_to_section_nr(pfn) >=3D NR_MEM_SECTIONS)
> >                 return 0;
> >         return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> > }
>
> Ah, ok I see. "page.h" is only included in no-mmu arches. Which explains
> why riscv re-implements that macro. Couple follow up questions then:
>
> * Did you test the memory-with-hole scenario without the sparsemem
> patches? It seems pfn_valid() will be wrong regardless of sparse/flat mem=
.
>
> * Any chance we can just use the generic pfn_valid() function in all
> cases not just sparsemem? Can you test that?
>

I think  flat mem doesn't support memory-with-hole scenario.
In mm/Kconfig, it says
"
          For systems that have holes in their physical address
          spaces and for features like NUMA and memory hotplug,
          choose "Sparse Memory"
"
IMHO, the memory-with-hole scenario should only be tested for sparse
mem but flat mem.

The generic pfn_valid() is just for non-mmu arches. Every architecture
with mmu defines their own pfn_valid().
This is supposed to be another separate patch that do we need to
implement a generic pfn_valid().
