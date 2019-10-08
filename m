Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E05AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFD321721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbfJHXbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:31:41 -0400
Received: from foss.arm.com ([217.140.110.172]:48526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfJHXbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:31:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 192BD337;
        Tue,  8 Oct 2019 16:31:40 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FB4F3F68E;
        Tue,  8 Oct 2019 16:31:39 -0700 (PDT)
Date:   Wed, 9 Oct 2019 00:31:38 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] arm64: lse: fix LSE atomics with LLVM's integrated
 assembler
Message-ID: <20191008233137.GL42880@e119886-lin.cambridge.arm.com>
References: <20191007201452.208067-1-samitolvanen@google.com>
 <20191008212730.185532-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008212730.185532-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 02:27:30PM -0700, Sami Tolvanen wrote:
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

This looks good to me. I can build and boot in a model with both Clang
(9.0.6) and GCC (7.3.1) and boot a guest without anything going bang.

Though when I build with AS=clang, e.g.

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang AS=clang Image

I get errors like this:

  CC      init/main.o
In file included from init/main.c:17:
In file included from ./include/linux/module.h:9:
In file included from ./include/linux/list.h:9:
In file included from ./include/linux/kernel.h:12:
In file included from ./include/linux/bitops.h:26:
In file included from ./arch/arm64/include/asm/bitops.h:26:
In file included from ./include/asm-generic/bitops/atomic.h:5:
In file included from ./include/linux/atomic.h:7:
In file included from ./arch/arm64/include/asm/atomic.h:16:
In file included from ./arch/arm64/include/asm/cmpxchg.h:14:
In file included from ./arch/arm64/include/asm/lse.h:13:
In file included from ./include/linux/jump_label.h:117:
./arch/arm64/include/asm/jump_label.h:24:20: error: expected a symbol reference in '.long' directive
                 "      .align          3                       \n\t"
                                                                  ^
<inline asm>:4:21: note: instantiated into assembly here
                .long           1b - ., "" - .  
                                           ^

I'm assuming that I'm doing something wrong?

Thanks,

Andrew Murray

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
>  static inline void __lse_atomic_##op(int i, atomic_t *v)			\
>  {									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  "	" #asm_op "	%w[i], %[v]\n"					\
>  	: [i] "+r" (i), [v] "+Q" (v->counter)				\
>  	: "r" (v));							\
> @@ -30,6 +31,7 @@ ATOMIC_OP(add, stadd)
>  static inline int __lse_atomic_fetch_##op##name(int i, atomic_t *v)	\
>  {									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  "	" #asm_op #mb "	%w[i], %w[i], %[v]"				\
>  	: [i] "+r" (i), [v] "+Q" (v->counter)				\
>  	: "r" (v)							\
> @@ -58,6 +60,7 @@ static inline int __lse_atomic_add_return##name(int i, atomic_t *v)	\
>  	u32 tmp;							\
>  									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	ldadd" #mb "	%w[i], %w[tmp], %[v]\n"			\
>  	"	add	%w[i], %w[i], %w[tmp]"				\
>  	: [i] "+r" (i), [v] "+Q" (v->counter), [tmp] "=&r" (tmp)	\
> @@ -77,6 +80,7 @@ ATOMIC_OP_ADD_RETURN(        , al, "memory")
>  static inline void __lse_atomic_and(int i, atomic_t *v)
>  {
>  	asm volatile(
> +	__LSE_PREAMBLE
>  	"	mvn	%w[i], %w[i]\n"
>  	"	stclr	%w[i], %[v]"
>  	: [i] "+&r" (i), [v] "+Q" (v->counter)
> @@ -87,6 +91,7 @@ static inline void __lse_atomic_and(int i, atomic_t *v)
>  static inline int __lse_atomic_fetch_and##name(int i, atomic_t *v)	\
>  {									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	mvn	%w[i], %w[i]\n"					\
>  	"	ldclr" #mb "	%w[i], %w[i], %[v]"			\
>  	: [i] "+&r" (i), [v] "+Q" (v->counter)				\
> @@ -106,6 +111,7 @@ ATOMIC_FETCH_OP_AND(        , al, "memory")
>  static inline void __lse_atomic_sub(int i, atomic_t *v)
>  {
>  	asm volatile(
> +	__LSE_PREAMBLE
>  	"	neg	%w[i], %w[i]\n"
>  	"	stadd	%w[i], %[v]"
>  	: [i] "+&r" (i), [v] "+Q" (v->counter)
> @@ -118,6 +124,7 @@ static inline int __lse_atomic_sub_return##name(int i, atomic_t *v)	\
>  	u32 tmp;							\
>  									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	neg	%w[i], %w[i]\n"					\
>  	"	ldadd" #mb "	%w[i], %w[tmp], %[v]\n"			\
>  	"	add	%w[i], %w[i], %w[tmp]"				\
> @@ -139,6 +146,7 @@ ATOMIC_OP_SUB_RETURN(        , al, "memory")
>  static inline int __lse_atomic_fetch_sub##name(int i, atomic_t *v)	\
>  {									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	neg	%w[i], %w[i]\n"					\
>  	"	ldadd" #mb "	%w[i], %w[i], %[v]"			\
>  	: [i] "+&r" (i), [v] "+Q" (v->counter)				\
> @@ -159,6 +167,7 @@ ATOMIC_FETCH_OP_SUB(        , al, "memory")
>  static inline void __lse_atomic64_##op(s64 i, atomic64_t *v)		\
>  {									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  "	" #asm_op "	%[i], %[v]\n"					\
>  	: [i] "+r" (i), [v] "+Q" (v->counter)				\
>  	: "r" (v));							\
> @@ -175,6 +184,7 @@ ATOMIC64_OP(add, stadd)
>  static inline long __lse_atomic64_fetch_##op##name(s64 i, atomic64_t *v)\
>  {									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  "	" #asm_op #mb "	%[i], %[i], %[v]"				\
>  	: [i] "+r" (i), [v] "+Q" (v->counter)				\
>  	: "r" (v)							\
> @@ -203,6 +213,7 @@ static inline long __lse_atomic64_add_return##name(s64 i, atomic64_t *v)\
>  	unsigned long tmp;						\
>  									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	ldadd" #mb "	%[i], %x[tmp], %[v]\n"			\
>  	"	add	%[i], %[i], %x[tmp]"				\
>  	: [i] "+r" (i), [v] "+Q" (v->counter), [tmp] "=&r" (tmp)	\
> @@ -222,6 +233,7 @@ ATOMIC64_OP_ADD_RETURN(        , al, "memory")
>  static inline void __lse_atomic64_and(s64 i, atomic64_t *v)
>  {
>  	asm volatile(
> +	__LSE_PREAMBLE
>  	"	mvn	%[i], %[i]\n"
>  	"	stclr	%[i], %[v]"
>  	: [i] "+&r" (i), [v] "+Q" (v->counter)
> @@ -232,6 +244,7 @@ static inline void __lse_atomic64_and(s64 i, atomic64_t *v)
>  static inline long __lse_atomic64_fetch_and##name(s64 i, atomic64_t *v)	\
>  {									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	mvn	%[i], %[i]\n"					\
>  	"	ldclr" #mb "	%[i], %[i], %[v]"			\
>  	: [i] "+&r" (i), [v] "+Q" (v->counter)				\
> @@ -251,6 +264,7 @@ ATOMIC64_FETCH_OP_AND(        , al, "memory")
>  static inline void __lse_atomic64_sub(s64 i, atomic64_t *v)
>  {
>  	asm volatile(
> +	__LSE_PREAMBLE
>  	"	neg	%[i], %[i]\n"
>  	"	stadd	%[i], %[v]"
>  	: [i] "+&r" (i), [v] "+Q" (v->counter)
> @@ -263,6 +277,7 @@ static inline long __lse_atomic64_sub_return##name(s64 i, atomic64_t *v)	\
>  	unsigned long tmp;						\
>  									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	neg	%[i], %[i]\n"					\
>  	"	ldadd" #mb "	%[i], %x[tmp], %[v]\n"			\
>  	"	add	%[i], %[i], %x[tmp]"				\
> @@ -284,6 +299,7 @@ ATOMIC64_OP_SUB_RETURN(        , al, "memory")
>  static inline long __lse_atomic64_fetch_sub##name(s64 i, atomic64_t *v)	\
>  {									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	neg	%[i], %[i]\n"					\
>  	"	ldadd" #mb "	%[i], %[i], %[v]"			\
>  	: [i] "+&r" (i), [v] "+Q" (v->counter)				\
> @@ -305,6 +321,7 @@ static inline s64 __lse_atomic64_dec_if_positive(atomic64_t *v)
>  	unsigned long tmp;
>  
>  	asm volatile(
> +	__LSE_PREAMBLE
>  	"1:	ldr	%x[tmp], %[v]\n"
>  	"	subs	%[ret], %x[tmp], #1\n"
>  	"	b.lt	2f\n"
> @@ -331,6 +348,7 @@ static inline u##sz __lse__cmpxchg_case_##name##sz(volatile void *ptr,	\
>  	unsigned long tmp;						\
>  									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	mov	%" #w "[tmp], %" #w "[old]\n"			\
>  	"	cas" #mb #sfx "\t%" #w "[tmp], %" #w "[new], %[v]\n"	\
>  	"	mov	%" #w "[ret], %" #w "[tmp]"			\
> @@ -377,6 +395,7 @@ static inline long __lse__cmpxchg_double##name(unsigned long old1,	\
>  	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
>  									\
>  	asm volatile(							\
> +	__LSE_PREAMBLE							\
>  	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
>  	"	eor	%[old1], %[old1], %[oldval1]\n"			\
>  	"	eor	%[old2], %[old2], %[oldval2]\n"			\
> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
> index 80b388278149..73834996c4b6 100644
> --- a/arch/arm64/include/asm/lse.h
> +++ b/arch/arm64/include/asm/lse.h
> @@ -6,6 +6,8 @@
>  
>  #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
>  
> +#define __LSE_PREAMBLE	".arch armv8-a+lse\n"
> +
>  #include <linux/compiler_types.h>
>  #include <linux/export.h>
>  #include <linux/jump_label.h>
> @@ -14,8 +16,6 @@
>  #include <asm/atomic_lse.h>
>  #include <asm/cpucaps.h>
>  
> -__asm__(".arch_extension	lse");
> -
>  extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
>  extern struct static_key_false arm64_const_caps_ready;
>  
> @@ -34,7 +34,7 @@ static inline bool system_uses_lse_atomics(void)
>  
>  /* In-line patching at runtime */
>  #define ARM64_LSE_ATOMIC_INSN(llsc, lse)				\
> -	ALTERNATIVE(llsc, lse, ARM64_HAS_LSE_ATOMICS)
> +	ALTERNATIVE(llsc, __LSE_PREAMBLE lse, ARM64_HAS_LSE_ATOMICS)
>  
>  #else	/* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
>  
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 
