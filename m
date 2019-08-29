Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1F6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3465B23403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWMz75Bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfH2U5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:57:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45862 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfH2U5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:57:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so2215497pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeDSTDmCykdOboI0NlO40BAz1xd+JSb526zs42hsg2U=;
        b=wWMz75BiWBHHLdLBIU+n9B/CTKoZ8dnq7ADjr5OGkRKToC9bRZONCKrh+s/7WxD7P7
         Z3PvHQvDI/bCbDi3VZY+VBuWDE/OQMsYWdFaW948gYKyR6kSLUafPqt6V4FhN6A7wCIP
         uVYhYBK9kBRw1O318HxJm2hltIhZlolHYQfOjz6V8gOleVd8jMrQyPQByQeWmVk9Sn2u
         Auy3+9mHeWDUhVQ5kfe8o3iYFRgS5ETL2v5fuVn6ilMiDSsXtY7dMF16ndW4htSfXPV1
         /+rImTVhTYSOsPQ55Q+dbV55VJlWRxSavFs1RoGuZNaMNfRveYw764+z2zbZ0XrxGaRt
         Resw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeDSTDmCykdOboI0NlO40BAz1xd+JSb526zs42hsg2U=;
        b=kilGqWMd9I1kE8R3lxlNdodVOd1JyY7e1UjT0lpw9XtqzgKrqlft9wh9HEz9vcjVi4
         xBj44soMghVo+fKpcz2d0EpRZBcCLGbxY/wpKu8Dpq7DdqiaH4A8PXLKZnhwcICuLuPO
         dKmPgqEbPybEOP/mB43HoBIS5dnJP82y7ypnia+BfKBTzQSwccIZU9mu2w5Z2YNM2QSW
         hufb99rXMLsEYP2GKbCyYa8D8JAxuPuzqbYTjTjb7L+KSp9MTKmtfX5pLvil9fkhbY8S
         PKZB9RxUJMC5gPxNytFR7XvPN5GVUofIuXmDEU1lez7B920gAIvC6/LZXLa7HaTBWXp0
         UFBA==
X-Gm-Message-State: APjAAAVTaitJ9gJHg6N1yN0uKTu2crAcIcH5/SKpewb2NYyUel2btrHb
        jI8x39U21spoLbcPm8DVJgnzJnkkgjGTcLCG0XhOUQ==
X-Google-Smtp-Source: APXvYqwxrHQNUffGYMlvpasEH3mMMVTH2bEhfBs7v/LPPVikgEwGiFF8NSyvBwuYvYRbOoHdgoVBcicPa9Xep4yIjgw=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr11791171pjt.123.1567112267046;
 Thu, 29 Aug 2019 13:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190829062635.45609-1-natechancellor@gmail.com>
 <CAKwvOdkXSWE+_JCZsuQdkCSrK5pJSp9n_Cd27asFP0mHBfHg6w@mail.gmail.com>
 <20190829193432.GA10138@archlinux-threadripper> <885bb20c11f0cb004e5eeda7b0ca6d16@agner.ch>
