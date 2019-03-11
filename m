Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB52214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfCKVhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:37:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36322 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfCKVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:37:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id b3so334032qtj.3;
        Mon, 11 Mar 2019 14:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OE2aYycL7Gv4WG0PwdCG8G+PdgNWJSiiyLW27YU//Vg=;
        b=ZugH7MC7vzMyqKGojaCQmD7AKXX8mWHoo+KOgWWfIDOxpq4TsMWKm3ffGKV7jX3prM
         KZHg5DKRuHOAoC3BqN164ulZLf6tvYne+MUSwhHqQWJDr2Aow24xZtmSC5oWAXV4h6+L
         WxGEllJhFIah4OhptkzKgx9tT8+x2K1r7QZfod3VPTS2bGioAG4CGDN81t/3T9PNbd4N
         WKFGzTQYbALoZw9NhErSsYSKyE0S0Mxcrqo7pUwupXwl7HgHmtiFlcDCy/bRsAVJkIX1
         +017YzUurvkGbzd99thIr767VhcQUfjyWCmUzyoVS5Rx/W6x91LE+dAdDJdkl/As9x8l
         esdw==
X-Gm-Message-State: APjAAAVh3WyEw75JyWNMHGNXKKwqadCK2GjwtPqpOgZlHGN6jS5AWcyp
        Jl12xLlcV1H5Qab8ug62VSzdidOlk+R5iyREElw=
X-Google-Smtp-Source: APXvYqyQ2w+0tVp9ObKx7GziegLU2CjhMw+WODkxrU5qE4r6kEba8X6k8H1cAJnWbDdyK/UW1QQd5pLKhcA/mnPZvqY=
X-Received: by 2002:ac8:1b7a:: with SMTP id p55mr14190887qtk.319.1552340222778;
 Mon, 11 Mar 2019 14:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181215212304.19390-1-natechancellor@gmail.com>
 <CAK8P3a05QL855mx21R-Pr6c2WjhSoopdFk9z4HvKoeM19A5aSQ@mail.gmail.com> <CAKv+Gu8nWO_GCPF1e6viGTSi5c-C+HoXqFNU=9yboC47E-kAFg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8nWO_GCPF1e6viGTSi5c-C+HoXqFNU=9yboC47E-kAFg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 22:36:45 +0100
Message-ID: <CAK8P3a3NjTCgFd2dQ9KbHP8DpXf6s-ULfeU6acAYC4SDi+2qvw@mail.gmail.com>
Subject: Re: [PATCH] ARM: Ensure that NEON code always compiles with Clang
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Tri Vo <trong@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 5:49 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 11 Mar 2019 at 17:22, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Dec 15, 2018 at 10:24 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >  endif
> > > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > > index a6741a895189..4600b62d845f 100644
> > > --- a/arch/arm/lib/xor-neon.c
> > > +++ b/arch/arm/lib/xor-neon.c
> > > @@ -14,7 +14,7 @@
> > >  MODULE_LICENSE("GPL");
> > >
> > >  #ifndef __ARM_NEON__
> > > -#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
> > > +#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> > >  #endif
> > >
> >
> > I see this patch has made it in now, but I also see two other problems with the
> > same file that prevent it from working right with clang:
> >
> > - it triggers #warning This code requires at least version 4.6 of GCC
>
> What is currently the oldest GCC we support for ARM?

Linux overall requires gcc-4.6, so we could just as well drop this
check, good point.

       Arnd
