Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64810C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32211206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xE/k+Zm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLXMIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:08:54 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40474 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfLXMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:08:53 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so18967987iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kMEJ1g3awjiJois5IXlpJaY3/3SmKKn3MhVIUyIiwUc=;
        b=xE/k+Zm3ZFRXndkfMspOBt5kR1YvFrSN0e2ynu/Wmd5Vds0tGvSKoLQ568kSJzlK+9
         HM79XkYELPxySMdzErmPeFL+NY4dFv+zPRPCRw/alakoh4B9QoqXIHE79Awa475DyLqq
         nyQ8jHyCpVmjoQTFe+9AhGTec4hJUJI+seEwGF+Xa85edEgT3Gb8OP03MI8rSI8wwaGx
         RSYDy/qI4U0s/5cuRns5hsx4Be65/Lq53Sf3zVLf66C1l6K6oIVNA9zJgTASGFqua8ez
         abXcCTTESsZT+6aWnJPDOflcO8DcUXVO/O3w4H1fU4AjyM/D8jnVGheLVhrC0ytMjZPY
         xmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kMEJ1g3awjiJois5IXlpJaY3/3SmKKn3MhVIUyIiwUc=;
        b=WS0joAuyfI41es4AJ3+CsAss/CMutiHlolO0yR3DkldUhuVV/Uwm2iGG/jRklRO+Y5
         okkOcsGE7FgZmxQIU6w7nB/G/8HJy+EnrO+6TbaVqrb6Xu3jwfMx+SlOU5YuPXfUboXU
         5RO2jhEk1ZXIrcz34zqiy6MOTK3mtzmzknyiPo41BqkvWlw7oWxXss56UB2BX20NG4mY
         kDaTTkqcWp7UqcZWqOljUlcvfJZC357tsgrkAMwrLeG+nMNJVuNBh9iWPKqlW2wyzatx
         XQmvHo0bjeGhF/F+qzdO45NEQnvHI+acw8/mJkXiPWGxbVSyUHrAPYAbGZbRQVXqPNWf
         CV4g==
X-Gm-Message-State: APjAAAX53U5M42QfaPWmQGrromslvtjs8C2cyckGMtcFrWW9/qCD+CnF
        MZWHN1jnS4POxJ1d1Df+a/wB6ZlBSEQpxkaGydPrCQ==
X-Google-Smtp-Source: APXvYqxS+n0uInOSHMsGQsOz7Vzo/DR0J0T9yDlisU6t8kWtggEJGnzpV5dEMdZJxeAAxYkBedY3EBh4JBiwBUrJ13o=
X-Received: by 2002:a02:40e:: with SMTP id 14mr27133228jab.102.1577189332324;
 Tue, 24 Dec 2019 04:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20191219171528.6348-1-brgl@bgdev.pl> <20191219171528.6348-13-brgl@bgdev.pl>
 <CAHp75VeMEngXiFmvTrsW7UZMz0ppR-W-J4D1xU+qKGfLXkG3kg@mail.gmail.com>
In-Reply-To: <CAHp75VeMEngXiFmvTrsW7UZMz0ppR-W-J4D1xU+qKGfLXkG3kg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 24 Dec 2019 13:08:41 +0100
Message-ID: <CAMRc=MdCQkooyMLH8E2uX8+gT7h8VsXnvv0oXvCstb=vjHJ8WA@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] gpiolib: add new ioctl() for monitoring changes
 in line info
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

czw., 19 gru 2019 o 19:17 Andy Shevchenko <andy.shevchenko@gmail.com>
napisa=C5=82(a):
>
> On Thu, Dec 19, 2019 at 7:17 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Currently there is no way for user-space to be informed about changes
> > in status of GPIO lines e.g. when someone else requests the line or its
> > config changes. We can only periodically re-read the line-info. This
> > is fine for simple one-off user-space tools, but any daemon that provid=
es
> > a centralized access to GPIO chips would benefit hugely from an event
> > driven line info synchronization.
> >
> > This patch adds a new ioctl() that allows user-space processes to reuse
> > the file descriptor associated with the character device for watching
> > any changes in line properties. Every such event contains the updated
> > line information.
> >
> > Currently the events are generated on three types of status changes: wh=
en
> > a line is requested, when it's released and when its config is changed.
> > The first two are self-explanatory. For the third one: this will only
> > happen when another user-space process calls the new SET_CONFIG ioctl()
> > as any changes that can happen from within the kernel (i.e.
> > set_transitory() or set_debounce()) are of no interest to user-space.
>
> > -       } else if (cmd =3D=3D GPIO_GET_LINEINFO_IOCTL) {
> > +       } else if (cmd =3D=3D GPIO_GET_LINEINFO_IOCTL ||
> > +                  cmd =3D=3D GPIO_GET_LINEINFO_WATCH_IOCTL) {
>
> Wouldn't be better for maintenance to have them separated from the day 1?
>

I think this would lead to a lot of code duplication. I left it as it is is=
 v4.

Bart
