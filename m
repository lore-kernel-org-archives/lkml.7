Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479C8C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB8B224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GdP1Dayr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfLEJbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:31:33 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40433 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfLEJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:31:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so2000147oto.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aHb1VO0xR+IPYYvVFCIzNRZ9emff31Jj/WMc/RTpBkM=;
        b=GdP1Dayrp1byZDNq+kDIEblYRD+qV/omiAYqmUcsazuy2zrOpTmK7+HcD2PMqTEB+Q
         vOjQ1QisF0vLwIIaKBQ0HMJzt1YVjvUNF9a2FedoljZGIrkdxC6srjB2aQ+vivJktyfK
         c8osz+HLeJs4OXv8IlknXvbGguyE7Risz/VDmUGe5cqgYGRlUMDmMLIIBW8WUunpnZHC
         eizhEpchE/6f+E9dMdaeSlsJV5F0E181kpJkyXk+nOGjFyOcNdtWvkuUNylHP9FfJqo2
         4rACwT82dEONNo7Pv9gQ0IL1Vk8OeOa+2nEulr13vDC8vuDBuAwEsF5Z2Gg9ndN5nHK8
         xH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aHb1VO0xR+IPYYvVFCIzNRZ9emff31Jj/WMc/RTpBkM=;
        b=WjAGzuwcXcsqGySRe6dfy2xeqUJ9Fpyb2QXZxdmoIRrFYcSWx1DkD3ZRyhmloCKtNE
         feY48LrsXpUcyqWed/vINnl6Sso9dg8Jms4CnBPMfYu2xpWHzbMAn+xJFSF+LATYInFy
         AYRTc14vczUCZo6q4e+i2DLi0F5xVaOmEfnLCIWhVwZ3Hmxm1lOoHrCmZ0kouGqDFUaT
         T9cr+ghYltsAxYrOaTw+BusOJgVFdTxzFXaCFSrDvKsYQwU1/Uq2qOjaDaFKaWh0owqG
         oGL53wvWavLsXErxcJ8Ltu5Fz0+m8XDJJMCU5LTDvkCPDo8EaMkv2d9Xm4o47EIAuUNe
         bcjw==
X-Gm-Message-State: APjAAAU3ksKH2VAPs1fMGX6tC2CbrHfbPohebLINBOVZTaDSNUrphPWz
        oQtGmshHWgnnOBPiFnWBnKMzWAhSNwLMUYXbEsQJpg==
X-Google-Smtp-Source: APXvYqxCuGWGi2Hd2SmDjfz4WH1x3LVcPWIqAX0xS0+w6ZIHEPKA3anyw8EIKh3cHHTODSHuJcezTbvjiYilTDgRMPU=
X-Received: by 2002:a9d:27c4:: with SMTP id c62mr6001704otb.292.1575538291595;
 Thu, 05 Dec 2019 01:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20191204155912.17590-1-brgl@bgdev.pl> <20191204155912.17590-8-brgl@bgdev.pl>
 <CAHp75Vf7+XY8rnrbMfMgNO25EHSemjZVUgvFFp+zvj4vvJ1B8g@mail.gmail.com>
In-Reply-To: <CAHp75Vf7+XY8rnrbMfMgNO25EHSemjZVUgvFFp+zvj4vvJ1B8g@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Dec 2019 10:31:20 +0100
Message-ID: <CAMpxmJU-X3JiVZ2+fVq5Y6jipJUkhVSMUyJjFnmjdkny0LRO9Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] gpiolib: rework the locking mechanism for
 lineevent kfifo
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 4 gru 2019 o 23:25 Andy Shevchenko <andy.shevchenko@gmail.com> na=
pisa=C5=82(a):
>
> On Wed, Dec 4, 2019 at 6:01 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The read_lock mutex is supposed to prevent collisions between reading
> > and writing to the line event kfifo but it's actually only taken when
> > the events are being read from it.
> >
> > Drop the mutex entirely and reuse the spinlock made available to us in
> > the waitqueue struct. Take the lock whenever the fifo is modified or
> > inspected. Drop the call to kfifo_to_user() and instead first extract
> > the new element from kfifo when the lock is taken and only then pass
> > it on to the user after the spinlock is released.
> >
>
> My comments below.
>
> > +       spin_lock(&le->wait.lock);
> >         if (!kfifo_is_empty(&le->events))
> >                 events =3D EPOLLIN | EPOLLRDNORM;
> > +       spin_unlock(&le->wait.lock);
>
> Sound like a candidate to have kfifo_is_empty_spinlocked().

Yeah, I noticed but I thought I'd just add it later separately - it's
always easier to merge self-contained series.

>
>
> >         struct lineevent_state *le =3D filep->private_data;
> > -       unsigned int copied;
> > +       struct gpioevent_data event;
> >         int ret;
>
> > +       if (count < sizeof(event))
> >                 return -EINVAL;
>
> This still has an issue with compatible syscalls. See patch I have
> sent recently.
> I dunno how you see is the better way: a) apply mine and rebase your
> series, or b) otherwise.
> I can do b) if you think it shouldn't be backported.
>

Looking at your patch it seems to me it's best to rebase yours on top
of this one - where I simply do copy_to_user() we can add a special
case for 32-bit user-space. I can try to do this myself for v3 if you
agree.

Bart

> Btw, either way we have a benifits for the following one (I see you
> drop kfifo_to_user() and add event variable on stack).
>
> > +       return sizeof(event);
>
> Also see comments in my patch regarding the event handling.
>
> --
> With Best Regards,
> Andy Shevchenko
