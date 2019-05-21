Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B90C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772A20851
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfHg9KXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfEUSD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:03:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35301 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:03:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id c15so11655621qkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kDWkGHshH7SIjjv0a0jvn7btoTP1C/ycawb8P/q+eYU=;
        b=bfHg9KXIbv6ZUzxyhXdQ7PvTDbMs0AHBj/gxSvUXIwpn5NjI4Hq9+NY3+YWN6tXI86
         e7qGTi4MlIUXCqyjvk3NF3W202oToF+h45pDqxEvUTvVFJzoRQVI3K97/75gbtxQvYJd
         feb4FXIdbbK6tNRj3v9jEqtOvuED9o+U/Wz3R1w2+uw/yY9IUzNG35RV3C2U4qm2fQz8
         f872RAveE0GDXGuCLtJOiTxc2e/c9gOr2QFdrCeUKGpT/Z1DwLlPp03hoQPUNRt98iLG
         b8e1PezCAMGCcmAadOaxQco/8V/ZmIXzVXw6yjFV3RlIcIlK0rFlLWIEE3a7zP+edhGI
         N8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kDWkGHshH7SIjjv0a0jvn7btoTP1C/ycawb8P/q+eYU=;
        b=ItOl15E//5nfPQqVYobR+8NJdTZutmqe8zV+Y1N7dyP2JBA+u8t/wLchAcU4ewaX0g
         dlRQCRXF4jRNBSKBoQl/lOy6xSZL23RWjHorF50C+XG2INYM7znd1kECATQpXD0ATI3f
         vrs2RIGFeRg4bqzOO0pObeRpTxaXZ2JhRek4WqnEnBUWaiSQiBnt9Ylfb54Sx3cyaZ1e
         KTgMUAPMCRkgGk92BH8T/FOvjsGJvw8eWh9cZdfMegkdspyeXZF4xRQgoFDRsQ1T98/D
         cr4a8ahuHcpWYdgQRnv9UmtCMLYrYZbJPQFeevFTIj8IwEMTPFjLmP5Q3N7iU15gW+As
         6Ywg==
X-Gm-Message-State: APjAAAVJL7u+RlhAVG2UnxuQ9iBgxhYwBxN/l3ezrEvHgvvHHSJH15DO
        /lC9qPbwAvvU+BUSqxgOIAo=
X-Google-Smtp-Source: APXvYqxcfesTR4lo3NfKr8pSJmnDHhCHwCuwiC9f4WvDin9LYPgrbF1lgfy4hkj9uvrRn0+RqVkiiA==
X-Received: by 2002:a37:4fca:: with SMTP id d193mr64466123qkb.298.1558461837811;
        Tue, 21 May 2019 11:03:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id w48sm2286736qtb.91.2019.05.21.11.03.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 11:03:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63509404A1; Tue, 21 May 2019 15:03:54 -0300 (-03)
Date:   Tue, 21 May 2019 15:03:54 -0300
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl when system kernel headers
 are ahead of the kernel
Message-ID: <20190521180354.GE26253@kernel.org>
References: <20190521030203.1447-1-vt@altlinux.org>
 <20190521132838.GB26253@kernel.org>
 <alpine.LRH.2.20.1905211632300.4243@Diego>
 <20190521151918.GD26253@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521151918.GD26253@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 21, 2019 at 12:19:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, May 21, 2019 at 04:34:47PM +0200, Michael Petlan escreveu:
> > On Tue, 21 May 2019, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, May 21, 2019 at 06:02:03AM +0300, Vitaly Chikunov escreveu:
> > > > When a host system has kernel headers that are newer than a compiling
> > > > kernel, mksyscalltbl fails with errors such as:

> > > >   <stdin>: In function 'main':
> > > >   <stdin>:271:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
> > > >   <stdin>:271:44: note: each undeclared identifier is reported only once for each function it appears in
> > > >   <stdin>:272:46: error: '__NR_pidfd_send_signal' undeclared (first use in this function)
> > > >   <stdin>:273:43: error: '__NR_io_uring_setup' undeclared (first use in this function)
> > > >   <stdin>:274:43: error: '__NR_io_uring_enter' undeclared (first use in this function)
> > > >   <stdin>:275:46: error: '__NR_io_uring_register' undeclared (first use in this function)
> > > >   tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: line 48: /tmp/create-table-xvUQdD: Permission denied

> > > > mksyscalltbl is compiled with default host includes, but run with

> > > It shouldn't :-\ So with this you're making it use the ones shipped in
> > > tools/include? Good, I'll test it, thanks!

> > I've hit the issue too, this patch fixes it for me.
> > Tested.

> Thanks, I'll add your Tested-by, appreciated.

Was this in a cross-build environment? Native? I'm asking because I test
this on several cross build environments, like on ubuntu 19.04 cross
building to aarch64:

perfbuilder@15e0b7c211c2:/git/perf$ grep PRETTY_NAME /etc/os-release 
PRETTY_NAME="Ubuntu 19.04"
perfbuilder@15e0b7c211c2:/git/perf$ aarch64-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=aarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/aarch64-linux-gnu/8/lto-wrapper
Target: aarch64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro 8.3.0-6ubuntu1' --with-bugurl=file:///usr/share/doc/gcc-8/README.Bugs --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr --with-gcc-major-version-only --program-suffix=-8 --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-libquadmath --disable-libquadmath-support --enable-plugin --enable-default-pie --with-system-zlib --disable-libphobos --enable-multiarch --enable-fix-cortex-a53-843419 --disable-werror --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=aarch64-linux-gnu --program-prefix=aarch64-linux-gnu- --includedir=/usr/aarch64-linux-gnu/include
Thread model: posix
gcc version 8.3.0 (Ubuntu/Linaro 8.3.0-6ubuntu1) 
perfbuilder@15e0b7c211c2:/git/perf$

I'm building it as:

$ make CORESIGHT=1 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- EXTRA_CFLAGS= -C /git/perf/tools/perf O=/tmp/build/perf

The end result is:

$ file /tmp/build/perf/perf
/tmp/build/perf/perf: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, BuildID[sha1]=5b4fd9f0f92cc331e43e6e4da9791c473524383d, for GNU/Linux 3.7.0, with debug_info, not stripped

I.e. it didn't fail the build, but in the end these new syscalls are not
there, while with your patch, they are:

perfbuilder@6e20056ed532:/git/perf$ tail /tmp/build/perf/arch/arm64/include/generated/asm/syscalls.c
	[292] = "io_pgetevents",
	[293] = "rseq",
	[294] = "kexec_file_load",
	[424] = "pidfd_send_signal",
	[425] = "io_uring_setup",
	[426] = "io_uring_enter",
	[427] = "io_uring_register",
	[428] = "syscalls",
#define SYSCALLTBL_ARM64_MAX_ID 428
};
perfbuilder@6e20056ed532:/git/perf$

perfbuilder@6e20056ed532:/git/perf$ strings /tmp/build/perf/perf | egrep '^(io_uring_|pidfd_|kexec_file)'
kexec_file_load
pidfd_send_signal
io_uring_setup
io_uring_enter
io_uring_register
perfbuilder@6e20056ed532:/git/perf$

Thanks, applied.

- Arnaldo
