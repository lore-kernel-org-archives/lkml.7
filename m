Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1084FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12E52182B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E58Me3Tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfE0OfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:35:10 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52143 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfE0OfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:35:10 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so27186795itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+XqkDysJ2lvGlKGrEtCwy0REIn7B+jIsk/sq1Q8Vh4=;
        b=E58Me3Tz1u/QoiJcikhnl2d3zng3tBKgKOumiiI6dv2g3y+O7kUWnv7Pjq1daDAW79
         D2ql/54QGPpUXEJlVLf2QocUirkcgoXaaf/MjFWeKtGv61T7bqi3EGvs+kqw+aDoZm6U
         vUW13b0mgBtfzU12+Dn6KuQDB/9foTXqGWLFv9noMC6JAPcNgTJPOzS6loCDWxKIwINN
         qt9tTZ42Nln/51H+8Zs00WfTMpQ/oeL9GMy7UNOXI9kWI102D1r/e8b2sa7+c+GEO5Wz
         FdTjUzSurlM44w2QWdZPiK+JHXLBf5eKib57d7N3Q0ovqeyEocFdmNsdRT85vnro54qq
         O6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+XqkDysJ2lvGlKGrEtCwy0REIn7B+jIsk/sq1Q8Vh4=;
        b=EvLgPEfvCgfsP8uPcNq52ptc763niglURoUV7VZFhRs/rjAL0GdJwRI+PaDOWJpM8M
         yH+pcKrMOj13RA97R1Ma5GbyuT2aYJ3wOV61ab4ZhgDnEMRfPaKKo+iPEGldx6Toj4QF
         1SXSoMnalVuMaid8UgqyW4oL3OtE691f+sbBzAt1TBTC5kYoQhyHVPsql0gQu3oCXtxy
         g6ryV3wT2NyNiYw4Vl6Ebbz1kH8tPA78wDVScmavdoBF+XenpwY51s3byrgOKg2PR/9+
         o4twz2riRqdICso332UaVYqWm4QRCIL+BSqXhUVukNK09nbtwJki7UVFL/W05Vlg8OtG
         hxWA==
X-Gm-Message-State: APjAAAUJu15ai6UKB3Zp8mWClUJ9CXcL1P1Msi+URNm+uIjmiW9DoFbN
        dwYTU50x4ztSr64Lce40xL2qHp4ZBYRpFZaB+fjHiQ==
X-Google-Smtp-Source: APXvYqysuSDkEC03OKzYxKO9hKrSv/c6TWgGj1d7E77j/f1DATyHT2dJDdLLf5mCtN+89X3xLa7S0wjnjSrQaDCZhIY=
X-Received: by 2002:a02:ce37:: with SMTP id v23mr6771111jar.2.1558967709273;
 Mon, 27 May 2019 07:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190524041814.7497-1-atish.patra@wdc.com>
