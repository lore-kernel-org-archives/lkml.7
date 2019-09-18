Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC26C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A81207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U351S7T4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfIRQCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:02:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50956 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfIRQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:02:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so769943wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yl3CO9TXK6n/CjIj2w2hV4glH8vSZmkVoir/AzZov4I=;
        b=U351S7T4SCivIrzesyKLpL9AreTpmBJQhbqLAJnNmsEnw3rIpnrKGwF6Fpc8D+2Al8
         RqkuS2WoofCu1MGiD8ec7/xQ+yXsK5YTpc6GpBZw5j3J98mR8h4i4Hs4BYV9MI7luQ5q
         5EyN3XIz2ayV3ApV1JeG+ZfIrtE2kfun6KmQX6jUkQcHOqqiWE9tNFLaT5elWSCMea/1
         Gw4y7+j+Ni8oInM8XSD/Ozoc+LzZ8yaB26Hks3ndYqa7HKJrLR8RPU7mu7HINAAGeT5u
         mrz4c+Zs6gr1oYnuVLVi1HpeAdPReQkg8IaV9Y0CfW9oyG3zNKDzVgwGkW257Mnr8nqM
         xtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yl3CO9TXK6n/CjIj2w2hV4glH8vSZmkVoir/AzZov4I=;
        b=YPeoqg3WAId7BDVJyK5Wg/Ka657NR6yS07+oLuB2ykcu5Tba758AZomP7E1Oe0S+uF
         0LNFEnqqXJLpnkCoj8HbXj7P/zubNAyv9GIqJuHfzW9mzX8lVDMPFPE/Wn7oA+9GqPal
         XpGtqjT5nqe4BJP1sc9h5zjBq1B1UmDEDmiFJ7+tGMm4eBwg6TqFt554z9MmfiPIudXm
         /NHicKSfvbOQt974bJpMOXeNvoELk0qvq8SjWrPUJDcxvOA5lbMV55eAI0d/xHdXQ4Ky
         6F1ERIooKq0GYAWpUnjJu8PN7MZt6mLl1Q1aELdM9TWgMwtE3+cyva8acey0jBMXA+59
         AW/w==
X-Gm-Message-State: APjAAAWHbiyPLuASMC4mEpYoHdDtD5hYAbKCAJlBbtAMV4UFE9OIdwD+
        fjeIYpb6lI2M91bCsfhK9Jg=
X-Google-Smtp-Source: APXvYqxEayvWyVYmkBnYgZYJPoYd22DnKWrjTOr+bR9LYPB1+dKok81yN6ApRMRZvGxAztD7zSPAvg==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr3638158wmh.101.1568822529834;
        Wed, 18 Sep 2019 09:02:09 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id r28sm8558346wrr.94.2019.09.18.09.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 09:02:09 -0700 (PDT)
Date:   Wed, 18 Sep 2019 09:02:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] arm64: fix unreachable code issue with cmpxchg
Message-ID: <20190918160207.GA23613@archlinux-threadripper>
References: <20190910115643.391995-1-arnd@arndb.de>
 <20190917203425.GA31423@archlinux-threadripper>
 <20190918090240.5cc3rfcuenefisgr@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918090240.5cc3rfcuenefisgr@willie-the-truck>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:02:41AM +0100, Will Deacon wrote:
> On Tue, Sep 17, 2019 at 01:34:25PM -0700, Nathan Chancellor wrote:
> > On Tue, Sep 10, 2019 at 01:56:22PM +0200, Arnd Bergmann wrote:
> > > On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> > > when CONFIG_OPTIMIZE_INLINING is set.
> > > Clang then fails a compile-time assertion, because it cannot tell at
> > > compile time what the size of the argument is:
> > > 
> > > mm/memcontrol.o: In function `__cmpxchg_mb':
> > > memcontrol.c:(.text+0x1a4c): undefined reference to `__compiletime_assert_175'
> > > memcontrol.c:(.text+0x1a4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__compiletime_assert_175'
> > > 
> > > Mark all of the cmpxchg() style functions as __always_inline to
> > > ensure that the compiler can see the result.
> > > 
> > > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/648
> > > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> > > Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> > > Tested-by: Andrew Murray <andrew.murray@arm.com>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > v2: skip unneeded changes, as suggested by Andrew Murray
> > > ---
> > >  arch/arm64/include/asm/cmpxchg.h | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > > index a1398f2f9994..f9bef42c1411 100644
> > > --- a/arch/arm64/include/asm/cmpxchg.h
> > > +++ b/arch/arm64/include/asm/cmpxchg.h
> > > @@ -62,7 +62,7 @@ __XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
> > >  #undef __XCHG_CASE
> > >  
> > >  #define __XCHG_GEN(sfx)							\
> > > -static inline unsigned long __xchg##sfx(unsigned long x,		\
> > > +static __always_inline  unsigned long __xchg##sfx(unsigned long x,	\
> > >  					volatile void *ptr,		\
> > >  					int size)			\
> > >  {									\
> > > @@ -148,7 +148,7 @@ __CMPXCHG_DBL(_mb)
> > >  #undef __CMPXCHG_DBL
> > >  
> > >  #define __CMPXCHG_GEN(sfx)						\
> > > -static inline unsigned long __cmpxchg##sfx(volatile void *ptr,		\
> > > +static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
> > >  					   unsigned long old,		\
> > >  					   unsigned long new,		\
> > >  					   int size)			\
> > > @@ -255,7 +255,7 @@ __CMPWAIT_CASE( ,  , 64);
> > >  #undef __CMPWAIT_CASE
> > >  
> > >  #define __CMPWAIT_GEN(sfx)						\
> > > -static inline void __cmpwait##sfx(volatile void *ptr,			\
> > > +static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
> > >  				  unsigned long val,			\
> > >  				  int size)				\
> > >  {									\
> > > -- 
> > > 2.20.0
> > > 
> > 
> > Looks like the arm64 pull request happened without this patch so clang
> > all{mod,yes}config builds are broken. Did the maintainers have any
> > further comments on it or could this make it in with the next one?
> 
> Fear not! I plan to send this with some other fixes we've got for -rc1.
> I just to get my CI scripts going again (new machine), but that shouldn't
> take long.
> 
> Will

Great, thank you!

Cheers,
Nathan
