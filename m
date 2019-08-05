Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C780C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0757A20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 01:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxT5g4Xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfHEBSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 21:18:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36818 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfHEBSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 21:18:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so82742957wrs.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 18:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OuVA76lIPJxgsPabWbHp8eFg+xI+TfW22xDF1fY+ibo=;
        b=nxT5g4Xtf9VB7HvzuMT7+eLwcs+DX43CUV5Ah37ZLyPhkoqz59j8ToOG/q7UMTinqW
         Auc1vXIEFLfvHAQEDm1YC3eqxfSXIM2feDiCPw1Oa4+l81rw6LgzjUmimYM2niLfp49a
         x2/CcpSQ5z1PcwjAac0/dsRwfR/hHxuBKszrljam7UgNCXE6PGoA+El8alNUk36DwBQb
         dFfTzvOVUlDx7oegbPQoOplwYYHpg76dpfiBR+ozAM6uj0DMR4O02CppAMNCVeT2+dvi
         nfftWZB3xsNm49nmvmzSQP0sbt9BmtkmwldvcVoiEc5h+xHmmSuB7z+PTDxsT2AwPLKe
         qHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuVA76lIPJxgsPabWbHp8eFg+xI+TfW22xDF1fY+ibo=;
        b=AqqpxYms8A3115T+W/9InBGid7cKZQfpQk7b7tG97Q7KQeV91UF+tlG0Qm/57e8I/m
         dyphN5OfHSnSrppG+/ItKy0+BQxJOehj+Opt+q2SHDFSx/Zxdltvh6/BOAdFXdbjaY0Q
         wJSDEN3F8SvjHLeYn83dGhfEyUt7vN43/+gymaL7UxIws0Kkadm9B8XF1ru+zH2nM83V
         W/fzp4sPdU5+Ae4Y9kJGGSHN2s8S/Sbm6VKp9xQ9oi11WfHapkuxSDtMKat6znQCNYK8
         Hd1VB8aGZFI8kJm5Y0/WSGKCFKAb7ZiKM+eiAZFDQEeptr39YyklXxHHxDf98xF9yfHP
         giww==
X-Gm-Message-State: APjAAAVBNwODDo31td4Y8yDu3UahPywWlxTGBE/v8ttmdcbO2ioxVHnO
        7ZIIjDX5c6pYPT8vs9HxTEk=
X-Google-Smtp-Source: APXvYqx0RFcm7sdrwBKqtff4N1ieX6JcPGjk+7/z2IJqePK8ZoGL7IowrQRFsFji1LdpVoF0Ml0afg==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr31637468wrv.186.1564967898243;
        Sun, 04 Aug 2019 18:18:18 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id x20sm186678895wrg.10.2019.08.04.18.18.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 18:18:17 -0700 (PDT)
Date:   Sun, 4 Aug 2019 18:18:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <20190805011815.GA110280@archlinux-threadripper>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <c0669a7130645a20e99915385b7e712360c31ed9.camel@perches.com>
 <CAHk-=wg1PAJR6ChVXE7O_H2wEG=1mWxi2uc0fH5bthOC_81uTA@mail.gmail.com>
 <49b659d8f88f67c736881224203418f59a5d29ac.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b659d8f88f67c736881224203418f59a5d29ac.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sun, Aug 04, 2019 at 05:39:28PM -0700, Joe Perches wrote:
> On Sun, 2019-08-04 at 11:09 -0700, Linus Torvalds wrote:
> > On Sun, Aug 4, 2019 at 11:01 AM Joe Perches <joe@perches.com> wrote:
> > > Linus?  Do you have an opinion about this RFC/patch?
> > 
> > So my only real concern is that the comment approach has always been
> > the really traditional one, going back all the way to 'lint' days.
> > 
> > And you obviously cannot use a #define to create a comment, so this
> > whole keyword model will never be able to do that.
> > 
> > At the same time, all the modern tools we care about do seem to be
> > happy with it, either through the gcc attribute, the clang
> > [[clang:fallthrough]] or the (eventual) standard C [[fallthrough]]
> > model.
> 
> (adding Nick Desaulniers and clang-built-linux to cc's)

Thanks for adding us.

> As far as I can tell, clang 10 (and it took hours to compile
> and link the most current version here) does not support

Just a heads up in case you want to mess around with clang in the
future, I wrote a toolchain build script for ClangBuiltLinux to help
with the long compile times by cutting as much cruft as possible (and
it is self contained by default, won't install anything outside of the
repository).

https://github.com/ClangBuiltLinux/tc-build

The slimmest working configuration for testing what you did would probably
be from the following command:

./build-llvm.py --build-stage1-only --projects clang --targets X86

> 	-Wimplicit-fallthrough=3
> and using just -Wimplicit-fallthrough with clang 10 does not emit
> a fallthrough warning even with -Wextra and -Wimplicit-fallthrough
> using switch / case code blocks like:

Unfortunately, -Wimplicit-fallthrough does not work for C right now
(only C++), as pointed out by Nick on LLVM's bug tracker.

https://bugs.llvm.org/show_bug.cgi?id=39382

This patch resolves that while adding support for the attribute.

https://reviews.llvm.org/D64838

Your example properly works when that patch is applied and
-Wimplicit-fallthrough is added to the list of flags.

../lib/test_module.c:24:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
        case 2:
        ^
../lib/test_module.c:24:2: note: insert '__attribute__((fallthrough));' to silence this warning
        case 2:
        ^
        __attribute__((fallthrough)); 
../lib/test_module.c:24:2: note: insert 'break;' to avoid fall-through
        case 2:
        ^
        break; 

Hopefully it can get merged soon. I am sure Nathan or Nick can speak
to further progress on that.

> The __has_attribute use is at least clang compatible.
> https://releases.llvm.org/3.7.0/tools/clang/docs/LanguageExtensions.html
> even if it doesn't (seem to?) work.

I was trying to follow along with this thread through the web interface
and kind of got lost, how does it not work? If I apply your compiler
attributes patch with D64838, I see fallthrough get expanded to
__attribute__((__fallthrough__)) by the preprocessor.

> >  - we'd need to make -Wimplicit-fallthrough be dependent on the
> > compiler actually supporting the attribute, not just on supporting the
> > flag.
> 
> I believe that also needs work if ever clang works,
> 
> Makefile:KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough=3,)
> 
> this will have to be changed for clang as the =<val> isn't (yet?) supported.

GCC's documentation says that -Wimplicit-fallthrough is equivalent to
-Wimplicit-fallthrough=3 so it seems like just making that change would
be all that is needed to support Clang:

https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-fallthrough

Cheers,
Nathan
