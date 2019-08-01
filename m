Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71D5C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DCE20449
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoLb0vr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfHAI40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:56:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33570 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:56:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so4919492edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBTnLCvDSjUrM5VA6hRLwxeWErZVATZCYstiolhIwfY=;
        b=NoLb0vr03SaJFiFBi/AvOZ0tOGsl2F71+ULfqAHJQdNz1s6+g8ouEys8/MJETlTZEN
         srka9oQ1P7WPq65ngL0VmuS1fNb5kjPDXdTqtz1GLjJMS6YGrv8HmUFKH7WkNZDzAAcx
         0eTb6+UXViDSIC+/jTCaQe4v72rH4sd7pZy1SNaAFmftnAdoChzd8/Mj09Idt0i2cYu2
         cCYjF0UNolnQqV22RklzJJemUVinGgMLueDcFA2ZgJtgWaImKjmbkQst3rMS3KA0Q+th
         J7VvC6MqN6JDp1NFQpRDE9XMj9zktpMPZFpIdWoT6n0eymISZrqf0/Z088JDdIonV2pf
         1B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBTnLCvDSjUrM5VA6hRLwxeWErZVATZCYstiolhIwfY=;
        b=lg2wWoK/RhS2rDwxvH9ifIkRRUzbkexC4s5LWyxxTw8sF17c9ONPrF6GAw+nB30T1S
         XJI1X5CyUUI0jvTjtLChYNaniuEsl5BaB2uwXUuctAKzDIbc5WpsS+gJ+07cEQcoAMZJ
         jsr+AZFZgR/2VSU8rRvygGxOw7iA94cUDTIn/6Y/7jqQ3BRZ393YrGccwIsmXyFZ/zNz
         Wnn8TslUlbgHsLavkqlgzABdFx8FS+Mxz8ftEeJksx+2he00gvjTiO0J7ss9aQ4QkkYj
         vJ3TMYuHnfFS4DWs5t/+CjlmsfWNiG/ggm5nem7A49cRAvyXctQRi8oNmg0XztSy9TaP
         U6iA==
X-Gm-Message-State: APjAAAURJmaCKuRMgYor1yo0UGPahfQdUspnq52gH/2WT6A3KEdmpDRB
        ppk8s5sTBmUoi8MpZDGIzpU4RCJInCG3cBzJLpk=
X-Google-Smtp-Source: APXvYqySdIHX4t/XbVlFWPNMolBJN2yEroFtRV93xbfuz+4fTUGkuwwYkvNVJyZRFJG0EvIVMvbqsZIvTd3ouVg5yO4=
X-Received: by 2002:a17:906:fc5:: with SMTP id c5mr56482594ejk.129.1564649783883;
 Thu, 01 Aug 2019 01:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
 <CAEUhbmUh0rJzFUoA05En9osy+Vv9AP0yOr-bs1goqk7+6SCv2g@mail.gmail.com> <alpine.DEB.2.21.9999.1907301218560.3486@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907301218560.3486@viisi.sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 1 Aug 2019 16:56:12 +0800
Message-ID: <CAEUhbmU8u-Z1At+U3KMk1OnQm8+NJnFiQGhu2f=xkOHYMkrPCA@mail.gmail.com>
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

On Thu, Aug 1, 2019 at 3:37 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> On Sun, 28 Jul 2019, Bin Meng wrote:
>
> > The spec does not mention 40-bit physical addresses, but 56-bit.
>
> Thanks, agreed.  Updated patch below
>
>
> - Paul
>
> From: Paul Walmsley <paul.walmsley@sifive.com>
> Date: Fri, 26 Jul 2019 10:21:11 -0700
> Subject: [PATCH v2] riscv: kbuild: add virtual memory system selection
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
> This second version of the patch fixes some errors in the Kconfig
> description text, found by Bin Meng <bmeng.cn@gmail.com>.
>
> This patch currently has no functional impact.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
>  arch/riscv/Kconfig                  | 43 +++++++++++++++++++++++++++++
>  arch/riscv/include/asm/pgtable-32.h |  4 +++
>  arch/riscv/include/asm/pgtable-64.h |  4 +++
>  3 files changed, 51 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 59a4727ecd6c..f5e76e25a91e 100644
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
> +                 addresses and 56-bit physical addresses, via a
> +                 three-stage page table layout.
> +       config RISCV_VM_SV48
> +               depends on 64BIT
> +               bool "RISC-V Sv48"
> +               help
> +                 The Sv48 virtual memory system is a page-based
> +                 address and page table format for RV64 systems.
> +                 It specifies a translation between 48-bit virtual
> +                 addresses and 56-bit physical addresses, via a
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

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
