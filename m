Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DC2C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAACD20857
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfCaQ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:28:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36460 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbfCaQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:28:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so8128673qtn.3;
        Sun, 31 Mar 2019 09:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSXHQsG3KOPg9vd5T+GCmFoc7Xf14JcZz1oGhypQBKw=;
        b=FywmAgQKw8GKWCgfqRIOXVZiz+XCIScercJxXlt4V7CB/ckYPgspOvIZBnestkgAoZ
         tlQ7eLDopNYdD2G3QKldeEvAsOTVXjVyI2s64F4k66jMI5vUPDt0olqTnFTN8jnKVy66
         bi2eEg09BDzOBI5fD1LNSU6CgP/6ApsIl5BJy6XDbHsKWR94xBf/4sURAmJ/Rszqj+Cl
         8ZJrnv7J7y0cVaB1HqzeBiswcBrU5tb0PuEGecjS8Ljdx+c3z/06cyxJ5wDe72s5U5H1
         3FyTly8wXfx4Y02tsEHmRozyFLQRQ0l0nKd877n73gx//Eo9Tb+OBEzU3vPLmBG/4Xp+
         o2fA==
X-Gm-Message-State: APjAAAWGv29s3F0kbEr0MwXsrM6rHTiI4Ki8dw55BD/8AuVGXDlpLSmi
        AJQ0C5Itoq8vq15EICHRjOkPaUtT+JsTegKIfjM=
X-Google-Smtp-Source: APXvYqx9e26flj4/DTUwCkm0QQZHO1TUNf4JZ4/rpFLAqXfyYImpebNZG5l1ed+kmdDk9YVAA0+XVhAQPMiHPduAVUU=
X-Received: by 2002:ac8:3fbc:: with SMTP id d57mr47482205qtk.96.1554049715359;
 Sun, 31 Mar 2019 09:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190325143521.34928-1-arnd@arndb.de> <20190325144737.703921-1-arnd@arndb.de>
 <87y34vl6ji.fsf@concordia.ellerman.id.au>
In-Reply-To: <87y34vl6ji.fsf@concordia.ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Apr 2019 00:28:18 +0800
Message-ID: <CAK8P3a14of-jJA2q7rki3gHk6gwE-0TCkzHuXZ1+TkemopgfRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 5:47 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Arnd Bergmann <arnd@arndb.de> writes:
> > Add the io_uring and pidfd_send_signal system calls to all architectures.
> >
> > These system calls are designed to handle both native and compat tasks,
> > so all entries are the same across architectures, only arm-compat and
> > the generic tale still use an old format.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/alpha/kernel/syscalls/syscall.tbl      | 4 ++++
> >  arch/arm/tools/syscall.tbl                  | 4 ++++
> >  arch/arm64/include/asm/unistd.h             | 2 +-
> >  arch/arm64/include/asm/unistd32.h           | 8 ++++++++
> >  arch/ia64/kernel/syscalls/syscall.tbl       | 4 ++++
> >  arch/m68k/kernel/syscalls/syscall.tbl       | 4 ++++
> >  arch/microblaze/kernel/syscalls/syscall.tbl | 4 ++++
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   | 4 ++++
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   | 4 ++++
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   | 4 ++++
> >  arch/parisc/kernel/syscalls/syscall.tbl     | 4 ++++
> >  arch/powerpc/kernel/syscalls/syscall.tbl    | 4 ++++
>
> Have you done any testing?
>
> I'd rather not wire up syscalls that have never been tested at all on
> powerpc.

No, I have not. I did review the system calls carefully and added the first
patch to fix the bug on x86 compat mode before adding the same bug
on the other compat architectures though ;-)

Generally, my feeling is that adding system calls is not fundamentally
different from adding other ABIs, and we should really do it at
the same time across all architectures, rather than waiting for each
maintainer to get around to reviewing and testing the new calls
first. This is not a problem on powerpc, but a lot of other architectures
are less active, which is how we have always ended up with
different sets of system calls across architectures.

The problem here is that this makes it harder for the C library to
know when a system call is guaranteed to be available. glibc
still needs a feature test for newly added syscalls to see if they
are working (they might be backported to an older kernel, or
disabled), but whenever the minimum kernel version is increased,
it makes sense to drop those checks and assume non-optional
system calls will work if they were part of that minimum version.

In the future, I'd hope that any new system calls get added
right away on all architectures when they land (it was a bit
tricky this time, because I still did a bunch of reworks that
conflicted with the new calls). Bugs will happen of course, but
I think adding them sooner makes it more likely to catch those
bugs early on so we have a chance to fix them properly,
and need fewer arch specific workarounds (ideally none)
for system calls.

       Arnd
