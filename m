Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B33AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A21E22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="hcnNUDAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfHTMq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:46:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33709 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTMq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:46:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id w18so4337723qki.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0S42M9S7qxJEzBtgNNJTLth6te4pKxacIfyHJwR3zU=;
        b=hcnNUDAKvArNbLoZYCBMUuQM1t2Pm3p5qDur7ME3SLn3eykhoxeogWMjnFGPN/9E2e
         l5uN4Erm1wuDy8jg755/LQ5zKVFvaoGvS95Idvcsu2F0bddZJ57OybE0k92z07JXjuSv
         hHkNj8EC6xX2zxDgd9AYI8rGsU9DDkrIu2fcJeohIJSDLqzyTfH7m4nV2vghGpum82J+
         ds9+l0aL2PAKSOhLJF5NUzOFK8qD0B/DGzwshUdJco9wvk0o24dUgCU2z+i2l72JJ612
         oLTE5a50SrMA/1x9FInmY8Ll/PcnsmYm/6ePcoChWlywhXdDBvg7bFkjB7kQ4xAmadwJ
         jTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0S42M9S7qxJEzBtgNNJTLth6te4pKxacIfyHJwR3zU=;
        b=Ye4w23UNGoZewcI/c0eIw7vchoPVAkPmFrSPkeDiuvxmjqNfcYXfPtvGzEOFfHGnVx
         BGw+SaOQRYQWRGC88g3wO+w24rcg3lv8BFlFyGk+nEAUx2S34jZPjsidaZfJMbyKl+Ws
         DNYd0n+O/8Pp3VGHOg7qYpHjVfhzALMVq62JNw5f6QHsKqemE62IR1D9lQ0P5NdsFfkg
         aPrvyw9oGb/ukro9KrMma/HpbT2+XDZj/TovrsLeFKLeHCFEEBbQC2/gfqh5qLyQ4kRb
         jmnzhDiFvcwzSRVxI77umzI3GS4mjzCZWrXCvEpu6jxjsaAQsdNDoLenj8kwdOCV6hjy
         RWdg==
X-Gm-Message-State: APjAAAXA2K7jybNH2pyIeQKo9nbY7zMokFWp4ca1+Ari8Nlz1U5DNJ1n
        P6lYNKDQcJu61/4Gy25+TotPiNBxjsup2qBi7oNHkA==
X-Google-Smtp-Source: APXvYqyPBYlqD/sF2jtAZF/ZNP1mDtud4D0Kz0SUr8Yv77n8BFtupSFZZqUKRxgec1Vj/1UyaflPq1JlUPkDZoxUwTQ=
X-Received: by 2002:a37:4a8d:: with SMTP id x135mr7008973qka.472.1566305217120;
 Tue, 20 Aug 2019 05:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190723130513.GA25290@kroah.com> <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com> <20190724153416.GA27117@kroah.com>
 <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
 <20190724155735.GC5571@kroah.com> <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de>
 <20190724161634.GB10454@kroah.com> <alpine.DEB.2.21.1907242153320.1791@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907242208590.1791@nanos.tec.linutronix.de>
 <20190725062447.GB5647@kroah.com> <CAHbf0-FenMwa6uMqpD_fJZLU3YKviOcMe_pBh8oWmUPoUYk_LA@mail.gmail.com>
 <CAHbf0-GpJY6SGz=9yXEh28vvBuHP-c_fKqP6u60Ag3et6FCPrg@mail.gmail.com>
 <alpine.DEB.2.21.1908191504570.2147@nanos.tec.linutronix.de>
 <CAHbf0-E9ye1a0uuU4p-bRJhgEpQhceo6X-qR8hoBWoiOHajh2A@mail.gmail.com> <alpine.DEB.2.21.1908191530560.2147@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908191530560.2147@nanos.tec.linutronix.de>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 20 Aug 2019 13:46:45 +0100
Message-ID: <CAHbf0-E5S+Pc4Q5gk-=sZfygMWyjkXBLxUg3TXm=+qwP8fES=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be reserved
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've updated the bug some more with more info

I can't replicate this on RHEL7 with GCC 4.8.5 or GCC 7.3.1

My GCC is as follows:

Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-pc-linux-gnu/9.2.0/lto-wrapper
Target: x86_64-pc-linux-gnu
Configured with:
/var/tmp/portage/sys-devel/gcc-9.2.0/work/gcc-9.2.0/configure
--host=x86_64-pc-linux-gnu --build=x86_64-pc-linux-gnu --prefix=/usr
--bindir=/usr/x86_64-pc-linux-gnu/gcc-bin/9.2.0
--includedir=/usr/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include
--datadir=/usr/share/gcc-data/x86_64-pc-linux-gnu/9.2.0
--mandir=/usr/share/gcc-data/x86_64-pc-linux-gnu/9.2.0/man
--infodir=/usr/share/gcc-data/x86_64-pc-linux-gnu/9.2.0/info
--with-gxx-include-dir=/usr/lib/gcc/x86_64-pc-linux-gnu/9.2.0/include/g++-v9
--with-python-dir=/share/gcc-data/x86_64-pc-linux-gnu/9.2.0/python
--enable-languages=c,c++,fortran --enable-obsolete --enable-secureplt
--disable-werror --with-system-zlib --enable-nls
--without-included-gettext --enable-checking=release
--with-bugurl=https://bugs.gentoo.org/ --with-pkgversion='Gentoo 9.2.0
p1' --disable-esp --enable-libstdcxx-time --enable-shared
--enable-threads=posix --enable-__cxa_atexit --enable-clocale=gnu
--enable-multilib --with-multilib-list=m32,m64 --disable-altivec
--disable-fixed-point --enable-targets=all --enable-libgomp
--disable-libmudflap --disable-libssp --disable-systemtap
--enable-vtable-verify --enable-lto --with-isl
--disable-isl-version-check --enable-default-pie --enable-default-ssp
Thread model: posix
gcc version 9.2.0 (Gentoo 9.2.0 p1)

Could this be related to the --enable-default-ssp or --enable-default-pie?

On Mon, 19 Aug 2019 at 14:31, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 19 Aug 2019, Mike Lothian wrote:
> >
> > I'm using GCC 9.2, binutils 2.32. I used to use the gold linker but
> > I've just switched back to using ld.bfd based on this discussion
> >
> > My .config can be found at:
> > https://raw.githubusercontent.com/FireBurn/KernelStuff/master/dot_config_tip
>
> Does this combo successfully build 5.2 or is this a general problem?
>
> Thanks,
>
>         tglx
