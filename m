Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B04CC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB20207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJbPaZd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634202AbfIYRcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:32:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33995 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634191AbfIYRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:31:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id k7so2213828pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9jMC9IG3snO17QWN/ztIxptE5ObHM9y3wrRE9rosy4=;
        b=tJbPaZd8No6mBXlk39pF1VnwAu+VU+36E+RQXXRob7D+tkC0JFCvg53yEFwVxhmUEF
         72Al+pifPLwC41lE4kODfF/ZLM6wSYuUju2VMmGnWDo6bcmUC3QmbCQgnAYDgHyedmTI
         7I7QHt8zkAUw3wIZ6rfolSCfy1Lkwenw90lBcIG9bclVeo8S1bDtL1m93U6IXeJiJKck
         jc5WOzLG0q4u5FguEubFJZjXfxcTVrVaFU2u3nJEXEWRR6U1rFvIZEJiEygm9DoEzYCq
         zCo6UgPplDK4KQ9Ald4Xk3/IXFQJXWCmIpUKwx0DTcx8X/YwLL1dmqLm3OE309n2NeLm
         +yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9jMC9IG3snO17QWN/ztIxptE5ObHM9y3wrRE9rosy4=;
        b=Wl/S22aj6yUZunbraJA3HSxP3m7wqgLRiWcVFcJ5/JAYpQ5VbDvSM6z/id8gDLVKh5
         GKyl5r3E5NIP8Wf41bfBTW9o/4SOr3Ea8h+eQKkJCe5rgMUs2DSCsbA4wBr+DMX+8lMs
         QUsbt1bRPiz9t0Y4iT8d7jtMI5LPgZ42279URNCwPi4Kfwle/3ZjZpeJH7M8spII14bG
         s5rVvKveMOM2EHtLyuft3NVpP8txT9gV/sjySOI7t5hF1wFWCghUMJar9b8Omdup/nZq
         Xu/xPbIbqVga/YQShTFFUfYUR+9gKzB3gMYTJS8FRUyZvHsaVndQuBKq9mnADsVL/7bt
         /9Dg==
X-Gm-Message-State: APjAAAXT0MO2R3v4Ph4ox48W2vWv3rzchuU02419E0ACaWUQXkL/L99N
        NOHVB79P1SfK2a5kCbfkG21N3+CjgFULdvFhiBQ7dyI5
X-Google-Smtp-Source: APXvYqyhIESqzzm+gg0yP7ezEx19FYcGL0tK4r8blzfA2HJBIuYhPZv3aVEEJ1ViytNwQYWogBOpkjL73cQ/l/t7hcE=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr10148671plo.223.1569432717179;
 Wed, 25 Sep 2019 10:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190925130926.50674-1-catalin.marinas@arm.com>
 <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com> <20190925170838.GK7042@arrakis.emea.arm.com>
In-Reply-To: <20190925170838.GK7042@arrakis.emea.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Sep 2019 10:31:45 -0700
Message-ID: <CAKwvOd=GcF0Tv2-h0LNMvCzx+tm5skKW1J7P=NTf8xYbmPiOPw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Allow disabling of the compat vDSO
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:08 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> This is just a temporary hiding of the issue, not a complete fix.

Yep.

> Vincenzo will do the fix later on.

Appreciated, I'm happy to help discuss, review, and test.

> > > - check whether COMPATCC is clang or not rather than CC_IS_CLANG, which
> > >   only checks the native compiler
> >
> > When cross compiling, IIUC CC_IS_CLANG is referring to CC which is the
> > cross compiler, which is different than HOSTCC which is the host
> > compiler.  HOSTCC is used mostly for things in scripts/ while CC is
> > used to compile a majority of the kernel in a cross compile.
>
> We need the third compiler here for the compat vDSO (at least with gcc),
> COMPATCC. I'm tempted to just drop the CONFIG_CROSS_COMPILE_COMPAT_VDSO
> altogether and only rely on a COMPATCC. This way we can add
> COMPATCC_IS_CLANG etc. in the Kconfig checks directly.

Oh, man, yeah 3 compilers in that case:
1. HOSTCC
2. CC
3. COMPATCC

>
> If clang can build both 32 and 64-bit with the same binary (just
> different options), we could maybe have COMPATCC default to CC and add a
> check on whether COMPATCC generates 32-bit binaries.

Cross compilation work differently between GCC and Clang from a
developers perspective. In GCC, at ./configure time you select which
architecture you'd like to cross compile for, and you get one binary
that targets one architecture.  You get a nice compiler that can do
mostly static dispatch at the cost of needing multiple binaries in
admittedly rare scenarios like the one we have here.  Clang defaults
to all backends enabled when invoking cmake (though there are options
to enable certain backends; Sony for instance enables only x86_64 for
their PS4 SDK (and thus I break their build frequently with my arm64
unit tests)).

Clang can do all of the above with one binary.  The codebase makes
heavy use of OOP+virtual dispatch to run ISA specific and general code
transformations (virtual dispatch is slower than static dispatch, but
relative to what the compiler is actually doing, I suspect the effects
are minimal. Folks are also heavily invested in researching
"devirtualization").  With one clang binary, I can do:

# implicitly uses the host's ISA, for me that's x86_64-linux-gnu
$ clang foo.c
$ clang -target aarch64-linux-gnu foo.c
$ clang -target arm-linux-gnueabi foo.c

Admittedly, it's not as simple for the kernel's case; the top level
Makefile sets some flags to support invoking Clang from a non-standard
location, and telling it where to find binutils because we can't
assemble the kernel with LLVM's substitute for GAS).
-- 
Thanks,
~Nick Desaulniers
