Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5532AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4C920663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckqGcq/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbfDRUCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:02:37 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36293 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:02:37 -0400
Received: by mail-it1-f194.google.com with SMTP id y10so5238334itc.1;
        Thu, 18 Apr 2019 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=md+2yuBcexkdcmroYWb/DHRRpVH85yQGDbGWlj/lPa8=;
        b=ckqGcq/1XjPiXpaSKzOlV/yqbaByjSirKCR3S5YfNi/+IDHj7/mJy/OQ2gsxd+X9zI
         ajyOIo0jrc20MbBZfMJ3vwgDj9eM47iX7zAHtp7lLyq69AkbkWWOPWWyqgFNeDxqVF7H
         34a1bvoETZMVZKBxNIADqGvKlfKY7F+1Y5sbxYl1oIU7K42I0pBCD0kbgq1s5KstqP1t
         rDHTZSdp+qhzH+wIA/EnZHEcllOqDvV5ncdIqVgpv9suOK+t+br4kAFFGcMvpdW6/cTs
         4r6JwI7/MGzm3a8W8rlZGTGlV330bTwJxXZtlJ+FoYwOWk2nYg0yuRAxqtqJ1zZjpCKx
         uhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=md+2yuBcexkdcmroYWb/DHRRpVH85yQGDbGWlj/lPa8=;
        b=DaHN7iYXPoFwFZ71o36zQIZZSf6G+KaIuylaTzO7+yMu4VegPsNwbom+BkY7mRPpxE
         CJxv5N5VT8ClfajI8PlvrfiodxfAh+mKdCpFjs4BR/r0OEKNL80vW+Yrb2hCmGFzilkd
         HGXeMIDVWMu0LOuN3cXkvKrBa5eQocy3/E4t7u3IHwDsGOYM9jzh1n3LlWKOS82HXFtP
         YxamQ2wpvs7zD7/NNCsfAScD5T3bGjM4pJSvms05fhaODAwWGywJJII7RzhUp6BCiZcM
         i7O6gx7I46dFf2oeryyOmR8D2/XgsUYV0+n3dxOhZfVyXurPkC44mKaLeJmtI03+0kui
         nBcQ==
X-Gm-Message-State: APjAAAV9dYdIolw3Vg/8LHiwLYuvc4qyLGpixXVTHbFCkLwfxS0FI4gp
        kBLIZqEmaAcUPMEm8RTYs7W9CJMVdRxR9qyJ0wDTOQjjKGY=
X-Google-Smtp-Source: APXvYqzu21GsYKKMcpfm9o+XkLf9kLx/wa5ht0dEBcqDNprmH/KAMvsZZwig+k8G4jhGFfcIvC2pj0tbBKMU8gLzYZA=
X-Received: by 2002:a24:45e4:: with SMTP id c97mr4886303itd.114.1555617755916;
 Thu, 18 Apr 2019 13:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-10-andrew.smirnov@gmail.com> <8233019b-988b-05d5-6b7c-55652da8b3cd@linaro.org>
In-Reply-To: <8233019b-988b-05d5-6b7c-55652da8b3cd@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 18 Apr 2019 13:02:24 -0700
Message-ID: <CAHQ1cqFW0XVe4e695pgs6mDvOvJ28VXwkzAwsFtZbc3E+PUVzQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] thermal: qoriq: Enable all sensors before
 registering them
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:09 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/04/2019 10:27, Andrey Smirnov wrote:
> > Tmu_get_temp will get called as a part of sensor registration via
> > devm_thermal_zone_of_sensor_register(). To prevent it from retruning
> > bogus data we need to enable sensor monitoring before that. Looking at
> > the datasheet (i.MX8MQ RM) there doesn't seem to be any harm in
> > enabling them all, so, for the sake of simplicity, change the code to
> > do just that.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 9774323a17bf..abbbfe88422e 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -23,6 +23,7 @@
> >  #define TMR_DISABLE  0x0
> >  #define TMR_ME               0x80000000
> >  #define TMR_ALPF     0x0c000000
> > +#define TMR_MSITE_ALL        GENMASK(15, 0)
> >
> >  #define REGS_TMTMIR  0x008   /* Temperature measurement interval Register */
> >  #define TMTMIR_DEFAULT       0x0000000f
> > @@ -61,28 +62,28 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
> >  static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >                                      struct qoriq_tmu_data *qdata)
> >  {
> > -     int id, sites = 0;
> > +     int id, ret;
> > +
> > +     regmap_write(qdata->regmap, REGS_TMR,
> > +                  TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
> >
> >       for (id = 0; id < SITES_MAX; id++) {
> >               struct thermal_zone_device *tzd;
> >
> >               tzd = devm_thermal_zone_of_sensor_register(dev, id,
> >                                                          qdata, &tmu_tz_ops);
> > -             if (IS_ERR(tzd)) {
> > -                     if (PTR_ERR(tzd) == -ENODEV)
> > -                             continue;
> > -                     else
> > -                             return PTR_ERR(tzd);
> > +             ret = PTR_ERR_OR_ZERO(tzd);
> > +             switch (ret) {
> > +             case -ENODEV:
> > +                     continue;
> > +             case 0:
>
> Why not simply:
>
>         if (!IS_ERR(tzd) || PTR_ERR(tzd) == -ENODEV)
>                 continue;
>
>         regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
>
>         return PTR_ERR(tzd);
>
> ?

Seemed like less typing and smaller diff for following patch that adds
hwmon sensor registration. I can probable make "if" work kind of the
same, so I'll change that. I do dislike that you had to use *_ERR
macro three times though, so I'll stick with PTR_ERR_OR_ZERO.

Thanks,
Andrey Smirnov
