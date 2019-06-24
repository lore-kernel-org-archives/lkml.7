Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E8C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C305720674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwlK2G28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFXWYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:24:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39099 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFXWYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:24:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so14162394ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RJ/2kCUFqt0p/B8wH1ducrJXpRHD9Vd6UXD6eBdK5zo=;
        b=vwlK2G28iGSTX/mLKanEVw9OvnDhLwi6UXaP2hX51CLLI0HSzYdn77mn/RmqiYl6mW
         CXVNWQJq2Y6m4JNAPCnzwC3jx+ABB3bEJfd7Ex6+90WTQgrgfpXS5uArKoPYzrlBPLWn
         TBar6NvVfyTlkAgiAbggVAo8Sqml0eNQXCnpKZikmrZOsoiI1FEDqj7DgA0/8KWHu936
         bihW3r9kMySDEs+cslLHX8Lntkgwcqp95tdQOtVjGMRE8+NWpeledtFLbGtFhVrofDiV
         J6FvSKMD0R8uaXGt9tQHU6k2X9umBkLZdaxYAzPSlBGijZQFe/caAq9vnri98wA2nV2Q
         6l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RJ/2kCUFqt0p/B8wH1ducrJXpRHD9Vd6UXD6eBdK5zo=;
        b=PqS49AtnNctUlXg5JFfYwi4CvykdjVoRwoq1+mUG7Tk+E9VQln/OhR8XvrJKGBkeug
         Bb7iq/5M2XM8vgkrnGtl7TMP4FbsJGZZoLCMSi4L+stkizquBV3AZwPF7F1lhiCB99KO
         RQ1LCprD1Uickzdfs/ZKAjrMgnDkbQURmMMiXk06Hrijzje3OoiJfiMsBf2dMsAN+X+n
         XCEqcKSlny2JLzKgDjrFJsBlusopEWRWwW9o/r611V+3vX8kXM5Np4JW/Z5sB0LO9Dgh
         2h1aPhNlre+BP2KgNXocyyrpAmm5L2HQ199uQO7bx4VY5oKvT7YtPwgz69iwzl0d0t6m
         y8tQ==
X-Gm-Message-State: APjAAAVdMkB+nR2R8cxKwTXt1n8Q84l3YpY0ONyJMUEQ1wtwCmnoHa/N
        ioWiRoQXSgcyNTTxh8p5PV3SSzJ4lv4tIc+oycKX5Q==
X-Google-Smtp-Source: APXvYqyj9SWN55Ra6slAJalJXB9mI/2jhCNU0xMT8hU+a2Rt1JjRex0Jx9/li/PopExkS9619juMJUl218+p6e5/e70=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr6893176ljm.180.1561415085502;
 Mon, 24 Jun 2019 15:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190530183941epcas5p4688d5fa80df649e4184a296ea78e6256@epcas5p4.samsung.com>
 <20190530183932.4132-1-linus.walleij@linaro.org> <28b92b86-19ac-0bf3-57d8-c7ab4557a45b@samsung.com>
 <CACRpkdaCaZyzfr9=QRz6uRZpK6mw_zDeVmBwgH7=FPbNGKB9tQ@mail.gmail.com> <547eacd4-e4b9-e9a9-9f89-aa33b05cb674@samsung.com>
In-Reply-To: <547eacd4-e4b9-e9a9-9f89-aa33b05cb674@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 00:24:33 +0200
Message-ID: <CACRpkdaiXcuygPfN-D848zTzs4+d5euquFKO3njHPhWvf_dasw@mail.gmail.com>
Subject: Re: [PATCH] extcon: gpio: Request reasonable interrupts
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 2:08 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> On 19. 6. 8. =EC=98=A4=EC=A0=84 6:24, Linus Walleij wrote:
> > On Tue, Jun 4, 2019 at 3:30 AM Chanwoo Choi <cw00.choi@samsung.com> wro=
te:
> >> On 19. 5. 31. =EC=98=A4=EC=A0=84 3:39, Linus Walleij wrote:
> >
> >>> +     /*
> >>> +      * It is unlikely that this is an acknowledged interrupt that g=
oes
> >>> +      * away after handling, what we are looking for are falling edg=
es
> >>> +      * if the signal is active low, and rising edges if the signal =
is
> >>> +      * active high.
> >>> +      */
> >>> +     if (gpiod_is_active_low(data->gpiod))
> >>> +             irq_flags =3D IRQF_TRIGGER_FALLING;
> >>
> >> If gpiod_is_active_low(data->gpiod) is true, irq_flags might be
> >> IRQF_TRIGGER_LOW instead of IRQF_TRIGGER_FALLING. How can we sure
> >> that irq_flags is always IRQF_TRIGGER_FALLING?
> >
> > OK correct me if I'm wrong, but this is an external connector and
> > the GPIO goes low/high when the connector is physically inserted.
> > If it was level trigged, it would lock up the CPU with interrupts until
> > it was unplugged again, since there is no way to acknowledge a
> > level IRQ.
> >
> > I think level IRQ on GPIOs are only used for logic peripherals
> > such as ethernet controllers etc where you can talk to the peripheral
> > and get it to deassert the line and thus acknowledge the IRQ.
> >
> > So the way I see it only edge triggering makes sense for extcon.
> >
> > Correct me if I'm wrong.
>
> Sorry for late reply because of vacation.

Don't worry I am not in a hurry. This is clean-up work :)

> Actually, I have not thought that the kind of irq_flags are fixed
> according to the category of specific h/w device. Until now, as I knew,
> the h/w device have to initialize the the kind of irq_flags
> for each peripheral device dependency. The each vendor of peripheral devi=
ce
> might design the kind of the kind of irq-flags for detection.
>
> If possible, could you provide some example on mainline kernel?

I don't know exactly what kind of example you are looking
for, but in e.g. drivers/input/keyboard/gpio_keys.c
you find this code:

                isr =3D gpio_keys_gpio_isr;
                irqflags =3D IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;

                switch (button->wakeup_event_action) {
                case EV_ACT_ASSERTED:
                        bdata->wakeup_trigger_type =3D active_low ?
                                IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISIN=
G;
                        break;
                case EV_ACT_DEASSERTED:
                        bdata->wakeup_trigger_type =3D active_low ?
                                IRQ_TYPE_EDGE_RISING : IRQ_TYPE_EDGE_FALLIN=
G;
                        break;

Is this what you're looking for?

Yours,
Linus Walleij
