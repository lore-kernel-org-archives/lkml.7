Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43FC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF40206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOPdseXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDDFZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:25:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45934 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDDFZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:25:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so856561ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBfACO2yvbKXYcntcMy9iuJl3GZkSswa+DWpJE7auzA=;
        b=nOPdseXMFBCJp1tkbrp9k6j7T/+kehHRD681BNID3DofIJupuh7h4v75uO1jIzwfO1
         Fh+/3wvjyAY0veeY18fkfcWY46cKwUPlLMPVtD991jxKp2/sY4YibI5dF2zuwa4/S1e5
         +0dL0JZDZ7Dqww3Hobum4MFiOgu6+zhkzGkgYJns1koPSgBNQwoP39YD6TiYkT63QP8R
         fj8UQL7Ladk4Px6E5kkuNFZImVpJZv3D2Fgf7du5DevyZnCcB3ndBLd0qPQf47ajXe/+
         QK/e9uQnyeuAFzzhW4RWCSGDGGp/Zf//eGA8F3r78EtsvAnoUAaQYabOrVHNTQIO9po4
         /GoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBfACO2yvbKXYcntcMy9iuJl3GZkSswa+DWpJE7auzA=;
        b=fTReOgJv5TdEwbysVJiBnhVgUMjeEjqJImszkD3ud0k+ofwGgDUuYLFt8RjKwA3zFL
         VgBAYHO17YQXq+CDnApJe22mtqiu5YP1QfkvaaM9h0nqRzGgUhDRdqiXVLrQSBtBJF/q
         jPtJDtyYZRcG9J/q8H4wsEUNuq+PW4/nGZuxdmNDU6IWkIDkSSp+oFWa2BVBCQXyywKK
         IpcLeJKp+WWLPK33T71om0r6VrOyVSqjIC5La1k1H9zXjclarGPpDpDI4UM9v3NZxoUb
         RXSeUGYTARIMalrm9S4sT1UgkF/p38ofnAEigzJ7cQ0hv7s+0f1Hg4h5HjVNgZLBZX7G
         aC/A==
X-Gm-Message-State: APjAAAWmkkKdL8EWxBQill3CiCTAdwDsnEyRp5Gcj07lPnBlIHvhkN7Z
        niqx6rkZ56Lj3dKNYHC0p6g9GLjSuDlK27k/ja2t3Q==
X-Google-Smtp-Source: APXvYqz9cg+EebYhtvLmiqsGuBbLrmNw/sOp/Q5ZBGRXTDkbBIRfdJDD4/BLBtjXpvNllmQ2e0Ia04TKDNK8g4FNDRw=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr2023102lja.49.1554355511291;
 Wed, 03 Apr 2019 22:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190320103927.21227-1-geert+renesas@glider.be>
In-Reply-To: <20190320103927.21227-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 12:24:59 +0700
Message-ID: <CACRpkdbqfJj37vHh3twpojHLoEnmcWqymbD8CYSi4PGPawP1Eg@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 5:39 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If a device is part of the wake-up path, it should indicate this by
> setting its power.wakeup_path field.  This allows the genpd core code to
> keep the device enabled during system suspend when needed.
>
> As regulators powering devices are not handled by genpd, the driver
> handles these itself, and thus must skip regulator control when the
> device is part of the wake-up path.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Note that I don't really need this on the Renesas Ebisu-4D board, as
> there is no regulator or PM Domain controlling power to the GPIO
> expander on that board.  I did want to have all wake-up path processing
> implemented in the driver for completeness, and did test its behavior
> with gpio-keys configured as a wake-up source.
>
> However, while this approach is known to work fine on other boards, with
> other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
> irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
> device suspend ordering.
>
> The proper ordering is:
>   1. When gpio-keys is suspended, its suspend handler calls
>      enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
>      pca953x_chip.wakeup_path to be incremented,
>   2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
>      and marks the device to be part of the wake-up path.
>
> However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
> scheme :-(
>
> So depending on topology, this may work, or not...

This looks like the right way to do it to me.

Ulf/Rafael: could either of you confirm that this is the right way
to handle it when we have an optional external regulator cutting
power to the chip providing the wakeup like this?

Yours,
Linus Walleij
