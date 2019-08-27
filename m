Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA592C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9949620828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="lNRHf/uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfH0JhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:37:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40954 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfH0JhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:37:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so18062585wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IV7f04O4NGHb2ANdnDGozNNJXYBrKg4ALn4SZ5C75rg=;
        b=lNRHf/ufr2g4BVhnZbV44iuKaYDSnfHRE3AYjHtHdaHw6Av+ZtNquOed+xALodlURD
         O/1+/BGHbK66VW7iseWAGCuDdQ27bW8/2FURXSpvNMxjJkb3QmRKGr8zX7Xqzw4r8JSl
         Hizuirmjs45Okqu62efIizHjaHiAW9QUxfzt16Psdpp9qTgocn4hCVUwBUTbQP/funsp
         iYP1QyBdCJcTZ21AGLE8LJSu4G9EgRS6+G0q+otPZzx6i1pQVZ31GgFniisHCFuohycw
         yI/7UT9AlJvpnB55Y8A+O5kQmeXO1ii67LOc+wd4xxDBfZ4nMUAdLi/lKFpyqhZNvlep
         iouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IV7f04O4NGHb2ANdnDGozNNJXYBrKg4ALn4SZ5C75rg=;
        b=f6FQHskaYMtu2R9SkYUN6d3A9gRpEGmMpMzYRroqBWz57Z5VSiK+wvMOX0OWw+RHuQ
         C4UtdE/J9ryGtQ2EXY79oup4LYR5vybQgldpCLvD79tnnPk5iCNIDfcUYfZ9vV3l8m8B
         lQLS8qO17ublWFvVdtnEB/R7I8tV7TGNN30hiT6029KbakDYSgzXi8XhsxWZX2EleZUn
         973fpuLj+X0a+DJO1OD2HWvdFaxVHOCntDosvomBWNFm17b+tRVEx2tRznabKYdyXsa9
         fkRd6kJ1a5zaeRM7Eo4NaQ93MQPGQeULQ4y/28RbkfDxh3D34G6hDc3XBCcFtbkwO4+I
         wYjw==
X-Gm-Message-State: APjAAAVzsgR2ai5w09JxPMyDP+l4A2kleYth8pvocF0PUXrt3PBZzJtY
        eVMB9C5UmKgGpkYOXKuLIy40h7POBHAH5idcoymPSA==
X-Google-Smtp-Source: APXvYqyyhce71ARF6qZk6l8ClBMFCyVYDYFrxmy72sz8U/+9ZvjclTuZr/4w3v7Ke6KXbnlIPfY1JHhxZ1EOIUmIbsQ=
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr27675823wrv.323.1566898626499;
 Tue, 27 Aug 2019 02:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190826233256.32383-1-atish.patra@wdc.com> <20190826233256.32383-3-atish.patra@wdc.com>
