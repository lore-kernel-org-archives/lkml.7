Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D3C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23362087F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5gvf/t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDGVqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:46:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46193 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGVqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:46:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so9421991ljk.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tt4h0HcSfIPpBua6kI5tfB/v3gS3Ph/COQYGEMLRKK8=;
        b=c5gvf/t7JfSRJp3sKmF530MyJQ7rjwBkjJManjXmqcyIj3SL2MVzlAhVk56Iagxaaq
         AkPpDpDaKDoCTZaNLfHKuSkEE6/aBbCrV7eeeW86OJ55ZmC30N2/eEQ9vVXhfc52PgDN
         ftRjOFDjqgQytcHh5n6H150Qz3rKypF02cWY9wm1ggnI6T41iqzXlYaW6pmal63+fEU/
         CCCRVanC8bGpfSQ3vvvj980UaWxIKL3J1y0tuj7xB4jsIQnJhFQrvzApRE/xnvMKkjAs
         MyHT/N543CDYzflUAuQ/tv5kZSXC0QqKruQt4vE+9nKFXbT5etqDtd+jav4OGWJDOMQA
         yYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tt4h0HcSfIPpBua6kI5tfB/v3gS3Ph/COQYGEMLRKK8=;
        b=q5BJ+iicD1/7DcZjavnSDFmWjH7vq1gY8F1cUOkxEdM5ATvgCFok1sdFnTcbuIIigX
         FQtDP5l8NKg066RnkrYYXGLXo63dC910Yvhqw1b8ijlkR28ZLNKfnhBz5v4/Z8KFcpLd
         DKpg+WG9+1Hn/M9fx2Unh3DoIzomEyf3PTjbqmGOEuHLvytGgF/Z/D0x4sS/ttKaq8uN
         0ZCBq7ioYXFBn1WDp+UMbl1usd1mHIi4dNfUzO90YaoU6Eg+s/+hF+qhvJzM6rDoM3K2
         LE3zzhnGtuOMZX5cdkts5Dn2mWk/YGt8CofDQG4XUlVJPYdX8nb56hbftJ/qgM3LVOa4
         vYNw==
X-Gm-Message-State: APjAAAU21vOqoO5e46HemVLyWdc20eMCszNDu9O8e/KO/q0mAYuxm9kE
        +qisNbmSlrx9LDj1e+0tDp42V5We0vvTrXGJ+73S2w==
X-Google-Smtp-Source: APXvYqzSbXBGcIaB1Kvv+f3juI6esTRMR/xcXn9le6V85uN12KfVQvfPTBNWqkh+HGPtxVtoXLu5dHTVH/RPtckcYK4=
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr11143388ljc.126.1554673599589;
 Sun, 07 Apr 2019 14:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-2-ncrews@chromium.org>
 <20190405201534.GA4426@roeck-us.net> <20190406084157.GA27043@amd>
In-Reply-To: <20190406084157.GA27043@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Sun, 7 Apr 2019 14:46:28 -0700
Message-ID: <CAE_wzQ9WG1+K1ZzVoii8ukDe_g+4Ha0bh6YvsRhceinwPjC+Kw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Nick Crews <ncrews@chromium.org>, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, sjg@google.com,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 1:41 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2019-04-05 13:15:34, Guenter Roeck wrote:
> > On Thu, Apr 04, 2019 at 11:10:08AM -0600, Nick Crews wrote:
> > > The EC is in charge of controlling the keyboard backlight on
> > > the Wilco platform. We expose a standard LED class device at
> > > /sys/class/leds/platform::kbd_backlight. This driver is modeled
> > > after the standard Chrome OS keyboard backlight driver at
> > > drivers/platform/chrome/cros_kbd_led_backlight.c
> > >
> > > Some Wilco devices do not support a keyboard backlight. This
> > > is checked via wilco_ec_keyboard_leds_exist() in the core driver,
> > > and a platform_device will only be registered by the core if
> > > a backlight is supported.
> > >
> > > After an EC reset the backlight could be in a non-PWM mode.
> > > Earlier in the boot sequence the BIOS should send a command to
> > > the EC to set the brightness, so things **should** be set up,
> > > but we double check in probe() as we query the initial brightness.
> > > If not set up, then set the brightness to 0.
> > >
> > > Since the EC will never change the backlight level of its own accord,
> > > we don't need to implement a brightness_get() method.
> > >
> > > v5 changes:
> > > -Rename the LED device to "platform::kbd_backlight", to
> > > denote that this is the built-in system keyboard.
> > >
> >
> > NACK.
>
> Please keep it as it is, it is okay.
>
> > Per Documentation/leds/leds-class.txt, LED devices are named
> >       "devicename:colour:function"
>
> You failed to follow threads explaining this is being changed, even
> when I pointed you at them. What you are doing here is not helpful.

Pavel, what I find is unhelpful is you requiring to conform to the new
rules that have not been accepted yet and for which there clearly are
objections. You keep ignoring all the issues that we continue to point
out with your proposed scheme.

I will go and try to reply to Jacek's thread, but it is my firm belief
that changing naming scheme is not what we need to do here.

>
> > This document also states "The naming scheme above leaves scope
> > for further attributes should they be needed". It does not permit,
> > however, to redefine one of the fields to mean "location", much less
> > the declaration that a devicename of "platform" shall refer to an
> > "internal" backlight, or that there shall be no more than one
> > "internal" backlight in a given system.
>
> "platform" is as good devicename as "wilco" or "chromeos".

No, because "platform" is not a device, it is something that you are
trying to assign a magic meaning to.

Thanks.

-- 
Dmitry
