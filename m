Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66878C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3555F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AL/2Px3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfDBMAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:00:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34737 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfDBMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:00:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so10224736oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K7hu232ulM7ss/J+eLrdcUTl20KHimcuP8QU4sHhpUg=;
        b=AL/2Px3Y5QOlQV6pjlmn0F3v5EDxGvYsC4uywnP9nc1roC/aNW7lmJzm1aKGJUicHc
         z5vmLgJduhsqtfXbnWykAZWsCrjnszu84IrAMpDIjt8C0xH6w6tpZwDIc8TB/53lzIFg
         cDXvBSh7Dy3z2bhJauA13qimcuNxthRQC1pFC6UO+ewP1p2X5iwvD6VChuklD2IfMXKM
         AvV7LWLko/+sTYSP2iGFBykojmgK+uKkdwsreboXENaP9TDxII2MiZZdP7O6E1ViVd3A
         iquzqN9KSw1KZaFqJVu5Z+K98/up9y2QSOlxqgmWpRN6W+jaHUpBftmAmKCc9atp0zvy
         D8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K7hu232ulM7ss/J+eLrdcUTl20KHimcuP8QU4sHhpUg=;
        b=R/zXnPkWo9ewmjCVorF83g9nciB0rz0fz/zGJJ1gi2N5U+/JSJFW7/4dddTX4RAZpS
         zJl39wG6ASwuqddteGoh1VABXCt6BX/MoTr/hGs8HDW8T2R5ALXfHsaFypbITTrEp2N4
         Eqf5gQAoNrFNw22kchwzgYXA3FBhldKCYADm5HAZXyq4vENyvbEkHuSNUiWekpAOb8hI
         92Rq7krX5MZFMCyTJkM/yc+GEundbayEl8H2ik6XcOHuGndMwrRCwlq80QrW26W9tGqd
         q7Xf0D1MI+TGTwI9D5R0b+BqgZvR3tJUZsbtzFQC2BvthwYS6QgD37KPwEKftxHLVfK0
         1mHg==
X-Gm-Message-State: APjAAAVG7RC5ykLGtsTg8bE4MEM1lV/BjmzL7SC6p/zQ6WaxQXCXZGBz
        HAzEKGPD7UlTRmFyZTaNFDRNn4KzkOMF1YS1olbRTw==
X-Google-Smtp-Source: APXvYqxSJJ4g+o4/xk5h+jCU0kBOL506zhrkm7b3FH+4oaBgYSrG/LzHYoL/m1AntU0CZ5Ve29GFyBH/J0uN61JMrOI=
X-Received: by 2002:aca:4c88:: with SMTP id z130mr16737743oia.170.1554206430753;
 Tue, 02 Apr 2019 05:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190329093334.3885-1-brgl@bgdev.pl> <20190329093334.3885-5-brgl@bgdev.pl>
 <8346cd90-3558-479b-2129-8ae7915b3bda@ti.com>
In-Reply-To: <8346cd90-3558-479b-2129-8ae7915b3bda@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 2 Apr 2019 14:00:20 +0200
Message-ID: <CAMpxmJUaLKUwc1DBvTfDM7h=dYU6CACwRrMz4H6PE+9G5duQ-g@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ARM: davinci: omapl138-hawk: add a fixed regulator
 for ohci-da8xx
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 kwi 2019 o 13:01 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> Hi Bart,
>
> On 29/03/19 3:03 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Instead of directly using the vbus GPIO we should model it as a fixed
> > regulator. Add all necessary fix-ups for the regulator to be registered
> > and configure the vbus GPIO as its enable pin.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  arch/arm/mach-davinci/board-omapl138-hawk.c | 49 +++++++++++++++++++--
> >  1 file changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mac=
h-davinci/board-omapl138-hawk.c
> > index e244c8648594..0039b4d4c935 100644
> > --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> > +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/platform_data/mtd-davinci.h>
> >  #include <linux/platform_data/mtd-davinci-aemif.h>
> >  #include <linux/platform_data/ti-aemif.h>
> > +#include <linux/regulator/fixed.h>
> >  #include <linux/regulator/machine.h>
> >
> >  #include <asm/mach-types.h>
> > @@ -298,15 +299,50 @@ static const short da850_hawk_usb11_pins[] =3D {
> >       -1
> >  };
> >
> > -static struct gpiod_lookup_table hawk_usb_gpio_lookup =3D {
> > +static struct regulator_consumer_supply hawk_usb_supplies[] =3D {
> > +     REGULATOR_SUPPLY("vbus", NULL),
> > +};
> > +
> > +static struct regulator_init_data hawk_usb_vbus_data =3D {
> > +     .consumer_supplies      =3D hawk_usb_supplies,
> > +     .num_consumer_supplies  =3D ARRAY_SIZE(hawk_usb_supplies),
> > +};
> > +
> > +static struct fixed_voltage_config hawk_usb_vbus =3D {
> > +     .supply_name            =3D "vbus",
> > +     .microvolts             =3D 3300000,
> > +     .init_data              =3D &hawk_usb_vbus_data,
> > +};
> > +
> > +static struct platform_device hawk_usb_vbus_device =3D {
> > +     .name           =3D "reg-fixed-voltage",
> > +     .id             =3D 1,
>
> Can you explain choice of of 1 for id here? Its the first fixed
> regulator being registered. Shouldn't it be 0?
>
> Thanks,
> Sekhar

Good point, I guess you're right. Something for v3 I guess.

Bart
