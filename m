Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95CDC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB162075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEFFIjaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfG1XeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:34:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38377 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfG1XeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:34:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so40690910lfj.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUvn9OI5nD/4S7v8ywB8lgEu/KDQowtKmV6CtOSPqUA=;
        b=aEFFIjaZRLhrPDgULFaRicTLJcOaMeowEaKUJOOHKxsU0QeLveEc4UGQHyiCE9z748
         LokY6dj1a7TghWqOkoJZ0mkFKXLYJN/B++Ka3tTFhWmvmB78ADuM9y9mObtiU0E4Trqz
         yeY0A1yraFZKZIdaaAh0yHYrBWOyKpGLB5iZhDkYTZOU/kUmbgRr9tG+Bvf4lOWB324F
         svF5yh/hqwRzyr0EgJCkUZhzkclqGfGdEZE6Jd5Tb3xOCak99/+GzYvbwS5TI3h5A998
         sN1u/IeShA4POS42IOkF4YLja9CWZ5LFecqlS73MoehKEDHT6PnnW3TJx2g8hZYF7j2s
         Zopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUvn9OI5nD/4S7v8ywB8lgEu/KDQowtKmV6CtOSPqUA=;
        b=Fsdw565+CgI8gdy+YsVrc5CJRW4ZkWIuGyJXpmr1doDPUFGQMu6Qo5SEn/z3zZbP15
         QHNXLrx89WfArpYZaL2qblBvTF3NVcoIJJcUP3YFqVr9is4e43o3qBKYxSMWYcHxm4S7
         A4Y0Xnd25hQAGSGJlb/Q/1Db2yCnKQt7UOzGbIgRZIbyaRT4umHoA3DywZYj5RiOABFF
         P25RZvGPvs8q7DKYs0rZrelTs9IQIm0+NzGodTihJhrfvHO1rk3naOmow0AQbSys4rOD
         cXk77sUA+3onSw99jXuFdHCc2ltzj4y2ny9URxzmlXBqU+SmBiMMz9f0DN9mmH+Xovao
         wM3w==
X-Gm-Message-State: APjAAAU7iKrMyiMjnpgH59uqQFkGttaBpVUS4RD55zYikfGgR5ScIoxd
        mGqxpiiKM/n9FX5/r85Cjdot83MHoQi9AfU3/Tsxtw==
X-Google-Smtp-Source: APXvYqysascwZ7s8p4u+iWYY6k2d56GISla2oOhZmhWM9B7cI6Cbtauk+/chIBA1grY5/zLjWKJ3aCLJJa9z3+4C1R8=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr51451245lfc.60.1564356855227;
 Sun, 28 Jul 2019 16:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <1563564291-9692-1-git-send-email-hongweiz@ami.com>
 <1563564291-9692-2-git-send-email-hongweiz@ami.com> <CACRpkdYhVoP75ZDfASW+DH5yf-a5diitiXsh7eLsJx5hsTC9sQ@mail.gmail.com>
 <ef9d9c17-6e2d-4a4e-ac44-f8da4bb3b8eb@www.fastmail.com>
In-Reply-To: <ef9d9c17-6e2d-4a4e-ac44-f8da4bb3b8eb@www.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 01:34:02 +0200
Message-ID: <CACRpkdZxsF9gQj0VicVLsPKXg6rKA1mLwbywmazOf0w8PLnOfA@mail.gmail.com>
Subject: Re: [v5 1/2] dt-bindings: gpio: aspeed: Add SGPIO support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Hongwei Zhang <hongweiz@ami.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-aspeed@lists.ozlabs.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:42 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> If the clock driver owns the control register, it also needs to know how
> many GPIOs we want to emit on the bus. This seems like an awkward
> configuration parameter for a clock driver.
>
> To avoid the weird parameter we could protect the control register
> with a lock shared between the clock driver and the SGPIO driver. This
> way the SGPIO driver could have the ngpios parameter, and request
> the clock after its written the ngpios value to the control register. A
> regmap would be useful here to avoid the resource clash and it also
> provides the required lock.

Nah. Too complicated.

What about using the clock API locally (in the singleton driver,
much as it is today) though, to give the right abstraction?

See
drivers/gpu/drm/pl111/pl111_display.c
pl111_init_clock_divider() for an example of a local
clock.

> However, you're also going down the path of splitting the driver such
> that there's one instance per bank. With this approach we need to
> solve two problems: Accounting for the total number of GPIOs,

I don't see that as a big problem since each driver instance will
handle 8 GPIOs and don't need to know how many the
other instances have and whether they exist or not.

> and
> only enabling the bus after the last bank has had its driver probed.

That is a bigger problem and a good reason to stick with
some complex driver like this.

> The accounting might be handled by accumulating the number of
> GPIOs in each bank in the control register itself, e.g. the driver
> implementation does something like:
>
> spin_lock(...)
> ctrl = ioread32(...)
> ngpios = FIELD_GET(ASPEED_SGPIO_CTRL_NGPIOS, ctrl);
> ngpios += 8;
> ctrl &= ~ASPEED_SGPIO_CTRL_NGPIOS;
> ctrl |= FIELD_PREP(ASPEED_SGPIO_CTRL_NGPIOS, ngpios);
> iowrite32(ctrl, ...);
> spin_unlock(...);

But why. The gpio_chip only knows the ngpios for its own instance.
It has no business knowing about how many gpios are on the
other chips or not. If this is split across several instances this should
not be accounted that is the point.

> This works on cold boot of the device when the ngpios field is set to
> zero due to reset, however will fail on subsequent warm reboots if
> the GPIO IP block is protected from reset by the SoC's watchdog
> configuration: the field will not be zeroed in this case, and the
> value of the field is represented by `NR_BOOTS * NR_GPIOS`,
> which is incorrect. To do this correctly I guess we would need some
> other global state held in the driver implementation (zeroed when
> the kernel is loaded), and write the incremented value to the control
> register on each probe() invocation.

This is answered about I guess.

> However, that aside, we can't simply enable the bus in the clock
> enable callback if enable is called per-bank, as it is called once on
> the first request with further requests simply refcounted as you
> mentioned. This is exactly the behaviour we can't tolerate with the
> bus: it must only be enabled after the last GPIO bank is registered,
> when we know the total number of GPIOs to emit.

So the bus needs to know the total number of GPIOs or
everything breaks, and that is the blocker for this
divide-and-conquer approach.

Why does the bus need to know the total number of GPIOs?

(Maybe the answer is elsewhere in the thread...)

I guess I will accept it if it is really this complex in the
hardware.

Yours,
Linus Walleij
