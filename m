Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F3C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF13421670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1UqVGLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfGISIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:08:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40511 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfGISID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:08:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so10498397pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VnM6ZlllgNz4Bft5zni4R6FgT6ay2Y8xF5/yfmghTI=;
        b=k1UqVGLrSihIVQimPXEKlmuN+hrCN4IyhUHR9Fc2BrtPuGA4K1lDaJve2L7nZWShFj
         pXTnSFcp7hOR/NjcVZ7hLGMwcvPLnFAyLMVICq26GwX74+CKkt6C8dlX2q2jKzysD4At
         0gr2QTrYD9Y4O3iMw0rCt1MKzEmlSX/0EYDYPw/Np9QBvIZDrbZ12jPl0HmmF0AoujtT
         QHEQrX3O7oO+p2Z+4g9aBgjpXj1iQlT3KufRJiEFxxJMs6SQddk/LOmdglmSJ8lqRrfL
         Rf+q0NLsh7OEwzPcohGlEdewMz5YSmsa9aS9425y8a3wmdmIDMEaG5je3VfVcCVvlnqI
         gTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VnM6ZlllgNz4Bft5zni4R6FgT6ay2Y8xF5/yfmghTI=;
        b=sp6yag6jwqwg/FykNZsS7tDRk8cmB/60xA4euwp2+WbPT/MEuo3OfhKmdYI8wWXuzv
         Xe/Tl8THfABNImF9TUPHX9hznpSh2oYXJp6HmWwwfpbU72SI6m/661ybc8BCeX6mKRfP
         P0p+iqL+QuEVBd5VDSrO9gTykfQnx/Px64rve3zKj8ZAFE46+7kmufzfpDjhX19TT7Jn
         tjauPNVq7f6Db0VAWbQIGLVQp9l8wxnJgNPL8ek7NLg9X+dMa0Xw2wuJAUn1ol1k3QpD
         Gtj/SJ4+vPf0dEZHA+16cj1uR1ipGSh384o3D6U1ca5ekTydRywEOx/bd7D/kVqwaY0C
         hPvQ==
X-Gm-Message-State: APjAAAV33TkHjGT76SUHNrtbdTt9HV3vH7cC7RV1OguUiZJ3REo1WolC
        9pokJ7bDzmZ/lQGAxC4Q57wR32Qx1bcmoZ6jhMxROm3v0vg=
X-Google-Smtp-Source: APXvYqx1ptPXEPdEdPRwy/Tqbw5gbLHRGF9Q/hr413p0p9p3VdirFiKOQZVLoQgffgDFpLTaNPPUt7eqGiZ9CWp98oA=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr33372838plq.223.1562695682401;
 Tue, 09 Jul 2019 11:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190708203049.3484750-1-arnd@arndb.de> <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
In-Reply-To: <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Jul 2019 11:07:51 -0700
Message-ID: <CAKwvOdnm6rd4pOJvRbAghLxfd2QL5VJ+ODiMyRh1ri3pmmz0yg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 1:41 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jul 8, 2019 at 10:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > llvm gets confused by inline asm with .rep directives,
>
> Are the LLVM developers aware of the bug?
> It seems like something we can work around but should
> eventually be fixed properly in LLVM, right?

Arnd filed the bug yesterday.  I looked at it; so someone working on
LLVM is aware of it.  The kernel is definitely exercising weak points
in our inline assembly support.

> > Link: https://bugs.llvm.org/show_bug.cgi?id=42539

> I guess this brings up the old question whether the compiler should
> be worked around or just considered immature, but as it happens this

Definitely a balancing act; we prioritize work based on what's
feasible to work around vs must be implemented.  A lot of my time is
going into validation of asm goto right now, but others are ramping up
on the integrated assembler (clang itself can be invoked as a
substitute for GNU AS; but there's not enough support to do `make
AS=clang` for the kernel just yet).
-- 
Thanks,
~Nick Desaulniers
