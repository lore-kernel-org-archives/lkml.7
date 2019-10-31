Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D75CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 20:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DEB20656
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 20:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S73tGnS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfJaUes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 16:34:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37616 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJaUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 16:34:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id p13so3232048pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9l1iF8Yd4cbsJGLUM/SW26KknarkUcShmOF9BoqHMJM=;
        b=S73tGnS/ZJF+fbC8RaG3esksSLQBz+nONIb30B9/d/c+3qgRZlPslhdi+Dd2ioA26M
         PJHW6SksmlJG77+8/8DZ0wpWUccicLrqaqJ4uf7iC0f8qoW91fkgKMdBv2HzhdM5ZhRY
         JtBK0SuAzoRRSSimV8NxKRmJ2vC9x7dCXosKDgTYrSUDvoCUsOst+zVzu+dX+80qrG4P
         HcgKQgui+YTZJ2owEaUwOYTJRSRshPqlnN41gQOoONKs+gr/+bWC/l8D/yhgG7w4Aibi
         GtBrdgenJ+HX8dk6AAqHs90uD8DqVBv67u1oym9EUwHuH3cc8BRCW2MYetnnV015VO5v
         HaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9l1iF8Yd4cbsJGLUM/SW26KknarkUcShmOF9BoqHMJM=;
        b=LJqsH2gkDh//rtkMLZhhwpWS04Nr9XUJZ+U8c4PLTJVpHal6Uq1gvomZDtXaqeLtNa
         TmF8bDm2n3MwBjvWXQh1DjkXsrqBGF5yNOTPbyFie8cUw/sjacbySkFIVD7L+W+TU16b
         NsWxSGRBn3NvWznwjUE8EZ+YDZ0wYTVibLuIdXoxIp0V7qO1hegVMVqlRX3opzxPORFf
         5Lz0LYy8+BCSae6w7TfL28zcVod9tlhLuQIQvgmsEr8Kh2KGnWQTozjSX3ZZn0TNlV7n
         B6HWfyTB0MgDNL6kM0HiZ4PKEH5LSvvQ1P/OTbJm0nvRf+/NYQLvKNimeb70mh2qImOg
         84Hg==
X-Gm-Message-State: APjAAAXkmEP2KDQa2R3QDIMoePXazrQ2dz0KMaP85OJ4GW2Jhk9Himja
        bjbm5Ly7E3NN2u9vONjuEt8Y3j4OQuXWTv2ootd+6g==
X-Google-Smtp-Source: APXvYqzcD14QDUDnhl1h/xb9pVpb0meKYJHEz18BKXPjesZw3450QpjcDJjWrObThnSCdYXF/xHv/UlLi4VWbhNZWi8=
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr8343680plp.179.1572554086594;
 Thu, 31 Oct 2019 13:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191031195705.36916-1-samitolvanen@google.com>
In-Reply-To: <20191031195705.36916-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Oct 2019 13:34:35 -0700
Message-ID: <CAKwvOdnnGFQSbchQrCKhzx5KxsD0MQAB9_0LO4d67AV8_u_tug@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] arm64: lse: fix LSE atomics with LLVM's
 integrated assembler
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

On Thu, Oct 31, 2019 at 12:57 PM Sami Tolvanen <samitolvanen@google.com> wrote:
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
> Tested-by: Andrew Murray <andrew.murray@arm.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
> index 574808b9df4c..da3280f639cd 100644
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
> @@ -332,6 +349,7 @@ __lse__cmpxchg_case_##name##sz(volatile void *ptr,                  \
>         unsigned long tmp;                                              \
>                                                                         \
>         asm volatile(                                                   \
> +       __LSE_PREAMBLE                                                  \
>         "       mov     %" #w "[tmp], %" #w "[old]\n"                   \
>         "       cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"    \
>         "       mov     %" #w "[ret], %" #w "[tmp]"                     \
> @@ -379,6 +397,7 @@ __lse__cmpxchg_double##name(unsigned long old1,                             \
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
> 2.24.0.rc0.303.g954a862665-goog
>


-- 
Thanks,
~Nick Desaulniers
