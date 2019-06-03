Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E35C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D84C26539
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcf8Kz3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfFCRac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:30:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32841 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfFCRac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:30:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id v29so5733875ljv.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87vmhbtFGypbRFP93z1soajD115x6/UE0lciB5UWxN4=;
        b=gcf8Kz3nDQ8H4R5OD/gfn3ipZVokaCSGZjWlkVHFuKzXAwq8UciIa15eIYFlZv2OfV
         QJbx74dOzrOeN/zbmnQK+eThQLmXVaqWc3TU8uQlLp/tUbUDoRc4b8nj0ggcshHj5RrS
         nbEdL7G6sM/MkovcGr9b9zDTrV6Fdwm0QbmR1bQsYVmtqBkB+oBAaImFuV55UyIGMpct
         5IE8HbUHzEpDMe/mrKdchXcHOHH1eGmwAKT2MjZ9BKEpEPvKFWk79HAZYi4DfV0W8/kQ
         Yllkrzr7noCCpo8Ot6alVxigtYls0uRQSiOq9/oyC0qZyKX6wVo59zSL37cn2ltPIaFK
         BlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87vmhbtFGypbRFP93z1soajD115x6/UE0lciB5UWxN4=;
        b=TbBft5q9DOOz5zi9C0blgGFZKQqRn47ZvFHuSpYsl6gcT4/oPa1GetldQ88gz/EhwV
         hy6BtdOQ4nyO342INdU9gT8pmbeT4VmwZVnqdFd9FTeTh+Wccu3xW1x3I3qDe3Dpxan9
         2b+x5XTifIT3FuXHWWYoGp6v9cEh6NuBWEe4rkqoUvfVaOqrHhV1M4A3+rh3diB/mwHQ
         kB5L5oF9GWOI0wZnXZwR4kAokgtGHXoswzYGQb+Llj3h+OOa7JqCD+g4TrsOfi2s9C0f
         R8DSNn27OViW9paQwdt/h346TYkTP25ZnhGiqPXJ1O1BqYGkNUApZ3kvHywS/Zk+bxz2
         conA==
X-Gm-Message-State: APjAAAXz6FnQPPUoYgN/z6mxs+CyM78sJVa1Xeeig5h1Y77J5kh2S9ZZ
        RVs55dxazF/7+ud9hoXiYj3TP9ZUv1BDDHywQnTTbw==
X-Google-Smtp-Source: APXvYqzg7eWJ/IwhrWvciMTZ7qEvC9ybwjiLgDg/gaY4C/HmzBeRvsjbwxgqJxnTRMgtB9olOpHCEdFsdPHPGoH9k+g=
X-Received: by 2002:a2e:5dc4:: with SMTP id v65mr7253755lje.138.1559583030373;
 Mon, 03 Jun 2019 10:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190529145322.20630-1-thierry.reding@gmail.com>
 <20190529145322.20630-2-thierry.reding@gmail.com> <CACRpkdb5vB6OwcAxtjsKLzHt9V27juEOEEDqqQczKT-3r+7X-g@mail.gmail.com>
 <20190603075324.GA27753@ulmo> <CACRpkda47EX981Dw=jLrU=PHn50+AQhJmpVRWJ9uJEQdcAsrTw@mail.gmail.com>
 <20190603121227.GB30132@ulmo>
In-Reply-To: <20190603121227.GB30132@ulmo>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Jun 2019 19:30:19 +0200
Message-ID: <CACRpkdaiZEqLWYGoVLYTzWEc-hX10kT4bXqx3bUynBDcyStLjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: Add support for hierarchical IRQ domains
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lina Iyer <ilina@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 2:12 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Jun 03, 2019 at 12:58:02PM +0200, Linus Walleij wrote:
> > On Mon, Jun 3, 2019 at 9:53 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > Me
> >
> > > > Please drop this. The default .to_irq() should be good for everyone.
> > > > Also patch 2/2 now contains a identical copy of the gpiolib
> > > > .to_irq() which I suspect you indended to drop, actually.
> > >
> > > It's not actually identical to the gpiolib implementation. There's still
> > > the conversion to the non-linear DT representation for GPIO specifiers
> > > from the linear GPIO number space, which is not taken care of by the
> > > gpiolib variant. That's precisely the point why this patch makes it
> > > possible to let the driver override things.
> >
> > OK something is off here, because the purpose of the irqdomain
> > is exactly to translate between different number spaces, so it should
> > not happen in the .to_irq() function at all.
> >
> > Irqdomain uses .map() in the old variant and .translate() in the
> > hierarchical variant to do this, so something is skewed.
> >
> > All .to_irq() should ever do is just call the irqdomain to do the
> > translation, no other logic (unless I am mistaken) so we should
> > be able to keep the simple .to_irq() logic inside gpiolib.
>
> Well, that's exactly the problem that I'm trying to solve. The problem
> is that .translate() translates from the DT number space to the GPIO or
> IRQ number space. However, since gpiochip_to_irq() now wants to call the
> irq_create_fwspec_mapping() interface, it must convert from the offset
> (in GPIO space) into the DT number space, which is what that function
> expects.

It sounds a lot like you want to use the irqdomain APIs for
something they were not made for.

The irqdomain in general remaps from hwirqs to Linux irqs.

The hierarchical irqdomain 1-to-1 remaps hwirqs on interrupt
controller A to hwirqs on interrupt controller B, then to Linux irqs.

The DT number space is not normally any concern of the
irqdomain, and is not normally used to shape up that.

But how to do it is another question. Maybe making it
possible to override .translate() is what we need to do,
as you say.

That way .translate() can account for weirdness in the DT,
get the real hwirq out and proceed to translate as usual.

And then in the end the irqdomain .translate() is indeed
used to fix up weird DTs.... well. Hm this one is strange. :)

Yours,
Linus Walleij
