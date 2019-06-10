Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1747C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FBC2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560179667;
	bh=P0dkD9ENiSJ+hO8sohQ82M4kCSPlYg9QTn6ACh1pGBM=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=gAbWQlc8OshFbfbE1T7hYVDMq9vJN+fZf28L7uXt5XP3j1ote0VWbIvW3ozHQBiD3
	 VfAgRdU3rW9ytt6IDji2Eq8vgM0MIKNhXVmgwIcz0O2ckcfPj74PrL1EJBByjkFuNs
	 tY4CXdRTleAvan1RP505A4zgThwvwwGbfhWH8vKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391112AbfFJPO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389999AbfFJPO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:14:26 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8139207E0;
        Mon, 10 Jun 2019 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560179666;
        bh=P0dkD9ENiSJ+hO8sohQ82M4kCSPlYg9QTn6ACh1pGBM=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=t/3aX0FvHhHEPaDvxLC/Zt72Z7M8KIX/RV4nCGE26f5wvCqRAHSDFsqqyMKDezdSK
         Xl2KSBSHTNZKMlEfsDGPkQTwOxV+jTJYQSxnTn5KPI5682IJHA0IEh2WBH09u9Pabp
         UNDXWvPZA+0vbsuahyuhEOhz5rGFaIGoHZHPVXOY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB3PR0402MB391678C245944942EA2A7F62F5110@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com> <20190604015928.23157-3-Anson.Huang@nxp.com> <20190606162543.EFFB820645@mail.kernel.org> <DB3PR0402MB391625A0B3D838CE88C53E33F5100@DB3PR0402MB3916.eurprd04.prod.outlook.com> <20190607180039.611C7208C0@mail.kernel.org> <DB3PR0402MB391678C245944942EA2A7F62F5110@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix .de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
User-Agent: alot/0.8.1
Date:   Mon, 10 Jun 2019 08:14:25 -0700
Message-Id: <20190610151425.D8139207E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-06-08 02:58:18)
> Hi, Stephen
>=20
> > -----Original Message-----
> > From: Stephen Boyd <sboyd@kernel.org>
> > Sent: Saturday, June 8, 2019 2:01 AM
> > To: bjorn.andersson@linaro.org; catalin.marinas@arm.com;
> > devicetree@vger.kernel.org; dinguyen@kernel.org;
> > enric.balletbo@collabora.com; festevam@gmail.com;
> > horms+renesas@verge.net.au; jagan@amarulasolutions.com;
> > kernel@pengutronix.de; l.stach@pengutronix.de; linux-arm-
> > kernel@lists.infradead.org; linux-clk@vger.kernel.org; linux-
> > kernel@vger.kernel.org; mark.rutland@arm.com;
> > maxime.ripard@bootlin.com; mturquette@baylibre.com; olof@lixom.net;
> > robh+dt@kernel.org; s.hauer@pengutronix .de <s.hauer@pengutronix.de>;
> > shawnguo@kernel.org; will.deacon@arm.com; Abel Vesa
> > <abel.vesa@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Anson
> > Huang <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Leonard
> > Crestez <leonard.crestez@nxp.com>
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: RE: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock dri=
ver
> >=20
> > Quoting Anson Huang (2019-06-06 17:50:28)
> > >
> > > I will use devm_platform_ioremap_resource() instead of ioremap(), and
> > > can you be more specific about devmified clk registration?
> > >
> >=20
> > I mean using things like devm_clk_hw_register().
>=20
> Sorry, I am still a little confused, all the clock register(clk_register(=
)) are via each different
> clock types like imx_clk_gate4/imx_clk_pll14xx, if using clk_hw_register,=
 means we need
> to re-write the clock driver using different clk register method, that wi=
ll make the driver
> completely different from i.mx8mq/i.mx8mm, they are actually same series =
of SoC as i.mx8mn,
> it will introduce many confusion, is my understanding correct? And is it =
OK to just keep what
> it is and make them all aligned?
>=20

Ok, the problem I'm trying to point out is that clk registrations need
to be undone, i.e. clk_unregister() needs to be called, when the driver
fails to probe. devm_*() is one way to do this, but if you have other
ways of removing all the registered clks then that works too. Makes
sense?

