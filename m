Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF79C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B502190F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569926581;
	bh=fLlcwekdrGSCzJboirhCdZb2pRq7XYqkATwD0/s6rn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E/QVq3ExIdWHDUHha2ioB7BNl1BFMrjlsVkr0rfTP/14lNqRD+H8WcTfEPyvAko+T
	 77EcVme7bza/3aIYSkIC7woIrhYFG0ldbYY0LU2T4QcAj6bkijPt56BWuACUOnSDLb
	 h+Oz9+Sxv7k7OjXC1Y7cvXSxRODQHG/TxZUyM5RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfJAKnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfJAKm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:42:59 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC6221906;
        Tue,  1 Oct 2019 10:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569926578;
        bh=fLlcwekdrGSCzJboirhCdZb2pRq7XYqkATwD0/s6rn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRf2kKjUQf04+gaCdNG46D5w6U0piINzln1PR2OvjWhQXDAlD/RkxgHyAojkua2nz
         tq/4o9XqfWbnpabpQep2kx3FXyKQzNDFI7iTKDHAJn8QNaUG8OfOL1tlrbNEC1ejgW
         RF5s1iWFOxLXHv36ZMje4zqPQUovVagB/ZgUvNJI=
Date:   Tue, 1 Oct 2019 11:42:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Partially revert "compiler: enable
 CONFIG_OPTIMIZE_INLINING forcibly"
Message-ID: <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
References: <20190930114540.27498-1-will@kernel.org>
 <CAK7LNARWkQ-z02RYv3XQ69KkWdmEVaZge07qiYC8_kyMrFzCTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARWkQ-z02RYv3XQ69KkWdmEVaZge07qiYC8_kyMrFzCTg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 06:40:26PM +0900, Masahiro Yamada wrote:
> On Mon, Sep 30, 2019 at 8:45 PM Will Deacon <will@kernel.org> wrote:
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 93d97f9b0157..c37c72adaeff 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -312,6 +312,7 @@ config HEADERS_CHECK
> >
> >  config OPTIMIZE_INLINING
> >         def_bool y
> > +       depends on !(ARM || ARM64) # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111
> 
> 
> This is a too big hammer.

It matches the previous default behaviour!

> For ARM, it is not a compiler bug, so I am trying to fix the kernel code.
> 
> For ARM64, even if it is a compiler bug, you can add __always_inline
> to the functions in question.
> (arch_atomic64_dec_if_positive in this case).
> 
> You do not need to force __always_inline globally.

So you'd prefer I do something like the diff below? I mean, it's a start,
but I do worry that we're hanging arch/arm/ out to dry.

Will

--->8

diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index c6bd87d2915b..574808b9df4c 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -321,7 +321,8 @@ static inline s64 __lse_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #define __CMPXCHG_CASE(w, sfx, name, sz, mb, cl...)                    \
-static inline u##sz __lse__cmpxchg_case_##name##sz(volatile void *ptr, \
+static __always_inline u##sz                                           \
+__lse__cmpxchg_case_##name##sz(volatile void *ptr,                     \
                                              u##sz old,                \
                                              u##sz new)                \
 {                                                                      \
@@ -362,7 +363,8 @@ __CMPXCHG_CASE(x,  ,  mb_, 64, al, "memory")
 #undef __CMPXCHG_CASE
 
 #define __CMPXCHG_DBL(name, mb, cl...)                                 \
-static inline long __lse__cmpxchg_double##name(unsigned long old1,     \
+static __always_inline long                                            \
+__lse__cmpxchg_double##name(unsigned long old1,                                \
                                         unsigned long old2,            \
                                         unsigned long new1,            \
                                         unsigned long new2,            \
