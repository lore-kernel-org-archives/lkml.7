Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87289C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEAE214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp8jo/Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCMMbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:31:36 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35501 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfCMMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:31:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id u128so1250884oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ulIB1WQv3rgTjsfOPfI4FyBCb55jcpj8cYazj22rUg=;
        b=Pp8jo/AmM5/+xRJ4rICNaNcDBtVfzUpuZnPEUYztGJW84YbjIZ9v25wYXllsBjWGrl
         9zO0sAR2kYgECiF713yrDqVVOwJSbfbNtqJS3iZqkU1b1n+fm+iCkemBUu540un41Wlk
         ALk+WxBRd01hfp/JK61KvyGv2tX2Q0otRNircxE4KLOkK7hNTpznYdp9LvC2csv3OOZj
         H2DXF5g/248zeCaGnjM4ySs7olDD/7s1qy3ekfhfWMw11v/3VdBfYQANLY4D36rIYPgy
         VdhIIVjaMKzzeIjHzmesK3gu+s5EvOG3Q1QZYai6aR0o6RpbZasKQgmXPAPhXubWy4Ha
         TXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ulIB1WQv3rgTjsfOPfI4FyBCb55jcpj8cYazj22rUg=;
        b=kuarKsWJKsrod3BhaI/iUIGa9Dv6vVrxwI8tXUkTHy1shrGZKpRrWzeBwKanJzyXbN
         iB97XalpTHVUydJWeEbcVrgthoJG5xRQlvnQPPXl2gX7rvRxMN7TUMe7Rotwd7cx9LrZ
         G/XOBjGFhVmv4ygUpFrVTgCX3mDuz6Y2DOOeMaOZSKSD/UxKXlq2HJhNH+fPHgRZh9sP
         +oEcSDmRWY89RMrdrtSzhJgPuRybc5r2pkECi6ORko1Ot8xxwOXJPFYam70iyd3U1mQn
         Q4lPMqbyNTzQ1olBaNgMBVAWrCQ7DdAUQOcgsiwecm26EmLQzNOguTYR2u4JJ+b2XpfC
         MlKA==
X-Gm-Message-State: APjAAAVZY4djEuBg8YO/L2lRs3/i5sVCMP60ByQcAW6So5HlSzoeJC4v
        8Gq3JtqviUnGICxhfhgOyqXDTuSisGz6gtakN/g=
X-Google-Smtp-Source: APXvYqxoVH9txwZZ18rOtF4Gv3dLQ02L7URWxud0h3SJQYKn3wDAh8loCF2gO6+4/Rd6U5UHVEVxHfmQR+OTptJivA4=
X-Received: by 2002:aca:d7c3:: with SMTP id o186mr1597452oig.28.1552480294149;
 Wed, 13 Mar 2019 05:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190313122403.248873-1-armax@google.com> <eb85ea17-babd-fe3a-f0ff-9c7f13498bd1@gmail.com>
In-Reply-To: <eb85ea17-babd-fe3a-f0ff-9c7f13498bd1@gmail.com>
From:   Armando Miraglia <arma2ff0@gmail.com>
Date:   Wed, 13 Mar 2019 13:31:23 +0100
Message-ID: <CAOcbMd2njzr8+6tLTh7k+1zq_VTkU3-fJYODzG0ZwoomO5F9ag@mail.gmail.com>
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in spi-mt7621.c
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Neil Brown <neil@brown.name>, Armando Miraglia <armax@google.com>,
        gregkh@linuxfoundation.org, sr@denx.de,
        Sankalp Negi <sankalpnegi2310@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That might be fun to try :) I should get an mt7621 dev board of sorts though.

On Wed, Mar 13, 2019 at 1:28 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 13/03/2019 13:24, Armando Miraglia wrote:
> > Running Lindent on the mt7621-spi.c file in drivers/staging I noticed that the
> > file contained style issues. This change attempts to address such style
> > problems.
> >
> > Signed-off-by: Armando Miraglia <armax@google.com>
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> Apart from fixing styling issues it would be usefull to see if we can add
> support for mt7621 to drivers/spi/spi-mt65xx.c
>
> Not sure if that is something you want to work on :)
>
> Regards,
> Matthias
>
> > ---
> > NOTE: resend this patch to include all mainteners listed by get_mantainers.pl.
> >  drivers/staging/mt7621-spi/spi-mt7621.c | 27 +++++++++++++------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
> > index b509f9fe3346..03d53845f8c5 100644
> > --- a/drivers/staging/mt7621-spi/spi-mt7621.c
> > +++ b/drivers/staging/mt7621-spi/spi-mt7621.c
> > @@ -52,14 +52,14 @@
> >  #define MT7621_LSB_FIRST     BIT(3)
> >
> >  struct mt7621_spi {
> > -     struct spi_master       *master;
> > -     void __iomem            *base;
> > -     unsigned int            sys_freq;
> > -     unsigned int            speed;
> > -     struct clk              *clk;
> > -     int                     pending_write;
> > -
> > -     struct mt7621_spi_ops   *ops;
> > +     struct spi_master *master;
> > +     void __iomem *base;
> > +     unsigned int sys_freq;
> > +     unsigned int speed;
> > +     struct clk *clk;
> > +     int pending_write;
> > +
> > +     struct mt7621_spi_ops *ops;
> >  };
> >
> >  static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
> > @@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
> >       struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
> >
> >       if ((spi->max_speed_hz == 0) ||
> > -             (spi->max_speed_hz > (rs->sys_freq / 2)))
> > +         (spi->max_speed_hz > (rs->sys_freq / 2)))
> >               spi->max_speed_hz = (rs->sys_freq / 2);
> >
> >       if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
> > @@ -316,9 +316,10 @@ static int mt7621_spi_setup(struct spi_device *spi)
> >  }
> >
> >  static const struct of_device_id mt7621_spi_match[] = {
> > -     { .compatible = "ralink,mt7621-spi" },
> > +     {.compatible = "ralink,mt7621-spi"},
> >       {},
> >  };
> > +
> >  MODULE_DEVICE_TABLE(of, mt7621_spi_match);
> >
> >  static int mt7621_spi_probe(struct platform_device *pdev)
> > @@ -408,9 +409,9 @@ MODULE_ALIAS("platform:" DRIVER_NAME);
> >
> >  static struct platform_driver mt7621_spi_driver = {
> >       .driver = {
> > -             .name = DRIVER_NAME,
> > -             .of_match_table = mt7621_spi_match,
> > -     },
> > +                .name = DRIVER_NAME,
> > +                .of_match_table = mt7621_spi_match,
> > +                },
> >       .probe = mt7621_spi_probe,
> >       .remove = mt7621_spi_remove,
> >  };
> >
