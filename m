Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DF8C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3095923427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNqfRzTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfH3R2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:28:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51594 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3R23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:28:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id k1so8166961wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eu7o1tjFJuoZ/R7GMzAcbzkgVT62tsYAxGmizjWMX1g=;
        b=vNqfRzTuHbAvVsS3zUpvAVib5iQ1fToXe25SMvEN3IZ6lKxyl1nk3LVqLbPT52L/e7
         h5mm7R83u/TOPgVcrOKY1IAXFwIjRRAQshoHym8JYlqKKxQuWVW/y+y0GzXPPWaXhypD
         JAXnmHSBwMRF3livuug96Ox1F2DepxnFINXLI647jrPR+/9V5SWrnkMp3vrlwzQ9iIL6
         Le2BVyhDYv4T3IUHcVPAJl1wBL9qxXtmERxOu1SHy+TeDexMl6Fj1Yp3rfOYlrGdwkDR
         s3mzYAmvCqoBCBYppE9lZ25q9wkH5AopP8ZqFJ5+XkmKByr9b6v2Z7ipZy4L351Sk/DB
         g6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eu7o1tjFJuoZ/R7GMzAcbzkgVT62tsYAxGmizjWMX1g=;
        b=DYDfPJrVHcNALyhau32ncIVew5RokrRvXyTkzP9dmhZG8IypvCaoAmpsM5Q8fHXCbm
         jmq/ROZvTfkCc/eErHgWv+gTXUgYF/DUr02Q55bKEAXQfdEo3a7O5FhTiSQFDp9YkCW0
         oSx7uxMM2dwGkKklaIw7tSDpkW6LZVBwnTBltV82J8ZIRUdd261O3gOIyWT3R5Xg8Hcx
         TIu/RygrV799WU+Wdzs4E1thSsQUuAr4StHjSs4WrKgPJwzQ5ZUQEWIle1RETT/LhsKu
         xYeeXpgMPbDHBsIC5RPALMVxiJP/SxJnX/+I+z3sMOaUn63kftbnVQDeGd7Za3G5fG1t
         WOAg==
X-Gm-Message-State: APjAAAV2dzGCmPAz62Z31WqZbTzhSqhpRTgkr2PBu93ZnCJOPmaz5ooI
        afzmkGsYN7DI+YO+/Hl90HE=
X-Google-Smtp-Source: APXvYqz/4etEtnnJmT0nqV9j3YE+c03EhkYjYG1flkPxaetZUPtf48FALOgc5C5NoMqOsBgY4e48ig==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr18881080wmh.173.1567186106390;
        Fri, 30 Aug 2019 10:28:26 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id p9sm7465898wru.61.2019.08.30.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 10:28:25 -0700 (PDT)
Date:   Fri, 30 Aug 2019 10:28:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or
 newer
Message-ID: <20190830172824.GA119107@archlinux-threadripper>
References: <20190829062635.45609-1-natechancellor@gmail.com>
 <CAKwvOdkXSWE+_JCZsuQdkCSrK5pJSp9n_Cd27asFP0mHBfHg6w@mail.gmail.com>
 <20190829193432.GA10138@archlinux-threadripper>
 <885bb20c11f0cb004e5eeda7b0ca6d16@agner.ch>
 <CAKwvOdm-9T5Mmys93VMK8HLUgPJa2HOpcmG96SAvH2EGLA=3Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm-9T5Mmys93VMK8HLUgPJa2HOpcmG96SAvH2EGLA=3Nw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 01:57:35PM -0700, Nick Desaulniers wrote:
