Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B7AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 05:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B01320733
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 05:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOJCEraL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfLRFJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 00:09:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37194 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 00:09:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so815628wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 21:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMFLnH21NJeulxobc8jd+JOZHWZhD/TqTEQSCvvfO5g=;
        b=pOJCEraLG6sj/m+Q+Cg1f/ZNeRPDCD9xsVbILF16rOjhjZtRMD/NLReS1hljov2VBn
         QDuy6ImonyoJVqkDUSkvlZkd6HzzSu5aAKAhBEfTpkKqdTaBgGwubR695w8qHW4BA4OQ
         htIk7KvDBfgJEd8c6Mj5M4bZ/zOjuHYAIJX9vpOCHrtpvQCwRE+s/5bdlDx6SJCNh/MK
         3nSXWVjnC4fusP8UGiwgDvZjrBcfCxXL3w3Pf8htbgz0mI+IlhQ5eyE0zTOijPT5p+ld
         UvsSE4uWeOzq4NEMF5sZv6QNE0A4DbfF9HIYVTJJ9NJGDUrEb2nAwJb3vJBS1I4weZMs
         HAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMFLnH21NJeulxobc8jd+JOZHWZhD/TqTEQSCvvfO5g=;
        b=DCr5o6nu9dYA7alFA+MuBv7A+gTf9T81GPcb+Wk14Sc8UZHUcr71TMm3NOJN3Po7Rb
         nXys1+QT8P8tLO0ONGVXubxGQZg8eaKYIFjSgK7Tfi5x1ZWJ3Kf5HJsb+tofnrAVPocW
         0hOMYqyLJ6cWgaCBm9lJPK6OOq265CDdMoSfbbwnl4c032Dlpy25icRFMxriBh+NyzxG
         p6Af8xGyXviIaNkD6RLqHqvHoSzxrk341enavL0dV0BXW2//GkhtXk346Cv/vHZpj4Fd
         C1mx0tXAQaBH3sKnGCWo0KvEi7wWhVDpcBlpa/6ubdHD3A8+vqVVLQh/Yh/mQha/VYU9
         SP4w==
X-Gm-Message-State: APjAAAUCV2Iocd5nO6xvikfKOuCTZc13Opta7s40kZX/bbiqZKc1QnpM
        ZkJ0730wE0BzlsOj/NNmtBc5tvrQrmjDR5lT3Hs=
X-Google-Smtp-Source: APXvYqymmBZJ8ipE4muhBx7w/9ro17xjwTEBDtEd8pQpMmt0+M/PkTNH1ms/vTESSvgKX1xaz5BZOBdef15tASHOn9o=
X-Received: by 2002:adf:e74a:: with SMTP id c10mr301019wrn.386.1576645763875;
 Tue, 17 Dec 2019 21:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20191217131530.513096-1-david.abdurachmanov@sifive.com> <CAAhSdy1pz5Zmrdm6hBxugjbBiw3d25XZJ47rpKgVk7fHaoEr6Q@mail.gmail.com>
In-Reply-To: <CAAhSdy1pz5Zmrdm6hBxugjbBiw3d25XZJ47rpKgVk7fHaoEr6Q@mail.gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Wed, 18 Dec 2019 07:08:47 +0200
Message-ID: <CAEn-LTpvd3=qR8X91JpE6Or3aEH9=F3jz7_N4Y3fA+CgMu+wJg@mail.gmail.com>
Subject: Re: [PATCH] define vmemmap before pfn_to_page calls
To:     Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 5:46 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Dec 17, 2019 at 6:45 PM David Abdurachmanov
> <david.abdurachmanov@gmail.com> wrote:
> >
> > pfn_to_page call depends on `vmemmap` being available before the call.
> > This caused compilation errors in Fedora/RISCV with 5.5-rc2 and was caused
> > by NOMMU changes which moved declarations after functions definitions.
> >
> > Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
> > Fixes: 6bd33e1ece52 ("riscv: add nommu support")
> > ---
> >  arch/riscv/include/asm/pgtable.h | 34 ++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 7ff0ed4f292e..d8c89e6e6b3d 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -90,6 +90,23 @@ extern pgd_t swapper_pg_dir[];
> >  #define __S110 PAGE_SHARED_EXEC
> >  #define __S111 PAGE_SHARED_EXEC
> >
> > +#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> > +#define VMALLOC_END      (PAGE_OFFSET - 1)
> > +#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> > +
> > +/*
> > + * Roughly size the vmemmap space to be large enough to fit enough
> > + * struct pages to map half the virtual address space. Then
> > + * position vmemmap directly below the VMALLOC region.
> > + */
> > +#define VMEMMAP_SHIFT \
> > +       (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> > +#define VMEMMAP_SIZE   BIT(VMEMMAP_SHIFT)
> > +#define VMEMMAP_END    (VMALLOC_START - 1)
> > +#define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> > +
> > +#define vmemmap                ((struct page *)VMEMMAP_START)
> > +
> >  static inline int pmd_present(pmd_t pmd)
> >  {
> >         return (pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
> > @@ -400,23 +417,6 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> >  #define __pte_to_swp_entry(pte)        ((swp_entry_t) { pte_val(pte) })
> >  #define __swp_entry_to_pte(x)  ((pte_t) { (x).val })
> >
> > -#define VMALLOC_SIZE     (KERN_VIRT_SIZE >> 1)
> > -#define VMALLOC_END      (PAGE_OFFSET - 1)
> > -#define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> > -
> > -/*
> > - * Roughly size the vmemmap space to be large enough to fit enough
> > - * struct pages to map half the virtual address space. Then
> > - * position vmemmap directly below the VMALLOC region.
> > - */
> > -#define VMEMMAP_SHIFT \
> > -       (CONFIG_VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> > -#define VMEMMAP_SIZE   BIT(VMEMMAP_SHIFT)
> > -#define VMEMMAP_END    (VMALLOC_START - 1)
> > -#define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> > -
> > -#define vmemmap                ((struct page *)VMEMMAP_START)
> > -
> >  #define PCI_IO_SIZE      SZ_16M
> >  #define PCI_IO_END       VMEMMAP_START
> >  #define PCI_IO_START     (PCI_IO_END - PCI_IO_SIZE)
> > --
> > 2.23.0
> >
>
> Can you add a comment for "#define vmemmap" about your findings ?

I send v2 in a few hours with extra comment. I will mention that this
is needed if CONFIG_SPARSEMEM_VMEMMAP=y
See https://github.com/torvalds/linux/blob/master/include/asm-generic/memory_model.h

>
> Otherwise looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup
