Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40D020872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfIJJX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:23:29 -0400
Received: from foss.arm.com ([217.140.110.172]:59728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfIJJX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:23:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F49728;
        Tue, 10 Sep 2019 02:23:28 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AED63F71F;
        Tue, 10 Sep 2019 02:23:27 -0700 (PDT)
Date:   Tue, 10 Sep 2019 10:23:25 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190910092324.GI9720@e119886-lin.cambridge.arm.com>
References: <20190909202153.144970-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909202153.144970-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 10:21:35PM +0200, Arnd Bergmann wrote:
> On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> when CONFIG_OPTIMIZE_INLINING is set.
> Clang then fails a compile-time assertion, because it cannot tell at
> compile time what the size of the argument is:
> 
> mm/memcontrol.o: In function `__cmpxchg_mb':
> memcontrol.c:(.text+0x1a4c): undefined reference to `__compiletime_assert_175'
> memcontrol.c:(.text+0x1a4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__compiletime_assert_175'
> 
> Mark all of the cmpxchg() style functions as __always_inline to
> ensure that the compiler can see the result.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I was able to reproduce this with the following:

$ git describe HEAD
next-20190904

$ clang --version
Android (5821526 based on r365631) clang version 9.0.6 (https://android.googlesource.com/toolchain/llvm-project 85305eaf1e90ff529d304abac8a979e1d967f0a2) (based on LLVM 9.0.6svn)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/andrewm/android-clang/clang-r365631/bin

$ make O=~/linux-build/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang -j56 allyesconfig Image

(I was unable to reproduce with defconfig+OPTIMIZE_INLINING).

However...

>  arch/arm64/include/asm/cmpxchg.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index a1398f2f9994..fd64dc8a235f 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -19,7 +19,7 @@
>   * acquire+release for the latter.
>   */
>  #define __XCHG_CASE(w, sfx, name, sz, mb, nop_lse, acq, acq_lse, rel, cl)	\
> -static inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)		\
> +static __always_inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)\

This hunk isn't needed, there is no BUILD_BUG here.


>  {										\
>  	u##sz ret;								\
>  	unsigned long tmp;							\
> @@ -62,7 +62,7 @@ __XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
>  #undef __XCHG_CASE
>  
>  #define __XCHG_GEN(sfx)							\
> -static inline unsigned long __xchg##sfx(unsigned long x,		\
> +static __always_inline  unsigned long __xchg##sfx(unsigned long x,	\
>  					volatile void *ptr,		\
>  					int size)			\
>  {									\
> @@ -103,8 +103,9 @@ __XCHG_GEN(_mb)
>  #define arch_xchg_release(...)	__xchg_wrapper(_rel, __VA_ARGS__)
>  #define arch_xchg(...)		__xchg_wrapper( _mb, __VA_ARGS__)
>  
> -#define __CMPXCHG_CASE(name, sz)			\
> -static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,	\
> +#define __CMPXCHG_CASE(name, sz)					\
> +static __always_inline u##sz 						\
> +__cmpxchg_case_##name##sz(volatile void *ptr,				\

This hunk isn't needed, there is no BUILD_BUG here.

>  					      u##sz old,		\
>  					      u##sz new)		\
>  {									\
> @@ -148,7 +149,7 @@ __CMPXCHG_DBL(_mb)
>  #undef __CMPXCHG_DBL
>  
>  #define __CMPXCHG_GEN(sfx)						\
> -static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
> +static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
>  					   unsigned long old,		\
>  					   unsigned long new,		\
>  					   int size)			\
> @@ -230,7 +231,7 @@ __CMPXCHG_GEN(_mb)
>  })
>  
>  #define __CMPWAIT_CASE(w, sfx, sz)					\
> -static inline void __cmpwait_case_##sz(volatile void *ptr,		\
> +static __always_inline void __cmpwait_case_##sz(volatile void *ptr,	\
>  				       unsigned long val)		\

This hunk isn't needed, there is no BUILD_BUG here.

>  {									\
>  	unsigned long tmp;						\
> @@ -255,7 +256,7 @@ __CMPWAIT_CASE( ,  , 64);
>  #undef __CMPWAIT_CASE
>  
>  #define __CMPWAIT_GEN(sfx)						\
> -static inline void __cmpwait##sfx(volatile void *ptr,			\
> +static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
>  				  unsigned long val,			\
>  				  int size)				\
>  {									\

Alternatively is it possible to replace the BUILD_BUG's with something else?

I think because we use BUILD_BUG at the end of a switch statement, we make
the assumption that size is known at compile time, for this reason we should
ensure the function containing the BUILD_BUG is __always_inline.

Looking across the kernel where BUILD_BUG is used as a default in a switch
statment ($ git grep -B 3 BUILD_BUG\( | grep default), most instances are
within macros, but many are found in an __always_inline function:

arch/x86/kvm/cpuid.h
mm/kasan/generic.c

Though some are not:

include/linux/signal.h
arch/arm64/include/asm/arm_dsu/pmu.h

I wonder if there may be a latent mole ready to whack with pmu.h?

Anyway with just the three remaining hunks:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Tested-by: Andrew Murray <andrew.murray@arm.com>

> -- 
> 2.20.0
> 
