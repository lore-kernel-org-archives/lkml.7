Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EC72054F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7NhIGlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfIQUea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:34:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39487 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQUe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:34:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so4566182wrj.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OD2RWaEvg0mKlB6+gvYRUOgK2t5a0eHRxcmucEA949U=;
        b=o7NhIGlLeKfZDZG/2v5fuiQ6Daq/jDGeUpCjB0kSeMoO6VkVfDBjgmnPxmCYlR/Ncp
         zvmTMOiEaipeD4CNEgWtO238GY+pqE8Z6ukFypHk0F+rhd5pTrdNFQkGpu2hDk/wXjmC
         wngE6br/fCluvfzIkf4z1NISPd7pszVW6uUDzZnQH4xO2CEYVFiiHGUdlp4NJjhFKQoT
         oxUWpdll98bzyuJ+jHaVbk2vCbfcN1oagvsWvr2lK2BFS91/kr2ITuX0kkJDbLdsStnU
         VPSD1MoQh5xKCNeHDhzPUGXl5PHoFIi5dxN4Oan3UCmcJS7GNMfDI+DckXyUh6Kp7D+T
         Mdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OD2RWaEvg0mKlB6+gvYRUOgK2t5a0eHRxcmucEA949U=;
        b=soPJtyCg3eO6rKz7gDnQY4RQ3DVwI8Z3X3QGsOVlBCLDle5MKj4Dlxxo84ACetUICv
         k9dlGGR8MOgfnjOOZxwU3Bcm3Z0tddhr8dJh1AJ6tisYkZV9QLICAgwGFPVsgNQQuFGe
         S79n/MqmENoblyniIgdctQmbyTNc2Ic1TrOzxjURdvWXb7FuqaAZQujN4iGsRclV3828
         rYzb9s0SbiOrZAbTK4pSMVkRfOykzS5Z6WsHonzhewSMvNwTKlVg3+ksNYl05gW+8akm
         LDPQGkraigJOS61Cctab4iEY2n/QHNheZjPoCUT1GPhl2lXW6WfnQ0HghWy1nLdbk/Rp
         fqDQ==
X-Gm-Message-State: APjAAAXSYsviV2oKolcRu1Ztwl/8KN9aVrr7XZVnM8gmtkUpiYtXZLND
        1jqu9o+PZMDjEJ4VR5SkD9lTyFB9V8Gv9w==
X-Google-Smtp-Source: APXvYqxhnNq0yqOrawXMaQYRcUtP27ZOq4tAifJHQCJI7Zugd+8QHbWna+1DR7USZuanbBpm9ScAqg==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr339029wrs.146.1568752467716;
        Tue, 17 Sep 2019 13:34:27 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id p85sm7607787wme.23.2019.09.17.13.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:34:26 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:34:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190917203425.GA31423@archlinux-threadripper>
References: <20190910115643.391995-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910115643.391995-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 01:56:22PM +0200, Arnd Bergmann wrote:
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
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/648
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Tested-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: skip unneeded changes, as suggested by Andrew Murray
> ---
>  arch/arm64/include/asm/cmpxchg.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index a1398f2f9994..f9bef42c1411 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -62,7 +62,7 @@ __XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
>  #undef __XCHG_CASE
>  
>  #define __XCHG_GEN(sfx)							\
> -static inline unsigned long __xchg##sfx(unsigned long x,		\
> +static __always_inline  unsigned long __xchg##sfx(unsigned long x,	\
>  					volatile void *ptr,		\
>  					int size)			\
>  {									\
> @@ -148,7 +148,7 @@ __CMPXCHG_DBL(_mb)
>  #undef __CMPXCHG_DBL
>  
>  #define __CMPXCHG_GEN(sfx)						\
> -static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
> +static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
>  					   unsigned long old,		\
>  					   unsigned long new,		\
>  					   int size)			\
> @@ -255,7 +255,7 @@ __CMPWAIT_CASE( ,  , 64);
>  #undef __CMPWAIT_CASE
>  
>  #define __CMPWAIT_GEN(sfx)						\
> -static inline void __cmpwait##sfx(volatile void *ptr,			\
> +static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
>  				  unsigned long val,			\
>  				  int size)				\
>  {									\
> -- 
> 2.20.0
> 

Looks like the arm64 pull request happened without this patch so clang
all{mod,yes}config builds are broken. Did the maintainers have any
further comments on it or could this make it in with the next one?

Cheers,
Nathan
