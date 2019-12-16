Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C7320725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dP+KqavQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLPLHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:07:33 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35820 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfLPLHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:07:32 -0500
Received: by mail-io1-f66.google.com with SMTP id v18so5446700iol.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfZaSbdFEASJkf9WsXHl71dcv4ETqMgnXgcnwp3Mq+I=;
        b=dP+KqavQmuo0QMDmi4neiVk93gyhwe17pjwdfjNCR4kaW410MUv5U9XBebG0Af2JUg
         uSjY0f9+4haCQspqumE1JA6bnz8vOxRbsSA26BD2mrXZCVUyRjkx08KynOVeOGtZ0Ok4
         rzKSsE7NpKWocqf5Jm4pm2f4YI9vDE48P61aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfZaSbdFEASJkf9WsXHl71dcv4ETqMgnXgcnwp3Mq+I=;
        b=bGnfdkMuVA3huTkE+Vt9yIruWVZHrHNACyVwLm36BF28+5+zVvMEvjmr6ziZQxbz6u
         do40GPCoqlewE4ZqvmA8Xzh0gkgBGJ+Vc12UH9yC80rAZicwbnWGlFspsuqR7Jgewt3d
         Ku6sZUJOpCC0JesOtTKVNpkYT5BPeso4NOBcZWIupawbnl3dF0uAWLQIYhds9DU6p/u/
         l+Yr6nBpe4H7HnUXPkbt6m7DMaBTgX4oNIyNlwQOv1LB2v/CIU4js1jZ4W58g0SJUwVW
         iSTgJcTlxv3qwSxvhGPIQA5M9zuMir8qoSjWjte/kAyWQg6YpCKocOby4vryCs/DU8nm
         nA2g==
X-Gm-Message-State: APjAAAX0FjE9TI+XD+7QflbzG/9AxLmXUwDepGvOTD7Y1kgYYI0aGIzS
        vce1G8CxnnfYt1XVWBrY0WMjZgDxB06o627g8/ixaQ==
X-Google-Smtp-Source: APXvYqxYm4/U2soHztfqAotrtRHQmYHhxvY2dRK0oTC0bL7+7SnLpoXa+xv9qJGP1N2VQheZkh2UqTeKeOZ/EbOzqgQ=
X-Received: by 2002:a5d:97c9:: with SMTP id k9mr17260864ios.297.1576494451527;
 Mon, 16 Dec 2019 03:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
 <20191203134816.5319-2-jagan@amarulasolutions.com> <20191204133600.gnv6dnhk6upe7xod@gilmour.lan>
In-Reply-To: <20191204133600.gnv6dnhk6upe7xod@gilmour.lan>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 16 Dec 2019 16:37:20 +0530
Message-ID: <CAMty3ZDU57Hj3ZSBC6sSMFWN9-HQadA03hmXUNUVS1W0UQQ3DA@mail.gmail.com>
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

On Wed, Dec 4, 2019 at 7:06 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Tue, Dec 03, 2019 at 07:18:10PM +0530, Jagan Teki wrote:
> > The MIPI DSI controller in Allwinner A64 is similar to A33.
> >
> > But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> > to have separate compatible for A64 on the same driver.
> >
> > DSI_SCLK uses mod clock-names on dt-bindings, so the same
> > is not required for A64.
> >
> > On that note
> > - A64 require minimum of 1 clock like the bus clock
> > - A33 require minimum of 2 clocks like both bus, mod clocks
> >
> > So, update dt-bindings so-that it can document both A33,
> > A64 bindings requirements.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v12:
> > - Use 'enum' instead of oneOf+const
> >
> >  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > index dafc0980c4fa..b91446475f35 100644
> > --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > @@ -15,7 +15,9 @@ properties:
> >    "#size-cells": true
> >
> >    compatible:
> > -    const: allwinner,sun6i-a31-mipi-dsi
> > +    enum:
> > +      - allwinner,sun6i-a31-mipi-dsi
> > +      - allwinner,sun50i-a64-mipi-dsi
> >
> >    reg:
> >      maxItems: 1
> > @@ -24,6 +26,8 @@ properties:
> >      maxItems: 1
> >
> >    clocks:
> > +    minItems: 1
> > +    maxItems: 2
> >      items:
> >        - description: Bus Clock
> >        - description: Module Clock
> > @@ -63,13 +67,25 @@ required:
> >    - reg
> >    - interrupts
> >    - clocks
> > -  - clock-names
> >    - phys
> >    - phy-names
> >    - resets
> >    - vcc-dsi-supply
> >    - port
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +         compatible:
> > +           contains:
> > +             const: allwinner,sun6i-a31-mipi-dsi
> > +      then:
> > +        properties:
> > +          clocks:
> > +            minItems: 2
> > +        required:
> > +          - clock-names
> > +
>
> Your else condition should check that the number of clocks items is 1
> on the A64

But the minItems mentioned as 1 in clocks, which is unchanged number
by default. doesn't it sufficient?
