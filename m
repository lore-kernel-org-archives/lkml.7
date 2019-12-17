Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F6BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC54207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qtoUbxZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfLQMGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:06:44 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41558 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfLQMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:06:44 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so8181914ils.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJFvFlTIidZyYqjLvZTlE95MCLu7jntYF3GzY++GrcU=;
        b=qtoUbxZKi8HQaYf/hEuyljG2Lk9x3aTYRUUhA+yNAkDKcQJk7YJ0lE6it9xS7/MtNE
         BH1N5iQvubVOF8dccCLV5moaKunrYjZQI/yqGf3BIh2A6y9OSaM4ASIGeUZi6MMVUOUL
         NaROAhN2+tEmIzppIlC25TZZFlD0N2HhlIUBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJFvFlTIidZyYqjLvZTlE95MCLu7jntYF3GzY++GrcU=;
        b=oeKm8/rvNInERsNueVcdgo+QDlk34OUjulCHEUJ/uVWNQauqkGDxHVehBsW/e/76Lv
         1YXqUAqF7ppETibewUttPzurNoU4iDGKaAObTf6u7udnwId59ZW1VXKBMKlf8iwu/3ED
         06BxRbiyCLAipO6KWcLDBB+hDXfwbj95UtMdUU9E5lFVQxB/Uo8gnjY/3JHRenC2Afv/
         71J3K31xIcf721yUCWCeocIVo/L05dS5CovnxUKsUkQFAuB6fL8T9dSozhLyAquXwa+R
         iOdXnvgeLpwQp/9+iz/ToJd1HdNQTbMQJ8Lih240z7xu4+U2HeC2J8kt4ZQdki4kVYSP
         rHZg==
X-Gm-Message-State: APjAAAWlfaOdZxPdybh1xX9vxikT8eFImZSacNBk6w0UctJxyGg13AwL
        h1CqPSfo95QDXRfkEcs4Kqf138GiJfTR3s3GK9uArQ==
X-Google-Smtp-Source: APXvYqzo1LW8pYHyyqjgRw5xkXeBYSK8ws4WYpGdREfWhRvAF2p1T/KlJp3RESV+UxI8vdA2SxK9Moux+dAQE89yUZ0=
X-Received: by 2002:a92:17cb:: with SMTP id 72mr16272735ilx.173.1576584402380;
 Tue, 17 Dec 2019 04:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
 <20191203134816.5319-2-jagan@amarulasolutions.com> <20191204133600.gnv6dnhk6upe7xod@gilmour.lan>
 <CAMty3ZDU57Hj3ZSBC6sSMFWN9-HQadA03hmXUNUVS1W0UQQ3DA@mail.gmail.com>
 <20191216112042.f4xvlgnbm4dk6wkq@gilmour.lan> <CAMty3ZBU-XaxR_vM5L2yVbhR5ftfbtDn3jP00qCxBF+owVyqDQ@mail.gmail.com>
 <20191216183410.akrmytbvaeg37wms@gilmour.lan>
