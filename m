Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE65DC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9164520659
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561502100;
	bh=/kwIgl7T7RUB6O8AVjTRLgNL7U9K6Zhd50WUYjJcszk=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=n23eOar8kxiIu4ScVHjM5WHYwR4nXZBCHy4vrJRpcKfMmnuU27Q2h4RCErHJCl+6v
	 dTxETeWCgkS9Y36xHLaf1vh2LTiwgvWwMQIrAHLDU4PIly0R7cIKDll+Xt1pPTAkFP
	 eerp6rDw/TOfK6OPh0xyiN1YdwdXnz2o6J9o4iVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfFYWe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFYWe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:34:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FCBF205ED;
        Tue, 25 Jun 2019 22:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561502097;
        bh=/kwIgl7T7RUB6O8AVjTRLgNL7U9K6Zhd50WUYjJcszk=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=TJcRicsuQdvPQg9FeTYbsi/IhN1JdT58h299gkXyrGdyEDhz+ZXUCdRDp0ABWeF67
         mfNgTTWW7vB2AB93S1BledWN7Ici0mXVLEkXdh1PtPnaCLdWvIrJvmKCZN0+p9w5ew
         eHnOpg3F3NLVVen8lN7NjAb6z6kZ0nPHR1rtx0d4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB3PR0402MB3916F7F7D7CA801F5C0D0610F5ED0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com> <20190604015928.23157-3-Anson.Huang@nxp.com> <20190606162543.EFFB820645@mail.kernel.org> <DB3PR0402MB391625A0B3D838CE88C53E33F5100@DB3PR0402MB3916.eurprd04.prod.outlook.com> <20190607180039.611C7208C0@mail.kernel.org> <DB3PR0402MB391678C245944942EA2A7F62F5110@DB3PR0402MB3916.eurprd04.prod.outlook.com> <20190610151425.D8139207E0@mail.kernel.org> <DB3PR0402MB3916F7F7D7CA801F5C0D0610F5ED0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
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
Subject: RE: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
Cc:     dl-linux-imx <linux-imx@nxp.com>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:34:56 -0700
Message-Id: <20190625223457.1FCBF205ED@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-06-10 19:06:22)
> > >
> > > Sorry, I am still a little confused, all the clock
> > > register(clk_register()) are via each different clock types like
> > > imx_clk_gate4/imx_clk_pll14xx, if using clk_hw_register, means we need
> > > to re-write the clock driver using different clk register method, that
> > > will make the driver completely different from i.mx8mq/i.mx8mm, they
> > > are actually same series of SoC as i.mx8mn, it will introduce many
> > confusion, is my understanding correct? And is it OK to just keep what =
it is
> > and make them all aligned?
> > >
> >=20
> > Ok, the problem I'm trying to point out is that clk registrations need =
to be
> > undone, i.e. clk_unregister() needs to be called, when the driver fails=
 to
> > probe. devm_*() is one way to do this, but if you have other ways of
> > removing all the registered clks then that works too. Makes sense?
>=20
> Yes, it makes sense. Do you think it is OK to add an imx_unregister_clock=
s() API, then
> call it in every place of returning failure in .probe function? If yes, I=
 will add it and also
> fix it in i.MX8MQ driver which uses platform driver model but does NOT ha=
ndle this case.=20
>=20
>         base =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (WARN_ON(IS_ERR(base)))
> -               return PTR_ERR(base);
> +       if (WARN_ON(IS_ERR(base))) {
> +               ret =3D PTR_ERR(base);
> +               goto unregister_clks;
> +       }
>=20
>                 pr_err("failed to register clks for i.MX8MN\n");
> -               return -EINVAL;
> +               goto unregister_clks;
>         }
>=20
>         return 0;
> +
> +unregister_clks:
> +       imx_unregister_clocks(clks, ARRAY_SIZE(clks));
> +
> +       return ret;
>=20
> +void imx_unregister_clocks(struct clk *clks[], unsigned int count)
> +{
> +       unsigned i;
> +
> +       for (i =3D 0; i < count; i++)
> +               clk_unregister(clks[i]);
> +}
> +
>=20

Yes, looks better.

