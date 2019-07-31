Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBE3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08346208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyvdoXfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbfGaLaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:30:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43230 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfGaLaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so69246773wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 04:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zTEnAMJpLFl2O5ZKL+mviLfZdYls9BPxKl0HMK9PJaA=;
        b=vyvdoXfZro1GvjQ7G8+Gdzy3J4ViTCfqOpp2WML+hNrCG4ygR/klF3NjM98BAija3v
         ywlgWMjLThNgmsSu+bJjRsqbxnsMBMhsOAKGx/qXmTqSRyN2uKPiB3AxapmfIa5c8rCx
         ViZKTmkpq/BFsEoTrGCI6G3wkG217PlsaBbMgggiLjohBr98fYszo3IZN4+kwcxqx6sR
         Kh5jaI71D7t0bKIF0XHvtJI+UPOSwcu06buTj1AuKrnpORpxzlxh75NyalHhbwHRZqQx
         hAjauJ98AAy6kNyTvuZKoNncnJJnRI5rCtrZnieY1uBk7ctKZ//Ql35RvFOdsm9KNco7
         GpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zTEnAMJpLFl2O5ZKL+mviLfZdYls9BPxKl0HMK9PJaA=;
        b=Pz/J+5xRA299FVXGANnBtDQY48jyyvLWyeIqGa6qDA5TuNVAbBMASoNmXScGwFPmhW
         bmErkaCmHsB30MHNBLcKt3V+LhuKknToOT2jBYw2jceuqh2E9oa2lY2nPLwrNIQcBiyj
         NAuVx00Hu8BhyTQOcWOUP5fAMD5tzG3hK1Ea9TsfB1WIprKOft/N5ilY1NbIOBybuMNk
         Ulck0mIBZjYjttUq9qhqfvBwlIgrv3KMOn3bphM/wwcebC4VOySGrGy+rU5vzXyimTAo
         D3ls+TGTIsBrykq8tB6YrdoOWBMpCu83aPgv2t3rB8BE8NhOg+37jbgGgLs3zMzRi4s7
         SkaA==
X-Gm-Message-State: APjAAAW+RZ/DJ0Xa+5SMRw6nd46tvG0q/3ChjBwhtRxIdaDc8PCrrOry
        34+iiBU7dljHh5pNf1XHayqdb9f3iAeOzhRY1OinQ3Tjy8thqg==
X-Google-Smtp-Source: APXvYqwo5syeoeR/KKrT2X/7tPZszHD8GhWdS52Z5eK87mSBcBGSxOC18O3IfHxxqGfy59jLrfdzNSjb92ERkN3w69I=
X-Received: by 2002:a5d:528d:: with SMTP id c13mr50812855wrv.247.1564572631497;
 Wed, 31 Jul 2019 04:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <201907281218.F6D2C2DD@keescook> <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
 <201907281507.B3F11DD54@keescook> <CAG_fn=Us9wREo+9PG-jPCTXsNv-rencgYHowtwXahuYBgdDs4A@mail.gmail.com>
 <CAHk-=wgTM+cN7zyUZacGQDv3DuuoA4LORNPWgb1Y_Z1p4iedNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgTM+cN7zyUZacGQDv3DuuoA4LORNPWgb1Y_Z1p4iedNQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 31 Jul 2019 13:30:19 +0200
Message-ID: <CAG_fn=WzcGvS7=SpigawnPDQgY13nFiqhmjFPaOH8LeuoU7Fhw@mail.gmail.com>
Subject: Re: [GIT PULL] meminit fix for v5.3-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 9:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jul 30, 2019 at 6:53 AM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > I wonder how hard it should be to make a zero-filling GCC plugin?
> > I'm not a big fan of hacking GCC, but it shouldn't differ much from
> > the existing GCC plugins that initialize locals.
>
> The thing is, as long as it's a plugin, I don't think we can rely on
> it. The gcc people will rightly just laugh at us if we were to report
> a bug with some kernel plugin.
>
> So I'd like the zeroing of local variables to be a native compiler
> option, so that we can (_eventually_ - these things take a long time)
> just start saying "ok, we simply consider stack variables to be always
> initialized".
>
> > I've some stale data collected on an x86 QEMU instance.
> > For 0x00 stack initialization:
> >  - hackbench, netperf and parallel Linux build were virtually free
> > (slowdown within stdev)
> >  - for af_inet_loopback the slowdown was ~4%
> > For 0xAA stack initialization:
> >  - netperf and parallel Linux build were free
> >  - for hackbench the slowdown was ~1.5%
> >  - for af_inet_loopback the slowdown was ~7%
>
> So I would expect that we have some special cases where we end up
> having arrays (or big structures) on the stack that end up being
> critical, and where initializing them is clearly  abad idea.
>
> Then we can verify manually are very much initialized, and that we
> could then mark and say "this is uninitialized".
>
> So when a compiler has an option to initialize stack variables, it
> would probably _also_ be a very good idea for that compiler to then
> support a variable attribute that says "don't initialize _this_
> variable, I will do that manually".
FWIW Clang has __attribute((uninitialized)) already:
https://reviews.llvm.org/rL349442
I agree that making it in GCC is easier if initialization itself is
implemented as part of GCC.

> But if we in ten years had a kernel model where only allocations and
> variables that were _explicitly_ uninitialized, that would be lovely.
>
> Then you can grep for those and verify that "yes, this is safe".
>
> We've historically had the reverse model - things are uninitialized by
> default, and you have to explicitly initialize them. Turning that on
> its head is what I would like to do long-term.
>
> (For normal allocations that wouldn't be too bad: get rid of
> __GFP_ZERO and friends, and instead do __GFP_UNINITIALIZED).
There've been concerns about such flags easily going out of control
(my original proposal for heap initialization contained such a flag).
To some extent their spread can be prevented by build-time checks, but
a simple grep can be insufficient, as people will start creating
helper functions to allocate with __GFP_UNINITIALIZED.

> Again - I don't think we want a world where everything is
> force-initialized. There _are_ going to be situations where that just
> hurts too much. But if we get to a place where we are zero-initialized
> by default, and have to explicitly mark the unsafe things (and we'll
> have comments not just about how they get initialized, but also about
> why that particular thing is so performance-critical), that would be a
> good place to be.
>
> This, btw, is why I also think that the "initialize with poison" is
> pointless and wrong. Yes, it can find bugs, but it doesn't really help
> improve the general situation, and people see it as a debugging tool,
> not a "improve code quality and improve the life of kernel developers"
> tool.
This sure makes sense. If this policy is adopted kernel-wide, we won't
need any debugging tools for uninit variables, so it's natural to
initialize them to zero.
>                 Linus



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
