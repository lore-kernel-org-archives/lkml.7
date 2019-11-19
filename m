Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B002C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F1E208CC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EVI5x0tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfKSOJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:09:02 -0500
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:59905
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728068AbfKSOI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:08:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyruR8Mh+A20YkDAiynqppbtxqzCKJlBto7xGi6NmidRZ24RXOm0zkZ975nBlmGYZakfweZHBgTRuhaSPRjx6ty6/OnUfzgDseK4ckN+9tHt4s6hfgraw5lj61Qgh9hxkoDaJ8sh0/fhxexjMnZqCV4hd+fesOA83AJ4WB0xI9x6RVdspnLPWqWVRmDQR6vuCwTynwwFiMKPgUR/vFUpdyaJtdxvCKtv4UH0StjiA6jj1dkI/Zw9vBk58hWr5XYAwGFCktHOiGYTemhC15NyKy2YNZOasdIUtVKhXghrHSB5qALBI/4r13gq+Zt4OJtWlOrOOW1XFE+2O96VQA1CrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph+7aNUUANu/qf690DDFhOXtHVpLqvR9BM0o+4PP05o=;
 b=PCdji0U4hp858RGFsAifrq+h1MeFv1k0vIapdGPOmic3ra2uGI0uq0OjZccp/AWAGMvUHqDXvvWpOLiICCVL4e6BLSmYO6HSuBSrjQHkQULEnRuhObTR0veisJdbomGhRyJEtvuAjEKlIbHYTB0SrzT/BCq1N3m/yNouKtNaclOxt+rC5mmJqXCh/yZklb1t/A0UT2Ecmhu9B2NZvTTBTUGdrGvsDhy5V/BNStO8laEhj8+hJ2Qs/3teGUnEGQPlk8Zo9yTlDKCTvmLNOY4JBgEiaAnRep+UDci+Ya13MeNQXKSfM6pzkafygVhHXLa0w22nrFRVSeKULYnC0WTFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph+7aNUUANu/qf690DDFhOXtHVpLqvR9BM0o+4PP05o=;
 b=EVI5x0tK4jR8QwgS59Xi3L0JAmNGmCq6SjcJsMWhuih34/2118IFLBGdX1dmpuVqBaqY3cvnP+7H+G2l5ARw1uVdoCIS0vrZf9ZSCLj9Ex1+7cLJzL0bEXJ+ZitT1Z7G+Aawg6Ok/HeHm9c8GqCk4H8qvo+JB46oYBurZ31WRPc=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB7044.eurprd04.prod.outlook.com (10.186.128.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 14:08:49 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 14:08:48 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 9/9] clk: imx7up: Rename the clks to hws
Thread-Topic: [PATCH 9/9] clk: imx7up: Rename the clks to hws
Thread-Index: AQHVnuLczdbn6NCbZUCohcuOl28r4w==
Date:   Tue, 19 Nov 2019 14:08:47 +0000
Message-ID: <1574172496-12987-10-git-send-email-abel.vesa@nxp.com>
References: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:208:122::39) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54ca7fd8-05e5-4c91-7ba7-08d76cf9feb7
x-ms-traffictypediagnostic: AM0PR04MB7044:|AM0PR04MB7044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7044CE17B1CE75B9D931C97EF64C0@AM0PR04MB7044.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(86362001)(66066001)(50226002)(386003)(486006)(102836004)(6506007)(26005)(66946007)(2906002)(6116002)(3846002)(6512007)(6486002)(30864003)(4326008)(5660300002)(6436002)(7736002)(25786009)(14454004)(76176011)(71200400001)(305945005)(8936002)(6636002)(478600001)(44832011)(476003)(71190400001)(2616005)(446003)(11346002)(36756003)(256004)(14444005)(316002)(66476007)(81156014)(81166006)(186003)(54906003)(110136005)(99286004)(8676002)(66446008)(52116002)(64756008)(66556008)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7044;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvfc/g06RFoZA7QrZnjhVLk2YcyJCFwJBCWaCUFyxBnHzCccgnaXfkuOPe9+JStaXYL46o/7iEiAlisR9gKoZUIK380gPyOYIisckvCQqSRzcI/A8NyXpAKdRWQGCTNWAJt4rSK0goVQnLU1NVh1qxKXi27GQMRXB0ww+2WfQlJGmb2vxGD6IeTpLyTh/2a/XhTI9V0Idlsnlrs0661FfDcsG+MmM7RYIMppY/MTU8XFij9ADeqqijQywZDPvWJWUXb2Lsr2oWQ+j/LrKnKLrujj6dNDp48tGleSCNL4tsRbTqGNENunujWYKcLb866OM4Wk2YHeyAEaXl29rck37HSXZnTckq5+McM0rDOxValIpMXOYcXK2JI0lQRSLVbL3jSZDJkNhUCju5eD27QtvFs+sxzAknrfVbRKPLrvaA6lpyrD6XlINxE9Mct+2pkk
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ca7fd8-05e5-4c91-7ba7-08d76cf9feb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 14:08:47.4697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nFnMDBuY2H9E23WezJg/2F9VTIj6Rg77FtqfBcf41C1Y1PH1CnvNba6SRV1MCfdBU2qU8WuG7a/Nx7rtIIODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just to keep in line with the other i.MX clock drivers that are
clk_hw based. Plus, it makes more sense to be called hws since its type is
clk_hw not clk.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 182 +++++++++++++++++++++-----------------=
----
 1 file changed, 91 insertions(+), 91 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 8657e5f..8f67e49 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -58,7 +58,7 @@ static struct clk **pcc3_uart_clks[ARRAY_SIZE(pcc3_uart_c=
lk_ids) + 1] __initdata
 static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 {
 	struct clk_hw_onecell_data *clk_data;
-	struct clk_hw **clks;
+	struct clk_hw **hws;
 	void __iomem *base;
=20
 	clk_data =3D kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_SCG1_END),
