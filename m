Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E499C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F392082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWNPt7nW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392486AbfIFWfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:35:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40044 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbfIFWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:35:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so5500777pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKbU78VIf5fOOmTThNh7lnS5dfYeSWT/lSDm744SIO0=;
        b=vWNPt7nW+whwTncJgD7DAv5qzns5PXjrJEnFy/vqmovNhinfvyE/SH5Sd/MGDZxXNl
         rC9i5VKXWO6IddxM4bN6WXTx9k4N9y7aUpGAtcimFtT751y4pTMdUhuVM3IxTw9SlpLx
         TGgwQslOWb+aJsXmFClGfjc3q61vcXl2DRiTaaIeGSrBiS+cNm5vYfo+VQhSipjzvb1A
         fifni8LV3fnjQzfRjsqAGGui/tp6kOoGQfu1D6AESSMZOqAHJLEvkYL2LrS5ANl3t9IZ
         wawHHHnUJACFHvTxvTuMmD5/2iA8esBj9VfNrANC4AkBCd88eO/CfO1FwC+oGfHeq5sz
         mZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKbU78VIf5fOOmTThNh7lnS5dfYeSWT/lSDm744SIO0=;
        b=DMe5Er5aM0LmkvYEwo0Dh6gesDwkUTuSIrilGb1jQrxqraQgL//fZHfmlfIXSkSyHe
         gYXtOBm2YMqivpboj9CU0tYvSP3WCvlGnzwh9wJ3IjA4RfWJKC6RhbdreZ/Au/6QEY7T
         xlZHKbx2YMSjWqtDOe+dVfeFax27VZmI2ntsgON/PeQnNdvyE79873AyC8aV6ya0RO4U
         pM6z4ZO7pwkCvbVBtKUWEEHEsPOmKwyAUFWWAB21XhLViXjw2UbUkxpNbVBy8PpINh8e
         BMIIcLS2x4aOeErG391CviL7S1+n2JSsopr1Y/wpmy73pho1V5YfGDWCXAyaf52iyc3y
         +1tA==
X-Gm-Message-State: APjAAAUcwEpkeHiefqlX33fjWvw/E5pusuQ11l4T0h2z8E3wxsfRyKA4
        jebK2ADMLtTAqEW84wkr/UT+dVGSqW2e0BeJFkGZsQ==
X-Google-Smtp-Source: APXvYqy1KOd0YR9NMCuh6I8UzTGEr9wBlKskZml0bIGWIbFBLwh2qFC6HZ5xViGP8bv/yfFWjKhpMaq+HitRk9SP8RM=
X-Received: by 2002:a63:6193:: with SMTP id v141mr10207909pgb.263.1567809313806;
 Fri, 06 Sep 2019 15:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
 <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org>
 <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
 <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak>
 <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com> <20190906220347.GD9749@gate.crashing.org>
In-Reply-To: <20190906220347.GD9749@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Sep 2019 15:35:02 -0700
Message-ID: <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 3:03 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Sep 06, 2019 at 11:14:08AM -0700, Nick Desaulniers wrote:
> > Here's the case that I think is perfect:
> > https://developers.redhat.com/blog/2016/02/25/new-asm-flags-feature-for-x86-in-gcc-6/
> >
> > Specifically the feature test preprocessor define __GCC_ASM_FLAG_OUTPUTS__.
> >
> > See exactly how we handle it in the kernel:
> > - https://github.com/ClangBuiltLinux/linux/blob/0445971000375859008414f87e7c72fa0d809cf8/arch/x86/include/asm/asm.h#L112-L118
> > - https://github.com/ClangBuiltLinux/linux/blob/0445971000375859008414f87e7c72fa0d809cf8/arch/x86/include/asm/rmwcc.h#L14-L30
> >
> > Feature detection of the feature makes it trivial to detect when the
> > feature is supported, rather than brittle compiler version checks.
> > Had it been a GCC version check, it wouldn't work for clang out of the
> > box when clang added support for __GCC_ASM_FLAG_OUTPUTS__.  But since
> > we had the helpful __GCC_ASM_FLAG_OUTPUTS__, and wisely based our use
> > of the feature on that preprocessor define, the code ***just worked***
> > for compilers that didn't support the feature ***and*** compilers when
> > they did support the feature ***without changing any of the source
> > code*** being compiled.
>
> And if instead you tested whether the actual feature you need works as
> you need it to, it would even work fine if there was a bug we fixed that
> breaks things for the kernel.  Without needing a new compiler.

That assumes a feature is broken out of the gate and is putting the
cart before the horse.  If a feature is available, it should work.  If
you later find it to be unsatisfactory, sure go out of your way to add
ugly compiler-specific version checks or upgrade your minimally
supported toolchain; until then feature detection is much cleaner (see
again __GCC_ASM_FLAG_OUTPUTS__).

>
> Or as another example, if we added support for some other flags. (x86
> has only a few flags; many other archs have many more, and in some cases
> newer hardware actually has more flags than older).

I think compiler flags are orthogonal to GNU C extensions we're discussing here.

>
> With the "macro" scheme we would need to add new macros in all these
> cases.  And since those are target-specific macros, that quickly expands
> beyond reasonable bounds.

I don't think so.  Can you show me an example codebase that proves me wrong?

>
> If you want to know if you can do X in some environment, just try to do X.

That's a very autoconf centric viewpoint.  Why doesn't the kernel take
that approach for __GCC_ASM_FLAG_OUTPUTS__?  Why not repeatedly invoke
$CC to find if every compiler __attribute__ is supported?  Do you
think it's faster for the C preprocessor to check for a few #ifdefs,
or to repeatedly invoke $CC at build or compile time to detect new
features?
-- 
Thanks,
~Nick Desaulniers
