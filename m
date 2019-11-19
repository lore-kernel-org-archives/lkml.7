Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D1C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA42F20730
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rrwNfIkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKSBGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:06:51 -0500
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:45708
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbfKSBGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:06:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wib4vMtmDY+NFksyOZAyEhwLZxN36lwVIHXGg+PGC2sC1TiUgvqWsvvgfmFHoH8JOIPc+nJoFSBENRoTSNrXKIQrGqdGWLeoYSW63/lp/WAAc+WrCzXzsTMcs/WvHvUbPv8ukadYFdRHxOuYtBXmH0BL0tMT0JAIcGOJVSFKDYVO78P40xlrtMQ5ZJlBN85YKT2lKMf4kMhJ0J+0bvl7ofWThcxxOVVgpJfg5Qx4JyvXKXBg4aYFCrn65+AAq7CbQXQk/5z8GAxOj6xttoL3t32yztTfSU6vVJqS/NzUM7Je6FZDKwc1D6hx9BXAsI7o99Gzp6xnP1RTGBK+SR+jSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj8adp4a24dtW/PPvid+IbElHqvksM+7Xnt1TUBwgT8=;
 b=F66XWzac+IgYAhCzKaOUXyPtu8luD8UnAIF+3+LR8V/myKjE/5ssTJSmTztPOTVPvElBbFjbh/KO70tJVK0gSFA6ukqo1SlaVEd+Wkztb63Hkdn9x7yVBfG+8FmKh3dFb6W/98Lgf076k398UT3Vq3UFPRorTes5FKPtmKBqRUFr1XT50BMTjKxjjIrMGns8uuUFzfBLlTIwuC2s9Zn0knlfRf/6cqSW+ARK8k38Cyu25LMLdlxPKFG1mCH8s7h4i1OYeWGgO855pTOHK3YpxvGBihRcmxV1eVPdAubvDwpqZ37sIPTA2cjLqn1D3d2K1zt2zIWBYXdR0pbBSYzJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj8adp4a24dtW/PPvid+IbElHqvksM+7Xnt1TUBwgT8=;
 b=rrwNfIkCZgGHIRyA4l14jGuNHxlcCc8sewCQvk7NUPJXKtRwe6wZfkp9E1OsoS/oIYWJpaQUUlKB+mFq2it1wzRX/TD3moGgW4d6OCyrmpA+NuoeMBrMU/ReFyhRb9QWIc0QdIREjEbyXz93sOPmKRPedcd0vvemzTDwycUxdtI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7137.eurprd04.prod.outlook.com (10.186.130.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Tue, 19 Nov 2019 01:06:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 01:06:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/4] clk: imx: imx8mn: Switch to clk_hw based API
Thread-Topic: [PATCH V2 2/4] clk: imx: imx8mn: Switch to clk_hw based API
Thread-Index: AQHVktMqCwK57JvXBUGi+SLZf4ysjKeRxVqg
Date:   Tue, 19 Nov 2019 01:06:46 +0000
Message-ID: <AM0PR04MB4481F5F07FF493E75CFD1747884C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1572846270-24375-1-git-send-email-peng.fan@nxp.com>
 <1572846270-24375-3-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023CC47DC123A66627940E9EE4D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023CC47DC123A66627940E9EE4D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aed59b44-4cb6-428e-3491-08d76c8cbf92