@@ -67,76 +67,76 @@ static void __init imx7ulp_clk_scg1_init(struct device_=
node *np)
 		return;
=20
 	clk_data->num =3D IMX7ULP_CLK_SCG1_END;
-	clks =3D clk_data->hws;
+	hws =3D clk_data->hws;
=20
-	clks[IMX7ULP_CLK_DUMMY]		=3D imx_clk_hw_fixed("dummy", 0);
+	hws[IMX7ULP_CLK_DUMMY]		=3D imx_clk_hw_fixed("dummy", 0);
=20
-	clks[IMX7ULP_CLK_ROSC]		=3D imx_obtain_fixed_clk_hw(np, "rosc");
-	clks[IMX7ULP_CLK_SOSC]		=3D imx_obtain_fixed_clk_hw(np, "sosc");
-	clks[IMX7ULP_CLK_SIRC]		=3D imx_obtain_fixed_clk_hw(np, "sirc");
-	clks[IMX7ULP_CLK_FIRC]		=3D imx_obtain_fixed_clk_hw(np, "firc");
-	clks[IMX7ULP_CLK_UPLL]		=3D imx_obtain_fixed_clk_hw(np, "upll");
+	hws[IMX7ULP_CLK_ROSC]		=3D imx_obtain_fixed_clk_hw(np, "rosc");
+	hws[IMX7ULP_CLK_SOSC]		=3D imx_obtain_fixed_clk_hw(np, "sosc");
+	hws[IMX7ULP_CLK_SIRC]		=3D imx_obtain_fixed_clk_hw(np, "sirc");
+	hws[IMX7ULP_CLK_FIRC]		=3D imx_obtain_fixed_clk_hw(np, "firc");
+	hws[IMX7ULP_CLK_UPLL]		=3D imx_obtain_fixed_clk_hw(np, "upll");
=20
 	/* SCG1 */
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
 	/* NOTE: xPLL config can't be changed when xPLL is enabled */
-	clks[IMX7ULP_CLK_APLL_PRE_SEL]	=3D imx_clk_hw_mux_flags("apll_pre_sel", b=
ase + 0x508, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_G=
ATE);
-	clks[IMX7ULP_CLK_SPLL_PRE_SEL]	=3D imx_clk_hw_mux_flags("spll_pre_sel", b=
ase + 0x608, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_G=
ATE);
+	hws[IMX7ULP_CLK_APLL_PRE_SEL]	=3D imx_clk_hw_mux_flags("apll_pre_sel", ba=
se + 0x508, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GA=
TE);
+	hws[IMX7ULP_CLK_SPLL_PRE_SEL]	=3D imx_clk_hw_mux_flags("spll_pre_sel", ba=
se + 0x608, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GA=
TE);
=20
 	/*							   name		    parent_name	   reg			shift	width	flags */
