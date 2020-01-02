Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBCC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A2B215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PeAnZdpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgABDtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:49:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39755 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABDtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:49:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so55280801oty.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 19:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAZWbwwfUkVb6p5+Q1nHSm8L0LTm2aiAcQDF8GpNwZk=;
        b=PeAnZdpzin0SiweJmAKbZ7tGf+WHxWKMuQUAn0R1Q4X5MBtUILBw0be0mCzLxx7dLg
         Y1ocadO2QeXjNPfozXkEfcDoeWxKGE4bD2+a+MAHtUj3+UfbuYGFBVxz95GJMM6Aqcfe
         lf7Q+McdAhwi/DAEGGwKKBN12Gz1cs8sUiOjgTC5hD17zw1d6+r+FXjnQM8JshU2FF8h
         F4PfDMeaLqw9jymonBBuPSy+N41OQfdChjwuO68xSeGXfu8hm2nb8S/bbzxWmIJhKDA8
         m6HB4c3v4Z5NDxR5mnWiZt4shOJj2rmdulKEdZGXd17ggTOe6RjkoPCxj+3HreSv3rsL
         uZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAZWbwwfUkVb6p5+Q1nHSm8L0LTm2aiAcQDF8GpNwZk=;
        b=o/Cxo/x1AC6efvSkRYgdT8xzNeJ4Gj5x4upcmnuaHyzjIQ5dZM5hozFXn8LGTqdLFU
         AnDmGl8XDRWGO95rGLy4TUJPLov3AHmsCZpSEz6tcGQ0TyepJE2Y8Z+L92SXUbGaqMeZ
         y5i+EyMshk41ZfSMA3KXIP9WtheqDjbI7YLPyET3sRIlN1F0DcMpEvzPQORgmIn4E3bZ
         mlO5O7uUwbQljyJPicBKG64PG83HdWy3n8uNl0UtBT4ptZdx4cyxo/hVA8pjxQI52BQ3
         Cd+UdWkh6XLbheZSU0vUNgIfdihaSvOYzEFh6qIBnYJ9Umt2Y1XS9wR5c26hMgs5Wv6u
         NLzA==
X-Gm-Message-State: APjAAAXiacCql2z2LvcahvmRYpC064FzzoYmQ3mj8FnsV7G3v3Nkk+mG
        SGZ2UfO6ufMFxovBwNO18eBujM24+TG5vZpj5/9pCQ==
X-Google-Smtp-Source: APXvYqywXpa/Npr3CqGui1M+Ck/9E84gKqQV0hHmjJWX1i+iiistDvuhhUTd0M/gmnfwxd9OX67eXymSKvDEkkHWs0c=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr92201599otq.75.1577936993075;
 Wed, 01 Jan 2020 19:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20200102031240.44484-1-zong.li@sifive.com> <20200102031240.44484-3-zong.li@sifive.com>
 <CAAhSdy0sp_=nwAKxphA8of4UV_NfxHE-KXyTPekmHkieq_XyVw@mail.gmail.com>
In-Reply-To: <CAAhSdy0sp_=nwAKxphA8of4UV_NfxHE-KXyTPekmHkieq_XyVw@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 2 Jan 2020 11:49:43 +0800
Message-ID: <CANXhq0rHOj6_UetWEnvNw4TzwWR9tzWTAJysxqknPN1Ng1Pu8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: mm: use __pa_symbol for kernel symbols
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 2, 2020 at 11:32 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Jan 2, 2020 at 8:42 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > __pa_symbol is the marcro that should be used for kernel symbols. It is
> > also a pre-requisite for DEBUG_VIRTUAL which will do bounds checking.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/mm/init.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 69f6678db7f3..965a8cf4829c 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -99,13 +99,13 @@ static void __init setup_initrd(void)
> >                 pr_info("initrd not found or empty");
> >                 goto disable;
> >         }
> > -       if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> > +       if (__pa_symbol(initrd_end) > PFN_PHYS(max_low_pfn)) {
> >                 pr_err("initrd extends beyond end of memory");
> >                 goto disable;
> >         }
> >
> >         size = initrd_end - initrd_start;
> > -       memblock_reserve(__pa(initrd_start), size);
> > +       memblock_reserve(__pa_symbol(initrd_start), size);
> >         initrd_below_start_ok = 1;
> >
> >         pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
> > @@ -124,8 +124,8 @@ void __init setup_bootmem(void)
> >  {
> >         struct memblock_region *reg;
> >         phys_addr_t mem_size = 0;
> > -       phys_addr_t vmlinux_end = __pa(&_end);
> > -       phys_addr_t vmlinux_start = __pa(&_start);
> > +       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> > +       phys_addr_t vmlinux_start = __pa_symbol(&_start);
> >
> >         /* Find the memory region containing the kernel */
> >         for_each_memblock(memory, reg) {
> > @@ -445,7 +445,7 @@ static void __init setup_vm_final(void)
> >
> >         /* Setup swapper PGD for fixmap */
> >         create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
> > -                          __pa(fixmap_pgd_next),
> > +                          __pa_symbol(fixmap_pgd_next),
> >                            PGDIR_SIZE, PAGE_TABLE);
> >
> >         /* Map all memory banks */
> > @@ -474,7 +474,7 @@ static void __init setup_vm_final(void)
> >         clear_fixmap(FIX_PMD);
> >
> >         /* Move to swapper page table */
> > -       csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | SATP_MODE);
> > +       csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
> >         local_flush_tlb_all();
> >  }
> >  #else
> > --
> > 2.24.1
> >
>
> Overall looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> I have not tried this patch but can you confirm that
> __pa_symbol() works fine even when DEBUG_VIRTUAL=n

Yes, it works fine through original way when DEBUG_VIRTUAL is not set.

>
> Regards,
> Anup
