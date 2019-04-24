Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781F6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346F82175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHeTkN2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbfDXRwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:52:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41339 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390563AbfDXR15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so3695895pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67jdBFagz3gdgx1ktpuKxYcSs68iKdINxduf0m5+lR8=;
        b=jHeTkN2FZl42JZHdGkpW+IjnroZKHJXjLNhxTtFZ8NoEYdFYEfQgVhU3ZvkT+1tsZm
         YhOpNiAwa/MlvQsLDSQT5PpcZ+mT/p2mA2g3NEWG8ITXnFYI0+GUI4r5rJ2HaHzsypUE
         F/ecFKfYTAYiRUkv2IMds52BvqbuRnI1VpDQKobI0tBujLXKi9eXrOUJeZj4nw/h3j/3
         nD4edwjXWspWzAYoYWuZwjwgzVR9taunBeYmNvI4ynR7b+v0CQzZO47vwvnML32lHUql
         kHBpHZVOYF5xjPze2n33xrcxpp4A5cTZ3IS0nc4864KcMsccqicpq4jd3H181t2A+6U1
         7DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67jdBFagz3gdgx1ktpuKxYcSs68iKdINxduf0m5+lR8=;
        b=VQGOClXx6/ImDm0JUumoEa8weme08SKDZjxWcrK3GoAql4i1GauCAMRsyGh1M/josC
         C3aIPRo1RB85YpAHC6VlrMt+GBJ5qUl0IAAGHfzkgBQKTxBVtjuH/YvUvBumR85zmsqW
         nEBVEhAc3IO762gmOqvXEMj/Pq7IjmSEYyJwmITYKo+QouqwbippNH1cwahbAWicliqe
         ogXqadkgx9RsFpqkgenkGIc6sND6e3PJPBfxuKf/bMMqWlPNUndhy7sN2pgNLgPrNNZX
         QT0H1B8JJLGU28dozG8EXD8kSIeHUp3WZ3OlFWgrRxomF7P+CVeQw2n7VgXzMMGFLh2L
         Accw==
X-Gm-Message-State: APjAAAUSgxohy0McsbIoPqviv/cui2iyQYySKoKySGXhDucnEH8eAWJ5
        U0ZjTUP1fkx6SUJlXKqElPnAqfKn17sre9rfPQUN6Q==
X-Google-Smtp-Source: APXvYqyiGkp0WNf8PcgDl6JrSYjxsUjH6XGtU3liOkEln0qAEi/aHqw5qUjr5HSGre6gO07TOUop2TjkfUa/0muk2wc=
X-Received: by 2002:a17:902:e281:: with SMTP id cf1mr33921459plb.13.1556126876390;
 Wed, 24 Apr 2019 10:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190424165537.GA48378@beast>
In-Reply-To: <20190424165537.GA48378@beast>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Apr 2019 10:27:45 -0700
Message-ID: <CAKwvOd=qDRNKS+dUm8X0C-9B2ZXjBfMYW5RJiTdF3jxDtDJdcA@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: sysreg: Make mrs_s and msr_s macros work with
 Clang and LTO
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:55 AM Kees Cook <keescook@chromium.org> wrote:
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
> v5: include register declaration in macro (rutland)

