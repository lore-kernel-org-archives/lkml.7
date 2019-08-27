Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB96206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="qDYbiUeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfH0J20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:28:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53615 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfH0J20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:28:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so2299840wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KD1R6ByN/3R82p9ak3vm+s3BMXArMxxW+15y2czIGAE=;
        b=qDYbiUeoWbOmkfxAYoW+Q0M1Yc1bU6L9JcwHvViFtTTchUEXYn8vxmejI88vcOcCuv
         c2VllOIlI5ckqOUvgaJNF+OLzkXtgYiZPKT2FAOUFMFXBQma9xjv7VVLvz80100Tm1RO
         38iWQqxwp7S2gWBUIfMvZixUUoLd4tjF9NqZTMXpUljpnkuN29ignL2SbU5z1/ImfKG1
         2qG26xJDBj09/ILW1FgQhaDU6n2Z41OPLUz09ll4qnihSlOfOY1UmIHqs189fpz6mOXG
         rlQGRwbwSBt60FM+2c6uU0Z3K5MlTt2jeFPGKbJBCF+CpqtViC7qMcP+amWl2DzRuF/g
         bbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KD1R6ByN/3R82p9ak3vm+s3BMXArMxxW+15y2czIGAE=;
        b=rAEUZDvH+P0JxbkReKGksHk1zO7wRAh+n4PsW7j+QrTM4CliV0FhJ4PQGTqqyw99im
         wX86rpavyaNnmCLSEywkyISVc1IGjJxHeiaNgfbjHVjl8TeK7rJei0x5PsfGhki92MLE
         iZ+ap5cyPD3OPdrzNA9XVUl2nX9leHIoWVKk40NfQFyzkNdo2VwVjwmW5Ff5ve1uMm+b
         eILb2F7XIhP0rowzNln9Dh4fqncaMQK+jD5SxOTQx5v2rMyRG1FO8GItZNAJdxbXjijb
         xCRiWdeK69+udoj6VPsqgPHx9/G+08cLCej60rSYLkXcngQKIrQt83iD6B9hpICigjD+
         fRKg==
X-Gm-Message-State: APjAAAXs4vSRAdUktoLbSCKa2kLgFqNpYNmvgVBn6ksXDNIgrWPkotHS
        paBRdLsAEou7o63OV9D7IWKh6sY1leRhmrYFUBbMPQ==
X-Google-Smtp-Source: APXvYqzmCKihkrDrdGsBhCo8OeLICgm1ur4vzTRcXbBzmPILVEdii9ui9AtvUYLP9Fqj+muLw2EgeGi6VqJEaJbWowI=
X-Received: by 2002:a1c:3d89:: with SMTP id k131mr25133981wma.24.1566898102426;
 Tue, 27 Aug 2019 02:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190826233256.32383-1-atish.patra@wdc.com> <20190826233256.32383-3-atish.patra@wdc.com>
 <20190827075831.GD682@rapoport-lnx> <CAAhSdy3gynEv1k84pghLY6+HcpBCiteUQUDbGn4_eEH_UFpbCA@mail.gmail.com>
 <20190827083913.GG682@rapoport-lnx>
