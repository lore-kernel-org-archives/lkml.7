Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCD2C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178A62064A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OratZNUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfGCBUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:20:38 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:32881 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:20:38 -0400
Received: by mail-pg1-f181.google.com with SMTP id m4so295404pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urKLpyPs+qKmJQRSn4nY/ri+HUCn/Tsi4t/dmFYcRT0=;
        b=OratZNUwxL044HPh468i9hQPweSr6b/xzZnT13Vl8Fa8hhsZCWJEYJvSJT3qKMhCdo
         1rew3nQ7+30olwQ31j5P1XpiaQ/q2DCyJGFry/w6SEsPRPWx6kPg6iifmRfeelLEBp2S
         DBJ7pPVURq9ighJQhRFqyk+ZZK/4szkLSrvTZs6+A4wYH5NqJZO68ch5OOM8kY8kWp7N
         +vBqqyaO4V4TpZW/91j2LS4CPH2293LJol2/0HF9uBfbNuGlW95Z7S+rS0Oh3I7IKgNy
         kwuuSdAZadBrSkUOgJaX26OmPuwQhjrk/q3KCXJpOpdXroUQnhkRU5W4J5Cq1H/XPINe
         Tw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urKLpyPs+qKmJQRSn4nY/ri+HUCn/Tsi4t/dmFYcRT0=;
        b=kyPV6bDw3LaekuO96aQ+bRH0rcsqAq7XfTD+IRKGtRtUi0oO6mRtbi9AXLilxJoHFW
         mzDLi2vhlgQ2YWbBPRd87ABeMs6Ee5P8Bj+Sx4JlZiYgTcOE40zNckDQfN0JLRg8mb6O
         3+4D/LvM0RzHn7vijePbVqLo37/7ZP3rYPhBTj3g1QSskzOf4khwy1GdyH6344pd9a/y
         KNrBcclekjmq0kjM7CG6s/RCX6Vvd5OP67ENfLgTgFNfSCGZrzdPP2gif1hYzzx1Scbg
         Bb3QQRPOPCx9RuY5BNcqFCIk61w3uWPp8VHNadOlRpHsVVKHMX+Bmnzvemzs3GbPPpHj
         APAw==
X-Gm-Message-State: APjAAAVh40qvkzv6SO3PifZ2tIvLu56wBA+7KgXSgZKU8ZxP3bPHefHe
        L1TWg1+r4e17KnFnXGp2feHcXXbxuupHpJCtmJJzU1BsYhTKlQ==
X-Google-Smtp-Source: APXvYqyGQDqM0MuXMme6vkiCcrJmmiL2Sa2JberNf3B8npxHgLRDZKGG8Q17e5PSGfAVUAY30c61qAkpqY4cazb1NSs=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr7952895pje.123.1562105353944;
 Tue, 02 Jul 2019 15:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
 <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jul 2019 15:09:02 -0700
Message-ID: <CAKwvOdn-=u1v8B1ni8QqiOXaimhc_tG6O=8kMb4c2vv62=D42g@mail.gmail.com>
Subject: Re: objtool warnings in prerelease clang-9
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>,
        Chandler Carruth <chandlerc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 2:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 2 Jul 2019, Nick Desaulniers wrote:
> > TL;DR
> > LLVM currently has a bug when unrolling loops containing asm goto and
> > we have a fix in hand.
> >
> > Conservatively, we can block loop unrolling when we see asm goto in a loop:
>
> Makes sense in order to make progress.

I have the conservative fix posted for review: https://reviews.llvm.org/D64101.
I've modified the test case there for what it should look like when we
can and do inline it:
https://gist.github.com/nickdesaulniers/7216f6e5a17c7064285190440cb88f1d
I feel like I'm pretty close to just fixing the block duplication in
unrolling outright and can probably have a working fix in the next day
or two.

> > This causes objtool to not find any issues in
> > arch/x86/kernel/cpu/mtrr/generic.o.  I don't observe any duplication
> > in the __jump_table section of the resulting .o file.  It also cuts
> > down the objtool warnings I observe in a defconfig (listed at the
> > beginning of the email) from 4 to 2. (platform-quirks.o predates asm
> > goto,
>
> It does not have asm goto inside :)

I think you're conflating arch/x86/kernel/cpu/mtrr/generic.o with
arch/x86/kernel/platform-quirks.o.

> platform-quirks.o:
>
>         if (x86_platform.set_legacy_features)
>   74:   4c 8b 1d 00 00 00 00    mov    0x0(%rip),%r11        # 7b <x86_early_init_platform_quirks+0x7b>
>   7b:   4d 85 db                test   %r11,%r11
>   7e:   0f 85 00 00 00 00       jne    84 <x86_early_init_platform_quirks+0x84>
>                 x86_platform.set_legacy_features();
> }
>   84:   c3                      retq
>
> That jne jumps to __x86_indirect_thunk_r11, aka. ratpoutine.

As an American with 100% French Canadian ancestry, I approve of the
term ratpoutine over retpoline.

> No idea why objtool thinks that the instruction at 0x84 is not
> reachable. Josh?


-- 
Thanks,
~Nick Desaulniers
