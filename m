Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB8C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F80206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 21:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HooNS6Li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391858AbfIIVgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 17:36:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39610 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbfIIVgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 17:36:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id bd8so7279702plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWfChiuUJemWX/xDu17NLd8EQGs1u1yuvhrocXkkuOg=;
        b=HooNS6LiLAXvF9NxFE+eZmqZRW7ToWinYSCthOx4HHhPgE/cRzd5jeOMn2yr5WiqfB
         WWlxDcwln3c9YsBFYGXWBlVEZ5flrg0DIwF8uyiFU1xecYdg0iM3B7HAOOG9dPpQXnQb
         xfeUvSxsNN2yfg5eHVNBw2aaE7XZvNv+LAE2fZb99cS3FC30B+OOmiFzjSvTfmOEPbul
         kmLdtJfpkj1ewRj4T47B1pgiuWnCGu/mCYZHCfP+iFQNfDHLyi3eGGgCva+7KRCA2qQk
         9XUmCDuEPWSrnKjgUXKCem2BUmdBQUY9f3Cq7S8+c4ZB7mK1YvHTvKzeO5bcxg9HomkM
         KujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWfChiuUJemWX/xDu17NLd8EQGs1u1yuvhrocXkkuOg=;
        b=a05KEQqQk3dnQWw6oGqyCnntcRn+MKXCU/wr7PbKyH2IPU/sgKkrErIPBXt9bDR5pa
         JwWUvAFLH9I/MKBklaKqs2XGChrCHnBakl9sbkzi+u/cnJqIOQeHE3ThUf9RAXEu2PFV
         um+jBjMpJHZP9BD6nk25AAMy1FTx3hB8MGZpo6MbwDJueYPju/8N3sO8wyt6jcWR7hsk
         MqLeN9b+fTq2QUlNRSai54HZ2r9uUo/tpngpPwLwM3deqc6aEgUj4+ueFQyGKwk6tred
         po5fexiGLyxbKZjgFNG2jDI1+M0Ake06GdOaA67dExu9cnZz9+BslKCbbnjGhOmiljV+
         +3hg==
X-Gm-Message-State: APjAAAXF5ZzU6RYriSESG73MY5dZlI6BzW/y5azxj84Kqa0qTS/S9hkb
        9oPMVd+21VpLRE5/nLdlTTlTso+/m5LVQnj3uH2PRA==
X-Google-Smtp-Source: APXvYqwkg+0VvgZLd1QcDeZiY87eDys4X4c+0f1blThj9icDKEd2DCXH7feptcBVwXIi9LLpUJncKLJuNiuB3WNbZ4E=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr26519733plo.223.1568064960627;
 Mon, 09 Sep 2019 14:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190909202153.144970-1-arnd@arndb.de> <CAKwvOdn90naN2qLx6qBCii67HNOYeJmVqTKEKuUpXcTXLEEaLA@mail.gmail.com>
In-Reply-To: <CAKwvOdn90naN2qLx6qBCii67HNOYeJmVqTKEKuUpXcTXLEEaLA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Sep 2019 14:35:49 -0700
Message-ID: <CAKwvOdnnsQHkLG02oa2hkP8JDEiqnaH_xsxLrWBxSs0bvZetsQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 2:06 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Mon, Sep 9, 2019 at 1:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On arm64 build with clang, sometimes the __cmpxchg_mb is not inlined
> > when CONFIG_OPTIMIZE_INLINING is set.
> > Clang then fails a compile-time assertion, because it cannot tell at
> > compile time what the size of the argument is:
> >
> > mm/memcontrol.o: In function `__cmpxchg_mb':
> > memcontrol.c:(.text+0x1a4c): undefined reference to `__compiletime_assert_175'
> > memcontrol.c:(.text+0x1a4c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__compiletime_assert_175'
> >
> > Mark all of the cmpxchg() style functions as __always_inline to
> > ensure that the compiler can see the result.
>
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>

Also, I think a Link tag may be appropriate as I believe it fixes this report:

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/648

>
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm64/include/asm/cmpxchg.h | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> > index a1398f2f9994..fd64dc8a235f 100644
> > --- a/arch/arm64/include/asm/cmpxchg.h
> > +++ b/arch/arm64/include/asm/cmpxchg.h
> > @@ -19,7 +19,7 @@
> >   * acquire+release for the latter.
> >   */
> >  #define __XCHG_CASE(w, sfx, name, sz, mb, nop_lse, acq, acq_lse, rel, cl)      \
> > -static inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)                \
> > +static __always_inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)\
> >  {                                                                              \
> >         u##sz ret;                                                              \
> >         unsigned long tmp;                                                      \
> > @@ -62,7 +62,7 @@ __XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
> >  #undef __XCHG_CASE
> >
> >  #define __XCHG_GEN(sfx)                                                        \
> > -static inline unsigned long __xchg##sfx(unsigned long x,               \
> > +static __always_inline  unsigned long __xchg##sfx(unsigned long x,     \
> >                                         volatile void *ptr,             \
> >                                         int size)                       \
> >  {                                                                      \
> > @@ -103,8 +103,9 @@ __XCHG_GEN(_mb)
> >  #define arch_xchg_release(...) __xchg_wrapper(_rel, __VA_ARGS__)
> >  #define arch_xchg(...)         __xchg_wrapper( _mb, __VA_ARGS__)
> >
> > -#define __CMPXCHG_CASE(name, sz)                       \
> > -static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,      \
> > +#define __CMPXCHG_CASE(name, sz)                                       \
> > +static __always_inline u##sz                                           \
> > +__cmpxchg_case_##name##sz(volatile void *ptr,                          \
> >                                               u##sz old,                \
> >                                               u##sz new)                \
> >  {                                                                      \
> > @@ -148,7 +149,7 @@ __CMPXCHG_DBL(_mb)
> >  #undef __CMPXCHG_DBL
> >
> >  #define __CMPXCHG_GEN(sfx)                                             \
> > -static inline unsigned long __cmpxchg##sfx(volatile void *ptr,         \
> > +static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,        \
> >                                            unsigned long old,           \
> >                                            unsigned long new,           \
> >                                            int size)                    \
> > @@ -230,7 +231,7 @@ __CMPXCHG_GEN(_mb)
> >  })
> >
> >  #define __CMPWAIT_CASE(w, sfx, sz)                                     \
> > -static inline void __cmpwait_case_##sz(volatile void *ptr,             \
> > +static __always_inline void __cmpwait_case_##sz(volatile void *ptr,    \
> >                                        unsigned long val)               \
> >  {                                                                      \
> >         unsigned long tmp;                                              \
> > @@ -255,7 +256,7 @@ __CMPWAIT_CASE( ,  , 64);
> >  #undef __CMPWAIT_CASE
> >
> >  #define __CMPWAIT_GEN(sfx)                                             \
> > -static inline void __cmpwait##sfx(volatile void *ptr,                  \
> > +static __always_inline void __cmpwait##sfx(volatile void *ptr,         \
> >                                   unsigned long val,                    \
> >                                   int size)                             \
> >  {                                                                      \
> > --
> > 2.20.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190909202153.144970-1-arnd%40arndb.de.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
