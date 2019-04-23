Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB339C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B348E206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XdmKegJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfDWJPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:15:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36620 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfDWJPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:15:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so10706853oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4HFxuYAKK5yY7ojgbXd1utMoT44UFgcVd8qOu2984A4=;
        b=XdmKegJHDZ4IpCpK6fXehJKzJYMEOKlsi0Jol0xs+OYkFyzd62gfI7sOgd4GCpnqSK
         4PVTqaAHSOlQtEhuKYbjVJijib7ZU7SHjTbNF7iAuE6uq5O3xhvP+KwyEOq8r2AF5FGh
         GQpVJlwqKV2YjtOHev+Hf4mUAQFSHvSKTDGfNHy95Ef0yRjZSj4y6UF1Y9eI6yMEqWUn
         lmENgHHEsjuC5fNbEyCyRmfS06R3+WQDJxdKUV+AKGNKC2ku82cPd3zImBQnaVt0C65t
         AVIkhXAp2I1/GeNlCombJ/d2MzKNmjp0YkA0d0LwHZkI1WQX+NhaDYfAb1MUYDlQtFHv
         W0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4HFxuYAKK5yY7ojgbXd1utMoT44UFgcVd8qOu2984A4=;
        b=Iqjz5DcKitBn+/hOEW8tHKGl3kVKCQO8PAWa7w/7FyC4WhMzZnlsiv0aXlGPi5Ou4F
         J7UG7WAkFSGH/L4iFx5+7fgG+sAyaX3vrbwnz9/dDeAF3uuBJXbK42tSe12n2BxLryxv
         3n0u6a3/2yrVELHk7+6Zx0BTGhc53pgfpNv82QYSH9YVkBRXveEDJtLCncLYlyooukl/
         Vt99GVtOb6Y1/SLSXHGHy03Q7Af0Zp58vKtsqulST+6rXLrXn2ffuysIRmPwoviQCnp2
         pHAh5pxGHcHw+sgFQXVWRZEu1IdGzma2/vb+8les+6xeIZXAgDQwWMi22xHmK1f8dvHz
         xURA==
X-Gm-Message-State: APjAAAUBd+V+84tm7gPn5pVWYwODR6V9JADd0px8ZxaXQFMrIDviBjhy
        UVJnCWSaCsJZ+bTgENdsD2HWKWIMjD0yWGBTv7MbFeFkyuU=
X-Google-Smtp-Source: APXvYqyRQceQt89mWKB9LuMA6aAQR85MWAoNQ55b6IQ5U7ljCSwyjA4fR+Uy4IMfIoTyY9pZMSusoy6src8b90Dz3PI=
X-Received: by 2002:aca:b8d5:: with SMTP id i204mr303030oif.175.1556010943163;
 Tue, 23 Apr 2019 02:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190417152701.23391-1-brgl@bgdev.pl> <20190417152701.23391-5-brgl@bgdev.pl>
 <CAHCN7xKVaYqd5LLvRx7i8ik+JnTFdpexZf2WXt0R2N1W1skOJA@mail.gmail.com>
In-Reply-To: <CAHCN7xKVaYqd5LLvRx7i8ik+JnTFdpexZf2WXt0R2N1W1skOJA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 23 Apr 2019 11:15:32 +0200
Message-ID: <CAMpxmJW9yWcQ8497OwOhMN8wj-Cmc3-UP7Rh-yoU_uDaQkVVSw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] ARM: dts: da850-evm: enable cpufreq
To:     Adam Ford <aford173@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 17 kwi 2019 o 19:09 Adam Ford <aford173@gmail.com> napisa=C5=82(a=
):
>
> On Wed, Apr 17, 2019 at 10:27 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
> > tps65070 pmic with configurable output voltage. By default da850-evm
> > boards support frequencies up to 375MHz so enable this operating
> > point.
>
> Have you done any testing with the LCD on any of the devices you have?
>
> I enabled the ondemand governor, and I got a bunch of splat from the
> LCD controller:
>
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
> differs from the calculated rate (54000000Hz)
> tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
> ... [ snip]
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
> differs from the calculated rate (54000000Hz)
> tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
> differs from the calculated rate (54000000Hz)
> tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
>
> It appears to go on forever.  I don't necessarily want to hold it up,
> but I don't know the clocking system well enough to know where to go
> investigate it.  I can certainly live without ondemand.  Using
> userspace as the default governor is fine for me for now.
>
> adam

Hi Adam,

I did test the tilcdc on da850-lcdk. The only message I'm getting
during transitions is a single:

tilcdc <name>: tilcdc_crtc_irq(<address>): FIFO underflow

but this is fairly normal - we also get this during modeset and it
doesn't affect the display.

The problem with the pixel clock may come from the bootloader - are
you using a recent version of u-boot?

Bart

> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: Adam Ford <aford173@gmail.com>
> > ---
> >  arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-=
evm.dts
> > index f04bc3e15332..f94bb38fdad9 100644
> > --- a/arch/arm/boot/dts/da850-evm.dts
> > +++ b/arch/arm/boot/dts/da850-evm.dts
> > @@ -191,6 +191,19 @@
> >         };
> >  };
> >
> > +&cpu {
> > +       cpu-supply =3D <&vdcdc3_reg>;
> > +};
> > +
> > +/*
> > + * The standard da850-evm kits and SOM's are 375MHz so enable this ope=
rating
> > + * point by default. Higher frequencies must be enabled for custom boa=
rds with
> > + * other variants of the SoC.
> > + */
> > +&opp_375 {
> > +       status =3D "okay";
> > +};
> > +
> >  &sata {
> >         status =3D "okay";
> >  };
> > --
> > 2.21.0
> >
