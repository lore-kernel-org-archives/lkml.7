Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1635FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1965206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfCEJDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:03:55 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45967 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCEJDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:03:55 -0500
Received: by mail-ua1-f68.google.com with SMTP id u1so7060525uae.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 01:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KWSQPdEAOEqKIAwJE+G/lhn/QeIrYHYHAUihUgH74c=;
        b=fvdtC+/22XgjgQfjAZWZTkAGv0Z9IjcYtmdtliV0F9LuMovA2sS3vE+pLMLR5Y+HaR
         LM6eWaUk4X6ZewiS7KRk5WpyG6KbN51AgxLQXLGdBcspqCLCtn5M8pMhXc/Neywgo3As
         C/7MCjq/kgBkhOgs7+2kBgF64g04i9RBKn1LrXpOV4dAy60Iio31DXdlLPRQys4/JVSs
         678+iP/49EMbyqmrZ7fseXQ/QI2yDC61hMrbXr/+Ru5WhoS8sDoVoJWECYcaX6dzhgWb
         jgBqOz9R34YgnF0VMopNtQSitkZZ0R2uRuR1HWhmbTNZIx8dHRrhx1Q8/+4lSzrzYYYs
         JYFw==
X-Gm-Message-State: APjAAAXv5bf/0x2chlCpkH/drZCtu7ohuFfJ5mHKHNEb9Hyg1vHp6llu
        VfOHfJBMhKSehVfyfsLKF1GBLz+g+wgtZD1dwOU=
X-Google-Smtp-Source: APXvYqzwCamDPX6FKuP0RpPlGgkIf9XDFbJ0k6R5hHOOCxicFvtU/F/3FWYuyo53l23ZY6yeMFVOOe5cb9X1gZ3aWAQ=
X-Received: by 2002:a67:8588:: with SMTP id h130mr572690vsd.11.1551776633545;
 Tue, 05 Mar 2019 01:03:53 -0800 (PST)
MIME-Version: 1.0
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com>
 <alpine.LNX.2.21.1903051154200.135@nippy.intranet> <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
 <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com> <alpine.LNX.2.21.1903051948290.147@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1903051948290.147@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Mar 2019 10:03:41 +0100
Message-ID: <CAMuHMdUEuYy24VuRnbRJOehHxAn0mmPw6LH7M9MWWi3-V5nVjA@mail.gmail.com>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Tue, Mar 5, 2019 at 9:58 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 5 Mar 2019, Geert Uytterhoeven wrote:
> > On Tue, Mar 5, 2019 at 3:58 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > On Tue, 5 Mar 2019, Finn Thain wrote:
> > > > Looks bogus to me.
> > > >
> > > > If you change memcpy to __builtin_memcpy, then we avoid the macro and the
> > > > warning changes to,
> > > >
> > > > ./include/linux/string.h:456:3: warning: '__builtin_memcpy' forming offset [7, 8] is out of the bounds [0, 6] [-Warray-bounds]
> > > >    __builtin_memcpy(dest, src, dest_len);
> > > >
> > > > The compiler has nothing to complain about here. dest is known to be
> > > > id->fr and dest_len is known to be sizeof(id->fr).
> > > >
> > > > The error message indicates that gcc has applied the bounds [0, 6] to dest
> > > > when in fact those are the bounds for src.
> > > >
> > >
> > > My mistake. GCC is right, it seems memcpy will read past the end of
> > > "5.0.0+".
> >
> > But only if the else branch is taken, which is not the case.
> >
>
> You and I know that, because we can see what values get passed to
> memcpy_and_pad(). But how is gcc to know that?

Gcc also sees (partly) what values get passed, else it would not give that
warning.

Still, should gcc give warnings based on branches that may or may not be
taken? I guess there are lots of cases in the kernel where this could lead
to false positives.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
