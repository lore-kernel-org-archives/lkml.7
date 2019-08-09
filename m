Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C421C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E222070D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p98Vpv2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436923AbfHIRC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:02:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39465 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407436AbfHIRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:02:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so96399213qtu.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FclrxiNVeDQRBUVrlhHeOXQhVrnasVK2qCxhjrZ+ESw=;
        b=p98Vpv2+yYXOmOjE4tNlUje0o/LvDN/IAP+Fw1/Itzh0AJJ/uEtrDzY8ClOf7M0TnO
         mN1LOwLQUEzGyxEbMGGdyJH1s/VCPwzmUZJHTwEG0MVM5qhAx11Sg4ja/z45ABcp0k1W
         aY8RKwKC44kvIKcHqscV8bEWZrvvHnu/s6pcCE4Jpz7LSWYF1xlNVt1UmxKYtSS7ZBEH
         2Dqz8S6e0VM9dFdAnDPj+PdrYisTl43RWG9JC83jwpUaEQwvqrnoQN2IO+39b8X0h4Q+
         76YB2aKWznpt4hd3SQ+cMH0iWVjxSEkSCG9iXTs6wcnPIfgd/Q328wN7GPx/P66NzMiZ
         tGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FclrxiNVeDQRBUVrlhHeOXQhVrnasVK2qCxhjrZ+ESw=;
        b=iFOIRZpoE0D44FlAPRUJz30uDGFStIOsGEdVaAiBLGg0AnLcXTFzZwyjKh8Lj7+OeP
         fDjabjSu96pypwsEoY1DWXuGvuTjV+380EtWFUvrPKArqBB+kEo9aw/4hIAGzrI1sGOh
         pi52FoKU3K1RTrwokrV4DxNwEXz4FpRAAc+xAqaUvNLq3c7EPc25En/FWyY1LBoNnVHY
         6Em4hY8WTT/yK0TRbWZik/neATIMF2GNmJG0swIakj19Jc+p+DKwS41spW7QITDOqbEE
         4z6G7JWV6mzZY2FtE+/P2InYjmT1cMw7heytUkKCgqgoz+weMLvucEEATA9NUAf3U50m
         z7BA==
X-Gm-Message-State: APjAAAXNA7F42Srj/5VhhG6JjHF2LS2PB66wP3IB56hQINy9O0Jj49Xb
        FtFZ2XjAJxm6Ub2+HH94eQBneOz89aiQ+i5V2/I=
X-Google-Smtp-Source: APXvYqz1xhE/4o+0ZlH0Rf7lEhuFwWXCEs3E301pFyqqHmAL1WP299xrXXmTXkvNd9hsV4hnq5V09xAyO+eXSgbaQIA=
X-Received: by 2002:ad4:4423:: with SMTP id e3mr19119365qvt.145.1565370146012;
 Fri, 09 Aug 2019 10:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
 <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com> <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com> <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com>
In-Reply-To: <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Sat, 10 Aug 2019 01:01:50 +0800
Message-ID: <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
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

Logan Gunthorpe <logang@deltatee.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=889=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:47=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
>
>
> On 2019-08-08 10:23 p.m., Greentime Hu wrote:
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
> > index 8ddb6c7fedac..6991f7a5a4a7 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -93,16 +93,20 @@ extern unsigned long min_low_pfn;
> >  #define virt_to_pfn(vaddr)     (phys_to_pfn(__pa(vaddr)))
> >  #define pfn_to_virt(pfn)       (__va(pfn_to_phys(pfn)))
> >
> > +#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
> > +#define pfn_valid(pfn) \
> > +       (((pfn) >=3D pfn_base) && (((pfn)-pfn_base) < max_mapnr))
> >  #define virt_to_page(vaddr)    (pfn_to_page(virt_to_pfn(vaddr)))
> >  #define page_to_virt(page)     (pfn_to_virt(page_to_pfn(page)))
> > +#else
> > +#define virt_to_page(vaddr)    ((struct page *)((((u64)vaddr -
> > va_pa_offset) / PAGE_SIZE) * sizeof(struct page) + VMEMMAP_START))
> > +#define page_to_virt(pg)       ((void *)(((((u64)pg - VMEMMAP_START) /
> > sizeof(struct page)) * PAGE_SIZE) + va_pa_offset))
> > +#endif
>
> This doesn't make sense to me at all. It should always use pfn_to_page()
> for virt_to_page() and the generic pfn_to_page()/page_to_pfn()
> implementations essentially already do what you are doing in a cleaner
> way. So I'd be really surprised if this does anything at all.
>

Thank you for point me out that. I just checked the generic
implementation and I should use that one.
Sorry I didn't check the generic one and just implement it again.
I think the only patch we need is the first part to use generic
pfn_valid(). I just tested it and yes it can boot successfully in dts
with hole.

It will fail in this check ((pfn)-pfn_base) < max_mapnr.
In my test case it will be
((6GB>>PAGE_SHIFT)-(2GB>>PAGE_SHIFT)=3D(4GB>>PAGE_SHIFT) <
(3GB>>PAGE_SHIFT) to return false.
 memory@80000000 {
         device_type =3D "memory";
         reg =3D <0x0 0x80000000 0x0 0x80000000>;
 };
 memory@180000000 {
         device_type =3D "memory";
         reg =3D <0x1 0x80000000 0x0 0x40000000>;
 };

To cause the check here failed to initialize page struct.

for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
        /*
         * There can be holes in boot-time mem_map[]s handed to this
         * function.  They do not exist on hotplugged memory.
         */
        if (context =3D=3D MEMMAP_EARLY) {
                if (!early_pfn_valid(pfn))
                        continue;
                if (!early_pfn_in_nid(pfn, nid))
                        continue;
                if (overlap_memmap_init(zone, &pfn))
                        continue;
                if (defer_init(nid, pfn, end_pfn))
                        break;
        }

        page =3D pfn_to_page(pfn);
        __init_single_page(page, pfn, zone, nid);


---------------------------------------------------------------------------=
---

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3f12b069af1d..208b3e14ccd8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -116,7 +116,8 @@ config PGTABLE_LEVELS
        default 2

 config HAVE_ARCH_PFN_VALID
-       def_bool y
+       bool
+       default !SPARSEMEM_VMEMMAP

 menu "Platform type"

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 8ddb6c7fedac..80d28fa1e2eb 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -100,8 +100,10 @@ extern unsigned long min_low_pfn;
 #define page_to_bus(page)      (page_to_phys(page))
 #define phys_to_page(paddr)    (pfn_to_page(phys_to_pfn(paddr)))

+#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define pfn_valid(pfn) \
        (((pfn) >=3D pfn_base) && (((pfn)-pfn_base) < max_mapnr))
+#endif

 #define ARCH_PFN_OFFSET                (pfn_base)
