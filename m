Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57275CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BB92087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/ZFzMBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfJ3JdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:33:15 -0400
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:28592
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:33:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIpZizWnAIUnvnCyrtW9WTckFJu17ieNc1KYP2Kwn/vikSVob/sx2PyUIEotFZdsPuxRIVd58rQhfFx2nanDzXxVtH8lk5CKKV+H4UeD1s4kcgJeBh5gKDT1yA99iBTNNX7ca8BkFYyE9n1HbvyBuWNH5MS9hzpxwgQxvjB09x2+L6Gvlglsv7vYysw7PUZFz/5r6tDXOjBpO1qfU9qDHvMEaELffxSPfh3HJDEZPHeOwb5JfIZrdn7rAwFpZ4lxIbgOUPfrLw0YrlaqrsYX+qyx0u78zp7Be8fUvdEjvazgTFeBt0UVEacPhXb6liN39f8SUJhL1l62y3noIfSyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJdeO7rYrVjx0Ti1GbpH8jJ1LFVliFAbZ+b7pAtbdX0=;
 b=fiuGYOW9U32mIEGPWQyH/8ze0k+63sntvKizpcUpFgxh3yM9fws607QdrAbDiV4Lxns+RUOESaQ+RInSzweW9QU8DbEnnxGOCoVmLqMfoJTlZh/K4+8uBMOsV/rzi7azY3nnGHMG/KMOg8CgkpxZzOr+wdF+uin5yCLVDfvpGv19ZQy8cQy55TB4ho4zAE4SFSrnOl+JeRxWVbo0gIM+ICwp65+K/JTuICVhAp36/Qkmu2SgUNjOq/YcvOTiDAsU0w55X22nJKmctaSmGI49ftxLapNAL/QvPkxETz33K+CjyOZ9jZOy9t8Npdvab6Smy9k6v/NskUhcLxnjqGRkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJdeO7rYrVjx0Ti1GbpH8jJ1LFVliFAbZ+b7pAtbdX0=;
 b=F/ZFzMBn5OmTC+zxtPD57HJz4b+Qu6TPEXhs4pMDjYjT+h+up6Oz9jOdDlEFren6YVqZBikO0zUQSfYXvzk+xcWyPIo0B7YXUoEl70+PqoOtjPfGcZAXJ/bMm7+czIm8F0n2lSosa+sWiE5yuHhqyYpg4xyFDGeWn2TwEsQzE6I=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB3985.eurprd04.prod.outlook.com (52.134.124.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 09:33:09 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02%3]) with mapi id 15.20.2347.033; Wed, 30 Oct 2019
 09:33:09 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Peng Fan <peng.fan@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] clk: imx: imx8mq: fix sys2/3_pll_out_sels
Thread-Topic: [PATCH] clk: imx: imx8mq: fix sys2/3_pll_out_sels
Thread-Index: AQHVijhIlRv5T5+Fgk+U/4a62CwQt6dvxcIAgAMv34A=
Date:   Wed, 30 Oct 2019 09:33:09 +0000
Message-ID: <20191030093307.s6hfcstxbqhd3iht@fsr-ub1664-175>
References: <1571900044-22079-1-git-send-email-peng.fan@nxp.com>
 <20191028085258.GZ16985@dragon>
