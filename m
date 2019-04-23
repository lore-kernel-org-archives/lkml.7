Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB2FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713B5218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMq99aPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfDWXtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:49:50 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41968 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfDWXtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:49:49 -0400
Received: by mail-ua1-f65.google.com with SMTP id l22so5408199uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKGQj4IyMgCdsCMgTy3ojcJsLsfl9tLwn625Vp1bQb8=;
        b=CMq99aPSxvERJXK2NmZ3SbWyCzRlNEyRbLzbjsjDRO6bQTxbXma50M751I1AYt6+F4
         qTjVfhLiOOOZUajSOH0vDfz0fN7ezjhxOhIA5UJkWNCKZ764jHuSIInp71OscfVeQsLl
         buKduLihADoNpuRjvmUFQhqxI5gYTOHegXRPM6wrgtdKZEVsxZappeeTyCUirBXtFYDk
         ruBxPpTpmwWctKVe2VShkChhUBRLKKwC1BF6dKeo9Mh9wmMPDAw/EWMyBqfB8KHvsSdM
         rIQLtVrAprU3oOLBrlqBrIwXeazW6BtZv9b+S1g21Yym77535AYRvusrdLy+Wi30wsZ9
         oRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKGQj4IyMgCdsCMgTy3ojcJsLsfl9tLwn625Vp1bQb8=;
        b=pJUwj0gMjZn33RHfSRcO4D6frQtU8ti3qNpFIRAibAoAD9W2gFY48rXBst6FqWdGf+
         7n3XvH57o4y+lK9EEcvJvC9U+CVRjctL4SBYTYV2nXtxQ0onDg16XfayY4NWT7YXi3uI
         3gVzEWB/a2UatRAXsFVV8Kfjr8LubC1a5vGYqP4NOuqDPy0zRWbxRwDXsatbh6936Lh3
         gZPPY6Uos4nvqNCmbY+t/G8V9s4Can68ifUoXEFpzwN5Or2YK7ciP2ZE3I0uaeuyzTXR
         EDpvNTPCVPT9OG/SyDCJWDIVrERHutgoYLltTALVAH3odKk77zTpw+pppkib/HV5Nx+K
         VpXQ==
X-Gm-Message-State: APjAAAXqVlwK012iv9Q8nFgj2ZZk6Znqk10RHCBfQXSwG/B+1IistO2J
        Dxxh/S/faf+827W2sNZry1nBRsL1mACT/uqxgp0Ysw==
X-Google-Smtp-Source: APXvYqyKg5BI4RqKe2bfkSdA3HOvDUsXoWApAPOTeAPO6i1YOxx487ItGyQj+3Hzt2e1xF/DFamX5TSPgFEE4spOLTM=
X-Received: by 2002:a9f:2a8d:: with SMTP id z13mr14981801uai.62.1556063387994;
 Tue, 23 Apr 2019 16:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190423232622.GA11776@beast>
