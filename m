Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468F6C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE9321774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktkDtU+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfK2JZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:25:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45697 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK2JZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:25:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so1423760ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 01:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mg1s2q4SGEIjUen50+yfiIskGrnLGRT7vDezP+iB3ek=;
        b=ktkDtU+MQ2A0ntvCYC85sCMclaO55zFflKLdsI6avwawIIlmHsDcE4mn8nJ3AztMEv
         /Cby7GoxYXup1ExYM3BQmgQXwwmBRJn6aVro0IWVoTMqa0JghFRIhtQsJ/lqSJ5qA3zr
         MehV1JylaHRE3qimaRKxr9uZSvY7MsCMlu/rzHFHBqy5wxIpyLk0W/JtJwv5UNsLEhqI
         Dxw3WCwOkkXy8sbssqn2378Js68tUCcht+TUwnuLI8DQO1mDdhR/OHeESiGR+5Za+VlW
         WTUCQFExToy0WVEcC2iYO6SGwBoaXe6KQGnXu/YWd18dToXPpJUkn+mjZ46/ACfLFkxV
         A/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mg1s2q4SGEIjUen50+yfiIskGrnLGRT7vDezP+iB3ek=;
        b=TyXHXbeAR/cc6B4paAF+3etPBqkzhL5hB2MAdev183ab9MT+lqLPqOshZDl/3v8FGr
         p6VB7wdLF62u6HxGXfnHoZ9PNDr6f1k5VHYqQQ5Y0a2Hxv9FPDrYjvUK4alE8tDeocTG
         7/cOD3yo2TQQJ5ilF8W53OstpOdO17bLi/cGXCYzO4CoRmLw8dJSfBZT0uBqbZ0tO2ER
         IYpKJsGMYcu0wi8KLyVmmAFVi6CiTyPvez06XVXzLQhvwYRdveM+7CXZEcalUJMwxVr7
         atjZ7cwEKDDuAkrQQ9DsFnLKMuL4PcldE1I2hJ8wR3widAF3BsAeNSJCCd+oBojr00Se
         7pYQ==
X-Gm-Message-State: APjAAAVUBrDAySl1gVv4bSNaK35l2F3QHzqJmsIS2CYdBm30PEvbDSUC
        BFxAo/wHZWz9QPOoMnivNzbxWagIgNtiHUN1VMIYyw==
X-Google-Smtp-Source: APXvYqzTv0ijDNJAizgamXHOcidWYTyrultraC4Zuh5XFuR7VO2T4//KTaO/9/IsP5Sukin50F6jt4XGVFDVmELqfPI=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr16086638ljm.233.1575019510217;
 Fri, 29 Nov 2019 01:25:10 -0800 (PST)
MIME-Version: 1.0
References: <20191128155438.325738-1-paul.kocialkowski@bootlin.com> <20191128155438.325738-6-paul.kocialkowski@bootlin.com>
In-Reply-To: <20191128155438.325738-6-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 10:24:58 +0100
Message-ID: <CACRpkdaSLsq-oA7t8OL6_6L+ivZE+a83M4JbTZ2HW5E1E7c6yw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] gpio: syscon: Add support for the Xylon LogiCVC GPIOs
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

thanks for your patch!

On Thu, Nov 28, 2019 at 4:54 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> The LogiCVC display hardware block comes with GPIO capabilities
> that must be exposed separately from the main driver (as GPIOs) for
> use with regulators and panels. A syscon is used to share the same
> regmap across the two drivers.
>
> Since the GPIO capabilities are pretty simple, add them to the syscon
> GPIO driver.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
(...)
> +#define LOGICVC_CTRL_REG               0x40
> +#define LOGICVC_CTRL_GPIO_SHIFT                11
> +#define LOGICVC_CTRL_GPIO_BITS         5
> +
> +#define LOGICVC_POWER_CTRL_REG         0x78
> +#define LOGICVC_POWER_CTRL_GPIO_SHIFT  0
> +#define LOGICVC_POWER_CTRL_GPIO_BITS   4
> +
> +static void logicvc_gpio_offset(struct syscon_gpio_priv *priv,
> +                               unsigned offset, unsigned int *reg,
> +                               unsigned int *bit)
> +{
> +       if (offset >= LOGICVC_CTRL_GPIO_BITS) {
> +               *reg = LOGICVC_POWER_CTRL_REG;
> +
> +               /* To the (virtual) power ctrl offset. */
> +               offset -= LOGICVC_CTRL_GPIO_BITS;
> +               /* To the actual bit offset in reg. */
> +               offset += LOGICVC_POWER_CTRL_GPIO_SHIFT;
> +       } else {
> +               *reg = LOGICVC_CTRL_REG;
> +
> +               /* To the actual bit offset in reg. */
> +               offset += LOGICVC_CTRL_GPIO_SHIFT;
> +       }
> +
> +       *bit = BIT(offset);
> +}

The gpio-syscon.c is for simple syscons where the lines
you want to affect are nicely ordered in the registers.
It is intended to be generic.

This is kind of shoehorning a special case into the generic
code.

Isn't it more appropriate to create a specific driver for this
hardware?

Special get/set quirks for any possible quirky offset is
certainly not the way to go, if this should be supported
we need generic properties in struct syscon_gpio_data
to indicate the valid bits and offsets.

Yours,
Linus Walleij