In-Reply-To: <20190826233256.32383-3-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 27 Aug 2019 15:06:55 +0530
Message-ID: <CAAhSdy35btg0SPDsrS70DezJpjrzmn07v2z04s65D_-U+NKPGA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] RISC-V: Add basic support for SBI v0.2
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 5:03 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> The SBI v0.2 introduces a base extension which is backward compatible
> with v0.1. Implement all helper functions and minimum required SBI
> calls from v0.2 for now. All other base extension function will be
> added later as per need.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 68 +++++++++++++++++++++++++++++-------
>  arch/riscv/kernel/Makefile   |  1 +
>  arch/riscv/kernel/sbi.c      | 50 ++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c    |  2 ++
>  4 files changed, 108 insertions(+), 13 deletions(-)
>  create mode 100644 arch/riscv/kernel/sbi.c
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 7f5ecaaaa0d7..4a4476956693 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -8,7 +8,6 @@
>
>  #include <linux/types.h>
>
> -
>  #define SBI_EXT_LEGACY_SET_TIMER 0x0
>  #define SBI_EXT_LEGACY_CONSOLE_PUTCHAR 0x1
>  #define SBI_EXT_LEGACY_CONSOLE_GETCHAR 0x2
> @@ -19,28 +18,61 @@
>  #define SBI_EXT_LEGACY_REMOTE_SFENCE_VMA_ASID 0x7
>  #define SBI_EXT_LEGACY_SHUTDOWN 0x8
>
> -#define SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3) ({             \
> +#define SBI_EXT_BASE 0x10
> +
> +enum sbi_ext_base_fid {
> +       SBI_EXT_BASE_GET_SPEC_VERSION = 0,
> +       SBI_EXT_BASE_GET_IMP_ID,
> +       SBI_EXT_BASE_GET_IMP_VERSION,
> +       SBI_EXT_BASE_PROBE_EXT,
> +       SBI_EXT_BASE_GET_MVENDORID,
> +       SBI_EXT_BASE_GET_MARCHID,
> +       SBI_EXT_BASE_GET_MIMPID,
> +};
> +
> +#define SBI_CALL_LEGACY(ext, fid, arg0, arg1, arg2, arg3) ({   \
>         register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);   \
>         register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);   \
>         register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);   \
>         register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);   \
> -       register uintptr_t a7 asm ("a7") = (uintptr_t)(which);  \
> +       register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);    \
> +       register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);    \
>         asm volatile ("ecall"                                   \
> -                     : "+r" (a0)                               \
> -                     : "r" (a1), "r" (a2), "r" (a3), "r" (a7)  \
> +                     : "+r" (a0), "+r" (a1)                    \
> +                     : "r" (a2), "r" (a3), "r" (a6), "r" (a7) \
>                       : "memory");                              \
>         a0;                                                     \
>  })

I think instead of removing old convention we should use
calling convention based on sbi_version detected at boot-time.

>
>  /* Lazy implementations until SBI is finalized */
> -#define SBI_CALL_LEGACY_0(which) SBI_CALL_LEGACY(which, 0, 0, 0, 0)
> -#define SBI_CALL_LEGACY_1(which, arg0) SBI_CALL_LEGACY(which, arg0, 0, 0, 0)
> -#define SBI_CALL_LEGACY_2(which, arg0, arg1) \
> -               SBI_CALL_LEGACY(which, arg0, arg1, 0, 0)
> -#define SBI_CALL_LEGACY_3(which, arg0, arg1, arg2) \
> -               SBI_CALL_LEGACY(which, arg0, arg1, arg2, 0)
> -#define SBI_CALL_LEGACY_4(which, arg0, arg1, arg2, arg3) \
> -               SBI_CALL_LEGACY(which, arg0, arg1, arg2, arg3)
> +#define SBI_CALL_LEGACY_0(ext) SBI_CALL_LEGACY(ext, 0, 0, 0, 0, 0)
> +#define SBI_CALL_LEGACY_1(ext, arg0) SBI_CALL_LEGACY(ext, 0, arg0, 0, 0, 0)
> +#define SBI_CALL_LEGACY_2(ext, arg0, arg1) \
> +               SBI_CALL_LEGACY(ext, 0, arg0, arg1, 0, 0)
> +#define SBI_CALL_LEGACY_3(ext, arg0, arg1, arg2) \
> +               SBI_CALL_LEGACY(ext, 0, arg0, arg1, arg2, 0)
> +#define SBI_CALL_LEGACY_4(ext, arg0, arg1, arg2, arg3) \
> +               SBI_CALL_LEGACY(ext, 0, arg0, arg1, arg2, arg3)
> +
> +extern unsigned long sbi_firmware_version;
> +struct sbiret {
> +       long error;
> +       long value;
> +};
> +
> +void riscv_sbi_init(void);
> +struct sbiret riscv_sbi_ecall(int ext, int fid, int arg0, int arg1,
> +                              int arg2, int arg3);
> +
> +#define SBI_CALL_0(ext, fid) riscv_sbi_ecall(ext, fid, 0, 0, 0, 0)
> +#define SBI_CALL_1(ext, fid, arg0) riscv_sbi_ecall(ext, fid, arg0, 0, 0, 0)
> +#define SBI_CALL_2(ext, fid, arg0, arg1) \
> +               riscv_sbi_ecall(ext, fid, arg0, arg1, 0, 0)
> +#define SBI_CALL_3(ext, fid, arg0, arg1, arg2) \
> +               riscv_sbi_ecall(ext, fid, arg0, arg1, arg2, 0)
> +#define SBI_CALL_4(ext, fid, arg0, arg1, arg2, arg3) \
> +               riscv_sbi_ecall(ext, fid, arg0, arg1, arg2, arg3)
> +
>
>  static inline void sbi_console_putchar(int ch)
>  {
> @@ -99,4 +131,14 @@ static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>                           start, size, asid);
>  }

