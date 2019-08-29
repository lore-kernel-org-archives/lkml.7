Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6F7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528A722CEA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfH2UWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:22:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41451 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfH2UWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:22:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id g17so4180089qkk.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 13:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIH6tsXstVG0i0l8PzAWx+GMnOxW2udp89Gezjs+3a4=;
        b=tSq4aIe5NCymQnL5VrFa7FXQFYHgA+xB8Qr3BmvNLsdwDPK2ZdftPs2xrV8XI6MvjU
         Y++tW5jUuQWydIqIqXC6/B6HRpCrYT9fEuxsciK31rejsZXyJ1pzakCS6ONrJkZIR0lU
         2lDOZU9ECDx7au+Zdy/cXlyAvC3HbfOyeg5A8WBNDxaQQusCeYa4n0ialG+11DeeRUM4
         SwKqAGZEm4x2hBFOE07i2roGZiRe66sgnF9PqGj+p0VCz2HpTlgCDtgmVpx4epWNDyvh
         bNqs0B2LD72Nyxd4O1vi2w8UJ7NveTjtJTJWY7MsOIOrJDcoN1wNqvum+ecVlE2oysvi
         oeSA==
X-Gm-Message-State: APjAAAXCpjHMM6phvmIFFWHZZrzh5+RBBWofXUVI+Ke3pfLo5GJrNdRX
        pDa8+qR0P5GqDQGDi326XQM9HlLz5SNHYJhiFtE=
X-Google-Smtp-Source: APXvYqzqXFX1AMuPK0cci9fNf4rc6J81XvXO9dqrG5q7s02Awnii9Z0vrin/pU+KnjwtBoomFZGVOjKQYA0lzgIyxoE=
X-Received: by 2002:a37:bd44:: with SMTP id n65mr11608757qkf.286.1567110120585;
 Thu, 29 Aug 2019 13:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble> <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
In-Reply-To: <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Aug 2019 22:21:44 +0200
Message-ID: <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 8:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Aug 29, 2019 at 10:35 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> So:
>
>  - we do want "memcpy()" to become "__builtin_memcpy()" which can then
> be optimized to either individual inlined assignments _or_ to an
> out-of-line call to memcpy().
>
>  - we do *not* want individual assignments to be randomly turned into
> memset/memcpy(), because of various different reasons (including
> function tracing, but also store tearing, yadda yadda)
>
> Conceptually, "-ffreestanding" is definitely what a kernel needs, but
> it has been *too* big of a hammer and disables real code generation,
> iirc.

I just tried passing just "-fno-builtin-memcpy -fno-builtin-memset".
This avoids going all the way to -ffreestanding and prevents the insertion
of unwanted memcpy and memset calls, but unfortunately (and
unsurprisingly) it also prevents the optimization of trivial memset calls.

On the other hand, I could not produce any trivial case like this without
CONFIG_KASAN, see https://godbolt.org/z/v440Qy

clang seems to behave similarly to gcc here, it will produce
calls to memset or memcpy when setting a lot of adjacent
members (17 for x86-clang, 29 for arm64 gcc), but not for two
or three of them. x86 gcc appears to always use string instructions
over memset().

Maybe we can just pass -fno-builtin-memcpy -fno-builtin-memset
for clang when CONFIG_KASAN is set and hope for the best?

        Arnd
