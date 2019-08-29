Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A283C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DC82189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="om9rfD3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfH2Teh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:34:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41158 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfH2Teh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:34:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so4592120wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wITCcu1aUHRsjm7ofKS0hPTgotk+bgOxAXtcBSapAng=;
        b=om9rfD3r3tWjux8nXOwoZHcvldgVv/88BLWEtjKKzNKRH0tOOMfrrvA1v/uSesZqAu
         F7xX0euXGljeMqlw8nAb87SdY/wz+KlGjAGstx1Cuqawl7/7sq7xH+/aKl4IulH2TYZl
         SZRq839nEKBvwW+Hy2x+q93UiBGv3oCw7wAYKPtqIFzrQkz3jOtwmtk+7CTPsHl+c3pD
         e7LBTdEZn/u5wHLMtVvJ+rGnjH3T0s5DFj2WTmk3UK2yKgaR0r9tMr1GeJzJ/kXzMbhF
         vqCqisP/AY91nhTO7uYN2DG8DSJ5v+qlaYmIDocQZtGuG+lYs+VNS5phXDxwA1Ug/OyA
         sACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wITCcu1aUHRsjm7ofKS0hPTgotk+bgOxAXtcBSapAng=;
        b=mfvddlpnI8ze2BP8Uudap2Mjj2iUCGVp1Pa6ZRhJyVKLf7VnBTUvIMqbrdVt2sB5Aj
         Y2XlgZUg+gibBuEpSN4Hq6acSeT6RLEpPX/Rs5i+YruIFYi26ru0DBDeHrrINUKzPll2
         ru1P5AbvAb0p2XgEVI2N+kC5zjoOPUW43r5OuM8B2naPKRwds+0vNMrCzirbKUPxWfTU
         4N2rf0AoubywEio2TYGrgTOIivzkaIzesCs4S/i526IKr9qAH7Oyv24kzvzHM1NTK5iq
         RJdvyzZ1AoVBr+1EbC6T6y9D9WannFwWQQU6ZqbMpUOrXM/Ai/QMAKPu2fg9h+UWAFEi
         60qA==
X-Gm-Message-State: APjAAAXfREKHnvjBY+xJ7YgEgqt2hzX922O2EozhV8zWnoC77xKpSNZF
        uWdWNUy2cs92sSRypH0eQtw=
X-Google-Smtp-Source: APXvYqwfC0hwHaNvtKcJP+AMQFx3UwJll3qWxANro4klHhx9Oo9LuQbO5ZMREVBc1sxJESACW/y4cg==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr10775791wrn.62.1567107274840;
        Thu, 29 Aug 2019 12:34:34 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c201sm7320983wmd.33.2019.08.29.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:34:34 -0700 (PDT)
Date:   Thu, 29 Aug 2019 12:34:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or
 newer
Message-ID: <20190829193432.GA10138@archlinux-threadripper>
References: <20190829062635.45609-1-natechancellor@gmail.com>
 <CAKwvOdkXSWE+_JCZsuQdkCSrK5pJSp9n_Cd27asFP0mHBfHg6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkXSWE+_JCZsuQdkCSrK5pJSp9n_Cd27asFP0mHBfHg6w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:55:28AM -0700, Nick Desaulniers wrote:
> On Wed, Aug 28, 2019 at 11:27 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
> > with clang:
> >
> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
> > softirq.c:(.text+0x504): undefined reference to `mcount'
> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
> > softirq.c:(.text+0x58c): undefined reference to `mcount'
> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
> > softirq.c:(.text+0x6c8): undefined reference to `mcount'
> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
> > softirq.c:(.text+0x75c): undefined reference to `mcount'
> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
> > softirq.c:(.text+0x840): undefined reference to `mcount'
> > arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow
> >
> > clang can emit a working mcount symbol, __gnu_mcount_nc, when
> > '-meabi gnu' is passed to it. Until r369147 in LLVM, this was
> > broken and caused the kernel not to boot because the calling
> > convention was not correct. Now that it is fixed, add this to
> > the command line when clang is 10.0.0 or newer so everything
> > works properly.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/35
> > Link: https://bugs.llvm.org/show_bug.cgi?id=33845
> > Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  arch/arm/Makefile | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index c3624ca6c0bc..7b5a26a866fc 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -112,6 +112,12 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
> >  CFLAGS_ABI     +=-funwind-tables
> >  endif
> >
> > +ifeq ($(CONFIG_CC_IS_CLANG),y)
> > +ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 100000; echo $$?),0)
> > +CFLAGS_ABI     +=-meabi gnu
> > +endif
> > +endif
> > +
> 
> Thanks for the patch!  I think this is one of the final issues w/ 32b
> ARM configs when building w/ Clang.
> 
> I'm not super enthused about the version check.  The flag is indeed
> not recognized by GCC, but I think it would actually be more concise
> with $(cc-option) and no compiler or version check.
> 
> Further, I think that the working __gnu_mcount_nc in Clang would
> better be represented as marking the arch/arm/KConfig option for
> CONFIG_FUNCTION_TRACER for dependent on a version of Clang greater
> than or equal to Clang 10, not conditionally adding this flag. (We
> should always add the flag when supported, IMO.  __gnu_mcount_nc's
> calling convention being broken is orthogonal to the choice of
> __gnu_mcount_nc vs mcount, and it's the former's that should be
> checked, not the latter as in this patch.

I will test with or without CONFIG_AEABI like Matthias asked and I will
implement your Kconfig suggestion if it passes all of my tests. The
reason that I did it this way is because I didn't want a user to end up
with a non-booting kernel since -meabi gnu works with older versions of
clang at build time, the issue happens at boot time but the Kconfig
suggestion + cc-option should fix that.

I should have a v2 out this evening.

Cheers,
Nathan
