Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555A0CA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149B721479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DGaATEtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfJ2Atr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:49:47 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:25668
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfJ2Atr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 20:49:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqlP0RAvmyaGTxdGyx3hpO+vZMWxkvhCN9vyFIWeeM41xcvgR2v3zs5GeHiQaZ22g2Bavva62cVmDs1lVivsf++gKwUNW/Rh+0nM28+Lh71sZOu+XrWFseLGhoZ9NrINieCH7FAijghqQv/pUQBSV8dhzYzzqe7nYO/YPlxv4sw2V2Ww/6i4nsZQunGCEPO9MK1dKPuZFkKEINsdSvJmjyD4GorLoG7jmE3JrQ3wurt45U3fzS0JJbhYn+FV41KH8y/gXrUtLa2lHZcDWh4mqGJ5GsFUgmsGM5ZW9PpcyZeD7JgK8tdxRZqk+QwesXRaMMTqBg0S8d4lp32VVRmifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XmhbovCtGoGD9bAjhU33oNMwNATrzirVVYM3riq28M=;
 b=NvMtyIoUCm6cJVcwwQqId8xLYu+MR+VpVN/IdWZqdRGhFMpOweqLzueMaETY/vWwGMAMFeECqP3VSYZKeAS7UnwPaV1abV035YBvWMlZ4cH33J/bExA3rCbW/ROuBiQWCmSy0YqeLtsOD2CAehZz2J+VB+iMS/LqIJnBTj+vh+XccqRDqAVo/uLlEUIGGLvs4cwKhuLQUWdL03l+7lqunIsJwvpd3mzqAGfuFWWDIpVy1WgW/I6qiBsIEZFHXz7iDbrBfHeiTuwF56Xy/ZBukEWOgRYATYz7Y5YNC+b7FOaxkknoRN6JQRE3Xj7yw0lTwwTL3Z2S2qIXIYZzbNX0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XmhbovCtGoGD9bAjhU33oNMwNATrzirVVYM3riq28M=;
 b=DGaATEtfon5MsUmkQVC+Q+LN2IC43zib5DrKGc+TNDYVsY8vYqtoX8yUO/0WM93yHSfNTVMBnoS8YVYknb1couc9XxfkISyIReC6qyw5D/gAIUbBe/QlItlnAhmRAyYZrelWKLE/j1BX6WAtwkPclb16yRRtoEQ90mrla+JUQ+0=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.34.20) by
 AM6PR04MB4182.eurprd04.prod.outlook.com (52.135.163.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 00:49:41 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::912a:3593:7e23:72d0]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::912a:3593:7e23:72d0%7]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 00:49:41 +0000
From:   Fancy Fang <chen.fang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v4] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Thread-Topic: [PATCH v4] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_PLL
 clock
Thread-Index: AQHVjWbPxL+wRlx07k+0T7BaUjsAXKdv4ESAgADqFUA=
Date:   Tue, 29 Oct 2019 00:49:41 +0000
Message-ID: <AM6PR04MB49365C9CB797E0FDE65B6856F3610@AM6PR04MB4936.eurprd04.prod.outlook.com>
References: <20191028080545.28275-1-chen.fang@nxp.com>
 <20191028105038.GB16985@dragon>
