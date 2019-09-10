Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6EBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFACF208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732950AbfIJNns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:43:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34109 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfIJNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:43:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so17062903qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 06:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6zPc+01Hqtj70FYQH87POktpG3lo+D/uPeGYtLeCvc=;
        b=qynhaLo1pqxhcQFzhoOgbhx9rpE0iYbUvUQqeuy+KWoVXuXBPkPyG1GW93MBlA5DGL
         eDy30KCgF2+K5xHl1UsiyKlon1l7V5rB6l15r1TC8pvuMSvy1KbkeI6eZVEVbAqQW+lS
         qSDjgD/mr05ddUjsgDzs4dkZSJaOS3//8kFcif0hYkXEKoe+e0fYJ6vpS5CdBpu88uAC
         wVIT9bFPj6g9qsjGFcy7OMFiL7p35Cl23KXFiwUFVJvWAemBXTtpc5VXSZaCVsYvfnrt
         KRzoE63GjHhS/rbJIqQQE92Xn7qT35qm9t3l4NEwRLJ6ZpSxCFeizPB2sQBrlegS3G4/
         C4eQ==
X-Gm-Message-State: APjAAAWbW/LNTKqAOo9SdVsnPtO8aDb5kh8S5y3DpVm5EM7/SRNTrrMR
        WZ09pdw0XE1uvBTEx5HnOimhmVSdDFjJ+HRmHxU=
X-Google-Smtp-Source: APXvYqx63W2KmaLnbZnwoNzPoM9AmlM0KI9/P88LEJJ6BbifXaOvNlmx+AWjiX8rS0YSdxh0Xc6uuOzmtj/wUOvmmm8=
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr8806139qkg.3.1568123026492;
 Tue, 10 Sep 2019 06:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190909202153.144970-1-arnd@arndb.de> <20190910074606.45k5m2pkztlpj4nj@willie-the-truck>
 <CAK8P3a0O8bVLgMzyc9bXb8joy6CZevP4CVn5eEwEPVqAOutDEw@mail.gmail.com> <20190910132415.4j2ygxhuanihvzhx@willie-the-truck>
In-Reply-To: <20190910132415.4j2ygxhuanihvzhx@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Sep 2019 15:43:29 +0200
Message-ID: <CAK8P3a3w6q7iUy2zYRhUqiWCR3o-L5s3BTYvXZMXb0zEa=Ydig@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix unreachable code issue with cmpxchg
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 3:24 PM Will Deacon <will@kernel.org> wrote:
> On Tue, Sep 10, 2019 at 10:04:24AM +0200, Arnd Bergmann wrote:
> > On Tue, Sep 10, 2019 at 9:46 AM Will Deacon <will@kernel.org> wrote:
> > - In theory, CONFIG_OPTIMIZE_INLINING is the right thing to do -- the compilers
> >   also make some particularly bad decisions around inlining when each inline
> >   turns into an __always_inline, as has been the case in Linux for a long time.
> >   I think in most cases, we get better object code with CONFIG_OPTIMIZE_INLINING
> >   and in the cases where this is worse, it may be better to fix the compiler.
> >   The new "asm_inline"  macro should also help with that.
>
> Sure, in theory, but it looks like there isn't a single arm64 compiler out
> there which gets it right.

I don't see anything architecture specific in here. When the option was
made generic instead of x86 specific, I fixed a ton of bugs that showed
up all over the place. If we don't want it on arm64, I'd suggest making
it a per-architecture opt-in instead of an opt-out.

> >
> >     | commit 4f81c5350b44bcc501ab6f8a089b16d064b4d2f6
> >     | Author: Jeff Dike <jdike@addtoit.com>
> >     | Date:   Mon Jul 7 13:36:56 2008 -0400
> >     |
> >     |     [UML] fix gcc ICEs and unresolved externs
> >     [...]
> >     |    This patch reintroduces unit-at-a-time for gcc >= 4.0,
> > bringing back the
> >     |    possibility of Uli's crash.  If that happens, we'll debug it.
> >
> >     it's still default-off and thus opt-in.
>
> This appears to be fixing an ICE, whereas the issue reported recently for
> arm64 gcc was silent miscompilation of atomics in some cases. Unfortunately,
> I can't seem to find the thread :/ Mark, you were on that one too, right?

Sorry, that reference was unclear, I meant the text for commit 3f9b5cc01856,
which in turn contains a citation of the earlier 4f81c5350b44bc commit.

> > - The inlining decisions of gcc and clang are already very different, and
> >    the bugs we are finding around that are much more common than
> >    the difference between CONFIG_OPTIMIZE_INLINING=y/n on a
> >    given compiler.
>
> Sorry, not sure that you're getting at here.
>
> Anyway, the second version of your patch looks fine, but I would still
> prefer to go the extra mile and disable CONFIG_OPTIMIZE_INLINING altogether
> given that I don't think it's a safe option to enable for us.

The point is that function inlining frequently causes all kinds of problems
when code was written in a way that is not entirely reproducible but
depends on the behavior of a particular implementation. I've fixed
lots of bugs based on any of these:

- gcc-4.0 and higher started ignoring 'inline' without
  __attribute__((always_inline)), so a workaround got applied
  in 2.6.26, and this turned into CONFIG_OPTIMIZE_INLINING=n
  later
- gcc -O2 makes different decisions compared to -Os and -O3,
  which is an endless source of "uninitialized variable" warnings
  and similar problems
- Some configuration options like KASAN grow the code to result
  in less inlining
- clang and gcc behave completely differently
- gcc is traditionally bad at guessing the size of inline assembly
  to make a good decision
- newer compilers tend to get better at identifying which functions
  benefit from inlining, which changes the balance

CONFIG_OPTIMIZE_INLINING clearly adds to that mess, but it's
not the worst part. The only real solution tends to be to write
portable and correct code rather than making assumptions
about compiler behavior.

    Arnd
