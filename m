Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6675AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B673206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSRuM9us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLKAHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:07:06 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46119 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfLKAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:07:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so14385029lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 16:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vKqFJGzj7zP9jxAQ/Fxr2GBQpU3k9RbiY8pAqobny0=;
        b=XSRuM9usxGH3asxsaXj6dtz/rkxCqUZFsZF5E4NGQqMDAp8E9lnlB+IjoaarN/OcLF
         6kfzdeD7826IhCPZ5O6JrA8MGb9occsM9FiL9Vs/S+qBbYfkhtvWrTfo7ngFAUkg0N4H
         FmwRtLnR+G9u0bDUKY0cfsesfzjhERZqREW85OTjJk3Ng2GYBExYhSUmqO95axW6mJ5I
         tGppw7/OBBZMk7c9RuDKpECoEMPMCXKLcYVpWT/d30bvWHHmQdhx9ptWTmxKh9Pe7XlF
         5rPW3o7FVr2ADMe58rF6XyObuJNbJx4yZtERJmIXkxtn8KANzhb+I578JOxBvtm6uC3b
         uXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vKqFJGzj7zP9jxAQ/Fxr2GBQpU3k9RbiY8pAqobny0=;
        b=JOoEuqG5KZ8HkJ2TT+R2P0zeDOYFFx4XJf8wVcl0fHlahYfH5a3ENn/UqxVFKxpV2I
         c30SaNDuFwg4fvKD6KY6PTEOiYzgIk8pMjuY/Etekc/XYhMCyPuQ72WgDyLZTg6PMylu
         fZCy/3m/eXB6cPXnJBa64s5qDikGyYS+LfnugoXDlrANEq/zJ3N4gKnyp/FmlhhuSqeb
         uqY3zryEW8BV3uEb3qgyr4zDD1ywdKr+bePgnf1faPUBf8Nwu81TMHyS1ctOczaw9Y/g
         RQ8F2aHVmt4l5H5SQMj2SO74ID9mpdhKQ5mPGCHTHbRvT/v6LN4J9H+CgEjXzPAXKJw1
         6fsA==
X-Gm-Message-State: APjAAAXdxSsCF+ZR2dOb2fZZlEpy/SvD1ARzkGkCOQvocA5iOaec++os
        DmHS294fJCDMY3buaaxjgmaFpHA9+vDJh/M0svAy/Q==
X-Google-Smtp-Source: APXvYqxVW0ZSopDXaAGHYtoUrhx2h12DD/w/jNt0W6I1hMAEhJb0fNLsF9WPsuEKi7yK29CRbsxEeBcvpTHHaU7Qj4s=
X-Received: by 2002:a19:c648:: with SMTP id w69mr349735lff.44.1576022823210;
 Tue, 10 Dec 2019 16:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20191120133409.9217-1-peter.ujfalusi@ti.com> <20191120133409.9217-2-peter.ujfalusi@ti.com>
 <CACRpkdbXX3=1EGpGRf6NgwUfY2Q0AKbGM8gJvVpY+BRAo5MQvQ@mail.gmail.com>
 <d423bc53-31df-b1b4-37da-932b7208a29e@ti.com> <CACRpkdafEdsN6i16SA175wE4J_4+EhS5Uw4Qsg=cZ=EuDYHmgg@mail.gmail.com>
 <89afb07f-fb70-3f44-2396-df350ca15690@ti.com>
In-Reply-To: <89afb07f-fb70-3f44-2396-df350ca15690@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 01:06:51 +0100
Message-ID: <CACRpkdYe47SZDW1JXT6g5n+AEOYd2PH92YtBnjQsd=Z2GJroZQ@mail.gmail.com>
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

On Mon, Dec 2, 2019 at 10:31 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 28/11/2019 12.06, Linus Walleij wrote:

> > The ambition to use refcounted GPIOs to solve this
> > usecase is probably wrong, I would say try to go for a
> > GPIO-based reset controller instead.
>
> I did that. A bit more lines of code than the gpio-shared.
> Only works if all clients are converted to reset controller, all must
> use reset_control_get_shared()

I don't think that's too much to ask, the usecase needs to
be expressed somewhere whether in code or DT properties.

> But my biggest issue was that how would you put a resets/reset-names to
> DT for a device where the gpio is used for enabling an output/input pin
> and not to place the device or part of the device to reset.

Rob suggest using GPIOs but represent them in the Linux kernel
as resets.

This would be a semantic effect of the line being named "reset-gpios"
as Rob pointed out. Name implies usage. We can formalize it
with DT YAML as well, these days, then it is impossible to get it
wrong, as long as the bindings are correct.

When you call the reset subsystem to create the reset handle
it can be instructed to look for a GPIO, possibly shared, and
this way replace the current explicit GPIO handling code
in the driver. It will just look as a reset no matter how many
other device or just this one is using it.

> Sure, one can say that something is in 'reset' when it is not enabled,
> but do you put the LCD backlight to 'reset' when you turn it off?
>
> Is your DC motor in 'reset' when it is not working?
>
> GPIO stands for General Purpose Input/Output, one of the purpose is to
> enable/disable things, reset things, turn on/off things or anything one
> could use 3.3V (or more/less).

Answered by explict interpretation of DT bindings
named "reset-gpios". Those are resets, nothing else.

> > The fact that some Linux drivers are already using explicit
> > GPIO's for their reset handling is maybe unfortunate,
> > they will simply have to grow code to deal with a reset
> > alternatively to GPIO, like first try to grab a reset
> > handle and if that doesn't fall back to use a GPIO.
>
> Sure, it can be done, but when we hit a case when the reset framework is
> not fitting for some devices use of the shared GPIO, then what we will do?

That can be said about literally anything we do in any
framework we design. Rough consensus and running code.
Bad paths will be taken sometimes, hopefully not too much.
We clean up the mess we create and refactor as we go
along, it is always optimistic design.

> How would it satisfy the regulator use case? We put the regulators to
> 'reset' when they are turned off / disabled?

We don't try to fix that now, if it's not broken don't fix it.
Let's try to fix the reset problem instead.

Yours,
Linus Walleij