In-Reply-To: <20190524041814.7497-1-atish.patra@wdc.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 27 May 2019 16:34:57 +0200
Message-ID: <CAKv+Gu9U56b50TrfriBfRFed_1aoXg2Y624tu7v5m2y+6DVq5w@mail.gmail.com>
Subject: Re: [v4 PATCH] RISC-V: Add an Image header that boot loader can parse.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Karsten Merker <merker@debian.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 at 06:18, Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, the last stage boot loaders such as U-Boot can accept only
> uImage which is an unnecessary additional step in automating boot
> process.
>
> Add an image header that boot loader understands and boot Linux from
> flat Image directly.
>
> This header is based on ARM64 boot image header and provides an
> opportunity to combine both ARM64 & RISC-V image headers in future.
>
> Also make sure that PE/COFF header can co-exist in the same image so
> that EFI stub can be supported for RISC-V in future. EFI specification
> needs PE/COFF image header in the beginning of the kernel image in order
> to load it as an EFI application. In order to support EFI stub, code0
> should be replaced with "MZ" magic string and res4(at offset 0x3c)
> should point to the rest of the PE/COFF header (which will be added
> during EFI support).
>
> Tested on both QEMU and HiFive Unleashed using OpenSBI + U-Boot + Linux.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Karsten Merker <merker@debian.org>
> Tested-by: Karsten Merker <merker@debian.org> (QEMU+OpenSBI+U-Boot)
>
> ---
> I have not sent out corresponding U-Boot patch as all the changes are
> compatible with current u-boot support. Once, the kernel header format
> is agreed upon, I will update the U-Boot patch.
>
> Changes from v3->v4
> 1. Update the commit text to clarify about PE/COFF header.
>
> Changes from v2->v3
> 1. Modified reserved fields to define a header version.
> 2. Added header documentation.
>
> Changes from v1-v2:
> 1. Added additional reserved elements to make it fully PE compatible.
> ---
>  Documentation/riscv/boot-image-header.txt | 50 ++++++++++++++++++
>  arch/riscv/include/asm/image.h            | 64 +++++++++++++++++++++++
>  arch/riscv/kernel/head.S                  | 32 ++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 Documentation/riscv/boot-image-header.txt
>  create mode 100644 arch/riscv/include/asm/image.h
>
> diff --git a/Documentation/riscv/boot-image-header.txt b/Documentation/riscv/boot-image-header.txt
> new file mode 100644
> index 000000000000..68abc2353cec
> --- /dev/null
> +++ b/Documentation/riscv/boot-image-header.txt
> @@ -0,0 +1,50 @@
> +                               Boot image header in RISC-V Linux
> +                       =============================================
> +
> +Author: Atish Patra <atish.patra@wdc.com>
> +Date  : 20 May 2019
> +
> +This document only describes the boot image header details for RISC-V Linux.
> +The complete booting guide will be available at Documentation/riscv/booting.txt.
> +
> +The following 64-byte header is present in decompressed Linux kernel image.
> +
> +       u32 code0;                /* Executable code */
> +       u32 code1;                /* Executable code */

Apologies for not mentioning this in my previous reply, but given that
you already know that you will need to put the magic string MZ at
offset 0x0, it makes more sense to not put any code there at all, but
educate the bootloader that the first executable instruction is at
offset 0x20, and put the spare fields right after it in case you ever
need more than 2 slots. (On arm64, we were lucky to be able to find an
opcode that happened to contain the MZ bit pattern and act almost like
a NOP, but it seems silly to rely on that for RISC-V as well)

So something like

u16 pe_res1;  /* MZ for EFI bootable images, don't care otherwise */
u8 magic[6];    /* "RISCV\0"

u64 text_offset;          /* Image load offset, little endian */
u64 image_size;           /* Effective Image size, little endian */
u64 flags;                /* kernel flags, little endian */

u32 code0;                /* Executable code */
u32 code1;                /* Executable code */

u64 reserved[2];     /* reserved for future use */

u32 version;              /* Version of this header */
u32 pe_res2;                 /* Reserved for PE COFF offset */