In-Reply-To: <20191028105038.GB16985@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chen.fang@nxp.com; 
x-originating-ip: [116.230.161.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c3950ac-a054-477d-8721-08d75c09e24a
x-ms-traffictypediagnostic: AM6PR04MB4182:|AM6PR04MB4182:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB41824DFEC1EF7545A36BF15DF3610@AM6PR04MB4182.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(13464003)(54534003)(186003)(9686003)(6436002)(66476007)(66556008)(64756008)(66446008)(316002)(54906003)(66066001)(66946007)(76116006)(14454004)(102836004)(53546011)(26005)(2906002)(7696005)(55016002)(6246003)(76176011)(99286004)(446003)(11346002)(25786009)(229853002)(486006)(4326008)(476003)(6916009)(6506007)(478600001)(6116002)(3846002)(8936002)(81166006)(81156014)(8676002)(256004)(305945005)(86362001)(52536014)(7736002)(74316002)(71200400001)(33656002)(5660300002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4182;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CyWs15jouB9Yof8ccjXzAOOVmW7tDlrYVSIfvqoZH34whcJXxgH0PjIuwVo8Wwk80Crece8KUaxv3SMxqOz97ALtRvzxKuy3YRriV+lcDpRCxl6jrIz5/8aQN6JgyY3AfNy4cMz22qrqcwm2TATlLqY+yspVHJXoolTjMhVQYd7C0EORycGhBp5Pwld3xnMXBZ8wSEncUrN4YxU3XdxH6QU5uTBKd3zdQbtDA17iUFma2+PqrvPdxm7QgryupOnL34mRd+Qn46xQ4GVblZn27x+ZTFpEUfLb+G68sgp44V+ye+2l3kBzrbn6TRwIx8uRrQBMlYTPah8TnvvSg/lPn+nCTSEcKKxw35fo/7gTbVZnyHqRiy8kZQpzuwW7/IKJMxgXI8Y1L3zn5A3gOERo8mWrNhGEfviAkw0czA1U0dtm1lrf3XbWicpUVx3fN3Sj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3950ac-a054-477d-8721-08d75c09e24a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 00:49:41.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7q+DHWhhtqMGdplegKLq36bnUjvIFoNbj6l7SC/QobHjX2HRMN0fqYCjfhcZnNIxmiCmbE/z2LnmfpmbzLljlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Monday, October 28, 2019 6:51 PM
> To: Fancy Fang <chen.fang@nxp.com>
> Cc: sboyd@kernel.org; linux-clk@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> mturquette@baylibre.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v4] clk: imx7ulp: do not export out IMX7ULP_CLK_MIPI_=
PLL
> clock
>=20
> On Mon, Oct 28, 2019 at 08:07:59AM +0000, Fancy Fang wrote:
> > The mipi pll clock comes from the MIPI PHY PLL output, so
> > it should not be a fixed clock.
> >
> > MIPI PHY PLL is in the MIPI DSI space, and it is used as
> > the bit clock for transferring the pixel data out and its
> > output clock is configured according to the display mode.
> >
> > So it should be used only for MIPI DSI and not be exported
> > out for other usages.
> >
> > Signed-off-by: Fancy Fang <chen.fang@nxp.com>
> > ---
> > ChangeLog v3->v4:
> >  * Add some comments to 'IMX7ULP_CLK_MIPI_PLL'
> >    clock.
> >
> >  Documentation/devicetree/bindings/clock/imx7ulp-clock.txt | 1 -
> >  drivers/clk/imx/clk-imx7ulp.c                             | 3 +--
> >  include/dt-bindings/clock/imx7ulp-clock.h                 | 6 ++++++
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > index a4f8cd478f92..93d89adb7afe 100644
> > --- a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > +++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> > @@ -82,7 +82,6 @@ pcc2: pcc2@403f0000 {
> >  		 <&scg1 IMX7ULP_CLK_APLL_PFD0>,
> >  		 <&scg1 IMX7ULP_CLK_UPLL>,
> >  		 <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>,
> > -		 <&scg1 IMX7ULP_CLK_MIPI_PLL>,
> >  		 <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>,
> >  		 <&scg1 IMX7ULP_CLK_ROSC>,
> >  		 <&scg1 IMX7ULP_CLK_SPLL_BUS_CLK>;
> > diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ul=
p.c
> > index 2022d9bead91..459b120b71d5 100644
> > --- a/drivers/clk/imx/clk-imx7ulp.c
> > +++ b/drivers/clk/imx/clk-imx7ulp.c
> > @@ -28,7 +28,7 @@ static const char * const scs_sels[]		=3D { "dummy",
> "sosc", "sirc", "firc", "dumm
> >  static const char * const ddr_sels[]		=3D { "apll_pfd_sel", "upll", };
> >  static const char * const nic_sels[]		=3D { "firc", "ddr_clk", };
> >  static const char * const periph_plat_sels[]	=3D { "dummy", "nic1_bus_=
clk",
> "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
> > -static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_c=
lk",
> "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk=
", };
> > +static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_c=
lk",
> "dummy", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_cl=
k", };
> >  static const char * const arm_sels[]		=3D { "divcore", "dummy", "dummy=
",
> "hsrun_divcore", };
> >
> >  /* used by sosc/sirc/firc/ddr/spll/apll dividers */
> > @@ -75,7 +75,6 @@ static void __init imx7ulp_clk_scg1_init(struct
> device_node *np)
> >  	clks[IMX7ULP_CLK_SOSC]		=3D imx_obtain_fixed_clk_hw(np, "sosc");
> >  	clks[IMX7ULP_CLK_SIRC]		=3D imx_obtain_fixed_clk_hw(np, "sirc");
> >  	clks[IMX7ULP_CLK_FIRC]		=3D imx_obtain_fixed_clk_hw(np, "firc");
> > -	clks[IMX7ULP_CLK_MIPI_PLL]	=3D imx_obtain_fixed_clk_hw(np, "mpll");
> >  	clks[IMX7ULP_CLK_UPLL]		=3D imx_obtain_fixed_clk_hw(np, "upll");
> >
> >  	/* SCG1 */
> > diff --git a/include/dt-bindings/clock/imx7ulp-clock.h
> b/include/dt-bindings/clock/imx7ulp-clock.h
> > index 6f66f9005c81..e9ef62f211fe 100644
> > --- a/include/dt-bindings/clock/imx7ulp-clock.h
> > +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> > @@ -49,7 +49,13 @@
> >  #define IMX7ULP_CLK_NIC1_DIV		36
> >  #define IMX7ULP_CLK_NIC1_BUS_DIV	37
> >  #define IMX7ULP_CLK_NIC1_EXT_DIV	38
> > +
> > +/* mpll clock is a special clock comes from
> > + * mipi DPHY PLL and should be used only for
> > + * mipi dsi instead of any other peripheral.
> > + */
> >  #define IMX7ULP_CLK_MIPI_PLL		39
> > +
>=20
> The point of comment is to tell that the clock ID is unsupported and
> shouldn't be used in DT.
>=20
> I reworded the comment and applied the patch.

OK. Thank you.

Best regards,
Fancy Fang
>=20
> Shawn
>=20
> >  #define IMX7ULP_CLK_SIRC		40
> >  #define IMX7ULP_CLK_SOSC_BUS_CLK	41
> >  #define IMX7ULP_CLK_FIRC_BUS_CLK	42
> > --
> > 2.17.1
> >
