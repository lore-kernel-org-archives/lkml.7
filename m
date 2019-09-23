Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF482C432C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B031820820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="V4bUEYg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503206AbfIWWFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:05:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35922 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503110AbfIWWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:05:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so15656138wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jbJLKwQpjOd723wY7Vi/Lqdhwgi3KaOZ4g+zQ7nLgfE=;
        b=V4bUEYg0YS+4DAymJw1ykzYFSljWIhwUN4y0c4Xw3ikBoT9IKyG3AA4yOUguY3uQRo
         JkplzVQ3uvBj8cjOy4GowAIFgZ6IuJVXgiDk3f722KJYjU+EruvFD86VLAgDBBVIVUK4
         ax0xf+bIbrxz8VPghVoqm2wahCBiLaucrCQDs6XvLRbQwzyHq5z0eC5Ii9Lxdd/B4KwE
         nd1KlWDNVB0UdBEXeLrgXOlE5pNaUcOUvWYO2d9VvVh6QPTXUYmoHgXTtnVXXzwie3gG
         SK/EmaGQHLpEKetBY1pFpUPvkByDkxYBpECcF7zWTCqj7JddiZtiXZziUmRObKh2UshR
         ywnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jbJLKwQpjOd723wY7Vi/Lqdhwgi3KaOZ4g+zQ7nLgfE=;
        b=geAibr2ZHeVtuBL4F3uSR9tWNWtp6MNMDZsyyUulxLkN37USEgfaST216PI9kT3CXZ
         9Pq7fx4qIj+x3DlQGqzSyT0lnXux1gfu3AQXiGOT/J3+rIeWo/4Z3QOy6v1+dMe+5li4
         dUfLg6e2U3McxLP33mN+106hY12LwUe/fm3jlzwv5LJfQ6xqIxlv1q33vlxiOLuoUrBF
         Vczkwd0pzCUabgQFuJvtANPkbn29jlLBga5t/yhTjc3TiXHeHaC6GWyGr/Ok0ewFgdYA
         +nlpmMjxNhRF5CwoBI5hqyPogR/V7/OD/ktVhXUg9xVUdz0Aq2fogpKsymXPKjpAJ6E7
         0CGw==
X-Gm-Message-State: APjAAAVvOroDf7fTervOzYmbk3jvJfccU9zjKdAG214Szdz2Zo3JFHl3
        1dDrF1AtP9pJ9sVMyeWfwc3KQ5gB3QlvLVRx7/eHSY9y
X-Google-Smtp-Source: APXvYqzSOfuanb7Qe1YMUmEHyioZIDI2B1FuvdEYuNZP6+C4WB4y7q1q/O0Me708Nq8MNMy+P/KaY67kI/lqA5PNB74=
X-Received: by 2002:adf:e591:: with SMTP id l17mr1122991wrm.199.1569276298912;
 Mon, 23 Sep 2019 15:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190827215539.1286-1-mmichilot@gateworks.com>
 <cb3e9be4-9ce6-354f-bb7c-a4710edc1c1b@xs4all.nl> <20190829142931.GZ28351@bigcity.dyn.berto.se>
In-Reply-To: <20190829142931.GZ28351@bigcity.dyn.berto.se>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 23 Sep 2019 15:04:47 -0700
Message-ID: <CAJ+vNU11HTcP8L5J2Xg+Rmhvb8JDYemhJxt-GaGG5Myk3n38Tw@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: adv7180: fix adv7280 BT.656-4 compatibility
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Matthew Michilot <matthew.michilot@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 7:29 AM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
>
> Hi,
>
> On 2019-08-29 13:43:49 +0200, Hans Verkuil wrote:
> > Adding Niklas.
> >
> > Niklas, can you take a look at this?
>
> I'm happy to have a look at this. I'm currently moving so all my boards
> are in a box somewhere. I hope to have my lab up and running next week,
> so if this is not urgent I will look at it then.
>

Niklas,

Have you looked at this yet? Without this patch the ADV7280A does not
output proper BT.656. We tested this on a Gateworks Ventana GW5404-G
which uses the ADV7280A connected to the IMX6 CSI parallel bus. I'm
hoping to see this get merged and perhaps backported to older kernels.

Regards,

Tim

> >
> > Regards,
> >
> >       Hans
> >
> > On 8/27/19 11:55 PM, Matthew Michilot wrote:
> > > From: Matthew Michilot <matthew.michilot@gmail.com>
> > >
> > > Captured video would be out of sync when using the adv7280 with
> > > the BT.656-4 protocol. Certain registers (0x04, 0x31, 0xE6) had to
> > > be configured properly to ensure BT.656-4 compatibility.
> > >
> > > An error in the adv7280 reference manual suggested that EAV/SAV mode
> > > was enabled by default, however upon inspecting register 0x31, it was
> > > determined to be disabled by default.
> > >
> > > Signed-off-by: Matthew Michilot <matthew.michilot@gmail.com>
> > > Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > >  drivers/media/i2c/adv7180.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.=
c
> > > index 99697baad2ea..27da424dce76 100644
> > > --- a/drivers/media/i2c/adv7180.c
> > > +++ b/drivers/media/i2c/adv7180.c
> > > @@ -94,6 +94,7 @@
> > >  #define ADV7180_REG_SHAP_FILTER_CTL_1      0x0017
> > >  #define ADV7180_REG_CTRL_2         0x001d
> > >  #define ADV7180_REG_VSYNC_FIELD_CTL_1      0x0031
> > > +#define ADV7180_VSYNC_FIELD_CTL_1_NEWAV 0x12
> > >  #define ADV7180_REG_MANUAL_WIN_CTL_1       0x003d
> > >  #define ADV7180_REG_MANUAL_WIN_CTL_2       0x003e
> > >  #define ADV7180_REG_MANUAL_WIN_CTL_3       0x003f
> > > @@ -935,10 +936,20 @@ static int adv7182_init(struct adv7180_state *s=
tate)
> > >             adv7180_write(state, ADV7180_REG_EXTENDED_OUTPUT_CONTROL,=
 0x57);
> > >             adv7180_write(state, ADV7180_REG_CTRL_2, 0xc0);
> > >     } else {
> > > -           if (state->chip_info->flags & ADV7180_FLAG_V2)
> > > +           if (state->chip_info->flags & ADV7180_FLAG_V2) {
> > > +                   /* ITU-R BT.656-4 compatible */
> > >                     adv7180_write(state,
> > >                                   ADV7180_REG_EXTENDED_OUTPUT_CONTROL=
,
> > > -                                 0x17);
> > > +                                 ADV7180_EXTENDED_OUTPUT_CONTROL_NTS=
CDIS);
> > > +                   /* Manually set NEWAVMODE */
> > > +                   adv7180_write(state,
> > > +                                 ADV7180_REG_VSYNC_FIELD_CTL_1,
> > > +                                 ADV7180_VSYNC_FIELD_CTL_1_NEWAV);
> > > +                   /* Manually set V bit end position in NTSC mode *=
/
> > > +                   adv7180_write(state,
> > > +                                 ADV7180_REG_NTSC_V_BIT_END,
> > > +                                 ADV7180_NTSC_V_BIT_END_MANUAL_NVEND=
);
> > > +           }
> > >             else
> > >                     adv7180_write(state,
> > >                                   ADV7180_REG_EXTENDED_OUTPUT_CONTROL=
,
> > >
> >
>
> --
> Regards,
> Niklas S=C3=B6derlund
