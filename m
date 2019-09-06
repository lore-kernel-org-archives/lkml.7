Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F55C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA58120842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392091AbfIFWED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:04:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:58019 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390045AbfIFWED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:04:03 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x86M3mnb024175;
        Fri, 6 Sep 2019 17:03:48 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x86M3lnA024173;
        Fri, 6 Sep 2019 17:03:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 6 Sep 2019 17:03:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Message-ID: <20190906220347.GD9749@gate.crashing.org>
References: <20190830231527.22304-5-linux@rasmusvillemoes.dk> <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com> <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org> <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com> <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com> <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak> <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:14:08AM -0700, Nick Desaulniers wrote:
> Here's the case that I think is perfect:
> https://developers.redhat.com/blog/2016/02/25/new-asm-flags-feature-for-x86-in-gcc-6/
> 
> Specifically the feature test preprocessor define __GCC_ASM_FLAG_OUTPUTS__.
> 
> See exactly how we handle it in the kernel:
> - https://github.com/ClangBuiltLinux/linux/blob/0445971000375859008414f87e7c72fa0d809cf8/arch/x86/include/asm/asm.h#L112-L118
> - https://github.com/ClangBuiltLinux/linux/blob/0445971000375859008414f87e7c72fa0d809cf8/arch/x86/include/asm/rmwcc.h#L14-L30
> 
> Feature detection of the feature makes it trivial to detect when the
> feature is supported, rather than brittle compiler version checks.
> Had it been a GCC version check, it wouldn't work for clang out of the
> box when clang added support for __GCC_ASM_FLAG_OUTPUTS__.  But since
> we had the helpful __GCC_ASM_FLAG_OUTPUTS__, and wisely based our use
> of the feature on that preprocessor define, the code ***just worked***
> for compilers that didn't support the feature ***and*** compilers when
> they did support the feature ***without changing any of the source
> code*** being compiled.

And if instead you tested whether the actual feature you need works as
you need it to, it would even work fine if there was a bug we fixed that
breaks things for the kernel.  Without needing a new compiler.

Or as another example, if we added support for some other flags. (x86
has only a few flags; many other archs have many more, and in some cases
newer hardware actually has more flags than older).

With the "macro" scheme we would need to add new macros in all these
cases.  And since those are target-specific macros, that quickly expands
beyond reasonable bounds.

If you want to know if you can do X in some environment, just try to do X.


Segher