In-Reply-To: <20190423232622.GA11776@beast>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Apr 2019 16:49:36 -0700
Message-ID: <CAKwvOdmD8g_Ecoi==KHUTPqMmAGYkbsijZ-FA_QKxke1LcjJEw@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: sysreg: Make mrs_s and msr_s macros work with
 Clang and LTO
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Matveev <alxmtvv@gmail.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 4:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> Clang's integrated assembler does not allow assembly macros defined
> in one inline asm block using the .macro directive to be used across
> separate asm blocks. LLVM developers consider this a feature and not a
> bug, recommending code refactoring:
>
>   https://bugs.llvm.org/show_bug.cgi?id=19749
>
> As binutils doesn't allow macros to be redefined, this change uses
> UNDEFINE_MRS_S and UNDEFINE_MSR_S to define corresponding macros
> in-place and workaround gcc and clang limitations on redefining macros
> across different assembler blocks.
>
> Specifically, the current state after preprocessing looks like this:
>
> asm volatile(".macro mXX_s ... .endm");
> void f()
> {
>         asm volatile("mXX_s a, b");
> }
>
> With GCC, it gives macro redefinition error because sysreg.h is included
> in multiple source files, and assembler code for all of them is later
> combined for LTO (I've seen an intermediate file with hundreds of
> identical definitions).
>
> With clang, it gives macro undefined error because clang doesn't allow
> sharing macros between inline asm statements.
>
> I also seem to remember catching another sort of undefined error with
> GCC due to reordering of macro definition asm statement and generated
> asm code for function that uses the macro.
>
> The solution with defining and undefining for each use, while certainly
> not elegant, satisfies both GCC and clang, LTO and non-LTO.
>
> Co-developed-by: Alex Matveev <alxmtvv@gmail.com>
> Co-developed-by: Yury Norov <ynorov@caviumnetworks.com>
> Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v4: move to using preprocessor entirely, split constraints for "rZ" case.
> v3: added more uses in irqflags, updated commit log, based on
>     discussion in https://lore.kernel.org/patchwork/patch/851580/
> ---
>  arch/arm64/include/asm/irqflags.h |  8 ++---
>  arch/arm64/include/asm/kvm_hyp.h  |  4 +--
>  arch/arm64/include/asm/sysreg.h   | 51 +++++++++++++++++++++++--------
>  3 files changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 43d8366c1e87..d359f28765cb 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -43,7 +43,7 @@ static inline void arch_local_irq_enable(void)
>         asm volatile(ALTERNATIVE(
>                 "msr    daifclr, #2             // arch_local_irq_enable\n"
>                 "nop",
> -               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +               __msr_s(SYS_ICC_PMR_EL1)
>                 "dsb    sy",
>                 ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> @@ -55,7 +55,7 @@ static inline void arch_local_irq_disable(void)
>  {
>         asm volatile(ALTERNATIVE(
>                 "msr    daifset, #2             // arch_local_irq_disable",
> -               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> +               __msr_s(SYS_ICC_PMR_EL1),
>                 ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
>                 : "r" ((unsigned long) GIC_PRIO_IRQOFF)
> @@ -86,7 +86,7 @@ static inline unsigned long arch_local_save_flags(void)
>                         "mov    %0, %1\n"
>                         "nop\n"
>                         "nop",
> -                       "mrs_s  %0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +                       __mrs_s(SYS_ICC_PMR_EL1)
>                         "ands   %1, %1, " __stringify(PSR_I_BIT) "\n"
>                         "csel   %0, %0, %2, eq",
>                         ARM64_HAS_IRQ_PRIO_MASKING)
> @@ -116,7 +116,7 @@ static inline void arch_local_irq_restore(unsigned long flags)
>         asm volatile(ALTERNATIVE(
>                         "msr    daif, %0\n"
>                         "nop",
> -                       "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0\n"
> +                       __msr_s(SYS_ICC_PMR_EL1)
>                         "dsb    sy",
>                         ARM64_HAS_IRQ_PRIO_MASKING)
>                 : "+r" (flags)
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 4da765f2cca5..f2e681d657bb 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -30,7 +30,7 @@
>         ({                                                              \
>                 u64 reg;                                                \
>                 asm volatile(ALTERNATIVE("mrs %0, " __stringify(r##nvh),\
> -                                        "mrs_s %0, " __stringify(r##vh),\
> +                                        __mrs_s(r##vh),                \
>                                          ARM64_HAS_VIRT_HOST_EXTN)      \
>                              : "=r" (reg));                             \
>                 reg;                                                    \
> @@ -40,7 +40,7 @@
>         do {                                                            \
>                 u64 __val = (u64)(v);                                   \
>                 asm volatile(ALTERNATIVE("msr " __stringify(r##nvh) ", %x0",\
> -                                        "msr_s " __stringify(r##vh) ", %x0",\
> +                                        __msr_s_x0(r##vh),             \
>                                          ARM64_HAS_VIRT_HOST_EXTN)      \
>                                          : : "rZ" (__val));             \
>         } while (0)
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 5b267dec6194..21d8f6dd4d79 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -746,20 +746,45 @@
>  #include <linux/build_bug.h>
>  #include <linux/types.h>
>
> -asm(
> -"      .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
> -"      .equ    .L__reg_num_x\\num, \\num\n"
> -"      .endr\n"
> +#define __DEFINE_MRS_MSR_S_REGNUM                              \
> +"      .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n" \
> +"      .equ    .L__reg_num_x\\num, \\num\n"                    \
> +"      .endr\n"                                                \
>  "      .equ    .L__reg_num_xzr, 31\n"
> -"\n"
> -"      .macro  mrs_s, rt, sreg\n"
> -       __emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))
> +
> +#define DEFINE_MRS_S                                           \
> +       __DEFINE_MRS_MSR_S_REGNUM                               \
> +"      .macro  mrs_s, rt, sreg\n"                              \
> +       __emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))     \
>  "      .endm\n"
> -"\n"
> -"      .macro  msr_s, sreg, rt\n"
> -       __emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))
> +
> +#define DEFINE_MSR_S                                           \
> +       __DEFINE_MRS_MSR_S_REGNUM                               \
> +"      .macro  msr_s, sreg, rt\n"                              \
> +       __emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))     \
>  "      .endm\n"
> -);
> +
> +#define UNDEFINE_MRS_S                                         \
> +"      .purgem mrs_s\n"
> +
> +#define UNDEFINE_MSR_S                                         \
> +"      .purgem msr_s\n"
> +
> +#define __mrs_s(r)                                             \
> +       DEFINE_MRS_S                                            \
> +"      mrs_s %0, " __stringify(r) "\n"                         \
> +       UNDEFINE_MRS_S
> +
> +#define __msr_s(r)                                             \
> +       DEFINE_MSR_S                                            \
> +"      msr_s " __stringify(r) ", %0\n"                         \
> +       UNDEFINE_MSR_S
> +
> +/* For use with "rZ" constraints. */
> +#define __msr_s_x0(r)                                          \
> +       DEFINE_MSR_S                                            \
> +"      msr_s " __stringify(r) ", %x0\n"                        \
> +       UNDEFINE_MSR_S

Cool, thanks for sending this revision; it's much cleaner IMO.  I
wonder (maybe Ard or Mark know) if we can drop the non-x0-variant of
msr and just use the x0-variant everywhere (but with the simpler name
of __msr_s)?

arch_local_irq_restore, arch_local_save_flags, arch_local_irq_disable,
and arch_local_irq_enable all seem to be dealing with unsigned longs
for %0, IIUC.

>
>  /*
>   * Unlike read_cpuid, calls to read_sysreg are never expected to be
> @@ -787,13 +812,13 @@ asm(
>   */
>  #define read_sysreg_s(r) ({                                            \
>         u64 __val;                                                      \
> -       asm volatile("mrs_s %0, " __stringify(r) : "=r" (__val));       \
> +       asm volatile(__mrs_s(r) : "=r" (__val));                        \
>         __val;                                                          \
>  })
>
>  #define write_sysreg_s(v, r) do {                                      \
>         u64 __val = (u64)(v);                                           \
> -       asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val)); \
> +       asm volatile(__msr_s_x0(r) : : "rZ" (__val));                   \
>  } while (0)
>
>  /*
> --
> 2.17.1
>
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
