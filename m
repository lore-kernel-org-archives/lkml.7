Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED279C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF7920883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="G6tBl6c1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDIPif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:38:35 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40461 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfDIPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:38:33 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so5614707itb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pt9UNGmZGIYGlZ2QTO4HylfUAQVS8xdNO3SXWY6eb4c=;
        b=G6tBl6c1Ws6CyGsICZgqvE1rUjgwzRPSFz2Q1in7N4+rvi+/QwOCvJcAj53J8/ekMG
         W1+jXB1/6luDXq93LNrQ0vN40m4osHRFb/1KmySoaSyxGFd0wz/hPvixP+p8U9Ozhpu+
         u8ihs04i/MdHAeNBaltE8ltPRuul4d8/HrbHcvlFfy8jRg8MCJos0fEV7Pc5shxXYHnx
         aZk7NDWLVfW2lvyr6a/sqbqrW9MlQFHTOuzzKpIoKPFxOeIWyO21cVXf2oOAIjSyNF8H
         GBmnhCz0aMnkyUnjCPLRcWqxzJNtHoT0nfJIiWJGtNHp02zLwx/tjmGpK8qyfTiSBX5z
         jieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pt9UNGmZGIYGlZ2QTO4HylfUAQVS8xdNO3SXWY6eb4c=;
        b=GpMv3QOvkUXPwXSRVRLHkwQVyDUqW0TWX0OLTldTf6tug6ojmhsBTAr14xFbuwnsRX
         WHROf0d7+RfSc5cYUXFQUOcnK69UN0LFsbJDP7H0bjw09b5YuKq2j/VgBY9sFCD3fP3U
         svKC8wJelKGMmeYMGjSYiipTaCYwvKaxG+mgZvpJx9pasn+mmvIve1/KwnaAbXwJgtwk
         F0gvf6LZKxwiVnFGSo3vudzotISLClw6Ct88ofDTQc5Yvwr6UnppElMhKcskdFTlBgUO
         CrAru6GBTuA1lshAAapdD9xElu5L1+fZESf4HAxJ2Ys3pAxaKG7JFKXUCgggKYhDE3Na
         4fxQ==
X-Gm-Message-State: APjAAAVz/SNE5CETOTua+AZuHpObBaIN7I0gAlZNvuhPE/JyzhY6Ize1
        Z5xlp75MRTM4c/F3cKP87rr05OL/oVEC5q8miA2FEg==
X-Google-Smtp-Source: APXvYqwgIZ8jvlJsLLHZsGZV7XLhc54MZO8km3dqpscHI9XMQP5QklSnw6tEw2lK3OyXmlDPeY2eD9811Hh2ecyIHKY=
X-Received: by 2002:a24:57cf:: with SMTP id u198mr21047947ita.162.1554824312072;
 Tue, 09 Apr 2019 08:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190403090108.24788-1-brgl@bgdev.pl> <20190403090108.24788-3-brgl@bgdev.pl>
 <20190406070746.GA29624@bogus> <CAMRc=Mc+cTVrzywTydp-10Hj=-m=qCmtK1+4NRiOFHZ855fnDw@mail.gmail.com>
 <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com> <CAMRc=Mc4HOn+Pjwf+sD4fU7gNoksRKXz9Yq6zE233CCoNskPiQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mc4HOn+Pjwf+sD4fU7gNoksRKXz9Yq6zE233CCoNskPiQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 9 Apr 2019 17:38:20 +0200
Message-ID: <CAMRc=MfkdBMmhrCM7Ut8ZGkgT=gFTRrbgFmu3MbghGwCRkEEKg@mail.gmail.com>
Subject: Re: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for max77650
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
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

wt., 9 kwi 2019 o 13:04 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a)=
:
>
> wt., 9 kwi 2019 o 03:10 Rob Herring <robh@kernel.org> napisa=C5=82(a):
> >
> > On Mon, Apr 8, 2019 at 7:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > >
> > > sob., 6 kwi 2019 o 09:07 Rob Herring <robh@kernel.org> napisa=C5=82(a=
):
> > > >
> > > > On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wrote=
:
> > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > >
> > > > > Add the DT binding document for the battery charger module of max=
77650.
> > > > >
> > > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > ---
> > > > >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++=
++++++
> > > > >  1 file changed, 27 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/power/suppl=
y/max77650-charger.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/power/supply/max77=
650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-c=
harger.txt
> > > > > new file mode 100644
> > > > > index 000000000000..fef188144386
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/power/supply/max77650-cha=
rger.txt
> > > > > @@ -0,0 +1,27 @@
> > > > > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > > > > +
> > > > > +This module is part of the MAX77650 MFD device. For more details
> > > > > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > > > +
> > > > > +The charger is represented as a sub-node of the PMIC node on the=
 device tree.
> > > > > +
> > > > > +Required properties:
> > > > > +--------------------
> > > > > +- compatible:                Must be "maxim,max77650-charger"
> > > > > +
> > > > > +Optional properties:
> > > > > +--------------------
> > > > > +- min-microvolt:     Minimum CHGIN regulation voltage (in microv=
olts). Must be
> > > > > +                     one of: 4000000, 4100000, 4200000, 4300000,=
 4400000,
> > > > > +                     4500000, 4600000, 4700000.
> > > > > +- current-limit-microamp:    CHGIN input current limit (in micro=
amps). Must
> > > > > +                             be one of: 95000, 190000, 285000, 3=
80000, 475000.
> > > >
> > > > To repeat what I said on v6, these should be common properties IMO =
(and
> > > > therefore documented as such).
> > > >
> > >
> > > Do you mean a separate "charger.txt" document in
> > > Documentation/devicetree/bindings/power/supply/?
> >
> > Yes, though I thought we had something already.
> >
> > Rob
>
> We don't AFAICT. There's only a binding document for "simple-battery"
> in power supply.
>
> Bart

Can we have it locally for now but without the maxim prefix and then
reuse it if any other charger needs such functionality? To make it
even more generic we can name it: "input-voltage-min-microvolt" &
"input-current-limit-microamp".

Bart
