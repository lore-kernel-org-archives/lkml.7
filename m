Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC233C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01FB205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbfDDJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:34:59 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44308 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731940AbfDDJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:06:48 -0400
Received: by mail-vs1-f68.google.com with SMTP id j184so890198vsd.11;
        Thu, 04 Apr 2019 02:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+XzHk+jpTGxDGVqwa4dg4gvQjQHJPUEUNt3UVVTA0M=;
        b=TIxcxsAHP0ztxYQnoDKdJhgktWvXsEVcp7F4z5b40lX0LVZTavA1jqtUNAjkTchRk+
         oEK5pwm0IYdoWuFqXSSOjBsquK87AW8I9aMRiL7tT1zTU9HsBeSE8ktlPvFIma5JKuue
         0WynQMnh4mfkYDJ37Q3qvKW/zLlavfBNSr+iPfLE4P+INXt2itXDiPdkWq2i8ZYZaHbo
         D8WRaAGsMe7DjrE8e8qVrZUIuc0MyJeQKadWhhELgWSxmZSo+Imf/z4jhl80ZzRtGGG+
         yhJo1kwUqhBuQk5pz8LtnYmxmFQE6YsGc8cVkfy+mnII7ZbNQtlqIFLJyULQDkrELT3Z
         W+Yw==
X-Gm-Message-State: APjAAAXfmUcAAo5whrs4v2VLCxpzpN/qxlYupOlfcd1PzxX2RrfawxeN
        EBTu8M35TyNlfjupYjYe3a0McSyLqusNsisZ8m0=
X-Google-Smtp-Source: APXvYqyQVT+lQa4Dnf7R6t91gYRQ+JEWFwqrjQtb6c1FMR+gD5nZYaA9ZPLXA91ckUsikJjFPiyeIHEPUp5cB0tIzfY=
X-Received: by 2002:a67:fbcc:: with SMTP id o12mr3473975vsr.60.1554368807334;
 Thu, 04 Apr 2019 02:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190320103927.21227-1-geert+renesas@glider.be> <CAPDyKFpecPdcqagc567kZJeWbe6y_0j9JAVKcE6c9Ltv+OG-Yw@mail.gmail.com>
In-Reply-To: <CAPDyKFpecPdcqagc567kZJeWbe6y_0j9JAVKcE6c9Ltv+OG-Yw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Apr 2019 11:06:35 +0200
Message-ID: <CAMuHMdVMOo2R2ehuU9XiVy0NS9J=mJkx0Mo-rsT=OBs-1kvH=Q@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Thu, Apr 4, 2019 at 10:55 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 20 Mar 2019 at 11:39, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > If a device is part of the wake-up path, it should indicate this by
> > setting its power.wakeup_path field.  This allows the genpd core code to
> > keep the device enabled during system suspend when needed.
> >
> > As regulators powering devices are not handled by genpd, the driver
> > handles these itself, and thus must skip regulator control when the
> > device is part of the wake-up path.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Note that I don't really need this on the Renesas Ebisu-4D board, as
> > there is no regulator or PM Domain controlling power to the GPIO
> > expander on that board.  I did want to have all wake-up path processing
> > implemented in the driver for completeness, and did test its behavior
> > with gpio-keys configured as a wake-up source.
>
> All above makes perfect sense to me.

> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

> > However, while this approach is known to work fine on other boards, with
> > other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
> > irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
> > device suspend ordering.
> >
> > The proper ordering is:
> >   1. When gpio-keys is suspended, its suspend handler calls
> >      enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
> >      pca953x_chip.wakeup_path to be incremented,
> >   2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
> >      and marks the device to be part of the wake-up path.
>
> Right.
>
> >
> > However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
> > scheme :-(
>
> Would it make sense to fixup the ordering issue via creating a
> parent/child relationship or setting up a device link?

Could that be due to gpio_keys not having rudimentary Runtime PM support?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