In-Reply-To: <20191216183410.akrmytbvaeg37wms@gilmour.lan>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 17 Dec 2019 17:36:31 +0530
Message-ID: <CAMty3ZDoE6fxA3gSeUAV+WJEz0_qdQgU43Uxiq2YnH-yFuxZfg@mail.gmail.com>
Subject: Re: [PATCH v12 1/7] dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:04 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Dec 16, 2019 at 10:29:08PM +0530, Jagan Teki wrote:
> > On Mon, Dec 16, 2019 at 4:50 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Mon, Dec 16, 2019 at 04:37:20PM +0530, Jagan Teki wrote:
> > > > On Wed, Dec 4, 2019 at 7:06 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > > >
> > > > > On Tue, Dec 03, 2019 at 07:18:10PM +0530, Jagan Teki wrote:
> > > > > > The MIPI DSI controller in Allwinner A64 is similar to A33.
> > > > > >
> > > > > > But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> > > > > > to have separate compatible for A64 on the same driver.
> > > > > >
> > > > > > DSI_SCLK uses mod clock-names on dt-bindings, so the same
> > > > > > is not required for A64.
> > > > > >
> > > > > > On that note
> > > > > > - A64 require minimum of 1 clock like the bus clock
> > > > > > - A33 require minimum of 2 clocks like both bus, mod clocks
> > > > > >
> > > > > > So, update dt-bindings so-that it can document both A33,
> > > > > > A64 bindings requirements.
> > > > > >
> > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > ---
> > > > > > Changes for v12:
> > > > > > - Use 'enum' instead of oneOf+const
> > > > > >
> > > > > >  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
> > > > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > > > index dafc0980c4fa..b91446475f35 100644
> > > > > > --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > > > @@ -15,7 +15,9 @@ properties:
> > > > > >    "#size-cells": true
> > > > > >
> > > > > >    compatible:
> > > > > > -    const: allwinner,sun6i-a31-mipi-dsi
> > > > > > +    enum:
> > > > > > +      - allwinner,sun6i-a31-mipi-dsi
> > > > > > +      - allwinner,sun50i-a64-mipi-dsi
> > > > > >
> > > > > >    reg:
> > > > > >      maxItems: 1
> > > > > > @@ -24,6 +26,8 @@ properties:
> > > > > >      maxItems: 1
> > > > > >
> > > > > >    clocks:
> > > > > > +    minItems: 1
> > > > > > +    maxItems: 2
> > > > > >      items:
> > > > > >        - description: Bus Clock
> > > > > >        - description: Module Clock
> > > > > > @@ -63,13 +67,25 @@ required:
> > > > > >    - reg
> > > > > >    - interrupts
> > > > > >    - clocks
> > > > > > -  - clock-names
> > > > > >    - phys
> > > > > >    - phy-names
> > > > > >    - resets
> > > > > >    - vcc-dsi-supply
> > > > > >    - port
> > > > > >
> > > > > > +allOf:
> > > > > > +  - if:
> > > > > > +      properties:
> > > > > > +         compatible:
> > > > > > +           contains:
> > > > > > +             const: allwinner,sun6i-a31-mipi-dsi
> > > > > > +      then:
> > > > > > +        properties:
> > > > > > +          clocks:
> > > > > > +            minItems: 2
> > > > > > +        required:
> > > > > > +          - clock-names
> > > > > > +
> > > > >
> > > > > Your else condition should check that the number of clocks items is 1
> > > > > on the A64
> > > >
> > > > But the minItems mentioned as 1 in clocks, which is unchanged number
> > > > by default. doesn't it sufficient?
> > >
> > > In the main schema, it's said that the clocks property can have one or
> > > two elements (to cover the A31 case that has one, and the A64 case
> > > that has 2).
> > >
> > > This is fine.
> > >
> > > Later on, you enforce that the A64 has two elements, and this is fine
> > > too.
> >
> > Actually A31 case has 2 and A64 case has 1.
> >
> > >
> > > However, you never check that on the A31 you only have one clock, and
> > > you could very well have two and no one would notice.
> >
> > I did check A31 case for 2 but not in A64. this is what you mean? so
> > adding A64 check like below would fine?
> >
> > allOf:
> >   - if:
> >       properties:
> >          compatible:
> >            contains:
> >              const: allwinner,sun6i-a31-mipi-dsi
>
> You need a new line here

I couldn't see new line before then: in example schema -
https://elixir.bootlin.com/linux/v5.5-rc2/source/Documentation/devicetree/bindings/example-schema.yaml#L208
May be a new changes for this ML or so?

>
> >       then:
>
> This is the wrong level of indentation, it needs to be at the same level than if

True, I have seen it in example schema.

>
> >         properties:
> >           clocks:
> >             minItems: 2
>
> Newline
>
> >         required:
> >           - clock-names
>
> Newline
>
> >   - if:
> >       properties:
> >          compatible:
> >            contains:
> >              const: allwinner,sun50i-a64-mipi-dsi
> >       then:
> >         properties:
> >           clocks:
> >             minItems: 1
>
> (and same thing here).
>
> But yeah, otherwise that's what I meant

Thanks for the detailed review.
