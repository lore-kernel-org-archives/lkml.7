Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13680C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD80F206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="deaX2weZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfGXI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:26:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41838 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGXI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:26:21 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so83614380ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0rTt0PWs8SlpFEmIlcfrWeoOuNH1aWKTFUUCUoidq3I=;
        b=deaX2weZdsR6CofrHgiWHgzvTlM6h0FNL2PCIdFa3ZeR+qEBKz/x2vejPlXRHVbmMl
         JcIU64QqYqXdMxbvfzRnMtxCpqigpmmONPmag0B3S94ydkRIBrNpe+pn6g1aMLWZubZ6
         UTzvInvq4w6iEOuIXPRd561yuPuJSvUrs266ftIc1nWLg3ThVkDpL/f+JQCyW061otPx
         iMDnLvksu7iT66jS8dBgADOsTBJhFtV7c5959cGfsIwCrCTAUGbyH+sqfbEEaX/g7W9P
         LzHLbNF3ottZFcV9EwyxFemoIAjtlIYkP3wQJVnx/oskfEntjJZYTsB3vBBLbKrJ4T5I
         5YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0rTt0PWs8SlpFEmIlcfrWeoOuNH1aWKTFUUCUoidq3I=;
        b=BzzRTResusRlERhU4EPqUHk3P0UDwUrQCJqOPv242+hf7fv+rFQzIPJQBC8osEKEKM
         yun+mA1h4z0VA/mfSCpfBzUy3Fa6QtZB3igo/W8FdsikuE+YgD4fqUSvOvQwGo95jw05
         5dMAl6XO38T5xSkP7ih6TRREjeqJIe4HX2ZhCrWTzAhgDDG7dYY5DwvimLg+J4rgNQVs
         Qpn25wPuBArmz7/Vpt0BTggNKacv+SHOyXnu3W0Ma/TVyb6rgLs7NKUKfkYhARE98SaD
         a492vqLqgIkF4sTIcF0+s3o35yPdFRSnfX63rQ7TJoj6WnHSbpZ1criYi+vymij8wzuJ
         vhqg==
X-Gm-Message-State: APjAAAUtpMKbh/Q6iAYK05YzrA0ww4eILzXqQ4PG6PL0g3aezaAOJjKM
        i6iFQc0/UvIP8HKCfsTMd2vaO0FxolVqHSnSMWY=
X-Google-Smtp-Source: APXvYqzLUytR+h+JqxzA0jh/OfN1pkCtT3uoRs01qtgiGnfU4aT24rqrogERbdvlD5vcFQubZ9LAL7ZCQLkdsMP8f5A=
X-Received: by 2002:a5d:80c3:: with SMTP id h3mr67287206ior.167.1563956780894;
 Wed, 24 Jul 2019 01:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190722150302.29526-1-brgl@bgdev.pl> <20190722150302.29526-8-brgl@bgdev.pl>
 <20190722160908.GZ9224@smile.fi.intel.com> <CAMRc=McGTk+i0SzWN7AvGu3deYbXX_rJX=7+dKRpKFPKM_qxDA@mail.gmail.com>
 <20190723153426.GL9224@smile.fi.intel.com>
In-Reply-To: <20190723153426.GL9224@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 24 Jul 2019 10:26:10 +0200
Message-ID: <CAMRc=MfbSUAoEeD-KhmiV57dT2mcQTftLjNbdnFYJ59e6X5QDQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] backlight: gpio: use a helper variable for &pdev->dev
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 lip 2019 o 17:34 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Tue, Jul 23, 2019 at 08:29:52AM +0200, Bartosz Golaszewski wrote:
> > pon., 22 lip 2019 o 18:09 Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
> > >
> > > On Mon, Jul 22, 2019 at 05:03:02PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Instead of dereferencing pdev each time, use a helper variable for
> > > > the associated device pointer.
> > >
> > > >  static int gpio_backlight_probe(struct platform_device *pdev)
> > > >  {
> > > > -     struct gpio_backlight_platform_data *pdata =3D
> > > > -             dev_get_platdata(&pdev->dev);
> > > > +     struct gpio_backlight_platform_data *pdata;
> > > >       struct backlight_properties props;
> > > >       struct backlight_device *bl;
> > > >       struct gpio_backlight *gbl;
> > > >       enum gpiod_flags flags;
> > > > +     struct device *dev;
> > >
> > > Can't we do
> > >
> > >         struct device dev =3D &pdev->dev;
> > >         struct gpio_backlight_platform_data *pdata =3D dev_get_platda=
ta(dev);
> > >
> > > ? It fits 80 nicely.
> > >
> >
> > IMO it's more readable like that with the reverse christmas tree layout=
.
>
> It makes more churn in the original code and for initializers the order i=
s
> defined by its nature.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Fair enough, I changed it in v3.

Bart