> +This header format is compliant with PE/COFF header and largely inspired from
> +ARM64 header. Thus, both ARM64 & RISC-V header can be combined into one common
> +header in future.
> +
> +Notes:
> +- This header can also be reused to support EFI stub for RISC-V in future. EFI
> +  specification needs PE/COFF image header in the beginning of the kernel image
> +  in order to load it as an EFI application. In order to support EFI stub,
> +  code0 should be replaced with "MZ" magic string and res5(at offset 0x3c) should
> +  point to the rest of the PE/COFF header.
> +
> +- version field indicate header version number.
> +       Bits 0:15  - Minor version
> +       Bits 16:31 - Major version
> +
> +  This preserves compatibility across newer and older version of the header.
> +  The current version is defined as 0.1.
> +
> +- res3 is reserved for offset to any other additional fields. This makes the
> +  header extendible in future. One example would be to accommodate ISA
> +  extension for RISC-V in future. For current version, it is set to be zero.
> +
> +- In current header, the flag field has only one field.
> +       Bit 0: Kernel endianness. 1 if BE, 0 if LE.
> +
> +- Image size is mandatory for boot loader to load kernel image. Booting will
> +  fail otherwise.
> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> new file mode 100644
> index 000000000000..61c9f20d2f19
> --- /dev/null
> +++ b/arch/riscv/include/asm/image.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_IMAGE_H
> +#define __ASM_IMAGE_H
> +
> +#define RISCV_IMAGE_MAGIC      "RISCV"
> +
> +
> +#define RISCV_IMAGE_FLAG_BE_SHIFT      0
> +#define RISCV_IMAGE_FLAG_BE_MASK       0x1
> +
> +#define RISCV_IMAGE_FLAG_LE            0
> +#define RISCV_IMAGE_FLAG_BE            1
> +
> +
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +#define __HEAD_FLAG_BE         RISCV_IMAGE_FLAG_BE
> +#else
> +#define __HEAD_FLAG_BE         RISCV_IMAGE_FLAG_LE
> +#endif
> +
> +#define __HEAD_FLAG(field)     (__HEAD_FLAG_##field << \
> +                               RISCV_IMAGE_FLAG_##field##_SHIFT)
> +
> +#define __HEAD_FLAGS           (__HEAD_FLAG(BE))
> +
> +#define RISCV_HEADER_VERSION_MAJOR 0
> +#define RISCV_HEADER_VERSION_MINOR 1
> +
> +#define RISCV_HEADER_VERSION (RISCV_HEADER_VERSION_MAJOR << 16 | \
> +                             RISCV_HEADER_VERSION_MINOR)
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * struct riscv_image_header - riscv kernel image header
> + *
> + * @code0:             Executable code
> + * @code1:             Executable code
> + * @text_offset:       Image load offset
> + * @image_size:                Effective Image size
> + * @flags:             kernel flags
> + * @version:           version
> + * @reserved:          reserved
> + * @reserved:          reserved
> + * @magic:             Magic number
> + * @reserved:          reserved (will be used for additional RISC-V specific header)
> + * @reserved:          reserved (will be used for PE COFF offset)
> + */
> +
> +struct riscv_image_header {
> +       u32 code0;
> +       u32 code1;
> +       u64 text_offset;
> +       u64 image_size;
> +       u64 flags;
> +       u32 version;
> +       u32 res1;
> +       u64 res2;
> +       u64 magic;
> +       u32 res3;
> +       u32 res4;
> +};
> +#endif /* __ASSEMBLY__ */
> +#endif /* __ASM_IMAGE_H */
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 370c66ce187a..577893bb150d 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -19,9 +19,41 @@
>  #include <asm/thread_info.h>
>  #include <asm/page.h>
>  #include <asm/csr.h>
> +#include <asm/image.h>
>
>  __INIT
>  ENTRY(_start)
> +       /*
> +        * Image header expected by Linux boot-loaders. The image header data
> +        * structure is described in asm/image.h.
> +        * Do not modify it without modifying the structure and all bootloaders
> +        * that expects this header format!!
> +        */
> +       /* jump to start kernel */
> +       j _start_kernel
> +       /* reserved */
> +       .word 0
> +       .balign 8
> +#if __riscv_xlen == 64
> +       /* Image load offset(2MB) from start of RAM */
> +       .dword 0x200000
> +#else
> +       /* Image load offset(4MB) from start of RAM */
> +       .dword 0x400000
> +#endif
> +       /* Effective size of kernel image */
> +       .dword _end - _start
> +       .dword __HEAD_FLAGS
> +       .word RISCV_HEADER_VERSION
> +       .word 0
> +       .dword 0
> +       .asciz RISCV_IMAGE_MAGIC
> +       .word 0
> +       .balign 4
> +       .word 0
> +
> +.global _start_kernel
> +_start_kernel:
>         /* Mask all interrupts */
>         csrw CSR_SIE, zero
>         csrw CSR_SIP, zero
> --
> 2.21.0
>
