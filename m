Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF4B2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 22:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TK2iPDXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfIOWoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 18:44:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32902 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIOWoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 18:44:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id e18so2584053oii.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKM6gHoedLrvZgJ8kEn4vmhTxoHEnXDQxH5PzzFF4Gk=;
        b=TK2iPDXQcdLGu7lygBUbi0NGhaopTNO3UgNu9A3ClnbwebllyrhrwuOZLZgJnDcEZd
         YnDPfM3wT1yjcoDjx+ItTXw4Hl2mEcug7zoBlrEz2K/WTqvijC5ip7c0DWT+8mGd66sB
         F5s4r+kPS304lZDKuTkvemZuKM1IOnxaA5pbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKM6gHoedLrvZgJ8kEn4vmhTxoHEnXDQxH5PzzFF4Gk=;
        b=YLX3EFy794Sru3KkhxzhRlYhYip2yrWnMdytGSqd4pt1ojgfSzgL08QQV4je0AiPX+
         dO5c7WiTjah65U4wVT7pfAsEK0I1TNi3XKtyYkbENFZCQ39qDrr3bsZrEYnHxKGVA4Bb
         QUXCAJ2ju6tuKH82lOVOw0tibpJLXMTSnw/HNibcbsgX+yB2y+WtZHnhzBmY7AUiQAoX
         xdh6t0S9DODGVFwxEAcp82N/Km4PiJD/g230V4U+ITCunnmVG/RwF0O+jpMhWK6n4m6L
         RC4JdpSE7pRCnnprvgJT0dXWNbp+4gLu9ew0BEUTWiALL3yd7BCgz979akl7i+xwZh89
         2d9w==
X-Gm-Message-State: APjAAAUPhOIEsD9vG9fxiwG7Z/ShvMCLwfhCXoZ0hso/U0Fp63uVhegL
        5oiZyOt4zj/IZEhRsePS1kov4DNINYU=
X-Google-Smtp-Source: APXvYqz6Uki3QQJ2KvcU+OmNFcb1n6KxEIvwJNxTFL2KEB4hbg63QMDV814E3hD9SErnpC1YkjYFfg==
X-Received: by 2002:aca:c38b:: with SMTP id t133mr11222153oif.22.1568587455675;
        Sun, 15 Sep 2019 15:44:15 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id 5sm2919209otp.20.2019.09.15.15.44.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 15:44:14 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 12so6858212oiq.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 15:44:14 -0700 (PDT)
X-Received: by 2002:aca:4794:: with SMTP id u142mr11893250oia.49.1568587453749;
 Sun, 15 Sep 2019 15:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151929.780-1-ncrews@chromium.org> <20190912080953.GO21254@piout.net>
In-Reply-To: <20190912080953.GO21254@piout.net>
From:   Nick Crews <ncrews@chromium.org>
Date:   Sun, 15 Sep 2019 23:44:03 +0100
X-Gmail-Original-Message-ID: <CAHX4x87M6opd5Ob_TRwCQ3mYgeFaV55DYiTYccM2cNX2nD3oYA@mail.gmail.com>
Message-ID: <CAHX4x87M6opd5Ob_TRwCQ3mYgeFaV55DYiTYccM2cNX2nD3oYA@mail.gmail.com>
Subject: Re: [PATCH] rtc: wilco-ec: Sanitize values received from RTC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre, thanks for the thoughts.

On Thu, Sep 12, 2019 at 9:09 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi Nick,
>
> On 10/09/2019 16:19:29+0100, Nick Crews wrote:
> > Check that the time received from the RTC HW is valid,
> > otherwise the computation of rtc_year_days() in the next
> > line could, and sometimes does, crash the kernel.
> >
> > While we're at it, fix the license to plain "GPL".
> >
> > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > ---
> >  drivers/rtc/rtc-wilco-ec.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > index 8ad4c4e6d557..0ccbf2dce832 100644
> > --- a/drivers/rtc/rtc-wilco-ec.c
> > +++ b/drivers/rtc/rtc-wilco-ec.c
> > @@ -110,8 +110,16 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> >       tm->tm_mday     = rtc.day;
> >       tm->tm_mon      = rtc.month - 1;
> >       tm->tm_year     = rtc.year + (rtc.century * 100) - 1900;
> > -     tm->tm_yday     = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
>
> If your driver doesn't care about yday, userspace doesn't either. You
> can simply not set it.

This driver indeed does not care about yday, so it sounds good to me
to simply not set it. However, I do still want to worry about the HW
returning some bogus time. It could be indicative of some other problem,
and I don't want to pass on this illegal time further up the stack. I can't
think of a reason why an illegal time should exist at all, we should just
deal with it as soon as possible. How about I remove setting yday as
you suggest, but still keep the rtc_valid_tm() check?

>
> >
> > +     if (rtc_valid_tm(tm)) {
> > +             dev_warn(dev,
> > +                      "Time computed from EC RTC is invalid: sec=%d, min=%d, hour=%d, mday=%d, mon=%d, year=%d",
> > +                      tm->tm_sec, tm->tm_min, tm->tm_hour, tm->mday,
> > +                      tm->mon, tm->year);
> > +             return -EIO;
> > +     }
> > +
> > +     tm->tm_yday = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> >       /* Don't compute day of week, we don't need it. */
> >       tm->tm_wday = -1;

Following our discussion, perhaps I'll just remove this too since the
RTC core inits this to -1 already?

> >
> > @@ -188,5 +196,5 @@ module_platform_driver(wilco_ec_rtc_driver);
> >
> >  MODULE_ALIAS("platform:rtc-wilco-ec");
> >  MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> > -MODULE_LICENSE("GPL v2");
> > +MODULE_LICENSE("GPL");
>
> This should be in a separate patch.

OK, I'll separate this out :)

>
> >  MODULE_DESCRIPTION("Wilco EC RTC driver");
> > --
> > 2.11.0
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
