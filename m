Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECB4C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A7520B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZFFq3ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFZFOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:14:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43272 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZFOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:14:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so1305779edr.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 22:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WXBlKcvrh55Jm6u44pgS7aWglycf0W6DqQgTbq7Fs6Y=;
        b=YZFFq3acGjyPiihbKpxE8wZw0lZfV+Gxqwlyjc7CO/BJ/fFzI0PZHno3M3N/9ZpB7J
         quvU6mMNOTzX+0H02jEGHRt1hObislZbvHCXBd44yLboeCtzcrnJPi+PgLLIQBzKeCI4
         41DWZLTTLfZCceF2NTEpxwzhXD2FnIpoZEB9hj5TtwpR3yjHZDyQYfFFrpOQDA2zVT1o
         00Kt8dd4Srye2Sha+9ceN+Zg2IzV6JC7KqI+EeVC/YAxotdeOYkNKmAb1et5Gn/bu1p0
         4/Ag1XhNsDSX26VyC/KCBGDD9aal4PpwvZK+btFfBVFqD8BjUSY+nxRYD8ya+k1i5EhY
         tLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXBlKcvrh55Jm6u44pgS7aWglycf0W6DqQgTbq7Fs6Y=;
        b=gHISJb5AG01Gs273u6f+1dL6wKykyHQXbq68ENeAnyGtitC7FSrRrsurJNM4Tv5rJ9
         bO0HNrsx88JekQq5utfnjAkW47cypAS4qkc+VHLxtm7GcrDROM7dQIBJiKTAt90jnrTr
         sO2fpY0ysGLDKcJRW3+EKQd+FjPbQH5FpzA0GF/4mBGwXun5JTgNQ0zPIw0o4q8P74Uj
         2hTTiZrF6JFVvgMXG5WZfG3/5fftyGZba4ff34cvNxd/M8IKg6md6DEZrjMiDW3EOFPg
         EKfPtGYQ+sl/RjgZBB66vXhLt62mAjLQJwmFCclPVgz0RZCIecnyaR5JuKKQRAFcpTsg
         PHSw==
X-Gm-Message-State: APjAAAXvSGq5/AyJN3dRurO7Uya3l56vGNp8Z9t4SUtiI6XHc1L0HioW
        SvNNAixr5M12wE8pSNkYeAvZCaq1oYM1mA==
X-Google-Smtp-Source: APXvYqz4D8TbYxxzXijx/+f24+Feee015KxpdHwx4lt8h2cndtu1j8DQmiKZwd/Vew4jrhyhyf9hAQ==
X-Received: by 2002:a17:906:70e:: with SMTP id y14mr2140149ejb.276.1561526052073;
        Tue, 25 Jun 2019 22:14:12 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id a8sm5197832edt.56.2019.06.25.22.14.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 22:14:11 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:14:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626051409.GB114229@archlinux-epyc>
References: <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net>
 <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <20190625234626.GC20820@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625234626.GC20820@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 08:46:26PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 25, 2019 at 01:27:46PM -0700, Nathan Chancellor escreveu:
