Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66383C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C7A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="i18Bzi9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDHMZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:25:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38170 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfDHMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:25:57 -0400
Received: by mail-it1-f196.google.com with SMTP id f22so20589548ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lQcpDr5VAF2zM8uHWq0SbeKOgE159Ny/tgMDuFmE6vk=;
        b=i18Bzi9SmJ28ujFiloXcrHDpCjfcj4/cJ199b4fJwbAHkA73kCnu1eYyrKnZQ/fD73
         Q0GXgU+dtAvYkKjrTZhRoBptnGCPX3KBp+qooku9+znowPRFIAZVmMAQX6gIKvGUIMAW
         oI6myldKjygByD9fp56S5cYe3xgM79AODwzXXoD63c0Fn9XN+kR4Fux3+HYJpr4aOYL6
         fnUMkWda+QUw8anMs7NZWeXP+bWs4P7OtEFxA9AJr9J+30cGOK/zqrzf6cDpRiLIZRdI
         XIml4qTFz0ZbiCK9PnSbQfPxEBjT3R8SaOT2Y5s1QLH6k/z2rALb1keNelz4TeL/3bk9
         qqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lQcpDr5VAF2zM8uHWq0SbeKOgE159Ny/tgMDuFmE6vk=;
        b=LXms16q6hdpBsGYLZy098/sIIIPKAJEFOt6Xx0hqq8WDMlwwYfl8+K1eX0ZzqD7ftV
         UGa7S12IfHlZWPQqs636hRbvXouACBnQ6Dzeern/FucpCaZ48g5kBZUJJqqsWlZYqVeQ
         mNb2QPnsxx4tFA5Jgy/o38nqQ4DKcarB6o2ZFRGIUnkovr8mNohSQ4m1jqH7C6P0DBiB
         uXq5ouG/EF0GrTyfH2Ppdi/tX1S0KMpAW5JYLPtW9bjivgGFw1CWZKdRYwKIfpRoyiel
         O/VxOW+Vd7A/c/YHRArl1Wlp31d04ZTynePIDb8HJ3XkYA+vf/EFjBLoWfu6EqYWpnOb
         NOAQ==
X-Gm-Message-State: APjAAAXjyOQBIGZLI4vtmE7/SXWR7rbBdMTr8YmQcFIyuoFMqVWdnC8O
        393jNnxOVslFFksTN1UQxqIII5+MPvoaeklA4vnPWQ==
X-Google-Smtp-Source: APXvYqypso5ErFjcfXh1FiVJ51uhvmCt0KVoZ/gESJrKqTUNlD5m+qLQP5hs9RZ0vPe4pNzBDI4kjUEkpO7nqLX7vs8=
X-Received: by 2002:a24:57cf:: with SMTP id u198mr16538556ita.162.1554726356883;
 Mon, 08 Apr 2019 05:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190403090108.24788-1-brgl@bgdev.pl> <20190403090108.24788-3-brgl@bgdev.pl>
 <20190406070746.GA29624@bogus>
In-Reply-To: <20190406070746.GA29624@bogus>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 8 Apr 2019 14:25:45 +0200
Message-ID: <CAMRc=Mc+cTVrzywTydp-10Hj=-m=qCmtK1+4NRiOFHZ855fnDw@mail.gmail.com>
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

sob., 6 kwi 2019 o 09:07 Rob Herring <robh@kernel.org> napisa=C5=82(a):
>
> On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the DT binding document for the battery charger module of max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/max7=
7650-charger.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-ch=
arger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger=
.txt
> > new file mode 100644
> > index 000000000000..fef188144386
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> > @@ -0,0 +1,27 @@
> > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > +
> > +This module is part of the MAX77650 MFD device. For more details
> > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > +
> > +The charger is represented as a sub-node of the PMIC node on the devic=
e tree.
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:                Must be "maxim,max77650-charger"
> > +
> > +Optional properties:
> > +--------------------
> > +- min-microvolt:     Minimum CHGIN regulation voltage (in microvolts).=
 Must be
> > +                     one of: 4000000, 4100000, 4200000, 4300000, 44000=
00,
> > +                     4500000, 4600000, 4700000.
> > +- current-limit-microamp:    CHGIN input current limit (in microamps).=
 Must
> > +                             be one of: 95000, 190000, 285000, 380000,=
 475000.
>
> To repeat what I said on v6, these should be common properties IMO (and
> therefore documented as such).
>

Do you mean a separate "charger.txt" document in
Documentation/devicetree/bindings/power/supply/?

Bart

> > +
> > +Example:
> > +--------
> > +
> > +     charger {
> > +             compatible =3D "maxim,max77650-charger";
> > +             min-microvolt =3D <4200000>;
> > +             curr-lim-microamp =3D <285000>;
> > +     };
> > --
> > 2.21.0
> >
