Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5D9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE5B22CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566239387;
	bh=9KJGx4BFkLMtrPddjIKIua8/xZfK4VKXBzqHl/frVIw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=G2rjU7/5//EoDgjDkOl7qljlxhiboVgME06pVAd7vB6TufEvEXf6CVE+Y3GVHwyRq
	 /zj8In4hNkzsFZ6/GKzuMPrLZaJjohuYDrmxANKkTEnUZcJY+L/ZCA4OUbtavXf4cH
	 idAkNxS/uhXdRlRrlzI2aJcQOt/m0VK2oR8J1Nco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfHSS3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbfHSS3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:29:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AEAB22CF5;
        Mon, 19 Aug 2019 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566239384;
        bh=9KJGx4BFkLMtrPddjIKIua8/xZfK4VKXBzqHl/frVIw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vObOdoZKBzOLrl+OrfoUeLAklcAUefsz/QYIMD+BcxP8U/tKL8PrRLfKRvwIke1it
         bKOK0sgBpBpB/vR1zPMm15U3fXNnhL2qvD4McWE+3CuzpONZyhAlXnemnO1a0sBD3q
         1+jtq4C2psjvM4Wk9hKu2hyqvShaQ1VYqPg6ciM0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB7PR04MB51952DF4E1EE7FF10A947347E2A80@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190815101613.22872-1-wen.he_1@nxp.com> <20190815101613.22872-2-wen.he_1@nxp.com> <20190816174624.115FC205F4@mail.kernel.org> <DB7PR04MB51952DF4E1EE7FF10A947347E2A80@DB7PR04MB5195.eurprd04.prod.outlook.com>
Subject: RE: [EXT] Re: [v2 2/3] clk: ls1028a: Add clock driver for Display output interface
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Wen He <wen.he_1@nxp.com>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 11:29:43 -0700
Message-Id: <20190819182944.4AEAB22CF5@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-19 00:30:49)
> > Quoting Wen He (2019-08-15 03:16:12)
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
> > > 801fa1cd0321..3c95d8ec31d4 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -223,6 +223,16 @@ config CLK_QORIQ
> > >           This adds the clock driver support for Freescale QorIQ plat=
forms
> > >           using common clock framework.
> > >
> > > +config CLK_LS1028A_PLLDIG
> > > +        bool "Clock driver for LS1028A Display output"
> > > +       depends on (ARCH_LAYERSCAPE || COMPILE_TEST) && OF
> >=20
> > Where is the OF dependency to build anything? Doesn't this still compile
> > without CONFIG_OF set?
>=20
> Yes, current included some APIs of the OF, like of_get_parent_name()

And there isn't a stub API for of_get_parent_name when OF isn't defined?

> > > +
> > > +static int plldig_clk_probe(struct platform_device *pdev) {
> > > +       struct clk_plldig *data;
> > > +       struct resource *mem;
> > > +       const char *parent_name;
> > > +       struct clk_init_data init =3D {};
> > > +       struct device *dev =3D &pdev->dev;
> > > +       int ret;
> > > +
> > > +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > > +       if (!data)
> > > +               return -ENOMEM;
> > > +
> > > +       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       data->regs =3D devm_ioremap_resource(dev, mem);
> > > +       if (IS_ERR(data->regs))
> > > +               return PTR_ERR(data->regs);
> > > +
> > > +       init.name =3D dev->of_node->name;
> > > +       init.ops =3D &plldig_clk_ops;
> > > +       parent_name =3D of_clk_get_parent_name(dev->of_node, 0);
> > > +       init.parent_names =3D &parent_name;
> >=20
> > Can you use the new way of specifying clk parents with the parent_data
> > member of clk_init?
>=20
> Of course, but I don't understand why need recommend to use this member?
> Is that the member parent_names will be discard in future?
>=20
> Here are definition of the clk-provider.h
> /* Only one of the following three should be assigned */
> const char              * const *parent_names;
> const struct clk_parent_data    *parent_data;
> const struct clk_hw             **parent_hws;
>=20
> For PLLDIG, it only has one parent.

Yes. Can you use clk_parent_data array and specify a DT index of 0 and
some name that would go into "clock-names" in the .fw_name member?

