Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AC8C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B340B206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669414;
	bh=l7X8ed7pz7Dl5bSOlEOD+bks12Iq8nGEwGkve1kdz+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eKnToe8ODP5kvFqMGFSqc+dgJAZC7q4JnB8k8Jp1G5WcL6kBubXq6eFtI9JYWA3hn
	 SzibeTUtmuuP6qKGqwKlXRAWIv8D/5r5ePYB6O15MKgFwqjRjZyjQWrFaHEcawyErv
	 vk59eZKLffsStM5vJwgt3hNcXdIGzioc3oTPoXlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfIPVaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:30:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45764 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIPVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:30:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so1316979ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCLA20gGKvQZwlis3MY7Pv1IHjNSw+BHwmOLksBRSKI=;
        b=UxzDmCVqMM5O4D7qCxnVJPyd5mVuuzaS828o4wDPtyAbmsWgp8MqcfFJhuy/ElL2F0
         26cb+ArVuU3TAP47x5x/xq81jlPd4d86Rt2SULijuG1gvUDgWpZi3vrO30KbsJODAImT
         DfLkGfSRwhyw53azG+nRe9A9l5c25X9d/J/FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCLA20gGKvQZwlis3MY7Pv1IHjNSw+BHwmOLksBRSKI=;
        b=M+E1o3QaZ47cJRTiIDp2lAieM89+5h+D925suvhCJ0Y2bzGVz6VTrcIyvf3DbJDhiT
         oMtZIw8Koryf0sCcz54Lvxq+6P46P7MIuwPh3Y+hl44U3Uwm1PXIjTjQ9HnBgjZPwG+F
         oIHAt7g9vOweUnEZNbGo/Vd7jQ7fmnFe4dkA6rQp7wNqT1mEerLo1SCza7zOrpXmSJ7G
         JZiN1hFerSgSs8w/xnwGHZInu/YAHWpK9ZZ67EggBah8RopV2h8pE38rn9XNarbN6g1g
         bGtdiHltFtNp7pOirWuCUhdXLjAlO3mlccHQIz6eIUxzeUL8V0wyzhSGAbhGoKm+vWa+
         nTWA==
X-Gm-Message-State: APjAAAXe6sCuWWhTwNiQID85Np4+U0u2etXfz/ArN3S4rfypV8aTPZQL
        5LTyvElv8JxDuD3NLbxkhBRAffP6X8U=
X-Google-Smtp-Source: APXvYqwkmgEjbtuQJHEDeFiTgTDB4kEwQD2qsM/TY66kMojYiCLn6C7h1V8vXrAWdAbNJp6lfIKvAA==
X-Received: by 2002:a2e:9006:: with SMTP id h6mr23286ljg.42.1568669410558;
        Mon, 16 Sep 2019 14:30:10 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i128sm17839lji.49.2019.09.16.14.30.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 14:30:09 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id c195so1114235lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:30:08 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr153361lfm.170.1568669408577;
 Mon, 16 Sep 2019 14:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190913072237.GA12381@zn.tnic> <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk> <20190913104232.GA4190@zn.tnic>
 <20190913163645.GC4190@zn.tnic> <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
 <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com> <CALCETrX8sR8ELEvUpdHug498dU6+MWSy_SagaRbuZZ9fkztmfw@mail.gmail.com>
In-Reply-To: <CALCETrX8sR8ELEvUpdHug498dU6+MWSy_SagaRbuZZ9fkztmfw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 14:29:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZJhU3c-djPcwCPyYh0y1YXKeyBuJZjq3CzW3v_YHgeg@mail.gmail.com>
Message-ID: <CAHk-=whZJhU3c-djPcwCPyYh0y1YXKeyBuJZjq3CzW3v_YHgeg@mail.gmail.com>
Subject: Re: [RFC] Improve memset
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <mail@rasmusvillemoes.dk>,
        x86-ml <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:41 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> After some experimentation, I think y'all are just doing it wrong.
> GCC is very clever about this as long as it's given the chance.  This
> test, for example, generates excellent code:
>
> #include <string.h>
>
> __THROW __nonnull ((1)) __attribute__((always_inline)) void
> *memset(void *s, int c, size_t n)
> {
>     asm volatile ("nop");
>     return s;
> }
>
> /* generates 'nop' */
> void zero(void *dest, size_t size)
> {
>     __builtin_memset(dest, 0, size);
> }

I think the point was that we'd like to get the default memset (for
when __builtin_memset() doesn't generate inline code) also inlined
into just "rep stosb", instead of that tail-call "jmp memset".

> So I'm thinking maybe compiler.h should actually do something like:
>
> #define memset __builtin_memset
>
> and we should have some appropriate magic so that the memset inline is
> exempt from the macro.

That "appropriate magic" is easy enough: make sure the memset inline
shows up before the macro definition.

However, gcc never actually inlines the memset() for me, always doing
that "jmp memset"

> FWIW, this obviously wrong code:
>
> __THROW __nonnull ((1)) __attribute__((always_inline)) void
> *memset(void *s, int c, size_t n)
> {
>     __builtin_memset(s, c, n);
>     return s;
> }
>
> generates 'jmp memset'.  It's not entirely clear to me exactly what's
> happening here.

I think calling memset() is always the default fallback for
__builtin_memset, and because it can't be recursiveyl inlined, it's
done as a call. Which is then turned into a tailcall because the
calling conventions match, thus the "jmp memset".

But as mentioned, the example you claim generates excellent code
doesn't actually inline memset() at all for me, and they are all doing
"jmp memset" except for the cases that get turned into direct stores.

Eg (removing the cfi annotations etc stuff):

        zero:
                movq    %rsi, %rdx
                xorl    %esi, %esi
                jmp     memset

rather than that "nop" showing up inside the zero function.

But I agree that when __builtin_memset() generates manual inline code,
it does the right thing, ie

        memset_a_bit:
                movl    $0, (%rdi)
                ret

is clearly the right thing to do. We knew that.

                  Linus
