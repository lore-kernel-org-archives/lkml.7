Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876F1CA9EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4417C20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C8QgLL1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfJ1Iz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:55:59 -0400
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:8941
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730954AbfJ1Iz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDCZoVR3gpLwZdTQ24aEGxqaStmgv7Fsq4aJ01RrB/O0d5dW592ZXq4ORMZwztcCXt4m693wOQZH8KSVqg7Hh71tQ5wC53Jg1W7Un/R04s9djwd6vgCCXipxe7D9HVgH5J/XuKptHGll9pXY5aJSKWY4Rbp58741qH5qqNBFb0pBRmlumhSgPnByM9gsFNdzld6odlGfbEK8QUmY34eyBocX8s5S9a7Mzx8XJfp5W1D8x/2kHVh9tfB/dZbQuwsNxZslCYffv4dDcLF2J7fANwdr7xQbE4Z7utES7ADEP+xrRjl0N+g7wj+iZJqYCeGNAjhrbP/vT84uKAawCNyuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcciRgQY7YijJoWptK60bTrcNI90RWMvwj72fWG2dxA=;
 b=ZrV3zjXBGwGJyaMUjk+y9VldLjgYFl0cylCrz72oWUPxWm3lzBwDQofXhNhJnQcqn91/CDvnvquaGrdkxc519+OwrXexfxaxLnnjmZs+4kjJNc5JPwnd4VQ81uubGDHuB6hA54mvYnXBaOkzKGId9pOr1ZPxnLqbxZ7vLvyPcpp8zbFn87MtL/rlnFH3HTy3X8RGz0Ms4ct5I10Tcj1jxtVfLLMYeIFnkwixkjSXMP8gGtBgYlL7vRmUBCga/eanNcKAWb/+jEhtJzAvUp2OmMwTU7COcivgVDHYTRgBFqIO9d9oTtmRaQFAVEOiH6cb5c/f6mfiXnH7vFN0bnLYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcciRgQY7YijJoWptK60bTrcNI90RWMvwj72fWG2dxA=;
 b=C8QgLL1gT4hjtVeLkflse/+O771I3GI3LMqht1I4vInorMj//Nb4HicZF72yWSUWyEXF79J6IrCenL+VuqtAU3KOKXy81fQ7v7ArC4PTXhaHrs/53x816bObgQu/RKUTn8SgMX6SPsP7yw+78uEEkUlYF9Th/L7ONYKA8os7sQQ=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5857.eurprd04.prod.outlook.com (20.178.118.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 08:55:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 08:55:52 +0000
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
Subject: RE: [PATCH] clk: imx: imx8mq: fix sys2/3_pll_out_sels
Thread-Topic: [PATCH] clk: imx: imx8mq: fix sys2/3_pll_out_sels
Thread-Index: AQHVijhIlRv5T5+Fgk+U/4a62CwQt6dvxcIAgAAAl5A=
Date:   Mon, 28 Oct 2019 08:55:52 +0000
Message-ID: <AM0PR04MB448197A0043ABB1FB7E238CB88660@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1571900044-22079-1-git-send-email-peng.fan@nxp.com>
 <20191028085258.GZ16985@dragon>
