Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4072EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6EC20833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MDshhyam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLBC06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:26:58 -0500
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:6142
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727285AbfLBC05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:26:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVM0k1i+of/HWd8QkQHur08CGFnjarR1KNM0PfmUxbUpa8UpaKcdQVvWSFEfG8Qt8R7T3lDzPktHAm3qSBhkwPkEwDhmAsqxNIm1IpZHnSSAfvKChm1mE+dVoU7wdzhFawu5pmk3fH+gya1G2y2k+GYiEDiFAH8yuj8nNSSIyrEu9ZxsZGbAiX5HCbyRAcXmaeLEEXAqhP0Ck9z7Ofa2IQVbWSfvBWdD0bJjg8DTdfwcvdOqTb7Vuj+0Hp2jColduJNgXU+IFsO6PkjkK3q1MebjyiVY722+X6ojfR3QcIWqR7X92kjvKHnyCsovO81o6kXl/yTZeS7Blmualr44+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kIUixMufIu7+rJnTokU8mYcYxADOy/1RquD0Q9HsQQ=;
 b=X7EcZjiKN0E9BjUINt5aJY/rYRbOLp2v6YS+QqAhWn+g3oc+ooMoagdSAUwdCeI8OtppwvPAkLlcuFM2QgiTDhUFVh6/ZRJtb/ZTHJJYTkHqbVMnszTA8PJO4hRQfMv66dB5BNehByXY8Tgg6CyOHUONZ3HHegqL+eQfqdMSxR3jpiN/g2NR6Y/hrYOPjHoNc2kS2vp0odNl5qwJXT6Cq7DgLiyS6I7hPJiElELWMIOPRayNbwFF4POtzXUcttcm/hSotoqaBFU1wn6ZOOoj6fWoq6YglUnnXKagTMqQWR9RYdHVEeV82hH6PRnEczV6/acXicZb1GC9QTdFzgtKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kIUixMufIu7+rJnTokU8mYcYxADOy/1RquD0Q9HsQQ=;
 b=MDshhyamSI+kNFJOoz8dhgzP49MY7DnZlq8ZOOKdAy/FLjU7ApU2ik5qvrIcIkKdjaFkhPB39lpwO8WgmNoXCUtDlAouk9bHLnp9jZHZ+gOSKHNE+IL2YAohpisWNPRxCcBZ+mGlxCEAZoNShn0h4T5GeUk0dRqqjCjD+Yo1qAs=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6772.eurprd04.prod.outlook.com (52.132.214.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 02:26:13 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 02:26:13 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Thread-Topic: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Thread-Index: AQHVjl58vmyH5lHO9kisrA51FWxJAKemP8QAgAATAjA=
Date:   Mon, 2 Dec 2019 02:26:13 +0000
Message-ID: <AM0PR04MB4481B7D74A1861558523F21488430@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
 <1572356175-24950-2-git-send-email-peng.fan@nxp.com>
 <20191202011721.GA17574@dragon>
In-Reply-To: <20191202011721.GA17574@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [114.220.170.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03794538-4e63-40ea-cea8-08d776cf0095
x-ms-traffictypediagnostic: AM0PR04MB6772:|AM0PR04MB6772:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6772E5E0CBF3DCFF1C0CCD5288430@AM0PR04MB6772.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(6916009)(9686003)(4326008)(66476007)(66066001)(5660300002)(25786009)(478600001)(7736002)(6116002)(71190400001)(71200400001)(3846002)(33656002)(256004)(305945005)(74316002)(86362001)(2906002)(8676002)(8936002)(81156014)(76176011)(6436002)(55016002)(446003)(99286004)(11346002)(76116006)(44832011)(66946007)(66556008)(7696005)(81166006)(52536014)(102836004)(6506007)(316002)(6246003)(26005)(14454004)(229853002)(66446008)(64756008)(54906003)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6772;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBFYz8i/nb//8lJJ6hs30SPC8frdfpTVRlOoz9u9Yc+cz6hRPwSKUHdQTBS0qYsD3dZN7n/LxebWY/Iyq0Wx/HDXTkWPL8bLfy0L9mwZds+9PtQ6pcECsoMGBuYMXIrwMEem+6LlzJcRWWAlVwCCh+zWbsMjI7npFeDoOz2R1xmlK9AZPHQsb2e1dGnxLryd6yZ+eu8xOgZ/YXrdb6Sy8q1OJffK/9rmfWb54uiQzRwDRaW0QAj+NflbcbI31LXa7mimB/aYgx/OOsXbQvRtFpOONj4u9+Gu/AuMlXYIjs8px2ZtwGTKL1YTJbghsFH8Yzmr7ejHTNz2+hYucoOpPK/QUaBjwHKtG9Jvzh3hSIdcsq3Y25NXL3/myD52GgrJxhUWSmF3eJh6KfTE3tnckAY0Vm96hEoM9ErerpI6Qk9Neog2nhkGHqg9R8ojT6PA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03794538-4e63-40ea-cea8-08d776cf0095
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 02:26:13.5850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpZSElb5AIH4zDQjXuBVSlquVjjUs+1KBSrFsE4b/0RMOV3diboI9Wt3TaRD2/ff8W22KsSc/9C1GvcKJ77c4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based AP=
I
>=20
> On Tue, Oct 29, 2019 at 01:40:54PM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Switch the imx_clk_pll14xx function to clk_hw based API, rename
> > accordingly and add a macro for clk based legacy. This allows us to
> > move closer to a clear split between consumer and provider clk APIs.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-pll14xx.c | 22 +++++++++++++---------
> >  drivers/clk/imx/clk.h         |  8 ++++++--
> >  2 files changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-pll14xx.c
> > b/drivers/clk/imx/clk-pll14xx.c index 5c458199060a..fa76e04251c4
> > 100644
> > --- a/drivers/clk/imx/clk-pll14xx.c
> > +++ b/drivers/clk/imx/clk-pll14xx.c
> > @@ -369,13 +369,14 @@ static const struct clk_ops clk_pll1443x_ops =3D =
{
> >  	.set_rate	=3D clk_pll1443x_set_rate,
> >  };
> >
> > -struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
> > -			    void __iomem *base,
> > -			    const struct imx_pll14xx_clk *pll_clk)
> > +struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char
> *parent_name,
> > +				  void __iomem *base,
> > +				  const struct imx_pll14xx_clk *pll_clk)
> >  {
> >  	struct clk_pll14xx *pll;
> > -	struct clk *clk;
> > +	struct clk_hw *hw;
> >  	struct clk_init_data init;
> > +	int ret;
> >  	u32 val;
> >
> >  	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL); @@ -412,12 +413,15 @@
> > struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
> >  	val &=3D ~BYPASS_MASK;
> >  	writel_relaxed(val, pll->base + GNRL_CTL);
> >
> > -	clk =3D clk_register(NULL, &pll->hw);
> > -	if (IS_ERR(clk)) {
> > -		pr_err("%s: failed to register pll %s %lu\n",
> > -			__func__, name, PTR_ERR(clk));
> > +	hw =3D &pll->hw;
> > +
> > +	ret =3D clk_hw_register(NULL, hw);
> > +	if (ret) {
> > +		pr_err("%s: failed to register pll %s %d\n",
> > +			__func__, name, ret);
> >  		kfree(pll);
> > +		return ERR_PTR(ret);
> >  	}
> >
> > -	return clk;
> > +	return hw;
> >  }
> > diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> > bc5bb6ac8636..5038622f1a72 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -97,8 +97,12 @@ extern struct imx_pll14xx_clk imx_1443x_pll;
> > #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \
> >  	imx_clk_hw_mux(name, reg, shift, width, parents, num_parents)->clk
> >
> > -struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
> > -		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
> > +#define imx_clk_pll14xx(name, parent_name, base, pll_clk) \
> > +	imx_clk_hw_pll14xx(name, parent_name, base, pll_clk)->clk
> > +
>=20
> I would suggest to use an inline function for this, which will be more re=
adable
> and complying to kernel coding style.

ok, I'll send out v2.

Thanks,
Peng.

>=20
> Shawn
>=20
> > +struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char
> *parent_name,
> > +				  void __iomem *base,
> > +				  const struct imx_pll14xx_clk *pll_clk);
> >
> >  struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
> >  		const char *parent, void __iomem *base);
> > --
> > 2.16.4
> >
