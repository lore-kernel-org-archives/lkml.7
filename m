Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A390C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE2C2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MBnXWi3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfCZNth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:49:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36678 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbfCZNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:49:36 -0400
Received: by mail-io1-f66.google.com with SMTP id f6so10822302iop.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BbMzgIzQCfWFlXsfTKjvE5YFCQD6PlQb3XZXDhFLods=;
        b=MBnXWi3EFgJUfYY0NfW9JI9zwf0RmGdMiCf2iziNzx/8pvXU0xsWMfahqhZl1sqJLb
         aqQfrvZQggQjSBByeFyav0V+nj/g95aAWmRgMpMlNYpRRB7x5tjWrX5KMBJvFct6OqsZ
         k1qI+8SwX/QWvA1piaEp8gbNCf/Om5sOMFik3AH/3iR5J4rfdbqerZeMlhA4fwWxNWz2
         MZa5YsYJIK2lO/vDFxv2aosG3yCWZy36e5gseMwdKMX+OVJYYYOUZl5J5H6GNgD6yybv
         RwN8DU0TggMxQbaLh1tde+/VthGKrhCJmieSNxjnPFdPXC0DgczNn6YtbLOlre4jCWQC
         4Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BbMzgIzQCfWFlXsfTKjvE5YFCQD6PlQb3XZXDhFLods=;
        b=koi2rQb0QPknP5yecowv0eg1T7PBm+KL8jNeCOK7JzfBZaRVkdxLMK8XoI7LdBNduk
         rgtWi360ZBMldXEK89L8sUN47nSrixJkUjQmaqar29ea/XUJ+30pmgy8ZdRd+jlRQ6XN
         yv6EaIzlgS5Ecrpk7+KAjsTjhA3Vz7SoSzwbEuxV1uRjuciYk2inzYFxHt85AeXWN+nX
         i7ZYa0tZjgUimeAMrwuKCl95MxmI4XZ4Am2JLzHcADGnhS9aimiq/uZa6hRHR1n6kUod
         YtnEKF9aTTy28DdexByxWr2i5SEx1jMz8ZZAlaE4IE12eHryfT8Cufng9E9nQKB5FPt0
         Iy9w==
X-Gm-Message-State: APjAAAV/7bm9ly0d3e25dmxzDQRDiPBFSeTVAyAdiKKs2fZe4mFUeVQI
        68akvP6XQYFd/JIO/GmlU0Lg6GBV9PIe0/LcxmtvfeEx
X-Google-Smtp-Source: APXvYqyK8kulVJ2QGkqImXDk7FfdEcLLymLdmUxG/qvsquaryZoWLeZkfoWg3YLpmX4nTs7gHZFKuu8qWgRI4EtXxgo=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr21355533ior.258.1553608175458;
 Tue, 26 Mar 2019 06:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-7-brgl@bgdev.pl>
 <20190322091223.GI27015@amd>
In-Reply-To: <20190322091223.GI27015@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Mar 2019 14:49:24 +0100
Message-ID: <CAMRc=Me1BbZKPQyAt4RR1eRk9pX3oHFudpm1CnHx3-AuD-G5ug@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 06/11] mfd: max77650: new core mfd driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 22 mar 2019 o 10:12 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:42:23, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the core mfd driver for max77650 PMIC. We define five sub-devices
> > for which the drivers will be added in subsequent patches.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/mfd/Kconfig          |  14 +++
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/max77650.c       | 234 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/max77650.h |  59 +++++++++
> >  4 files changed, 308 insertions(+)
> >  create mode 100644 drivers/mfd/max77650.c
> >  create mode 100644 include/linux/mfd/max77650.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 0ce2d8dfc5f1..ade04e124aa0 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -733,6 +733,20 @@ config MFD_MAX77620
> >         provides common support for accessing the device; additional dr=
ivers
> >         must be enabled in order to use the functionality of the device=
.
> >
> > +config MFD_MAX77650
> > +     tristate "Maxim MAX77650/77651 PMIC Support"
> > +     depends on I2C
> > +     depends on OF || COMPILE_TEST
>
> This says it will compile ok in !OF case. Will it?
>

It will compile because the stubs for OF functions will be provided -
it just won't work, because they won't be implemented.

Bart

> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