In-Reply-To: <20190827083913.GG682@rapoport-lnx>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 27 Aug 2019 14:58:11 +0530
Message-ID: <CAAhSdy0wBhcggNOd0C4RapnLbZ-a0TtrQ_XiZHNo9KQnJcUaBA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] RISC-V: Add basic support for SBI v0.2
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 2:09 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Aug 27, 2019 at 01:53:23PM +0530, Anup Patel wrote:
> > On Tue, Aug 27, 2019 at 1:28 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Mon, Aug 26, 2019 at 04:32:56PM -0700, Atish Patra wrote:
> > > > The SBI v0.2 introduces a base extension which is backward compatible
> > > > with v0.1. Implement all helper functions and minimum required SBI
> > > > calls from v0.2 for now. All other base extension function will be
> > > > added later as per need.
> > > >
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >  arch/riscv/include/asm/sbi.h | 68 +++++++++++++++++++++++++++++-------
> > > >  arch/riscv/kernel/Makefile   |  1 +
> > > >  arch/riscv/kernel/sbi.c      | 50 ++++++++++++++++++++++++++
> > > >  arch/riscv/kernel/setup.c    |  2 ++
> > > >  4 files changed, 108 insertions(+), 13 deletions(-)
> > > >  create mode 100644 arch/riscv/kernel/sbi.c
> > > >
> > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > > > index 7f5ecaaaa0d7..4a4476956693 100644
> > > > --- a/arch/riscv/include/asm/sbi.h
> > > > +++ b/arch/riscv/include/asm/sbi.h
> > > > @@ -8,7 +8,6 @@
> > > >
> > > >  #include <linux/types.h>
> > > >
> > > > -
> > > >  #define SBI_EXT_LEGACY_SET_TIMER 0x0
> > > >  #define SBI_EXT_LEGACY_CONSOLE_PUTCHAR 0x1
> > > >  #define SBI_EXT_LEGACY_CONSOLE_GETCHAR 0x2
> > > > @@ -19,28 +18,61 @@
> > > >  #define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID 0x7
> > > >  #define SBI_EXT_LEGACY_SHUTDOWN 0x8
> > > >
> > > > -#define SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3) ({             \
> > > > +#define SBI_EXT_BASE 0x10
> > > > +
> > > > +enum sbi_ext_base_fid {
> > > > +     SBI_EXT_BASE_GET_SPEC_VERSION = 0,
> > > > +     SBI_EXT_BASE_GET_IMP_ID,
> > > > +     SBI_EXT_BASE_GET_IMP_VERSION,
> > > > +     SBI_EXT_BASE_PROBE_EXT,
> > > > +     SBI_EXT_BASE_GET_MVENDORID,
> > > > +     SBI_EXT_BASE_GET_MARCHID,
> > > > +     SBI_EXT_BASE_GET_MIMPID,
> > > > +};
> > > > +
> > > > +#define SBI_CALL_LEGACY(ext, fid, arg0, arg1, arg2, arg3) ({ \
> > > >       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);   \
> > > >       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);   \
> > > >       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);   \
> > > >       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);   \
> > > > -     register uintptr_t a7 asm ("a7") = (uintptr_t)(which);  \
> > > > +     register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);    \
> > > > +     register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);    \
> > > >       asm volatile ("ecall"                                   \
> > > > -                   : "+r" (a0)                               \
> > > > -                   : "r" (a1), "r" (a2), "r" (a3), "r" (a7)  \
> > > > +                   : "+r" (a0), "+r" (a1)                    \
> > > > +                   : "r" (a2), "r" (a3), "r" (a6), "r" (a7) \
> > >
> > > Maybe I'm missing something, but how is this supposed to work on systems
> > > with SBI v0.1? Wouldn't this cause a mismatch in the registers?
> >
> > The SBI v0.2 has two major changes:
> > 1. New improved calling convention which is backward compatible
> > with SBI v0.1 so older kernels with SBI v0.1 will continue to work as-is.
> > 2. Base set of mandatory SBI v0.2 calls which can be used to detect
> > SBI version, check supported SBI calls and extentions.
> >
> > Old calling convention in SBI v0.1 was:
> > Parameters:
> > a0 -> arg0
> > a1 -> arg1
> > a2 -> arg2
> > a3 -> arg3
> > a7 -> function_id
> > Return:
> > a0 -> return value or error code
> >
> > In SBI v0.2, we have extension and function. Each SBI extension
> > is a set of function. The new calling convention in SBI v0.2 is:
> > Parameters:
> > a0 -> arg0
> > a1 -> arg1
> > a2 -> arg2
> > a3 -> arg3
> > a6 -> function_id
> > a7 -> extension_id
> > Return:
> > a0 -> error code
> > a1 -> return value (optional)
>
> So with this patch SBI_CALL_LEGACY() uses SBI v0.2 convention, right?
> Doesn't it mean that you cannot run a new kernel on a system with SBI v0.1?

This is certainly possible. It's just that this patch is using SBI v0.2
convention for older firmware as well.

Ideally, we should check sbi_version for each legacy SBI calls and
use different calling convention based sbi_version. The sbi_version
detection will work fine on both old and new firmwares because
on old firmware SBI version call will fail which means it is SBI v0.1
interface.

I think all legacy calls should be moved to kernel/sbi.c.

I have other comments too.

Let me post detailed review comments.

Regards,
Anup

>
> > All legacy SBI v0.1 functions can be thought of as separate
> > extensions. That's how SBI v0.2 will be backward compatible.
> >
> > Regards,
> > Anup
> >
> > >
> > > >                     : "memory");                              \
> > > >       a0;                                                     \
> > > >  })
> > > >
> > > >  /* Lazy implementations until SBI is finalized */
> > > > -#define SBI_CALL_LEGACY_0(which) SBI_CALL_LEGACY(which, 0, 0, 0, 0)
> > > > -#define SBI_CALL_LEGACY_1(which, arg0) SBI_CALL_LEGACY(which, arg0, 0, 0, 0)
> > > > -#define SBI_CALL_LEGACY_2(which, arg0, arg1) \
> > > > -             SBI_CALL_LEGACY(which, arg0, arg1, 0, 0)
> > > > -#define SBI_CALL_LEGACY_3(which, arg0, arg1, arg2) \
> > > > -             SBI_CALL_LEGACY(which, arg0, arg1, arg2, 0)
> > > > -#define SBI_CALL_LEGACY_4(which, arg0, arg1, arg2, arg3) \
> > > > -             SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3)
> > > > +#define SBI_CALL_LEGACY_0(ext) SBI_CALL_LEGACY(ext, 0, 0, 0, 0, 0)
> > > > +#define SBI_CALL_LEGACY_1(ext, arg0) SBI_CALL_LEGACY(ext, 0, arg0, 0, 0, 0)
> > > > +#define SBI_CALL_LEGACY_2(ext, arg0, arg1) \
> > > > +             SBI_CALL_LEGACY(ext, 0, arg0, arg1, 0, 0)
> > > > +#define SBI_CALL_LEGACY_3(ext, arg0, arg1, arg2) \
> > > > +             SBI_CALL_LEGACY(ext, 0, arg0, arg1, arg2, 0)
> > > > +#define SBI_CALL_LEGACY_4(ext, arg0, arg1, arg2, arg3) \
> > > > +             SBI_CALL_LEGACY(ext, 0, arg0, arg1, arg2, arg3)
> > > > +
> > > > +extern unsigned long sbi_firmware_version;
> > > > +struct sbiret {
> > > > +     long error;
> > > > +     long value;
> > > > +};
> > > > +
> > > > +void riscv_sbi_init(void);
> > > > +struct sbiret riscv_sbi_ecall(int ext, int fid, int arg0, int arg1,
> > > > +                            int arg2, int arg3);
> > > > +
> > > > +#define SBI_CALL_0(ext, fid) riscv_sbi_ecall(ext, fid, 0, 0, 0, 0)
> > > > +#define SBI_CALL_1(ext, fid, arg0) riscv_sbi_ecall(ext, fid, arg0, 0, 0, 0)
> > > > +#define SBI_CALL_2(ext, fid, arg0, arg1) \
> > > > +             riscv_sbi_ecall(ext, fid, arg0, arg1, 0, 0)
> > > > +#define SBI_CALL_3(ext, fid, arg0, arg1, arg2) \
> > > > +             riscv_sbi_ecall(ext, fid, arg0, arg1, arg2, 0)
> > > > +#define SBI_CALL_4(ext, fid, arg0, arg1, arg2, arg3) \
> > > > +             riscv_sbi_ecall(ext, fid, arg0, arg1, arg2, arg3)
> > > > +
> > > >
> > > >  static inline void sbi_console_putchar(int ch)
> > > >  {
> > > > @@ -99,4 +131,14 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> > > >                         start, size, asid);
> > > >  }
> > > >
> > > > +static inline unsigned long riscv_sbi_major_version(void)
> > > > +{
> > > > +     return (sbi_firmware_version >> 24) & 0x7f;
> > > > +}
> > > > +
> > > > +static inline unsigned long riscv_sbi_minor_version(void)
> > > > +{
> > > > +     return sbi_firmware_version & 0xffffff;
> > > > +}
> > > > +
> > > >  #endif
> > > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > > index 2420d37d96de..faf862d26924 100644
> > > > --- a/arch/riscv/kernel/Makefile
> > > > +++ b/arch/riscv/kernel/Makefile
> > > > @@ -17,6 +17,7 @@ obj-y       += irq.o
> > > >  obj-y        += process.o
> > > >  obj-y        += ptrace.o
> > > >  obj-y        += reset.o
> > > > +obj-y        += sbi.o
> > > >  obj-y        += setup.o
> > > >  obj-y        += signal.o
> > > >  obj-y        += syscall_table.o
> > > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > > new file mode 100644
> > > > index 000000000000..457b8cc0e9d9
> > > > --- /dev/null
> > > > +++ b/arch/riscv/kernel/sbi.c
> > > > @@ -0,0 +1,50 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * SBI initialilization and base extension implementation.
> > > > + *
> > > > + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
> > > > + */
> > > > +
> > > > +#include <asm/sbi.h>
> > > > +#include <linux/sched.h>
> > > > +
> > > > +unsigned long sbi_firmware_version;
> > > > +
> > > > +struct sbiret riscv_sbi_ecall(int ext, int fid, int arg0, int arg1,
> > > > +                          int arg2, int arg3)
> > > > +{
> > > > +     struct sbiret ret;
> > > > +
> > > > +     register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> > > > +     register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> > > > +     register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> > > > +     register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> > > > +     register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> > > > +     register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> > > > +     asm volatile ("ecall"
> > > > +                   : "+r" (a0), "+r" (a1)
> > > > +                   : "r" (a2), "r" (a3), "r" (a6), "r" (a7)
> > > > +                   : "memory");
> > > > +     ret.error = a0;
> > > > +     ret.value = a1;
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static struct sbiret sbi_get_spec_version(void)
> > > > +{
> > > > +     return SBI_CALL_0(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION);
> > > > +}
> > > > +
> > > > +void riscv_sbi_init(void)
> > > > +{
> > > > +     struct sbiret ret;
> > > > +
> > > > +     /* legacy SBI version*/
> > > > +     sbi_firmware_version = 0x1;
> > > > +     ret = sbi_get_spec_version();
> > > > +     if (!ret.error)
> > > > +             sbi_firmware_version = ret.value;
> > > > +     pr_info("SBI version implemented in firmware [%lu:%lu]\n",
> > > > +             riscv_sbi_major_version(), riscv_sbi_minor_version());
> > > > +}
> > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > index a990a6cb184f..4c324fd398c8 100644
> > > > --- a/arch/riscv/kernel/setup.c
> > > > +++ b/arch/riscv/kernel/setup.c
> > > > @@ -21,6 +21,7 @@
> > > >  #include <asm/sections.h>
> > > >  #include <asm/pgtable.h>
> > > >  #include <asm/smp.h>
> > > > +#include <asm/sbi.h>
> > > >  #include <asm/tlbflush.h>
> > > >  #include <asm/thread_info.h>
> > > >
> > > > @@ -70,6 +71,7 @@ void __init setup_arch(char **cmdline_p)
> > > >       swiotlb_init(1);
> > > >  #endif
> > > >
> > > > +     riscv_sbi_init();
> > > >  #ifdef CONFIG_SMP
> > > >       setup_smp();
> > > >  #endif
> > > > --
> > > > 2.21.0
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
> > >
>
> --
> Sincerely yours,
> Mike.
>
