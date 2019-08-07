Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC234C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830FB22BED
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdAfvsBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbfHGICU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:02:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36617 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfHGICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:02:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so39567123plt.3;
        Wed, 07 Aug 2019 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMYKAhYPKEnQGnxaciLVfbL2EBRQZTnzyusT+eGUFDI=;
        b=pdAfvsBn/elV6g9A15Ff3y6eAnCzod6jYljCYYDEU0KccWHWNZrZwVBLsc6im5TYsD
         DEmj70vyo+6P1zUcQzf9b864MBernbwKrNreqMHAGXiE/ZA26ETKe2jko7WKDC4BDgW7
         JlMk30prM3BAnGLvtsmnIbk3wCAW1fooMV+d1NjL7zcJr45i/5+dEuV87DQY8eyNec53
         axS8RBQbRJXpwiAfHDj45uCDxm11LtyZSuTASrinolNvZr5JrzQdenmmH2mrH7PLwCBc
         Zn48ffgwB+HhNlOy33c3p7dvYl+lUB1qtWVeQorhDg9YzVtQy9lplBviyYnNJVCwPhRZ
         YeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMYKAhYPKEnQGnxaciLVfbL2EBRQZTnzyusT+eGUFDI=;
        b=E75CkRebsYp/qe2y5MY8EFY6QYUjc7WkvgxzUxaB15r6IBEDqUQFYXasNGkmiXj+J6
         aqwb9kFGLbD7Ki/ZlnMBOgnVKhrLpFzLYp2ate6FCEbWrUo6L3aSbi+xmj6ThrNQExiB
         f9sUrpObuvyqqAb8IkF8L3azwy1gwJjmNnkb20jumaAzjZWSkyr55WHzmXuqXz+k3Cvt
         zr1gl3qqrm6gbnSipz/SWrFnyp7eULw+ysH8l8qzlyh0/NFj0sEipOkzQWndzZm4Lw6y
         dkpBtDX6HJeQFUq9ssJdHhku20HzTLEEgBnh1zhuZhPDbAO9eC+I08wtcKX6QDcQW/di
         cdog==
X-Gm-Message-State: APjAAAV88TGdBEcjsYbNHm6Vmm+62PGfv6A6BwQJA1snO9+piP/g+mL2
        OUBZcQJVjVKqsnIzpQxxyDGECvlVKw1RqZDt8FQ=
X-Google-Smtp-Source: APXvYqyqWK9u/CHw1zTdlV97mvyyYTDrtTSZKGdz+QwBWDIxQ7c5WIJ0MyjI3nPGVjchkLUEy7PdSgYhYZaRS/NGmmQ=
X-Received: by 2002:aa7:9713:: with SMTP id a19mr8060914pfg.64.1565164939482;
 Wed, 07 Aug 2019 01:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190805193243.18584-1-andrew.smirnov@gmail.com>
 <CAHp75VcjUwUj-6r+k2bTFhhr9hk942-ZEu=GhvhKNjfgEYf1Qw@mail.gmail.com> <CAHQ1cqEHNq9jJfKWKrZ1utbsk8HG4gywuaxNNMFOgFZGULwyEw@mail.gmail.com>
In-Reply-To: <CAHQ1cqEHNq9jJfKWKrZ1utbsk8HG4gywuaxNNMFOgFZGULwyEw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Aug 2019 11:02:07 +0300
Message-ID: <CAHp75VcZr1KmjnA-17sygzdO3P0-tMYNei8x-pH+Fp8oNjo8ww@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Introduce uart_tx_stoppped_or_empty()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Chris Healy <cphealy@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 4:20 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Mon, Aug 5, 2019 at 11:48 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 5, 2019 at 10:36 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> > > The vast majority of the serial drivers check for
> > >
> > >     uart_tx_stopped(&p->port) || uart_circ_empty(xmit)
> > >
> > > condition one or more times. Create a dedicated helper function and
> > > convert drivers to use it.
> >
> > Sometimes the arguments are swapped. It means that in case of first
> > being false the second is aslo going to be checked.
> > So, does ordering have any side effect?
> >
> > Please, elaborate this in the commit message.
> >
>
> Neither  uart_tx_stopped() nor uart_circ_empty() should have any side
> effects. I also didn't see any comments indicating that ordering is
> important. Is that enough of a justification?

The problem here is the word 'should' which implies the doubt.
Can you simple check this and elaborate in the commit message, like
"foo() checks X while bar() checks Y which are orthogonal to each
other and thus have no side effect on ordering"?

If it's not the case (for example, one of them does something under
lock, while the other is not, or barriers are in place) then we need
to keep ordering as in the original cases.

(Personally I believe there is no ordering issues, though I didn't
check this to be sure)

> > >  drivers/tty/serial/8250/8250_dma.c          |  2 +-
> > >  drivers/tty/serial/8250/8250_omap.c         |  7 +++----
> > >  drivers/tty/serial/sc16is7xx.c              |  2 +-
> >
> > For the drivers I care about (see above) I prefer to see conversion on
> > per driver basis. Of course, if Greg is okay with the current, I won't
> > object.
>
> I am more than happy to split this any way necessary.

Perhaps the best approach is to introduce a helper (patch 1) and do
few conversions as examples (patches 2-...), probably the ones that
reduce amount of lines.

> > > -               if (uart_tx_stopped(&up->port) ||
> > > -                   uart_circ_empty(&up->port.state->xmit)) {
> > > +               if (uart_tx_stopped_or_empty(&up->port)) {
> >
> > Yes, it becomes one line, but...
> >
> > > -       if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
> > > -           uart_circ_empty(&uap->port.state->xmit)) {
> > > +       if (!(dmacr & UART011_TXDMAE) ||
> > > +           uart_tx_stopped_or_empty(&uap->port)) {
> >
> > ...wouldn't be the case here as well? And perhaps in other places?
>
> Hmm, not sure I am reading this comment right. Are we talking purely
> about formatting here? If we are, yeah, I probably can make this into
> a single line.

Yes, it's about pure style (also consider in some cases it's better to
have ~83 character line than split).

> Not sure if there any other places like that,
> sirfsoc_uart.c perhaps?

Maybe, above is the fist of which my eye is stumbled.

-- 
With Best Regards,
Andy Shevchenko
