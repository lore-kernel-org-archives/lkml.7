Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D31C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8022071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRhLjYM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKVMKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:10:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46018 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfKVMKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:10:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so7050870ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 04:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlDWTRSDtzcsrS/LzPR3YwO7p6W49eS5hMAX/W8yQE0=;
        b=pRhLjYM0wx/YizczTitjIGOaQJ3d7C3HKug/L0+xWBQiV0c0Nk9AKah2Tcvn321RB3
         64UTqFpyIj5U2Ub+uUJK230TnnmsIC0mrbFcrSmcxEIUxGLmWyVS7j5EsqUE8B+GChJo
         lgeNS4EfhmVVmA559xgRF4VUIAPfwtS7U2APxgfRXw89iaTSfvKyb9t5ejHGo6AaRITK
         fCbEqJTC/0ae3U9y3iHN54/jQrdvW0XfE8xUf22m+gmlCdaMwCJ6ROoOu4ROGxijXKuZ
         vtmU2XXCvOaF4G3M1IsTO7THcDosvQdEjs+XpakwnqGfgryu+C3GHNuU6zcYnFW8J813
         B9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlDWTRSDtzcsrS/LzPR3YwO7p6W49eS5hMAX/W8yQE0=;
        b=ZxpBA7an5Fp4gFkxL8ruEVop9It2UwvkyQzkNwdNeCgy9yXJt26+ws6FFSOaubB/eD
         /6eJP60b2rIei2T+eQjacPl4+hkPOuEUFDMrXv1hwa5qenfvvNDeS+pvJjVGgVBMZvRW
         p5AFVVrytEO2B0JpM9+TWsM8vWQbJS6NcogD66APCnWeIe2kM4y26jwUTTKcf9R41f0h
         sh8bRh6c+xGEMa+pUEkOj1kOwBz8N5w0HatuE4w8vKzLK/gyE4yQ8FK77VoNEV+4mC4t
         ZVhjXKjO2e1lLu9annpTjXMSMiza/2up402hVQORNHwAn5S35JCSo7jwWi7QGudktPV9
         A19g==
X-Gm-Message-State: APjAAAXqAyIPDVcfstGSgcvAWSxA08HN6FaV3cv9LCJMsw9SMPCVvh8F
        EeCkdty1ilmo6zt+Sh0NrjHRSCFZUVqwcvSXNgwKEQ==
X-Google-Smtp-Source: APXvYqyqKXD0yVNT+urjoUi2GUYSWy9M9yz+lnGATBdyiLh4EoHM658sZ5KV3XTNbO32a5Dg4fjfdP6zwcFqrraCeP4=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr12053927ljd.183.1574424641250;
 Fri, 22 Nov 2019 04:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20191120133409.9217-1-peter.ujfalusi@ti.com> <20191120133409.9217-2-peter.ujfalusi@ti.com>
In-Reply-To: <20191120133409.9217-2-peter.ujfalusi@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 13:10:29 +0100
Message-ID: <CACRpkdbXX3=1EGpGRf6NgwUfY2Q0AKbGM8gJvVpY+BRAo5MQvQ@mail.gmail.com>
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

On Wed, Nov 20, 2019 at 2:34 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> Boards might use the same GPIO line to control several external devices.
> Add section to document on how a shared GPIO pin can be described.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

As I've stated earlier I think this information is surplus.
If two devices have a phandle to the same GPIO line
then it is by definition shared.

> +               line_a {
> +                       gpio-shared;

So this is unnecessary: if the same line is referenced
by phandle from two places it is shared, simple as that.
It is up to code in the operating system (like Linux) to
detect if they are shared in practice (both consumer
nodes are enabled) and then deal with the outcome.

> +                       gpios = <5 0>;
> +                       output-low;

This is overlapping with the use case to define initial
state values for GPIOs, something that has been
brought up repeatedly and I've collected links for
previous discussions several times.

I guess if need be I have to look them up again.

The DT maintainers don't like the hog syntax so
something else is desired for this.

> +                       refcounted-high;
(snip)
> +The shared GPIO line management strategy can be selected with either of the
> +following properties:
> +- refcounted-low: The line must be kept low as long as there is at least one
> +               request asking it to be low.
> +- refcounted-high: The line must be kept high as long as there is at least one
> +               request asking it to be high.

Is this really needed? Isn't it more appropriate to just define the
semantics such that as soon as some consumer requests the line
high it will be refcounted high, and as soon as it is requested
low by any consumer it will be refcounted low.

> +If neither of the refcounting strategy was selected then the shared GPIO is
> +handled as pass through. In this mode all user requests will be forwarded to the
> +shared GPIO pin without refcounting.

Why should this even be allowed? If we are defining a special semantic
for refcounted GPIOs (even defining a separate API in the Linux
OS, though it is beside the point) why do we have to have a fallback
to the old behaviour at all?

I think you can do this by just detecting multiple phandles to the
same GPIO and implicit refcounting for > 1 consumers.

I.e. no new bindings at all, maybe some patches explaining the
semantic effect of using the same GPIO from two consumer
nodes.

Yours,
Linus Walleij