-	clks[IMX7ULP_CLK_APLL_PRE_DIV]	=3D imx_clk_hw_divider_flags("apll_pre_div=
", "apll_pre_sel", base + 0x508,	8,	3,	CLK_SET_RATE_GATE);
-	clks[IMX7ULP_CLK_SPLL_PRE_DIV]	=3D imx_clk_hw_divider_flags("spll_pre_div=
", "spll_pre_sel", base + 0x608,	8,	3,	CLK_SET_RATE_GATE);
+	hws[IMX7ULP_CLK_APLL_PRE_DIV]	=3D imx_clk_hw_divider_flags("apll_pre_div"=
, "apll_pre_sel", base + 0x508,	8,	3,	CLK_SET_RATE_GATE);
+	hws[IMX7ULP_CLK_SPLL_PRE_DIV]	=3D imx_clk_hw_divider_flags("spll_pre_div"=
, "spll_pre_sel", base + 0x608,	8,	3,	CLK_SET_RATE_GATE);
=20
 	/*						name	 parent_name	 base */
-	clks[IMX7ULP_CLK_APLL]		=3D imx_clk_hw_pllv4("apll",  "apll_pre_div", bas=
e + 0x500);
-	clks[IMX7ULP_CLK_SPLL]		=3D imx_clk_hw_pllv4("spll",  "spll_pre_div", bas=
e + 0x600);
+	hws[IMX7ULP_CLK_APLL]		=3D imx_clk_hw_pllv4("apll",  "apll_pre_div", base=
 + 0x500);
+	hws[IMX7ULP_CLK_SPLL]		=3D imx_clk_hw_pllv4("spll",  "spll_pre_div", base=
 + 0x600);
=20
 	/* APLL PFDs */
-	clks[IMX7ULP_CLK_APLL_PFD0]	=3D imx_clk_hw_pfdv2("apll_pfd0", "apll", bas=
e + 0x50c, 0);
-	clks[IMX7ULP_CLK_APLL_PFD1]	=3D imx_clk_hw_pfdv2("apll_pfd1", "apll", bas=
e + 0x50c, 1);
-	clks[IMX7ULP_CLK_APLL_PFD2]	=3D imx_clk_hw_pfdv2("apll_pfd2", "apll", bas=
e + 0x50c, 2);
-	clks[IMX7ULP_CLK_APLL_PFD3]	=3D imx_clk_hw_pfdv2("apll_pfd3", "apll", bas=
e + 0x50c, 3);
+	hws[IMX7ULP_CLK_APLL_PFD0]	=3D imx_clk_hw_pfdv2("apll_pfd0", "apll", base=
 + 0x50c, 0);
+	hws[IMX7ULP_CLK_APLL_PFD1]	=3D imx_clk_hw_pfdv2("apll_pfd1", "apll", base=
 + 0x50c, 1);
+	hws[IMX7ULP_CLK_APLL_PFD2]	=3D imx_clk_hw_pfdv2("apll_pfd2", "apll", base=
 + 0x50c, 2);
+	hws[IMX7ULP_CLK_APLL_PFD3]	=3D imx_clk_hw_pfdv2("apll_pfd3", "apll", base=
 + 0x50c, 3);
=20
 	/* SPLL PFDs */
-	clks[IMX7ULP_CLK_SPLL_PFD0]	=3D imx_clk_hw_pfdv2("spll_pfd0", "spll", bas=
e + 0x60C, 0);
-	clks[IMX7ULP_CLK_SPLL_PFD1]	=3D imx_clk_hw_pfdv2("spll_pfd1", "spll", bas=
e + 0x60C, 1);
-	clks[IMX7ULP_CLK_SPLL_PFD2]	=3D imx_clk_hw_pfdv2("spll_pfd2", "spll", bas=
e + 0x60C, 2);
-	clks[IMX7ULP_CLK_SPLL_PFD3]	=3D imx_clk_hw_pfdv2("spll_pfd3", "spll", bas=
e + 0x60C, 3);
+	hws[IMX7ULP_CLK_SPLL_PFD0]	=3D imx_clk_hw_pfdv2("spll_pfd0", "spll", base=
 + 0x60C, 0);
+	hws[IMX7ULP_CLK_SPLL_PFD1]	=3D imx_clk_hw_pfdv2("spll_pfd1", "spll", base=
 + 0x60C, 1);
+	hws[IMX7ULP_CLK_SPLL_PFD2]	=3D imx_clk_hw_pfdv2("spll_pfd2", "spll", base=
 + 0x60C, 2);
+	hws[IMX7ULP_CLK_SPLL_PFD3]	=3D imx_clk_hw_pfdv2("spll_pfd3", "spll", base=
 + 0x60C, 3);
=20
 	/* PLL Mux */
-	clks[IMX7ULP_CLK_APLL_PFD_SEL]	=3D imx_clk_hw_mux_flags("apll_pfd_sel", b=
ase + 0x508, 14, 2, apll_pfd_sels, ARRAY_SIZE(apll_pfd_sels), CLK_SET_RATE_=
PARENT | CLK_SET_PARENT_GATE);
-	clks[IMX7ULP_CLK_SPLL_PFD_SEL]	=3D imx_clk_hw_mux_flags("spll_pfd_sel", b=
ase + 0x608, 14, 2, spll_pfd_sels, ARRAY_SIZE(spll_pfd_sels), CLK_SET_RATE_=
PARENT | CLK_SET_PARENT_GATE);
-	clks[IMX7ULP_CLK_APLL_SEL]	=3D imx_clk_hw_mux_flags("apll_sel", base + 0x=
508, 1, 1, apll_sels, ARRAY_SIZE(apll_sels), CLK_SET_RATE_PARENT | CLK_SET_=
PARENT_GATE);
-	clks[IMX7ULP_CLK_SPLL_SEL]	=3D imx_clk_hw_mux_flags("spll_sel", base + 0x=
608, 1, 1, spll_sels, ARRAY_SIZE(spll_sels), CLK_SET_RATE_PARENT | CLK_SET_=
PARENT_GATE);
+	hws[IMX7ULP_CLK_APLL_PFD_SEL]	=3D imx_clk_hw_mux_flags("apll_pfd_sel", ba=
se + 0x508, 14, 2, apll_pfd_sels, ARRAY_SIZE(apll_pfd_sels), CLK_SET_RATE_P=
ARENT | CLK_SET_PARENT_GATE);
+	hws[IMX7ULP_CLK_SPLL_PFD_SEL]	=3D imx_clk_hw_mux_flags("spll_pfd_sel", ba=
se + 0x608, 14, 2, spll_pfd_sels, ARRAY_SIZE(spll_pfd_sels), CLK_SET_RATE_P=
ARENT | CLK_SET_PARENT_GATE);
+	hws[IMX7ULP_CLK_APLL_SEL]	=3D imx_clk_hw_mux_flags("apll_sel", base + 0x5=
08, 1, 1, apll_sels, ARRAY_SIZE(apll_sels), CLK_SET_RATE_PARENT | CLK_SET_P=
ARENT_GATE);
+	hws[IMX7ULP_CLK_SPLL_SEL]	=3D imx_clk_hw_mux_flags("spll_sel", base + 0x6=
08, 1, 1, spll_sels, ARRAY_SIZE(spll_sels), CLK_SET_RATE_PARENT | CLK_SET_P=
ARENT_GATE);
=20
-	clks[IMX7ULP_CLK_SPLL_BUS_CLK]	=3D imx_clk_hw_divider_gate("spll_bus_clk"=
, "spll_sel", CLK_SET_RATE_GATE, base + 0x604, 8, 3, 0, ulp_div_table, &imx=
_ccm_lock);
+	hws[IMX7ULP_CLK_SPLL_BUS_CLK]	=3D imx_clk_hw_divider_gate("spll_bus_clk",=
 "spll_sel", CLK_SET_RATE_GATE, base + 0x604, 8, 3, 0, ulp_div_table, &imx_=
ccm_lock);
=20
 	/* scs/ddr/nic select different clock source requires that clock to be en=
abled first */
-	clks[IMX7ULP_CLK_SYS_SEL]	=3D imx_clk_hw_mux2("scs_sel", base + 0x14, 24,=
 4, scs_sels, ARRAY_SIZE(scs_sels));
-	clks[IMX7ULP_CLK_HSRUN_SYS_SEL] =3D imx_clk_hw_mux2("hsrun_scs_sel", base=
 + 0x1c, 24, 4, scs_sels, ARRAY_SIZE(scs_sels));
-	clks[IMX7ULP_CLK_NIC_SEL]	=3D imx_clk_hw_mux2("nic_sel", base + 0x40, 28,=
 1, nic_sels, ARRAY_SIZE(nic_sels));
-	clks[IMX7ULP_CLK_DDR_SEL]	=3D imx_clk_hw_mux_flags("ddr_sel", base + 0x30=
, 24, 2, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARE=
NT_ENABLE);
+	hws[IMX7ULP_CLK_SYS_SEL]	=3D imx_clk_hw_mux2("scs_sel", base + 0x14, 24, =
4, scs_sels, ARRAY_SIZE(scs_sels));
+	hws[IMX7ULP_CLK_HSRUN_SYS_SEL] =3D imx_clk_hw_mux2("hsrun_scs_sel", base =
+ 0x1c, 24, 4, scs_sels, ARRAY_SIZE(scs_sels));
+	hws[IMX7ULP_CLK_NIC_SEL]	=3D imx_clk_hw_mux2("nic_sel", base + 0x40, 28, =
1, nic_sels, ARRAY_SIZE(nic_sels));
+	hws[IMX7ULP_CLK_DDR_SEL]	=3D imx_clk_hw_mux_flags("ddr_sel", base + 0x30,=
 24, 2, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PAREN=
T_ENABLE);
=20
-	clks[IMX7ULP_CLK_CORE_DIV]	=3D imx_clk_hw_divider_flags("divcore",	"scs_s=
el",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
-	clks[IMX7ULP_CLK_HSRUN_CORE_DIV] =3D imx_clk_hw_divider_flags("hsrun_divc=
ore", "hsrun_scs_sel", base + 0x1c, 16, 4, CLK_SET_RATE_PARENT);
+	hws[IMX7ULP_CLK_CORE_DIV]	=3D imx_clk_hw_divider_flags("divcore",	"scs_se=
l",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
+	hws[IMX7ULP_CLK_HSRUN_CORE_DIV] =3D imx_clk_hw_divider_flags("hsrun_divco=
re", "hsrun_scs_sel", base + 0x1c, 16, 4, CLK_SET_RATE_PARENT);
=20
-	clks[IMX7ULP_CLK_DDR_DIV]	=3D imx_clk_hw_divider_gate("ddr_clk", "ddr_sel=
", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
+	hws[IMX7ULP_CLK_DDR_DIV]	=3D imx_clk_hw_divider_gate("ddr_clk", "ddr_sel"=
, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
 							       0, ulp_div_table, &imx_ccm_lock);
=20
-	clks[IMX7ULP_CLK_NIC0_DIV]	=3D imx_clk_hw_divider_flags("nic0_clk",		"nic=
_sel",  base + 0x40, 24, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX7ULP_CLK_NIC1_DIV]	=3D imx_clk_hw_divider_flags("nic1_clk",		"nic=
0_clk", base + 0x40, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
-	clks[IMX7ULP_CLK_NIC1_BUS_DIV]	=3D imx_clk_hw_divider_flags("nic1_bus_clk=
",	"nic0_clk", base + 0x40, 4,  4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	hws[IMX7ULP_CLK_NIC0_DIV]	=3D imx_clk_hw_divider_flags("nic0_clk",		"nic_=
sel",  base + 0x40, 24, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	hws[IMX7ULP_CLK_NIC1_DIV]	=3D imx_clk_hw_divider_flags("nic1_clk",		"nic0=
_clk", base + 0x40, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	hws[IMX7ULP_CLK_NIC1_BUS_DIV]	=3D imx_clk_hw_divider_flags("nic1_bus_clk"=
,	"nic0_clk", base + 0x40, 4,  4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
=20
-	clks[IMX7ULP_CLK_GPU_DIV]	=3D imx_clk_hw_divider("gpu_clk", "nic0_clk", b=
ase + 0x40, 20, 4);
+	hws[IMX7ULP_CLK_GPU_DIV]	=3D imx_clk_hw_divider("gpu_clk", "nic0_clk", ba=
se + 0x40, 20, 4);
=20
-	clks[IMX7ULP_CLK_SOSC_BUS_CLK]	=3D imx_clk_hw_divider_gate("sosc_bus_clk"=
, "sosc", 0, base + 0x104, 8, 3,
+	hws[IMX7ULP_CLK_SOSC_BUS_CLK]	=3D imx_clk_hw_divider_gate("sosc_bus_clk",=
 "sosc", 0, base + 0x104, 8, 3,
 							       CLK_DIVIDER_READ_ONLY, ulp_div_table, &imx_ccm_lock);
-	clks[IMX7ULP_CLK_FIRC_BUS_CLK]	=3D imx_clk_hw_divider_gate("firc_bus_clk"=
, "firc", 0, base + 0x304, 8, 3,
+	hws[IMX7ULP_CLK_FIRC_BUS_CLK]	=3D imx_clk_hw_divider_gate("firc_bus_clk",=
 "firc", 0, base + 0x304, 8, 3,
 							       CLK_DIVIDER_READ_ONLY, ulp_div_table, &imx_ccm_lock);
=20
-	imx_check_clk_hws(clks, clk_data->num);
+	imx_check_clk_hws(hws, clk_data->num);
=20
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 }
@@ -145,7 +145,7 @@ CLK_OF_DECLARE(imx7ulp_clk_scg1, "fsl,imx7ulp-scg1", im=
x7ulp_clk_scg1_init);
 static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 {
 	struct clk_hw_onecell_data *clk_data;
-	struct clk_hw **clks;
+	struct clk_hw **hws;
 	void __iomem *base;
 	int i;
=20
@@ -155,42 +155,42 @@ static void __init imx7ulp_clk_pcc2_init(struct devic=
e_node *np)
 		return;
=20
 	clk_data->num =3D IMX7ULP_CLK_PCC2_END;
-	clks =3D clk_data->hws;
+	hws =3D clk_data->hws;
=20
 	/* PCC2 */
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
-	clks[IMX7ULP_CLK_DMA1]		=3D imx_clk_hw_gate("dma1", "nic1_clk", base + 0x=
20, 30);
-	clks[IMX7ULP_CLK_RGPIO2P1]	=3D imx_clk_hw_gate("rgpio2p1", "nic1_bus_clk"=
, base + 0x3c, 30);
-	clks[IMX7ULP_CLK_DMA_MUX1]	=3D imx_clk_hw_gate("dma_mux1", "nic1_bus_clk"=
, base + 0x84, 30);
-	clks[IMX7ULP_CLK_CAAM]		=3D imx_clk_hw_gate("caam", "nic1_clk", base + 0x=
90, 30);
-	clks[IMX7ULP_CLK_LPTPM4]	=3D imx7ulp_clk_hw_composite("lptpm4",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
-	clks[IMX7ULP_CLK_LPTPM5]	=3D imx7ulp_clk_hw_composite("lptpm5",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
-	clks[IMX7ULP_CLK_LPIT1]		=3D imx7ulp_clk_hw_composite("lpit1",   periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
-	clks[IMX7ULP_CLK_LPSPI2]	=3D imx7ulp_clk_hw_composite("lpspi2",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
-	clks[IMX7ULP_CLK_LPSPI3]	=3D imx7ulp_clk_hw_composite("lpspi3",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
-	clks[IMX7ULP_CLK_LPI2C4]	=3D imx7ulp_clk_hw_composite("lpi2c4",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
-	clks[IMX7ULP_CLK_LPI2C5]	=3D imx7ulp_clk_hw_composite("lpi2c5",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
-	clks[IMX7ULP_CLK_LPUART4]	=3D imx7ulp_clk_hw_composite("lpuart4", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
-	clks[IMX7ULP_CLK_LPUART5]	=3D imx7ulp_clk_hw_composite("lpuart5", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
-	clks[IMX7ULP_CLK_FLEXIO1]	=3D imx7ulp_clk_hw_composite("flexio1", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
-	clks[IMX7ULP_CLK_USB0]		=3D imx7ulp_clk_hw_composite("usb0",    periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
-	clks[IMX7ULP_CLK_USB1]		=3D imx7ulp_clk_hw_composite("usb1",    periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
-	clks[IMX7ULP_CLK_USB_PHY]	=3D imx_clk_hw_gate("usb_phy", "nic1_bus_clk", =
base + 0xd4, 30);
-	clks[IMX7ULP_CLK_USDHC0]	=3D imx7ulp_clk_hw_composite("usdhc0",  periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
-	clks[IMX7ULP_CLK_USDHC1]	=3D imx7ulp_clk_hw_composite("usdhc1",  periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
-	clks[IMX7ULP_CLK_WDG1]		=3D imx7ulp_clk_hw_composite("wdg1",    periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
-	clks[IMX7ULP_CLK_WDG2]		=3D imx7ulp_clk_hw_composite("sdg2",    periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
-
-	imx_check_clk_hws(clks, clk_data->num);
+	hws[IMX7ULP_CLK_DMA1]		=3D imx_clk_hw_gate("dma1", "nic1_clk", base + 0x2=
0, 30);
+	hws[IMX7ULP_CLK_RGPIO2P1]	=3D imx_clk_hw_gate("rgpio2p1", "nic1_bus_clk",=
 base + 0x3c, 30);
+	hws[IMX7ULP_CLK_DMA_MUX1]	=3D imx_clk_hw_gate("dma_mux1", "nic1_bus_clk",=
 base + 0x84, 30);
+	hws[IMX7ULP_CLK_CAAM]		=3D imx_clk_hw_gate("caam", "nic1_clk", base + 0x9=
0, 30);
+	hws[IMX7ULP_CLK_LPTPM4]	=3D imx7ulp_clk_hw_composite("lptpm4",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	hws[IMX7ULP_CLK_LPTPM5]	=3D imx7ulp_clk_hw_composite("lptpm5",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	hws[IMX7ULP_CLK_LPIT1]		=3D imx7ulp_clk_hw_composite("lpit1",   periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	hws[IMX7ULP_CLK_LPSPI2]	=3D imx7ulp_clk_hw_composite("lpspi2",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
+	hws[IMX7ULP_CLK_LPSPI3]	=3D imx7ulp_clk_hw_composite("lpspi3",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
+	hws[IMX7ULP_CLK_LPI2C4]	=3D imx7ulp_clk_hw_composite("lpi2c4",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
+	hws[IMX7ULP_CLK_LPI2C5]	=3D imx7ulp_clk_hw_composite("lpi2c5",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
+	hws[IMX7ULP_CLK_LPUART4]	=3D imx7ulp_clk_hw_composite("lpuart4", periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
+	hws[IMX7ULP_CLK_LPUART5]	=3D imx7ulp_clk_hw_composite("lpuart5", periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
+	hws[IMX7ULP_CLK_FLEXIO1]	=3D imx7ulp_clk_hw_composite("flexio1", periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
+	hws[IMX7ULP_CLK_USB0]		=3D imx7ulp_clk_hw_composite("usb0",    periph_pla=
t_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
+	hws[IMX7ULP_CLK_USB1]		=3D imx7ulp_clk_hw_composite("usb1",    periph_pla=
t_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
+	hws[IMX7ULP_CLK_USB_PHY]	=3D imx_clk_hw_gate("usb_phy", "nic1_bus_clk", b=
ase + 0xd4, 30);
+	hws[IMX7ULP_CLK_USDHC0]	=3D imx7ulp_clk_hw_composite("usdhc0",  periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
+	hws[IMX7ULP_CLK_USDHC1]	=3D imx7ulp_clk_hw_composite("usdhc1",  periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
+	hws[IMX7ULP_CLK_WDG1]		=3D imx7ulp_clk_hw_composite("wdg1",    periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
+	hws[IMX7ULP_CLK_WDG2]		=3D imx7ulp_clk_hw_composite("sdg2",    periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
+
+	imx_check_clk_hws(hws, clk_data->num);
=20
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
=20
 	for (i =3D 0; i < ARRAY_SIZE(pcc2_uart_clk_ids); i++) {
 		int index =3D pcc2_uart_clk_ids[i];
=20
-		pcc2_uart_clks[i] =3D &clks[index]->clk;
+		pcc2_uart_clks[i] =3D &hws[index]->clk;
 	}
=20
 	imx_register_uart_clocks(pcc2_uart_clks);
@@ -200,7 +200,7 @@ CLK_OF_DECLARE(imx7ulp_clk_pcc2, "fsl,imx7ulp-pcc2", im=
x7ulp_clk_pcc2_init);
 static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 {
 	struct clk_hw_onecell_data *clk_data;
-	struct clk_hw **clks;
+	struct clk_hw **hws;
 	void __iomem *base;
 	int i;
=20
@@ -210,41 +210,41 @@ static void __init imx7ulp_clk_pcc3_init(struct devic=
e_node *np)
 		return;
=20
 	clk_data->num =3D IMX7ULP_CLK_PCC3_END;
-	clks =3D clk_data->hws;
+	hws =3D clk_data->hws;
=20
 	/* PCC3 */
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
-	clks[IMX7ULP_CLK_LPTPM6]	=3D imx7ulp_clk_hw_composite("lptpm6",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
-	clks[IMX7ULP_CLK_LPTPM7]	=3D imx7ulp_clk_hw_composite("lptpm7",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
+	hws[IMX7ULP_CLK_LPTPM6]	=3D imx7ulp_clk_hw_composite("lptpm6",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
+	hws[IMX7ULP_CLK_LPTPM7]	=3D imx7ulp_clk_hw_composite("lptpm7",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
=20
-	clks[IMX7ULP_CLK_MMDC]		=3D clk_hw_register_gate(NULL, "mmdc", "nic1_clk"=
, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+	hws[IMX7ULP_CLK_MMDC]		=3D clk_hw_register_gate(NULL, "mmdc", "nic1_clk",=
 CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 							       base + 0xac, 30, 0, &imx_ccm_lock);
-	clks[IMX7ULP_CLK_LPI2C6]	=3D imx7ulp_clk_hw_composite("lpi2c6",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
-	clks[IMX7ULP_CLK_LPI2C7]	=3D imx7ulp_clk_hw_composite("lpi2c7",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
-	clks[IMX7ULP_CLK_LPUART6]	=3D imx7ulp_clk_hw_composite("lpuart6", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
-	clks[IMX7ULP_CLK_LPUART7]	=3D imx7ulp_clk_hw_composite("lpuart7", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
-	clks[IMX7ULP_CLK_DSI]		=3D imx7ulp_clk_hw_composite("dsi",     periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
-	clks[IMX7ULP_CLK_LCDIF]		=3D imx7ulp_clk_hw_composite("lcdif",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
+	hws[IMX7ULP_CLK_LPI2C6]	=3D imx7ulp_clk_hw_composite("lpi2c6",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
+	hws[IMX7ULP_CLK_LPI2C7]	=3D imx7ulp_clk_hw_composite("lpi2c7",  periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	hws[IMX7ULP_CLK_LPUART6]	=3D imx7ulp_clk_hw_composite("lpuart6", periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	hws[IMX7ULP_CLK_LPUART7]	=3D imx7ulp_clk_hw_composite("lpuart7", periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	hws[IMX7ULP_CLK_DSI]		=3D imx7ulp_clk_hw_composite("dsi",     periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
+	hws[IMX7ULP_CLK_LCDIF]		=3D imx7ulp_clk_hw_composite("lcdif",   periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
=20
-	clks[IMX7ULP_CLK_VIU]		=3D imx_clk_hw_gate("viu",   "nic1_clk",	   base +=
 0xa0, 30);
-	clks[IMX7ULP_CLK_PCTLC]		=3D imx_clk_hw_gate("pctlc", "nic1_bus_clk", bas=
e + 0xb8, 30);
-	clks[IMX7ULP_CLK_PCTLD]		=3D imx_clk_hw_gate("pctld", "nic1_bus_clk", bas=
e + 0xbc, 30);
-	clks[IMX7ULP_CLK_PCTLE]		=3D imx_clk_hw_gate("pctle", "nic1_bus_clk", bas=
e + 0xc0, 30);
-	clks[IMX7ULP_CLK_PCTLF]		=3D imx_clk_hw_gate("pctlf", "nic1_bus_clk", bas=
e + 0xc4, 30);
+	hws[IMX7ULP_CLK_VIU]		=3D imx_clk_hw_gate("viu",   "nic1_clk",	   base + =
0xa0, 30);
+	hws[IMX7ULP_CLK_PCTLC]		=3D imx_clk_hw_gate("pctlc", "nic1_bus_clk", base=
 + 0xb8, 30);
+	hws[IMX7ULP_CLK_PCTLD]		=3D imx_clk_hw_gate("pctld", "nic1_bus_clk", base=
 + 0xbc, 30);
+	hws[IMX7ULP_CLK_PCTLE]		=3D imx_clk_hw_gate("pctle", "nic1_bus_clk", base=
 + 0xc0, 30);
+	hws[IMX7ULP_CLK_PCTLF]		=3D imx_clk_hw_gate("pctlf", "nic1_bus_clk", base=
 + 0xc4, 30);
=20
-	clks[IMX7ULP_CLK_GPU3D]		=3D imx7ulp_clk_hw_composite("gpu3d",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
-	clks[IMX7ULP_CLK_GPU2D]		=3D imx7ulp_clk_hw_composite("gpu2d",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
+	hws[IMX7ULP_CLK_GPU3D]		=3D imx7ulp_clk_hw_composite("gpu3d",   periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
+	hws[IMX7ULP_CLK_GPU2D]		=3D imx7ulp_clk_hw_composite("gpu2d",   periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
=20
-	imx_check_clk_hws(clks, clk_data->num);
+	imx_check_clk_hws(hws, clk_data->num);
=20
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
=20
 	for (i =3D 0; i < ARRAY_SIZE(pcc3_uart_clk_ids); i++) {
 		int index =3D pcc3_uart_clk_ids[i];
=20
-		pcc3_uart_clks[i] =3D &clks[index]->clk;
+		pcc3_uart_clks[i] =3D &hws[index]->clk;
 	}
=20
 	imx_register_uart_clocks(pcc3_uart_clks);
@@ -254,7 +254,7 @@ CLK_OF_DECLARE(imx7ulp_clk_pcc3, "fsl,imx7ulp-pcc3", im=
x7ulp_clk_pcc3_init);
 static void __init imx7ulp_clk_smc1_init(struct device_node *np)
 {
 	struct clk_hw_onecell_data *clk_data;
-	struct clk_hw **clks;
+	struct clk_hw **hws;
 	void __iomem *base;
=20
 	clk_data =3D kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_SMC1_END),
@@ -263,15 +263,15 @@ static void __init imx7ulp_clk_smc1_init(struct devic=
e_node *np)
 		return;
=20
 	clk_data->num =3D IMX7ULP_CLK_SMC1_END;
-	clks =3D clk_data->hws;
+	hws =3D clk_data->hws;
=20
 	/* SMC1 */
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
-	clks[IMX7ULP_CLK_ARM] =3D imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, =
arm_sels, ARRAY_SIZE(arm_sels), CLK_IS_CRITICAL);
+	hws[IMX7ULP_CLK_ARM] =3D imx_clk_hw_mux_flags("arm", base + 0x10, 8, 2, a=
rm_sels, ARRAY_SIZE(arm_sels), CLK_IS_CRITICAL);
=20
-	imx_check_clk_hws(clks, clk_data->num);
+	imx_check_clk_hws(hws, clk_data->num);
=20
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 }
--=20
2.7.4