To be sure that new kernels work fine on older kernel, we
can be conservative and move all legacy SBI calls to kernel/sbi.c.
All legacy SBI calls can check sbi_version and use appropriate
SBI calling convention.

This might be redundant if we can ensure that newer kernels
work fine with older SBI v0.1 firmwares.

>
> +static inline unsigned long riscv_sbi_major_version(void)
> +{
> +       return (sbi_firmware_version >> 24) & 0x7f;
> +}
> +
> +static inline unsigned long riscv_sbi_minor_version(void)
> +{
> +       return sbi_firmware_version & 0xffffff;
> +}
> +
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 2420d37d96de..faf862d26924 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -17,6 +17,7 @@ obj-y += irq.o
>  obj-y  += process.o
>  obj-y  += ptrace.o
>  obj-y  += reset.o
> +obj-y  += sbi.o
>  obj-y  += setup.o
>  obj-y  += signal.o
>  obj-y  += syscall_table.o
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> new file mode 100644
> index 000000000000..457b8cc0e9d9
> --- /dev/null
> +++ b/arch/riscv/kernel/sbi.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SBI initialilization and base extension implementation.
> + *
> + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <asm/sbi.h>
> +#include <linux/sched.h>
> +
> +unsigned long sbi_firmware_version;

Rename this too sbi_version or sbi_spec_version.
The firmware version is different thing.

> +
> +struct sbiret riscv_sbi_ecall(int ext, int fid, int arg0, int arg1,
> +                            int arg2, int arg3)
> +{
> +       struct sbiret ret;
> +
> +       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> +       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> +       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> +       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> +       register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> +       register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> +       asm volatile ("ecall"
> +                     : "+r" (a0), "+r" (a1)
> +                     : "r" (a2), "r" (a3), "r" (a6), "r" (a7)
> +                     : "memory");
> +       ret.error = a0;
> +       ret.value = a1;
> +
> +       return ret;
> +}
> +
> +static struct sbiret sbi_get_spec_version(void)
> +{
> +       return SBI_CALL_0(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION);
> +}
> +
> +void riscv_sbi_init(void)
> +{
> +       struct sbiret ret;
> +
> +       /* legacy SBI version*/
> +       sbi_firmware_version = 0x1;
> +       ret = sbi_get_spec_version();
> +       if (!ret.error)
> +               sbi_firmware_version = ret.value;
> +       pr_info("SBI version implemented in firmware [%lu:%lu]\n",
> +               riscv_sbi_major_version(), riscv_sbi_minor_version());

Should we not print SBI implementation ID and SBI firmware version.

Regards,
Anup

> +}
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index a990a6cb184f..4c324fd398c8 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -21,6 +21,7 @@
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
>  #include <asm/smp.h>
> +#include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/thread_info.h>
>
> @@ -70,6 +71,7 @@ void __init setup_arch(char **cmdline_p)
>         swiotlb_init(1);
>  #endif
>
> +       riscv_sbi_init();
>  #ifdef CONFIG_SMP
>         setup_smp();
>  #endif
> --
> 2.21.0
>
