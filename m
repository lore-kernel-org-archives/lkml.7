Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC22C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE3221771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="DFl5tTg+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+MOEEjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfK1Rvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:51:41 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37491 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726569AbfK1Rvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:51:40 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8DFB1342C;
        Thu, 28 Nov 2019 12:51:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 28 Nov 2019 12:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZW6UxhH0Hm8lRDs/4M+dETDPOEm
        QhBVGqXhRss+nCzY=; b=DFl5tTg+prW79LfU+kzaWtNO/eowldIHYBmvX2oICxC
        z4QBHxeowgDuQeqF/wcvVgXCD/JIA7vUBEnxyFJKacjnmq2D5DhVBaPUyJEFFNpr
        ui0s990Z5w369E8CqQ+ROh372czQk2SQbSIwDUsymMubr/RBjguRYmpQqB6UX/2P
        6bztS8S/q4uHFsQBkzNv6PQIemC7eQEEHVVW2adweCXZ8ms6fKQ0gGPz+WQpeHgc
        mTugC6RfzC4yEu5nmcPLeKpcyHCSIA3gIaLXACbUgvWmjBsUztGVm6BthVVr4c/X
        HpP8gyUiQ0b1BiXXkDwNBYfnlrWLB+73QCcjPQPcdVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZW6Uxh
        H0Hm8lRDs/4M+dETDPOEmQhBVGqXhRss+nCzY=; b=v+MOEEjFVGd6R+cUGyIQEp
        8BBMItY604U7PPVeZD8V6/l/Zrk6WUqRBidI5gGkP50HSr9OnjMCT851g1HvqL5Y
        Q41d5T1R6mncxHXSErZpagb8ilXLBOWo7UG3q4R0MuBK82jFxXeMEw8AtlVBgyQQ
        uT1dXj5P/x3KBHZZoIISmoZsljpqIq9UF7MNiONNRzf8SEVM07+nDYMsIJ7kEibe
        flsO0R1+TMPHeh2VahjVuhvzMa9gJLdp0HIntlM0IiaqId/hra/wZfXV//jP3tgi
        fOhgy4BJpUtf/rzV9atguRr7uaTIlXjgQj5M9TidtAQEBG98CIqwxpjy9ipy0y3w
        ==
X-ME-Sender: <xms:KgngXUFvbDaLBE-pkVmL-IxdYmhi9W6pBOi4-tLooEaa_Un3SFr1AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkpheple
    dtrdekledrieekrdejieenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegt
    vghrnhhordhtvggthhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:KgngXfpoBSPQMERQxdBXb7UMv4jVWUx_iGIDaIq5z7fVAfcpwFCD7g>
    <xmx:KgngXc2r6XTst-90cPb2zh8ENJeZomZc3A3JB1-CFogecHw1dGTnFg>
    <xmx:KgngXTBqAVjTXmpxTGOGdsJwwEPeMFdXLCarHVw-0XSOhJ9eAf8_Lg>
    <xmx:KwngXfHecfjCy8435wuh4o8afqIqEiTRcu0y9GlfBm3Z9wGu7i1Y0A>
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DEE4180061;
        Thu, 28 Nov 2019 12:51:37 -0500 (EST)
Date:   Thu, 28 Nov 2019 18:51:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v11 4/7] drm/sun4i: dsi: Handle bus clock explicitly
Message-ID: <20191128175134.kcgtylfo4ax6ifz7@gilmour.lan>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-5-jagan@amarulasolutions.com>
 <20191028153427.pc3tnoz2d23filhx@hendrix>
 <CAMty3ZCisTrFGjzHyqSofqFAsKSLV1n2xP5Li3Lonhdi0WUZVA@mail.gmail.com>
 <20191029085401.gvqpwmmpyml75vis@hendrix>
 <CAMty3ZAWPZSHtAZDf_0Dpx588YGGv3pJX1cXMfkZus3+WF94cA@mail.gmail.com>
 <20191103173227.GF7001@gilmour>
 <CAMty3ZD5uxU=xb0z7PWaXzodYbWRJkP9HjGX-HZYFT4bwk0GOg@mail.gmail.com>
 <20191122181820.GQ4345@gilmour.lan>
 <CAMty3ZDePC=B-DgfCcjRhJTeciwZmSEU-c4u1=sN_Hs0RgbC7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tueqnmro5e6uu24k"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDePC=B-DgfCcjRhJTeciwZmSEU-c4u1=sN_Hs0RgbC7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tueqnmro5e6uu24k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 23, 2019 at 01:20:21AM +0530, Jagan Teki wrote:
