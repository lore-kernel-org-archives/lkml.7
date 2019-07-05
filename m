Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16943C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CFC20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFcRN8vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfGEI6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:58:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35002 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfGEI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:58:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so1774195ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAK+HQXm4zM3yGamuT9+AVKxhqMcm5jL9vd/N5ksk0c=;
        b=PFcRN8vqdRs1XHo8CJhFwUNk8C4nKxTRtfakN+VIAqiU13A5AmaFxUqKZ30/l/FwnL
         bKpcOoCPVKMFtc13bNUjJ9M8TsmeBQFJsN3OBOcjicVqRx4TdMzJU+OUqe0o5XlLjuXv
         kJ+aDUXLBozQJZ6wCB1IIbCgJ1BCcrzav/c85c72u00VCD0jrnoTSIBir2hi7Z9coK+P
         IiR1fSkMZyxu44Ry6JOMtA54Yxq1TGUeANIlWVS8qeC4BzzQoYHc2gIt0Ycj5sYeeQO1
         sVh9M8wX9ti5G5m4dJGGLlrsgLGqXw2aXsrZEbwm7XmLHzKi1RDu8XtRgDSd4hEWSXVK
         4Z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAK+HQXm4zM3yGamuT9+AVKxhqMcm5jL9vd/N5ksk0c=;
        b=lZTbmTYPqQ2HVA3Ut5ABww0/kYcEPtdwIDktd5yIlh+4nm5dhjhv9XHWkYeOpXg8LS
         IlSPdbzc5UMeoi6zCjOnrsBUcK8JKe7hRixGXzTjPFMkUZA+YLfPJkWDplKeLEpGETGv
         eccV9n8YkHRJ2MSuSCgTGf4meF/G6RchoCBBbwaHGLPQVBB3egye2IxKBpC0QwwLnlJb
         M51l+eSqXmk6g44O4VRMopzDbHehXiIPrHH1XS+K3Er8ipMjEqRxnhSa72BPZbrp1hVG
         3oeyGHIndUyir49l5fKe/Gd6rtQuDabDcXuARl/lO5+Xhv2aIJUcVUcUFqjo8nlPQm1u
         SnSw==
X-Gm-Message-State: APjAAAVliKIgXinGXZEwO10JVdyiBOUiVXyScZCljYSq1UQUcdsslzUq
        I47CeoY4qGOttIS5Wnqlz2iJCsLqZULK9PqMF04LAtKZ
X-Google-Smtp-Source: APXvYqzNMxvRsv1RC7618zL4v00ohASaVxdpPgJfg3fqsJFb0iBwJWWMqhbHh7stOpLPPgEyrZAElm3JpEKzhJ9IIAI=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr1562120ljm.180.1562317086652;
 Fri, 05 Jul 2019 01:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <tip-f3d705d506a2afa6c21c2c728783967e80863b31@git.kernel.org>
 <CACRpkdboWWKfaTu=TKqnZgjy4HNWr+fjmQXLBBmePsaDihkbSA@mail.gmail.com>
 <be57afd0-5a81-4d79-3ee4-1fb23644f424@arm.com> <CACRpkdbgyWmMM+3L6rjpWr4Z=qu4w6cri3cv0DG51JpFd9Ej4g@mail.gmail.com>
 <CAKv+Gu_=4P=caK4mFiAf+sqnKSZciCH0w8wUp19ef4xDVLH9-w@mail.gmail.com>
In-Reply-To: <CAKv+Gu_=4P=caK4mFiAf+sqnKSZciCH0w8wUp19ef4xDVLH9-w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Jul 2019 10:57:55 +0200
Message-ID: <CACRpkdZTkMzEBX5b8LCdxkSPoY2pTcTZWEPTHuS3WpX6a5=cnA@mail.gmail.com>
Subject: Re: [tip:irq/core] gpio: mb86s7x: Enable ACPI support
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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

On Thu, Jul 4, 2019 at 8:18 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On Thu, 4 Jul 2019 at 09:52, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Wed, Jul 3, 2019 at 3:50 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> > > On 03/07/2019 13:26, Linus Walleij wrote:
> > > > On Wed, Jul 3, 2019 at 11:24 AM tip-bot for Ard Biesheuvel
> > > > <tipbot@zytor.com> wrote:
> > > >
> > > >> Committer:  Marc Zyngier <marc.zyngier@arm.com>
> > > >> CommitDate: Wed, 29 May 2019 10:42:19 +0100
> > > >>
> > > >> gpio: mb86s7x: Enable ACPI support
> > > >>
> > > >> Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> > > >> support for ACPI GPIO interrupts routed via platform interrupts, by
> > > >> wiring the two together via the to_irq() gpiochip callback.
> > > >>
> > > >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > >
> > > > OK!
> > > >
> > > >> +#include "gpiolib.h"
> > > >> +
> > > >
> > > > But this isn't needed anymore, is it?
> > >
> > > You tell me! ;-)
> > >
> > > > I can try to remember to remove it later though.
> > >
> > > Yeah, please send a separate patch. tip is stable, and we can't roll
> > > this back.
> >
> > I'll just fix it in the GPIO tree after -rc1.
> > Made a personal TODO note!
>
> Why wouldn't it be needed anymore?

I looked over the code like 5 times and I can't see it touching any
gpiolib internals anymore, but maybe I'm still wrong?

Normally GPIO drivers should get all symbols it needs from
<linux/gpio/driver.h> and "gpiolib.h" is not something drivers
should include.

Anyways I will get to know from compile tests if I'm wrong.

Yours,
Linus Walleij