Great! Thanks for following up on the feedback.  Happy to see the way
this turned out.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> v4: move to using preprocessor entirely, split constraints for "rZ" case.
> v3: added more uses in irqflags, updated commit log, based on
>     discussion in https://lore.kernel.org/patchwork/patch/851580/
> ---
>  arch/arm64/include/asm/irqflags.h |  8 +++---
>  arch/arm64/include/asm/kvm_hyp.h  |  4 +--
>  arch/arm64/include/asm/sysreg.h   | 45 ++++++++++++++++++++++---------
>  3 files changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 43d8366c1e87..629963189085 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -43,7 +43,7 @@ static inline void arch_local_irq_enable(void)
>         asm volatile(ALTERNATIVE(
>                 "msr    daifclr, #2             // arch_local_irq_enable\n"
>                 "nop",
> -               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +               __msr_s(SYS_ICC_PMR_EL1, "%0")
>                 "dsb    sy",
>                 ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> @@ -55,7 +55,7 @@ static inline void arch_local_irq_disable(void)
>  {
>         asm volatile(ALTERNATIVE(
>                 "msr    daifset, #2             // arch_local_irq_disable",
> -               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> +               __msr_s(SYS_ICC_PMR_EL1, "%0"),
>                 ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
>                 : "r" ((unsigned long) GIC_PRIO_IRQOFF)
> @@ -86,7 +86,7 @@ static inline unsigned long arch_local_save_flags(void)
>                         "mov    %0, %1\n"
>                         "nop\n"
>                         "nop",
> -                       "mrs_s  %0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +                       __mrs_s("%0", SYS_ICC_PMR_EL1)
>                         "ands   %1, %1, " __stringify(PSR_I_BIT) "\n"
>                         "csel   %0, %0, %2, eq",
>                         ARM64_HAS_IRQ_PRIO_MASKING)
> @@ -116,7 +116,7 @@ static inline void arch_local_irq_restore(unsigned long flags)
>         asm volatile(ALTERNATIVE(
>                         "msr    daif, %0\n"
>                         "nop",
> -                       "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0\n"
> +                       __msr_s(SYS_ICC_PMR_EL1, "%0")
>                         "dsb    sy",
>                         ARM64_HAS_IRQ_PRIO_MASKING)
>                 : "+r" (flags)
> diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
> index 4da765f2cca5..c3060833b7a5 100644
> --- a/arch/arm64/include/asm/kvm_hyp.h
> +++ b/arch/arm64/include/asm/kvm_hyp.h
> @@ -30,7 +30,7 @@
>         ({                                                              \
>                 u64 reg;                                                \
>                 asm volatile(ALTERNATIVE("mrs %0, " __stringify(r##nvh),\
> -                                        "mrs_s %0, " __stringify(r##vh),\
> +                                        __mrs_s("%0", r##vh),          \
>                                          ARM64_HAS_VIRT_HOST_EXTN)      \
>                              : "=r" (reg));                             \
>                 reg;                                                    \
> @@ -40,7 +40,7 @@
>         do {                                                            \
>                 u64 __val = (u64)(v);                                   \
>                 asm volatile(ALTERNATIVE("msr " __stringify(r##nvh) ", %x0",\
> -                                        "msr_s " __stringify(r##vh) ", %x0",\
> +                                        __msr_s(r##vh, "%x0"),         \
>                                          ARM64_HAS_VIRT_HOST_EXTN)      \
>                                          : : "rZ" (__val));             \
>         } while (0)
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 5b267dec6194..3b2c09eddd8f 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -746,20 +746,39 @@
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
> +#define __mrs_s(v, r)                                          \
> +       DEFINE_MRS_S                                            \
> +"      mrs_s " v ", " __stringify(r) "\n"                      \
> +       UNDEFINE_MRS_S
> +
> +#define __msr_s(r, v)                                          \
> +       DEFINE_MSR_S                                            \
> +"      msr_s " __stringify(r) ", " v "\n"                      \
> +       UNDEFINE_MSR_S
>
>  /*
>   * Unlike read_cpuid, calls to read_sysreg are never expected to be
> @@ -787,13 +806,13 @@ asm(
>   */
>  #define read_sysreg_s(r) ({                                            \
>         u64 __val;                                                      \
> -       asm volatile("mrs_s %0, " __stringify(r) : "=r" (__val));       \
> +       asm volatile(__mrs_s("%0", r) : "=r" (__val));                  \
>         __val;                                                          \
>  })
>
>  #define write_sysreg_s(v, r) do {                                      \
>         u64 __val = (u64)(v);                                           \
> -       asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val)); \
> +       asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));               \
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