> > > Please have a look at this snippet, I have used your second
> > > suggestions. let me know if you have any comments?
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > index 8fa90cfc2ac8..91c95e56d870 100644
> > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > @@ -1109,24 +1109,36 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >          return PTR_ERR(dsi->regulator);
> > >      }
> > >
> > > -    dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
> > > -                          &sun6i_dsi_regmap_config);
> > > -    if (IS_ERR(dsi->regs)) {
> > > -        dev_err(dev, "Couldn't create the DSI encoder regmap\n");
> > > -        return PTR_ERR(dsi->regs);
> > > -    }
> > > -
> > >      dsi->reset = devm_reset_control_get_shared(dev, NULL);
> > >      if (IS_ERR(dsi->reset)) {
> > >          dev_err(dev, "Couldn't get our reset line\n");
> > >          return PTR_ERR(dsi->reset);
> > >      }
> > >
> > > +    dsi->regs = regmap_init_mmio(dev, base, &sun6i_dsi_regmap_config);
> >
> > You should use the devm variant here
>
> Sure.
>
> >
> > > +    if (IS_ERR(dsi->regs)) {
> > > +        dev_err(dev, "Couldn't init regmap\n");
> > > +        return PTR_ERR(dsi->regs);
> > > +    }
> > > +
> > > +    dsi->bus_clk = devm_clk_get(dev, NULL);
> >
> > I guess you still need to pass 'bus' here?
>
> But the idea here is not to specify clock name explicitly to support
> A64. otherwise A64 would fail as we are not specifying the clock-names
> explicitly on dsi node.

Right. But you have no guarantee that the bus clock is going to be the
first one on the other SoCs either.

What about something like that instead:

char *clk_name = NULL;
if (dsi->has_mod_clk)
    clk_name = "bus";

clk = devm_clk_get(dev, clk_name);
if (IS_ERR(clk))
    return PTR_ERR(clk));

regmap_mmio_attach_clk(regmap, clk);

>
> dsi: dsi@1ca0000 {
>        compatible = "allwinner,sun50i-a64-mipi-dsi";
>        reg = <0x01ca0000 0x1000>;
>        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>        clocks = <&ccu CLK_BUS_MIPI_DSI>;
>        resets = <&ccu RST_BUS_MIPI_DSI>;
>       phys = <&dphy>;
>       phy-names = "dphy";
> .....
> };
>
> >
> > > +    if (IS_ERR(dsi->bus_clk)) {
> > > +        dev_err(dev, "Couldn't get the DSI bus clock\n");
> > > +        ret = PTR_ERR(dsi->bus_clk);
> > > +        goto err_regmap;
> > > +    } else {
> > > +        printk("Jagan.. Got the BUS clock\n");
> > > +        ret = regmap_mmio_attach_clk(dsi->regs, dsi->bus_clk);
> > > +        if (ret)
> > > +            goto err_bus_clk;
> > > +    }
> > > +
> > >      if (dsi->variant->has_mod_clk) {
> > >          dsi->mod_clk = devm_clk_get(dev, "mod");
> > >          if (IS_ERR(dsi->mod_clk)) {
> > >              dev_err(dev, "Couldn't get the DSI mod clock\n");
> > > -            return PTR_ERR(dsi->mod_clk);
> > > +            ret = PTR_ERR(dsi->mod_clk);
> > > +            goto err_attach_clk;
> > >          }
> > >      }
> > >
> > > @@ -1167,6 +1179,14 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
> > >  err_unprotect_clk:
> > >      if (dsi->variant->has_mod_clk)
> > >          clk_rate_exclusive_put(dsi->mod_clk);
> > > +err_attach_clk:
> > > +    if (!IS_ERR(dsi->bus_clk))
> > > +        regmap_mmio_detach_clk(dsi->regs);
> > > +err_bus_clk:
> > > +    if (!IS_ERR(dsi->bus_clk))
> > > +        clk_put(dsi->bus_clk);
> > > +err_regmap:
> > > +    regmap_exit(dsi->regs);
> > >      return ret;
> > >  }
> > >
> > > @@ -1181,6 +1201,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
> > >      if (dsi->variant->has_mod_clk)
> > >          clk_rate_exclusive_put(dsi->mod_clk);
> > >
> > > +    if (!IS_ERR(dsi->bus_clk)) {
> > > +        regmap_mmio_detach_clk(dsi->regs);
> > > +        clk_put(dsi->bus_clk);
> >
> > This will trigger a warning, you put down the reference twice
>
> You mean regmap_mmio_detach_clk will put the clk?

No, devm_clk_get will.

Maxime

--tueqnmro5e6uu24k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXeAJJgAKCRDj7w1vZxhR
xeTeAQCacNpV8Wm/rBcNEWf932Rl1dECN/23C4NSORo+wFWl+QEA9eslBkFZsEsR
8bsW4OOl0eHdwYb6HSh9C+3pq52yBgU=
=UsjM
-----END PGP SIGNATURE-----

--tueqnmro5e6uu24k--