> On Thu, Aug 29, 2019 at 1:21 PM Stefan Agner <stefan@agner.ch> wrote:
> >
> > On 2019-08-29 21:34, Nathan Chancellor wrote:
> > > On Thu, Aug 29, 2019 at 10:55:28AM -0700, Nick Desaulniers wrote:
> > >> On Wed, Aug 28, 2019 at 11:27 PM Nathan Chancellor
> > >> <natechancellor@gmail.com> wrote:
> > >> >
> > >> > Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
> > >> > with clang:
> > >> >
> > >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
> > >> > softirq.c:(.text+0x504): undefined reference to `mcount'
> > >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
> > >> > softirq.c:(.text+0x58c): undefined reference to `mcount'
> > >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
> > >> > softirq.c:(.text+0x6c8): undefined reference to `mcount'
> > >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
> > >> > softirq.c:(.text+0x75c): undefined reference to `mcount'
> > >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
> > >> > softirq.c:(.text+0x840): undefined reference to `mcount'
> > >> > arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow
> > >> >
> > >> > clang can emit a working mcount symbol, __gnu_mcount_nc, when
> > >> > '-meabi gnu' is passed to it. Until r369147 in LLVM, this was
> > >> > broken and caused the kernel not to boot because the calling
> > >> > convention was not correct. Now that it is fixed, add this to
> > >> > the command line when clang is 10.0.0 or newer so everything
> > >> > works properly.
> > >> >
> > >> > Link: https://github.com/ClangBuiltLinux/linux/issues/35
> > >> > Link: https://bugs.llvm.org/show_bug.cgi?id=33845
> > >> > Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
> > >> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >> > ---
> > >> >  arch/arm/Makefile | 6 ++++++
> > >> >  1 file changed, 6 insertions(+)
> > >> >
> > >> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > >> > index c3624ca6c0bc..7b5a26a866fc 100644
> > >> > --- a/arch/arm/Makefile
> > >> > +++ b/arch/arm/Makefile
> > >> > @@ -112,6 +112,12 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
> > >> >  CFLAGS_ABI     +=-funwind-tables
> > >> >  endif
> > >> >
> > >> > +ifeq ($(CONFIG_CC_IS_CLANG),y)
> > >> > +ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 100000; echo $$?),0)
> > >> > +CFLAGS_ABI     +=-meabi gnu
> > >> > +endif
> > >> > +endif
> > >> > +
> > >>
> > >> Thanks for the patch!  I think this is one of the final issues w/ 32b
> > >> ARM configs when building w/ Clang.
> > >>
> > >> I'm not super enthused about the version check.  The flag is indeed
> > >> not recognized by GCC, but I think it would actually be more concise
> > >> with $(cc-option) and no compiler or version check.
> > >>
> > >> Further, I think that the working __gnu_mcount_nc in Clang would
> > >> better be represented as marking the arch/arm/KConfig option for
> > >> CONFIG_FUNCTION_TRACER for dependent on a version of Clang greater
> > >> than or equal to Clang 10, not conditionally adding this flag. (We
> > >> should always add the flag when supported, IMO.  __gnu_mcount_nc's
> > >> calling convention being broken is orthogonal to the choice of
> > >> __gnu_mcount_nc vs mcount, and it's the former's that should be
> > >> checked, not the latter as in this patch.
> > >
> > > I will test with or without CONFIG_AEABI like Matthias asked and I will
> > > implement your Kconfig suggestion if it passes all of my tests. The
> > > reason that I did it this way is because I didn't want a user to end up
> > > with a non-booting kernel since -meabi gnu works with older versions of
> > > clang at build time, the issue happens at boot time but the Kconfig
> > > suggestion + cc-option should fix that.
> >
> > I agree with Nathan here, I'd rather prefer the build system to fail
> > building rather than runtime error.
> >
> > If we decide we want to have it building despite it not building a
> > functional kernel, we should at least add a #warning...
> 
> Just to be clear...I was suggesting a build failure, but for
> __gnu_mcount_nc not having the correct calling convention in older
> clang releases, which is orthogonal to passing `-meabi gnu`.  This
> patch uses the __gnu_mcount_nc calling convention problem to justify a
> version check for a flag that while closely related, is not actually
> the problem, IMO.

I am not entirely sure what you mean. -meabi gnu has always produced a
buildable kernel (see Stefan's original report [1]), it just doesn't
boot and that all happens silently.

[1]: https://lore.kernel.org/linux-arm-kernel/35ae3d464c7b77a5fe86a732079e32bc@agner.ch/

Okay, after doing some further testing...

Disabling CONFIG_AEABI does not work with clang, I get a ton of failures
around undefined references to __aeabi_idivmod and __aeabi_uidivmod. I
don't think this is worth looking into given that CONFIG_AEABI is not
selectable when CONFIG_CPU_V6 or CONFIG_CPU_V7 is selected, which is
what we primarily care about.. We currently build and boot
multi_v5_defconfig but it has CONFIG_AEABI set in it. As a result, I
don't think we need to care about it with this patch.

This diff would also solve the issue without the need for the version
check in the Makefile, as it is the combination of -meabi gnu and -pg
that causes the boot issue and -pg gets added when
CONFIG_FUNCTION_TRACER is enabled. Would that be preferred? I do not
think adding cc-option is necessary given that we know GCC universally
does not support this flag; there is no point in adding a small penalty
with cc-option to either compiler.

Cheers,
Nathan

================================================

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a98c7af50bf0..440ad41e77e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -83,7 +83,7 @@ config ARM
 	select HAVE_FAST_GUP if ARM_LPAE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && (CC_IS_GCC || CLANG_VERSION >= 100000)
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IDE if PCI || ISA || PCMCIA
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a43fc753aa53..23c2bf0fbd30 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -115,6 +115,10 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
 CFLAGS_ABI	+=-funwind-tables
 endif
 
+ifeq ($(CONFIG_CC_IS_CLANG),y)
+CFLAGS_ABI	+=-meabi gnu
+endif
+
 # Accept old syntax despite ".syntax unified"
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 
