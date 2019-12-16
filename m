Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC37C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E26206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mvCGoG39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfLPQ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:59:22 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45845 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:59:21 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so4570338ioi.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wT7SZ+OLO630PVI5NYrvDjy+jNlP7/vPSuqmUxImjRI=;
        b=mvCGoG390lkQhIGt10C5uJOnQlDLqM7ckcj5+vO5/E5UBpBhaLT0+k2/e7I4DLcEeY
         2ifgfrg+zjpexA6m1T2Ge1sRCpRRTyvEIhEZTAMP9J664HhTWziOuDAb1+iyH7srY7PA
         ozqRWgCYhHDvJDJ5yuT6pDwnFshn+bjNE7YmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wT7SZ+OLO630PVI5NYrvDjy+jNlP7/vPSuqmUxImjRI=;
        b=B41oQut99KneaL0QIwK1b9AhDBU3T4zZR8il6+iRhzF3O2oP8gzWvbQ4lIJFt0ab5r
         jzhp0ERUjIOFZUDVdIU6TEUvKdYJZ8ikebah/LYq/9bYqjkbEeq7gcQcNKCtY7yayQ1p
         3TSg1B6p+6axj+oZwq6GPsjIBV+Y4FMK33K/Yr3Nh67un+mBAXHbysr1LUgWOIJEjqWJ
         qtl6G5/JXAiyUFvL0jBwofOvAZg8TfiUBgzDL1eEclIXQ8vIEHB0E38rllgY3TYTDcwf
         lg6uf3aiQoA7lfDM/S+WUM2A/1QFsbqIH4b+Qa0svuA28tEgBvnVpMw4+PPE9+idMEWd
         zgTQ==
X-Gm-Message-State: APjAAAXzamcOaTWYLWmSKUsBTmTMnJWNCTYr13iYoBCVp8WAPdI216r4
        T21SeRllOyefxTE0qIFRLr8azovV1RG9l+WULOquzA==
X-Google-Smtp-Source: APXvYqxdRoeWD1Tywgum5/3SAGtinVvAq8t3n49rScn14Yz2lW3axKTMURLW3omvXjZ5mdfPRnnhCaLiPDyJLxS1qSY=
X-Received: by 2002:a05:6602:2504:: with SMTP id i4mr19060859ioe.173.1576515559642;
 Mon, 16 Dec 2019 08:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
 <20191203134816.5319-2-jagan@amarulasolutions.com> <20191204133600.gnv6dnhk6upe7xod@gilmour.lan>
 <CAMty3ZDU57Hj3ZSBC6sSMFWN9-HQadA03hmXUNUVS1W0UQQ3DA@mail.gmail.com> <20191216112042.f4xvlgnbm4dk6wkq@gilmour.lan>
In-Reply-To: <20191216112042.f4xvlgnbm4dk6wkq@gilmour.lan>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 16 Dec 2019 22:29:08 +0530
Message-ID: <CAMty3ZBU-XaxR_vM5L2yVbhR5ftfbtDn3jP00qCxBF+owVyqDQ@mail.gmail.com>
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

On Mon, Dec 16, 2019 at 4:50 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Dec 16, 2019 at 04:37:20PM +0530, Jagan Teki wrote:
> > On Wed, Dec 4, 2019 at 7:06 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Tue, Dec 03, 2019 at 07:18:10PM +0530, Jagan Teki wrote:
> > > > The MIPI DSI controller in Allwinner A64 is similar to A33.
> > > >
> > > > But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> > > > to have separate compatible for A64 on the same driver.
> > > >
> > > > DSI_SCLK uses mod clock-names on dt-bindings, so the same
> > > > is not required for A64.
> > > >
> > > > On that note
> > > > - A64 require minimum of 1 clock like the bus clock
> > > > - A33 require minimum of 2 clocks like both bus, mod clocks
> > > >
> > > > So, update dt-bindings so-that it can document both A33,
> > > > A64 bindings requirements.
> > > >
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > > Changes for v12:
> > > > - Use 'enum' instead of oneOf+const
> > > >
> > > >  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
> > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > index dafc0980c4fa..b91446475f35 100644
> > > > --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > > > @@ -15,7 +15,9 @@ properties:
> > > >    "#size-cells": true
> > > >
> > > >    compatible:
> > > > -    const: allwinner,sun6i-a31-mipi-dsi
> > > > +    enum:
> > > > +      - allwinner,sun6i-a31-mipi-dsi
> > > > +      - allwinner,sun50i-a64-mipi-dsi
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -24,6 +26,8 @@ properties:
> > > >      maxItems: 1
> > > >
> > > >    clocks:
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > >      items:
> > > >        - description: Bus Clock
> > > >        - description: Module Clock
> > > > @@ -63,13 +67,25 @@ required:
> > > >    - reg
> > > >    - interrupts
> > > >    - clocks
> > > > -  - clock-names
> > > >    - phys
> > > >    - phy-names
> > > >    - resets
> > > >    - vcc-dsi-supply
> > > >    - port
> > > >
> > > > +allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +         compatible:
> > > > +           contains:
> > > > +             const: allwinner,sun6i-a31-mipi-dsi
> > > > +      then:
> > > > +        properties:
> > > > +          clocks:
> > > > +            minItems: 2
> > > > +        required:
> > > > +          - clock-names
> > > > +
> > >
> > > Your else condition should check that the number of clocks items is 1
> > > on the A64
> >
> > But the minItems mentioned as 1 in clocks, which is unchanged number
> > by default. doesn't it sufficient?
>
> In the main schema, it's said that the clocks property can have one or
> two elements (to cover the A31 case that has one, and the A64 case
> that has 2).
>
> This is fine.
>
> Later on, you enforce that the A64 has two elements, and this is fine
> too.

Actually A31 case has 2 and A64 case has 1.

>
> However, you never check that on the A31 you only have one clock, and
> you could very well have two and no one would notice.

I did check A31 case for 2 but not in A64. this is what you mean? so
adding A64 check like below would fine?

allOf:
  - if:
      properties:
         compatible:
           contains:
             const: allwinner,sun6i-a31-mipi-dsi
      then:
        properties:
          clocks:
            minItems: 2
        required:
          - clock-names
  - if:
      properties:
         compatible:
           contains:
             const: allwinner,sun50i-a64-mipi-dsi
      then:
        properties:
          clocks:
            minItems: 1
