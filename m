Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B2DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E66621924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568826053;
	bh=+VV0O6MMtZyWgdqUHiASXwOLRO7jkiwEUpT92RQzt4g=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=q4bNQdMBkb+Iekn5RRc9N0d4FPaeVO5IgOQFtAmr5CmRQY3l7bjp1TPt0ceMF46qz
	 3Uko2YUYKBilsKZ8Tj6MBK1dtAZ6rQVkSKvQlD2d7X7RPBtvDsmh4dWUmD7BtymmXD
	 2jU+geh05v5TMIYEI1GrCvgdzpxbTPWBQ2gzdtc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfIRRAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbfIRRAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:00:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEAF21848;
        Wed, 18 Sep 2019 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568826051;
        bh=+VV0O6MMtZyWgdqUHiASXwOLRO7jkiwEUpT92RQzt4g=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=1PMW3AoOt/ymX/M1dp08qnsJqv3s/b+YM+GZZMumAjq6O6h/eRnWn0TVcvCuvXQKE
         GIKROoeOINGme7kF9BlLqLmQZ9g5x2+dkI8RtpxuRROFwu0Wrr+xqeVmy4v3YdzPcZ
         2KPRvNqzdwk1QRrlVeSzfqA2zLlNFPqxw2kBVMPk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB7PR04MB51953099D6331F4F844A45EFE28E0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190829105919.44363-1-wen.he_1@nxp.com> <20190829105919.44363-2-wen.he_1@nxp.com> <20190916202637.B5F542067B@mail.kernel.org> <DB7PR04MB51953099D6331F4F844A45EFE28E0@DB7PR04MB5195.eurprd04.prod.outlook.com>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [EXT] Re: [v4 2/2] clk: ls1028a: Add clock driver for Display output interface
User-Agent: alot/0.8.1
Date:   Wed, 18 Sep 2019 10:00:50 -0700
Message-Id: <20190918170051.2AEAF21848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-09-18 02:20:26)
> > -----Original Message-----
> > From: Stephen Boyd <sboyd@kernel.org>
> > Quoting Wen He (2019-08-29 03:59:19)
> > > diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c new
> > > file mode 100644 index 000000000000..d3239bcf59de
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-plldig.c
> > > @@ -0,0 +1,298 @@
[...]
>=20
> >=20
> > > +
> > > +/* Maximum of the divider */
> > > +#define MAX_RFDPHI1          63
> > > +
> > > +/* Best value of multiplication factor divider */
> > > +#define PLLDIG_DEFAULE_MULT         44
> > > +
> > > +/*
> > > + * Clock configuration relationship between the PHI1
> > > +frequency(fpll_phi) and
> > > + * the output frequency of the PLL is determined by the PLLDV,
> > > +according to
> > > + * the following equation:
> > > + * fpll_phi =3D (pll_ref * mfd) / div_rfdphi1  */ struct
> > > +plldig_phi1_param {
> > > +       unsigned long rate;
> > > +       unsigned int rfdphi1;
> > > +       unsigned int mfd;
> > > +};
> > > +
> > > +enum plldig_phi1_freq_range {
> > > +       PHI1_MIN        =3D 27000000U,
> > > +       PHI1_MAX        =3D 600000000U
> > > +};
> >=20
> > Please just inline these values in the one place they're used.
> >=20
> > > +
> > > +struct clk_plldig {
> > > +       struct clk_hw hw;
> > > +       void __iomem *regs;
> > > +       struct device *dev;
> >=20
> > Please remove this, it is unused.
>=20
> It is used for probe.

Use a local variable and don't store it away forever in the struct.

> >=20
> > > +
> > > +       val =3D readl(data->regs + PLLDIG_REG_PLLDV);
> > > +       val =3D phi1_param.mfd;
> > > +       rfdphi1 =3D phi1_param.rfdphi1;
> > > +       val |=3D rfdphi1;
> > > +
> > > +       writel(val, data->regs + PLLDIG_REG_PLLDV);
> > > +
> > > +       /* delay 200us make sure that old lock state is cleared */
> > > +       udelay(200);
> > > +
> > > +       /* Wait until PLL is locked or timeout (maximum 1000 usecs) */
> > > +       ret =3D readl_poll_timeout_atomic(data->regs + PLLDIG_REG_PLL=
SR,
> > cond,
> > > +                                       cond & PLLDIG_LOCK_MASK,
> > 0,
> > > +                                       USEC_PER_MSEC);
> > > +
> > > +       return ret;
> >=20
> > Just return readl_poll_timeout_atomic(...) here.
>=20
> Maybe use below code will to best describes.
>=20
> If (ret)
>         return -ETIMEOUT;
>=20
> return 0;

No, just return readl_poll_timeout_atomic().

