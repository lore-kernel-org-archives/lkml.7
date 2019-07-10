Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A10C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01FE20665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGJIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:33:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41204 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJIdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:33:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id v22so1232776qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 01:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvPTF3a8/fdtxlBIjNYrf4YZbuOxeSd33JZmNhvjGmk=;
        b=knrOWJbjSiwt46XW0NPf3qKelMUXrfI+FAaQasM6J8fDU0RljpNkxiMv8k2wHrAOSA
         NyTE/+pc2tqhevPwlpGvtYTzfjdCu3oAuvr1GR22C+nvgofirjOQXM02aOgIxfvnRo0V
         qwmQdfJ9ld4dS4gRaJkHkfMNUGtdThWXJwKIRro2IPPPmcbMTAoWWxUrf1uXJKtDwikO
         dfQqzePyLNlmwAa89TJrU36fRCMtwTadf8qVCPBDHXTq80ZCEYRPIkxY5tjiBYSSGUOo
         y6a0x+X2U4QhbVXVf2rxVXSJgsho98UGVUrgi82UiWt2F2BeKj2JcfjkibPu5s10xm5s
         sjUw==
X-Gm-Message-State: APjAAAXhM24e7gz9QM3WwRCxIBwOoL78kweXiOasuRPKJjeqMwmPlBzW
        ZeQ+56kY4iifkcblabfKB1mwwpMDmgwO+vEYt/0=
X-Google-Smtp-Source: APXvYqxWm5A70n0ozg7wKfRZOgg4AmBN8Ck25NGVCj8JwPJ6khfrPXouqBoRbIFkorgLi3JErvqBgs1mTp1bKUxmuVw=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr21567171qka.138.1562747628305;
 Wed, 10 Jul 2019 01:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190708203049.3484750-1-arnd@arndb.de> <CACRpkdY1JzUZKgmXbObb6hqFcLFygAj2NuMgPMj=8tCp9U2C1A@mail.gmail.com>
 <CAKwvOdnm6rd4pOJvRbAghLxfd2QL5VJ+ODiMyRh1ri3pmmz0yg@mail.gmail.com>
 <CAK8P3a2anB0hD5J0JfPpJ_Gjc=NjoNC4k9nJ=t9H5AOBbdnfqg@mail.gmail.com> <20190709222517.c3nn6fgrz2eost3s@shell.armlinux.org.uk>
In-Reply-To: <20190709222517.c3nn6fgrz2eost3s@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Jul 2019 10:33:31 +0200
Message-ID: <CAK8P3a3Sv1dfSC3W4_Hfj8TSKaiJKS+fW1woLeLhGw97jHgT6g@mail.gmail.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 12:25 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jul 09, 2019 at 08:40:51PM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 9, 2019 at 8:08 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > > On Tue, Jul 9, 2019 at 1:41 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > > I guess this brings up the old question whether the compiler should
> > > > be worked around or just considered immature, but as it happens this
> > >
> > > Definitely a balancing act; we prioritize work based on what's
> > > feasible to work around vs must be implemented.  A lot of my time is
> > > going into validation of asm goto right now, but others are ramping up
> > > on the integrated assembler (clang itself can be invoked as a
> > > substitute for GNU AS; but there's not enough support to do `make
> > > AS=clang` for the kernel just yet).
> >
> > Note that this bug is the same with both gas and AS=clang, which also
> > indicates that clang implemented the undocumented .rep directive
> > for compatibility.
> >
> > Overall I think we are at the point where building the kernel with clang-8
> > is mature enough that we should work around bugs like this where it is
> > easy enough rather than waiting for clang-9.
>
> While both assemblers seem to support both .rept and .rep, might it
> be an idea to check what the clang-8 situation is with .rept ?

Good idea. I tried this patch now:

--- a/arch/arm/include/asm/mtd-xip.h
+++ b/arch/arm/include/asm/mtd-xip.h
@@ -15,6 +15,6 @@
 #include <mach/mtd-xip.h>

 /* fill instruction prefetch */
-#define xip_iprefetch()        do { asm volatile (".rep 8; nop;
.endr"); } while (0)
+#define xip_iprefetch()        do { asm volatile (".rept 8; nop;
.endr"); } while (0)

 #endif /* __ARM_MTD_XIP_H__ */

Unfortunately that has no effect, clang treats them both the same way.

      Arnd
