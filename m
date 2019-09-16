Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8111EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575AF214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568658775;
	bh=tGbgQXC0MLIMph9i8iPtfJHaRUqvcrZYiWDIfiq9yPg=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=BE1Qot+t0qjkoLUMZIq0jCJIaTJsp4Md+AEbU0Ah80LnJqGkb/1WUwuBS2vGRs7Vi
	 pAG7klDJ62z7hkpOKRxXo3iAILN1b48ajIMFPMUYagFmQ6eOWtUggX+hUvg9JU3Tmb
	 YH17lStr3eSZhwdmiZB72a3jiZeaOi/1yQHA3gaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbfIPScy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbfIPScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:32:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E360720830;
        Mon, 16 Sep 2019 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568658773;
        bh=tGbgQXC0MLIMph9i8iPtfJHaRUqvcrZYiWDIfiq9yPg=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=Evmir6osXsKDL0nl+tpO2zp5kvCCW0B6ipAsu9ekOEBw1bL4nZHHVh2107KHj/IO+
         N4dxjoCCW+6/sFLDp4Uk68KgYI5pLSnQcAkF6IUlAxT2bszMtvIwtHgFdUGdNOmTdk
         DN6En7/q67Kg+LQJFc4E4rDMkhZ2PhbGr/zk+kOQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB7PR04MB519563FED2146F6D1327668AE2AB0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190815101613.22872-1-wen.he_1@nxp.com> <20190815101613.22872-2-wen.he_1@nxp.com> <20190816174624.115FC205F4@mail.kernel.org> <DB7PR04MB51952DF4E1EE7FF10A947347E2A80@DB7PR04MB5195.eurprd04.prod.outlook.com> <20190819182944.4AEAB22CF5@mail.kernel.org> <DB7PR04MB519563FED2146F6D1327668AE2AB0@DB7PR04MB5195.eurprd04.prod.outlook.com>
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
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [EXT] Re: [v2 2/3] clk: ls1028a: Add clock driver for Display output interface
User-Agent: alot/0.8.1
Date:   Mon, 16 Sep 2019 11:32:52 -0700
Message-Id: <20190916183252.E360720830@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-19 19:24:25)
>=20
> >=20
> > > > > +
> > > > > +static int plldig_clk_probe(struct platform_device *pdev) {
> > > > > +       struct clk_plldig *data;
> > > > > +       struct resource *mem;
> > > > > +       const char *parent_name;
> > > > > +       struct clk_init_data init =3D {};
> > > > > +       struct device *dev =3D &pdev->dev;
> > > > > +       int ret;
> > > > > +
> > > > > +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > > > > +       if (!data)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > > +       data->regs =3D devm_ioremap_resource(dev, mem);
> > > > > +       if (IS_ERR(data->regs))
> > > > > +               return PTR_ERR(data->regs);
> > > > > +
> > > > > +       init.name =3D dev->of_node->name;
> > > > > +       init.ops =3D &plldig_clk_ops;
> > > > > +       parent_name =3D of_clk_get_parent_name(dev->of_node, 0);
> > > > > +       init.parent_names =3D &parent_name;
> > > >
> > > > Can you use the new way of specifying clk parents with the
> > > > parent_data member of clk_init?
> > >
> > > Of course, but I don't understand why need recommend to use this memb=
er?
> > > Is that the member parent_names will be discard in future?
> > >
> > > Here are definition of the clk-provider.h
> > > /* Only one of the following three should be assigned */
> > > const char              * const *parent_names;
> > > const struct clk_parent_data    *parent_data;
> > > const struct clk_hw             **parent_hws;
> > >
> > > For PLLDIG, it only has one parent.
> >=20
> > Yes. Can you use clk_parent_data array and specify a DT index of 0 and =
some
> > name that would go into "clock-names" in the .fw_name member?
>=20
> OK, but .fw_name used for to registering clk, current it registered with =
fixed clk in dts .
> I think should be specify a DT index of 0 and specify the unique name for=
 .name member.
>=20
> I found have two ways to specify:
> 1. declare clk_parent_data variable parent_data, and initialization with =
clk_init_data, like this:
> =20
> parent_data.name =3D of_clk_get_parent_name(dev->of_node, 0);=20

This isn't preferred because of_clk_get_parent_name() is DT specific and
relies on the parent clk being registered before calling the function so
that we can figure out the globally unique name.

> parent_data.index =3D 0;
>=20
> init.name =3D dev->of_node->name;
> init.ops =3D &plldig_clk_ops;
> init.parent_data =3D &parent_data;
> init.num_parents =3D 1;
>=20
> 2. Or use a static const array for here? And put the unique name and inde=
x like this.
> static const struct clk_parent_data parent_data[] =3D {
>         {.name =3D "phy_27m", .index =3D 0},
> };
>=20
> After then initialization with macro CLK_HW_INIT_PARENTS_DATA?

Yes use option #2. But, don't even specify a .name if this is new code
because .name is a fallback mechanism that is supposed to be used if
you're migrating code from an older DT to a newer DT. I don't think
that's happening here.

