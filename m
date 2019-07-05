Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEDDC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4030420989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cC3vcStQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfGERx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 13:53:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52359 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfGERx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 13:53:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so9984874wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKrn7NJ/yuO5P8NQh8suLObB71KcTMq7kM1FIw6E7Nw=;
        b=cC3vcStQETpWhXWzAhUNLY1eaYOSk9YIysUj1Djqjcnb3G0BljbEd30FM5m43neEF+
         zqsC12XaEL/Y2+b+C1Ad2nmZ5wqvAge27sUZf7NecIbk60qV3xyVwLnelPyn6JLahgA9
         lcNihAxRda9tvTkbCrg8dvpCpWA8uX4B/V7ETwA2D/tm7vZnl9/43baDeTFfmK2Rx/e0
         2zAzCR7m8RrfXi/yb9uNRuXYdFzj8aHhTJP1t5UWOUSkoElSL5mKb1mcO3RR1tjmerOP
         ckhDRjzpdIk8TICT3ookIaCG1+udzvoe262FIa9BP9AMEYsW4u5V9kC75Lp7vl8J0cYR
         vZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKrn7NJ/yuO5P8NQh8suLObB71KcTMq7kM1FIw6E7Nw=;
        b=DrGsUfSOOmswg3pk9dhGOi8iNOlTsm1rjFVJ07pD3/wdiUabgBt8TFf0ZvoYeym+gG
         KqzrMVykeg2Rm8vSV61mC2dTX3veu7lWnyOFcYHiqfAa8LKliiIzkKr3MgIpZd95s3Mx
         tXDkurgl8ybnCzOQ4HUAHgIABNOBw2uo+QzCeadfpLugu7pwS5UM9IXtP32vtfoU4xfI
         WFZVcdm1xF9xSXCqZTsgUKgM6AfzsX7GBCqtGX8fPRtOrHWBY8Dkzw/7QEz6hs9quCwT
         7gf6I3XsTIJUq3xA4LgzgYDsM2UTJQbkM6osD/wNExfruaaBAIkdHDVF93cwB1jKcfgx
         9eUA==
X-Gm-Message-State: APjAAAXmoQIkZkR/Ajx/cGcMacJYlk2nuKE9qZ8nd2Jg4s+yeCL15Q0J
        1nW1AR95CHw+Jx23sQxhPWMkfyrJPwBURP7WWVYyYA==
X-Google-Smtp-Source: APXvYqxwAYfnATNzFUJ0N7VQQjEFwIpmRpJ+VVRt/JsQO3D53mfQH7iQLrqEQIiKNSe7NMEwlms7IinwvccYMA3EI54=
X-Received: by 2002:a1c:b706:: with SMTP id h6mr4166562wmf.119.1562349205298;
 Fri, 05 Jul 2019 10:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <tip-f3d705d506a2afa6c21c2c728783967e80863b31@git.kernel.org>
 <CACRpkdboWWKfaTu=TKqnZgjy4HNWr+fjmQXLBBmePsaDihkbSA@mail.gmail.com>
 <be57afd0-5a81-4d79-3ee4-1fb23644f424@arm.com> <CACRpkdbgyWmMM+3L6rjpWr4Z=qu4w6cri3cv0DG51JpFd9Ej4g@mail.gmail.com>
 <CAKv+Gu_=4P=caK4mFiAf+sqnKSZciCH0w8wUp19ef4xDVLH9-w@mail.gmail.com> <CACRpkdZTkMzEBX5b8LCdxkSPoY2pTcTZWEPTHuS3WpX6a5=cnA@mail.gmail.com>
In-Reply-To: <CACRpkdZTkMzEBX5b8LCdxkSPoY2pTcTZWEPTHuS3WpX6a5=cnA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Jul 2019 19:53:14 +0200
Message-ID: <CAKv+Gu9cZamcgFgzQP7ZX27jYNnFJG8XDPy+RwsZB_zfWsGNAw@mail.gmail.com>
Subject: Re: [tip:irq/core] gpio: mb86s7x: Enable ACPI support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019 at 10:58, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Jul 4, 2019 at 8:18 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On Thu, 4 Jul 2019 at 09:52, Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Wed, Jul 3, 2019 at 3:50 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> > > > On 03/07/2019 13:26, Linus Walleij wrote:
> > > > > On Wed, Jul 3, 2019 at 11:24 AM tip-bot for Ard Biesheuvel
> > > > > <tipbot@zytor.com> wrote:
> > > > >
> > > > >> Committer:  Marc Zyngier <marc.zyngier@arm.com>
> > > > >> CommitDate: Wed, 29 May 2019 10:42:19 +0100
> > > > >>
> > > > >> gpio: mb86s7x: Enable ACPI support
> > > > >>
> > > > >> Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> > > > >> support for ACPI GPIO interrupts routed via platform interrupts, by
> > > > >> wiring the two together via the to_irq() gpiochip callback.
> > > > >>
> > > > >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > > >
> > > > > OK!
> > > > >
> > > > >> +#include "gpiolib.h"
> > > > >> +
> > > > >
> > > > > But this isn't needed anymore, is it?
> > > >
> > > > You tell me! ;-)
> > > >
> > > > > I can try to remember to remove it later though.
> > > >
> > > > Yeah, please send a separate patch. tip is stable, and we can't roll
> > > > this back.
> > >
> > > I'll just fix it in the GPIO tree after -rc1.
> > > Made a personal TODO note!
> >
> > Why wouldn't it be needed anymore?
>
> I looked over the code like 5 times and I can't see it touching any
> gpiolib internals anymore, but maybe I'm still wrong?
>
> Normally GPIO drivers should get all symbols it needs from
> <linux/gpio/driver.h> and "gpiolib.h" is not something drivers
> should include.
>
> Anyways I will get to know from compile tests if I'm wrong.
>

IIRC it had something to do with the ACPI helpers that this driver
calls directly.
