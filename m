Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D1C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645682071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="nh2sZuFY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tUlRfaSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKVSS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:18:26 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33779 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbfKVSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:18:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 202063998;
        Fri, 22 Nov 2019 13:18:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 22 Nov 2019 13:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=9N1i6sM3HCy/tNUXBVN7iRT2F5Y
        r7eksrFzwBiYgpho=; b=nh2sZuFYIt8yPQNDtUg558rh4e2QQvCiHerjNYwzgv4
        LqLpSGFkFJPX5uQKmD6n2pjOVqW/a9WVdtdv6kGEarEceQFrClDpdkuts24xd2Lp
        mdMjaR8heQiRnkjZCAfV3T8HkkV9fkQDUW6J6LxWRI0zGMczNR2/IrEWut/9HSBd
        Nzr5VQUcLWJEtjeWGShw/tASVnXZjrBb9AzRmLdxwFrKNTe7UmQPurP+x+Z4agDP
        bTdiX9sNRiaU3DI+Y4wn1RwsOJOQ0qrZFOQac0B1cAO4OTyqYT/2VuWpBenzeH8J
        QK8k8SLgKkSuRuA1LVysrruQbBx1Sv0x2t/R6j8zBbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9N1i6s
        M3HCy/tNUXBVN7iRT2F5Yr7eksrFzwBiYgpho=; b=tUlRfaSe7dnWGjC/4oqkwU
        DnVPoFdhTAooLtwcBlcr9LoDIrmqoc+PXvsEXLvUh3fLsbmVYjgGb4GTd4N78MES
        KHH+QuqWR+8MFDc5lCY5XcMc1JCpn8pWJDAvo4IeL3/VEjUOdOQHKrdDTLBZNzGb
        MD4swZ7Q26NKS0ccl/mk62jqCdpm3zFqQhkEFEIyETMKpTkcOTcxmGJdoN1gKHgP
        jdJkcRQQydp4CvXHIUb5dW2SiG5gaVSAO5/w9c21O4x2IPFvzdxZLtWeCj9Ax0Ga
        rln+OiPE3vNu6fpl5r6R55X/pCRJP5e51QZs5ZEaknCoh8fI5RqtXuizScfQT6CA
        ==
X-ME-Sender: <xms:bybYXctraIKC9Ia6PR9cXef2XF9PpJyM8T0BFKZAxq7idoCmZWXoHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehgedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppe
    eltddrkeelrdeikedrjeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvges
    tggvrhhnohdrthgvtghhnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:bybYXT0v4144JRl8VXwXEAsfBCtRKNtlMwtcy3u9Ny2uO9d4LKcRBg>
    <xmx:bybYXTVsQZGE9Xzi43eQzNvHL1jtTuI4Ax86IGepDtNxqfFmA_Ah1Q>
    <xmx:bybYXZNrjqQYRuZ8AT6NUg6Fd1wrK0F0ac8HxpjrbW-lK7T2tP1Avw>
    <xmx:cCbYXcyRcR-gSTwuJWfp7f70EdyehoT-1yL1cc8P4nYlCYZCWI_jnA>
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 924C580061;
        Fri, 22 Nov 2019 13:18:22 -0500 (EST)
Date:   Fri, 22 Nov 2019 19:18:20 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20191122181820.GQ4345@gilmour.lan>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-5-jagan@amarulasolutions.com>
 <20191028153427.pc3tnoz2d23filhx@hendrix>
 <CAMty3ZCisTrFGjzHyqSofqFAsKSLV1n2xP5Li3Lonhdi0WUZVA@mail.gmail.com>
 <20191029085401.gvqpwmmpyml75vis@hendrix>
 <CAMty3ZAWPZSHtAZDf_0Dpx588YGGv3pJX1cXMfkZus3+WF94cA@mail.gmail.com>
 <20191103173227.GF7001@gilmour>
 <CAMty3ZD5uxU=xb0z7PWaXzodYbWRJkP9HjGX-HZYFT4bwk0GOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qerVZHYPvsyvugus"
