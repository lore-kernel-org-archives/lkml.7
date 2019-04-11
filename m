Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1541C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949262146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555001435;
	bh=yIir5Y2LTtThpcZ0wmoahtPjJhRvzPB4XRFyJC5fbpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W+JXR7U9J0vClZrtgo4ofPeGpWvkgUnfk94wOxQ29Xo5b9z5omksgb9BORMsk1Yy+
	 4LiR1GTIlnYrlCiXhG1WsxE3Y8mseMbNQwPlZ0hax2wng1rCd1p7u0ZtwnRGiBY/RD
	 IqCE6nEsWjEo31FiichGve6yTD25YfmIbjABvxlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDKQue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKQud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:50:33 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FC0C2146F;
        Thu, 11 Apr 2019 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555001432;
        bh=yIir5Y2LTtThpcZ0wmoahtPjJhRvzPB4XRFyJC5fbpY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vnL9Do0tI6kdTd3ZBZSqJJl+7Mqkt4UshkZI4sl3m6mDQmAqWApaTluwpiYPUZxAX
         EpZYF9Y26xbZK80UxkgViwBbmu5TM8z9R+scsafLZ5Z2dJwThJMf3f/0AZRryzcEtF
         mGDVpDI+Ixwwb2kHm0DDCXs1fHOp4sOOv3+prKGM=
Received: by mail-qt1-f170.google.com with SMTP id z16so7905811qtn.4;
        Thu, 11 Apr 2019 09:50:32 -0700 (PDT)
X-Gm-Message-State: APjAAAUv/vXy44gK+UJzQoDZg/vUCrUuDGKosXubRxLTmUYsef03eojq
        ooTiSTyHl+FRtra74pswktk2a9wkBh+Sy3mK+A==
X-Google-Smtp-Source: APXvYqwTqvX7C0TTcwgCaYWdFm3bXLLByPKzUgynxM+iqmu4l9jDYFGRw2vas6PYj2tYWtRg5Rk0rxSUelKiNEkJZNg=
X-Received: by 2002:aed:3e3d:: with SMTP id l58mr43153787qtf.77.1555001431360;
 Thu, 11 Apr 2019 09:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190403090108.24788-1-brgl@bgdev.pl> <20190403090108.24788-3-brgl@bgdev.pl>
 <20190406070746.GA29624@bogus> <CAMRc=Mc+cTVrzywTydp-10Hj=-m=qCmtK1+4NRiOFHZ855fnDw@mail.gmail.com>
 <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com>
 <CAMRc=Mc4HOn+Pjwf+sD4fU7gNoksRKXz9Yq6zE233CCoNskPiQ@mail.gmail.com> <CAMRc=MfkdBMmhrCM7Ut8ZGkgT=gFTRrbgFmu3MbghGwCRkEEKg@mail.gmail.com>
In-Reply-To: <CAMRc=MfkdBMmhrCM7Ut8ZGkgT=gFTRrbgFmu3MbghGwCRkEEKg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Apr 2019 11:50:19 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKHGczKAD3VjBsq6G=Ev0t8p_qWZ0YG6rRsqO8GuRAK7Q@mail.gmail.com>
Message-ID: <CAL_JsqKHGczKAD3VjBsq6G=Ev0t8p_qWZ0YG6rRsqO8GuRAK7Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for max77650
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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

On Tue, Apr 9, 2019 at 10:38 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> wt., 9 kwi 2019 o 13:04 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
> >
> > wt., 9 kwi 2019 o 03:10 Rob Herring <robh@kernel.org> napisa=C5=82(a):
> > >
> > > On Mon, Apr 8, 2019 at 7:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> > > >
> > > > sob., 6 kwi 2019 o 09:07 Rob Herring <robh@kernel.org> napisa=C5=82=
(a):
> > > > >
> > > > > On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wro=
te:
> > > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > >
> > > > > > Add the DT binding document for the battery charger module of m=
ax77650.
> > > > > >
> > > > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > > ---
> > > > > >  .../power/supply/max77650-charger.txt         | 27 +++++++++++=
++++++++
> > > > > >  1 file changed, 27 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/power/sup=
ply/max77650-charger.txt
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/power/supply/max=
77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650=
-charger.txt
> > > > > > new file mode 100644
> > > > > > index 000000000000..fef188144386
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/power/supply/max77650-c=
harger.txt
> > > > > > @@ -0,0 +1,27 @@
> > > > > > +Battery charger driver for MAX77650 PMIC from Maxim Integrated=
.
> > > > > > +
> > > > > > +This module is part of the MAX77650 MFD device. For more detai=
ls
> > > > > > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > > > > +
> > > > > > +The charger is represented as a sub-node of the PMIC node on t=
he device tree.
> > > > > > +
> > > > > > +Required properties:
> > > > > > +--------------------
> > > > > > +- compatible:                Must be "maxim,max77650-charger"
> > > > > > +
> > > > > > +Optional properties:
> > > > > > +--------------------
> > > > > > +- min-microvolt:     Minimum CHGIN regulation voltage (in micr=
ovolts). Must be
> > > > > > +                     one of: 4000000, 4100000, 4200000, 430000=
0, 4400000,
> > > > > > +                     4500000, 4600000, 4700000.
> > > > > > +- current-limit-microamp:    CHGIN input current limit (in mic=
roamps). Must
> > > > > > +                             be one of: 95000, 190000, 285000,=
 380000, 475000.
> > > > >
> > > > > To repeat what I said on v6, these should be common properties IM=
O (and
> > > > > therefore documented as such).
> > > > >
> > > >
> > > > Do you mean a separate "charger.txt" document in
> > > > Documentation/devicetree/bindings/power/supply/?
> > >
> > > Yes, though I thought we had something already.
> > >
> > > Rob
> >
> > We don't AFAICT. There's only a binding document for "simple-battery"
> > in power supply.
> >
> > Bart
>
> Can we have it locally for now but without the maxim prefix and then
> reuse it if any other charger needs such functionality? To make it
> even more generic we can name it: "input-voltage-min-microvolt" &
> "input-current-limit-microamp".

I guess. And defining these as 'input' is good because we do have
similar property names already for battery current limit and voltages.

Rob
