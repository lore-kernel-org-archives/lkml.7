Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3134A21741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrIZCIXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfK1KGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:06:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39452 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfK1KGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:06:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id e10so18660540ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUJALJT7TTpPicHHFkyqG0CxrKAUNpXMj/J44tCGQC4=;
        b=MrIZCIXKCoWoT3alX7UY36qi/6SmTc8BmnSzXxmhsQpC3yJD3IGpnPHTHRA18Eq4Ii
         dA9JQj8dImYM/knYLxHfT9Amb+CBMYLylpGe8yqPF3l74o2xTtnKKtGSQgoG6/WTJ/oL
         HUwMesK82Mbk14A7KTmke+h5acBeYRP/otlWfqCq7PAbpIRdWJ10VEj2VCjL7tbbk+Rr
         NxZZ9SHbyBXhfeY2zwMQ1yglciw9gS/q4pPMp2nX+/rBkPPnVgj9MQHTPDHOLO99uH2y
         VKbEYHJ6ET/W96KuTASZNjb2IB0ZQxCPs672YjBtFM0beOSqC8SiM1NMvSwegQqNVtV1
         +kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUJALJT7TTpPicHHFkyqG0CxrKAUNpXMj/J44tCGQC4=;
        b=s2wVUvYi6CUC5yjOjp4BOzdN0KczyHwrM5VuZRWcmgwBBV/6Bir2YWGODeSlrMNVI0
         vn0752evDUDu85x0Pc64WvjnZqsE+3l7wWi5mtYHLh4NlWg7RIO41fJxTjLcWJ0DvuY5
         o9Ap/LdrPP6Lyp+EFBJJJLuhvV4Ug12SoUwffUfb05YE3DT0Jh9OhWUdAPo0C5YfFOAC
         VnK3sHSLKelZwKthS7rWAEn7Mr/kh76Y7xa+B0ShpOatW6SD13jjVXkZVvv1uep2sYqO
         q+2R1WK6NPWzBXJAXEGx7EocaPFxtSSVHtgAcdFtG8KU2x+LwYfIsynHL/4h1kkwLww1
         2RJA==
X-Gm-Message-State: APjAAAVONwfpscIrTbDGGeKpy71SLLdj4ecr4sBmh1Aq+5+DRPaZiqIM
        0iCOaEVshN9cNvAEM0XJUqid6twwa80QTN/nK91ywA==
X-Google-Smtp-Source: APXvYqwk5GfDLW4bgJe+dmZ3t+boVThpmLI6573Ta152HHaHVEwKJ6QpDlfomukhdkz0o/BidvY2uXE+XHx6i4GMZaA=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr33914816lji.251.1574935607136;
 Thu, 28 Nov 2019 02:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20191120133409.9217-1-peter.ujfalusi@ti.com> <20191120133409.9217-2-peter.ujfalusi@ti.com>
 <CACRpkdbXX3=1EGpGRf6NgwUfY2Q0AKbGM8gJvVpY+BRAo5MQvQ@mail.gmail.com> <d423bc53-31df-b1b4-37da-932b7208a29e@ti.com>
In-Reply-To: <d423bc53-31df-b1b4-37da-932b7208a29e@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 11:06:35 +0100
Message-ID: <CACRpkdafEdsN6i16SA175wE4J_4+EhS5Uw4Qsg=cZ=EuDYHmgg@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: gpio: Document shared GPIO line usage
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 2:36 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 22/11/2019 14.10, Linus Walleij wrote:
> > On Wed, Nov 20, 2019 at 2:34 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> >
> >> Boards might use the same GPIO line to control several external devices.
> >> Add section to document on how a shared GPIO pin can be described.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >
> > As I've stated earlier I think this information is surplus.
> > If two devices have a phandle to the same GPIO line
> > then it is by definition shared.
>
> Well, phandle + line number to be precise.

This is what I mean when I say "phandle to the same GPIO line".
Like this:

foo-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;

If the phandle <&gpio0 5 *>; appear in some other
(non-disabled) node it has > 1 users.

> >> +               line_a {
> >> +                       gpio-shared;
> >
> > So this is unnecessary: if the same line is referenced
> > by phandle from two places it is shared, simple as that.
>
> phandle is pointing to the gpio controller, not to the line.

Cleared up above.

> >> +                       gpios = <5 0>;
> >> +                       output-low;
> >
> > This is overlapping with the use case to define initial
> > state values for GPIOs, something that has been
> > brought up repeatedly and I've collected links for
> > previous discussions several times.
>
> I don't mind this to go away and the first set would configure the level.
> Kept it here so I can reuse the gpio-hog code from gpiolib-of ;)

People have tried to reuse the hog code to set up
initial line levels as well, it failed because they could
not get the DT bindings through the door.

> > I guess if need be I have to look them up again.
> >
> > The DT maintainers don't like the hog syntax so
> > something else is desired for this.
>
> I see, so the gpio-hog might change?

They will not change since they are ABI, but their
use case will not be extended AFAICT.
Not my pick, I liked the hog syntax but we need
consensus.

> > (snip)
> >> +The shared GPIO line management strategy can be selected with either of the
> >> +following properties:
> >> +- refcounted-low: The line must be kept low as long as there is at least one
> >> +               request asking it to be low.
> >> +- refcounted-high: The line must be kept high as long as there is at least one
> >> +               request asking it to be high.
> >
> > Is this really needed? Isn't it more appropriate to just define the
> > semantics such that as soon as some consumer requests the line
> > high it will be refcounted high, and as soon as it is requested
> > low by any consumer it will be refcounted low.
>
> Well. How do we decide which level is the one that should be preserved?

First come first serve.

If there is any conflict amongst the consumers we are
screwed anyway so why try to establish where they should
agree if they don't agree?

> How would the core decide what to in a simplest case:
> two device, they are the same part.
> ENABLE pin which needs to be high to enable the device.
> When the driver probes it asks for initial deasserted GPIO as the device
> is not in active use.

This makes me think it should be a unique driver
with a unique compatible string, as it embodies
use cases.

It is too broad to just define
refcounted-high or refcounted-low, that is hiding the
real use case, so I would go for something like a
resource in the device tree that all other devices that
need it can take.

Like a reset controller, precisely:

reset: reset-controller {
    compatible = "reset-gpio";
    gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
    #reset-cells = <0>;
};

dev0 {
    resets = <&reset>;
};

dev1 {
    resets = <&reset>;
};

The ambition to use refcounted GPIOs to solve this
usecase is probably wrong, I would say try to go for a
GPIO-based reset controller instead.

The fact that some Linux drivers are already using explicit
GPIO's for their reset handling is maybe unfortunate,
they will simply have to grow code to deal with a reset
alternatively to GPIO, like first try to grab a reset
handle and if that doesn't fall back to use a GPIO.

I would say don't try to shoehorn this use case into the
gpio library but instead try to create a reset controller that
takes care of arbitrating the use of a single GPIO line.

Yours,
Linus Walleij