Content-Disposition: inline
In-Reply-To: <CAMty3ZD5uxU=xb0z7PWaXzodYbWRJkP9HjGX-HZYFT4bwk0GOg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qerVZHYPvsyvugus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Nov 21, 2019 at 05:24:47PM +0530, Jagan Teki wrote:
> On Sun, Nov 3, 2019 at 11:02 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Fri, Nov 01, 2019 at 07:42:55PM +0530, Jagan Teki wrote:
> > > Hi Maxime,
> > >
> > > On Tue, Oct 29, 2019 at 2:24 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > >
> > > > On Tue, Oct 29, 2019 at 04:03:56AM +0530, Jagan Teki wrote:
> > > > > > > explicit handling of common clock would require since the A64
> > > > > > > doesn't need to mention the clock-names explicitly in dts since it
> > > > > > > support only one bus clock.
> > > > > > >
> > > > > > > Also pass clk_id NULL instead "bus" to regmap clock init function
> > > > > > > since the single clock variants no need to mention clock-names
> > > > > > > explicitly.
> > > > > >
> > > > > > You don't need explicit clock handling. Passing NULL as the argument
> > > > > > in regmap_init_mmio_clk will make it use the first clock, which is the
> > > > > > bus clock.
> > > > >
> > > > > Indeed I tried that, since NULL clk_id wouldn't enable the bus clock
> > > > > during regmap_mmio_gen_context code, passing NULL triggering vblank
> > > > > timeout.
> > > >
> > > > There's a bunch of users of NULL in tree, so finding out why NULL
> > > > doesn't work is the way forward.
> > >
> > > I'd have looked the some of the users before checking the code as
> > > well. As I said passing NULL clk_id to devm_regmap_init_mmio_clk =>
> > > __devm_regmap_init_mmio_clk would return before processing the clock.
> > >
> > > Here is the code snippet on the tree just to make sure I'm on the same
> > > page or not.
> > >
> > > static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
> > >                                         const char *clk_id,
> > >                                         void __iomem *regs,
> > >                                         const struct regmap_config *config)
> > > {
> > >         -----------------------
> > >         --------------
> > >         if (clk_id == NULL)
> > >                 return ctx;
> > >
> > >         ctx->clk = clk_get(dev, clk_id);
> > >         if (IS_ERR(ctx->clk)) {
> > >                 ret = PTR_ERR(ctx->clk);
> > >                 goto err_free;
> > >         }
> > >
> > >         ret = clk_prepare(ctx->clk);
> > >         if (ret < 0) {
> > >                 clk_put(ctx->clk);
> > >                 goto err_free;
> > >         }
> > >         -------------
> > >         ---------------
> > > }
> > >
> > > Yes, I did check on the driver in the tree before committing explicit
> > > clock handle, which make similar requirements like us in [1]. this
> > > imx2 wdt driver is handling the explicit clock as well. I'm sure this
> > > driver is updated as I have seen few changes related to this driver in
> > > ML.
> >
> > I guess we have two ways to go at this then.
> >
> > Either we remove the return, but it might have a few side-effects, or
> > we call clk_get with NULL or bus depending on the case, and then call
> > regmap_mmio_attach_clk.
>
> Thanks for the inputs.
>
> Please have a look at this snippet, I have used your second
> suggestions. let me know if you have any comments?
>
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 8fa90cfc2ac8..91c95e56d870 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -1109,24 +1109,36 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>          return PTR_ERR(dsi->regulator);
>      }
>
> -    dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
> -                          &sun6i_dsi_regmap_config);
> -    if (IS_ERR(dsi->regs)) {
> -        dev_err(dev, "Couldn't create the DSI encoder regmap\n");
> -        return PTR_ERR(dsi->regs);
> -    }
> -
>      dsi->reset = devm_reset_control_get_shared(dev, NULL);
>      if (IS_ERR(dsi->reset)) {
>          dev_err(dev, "Couldn't get our reset line\n");
>          return PTR_ERR(dsi->reset);
>      }
>
> +    dsi->regs = regmap_init_mmio(dev, base, &sun6i_dsi_regmap_config);

You should use the devm variant here

> +    if (IS_ERR(dsi->regs)) {
> +        dev_err(dev, "Couldn't init regmap\n");
> +        return PTR_ERR(dsi->regs);
> +    }
> +
> +    dsi->bus_clk = devm_clk_get(dev, NULL);

I guess you still need to pass 'bus' here?

> +    if (IS_ERR(dsi->bus_clk)) {
> +        dev_err(dev, "Couldn't get the DSI bus clock\n");
> +        ret = PTR_ERR(dsi->bus_clk);
> +        goto err_regmap;
> +    } else {
> +        printk("Jagan.. Got the BUS clock\n");
> +        ret = regmap_mmio_attach_clk(dsi->regs, dsi->bus_clk);
> +        if (ret)
> +            goto err_bus_clk;
> +    }
> +
>      if (dsi->variant->has_mod_clk) {
>          dsi->mod_clk = devm_clk_get(dev, "mod");
>          if (IS_ERR(dsi->mod_clk)) {
>              dev_err(dev, "Couldn't get the DSI mod clock\n");
> -            return PTR_ERR(dsi->mod_clk);
> +            ret = PTR_ERR(dsi->mod_clk);
> +            goto err_attach_clk;
>          }
>      }
>
> @@ -1167,6 +1179,14 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
>  err_unprotect_clk:
>      if (dsi->variant->has_mod_clk)
>          clk_rate_exclusive_put(dsi->mod_clk);
> +err_attach_clk:
> +    if (!IS_ERR(dsi->bus_clk))
> +        regmap_mmio_detach_clk(dsi->regs);
> +err_bus_clk:
> +    if (!IS_ERR(dsi->bus_clk))
> +        clk_put(dsi->bus_clk);
> +err_regmap:
> +    regmap_exit(dsi->regs);
>      return ret;
>  }
>
> @@ -1181,6 +1201,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
>      if (dsi->variant->has_mod_clk)
>          clk_rate_exclusive_put(dsi->mod_clk);
>
> +    if (!IS_ERR(dsi->bus_clk)) {
> +        regmap_mmio_detach_clk(dsi->regs);
> +        clk_put(dsi->bus_clk);

This will trigger a warning, you put down the reference twice

Maxime

--qerVZHYPvsyvugus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdgmbAAKCRDj7w1vZxhR
xXAPAQCiQx8necDbZpLfsv/R7X/EGLZepkaO/cE23lMNJwmGIAD9FSP48+7pcnm3
HhzifgMtZzRSaH/EgCQpjsJg+5eqUwc=
=GeTa
-----END PGP SIGNATURE-----

--qerVZHYPvsyvugus--
