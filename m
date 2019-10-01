Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7097C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C664021855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbfJALli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:41:38 -0400
Received: from foss.arm.com ([217.140.110.172]:47532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387715AbfJALld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CAAC337;
        Tue,  1 Oct 2019 04:41:32 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85B53F706;
        Tue,  1 Oct 2019 04:41:31 -0700 (PDT)
Date:   Tue, 1 Oct 2019 12:41:30 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] Partially revert "compiler: enable
 CONFIG_OPTIMIZE_INLINING forcibly"
Message-ID: <20191001114129.GL42880@e119886-lin.cambridge.arm.com>
References: <20190930114540.27498-1-will@kernel.org>
 <CAK7LNARWkQ-z02RYv3XQ69KkWdmEVaZge07qiYC8_kyMrFzCTg@mail.gmail.com>
 <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 11:42:54AM +0100, Will Deacon wrote:
> On Tue, Oct 01, 2019 at 06:40:26PM +0900, Masahiro Yamada wrote:
> > On Mon, Sep 30, 2019 at 8:45 PM Will Deacon <will@kernel.org> wrote:
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 93d97f9b0157..c37c72adaeff 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -312,6 +312,7 @@ config HEADERS_CHECK
> > >
> > >  config OPTIMIZE_INLINING
> > >         def_bool y
> > > +       depends on !(ARM || ARM64) # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111
> > 
> > 
> > This is a too big hammer.
> 
> It matches the previous default behaviour!
> 
> > For ARM, it is not a compiler bug, so I am trying to fix the kernel code.
> > 
> > For ARM64, even if it is a compiler bug, you can add __always_inline
> > to the functions in question.
> > (arch_atomic64_dec_if_positive in this case).
> > 
> > You do not need to force __always_inline globally.
> 
> So you'd prefer I do something like the diff below? I mean, it's a start,
> but I do worry that we're hanging arch/arm/ out to dry.

If I've understood one part of this issue correctly - and using the
c2p_unsupported build failure as an example [1], there are instances in
the kernel where it is assumed that the compiler will optimise out a call
to an undefined function, and also assumed that the compiler will know
at compile time that the function will never get called. It's common to
satisfy this assumption when the calling function is inlined.

But I suspect there may be other cases similar to c2p_unsupported which
are still lurking.

For example the following functions are called but non-existent, and thus
may be an area worth investigating:

__buggy_use_of_MTHCA_PUT, __put_dbe_unknown, __cmpxchg_wrong_size,
__bad_percpu_size, __put_user_bad, __get_user_unknown,
__bad_unaligned_access_size, __bad_xchg

But more generally, as this is a common pattern - isn't there a benefit
here for changing all of these to BUILD_BUG? (So they can be found easily).

Or to avoid this class of issues, change them to BUG or unreachable - but
lose the benefit of compile time detection?

Thanks,

Andrew Murray

[1] https://lore.kernel.org/patchwork/patch/1122097/
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index c6bd87d2915b..574808b9df4c 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -321,7 +321,8 @@ static inline s64 __lse_atomic64_dec_if_positive(atomic64_t *v)
>  }
>  
>  #define __CMPXCHG_CASE(w, sfx, name, sz, mb, cl...)                    \
> -static inline u##sz __lse__cmpxchg_case_##name##sz(volatile void *ptr, \
> +static __always_inline u##sz                                           \
> +__lse__cmpxchg_case_##name##sz(volatile void *ptr,                     \
>                                               u##sz old,                \
>                                               u##sz new)                \
>  {                                                                      \
> @@ -362,7 +363,8 @@ __CMPXCHG_CASE(x,  ,  mb_, 64, al, "memory")
>  #undef __CMPXCHG_CASE
>  
>  #define __CMPXCHG_DBL(name, mb, cl...)                                 \
> -static inline long __lse__cmpxchg_double##name(unsigned long old1,     \
> +static __always_inline long                                            \
> +__lse__cmpxchg_double##name(unsigned long old1,                                \
>                                          unsigned long old2,            \
>                                          unsigned long new1,            \
>                                          unsigned long new2,            \
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
