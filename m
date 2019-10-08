Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9509B2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqkR8rc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfJHWQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:16:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46707 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:16:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id q24so9705plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiqFnu89plxZSLedgLcdRBN9DKh7erYv6ytT6fDXTcU=;
        b=RqkR8rc+HYwlFbxqDyeNhe4H9RNIYyu5bNdc5Ia9pOuDgR3X8eQSSrw4D9maee7qyv
         bZJfKUzj5R91DuV/78SkulhLfb2RHBy7pJd7Kz63C5rTPX5GTk0S1NMTLjo107LVzwJv
         OH/jbK72MrLeySR5fMec6E8HardxjZ8MzKuh3vJvAvD6ilm3P2Y2oG04m9QE/GawzASr
         f4IlC2C+BnaXQuC5o8BkEa5EhEw/YP1EnDAx7SaLDU4bC0bzWKtALlkT/eVtMh2MrIKa
         ztcNJqC3AlfYRR3wQ50jfU+ZzRtC8eGnuQq024jE1fOP+Y3YRsnahw0f5hKW5I2ftn+c
         FhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiqFnu89plxZSLedgLcdRBN9DKh7erYv6ytT6fDXTcU=;
        b=O/FyIsG+37ktbUbhipHVgMjnJ6oTQBsHDM2R/bLyE4/b55agNyZtmhxYmJBErG1K7p
         yvrTmX1SwZTsWZbL/L6cIckpyc9dFodSot4oddgP6bwAEWI3Yf4Ukz0LwGBRu5r5OcTm
         XEtZ5UlOF546JR4VpZUi+k+M1k0nmL5idUY8gChi0CI/JGfqoUXMNTvL/CXuSmiptCZY
         EQgMlPGUpVOG+mz2t6AVrPutbUab4wM6PwnijQk07yv8CxKh5BPkcg/xMOddH0ZfZYmz
         3pptAwaZLzXRgDpBhXlx8pTLmW3UqhW9uLIHf7VH8M/vvb1AsLqgMxU4uA6FiZ2G9y89
         imvA==
X-Gm-Message-State: APjAAAXcFyrxxzgiRy7VY7fhc1bTHsHC4iiGBC7FyHw7cHsGjR/1vC4y
        AC9fj8XebikcybqWr13E/8eMNc3jPgAb6WZ8OoCbLg==
X-Google-Smtp-Source: APXvYqy1ETIas/wOJ+uCHs3/XIi5AxYgszeqVZ4Cu5XUmvmIOYIYVGlJMRoEChZ5mREGh0jCfBXazg040OGT3cNArhQ=
X-Received: by 2002:a17:902:7c08:: with SMTP id x8mr35766287pll.119.1570572961517;
 Tue, 08 Oct 2019 15:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191007201452.208067-1-samitolvanen@google.com> <20191008212730.185532-1-samitolvanen@google.com>
In-Reply-To: <20191008212730.185532-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Oct 2019 15:15:49 -0700
Message-ID: <CAKwvOdkG9PjEkNNsi7P4bD2gtVvgPLPpmyAqzOFv4v9PL3uoeg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: lse: fix LSE atomics with LLVM's integrated assembler
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 2:27 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Unlike gcc, clang considers each inline assembly block to be independent
> and therefore, when using the integrated assembler for inline assembly,
> any preambles that enable features must be repeated in each block.
>
> This change defines __LSE_PREAMBLE and adds it to each inline assembly
> block that has LSE instructions, which allows them to be compiled also
> with clang's assembler.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/671
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>