In-Reply-To: <20191028085258.GZ16985@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 418670d0-141a-47d7-9d88-08d75b84a34e
x-ms-traffictypediagnostic: AM0PR04MB5857:|AM0PR04MB5857:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB585795756B87E70FB0D3E81388660@AM0PR04MB5857.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(478600001)(446003)(64756008)(66946007)(66556008)(66476007)(9686003)(6506007)(229853002)(66446008)(2906002)(14454004)(76116006)(14444005)(3846002)(6116002)(55016002)(6306002)(71190400001)(25786009)(256004)(76176011)(99286004)(71200400001)(6436002)(52536014)(102836004)(316002)(44832011)(966005)(8936002)(86362001)(7696005)(26005)(66066001)(6916009)(81166006)(81156014)(8676002)(5660300002)(476003)(4326008)(54906003)(186003)(74316002)(305945005)(486006)(6246003)(33656002)(7736002)(11346002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5857;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSGrEaq1MoPsXkfi4atdPEyL+SO+NbeKxulb6r4rv9HzlNJ9RpFGVjU+LwEsd2S8Zmk8L07//2AOlB6YqOQMYnlDshRdngxUx7Dz+wIQDeU8L8GFiu9oPq5UoVLsEJBzjNdVdICQqmbs77tmyWtkyngBEUKQisnZGgty2KUaRAeklKo+IbzGlADniRSDUcv3vLyM+gCGhCaI9EtLtPTzLRWkMxiyDEnezXWj05ysnKCpVCM0UmLTs2Sc2qqqYf6SQ6fwkBHq0F5RIF6V8+ldDkBZqRM/63ptBUyhABmHG8WEIPIDkWtQt4xeOWsQ3yQtbsUjFhC6PHOoUG5UhfHyX0HbOoOQZ99oAHqQnlYyutDR78Calg8/mQfZfTe52ujrI07m3+9ii/3m7C4FALGaLwHOEzwU7e+LqzVKcdP+o7ORSEf4fQG2jTUqEBBMjfEu7fBC2jVvSCem6fMWzvx6/6dFrcp3hkRsjkPN9CphQ4Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418670d0-141a-47d7-9d88-08d75b84a34e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 08:55:52.8994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUM3QlvIGwViaprgKE5otV/YHCHAvW5dDMVlzAl5SmPWkBHWCzInXl6yGq2AIbYGka8h/fcI35fHcIuLjGRsgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] clk: imx: imx8mq: fix sys2/3_pll_out_sels
>=20
> @Abel, comments?

I have rebased patch with clk/imx and have v2 to avoid merge conflicts.
https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=3D166=
321

Thanks,
Peng.

>=20
> Shawn
>=20
> On Thu, Oct 24, 2019 at 06:57:21AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The current clk tree shows:
> >  osc_25m                              9       11        0
> 25000000          0     0  50000
> >     sys2_pll1_ref_sel                 1        1        0
> 25000000          0     0  50000
> >        sys3_pll_out                   1        1        0
> 25000000          0     0  50000
> >     sys1_pll1_ref_sel                 2        2        0
> 25000000          0     0  50000
> >        sys2_pll_out                   6        6        0
> 1000000000          0     0  50000
> >
> > It is not correct that sys3_pll_out use sys2_pll1_ref_sel as parent,
> > sys2_pll_out use sys1_pll1_ref_sel as parent.
> >
> > According to the current imx_clk_sccg_pll design, it uses both
> > bypass1/2, however set bypass2 as 1 is not correct, because it will
> > make sys[x]_pll_out use wrong parent and might access wrong registers.
> >
> > So correct bypass2 to 0 and fix sys2/3_pll_out_sels.
> >
> > After fix, the tree shows:
> >  osc_25m                             10       12        0
> 25000000          0     0  50000
> >     sys3_pll1_ref_sel                 1        1        0
> 25000000          0     0  50000
> >        sys3_pll_out                   1        1        0
> 25000000          0     0  50000
> >     sys2_pll1_ref_sel                 1        1        0
> 25000000          0     0  50000
> >        sys2_pll_out                   6        6        0
> 1000000000          0     0  50000
> >     sys1_pll1_ref_sel                 1        1        0
> 25000000          0     0  50000
> >        sys1_pll_out                   5        5        0
> 800000000          0     0  50000
> >
> > Fixes: e9dda4af685f ("clk: imx: Refactor entire sccg pll clk")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8mq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mq.c
> > b/drivers/clk/imx/clk-imx8mq.c index 05ece7b5da54..e17f0ebfacb0
> 100644
> > --- a/drivers/clk/imx/clk-imx8mq.c
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -35,8 +35,8 @@ static const char * const audio_pll2_bypass_sels[] =
=3D
> > {"audio_pll2", "audio_pll2_  static const char * const
> > video_pll1_bypass_sels[] =3D {"video_pll1", "video_pll1_ref_sel", };
> >
> >  static const char * const sys1_pll_out_sels[] =3D {"sys1_pll1_ref_sel"=
,
> > }; -static const char * const sys2_pll_out_sels[] =3D
> > {"sys1_pll1_ref_sel", "sys2_pll1_ref_sel", }; -static const char *
> > const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel", "sys2_pll1_ref_sel"=
,
> > };
> > +static const char * const sys2_pll_out_sels[] =3D {"sys2_pll1_ref_sel"=
,
> > +}; static const char * const sys3_pll_out_sels[] =3D
> > +{"sys3_pll1_ref_sel", };
> >  static const char * const dram_pll_out_sels[] =3D {"dram_pll1_ref_sel"=
,
> > };  static const char * const video2_pll_out_sels[] =3D
> > {"video2_pll1_ref_sel", };
> >
> > @@ -345,8 +345,8 @@ static int imx8mq_clocks_probe(struct
> platform_device *pdev)
> >  	clks[IMX8MQ_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out",
> > "video_pll1_bypass", base + 0x10, 21);
> >
> >  	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_sccg_pll("sys1_pll_out",
> sys1_pll_out_sels, ARRAY_SIZE(sys1_pll_out_sels), 0, 0, 0, base + 0x30,
> CLK_IS_CRITICAL);
> > -	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_sccg_pll("sys2_pll_out",
> sys2_pll_out_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 1, base + 0x3c,
> CLK_IS_CRITICAL);
> > -	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out",
> sys3_pll_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 0x48,
> CLK_IS_CRITICAL);
> > +	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_sccg_pll("sys2_pll_out",
> sys2_pll_out_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 0, base + 0x3c,
> CLK_IS_CRITICAL);
> > +	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out",
> > +sys3_pll_out_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base +
> > +0x48, CLK_IS_CRITICAL);
> >  	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out",
> dram_pll_out_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60,
> CLK_IS_CRITICAL);
> >  	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sccg_pll("video2_pll_out",
> > video2_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base +
> > 0x54, 0);
> >
> > --
> > 2.16.4
> >