In-Reply-To: <20191028085258.GZ16985@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0412.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::16) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5581adeb-3d28-4495-0c61-08d75d1c2d1b
x-ms-traffictypediagnostic: AM0PR04MB3985:|AM0PR04MB3985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB3985B577B619E88DF76FA4F4F6600@AM0PR04MB3985.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(99286004)(11346002)(66446008)(64756008)(25786009)(66556008)(26005)(66476007)(54906003)(2906002)(478600001)(386003)(316002)(66946007)(6506007)(5660300002)(33716001)(71190400001)(71200400001)(53546011)(1076003)(14454004)(446003)(6512007)(186003)(44832011)(66066001)(6916009)(14444005)(86362001)(52116002)(256004)(8936002)(7736002)(486006)(6246003)(305945005)(9686003)(102836004)(4326008)(81166006)(6116002)(6436002)(81156014)(8676002)(6486002)(3846002)(76176011)(476003)(229853002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3985;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tg/2A49NKh1tqcvZURVhDbm2iQuwtM43yJDNHBoMPaWI0t0TZErjyyTIiKax7Ar20+ys35kX9Z5r74v6+EIOftFCyMe7J+7lqj791OKHkduXowBmidPtvACB1aWLdUdaI0Pi3QNTOn+M4irY3UzHJ5RqNLs/cjl0wlUVvsPefmy6M4lXsu51/Tk1MBleKRksRhneXPJK+qtyhc+K1vgqHBi2KBm8XKZHCfIjtBAMbVNfNVYGFOiQrUW9ocJKFAlH3NSh7qiLwPHBspKan+XBtgZ/6YGcgNoRcDBoWwFJ+bGyUV6fyktTHDtvYJRgUM75SU+VGpdu3XXz/75+i02Mlqg/jqyi92yNwQ1WM2YziGDlLXpUUaQxwVJ9Qj2QiIsuqB+t3igmv/yJ4/qK1KfqqOzb+Wpn9ke+D9pAz88moLepAjM6hiwqh27fWWehgGAq
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EEB8FF15868EC04783EF629F12858420@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5581adeb-3d28-4495-0c61-08d75d1c2d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 09:33:09.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DQte0/mmYKwM+IruiwBZwpGytFtHE3vXeKaByggSSxBQ7S/ZLYzGGvenzJV7zLqGna/31OMc0vafGTHVzYmeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-28 16:53:00, Shawn Guo wrote:
> @Abel, comments?
>=20

Looks good to me.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> Shawn
>=20
> On Thu, Oct 24, 2019 at 06:57:21AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >=20
> > The current clk tree shows:
> >  osc_25m                              9       11        0    25000000  =
        0     0  50000
> >     sys2_pll1_ref_sel                 1        1        0    25000000  =
        0     0  50000
> >        sys3_pll_out                   1        1        0    25000000  =
        0     0  50000
> >     sys1_pll1_ref_sel                 2        2        0    25000000  =
        0     0  50000
> >        sys2_pll_out                   6        6        0  1000000000  =
        0     0  50000
> >=20
> > It is not correct that sys3_pll_out use sys2_pll1_ref_sel as parent,
> > sys2_pll_out use sys1_pll1_ref_sel as parent.
> >=20
> > According to the current imx_clk_sccg_pll design, it uses both
> > bypass1/2, however set bypass2 as 1 is not correct, because it will
> > make sys[x]_pll_out use wrong parent and might access wrong registers.
> >=20
> > So correct bypass2 to 0 and fix sys2/3_pll_out_sels.
> >=20
> > After fix, the tree shows:
> >  osc_25m                             10       12        0    25000000  =
        0     0  50000
> >     sys3_pll1_ref_sel                 1        1        0    25000000  =
        0     0  50000
> >        sys3_pll_out                   1        1        0    25000000  =
        0     0  50000
> >     sys2_pll1_ref_sel                 1        1        0    25000000  =
        0     0  50000
> >        sys2_pll_out                   6        6        0  1000000000  =
        0     0  50000
> >     sys1_pll1_ref_sel                 1        1        0    25000000  =
        0     0  50000
> >        sys1_pll_out                   5        5        0   800000000  =
        0     0  50000
> >=20
> > Fixes: e9dda4af685f ("clk: imx: Refactor entire sccg pll clk")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8mq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.=
c
> > index 05ece7b5da54..e17f0ebfacb0 100644
> > --- a/drivers/clk/imx/clk-imx8mq.c
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -35,8 +35,8 @@ static const char * const audio_pll2_bypass_sels[] =
=3D {"audio_pll2", "audio_pll2_
> >  static const char * const video_pll1_bypass_sels[] =3D {"video_pll1", =
"video_pll1_ref_sel", };
> > =20
> >  static const char * const sys1_pll_out_sels[] =3D {"sys1_pll1_ref_sel"=
, };
> > -static const char * const sys2_pll_out_sels[] =3D {"sys1_pll1_ref_sel"=
, "sys2_pll1_ref_sel", };
> > -static const char * const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel"=
, "sys2_pll1_ref_sel", };
> > +static const char * const sys2_pll_out_sels[] =3D {"sys2_pll1_ref_sel"=
, };
> > +static const char * const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel"=
, };
> >  static const char * const dram_pll_out_sels[] =3D {"dram_pll1_ref_sel"=
, };
> >  static const char * const video2_pll_out_sels[] =3D {"video2_pll1_ref_=
sel", };
> > =20
> > @@ -345,8 +345,8 @@ static int imx8mq_clocks_probe(struct platform_devi=
ce *pdev)
> >  	clks[IMX8MQ_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "video=
_pll1_bypass", base + 0x10, 21);
> > =20
> >  	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_sccg_pll("sys1_pll_out", sys1_p=
ll_out_sels, ARRAY_SIZE(sys1_pll_out_sels), 0, 0, 0, base + 0x30, CLK_IS_CR=
ITICAL);
> > -	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_sccg_pll("sys2_pll_out", sys2_p=
ll_out_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 1, base + 0x3c, CLK_IS_CR=
ITICAL);
> > -	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_p=
ll_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 0x48, CLK_IS_CR=
ITICAL);
> > +	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_sccg_pll("sys2_pll_out", sys2_p=
ll_out_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 0, base + 0x3c, CLK_IS_CR=
ITICAL);
> > +	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_p=
ll_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CR=
ITICAL);
> >  	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_p=
ll_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CR=
ITICAL);
> >  	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sccg_pll("video2_pll_out", vi=
deo2_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0=
);
> > =20
> > --=20
> > 2.16.4
> >=20