x-ms-traffictypediagnostic: AM0PR04MB7137:|AM0PR04MB7137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB71370900908CB724DC755885884C0@AM0PR04MB7137.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(186003)(55016002)(6116002)(14454004)(3846002)(4326008)(229853002)(2201001)(6246003)(76176011)(66066001)(2906002)(2501003)(7736002)(74316002)(25786009)(305945005)(86362001)(71200400001)(71190400001)(52536014)(66946007)(66556008)(64756008)(66446008)(66476007)(256004)(478600001)(9686003)(6436002)(5660300002)(99286004)(33656002)(26005)(110136005)(8676002)(486006)(53546011)(8936002)(81166006)(81156014)(44832011)(316002)(11346002)(102836004)(6506007)(76116006)(446003)(7696005)(476003)(54906003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7137;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HExO8AaHioNVh8mc4ty2QVpaukJA+Wm1qInEzMpSwg7XD2Pi5t1aANL7pBtlzwG59rmwGafMySC5+dMsUAkku71d/zS8Mg8SE7hJsBbDJ/LQUZIqOGLmncT8piPWzW8dhYD3Gvu+6v4MicrRDVg2tsB/A8dsuVHIWWodqxNU/ASJeYz798+mT66qY8u9uCD72UUK/1uobk6GVwpi3tWN7Mn/JgATOnGdjOJo9Om3MQrB/IZXNK+8R1WMADGk3kKZ3BmhWk/D30dl0YIaKLsuqUmIpQHVQTelE9K3rMaoFf7TNXR9BsvPhcqUqMC26rkgPBSyJg4peKO2FpdB9e7WVIlQIHaaPtORWgu+Z5zxH3ow9BlsmC0dJ6YOPrV/tEzQxL3vvSe+E8b+rpYpRUkbtgGkoEPpvwdSuqhCbzLib76+GdGcaOji3/yofQWDY6yt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed59b44-4cb6-428e-3491-08d76c8cbf92
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 01:06:46.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlAVNNcmdMs3nrIUcFmFMP3IPqQVR2XDwbFj4B1IOAmd3I6Foi7tokCgHfiGfgo7ko5sY11UiUexO8kxhI7dYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 2/4] clk: imx: imx8mn: Switch to clk_hw based API
>=20
> On 2019-11-04 7:46 AM, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Switch the entire clk-imx8mn driver to clk_hw based API.
> > This allows us to move closer to a clear split between consumer and
> > provider clk APIs.
>=20
> > -	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1",
> "audio_pll1_ref_sel", base, &imx_1443x_pll);
> > -	clks[IMX8MN_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2",
> "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
> > -	clks[IMX8MN_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1",
> "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
> > -	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll",
> "dram_pll_ref_sel", base + 0x50, &imx_1443x_pll);
> > -	clks[IMX8MN_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel"=
,
> base + 0x64, &imx_1416x_pll);
> > -	clks[IMX8MN_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel"=
,
> base + 0x74, &imx_1416x_pll);
> > -	clks[IMX8MN_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel"=
,
> base + 0x84, &imx_1416x_pll);
> > -	clks[IMX8MN_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
> > -	clks[IMX8MN_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);
> > -	clks[IMX8MN_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_s=
el",
> base + 0x114, &imx_1416x_pll);
> > +	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_hw_pll14xx("audio_pll1",
> "audio_pll1_ref_sel", base, &imx_1416x_pll);
> > +	clks[IMX8MN_AUDIO_PLL2] =3D imx_clk_hw_pll14xx("audio_pll2",
> "audio_pll2_ref_sel", base + 0x14, &imx_1416x_pll);
> > +	clks[IMX8MN_VIDEO_PLL1] =3D imx_clk_hw_pll14xx("video_pll1",
> "video_pll1_ref_sel", base + 0x28, &imx_1416x_pll);
> > +	clks[IMX8MN_DRAM_PLL] =3D imx_clk_hw_pll14xx("dram_pll",
> "dram_pll_ref_sel", base + 0x50, &imx_1416x_pll);
> > +	clks[IMX8MN_GPU_PLL] =3D imx_clk_hw_pll14xx("gpu_pll",
> "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
> > +	clks[IMX8MN_VPU_PLL] =3D imx_clk_hw_pll14xx("vpu_pll",
> "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
> > +	clks[IMX8MN_ARM_PLL] =3D imx_clk_hw_pll14xx("arm_pll",
> "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
> > +	clks[IMX8MN_SYS_PLL1] =3D imx_clk_hw_fixed("sys_pll1", 800000000);
> > +	clks[IMX8MN_SYS_PLL2] =3D imx_clk_hw_fixed("sys_pll2", 1000000000);
> > +	clks[IMX8MN_SYS_PLL3] =3D imx_clk_hw_pll14xx("sys_pll3",
> > +"sys_pll3_ref_sel", base + 0x114, &imx_1416x_pll);
>=20
> You are switching audio/video/dram PLL from imx_1443x_pll to
> imx_1416x_pll, are you sure this is correct?

That is a mistaken, copy/paste error. I'll fix in V3.

>=20
> If this is intentional it should be an separate patch.
>=20
> > -	clks[IMX8MN_CLK_ARM] =3D imx_clk_cpu("arm", "arm_a53_div",
> > -					   clks[IMX8MN_CLK_A53_DIV],
> > -					   clks[IMX8MN_CLK_A53_SRC],
> > -					   clks[IMX8MN_ARM_PLL_OUT],
> > -					   clks[IMX8MN_CLK_24M]);
>=20
> > +	clks[IMX8MN_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
> > +					      clks[IMX8MN_CLK_A53_DIV]->clk,
> > +					      clks[IMX8MN_CLK_A53_SRC]->clk,
> > +					      clks[IMX8MN_ARM_PLL_OUT]->clk,
> > +					      clks[IMX8MN_CLK_24M]->clk);
>=20
> This series seems to be against Shawn's clk/imx but there is an additiona=
l
> patch in Stephen's tree which changes this 24M to PLL1_800M.
> Maybe that should be pulled into clk/imx? Otherwise it might spawn an
> unreadable merge conflicts since almost the entire file is rewritten.

Yes.

Thanks,
Peng.

>=20
> --
> Regards,
> Leonard
