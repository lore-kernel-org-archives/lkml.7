Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E85AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E76A20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfCYK1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:27:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39693 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfCYK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:27:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so9568465qte.6;
        Mon, 25 Mar 2019 03:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWk2E7FS2keWQ3mp16IWcnefUS4l+ZTi/r4nGIMgIAY=;
        b=ZJXBkeD7qmZfvxVk20Z8aG+OzhogiHXfAQrwcFXVKuBWL4XrgVOmPHbQ11dgDqFX6H
         7/JbvXTTHDSzORHOOU6a1AMumzhw0RNGtfR5i+bE8SYJQ0GQLokKu7HoHn1K2ogtfaNA
         qNRzoSiRXAI44DEKQnAFNBTKZ7R9pJeoeUIlvZEqEEeRcScKkRXlwne6GdzO0LF+oq7L
         KLcdsHRbw6sy3Lw4YMRy1Nd/HZ9AEGqTucNf7mXiSu88QIEIRdTAnkkjd/rdgUuKSHPx
         MZfhXTnIOXbHusfwcVnt7K1IW1atgc9t3mcAcf0sjS9Lx4nRSv6YgSbO8acc28vKuIHH
         T7AQ==
X-Gm-Message-State: APjAAAWWTUu6UESQArrmE2je253YXcf/X34UGJB7eKESM9OPx1a98AHH
        CGq/P/oSHiJCL43Y71p3/AkG5bsxpfJs1r/SNGDWhA==
X-Google-Smtp-Source: APXvYqyjyImGL1pGf/aDVmDwHNjft4SZK7XiOGetAykXBVPrR+YAK8JAm8dLkG811rLOdSD5qF9H6YdvL0SvSIQwzSg=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr19400309qve.149.1553509659744;
 Mon, 25 Mar 2019 03:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com> <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
In-Reply-To: <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Mar 2019 11:27:22 +0100
Message-ID: <CAK8P3a3SRYAHSoNfLb7_25O8kP6faN=Bg--QNOzaL9=wVn=ycw@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 2:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > I've added your patch to my randconfig test setup and will let you
> > know if I see anything noticeable. I'm currently testing clang-arm32,
> > clang-arm64 and gcc-x86.
>
> This is the only additional bug that has come up so far:
>
> `.exit.text' referenced in section `.alt.smp.init' of
> drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> `exit.text' of drivers/char/ipmi/ipmi_msghandler.o

FWIW, the message up there does not match the patch anyway,
that was an unrelated bug.

     Arnd
