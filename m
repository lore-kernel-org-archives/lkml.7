Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B3CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3BD20828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BUMTIuQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfH1K4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:56:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33799 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1K4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:56:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id c7so2328438otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9nBDIm2N1o53yUHNgHlni3PU6OkH5zkDsyDdUf/2oVk=;
        b=BUMTIuQPT4mnrt196mfGejjgRmHSZoT05FuKeAxQp9JStqUFVI2cEDFgxC93bWptk0
         mYMKz9bxEUKtrIbTgU1wlT3W5YGAOEnvVGHht9L/4jugtGrqk7yHpV8jFtxV+V90O+um
         /H5YHEjPVI91os5xEofC/w51XzKgVSynB6t0WGQbyjwFqedBu1lnnQlw8HQiW4LaXWxi
         NIpanUcOVC3DkhxmoTFRSasS4UR4482qgff6tXmEXUNTxQyI5p+Pimlr3yVg45yxjZIl
         xPqZHIhF22HJXKOGJ44FdPfwF+j6y+nBXCtVJLfIj68NptVx2I0+zHOrHm4vqquq8Ktb
         WIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9nBDIm2N1o53yUHNgHlni3PU6OkH5zkDsyDdUf/2oVk=;
        b=nHEZW47dmoDvibFmedSmXi86fSAZQwA2n9T220gu0bezh9vITOS7LPf2v9CFPX3yyz
         zb+nLITHxZiO6gW5q7QYd44b9S7nNRC5eDAnXhJuvqIFlZti0T4PnJCKly5ub5S7DU9Z
         L9ba/oa6HYY5aSeGATau0HYICutBUEzIwklyfpNGRG22OJZ4ciIfoRDtAK+yUP5J/VTl
         BBdZ1KtnbQ5yUW0ximp3ApT9QK6OLn800M1eRapGxAY+58sN7m5daEJ+LIL6m7k4KM/2
         9gdsvHrErha7B3FdB7Z2NlmSde4Dlg2BKjcIiQ5Sayp+UHhPL1l4unCGpbMfTvPqStcA
         tVaA==
X-Gm-Message-State: APjAAAV5i3NlaIhK26HNc/QOXsY0Q39CvxUP6q8CLwusLIwMiWRS6lKu
        Qq27PhC49e83ypxA7sgLk5EJ3O3rSD1oeKVqZShQbQ==
X-Google-Smtp-Source: APXvYqwbHxw64sX7kxlc9Y4MID92CqSaT+i8SQ6bQ48Si4zn2Rjk+DXtFquo2zpnX5NMjvYXztu9wY8XqKYajTOkN+M=
X-Received: by 2002:a9d:6290:: with SMTP id x16mr2722950otk.292.1566989799465;
 Wed, 28 Aug 2019 03:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190827064629.90214-1-david@protonic.nl> <CAMpxmJV2XC+CK1SfJnH2YuaD2Gh=fiBQY+WPbjnqkvxGW6ZH_w@mail.gmail.com>
In-Reply-To: <CAMpxmJV2XC+CK1SfJnH2YuaD2Gh=fiBQY+WPbjnqkvxGW6ZH_w@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 28 Aug 2019 12:56:28 +0200
Message-ID: <CAMpxmJXQ=M9PeMFBf70aE5Jgg3c6P2=4QF5CxWpenh+2WXLhnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-pca953x.c: Correct type of reg_direction
To:     David Jander <david@protonic.nl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 28 sie 2019 o 10:38 Bartosz Golaszewski
<bgolaszewski@baylibre.com> napisa=C5=82(a):
>
> wt., 27 sie 2019 o 08:46 David Jander <david@protonic.nl> napisa=C5=82(a)=
:
> >
> > The type of reg_direction needs to match the type of the regmap, which =
is
> > u8.
> >
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  drivers/gpio/gpio-pca953x.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> > index 378b206d2dc9..30072a570bc2 100644
> > --- a/drivers/gpio/gpio-pca953x.c
> > +++ b/drivers/gpio/gpio-pca953x.c
> > @@ -604,7 +604,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_=
data *d)
> >         u8 new_irqs;
> >         int level, i;
> >         u8 invert_irq_mask[MAX_BANK];
> > -       int reg_direction[MAX_BANK];
> > +       u8 reg_direction[MAX_BANK];
> >
> >         regmap_bulk_read(chip->regmap, chip->regs->direction, reg_direc=
tion,
> >                          NBANK(chip));
> > @@ -679,7 +679,7 @@ static bool pca953x_irq_pending(struct pca953x_chip=
 *chip, u8 *pending)
> >         bool pending_seen =3D false;
> >         bool trigger_seen =3D false;
> >         u8 trigger[MAX_BANK];
> > -       int reg_direction[MAX_BANK];
> > +       u8 reg_direction[MAX_BANK];
> >         int ret, i;
> >
> >         if (chip->driver_data & PCA_PCAL) {
> > @@ -768,7 +768,7 @@ static int pca953x_irq_setup(struct pca953x_chip *c=
hip,
> >  {
> >         struct i2c_client *client =3D chip->client;
> >         struct irq_chip *irq_chip =3D &chip->irq_chip;
> > -       int reg_direction[MAX_BANK];
> > +       u8 reg_direction[MAX_BANK];
> >         int ret, i;
> >
> >         if (!client->irq)
> > --
> > 2.19.1
> >
>
> Applied for v5.4.

Actually the second patch depends on the first one, so moved it over to fix=
es.

Bart

>
> Thanks!
> Bart
