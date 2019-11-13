Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5520C17449
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBAC2245B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JewPXSC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKMMUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:20:13 -0500
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:8934
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfKMMUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:20:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZeHCM7Verepn7Q+Zbqmw8SkvBTattgD/egKPnFkMlocHl5A0LxuBxbJ2Uj1rGUJEc6Fo8nby9fho94M2SPY/1x7TadqqTC3GmAFVLvvp0Drxx4ODO0Um6l4I0tgFmqFIUkKGtAEVkceSn8/K9P+VV1TwgySsV+P3krUz+7qnQRkFN122XcjYCDcgFcrjcfNP7W00ykPM3hMheV4++P6xRTbvyDrHx6SnECKQeQlCYU5/hHXWyodqty4CLD2vaiALkkLQFsjnzd4MryLQut2pLb9a4xhypL/uIr48cFVCuGV4temlKVDpKkK3DwODoP0+8X0mL8YadIUZKMzZNN5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMgF0hJdQKPwZbxjNMppqlhyfiyzp1tDEiz8rhezUz0=;
 b=OlK3Gj6v1PMq33GIV9IZd+1u0W1Q+AoNAfMzqP4VoNC8EwCj1NN/nYTO4oQxXVDyoMwy3AeJWAYJ4QZJgaKJc9Xk0khTknGpuA5agmEjxlDVDUTMCF6Nw2Gu9Ua8SDAD3boX1+Uw+qv4DmUGkzSJCVdRC5aW4IjX1ClI2z/TT0zjT0lO5hwdjdRNSV10YDVEx6/wwrW/pVeUjY2SnSShI6ZiCLkXhsr2cjg8l4NUEHfpLIXCCL+zM2DBHYPflz7eLj85TTva66r+vUNB1wOFwi0zuSBYIRZLkx4AtMHETU2plmxFaq6Eq23b8FtoIubTktYLYtS97ejim9z203yeqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMgF0hJdQKPwZbxjNMppqlhyfiyzp1tDEiz8rhezUz0=;
 b=JewPXSC0BA7/FZKoj57S+KgMGcz/Z/LxDB/p3uZHj1lslwLavwL/Bm3P4Kv1/ZgiY1vw/Rgoti0+uxlNGazNZ84uHDOQmEUDxSw2g5nOeHScfuwhpYugTO2cKDIusmiWrspQoGLumPHfWha585WCI7E+ZmV2b3ZR0B+si+BqXtE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0SPR01MB15.eurprd04.prod.outlook.com (52.134.126.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 13 Nov 2019 12:19:29 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 12:19:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH] clk: imx: pll14xx: introduce imx_clk_hw_pll14xx_flags
Thread-Topic: [PATCH] clk: imx: pll14xx: introduce imx_clk_hw_pll14xx_flags
Thread-Index: AQHVmfO4UT5wBnIiNkiEwV6EPli0LqeJBRtg
Date:   Wed, 13 Nov 2019 12:19:28 +0000
Message-ID: <AM0PR04MB4481188B12082C20CADAC5BD88760@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1573629896-23954-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023CD16303E0CB6F524313DEE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023CD16303E0CB6F524313DEE760@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [49.72.5.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1667dbee-6451-49bd-7fea-08d76833bb2e
x-ms-traffictypediagnostic: AM0SPR01MB15:|AM0SPR01MB15:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0SPR01MB1555D7A58C1F9C1BFFFAF888760@AM0SPR01MB15.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(43544003)(66556008)(2501003)(66446008)(66946007)(6116002)(64756008)(3846002)(53546011)(8936002)(99286004)(2906002)(6506007)(102836004)(33656002)(256004)(4326008)(76116006)(71200400001)(71190400001)(486006)(66476007)(305945005)(76176011)(26005)(81156014)(81166006)(74316002)(8676002)(52536014)(7696005)(44832011)(7736002)(186003)(54906003)(110136005)(5660300002)(316002)(55016002)(86362001)(966005)(66066001)(478600001)(11346002)(229853002)(446003)(2201001)(9686003)(6436002)(14454004)(476003)(6246003)(25786009)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB15;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kzw/bkNP2MalU6LZpjaaR+FCx5/X25is1M6dVbFPC7HZhWku9lljq9I08xluAWwX+m/9/uDq9UvjNB18RU0zD3cq7XNsn1Pb5kLvBYzvh5tTk3IMexLr8QbM0LHMz+cwO1+m+cQrbpzr7LIUhp/vvT07wZKRL0VBT6NjbmVmxIgM31YRuIy9lTgt9IjNRCf5KQa1Iq8EiXKWTKVoVj4iK0HxD1q6pxexHxexBwgCsiELJ+63CpOwFJjRPB8RhxF9sn31LAuYsYuKvK2CAffGH63W58wdVWpLjO7fwTeFUTz6YHcK+UVOjSD0qTdETBozitqS+ksXdebzPGgvAUWFo6M9HYH9uvy7p2rgDQwizyZbCWEJj7J2+N4HROiL+apT2nTAnM5buQCFNHUPFz8q0lSXbgTO0gSfm9hXNcuixx/dXEyfhMFPkngWmqPm1v6T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1667dbee-6451-49bd-7fea-08d76833bb2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:19:28.8092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5UfVm32VExP4QBwB6d88bagcNmjXBpZh+792yokMiwKgDBHd6I0cOXXYi2x32S4FavUDoe5h6vFeelAVHnF8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH] clk: imx: pll14xx: introduce imx_clk_hw_pll14xx_flag=
s
>=20
> On 13.11.2019 09:26, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Introduce imx_clk_hw_pll14xx_flags, then no need to add new
> > imx_pll14xx_clk variable for new flags.
> >
> > Since the original imx_pll14xx_clk flags is not used, so drop it.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
>=20
> Most other imx clock wrappers take flags as an argument so it's nice to b=
e
> consistent.
>=20
> > V1:
> >   Based on https://patchwork.kernel.org/patch/11217889/
>=20
> In general if you sent patches on top of patches it makes sense to resend=
 as a