Thanks, I think this will better limit the assembler to use of these
instructions, while preventing the C compiler from emitting them.
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang -j71 clean
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang
-j71 defconfig
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang
-j71 fs/ext4/balloc.o
<error explosion>
$ git am <patch.eml>
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang
-j71 fs/ext4/balloc.o
...
$ echo $?
0
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang -j71 clean
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang -j71 defconfig
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang -j71
<builds successfully>
$ qemu-system-aarch64 -kernel arch/arm64/boot/Image.gz -machine virt
-cpu cortex-a72 -nographic --append "console=ttyAMA0" -m 2048 -initrd
/android1/buildroot/output/images/rootfs.cpio
<boots successfully; doesn't appear to regress the case of GAS, though
I doubt such a compiler directive would>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v2:
>  - Add a preamble to inline assembly blocks that use LSE instead
>    of allowing the compiler to emit LSE instructions everywhere.
>
> ---
>  arch/arm64/include/asm/atomic_lse.h | 19 +++++++++++++++++++
>  arch/arm64/include/asm/lse.h        |  6 +++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index c6bd87d2915b..3ee600043042 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -14,6 +14,7 @@
>  static inline void __lse_atomic_##op(int i, atomic_t *v)                       \
>  {                                                                      \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>  "      " #asm_op "     %w[i], %[v]\n"                                  \
>         : [i] "+r" (i), [v] "+Q" (v->counter)                           \
>         : "r" (v));                                                     \
> @@ -30,6 +31,7 @@ ATOMIC_OP(add, stadd)
>  static inline int __lse_atomic_fetch_##op##name(int i, atomic_t *v)    \
>  {                                                                      \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>  "      " #asm_op #mb " %w[i], %w[i], %[v]"                             \
>         : [i] "+r" (i), [v] "+Q" (v->counter)                           \
>         : "r" (v)                                                       \
> @@ -58,6 +60,7 @@ static inline int __lse_atomic_add_return##name(int i, atomic_t *v)   \
>         u32 tmp;                                                        \
>                                                                         \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       ldadd" #mb "    %w[i], %w[tmp], %[v]\n"                 \
>         "       add     %w[i], %w[i], %w[tmp]"                          \
>         : [i] "+r" (i), [v] "+Q" (v->counter), [tmp] "=&r" (tmp)        \
> @@ -77,6 +80,7 @@ ATOMIC_OP_ADD_RETURN(        , al, "memory")
>  static inline void __lse_atomic_and(int i, atomic_t *v)
>  {
>         asm volatile(
> +       __LSE_PREAMBLE
>         "       mvn     %w[i], %w[i]\n"
>         "       stclr   %w[i], %[v]"
>         : [i] "+&r" (i), [v] "+Q" (v->counter)
> @@ -87,6 +91,7 @@ static inline void __lse_atomic_and(int i, atomic_t *v)
>  static inline int __lse_atomic_fetch_and##name(int i, atomic_t *v)     \
>  {                                                                      \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       mvn     %w[i], %w[i]\n"                                 \
>         "       ldclr" #mb "    %w[i], %w[i], %[v]"                     \
>         : [i] "+&r" (i), [v] "+Q" (v->counter)                          \
> @@ -106,6 +111,7 @@ ATOMIC_FETCH_OP_AND(        , al, "memory")
>  static inline void __lse_atomic_sub(int i, atomic_t *v)
>  {
>         asm volatile(
> +       __LSE_PREAMBLE
>         "       neg     %w[i], %w[i]\n"
>         "       stadd   %w[i], %[v]"
>         : [i] "+&r" (i), [v] "+Q" (v->counter)
> @@ -118,6 +124,7 @@ static inline int __lse_atomic_sub_return##name(int i, atomic_t *v) \
>         u32 tmp;                                                        \
>                                                                         \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       neg     %w[i], %w[i]\n"                                 \
>         "       ldadd" #mb "    %w[i], %w[tmp], %[v]\n"                 \
>         "       add     %w[i], %w[i], %w[tmp]"                          \
> @@ -139,6 +146,7 @@ ATOMIC_OP_SUB_RETURN(        , al, "memory")
>  static inline int __lse_atomic_fetch_sub##name(int i, atomic_t *v)     \
>  {                                                                      \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       neg     %w[i], %w[i]\n"                                 \
>         "       ldadd" #mb "    %w[i], %w[i], %[v]"                     \
>         : [i] "+&r" (i), [v] "+Q" (v->counter)                          \
> @@ -159,6 +167,7 @@ ATOMIC_FETCH_OP_SUB(        , al, "memory")
>  static inline void __lse_atomic64_##op(s64 i, atomic64_t *v)           \
>  {                                                                      \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>  "      " #asm_op "     %[i], %[v]\n"                                   \
>         : [i] "+r" (i), [v] "+Q" (v->counter)                           \
>         : "r" (v));                                                     \
> @@ -175,6 +184,7 @@ ATOMIC64_OP(add, stadd)
>  static inline long __lse_atomic64_fetch_##op##name(s64 i, atomic64_t *v)\
>  {                                                                      \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>  "      " #asm_op #mb " %[i], %[i], %[v]"                               \
>         : [i] "+r" (i), [v] "+Q" (v->counter)                           \
>         : "r" (v)                                                       \
> @@ -203,6 +213,7 @@ static inline long __lse_atomic64_add_return##name(s64 i, atomic64_t *v)\
>         unsigned long tmp;                                              \
>                                                                         \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       ldadd" #mb "    %[i], %x[tmp], %[v]\n"                  \
>         "       add     %[i], %[i], %x[tmp]"                            \
>         : [i] "+r" (i), [v] "+Q" (v->counter), [tmp] "=&r" (tmp)        \
> @@ -222,6 +233,7 @@ ATOMIC64_OP_ADD_RETURN(        , al, "memory")
>  static inline void __lse_atomic64_and(s64 i, atomic64_t *v)
>  {
>         asm volatile(
> +       __LSE_PREAMBLE
>         "       mvn     %[i], %[i]\n"
>         "       stclr   %[i], %[v]"
>         : [i] "+&r" (i), [v] "+Q" (v->counter)
> @@ -232,6 +244,7 @@ static inline void __lse_atomic64_and(s64 i, atomic64_t *v)
>  static inline long __lse_atomic64_fetch_and##name(s64 i, atomic64_t *v)        \
>  {                                                                      \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       mvn     %[i], %[i]\n"                                   \
>         "       ldclr" #mb "    %[i], %[i], %[v]"                       \
>         : [i] "+&r" (i), [v] "+Q" (v->counter)                          \
> @@ -251,6 +264,7 @@ ATOMIC64_FETCH_OP_AND(        , al, "memory")
>  static inline void __lse_atomic64_sub(s64 i, atomic64_t *v)
>  {
>         asm volatile(
> +       __LSE_PREAMBLE
>         "       neg     %[i], %[i]\n"
>         "       stadd   %[i], %[v]"
>         : [i] "+&r" (i), [v] "+Q" (v->counter)
> @@ -263,6 +277,7 @@ static inline long __lse_atomic64_sub_return##name(s64 i, atomic64_t *v)    \
>         unsigned long tmp;                                              \
>                                                                         \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       neg     %[i], %[i]\n"                                   \
>         "       ldadd" #mb "    %[i], %x[tmp], %[v]\n"                  \
>         "       add     %[i], %[i], %x[tmp]"                            \
> @@ -284,6 +299,7 @@ ATOMIC64_OP_SUB_RETURN(        , al, "memory")
>  static inline long __lse_atomic64_fetch_sub##name(s64 i, atomic64_t *v)        \
>  {                                                                      \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       neg     %[i], %[i]\n"                                   \
>         "       ldadd" #mb "    %[i], %[i], %[v]"                       \
>         : [i] "+&r" (i), [v] "+Q" (v->counter)                          \
> @@ -305,6 +321,7 @@ static inline s64 __lse_atomic64_dec_if_positive(atomic64_t *v)
>         unsigned long tmp;
>
>         asm volatile(
> +       __LSE_PREAMBLE
>         "1:     ldr     %x[tmp], %[v]\n"
>         "       subs    %[ret], %x[tmp], #1\n"
>         "       b.lt    2f\n"
> @@ -331,6 +348,7 @@ static inline u##sz __lse__cmpxchg_case_##name##sz(volatile void *ptr,      \
>         unsigned long tmp;                                              \
>                                                                         \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       mov     %" #w "[tmp], %" #w "[old]\n"                   \
>         "       cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"    \
>         "       mov     %" #w "[ret], %" #w "[tmp]"                     \
> @@ -377,6 +395,7 @@ static inline long __lse__cmpxchg_double##name(unsigned long old1,  \
>         register unsigned long x4 asm ("x4") = (unsigned long)ptr;      \
>                                                                         \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
>         "       eor     %[old1], %[old1], %[oldval1]\n"                 \
>         "       eor     %[old2], %[old2], %[oldval2]\n"                 \
> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
> index 80b388278149..73834996c4b6 100644
> --- a/arch/arm64/include/asm/lse.h
> +++ b/arch/arm64/include/asm/lse.h
> @@ -6,6 +6,8 @@
>
>  #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
>
> +#define __LSE_PREAMBLE ".arch armv8-a+lse\n"
> +
>  #include <linux/compiler_types.h>
>  #include <linux/export.h>
>  #include <linux/jump_label.h>
> @@ -14,8 +16,6 @@
>  #include <asm/atomic_lse.h>
>  #include <asm/cpucaps.h>
>
> -__asm__(".arch_extension       lse");
> -
>  extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
>  extern struct static_key_false arm64_const_caps_ready;
>
> @@ -34,7 +34,7 @@ static inline bool system_uses_lse_atomics(void)
>
>  /* In-line patching at runtime */
>  #define ARM64_LSE_ATOMIC_INSN(llsc, lse)                               \
> -       ALTERNATIVE(llsc, lse, ARM64_HAS_LSE_ATOMICS)
> +       ALTERNATIVE(llsc, __LSE_PREAMBLE lse, ARM64_HAS_LSE_ATOMICS)
>
>  #else  /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
>
> --
> 2.23.0.581.g78d2f28ef7-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191008212730.185532-1-samitolvanen%40google.com.



-- 
Thanks,
~Nick Desaulniers
