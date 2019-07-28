Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C02C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70A52075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swl6CXvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfG1Nij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:38:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39158 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1Nii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:38:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so57044402edv.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hy+mRQ+QZ9gGOKuMHdwHfkZBAGMRoDJYYoYSH6U8K7A=;
        b=Swl6CXvxlH7T2DPcTnYcdtPuLwjp1jS/fDPuuVE/laBJ+s8PYOLdZglXMZpo67fYxV
         Ll9W7uWM5Li2hT8noe7HHL1mJntUkro2fHHOkSwC+m1BmQ1Fmrw5cie3x79EYSGQ+qEW
         dDSUKFvyU7RQyyDmurzRgnF8B1hfYL/1RobTTgQxBaa5n/MXI4ZF4yMYq7crzJMhZqiX
         3V6GD3TrrIiqj4vh/O7j3WZfuJhnILDSXKOC68GWc2AqIKIokBi8C9XNSrdKdFLJkZIk
         tEVwtn390QhvG41kVuGNnusTPYkExko+27RGIUanjkwcZo+6ToZnx3n4ZgoiL/2EpvII
         qkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hy+mRQ+QZ9gGOKuMHdwHfkZBAGMRoDJYYoYSH6U8K7A=;
        b=LCL4U63vTVviBp44/ro/tzqu7WytvtqwmFoY84YG3Fw+VnEjL5IU0XkfN7FosRRpYu
         rinVRl1yxzPhWKWFeb4obuFEh5V7weg0Xf1K/8ZQCXipZSbaSM5PC2GIxKve1P7FUodA
         4WNVlBEi6Z4Ix2wrvjmGqJeejSj0u2Hq4yK0+KTgwdiOTtqQRQ90ly5d8h7OcbebpwoF
         Fi4IhBxzbT7R0sLEd1WqU6cz+DNYsxXmE4S9U0GY7/zeVZFwGbbf5yV4vOF9zgbAxN7H
         rnlJwB+0Laqvnx3NAiG5rVHZyeGQWlrwVabtgjKgRHB28sWMVV/leVn3Svh+RdkqhIgA
         BWRw==
X-Gm-Message-State: APjAAAXoKDA4gJtA5HnlvtHSIUX9DMncyfmbQLtfWkbU3n8BheT4rAsZ
        +oLNUnf0hgCpD8lfPt9QcuCCwc/T6rDpBPzkhMo=
X-Google-Smtp-Source: APXvYqzJFhA4yfR/AhsQy7gz2M1fgFG9KBciwTB/MXLVkyXYEFdwGDN6sQjCRmCociC7RVSJJcTt/NzLrgI1xepJ8DY=
X-Received: by 2002:a17:906:81cb:: with SMTP id e11mr79541973ejx.37.1564321116352;
 Sun, 28 Jul 2019 06:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 28 Jul 2019 21:38:25 +0800
Message-ID: <CAEUhbmUh0rJzFUoA05En9osy+Vv9AP0yOr-bs1goqk7+6SCv2g@mail.gmail.com>
Subject: Re: [PATCH] riscv: kbuild: add virtual memory system selection
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 4:00 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> The RISC-V specifications currently define three virtual memory
> translation systems: Sv32, Sv39, and Sv48.  Sv32 is currently specific
> to 32-bit systems; Sv39 and Sv48 are currently specific to 64-bit
> systems.  The current kernel only supports Sv32 and Sv39, but we'd
> like to start preparing for Sv48.  As an initial step, allow the
> virtual memory translation system to be selected via kbuild, and stop
> the build if an option is selected that the kernel doen't currently
> support.
>
> This patch currently has no functional impact.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/Kconfig                  | 43 +++++++++++++++++++++++++++++
>  arch/riscv/include/asm/pgtable-32.h |  4 +++
>  arch/riscv/include/asm/pgtable-64.h |  4 +++
>  3 files changed, 51 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 59a4727ecd6c..8ef64fe2c2b3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -155,6 +155,49 @@ config MODULE_SECTIONS
>         bool
>         select HAVE_MOD_ARCH_SPECIFIC
>
> +choice
> +       prompt "Virtual Memory System"
> +       default RISCV_VM_SV32 if 32BIT
> +       default RISCV_VM_SV39 if 64BIT
> +       help
> +         The RISC-V Instruction Set Manual Volume II: Privileged
> +         Architecture defines several different "virtual memory
> +         systems" which specify virtual and physical address formats
> +         and the structure of page table entries.  This determines
> +         the amount of virtual address space present and how it is
> +         translated into physical addresses.
> +
> +       config RISCV_VM_SV32
> +               depends on 32BIT
> +               bool "RISC-V Sv32"
> +               help
> +                 The Sv32 virtual memory system is a page-based
> +                 address and page table format for RV32 systems.
> +                 It specifies a translation between 32-bit virtual
> +                 addresses and 33-bit physical addresses, via a
> +                 two-stage page table layout.
> +       config RISCV_VM_SV39
> +               depends on 64BIT
> +               bool "RISC-V Sv39"
> +               help
> +                 The Sv39 virtual memory system is a page-based
> +                 address and page table format for RV64 systems.
> +                 It specifies a translation between 39-bit virtual
> +                 addresses and 40-bit physical addresses, via a

The spec does not mention 40-bit physical addresses, but 56-bit.

> +                 three-stage page table layout.
> +       config RISCV_VM_SV48
> +               depends on 64BIT
> +               bool "RISC-V Sv48"
> +               help
> +                 The Sv48 virtual memory system is a page-based
> +                 address and page table format for RV64 systems.
> +                 It specifies a translation between 48-bit virtual
> +                 addresses and 49-bit physical addresses, via a

ditto.

> +                 four-stage page table layout.
> +
> +endchoice
> +
> +
>  choice
>         prompt "Maximum Physical Memory"
>         default MAXPHYSMEM_2GB if 32BIT
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index b0ab66e5fdb1..86d41a04735b 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -6,6 +6,10 @@
>  #ifndef _ASM_RISCV_PGTABLE_32_H
>  #define _ASM_RISCV_PGTABLE_32_H
>
> +#if !defined(CONFIG_RISCV_VM_SV32)
> +#error Only Sv32 supported
> +#endif
> +
>  #include <asm-generic/pgtable-nopmd.h>
>  #include <linux/const.h>
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 74630989006d..86935595115d 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -6,6 +6,10 @@
>  #ifndef _ASM_RISCV_PGTABLE_64_H
>  #define _ASM_RISCV_PGTABLE_64_H
>
> +#if !defined(CONFIG_RISCV_VM_SV39)
> +#error Only Sv39 supported for now
> +#endif
> +
>  #include <linux/const.h>
>
>  #define PGDIR_SHIFT     30
> --

Regards,
Bin