> series. That clk_hw series is not in yet.

Thanks for hints, I'll take care in future.

Thanks,
Peng.

>=20
> >   drivers/clk/imx/clk-pll14xx.c | 12 +++++++++++-
> >   drivers/clk/imx/clk.h         |  7 ++++++-
> >   2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-pll14xx.c
> > b/drivers/clk/imx/clk-pll14xx.c index 2bbcfbf8081a..a8af949f0848
> > 100644
> > --- a/drivers/clk/imx/clk-pll14xx.c
> > +++ b/drivers/clk/imx/clk-pll14xx.c
> > @@ -379,6 +379,16 @@ struct clk_hw *imx_clk_hw_pll14xx(const char
> *name, const char *parent_name,
> >   				  void __iomem *base,
> >   				  const struct imx_pll14xx_clk *pll_clk)
> >   {
> > +
> > +	return imx_clk_hw_pll14xx_flags(name, parent_name, base, pll_clk,
> > +0); }
> > +
> > +struct clk_hw *imx_clk_hw_pll14xx_flags(const char *name,
> > +					const char *parent_name,
> > +					void __iomem *base,
> > +					const struct imx_pll14xx_clk *pll_clk,
> > +					unsigned long flags)
> > +{
> >   	struct clk_pll14xx *pll;
> >   	struct clk_hw *hw;
> >   	struct clk_init_data init;
> > @@ -390,7 +400,7 @@ struct clk_hw *imx_clk_hw_pll14xx(const char
> *name, const char *parent_name,
> >   		return ERR_PTR(-ENOMEM);
> >
> >   	init.name =3D name;
> > -	init.flags =3D pll_clk->flags;
> > +	init.flags =3D flags;
> >   	init.parent_names =3D &parent_name;
> >   	init.num_parents =3D 1;
> >
> > diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> > cd92d9fdccf4..c2851a82b4fd 100644
> > --- a/drivers/clk/imx/clk.h
> > +++ b/drivers/clk/imx/clk.h
> > @@ -48,7 +48,6 @@ struct imx_pll14xx_clk {
> >   	enum imx_pll14xx_type type;
> >   	const struct imx_pll14xx_rate_table *rate_table;
> >   	int rate_count;
> > -	int flags;
> >   };
> >
> >   extern struct imx_pll14xx_clk imx_1416x_pll; @@ -105,6 +104,12 @@
> > struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char
> *parent_name,
> >   				  void __iomem *base,
> >   				  const struct imx_pll14xx_clk *pll_clk);
> >
> > +struct clk_hw *imx_clk_hw_pll14xx_flags(const char *name,
> > +					const char *parent_name,
> > +					void __iomem *base,
> > +					const struct imx_pll14xx_clk *pll_clk,
> > +					unsigned long flags);
> > +
> >   struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
> >   		const char *parent, void __iomem *base);