In-Reply-To: <885bb20c11f0cb004e5eeda7b0ca6d16@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Aug 2019 13:57:35 -0700
Message-ID: <CAKwvOdm-9T5Mmys93VMK8HLUgPJa2HOpcmG96SAvH2EGLA=3Nw@mail.gmail.com>
Subject: Re: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer
To:     Stefan Agner <stefan@agner.ch>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 1:21 PM Stefan Agner <stefan@agner.ch> wrote:
>
> On 2019-08-29 21:34, Nathan Chancellor wrote:
> > On Thu, Aug 29, 2019 at 10:55:28AM -0700, Nick Desaulniers wrote:
> >> On Wed, Aug 28, 2019 at 11:27 PM Nathan Chancellor
> >> <natechancellor@gmail.com> wrote:
> >> >
> >> > Currently, multi_v7_defconfig + CONFIG_FUNCTION_TRACER fails to build
> >> > with clang:
> >> >
> >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `_local_bh_enable':
> >> > softirq.c:(.text+0x504): undefined reference to `mcount'
> >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `__local_bh_enable_ip':
> >> > softirq.c:(.text+0x58c): undefined reference to `mcount'
> >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `do_softirq':
> >> > softirq.c:(.text+0x6c8): undefined reference to `mcount'
> >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_enter':
> >> > softirq.c:(.text+0x75c): undefined reference to `mcount'
> >> > arm-linux-gnueabi-ld: kernel/softirq.o: in function `irq_exit':
> >> > softirq.c:(.text+0x840): undefined reference to `mcount'
> >> > arm-linux-gnueabi-ld: kernel/softirq.o:softirq.c:(.text+0xa50): more undefined references to `mcount' follow
> >> >
> >> > clang can emit a working mcount symbol, __gnu_mcount_nc, when
> >> > '-meabi gnu' is passed to it. Until r369147 in LLVM, this was
> >> > broken and caused the kernel not to boot because the calling
> >> > convention was not correct. Now that it is fixed, add this to
> >> > the command line when clang is 10.0.0 or newer so everything
> >> > works properly.
> >> >
> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/35
> >> > Link: https://bugs.llvm.org/show_bug.cgi?id=33845
> >> > Link: https://github.com/llvm/llvm-project/commit/16fa8b09702378bacfa3d07081afe6b353b99e60
> >> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> > ---
> >> >  arch/arm/Makefile | 6 ++++++
> >> >  1 file changed, 6 insertions(+)
> >> >
> >> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> >> > index c3624ca6c0bc..7b5a26a866fc 100644
> >> > --- a/arch/arm/Makefile
> >> > +++ b/arch/arm/Makefile
> >> > @@ -112,6 +112,12 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
> >> >  CFLAGS_ABI     +=-funwind-tables
> >> >  endif
> >> >
> >> > +ifeq ($(CONFIG_CC_IS_CLANG),y)
> >> > +ifeq ($(shell test $(CONFIG_CLANG_VERSION) -ge 100000; echo $$?),0)
> >> > +CFLAGS_ABI     +=-meabi gnu
> >> > +endif
> >> > +endif
> >> > +
> >>
> >> Thanks for the patch!  I think this is one of the final issues w/ 32b
> >> ARM configs when building w/ Clang.
> >>
> >> I'm not super enthused about the version check.  The flag is indeed
> >> not recognized by GCC, but I think it would actually be more concise
> >> with $(cc-option) and no compiler or version check.
> >>
> >> Further, I think that the working __gnu_mcount_nc in Clang would
> >> better be represented as marking the arch/arm/KConfig option for
> >> CONFIG_FUNCTION_TRACER for dependent on a version of Clang greater
> >> than or equal to Clang 10, not conditionally adding this flag. (We
> >> should always add the flag when supported, IMO.  __gnu_mcount_nc's
> >> calling convention being broken is orthogonal to the choice of
> >> __gnu_mcount_nc vs mcount, and it's the former's that should be
> >> checked, not the latter as in this patch.
> >
> > I will test with or without CONFIG_AEABI like Matthias asked and I will
> > implement your Kconfig suggestion if it passes all of my tests. The
> > reason that I did it this way is because I didn't want a user to end up
> > with a non-booting kernel since -meabi gnu works with older versions of
> > clang at build time, the issue happens at boot time but the Kconfig
> > suggestion + cc-option should fix that.
>
> I agree with Nathan here, I'd rather prefer the build system to fail
> building rather than runtime error.
>
> If we decide we want to have it building despite it not building a
> functional kernel, we should at least add a #warning...

Just to be clear...I was suggesting a build failure, but for
__gnu_mcount_nc not having the correct calling convention in older
clang releases, which is orthogonal to passing `-meabi gnu`.  This
patch uses the __gnu_mcount_nc calling convention problem to justify a
version check for a flag that while closely related, is not actually
the problem, IMO.
-- 
Thanks,
~Nick Desaulniers
