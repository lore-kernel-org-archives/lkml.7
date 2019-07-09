Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC4EC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1882073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfGITfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:35:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45542 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfGITfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:35:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so16912414qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYkOxU56fFZbe/rXWQ61Eydypj6M58uv2TRFoFlJd+U=;
        b=f4aoozibe2xS4JQ0aXnjs7bkPvwurBw6e7Yinh67fJVviT/VAwtakWrEfQk0CqKAz1
         BoacAxRWHSqKaOz0TeY5lX1Njk+HQrF5lnrTB5Gsq50z70Caexfy6Thcq5qsfDJCwRF0
         GFb9sp381aW1wNlBKXY6UmDimf61x1DxzWiRp1QS0QBv8lNsTKu3n0L5OfCybQ6Iw1lQ
         G/elJgJO/1rQOVKcH4NagOOC8r+oFYSbDhPYQiLaK2qUs7+tbeqM5ssCaW1T6I3qd0gs
         V82ATU9kekCmgB16vp4oMdvbET+U0fNMlb/b6IffZ6Pt1EQfIZAsAm0DUjS5jZ3fKMKf
         KGSg==
X-Gm-Message-State: APjAAAWNQ0oLHnmgdF4U2f32aMJvSX18mTrhRh1GNkJDDI8nyJHxLjzq
        73yKKG7lten0R569BPNhertX7r7CY8cSGXgwJNs=
X-Google-Smtp-Source: APXvYqzIrfw3JIJHqKR6sAb8jF/wgeD0S6YuTEPHCsoMBdWLmV+cJpJI++7MjWLFIegbqP/XnIrhKu8WvMkL5wQ0lHY=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr19622232qkm.3.1562700951363;
 Tue, 09 Jul 2019 12:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190709183612.2693974-1-arnd@arndb.de> <CANpmjNNiygcPkXSFWGNZtOf6LC1Z_xjnim=4hH_KMDEZ9SodDg@mail.gmail.com>
In-Reply-To: <CANpmjNNiygcPkXSFWGNZtOf6LC1Z_xjnim=4hH_KMDEZ9SodDg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Jul 2019 21:35:34 +0200
Message-ID: <CAK8P3a1SQaEymLpvTaX0_YDsGcKt=ys6_KwceC7mpkFJzhpQ=g@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: fix kasan_check_read() compiler warning
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 8:46 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 9 Jul 2019 at 20:36, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The kasan_check_read() is marked 'inline', which usually includes
> > the 'always_inline' attribute. In some configuration, gcc decides that
> > it cannot inline this, causing a build failure:
> >
> > In file included from include/linux/compiler.h:257,
> >                  from arch/x86/include/asm/current.h:5,
> >                  from include/linux/sched.h:12,
> >                  from include/linux/ratelimit.h:6,
> >                  from fs/dcache.c:18:
> > include/linux/compiler.h: In function 'read_word_at_a_time':
> > include/linux/kasan-checks.h:31:20: error: inlining failed in call to always_inline 'kasan_check_read': function attribute mismatch
> >  static inline bool kasan_check_read(const volatile void *p, unsigned int size)
> >                     ^~~~~~~~~~~~~~~~
> > In file included from arch/x86/include/asm/current.h:5,
> >                  from include/linux/sched.h:12,
> >                  from include/linux/ratelimit.h:6,
> >                  from fs/dcache.c:18:
> > include/linux/compiler.h:280:2: note: called from here
> >   kasan_check_read(addr, 1);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > While I have no idea why it does this, but changing the call to the
> > internal __kasan_check_read() fixes the issue.
>
> Thanks, this was fixed more generally in v5:
> http://lkml.kernel.org/r/20190708170706.174189-1-elver@google.com

Ok, that looks like a better solution indeed. I tried something
similar at first but got it wrong.

      Arnd