> > On Tue, Jun 25, 2019 at 09:53:09PM +0200, Thomas Gleixner wrote:
> > > On Tue, 25 Jun 2019, Nathan Chancellor wrote:
> > > > On Tue, Jun 25, 2019 at 10:12:42AM -0700, Kees Cook wrote:
> > > > > On Tue, Jun 25, 2019 at 09:18:46AM +0200, Peter Zijlstra wrote:
> > > > > > Can it build a kernel without patches yet? That is, why should I care
> > > > > > what LLVM does?
> > > > > 
> > > > > Yes. LLVM trunk builds and boots x86 now. As for distro availability,
> > > > > AIUI, the asm-goto feature missed the 9.0 LLVM branch point, so it'll
> > > > > appear in the following release.
> > > > > 
> > > > > -- 
> > > > > Kees Cook
> > > > 
> > > > I don't think that's right. LLVM 9 hasn't been branched yet so it should
> > > > make it in.
> > > > 
> > > > http://lists.llvm.org/pipermail/llvm-dev/2019-June/133155.html
> > > > 
> > > > If anyone wants to play around with it before then, we wrote a
> > > > self-contained script that will build an LLVM toolchain suitable for
> > > > kernel development:
> > > > 
> > > > https://github.com/ClangBuiltLinux/tc-build
> > > 
> > > Useful!
> > > 
> > > But can the script please check for a minimal clang version required to
> > > build that thing.
> > > 
> > > The default clang-3.8 which is installed on Debian stretch explodes. The
> > > 6.0 variant from backports works as advertised.
> > > 
> > 
> > Hmmm interesting, I test a lot of different distros using Docker
> > containers to make sure the script works universally and that includes
> > Debian stretch, which is the stress tester because all of the packages
> > are older.
> 
> Interesting, I've been building tools/perf, tools/{lib,arch/include},
> etc with lots of clang versions for quite a while, all in containers,
> using podman:
> 

Huh, interesting, I'm going to have to check that out (first time I have
heard of podman).

If anyone cares to see it, here is my little crude script:

https://github.com/nathanchance/scripts/blob/d8cfcc05fc50453503d48e32767f24dfac82dcd4/funcs/cbl#L693-L776

Cheers,
Nathan

> ----------------------------
> The first ones are container based builds of tools/perf with and without libelf
> support.  Where clang is available, it is also used to build perf with/without
> libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
> when clang and its devel libraries are installed.
> 
> Several are cross builds, the ones with -x-ARCH and the android one, and those
> may not have all the features built, due to lack of multi-arch devel packages,
> available and being used so far on just a few, like
> debian:experimental-x-{arm64,mipsel}.
> 
>   $ export PERF_TARBALL=http://192.168.124.1/perf/perf-5.2.0-rc4.tar.xz
>   $ dm
>    1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
>    2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
>    3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
>    4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>    7 alpine:edge                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 7.0.1 (tags/RELEASE_701/final) (based on LLVM 7.0.1)
>    8 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
>    9 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
>   10 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   11 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   12 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
>   13 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
>   14 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36)
>   15 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.1.1 20190611 gcc-9-branch@272162
>   16 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
>   17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
>   18 debian:experimental           : Ok   gcc (Debian 8.3.0-7) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
>   19 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
>   20 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
>   21 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-7) 8.3.0
>   22 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-7) 8.3.0
>   23 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
>   24 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
>   25 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
>   26 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
>   27 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
>   28 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
>   29 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
>   30 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
>   31 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
>   32 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
>   33 fedora:30                     : Ok   gcc (GCC) 9.1.1 20190503 (Red Hat 9.1.1-1), clang version 8.0.0 (Fedora 8.0.0-1.fc30)
>   34 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
>   35 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
>   36 fedora:31                     : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
>   37 fedora:rawhide                : Ok   gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2), clang version 8.0.0 (Fedora 8.0.0-3.fc31)
>   38 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
>   39 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
>   40 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
>   41 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
>   42 manjaro:latest                : Ok   gcc (GCC) 8.3.0, clang version 8.0.0 (tags/RELEASE_800/final)
>    1 openmandriva:cooker           : Ok   gcc (GCC) 9.1.0 20190503 (OpenMandriva)
>   43 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
>   44 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
>   45 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
>   46 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.1.1 20190520 [gcc-9-branch revision 271396], clang version 7.0.1 (tags/RELEASE_701/final 349238)
>   47 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
>   48 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-36.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
>   49 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
>   50 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
>   51 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
>   52 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   53 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   54 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   55 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   56 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   57 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   58 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
>   59 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
>   60 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
>   61 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
>   62 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
>   63 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
>   64 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
>   65 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
>   66 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
>   67 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
>   68 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
>   69 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
>   70 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
>   71 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
>   72 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
>   73 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
>   $
> 
> - Arnaldo
