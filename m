Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0FBC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5DE206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIYv+W/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfDDPqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:46:52 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36518 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfDDPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:46:51 -0400
Received: by mail-vs1-f67.google.com with SMTP id n4so1655531vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8gRJMICwdjjPmJZUtaM6oeLwi+MaWpqWKTPDjj9cBk=;
        b=TIYv+W/Cr5WxbCAVkhpQmaC8TbZRy6Cwrvf73Yfnhe1ZXyiTVyhFf1mf5xMr52eWwm
         WZ569nx2iR1l4iT+rrdi7QNsxF2sH0v79ew2+yDe3oOLYtmeLg+WB9bm/bsQE391aD/5
         EYWL3jfROrXFeL5z+wKD8LeEOpq6TD82uS4MX9VnPmO09neJExkOSxCttkaGO1SZ4QMH
         1lnRncEy3suDD94CMbOyNrFu21iW8Oi9kMgG6TIjawl643fPb7+iQ0ilNCadYzXqveOr
         ys2Ry/29QbocJYVgF1j0DcZvy8evCoywnnZOyfuL2decqM4v+Lsx0B9loTwIeUxhmdNQ
         UDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8gRJMICwdjjPmJZUtaM6oeLwi+MaWpqWKTPDjj9cBk=;
        b=aFlCXXYoke7qiPNy69fccv80mkY62fFTuDPRWgHxFK74PlNpQ45Z8nx06f5Fd1UwrT
         sX1UfWZBLF9DSgyM9chwbGUlfkabhbKLrrOF11wpuNRIoAdV4XafoP/asc3bS/sG3m06
         cyE2gd+A6IxLEGHXJBhzSh4StoSt09sm81jsvdGYe+jG4Y/TMhGInn8Wjjs9Ha4EYrhj
         8FQYUEp5kDrGBDjQhihHjByj7eU2icQF88Zxbx+z6lfquWjDrsioTZqK4QyVrZ9JJZS9
         D/+P8qMAcJSYQe0WXBRiA5DTd4kqQ2dvhOioP55/P6FqepYp0RVm7sJtZtmEswI/ISUl
         aprA==
X-Gm-Message-State: APjAAAWT7UlFY3sgbPscEue3ycgQMnD7tTTwl/BBuCP7aNXbTbqoMvDO
        qGazgGFvRTEUWcMN18HmA6Fjpdkow5pD9BABnC9Wlw==
X-Google-Smtp-Source: APXvYqyaRHK6lx55S4vEPKZOn2d60BlUiMZP7R7Pbd9UFoFnRM9erRJJeP8gELrZo5r/MoqO6zoCHL7tazU0a8fx4q4=
X-Received: by 2002:a67:2e8c:: with SMTP id u134mr4562798vsu.57.1554392810775;
 Thu, 04 Apr 2019 08:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190320103927.21227-1-geert+renesas@glider.be>
 <CAPDyKFpecPdcqagc567kZJeWbe6y_0j9JAVKcE6c9Ltv+OG-Yw@mail.gmail.com> <CAMuHMdVMOo2R2ehuU9XiVy0NS9J=mJkx0Mo-rsT=OBs-1kvH=Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVMOo2R2ehuU9XiVy0NS9J=mJkx0Mo-rsT=OBs-1kvH=Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Apr 2019 17:46:14 +0200
Message-ID: <CAPDyKFr7hu+ELfDSgQ+E3D=eNJR_8iJMPSobLpKDJ0Tgw=27vQ@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

[...]

> > > However, while this approach is known to work fine on other boards, with
> > > other GPIO and interrupt controllers (gpio-rcar, irq-renesas-irqc,
> > > irq-renesas-intc-irqpin), it wouldn't work on Ebisu-4D, due to different
> > > device suspend ordering.
> > >
> > > The proper ordering is:
> > >   1. When gpio-keys is suspended, its suspend handler calls
> > >      enable_irq_wake(), invoking pca953x_irq_set_wake(), and causing
> > >      pca953x_chip.wakeup_path to be incremented,
> > >   2. When gpio-pca953x is suspended, it checks pca953x_chip.wakeup_path,
> > >      and marks the device to be part of the wake-up path.
> >
> > Right.
> >
> > >
> > > However, gpio-keys is suspended _after_ gpio-pca953x, breaking the
> > > scheme :-(
> >
> > Would it make sense to fixup the ordering issue via creating a
> > parent/child relationship or setting up a device link?
>
> Could that be due to gpio_keys not having rudimentary Runtime PM support?

You are saying that the parent/child relation ship is already there?

In such case, it shouldn't matter whether runtime PM is deployed or
not, the PM core should propagate the wakeup_path flag from children
to parents in __device_suspend() and in device_suspend_late(). If that
doesn't happen there is bug in the PM core.

Kind regards
Uffe
