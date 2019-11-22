Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2145BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04102072D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7YbCpaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfKVNqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:46:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34745 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVNqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:46:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so80324ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAWQ1LyijIUn8GXkKQWpBR9cSbqAaXNTjABBgrzAgjY=;
        b=b7YbCpaJKUEXz9rRNxJCqgWw6u2W9WiUuKBb282nEnxsXV5AOJWKcOeGD1IPzfNXla
         hpGZkKxz4zv0B43yYN2G8jNfN8ANkHc8mfRAmY3MA4TMsknUngiyHt7jc5zDzqVpk8gw
         CE9gKu7RHqm5M3VOO0ZLnejT8hWNT025tfdEeeOuPkZtBMgQLauofccazvkDNEeqs3NK
         3mGf/zxlOAjEk13XniLBI8q/PEoeJHsz28PSwLGSNz1MC+Vq1yLIo4oxNdLb6ilNxH5S
         YnopfSTHKSu7lBKpdE02eBgzxk8OFw7Rzr+uHk9QP4DD4wtASy/5vyh9EJ5esWR0I3tv
         X4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAWQ1LyijIUn8GXkKQWpBR9cSbqAaXNTjABBgrzAgjY=;
        b=ErSmVvTrA+Os4gJFhXG/hTjEQNh5+gyNEDKE7Sc2oEAX6mSQoFXac0135rvT7hrLLQ
         gtPUmBCHHr8fyE+Rs1r5le4i0c5bo0WpK9AfjiS/9HI+84imT0JcGvKzwYdlhIDPGt1o
         tqybPKXYqYEQnkTFPiD1umWy7iOL5boekZaQ6l34GXd06ChRBxZvgpEyUmiErwco5KQB
         XAQjEmFGoTZaB8pfBG91d+fIUEN5R6s138i19enQzvyxFtt0SW56dt+BpYdowwrV9oX4
         HYKsFNf0dXN4b0wVzaqUMxX9mohms7mhKoa9ewuEeS4fLZFwpB1qc1QdcJLivyMQWz9R
         rstQ==
X-Gm-Message-State: APjAAAV0emfb7hko6bWs7FJadpKQ+IgdgWoPJfDC2eClrG9Go3+nFSGE
        0k53gXx2zwfYTcQMpGW3FGJC72MDNIGsMLcx4g2+mw==
X-Google-Smtp-Source: APXvYqybX5QT/gZhgpR8SIpGxJbvAHrXKF5bruZ9lplrVlV6FQIR1YnjE3w9mALrMnjW5MTAYv3dIniFGFi025v/15A=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr144057ljm.233.1574430408587;
 Fri, 22 Nov 2019 05:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20191120142038.30746-1-ktouil@baylibre.com> <20191120142038.30746-2-ktouil@baylibre.com>
 <CACRpkdaZrvPObjyN4kasARzKZ9=PiAcvTzXzWkmC7R+Ay5tU8w@mail.gmail.com>
 <CAMpxmJWSgYjcGdR7Zrj-=nA+H8cYfZUriHQPxN=8zgPDvD-wTA@mail.gmail.com>
 <CACRpkdaW82pgQivc0VVgqqVv4fgXxMyGD3Lo8YHcMK7aGPDKaw@mail.gmail.com> <CAMpxmJU_0MzroyD_ZF5WOxpZz3dkADLOmW7aKpWdJ7GCvo-RnA@mail.gmail.com>
In-Reply-To: <CAMpxmJU_0MzroyD_ZF5WOxpZz3dkADLOmW7aKpWdJ7GCvo-RnA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 14:46:36 +0100
Message-ID: <CACRpkdaPQKxfC66yhG=xdmCOGGd9PjDVCwZquKb+4HmuS_=kNA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: new optional property write-protect-gpios
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Khouloud Touil <ktouil@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        baylibre-upstreaming@groups.io,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 2:04 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> > I would to like this:
> >
> > 1. Add a new generic property
> >    writeprotect-gpios that mandates to use GPIO_ACTIVE_LOW
> >    and use this in the new example
> >
> > 2. Deprecate wp-gpios in the binding, keep it around but deprecated.
>
> This is a pretty standard property though - for instance it is
> documented in the main mmc binding and doesn't mandate GPIO_ACTIVE_LOW
> either. I think this is because nobody says that the write-protect
> line must always be driver low to be asserted - this is highly
> implementation-specific.

The MMC case is actually especially convoluted. It has always
respected the GPIO_ACTIVE_LOW flag, and that is used if
present. At the same time it *also* supported a bool
wp-inverted flag, with the specified semantic that if both
were specified (ACTIVE_LOW and wp-inverted) the result
would be nothing as it is a double logical inversion.

So that is why the quirk looks like this:

       /*
         * Handle MMC "cd-inverted" and "wp-inverted" semantics.
         */
        if (IS_ENABLED(CONFIG_MMC)) {
                /*
                 * Active low is the default according to the
                 * SDHCI specification and the device tree
                 * bindings. However the code in the current
                 * kernel was written such that the phandle
                 * flags were always respected, and "cd-inverted"
                 * would invert the flag from the device phandle.
                 */
                if (!strcmp(propname, "cd-gpios")) {
                        if (of_property_read_bool(np, "cd-inverted"))
                                *flags ^= OF_GPIO_ACTIVE_LOW;
                }
                if (!strcmp(propname, "wp-gpios")) {
                        if (of_property_read_bool(np, "wp-inverted"))
                                *flags ^= OF_GPIO_ACTIVE_LOW;
                }
        }

Nevermind MMC though.

The current code for at24 has an ambiguousness issue: if
the gpios cell 2 is specified as GPIO_ACTIVE_LOW
(which is in some sense correct) then the effect will be
that it is driven high to assert the wp, which is  ... rather
counterintuitive.

I could think of a compromise like this:

1. Keep "wp-gpios"

2. Add a quirk to gpiolib-of.c that will force that as active
   low no matter what flag is specified to the GPIO descriptor.

3. If some other flag that GPIO_ACTIVE_LOW is specified,
  print a warning and say the the (default) GPIO_ACTIVE_HIGH
  i.e. 0 is gonna be ignored and we forced the line to be
  active low.

4. The code still need to be modified to set the value
   to "1" to assert the line since the gpiolib now handles
   the inversion semantics.

5. Hope that no system with an active high wp ever comes
  into existence because then we are screwed and will have
  to create a new binding and deprecate the old binding
  anyway.

Yours,
Linus Walleij
