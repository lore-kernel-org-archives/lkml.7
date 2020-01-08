Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1095C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51D620692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nCfrnqH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgAHQzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:55:52 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42887 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgAHQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:55:51 -0500
Received: by mail-il1-f195.google.com with SMTP id t2so3205574ilq.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1otWToj29hMezV4JMaks8PqTBWepruh9XfV6M8TCvsU=;
        b=nCfrnqH2TuHcWKw+gqbTFlRBtsM+1gJEXink7mJuJk0nmvtdrlFU+U/tbWkZz5lvA4
         dh07Owg6buNjoKYNVnWOh06dY6tSCJ4FFXsMQS5xM9fY2YoZ2K8d4h0vrrk0rcKiCjDg
         /zt7j1NoX9mNE6LKBm9rZQ0cWua+UdPI9ESaC/HRaqDM0l6Oc7Jd7kZNsC2BTgIRDFI4
         iA+z4DrmdMyAUoIUh+NMcZ7KO4KtcZOSpubVyY/xr4AyYShePoXKrSYY/MMd1F7z27bq
         Le9Q386olO/iPiTVvMnoWZWycMdtNI3ctdhfn+o2XKbjArzyeUB3Ou9iSd1gYdLdJO2v
         M4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1otWToj29hMezV4JMaks8PqTBWepruh9XfV6M8TCvsU=;
        b=M7AznN+QchcvLHXk5AVnmaukgVhrD8lUZHU2Rg57uVJuRXmutPm2oRnVSw134UonMi
         4wlDgl099q/Mdmr2dNC88oZ/6UHyvpesVwdLqsI4Lr1NQUHx5DOV0Jo8PlsJT3wggWJu
         UX1+ompCf+hOxEUy5A8MKbxy6sTObIftK4vsdBzlsqxqT6T38cHtIlabUD75QihAliw/
         yLYnxpJCFDvo+zDR8PXFAd5XWmsvRff+dSHjehxgNKotbD6CiXC87qN91959jQLmUKsM
         SEVMvghlmfrqibgojf2zkfDVgyjCCzNm5i0Jix+A7M3dGrPfzRDBkyqg+ybPElttv+Lp
         3A2w==
X-Gm-Message-State: APjAAAXhDgJ+NpFIjURzqOLQrrDviWwi1Nuzgw9uafgxx+W+Zv7ww7TC
        CpM5gdmydIfN3Oz06lN3pTKCEUgpaQIjWwoBRndpFg==
X-Google-Smtp-Source: APXvYqwXzt3Dr3coz5H6HOpE5yRjd+aaGYWdxOg2BItU2UZbx7shuxzvTAuTgRpxCkvnNo27mF+acMycT/1lh7iRvtU=
X-Received: by 2002:a92:8712:: with SMTP id m18mr4760361ild.40.1578502550789;
 Wed, 08 Jan 2020 08:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <20191224120709.18247-13-brgl@bgdev.pl>
 <20200108124650.GR32742@smile.fi.intel.com>
In-Reply-To: <20200108124650.GR32742@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Jan 2020 17:55:39 +0100
Message-ID: <CAMRc=McbH7be7Y1SDO3UtSSOgYiDnHde1Au2yhsJxMcviDiJGQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] gpiolib: add new ioctl() for monitoring changes
 in line info
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 8 sty 2020 o 13:46 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Tue, Dec 24, 2019 at 01:07:08PM +0100, Bartosz Golaszewski wrote:
> ...
>
> > -     } else if (cmd =3D=3D GPIO_GET_LINEINFO_IOCTL) {
> > +     } else if (cmd =3D=3D GPIO_GET_LINEINFO_IOCTL ||
> > +                cmd =3D=3D GPIO_GET_LINEINFO_WATCH_IOCTL) {
>
> What about to split the functionality to something like lineinfo_get() an=
d...
>
> >               struct gpioline_info lineinfo;
>
> > -             struct gpio_desc *desc;
>
> Hmm... Is it correct patch for this change?

Yes, because instead of declaring *desc in every branch, we declare it
once and use it twice.

>
> >
> >               if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
> >                       return -EFAULT;
> > @@ -1246,11 +1260,25 @@ static long gpio_ioctl(struct file *filp, unsig=
ned int cmd, unsigned long arg)
> >
> >               if (copy_to_user(ip, &lineinfo, sizeof(lineinfo)))
> >                       return -EFAULT;
> > +
> > +             if (cmd =3D=3D GPIO_GET_LINEINFO_WATCH_IOCTL)
> > +                     set_bit(desc_to_gpio(desc), priv->watched_lines);
> > +
>
> ...simple use
>
>         } else if (cmd =3D=3D GPIO_GET_LINEINFO_IOCTL) {
>                 return lineinfo_get();
>         } else if {cmd =3D=3D GPIO_GET_LINEINFO_WATCH_IOCTL) {
>                 ret =3D lineinfo_get()
>                 set_bit();
>                 return ret;
>         }
>
> ?

You still need to retrieve *desc outside of lineinfo_get(). I think
it's not worth the hassle.

Bart
