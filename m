Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E305DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34462064A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJ/Cp9sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfFQQc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:32:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46303 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFQQc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:32:29 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so22455592iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyvlBZ9D/Zjk2MW/3VQHdWy6VMYt1yotnl1P/NZQLYw=;
        b=EJ/Cp9sFXyoWPLdx4T75q2KAVuLe6xIazZp50xTNkSvbp8Lz55BFAWfHHcfdafuJLs
         rlzMdiwYuGiot4wub+V48pZl2j6EaWZEUAPGnv1eowEzTFIfxowKcHGD2WhSXEPd3aJX
         k+rOD1WfnXUFECEDLjKKiLM/n6SgQ8XemLXAdZF7CeRJvGVkxwuaytocJcGMKDqTZjvu
         Rp10jnCmEfwE65wcMd3FVaQXFBQarjFZFkqWhKUbFJuDR4QXJbCetOuFahb5+xVGEJI5
         c3H+CYuwx5kdUNS04YSIWIKRkcCrolC/vwbXKKuzWcgbrPcC+cjdcYDeYQdPNqfcL9RQ
         VxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyvlBZ9D/Zjk2MW/3VQHdWy6VMYt1yotnl1P/NZQLYw=;
        b=ozTiiKJnKVuyDvnccrzZ5WdpPbMIO/sexi3XwCj3xoU6Spwr9z87rXmjEkOqBjYRpB
         1lQrDQAETSSAAteWaWK71Py6U6vWCv4hloy65FW41zvTv3qfiyo0ZBUrdDo1NWfReSNI
         BgwpUW1RmdixVcoLjS3z3/o5MjAhEbPGIJTUrFLdk5v/YEMHQGvf728ty5rrCqQoNknX
         J5KGz9bN3Aoc87Plp3TwIV0qzsjhjfphGIjpILwXzAvC6ArL4+MIT6WHgWuwwGBO6lNu
         kkqUDbpbvU++s13dX054uPy1n6NqKFm2yZxs/S9HobsMsAm31lQqxWAL384oQ7Vq06t7
         bmrw==
X-Gm-Message-State: APjAAAULZMbDX5t6tFOsYAUCbbrPcJg8bfDhgUr7qlF/XHhszObzF087
        lKeqLBd1adf1gWnQO1lcB4NjtG/G2Zwcnze2eDUTF512
X-Google-Smtp-Source: APXvYqx5u4mTUnavwavifEXCjDNol/Lgb4aYt5qFQmeAoCNvZzuBGMwtrlzB5E5q3/XAvaD2Tw3E0ByOs8hoi+G+mpQ=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr11263939iob.49.1560789148415;
 Mon, 17 Jun 2019 09:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190617104237.2082388-1-arnd@arndb.de> <20190617112652.GB30800@fuggles.cambridge.arm.com>
 <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com> <20190617161330.GD30800@fuggles.cambridge.arm.com>
In-Reply-To: <20190617161330.GD30800@fuggles.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Jun 2019 18:32:16 +0200
Message-ID: <CAKv+Gu9Fh3anh6-TeDWZ+pL7rs7EBWZqvLXASRNjicGu7k+WKw@mail.gmail.com>
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
To:     Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 at 18:13, Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Jun 17, 2019 at 02:21:46PM +0200, Arnd Bergmann wrote:
> > On Mon, Jun 17, 2019 at 1:26 PM Will Deacon <will.deacon@arm.com> wrote:
> > > On Mon, Jun 17, 2019 at 12:42:11PM +0200, Arnd Bergmann wrote:
> > > > genksyms does not understand __uint128_t, so we get a build failure
> > > > in the fpsimd module when it cannot export a symbol right:
> > >
> > > The fpsimd code is builtin, so which module is actually failing? My
> > > allmodconfig build succeeds, so I must be missing something.
> >
> > It happened for me on randconfig builds, you can find one such configuration
> > at https://pastebin.com/cU8iQ4ta now. I was building this with clang
> > rather than gcc, which may affect the issue, but I assumed not.
>
> Hmm, I've failed to reproduce the issue with that config and either GCC
> (7.1.1 and 8.3.0) or Clang (a flavour of 9.0.0 from a few months ago).
>
> > > > WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version generation failed, symbol will not be versioned.
> > > > /home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against `__crc_kernel_neon_begin' can not be used when making a shared object
> > > > arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation: unsupported relocation
> > > > arch/arm64/kernel/fpsimd.o:(".discard.addressable"+0x0): dangerous relocation: unsupported relocation
> > > > arch/arm64/kernel/fpsimd.o:(".discard.addressable"+0x8): dangerous relocation: unsupported relocation
> > > >
> > > > We could teach genksyms about the type, but it's easier to just
> > > > work around it by defining that type locally in a way that genksyms
> > > > understands.
> > > >
> > > > Fixes: 41040cf7c5f0 ("arm64/sve: Fix missing SVE/FPSIMD endianness conversions")
> > >
> > > I can't see which part of that patch causes the problem, so I'm a bit wary
> > > of the fix. We've been using __uint128_t for a while now, and I see there's
> > > one in the x86 kvm code as well, so it would be nice to understand what's
> > > happening here so that we can avoid running into it in future as well.
> >
> > The problem is only in files that export a symbol. This is also the
> > case in arch/x86/kernel/kvm.c, but it may be lucky because the
> > type only appears /after/ the last export in that file.
> >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  arch/arm64/kernel/fpsimd.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > > index 07f238ef47ae..2aba07cccf50 100644
> > > > --- a/arch/arm64/kernel/fpsimd.c
> > > > +++ b/arch/arm64/kernel/fpsimd.c
> > > > @@ -400,6 +400,9 @@ static int __init sve_sysctl_init(void) { return 0; }
> > > >  #define ZREG(sve_state, vq, n) ((char *)(sve_state) +                \
> > > >       (SVE_SIG_ZREG_OFFSET(vq, n) - SVE_SIG_REGS_OFFSET))
> > > >
> > > > +#ifdef __GENKSYMS__
> > > > +typedef __u64 __uint128_t[2];
> > > > +#endif
> > >
> > > I suspect I need to figure out what genksyms is doing, but I'm nervous
> > > about exposing this as an array type without understanding whether or
> > > not that has consequences for its operation.
> >
> > The entire point is genksyms is to ensure that types of exported symbols
> > are compatible. To do this, it has a limited parser for C source code that
> > understands the basic types (char, int, long, _Bool, etc) and how to
> > aggregate them into structs and function arguments. This process has
> > always been fragile, and it clearly breaks when it fails to understand a
> > particular type.
>
> Ok, but the patch that appears to cause this problem doesn't change the
> type of anything we're exporting. The symbol in your log is
> "kernel_neon_begin" which is:
>
>         void kernel_neon_begin(void);
>
> so I'm still fairly confused about the problem. In fact, even if I create
> a silly:
>
>         void will_kernel_neon_begin(__uint128_t);
>
> function, then somehow I see it being processed:
>
>         __crc_will_kernel_neon_begin = 0x5401d250;
>
> Is there some way that your passing '-w' to genksyms?
>

The problem is not about the types we're *exporting*. Genksyms just
gives up halfway through the file, as soon as it encounters something
it doesn't like, and any symbol that hasn't been encountered yet at
that point will not have a crc generated for it.
