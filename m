Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D2CC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F9E2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aXdnFEhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfKVKs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:48:29 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:54809
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728945AbfKVKs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQzwECHSADIN4sL7QNLZRAl0o936yddiuSLoG5nYCVoMdtfLiuyU+WxSm3zvnF3GlyCAs0kUjKF7KHvIzbClBRut2nrSvwtHzRQAQ6vWSbQQLijhz3pvXua/FfAU8wubbKe0zwVRHiN+Sw5goBXFto9zKhYYISEtdGXYH8do3b3oljC4oTl1uRKVQlHPDXupuxAKKNaUEYHOBvlpiglkVYgJMgYzVpPeBKyhX4iFPWbg6l0RlLwKS5IbTr0Kx2bcnOzsm3WKf8WXZ2f8FmD2sunbgzvk0KjgZcURV+aSeKpz6vBsF9u4aIr20z8OPc8eR162rXDM7A/2mSY//dbvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPuYv25hNO5SD3jJI5LLppub0qnpHRLE7dhh40VZzOw=;
 b=bDVm/R03yIxIpg9x7Av9Rl8VZQKszNKBFDdbIkG8vwy4xuX2NXTahR1d+KBTagSMV4DfnGPBRyQno4m9nliDFVPkQdSU3fZC4H1axb1JldJsh13LWoKBlVU+TqFxy5vSl2IWu8oDv5K9m5iWBHiWKgFaud8MqrejUnsAZkbQTUtGD6+sa3MB4EONDiUInqKKiNGBpBUwBuroyWwUqyEl3M3CyVM1IPaRSD4ivxX3MeHsF07oVuy5ozDeaXhGPus5ycVaFWaaezkfRbaSJZ3e/e9KGNwstjuullc6Ic7YWRW9Wd7nIHuwIxb+SmYCaAOg3lIaeEUygwfSkyeS8TRDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPuYv25hNO5SD3jJI5LLppub0qnpHRLE7dhh40VZzOw=;
 b=aXdnFEhEpbZqTiaDUejUuM+45AiWAl3uJdWV3ef0Hgxb4CVry7Sz256OLar6H/w0PdSHNlVGITkPil0632OjiAvx2NeNF1e+3fY/SGE5IFlJhcbXMxPG9vffQFdPo8tyWpLDkhzUolUIRChyOZjUXAxeIy5Lz9A2/bZ5f3juiw0=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6961.eurprd04.prod.outlook.com (52.132.212.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:48:19 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:48:19 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 09/11] clk: imx: Rename the imx_clk_pfdv2 to imply it's
 clk_hw based
Thread-Topic: [PATCH v2 09/11] clk: imx: Rename the imx_clk_pfdv2 to imply
 it's clk_hw based
Thread-Index: AQHVoSJZkx/MqnVoLEGsmkLg5Tj5Mw==
Date:   Fri, 22 Nov 2019 10:48:18 +0000
Message-ID: <1574419679-3813-10-git-send-email-abel.vesa@nxp.com>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:15::33) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb02c53a-d149-4c19-393b-08d76f397c39
x-ms-traffictypediagnostic: AM0PR04MB6961:|AM0PR04MB6961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6961AC0CA71826AC80A44B69F6490@AM0PR04MB6961.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(186003)(44832011)(446003)(11346002)(2616005)(52116002)(76176011)(66446008)(64756008)(66556008)(66476007)(7736002)(478600001)(6636002)(36756003)(5660300002)(6506007)(26005)(2906002)(86362001)(14454004)(102836004)(386003)(305945005)(25786009)(66946007)(256004)(110136005)(8936002)(50226002)(6116002)(316002)(99286004)(54906003)(81166006)(81156014)(8676002)(6436002)(6512007)(4326008)(71190400001)(3846002)(71200400001)(66066001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6961;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PI0JsTmpgUOzaFShL67BdJWOJw3u3TwPnurufj2FestnUG1VPj659XhGCZhsjtS6+Q6+Y6iM14fiPCutSobvBmL5VEvL7TTauJAY1g3i9aZeve3fE63RMdkdUJ+UCHs3mOnX96l66Bm5xXx8JDO6l6DEHTzdVgy7kqCVSo57TYo7LaJUIDbbfTMF59feWxi17Y3Dq7jGqLBYnFeVtTe3Cf8qzq0+0fNhg4a+iLhZ10chh2C7JFDyajTSKs9Y0OKUIzhPhlkdhAZc+0k7B11eq5QK7RFXq7p5yTq+iHADnfMJ2u3Eh70rkbmY45972H9TDQO33Uu9q/iyEgi/votYyVtb1v44OBOmSeeHz49qPz7NlBltSHXMIHVu2wUms8QhLaQdLMMHB4cLObxO3F/hGzDJZPxC9hPS2hAIvDNxW47lQO0+1sB6lCFmBsnsiI2d
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb02c53a-d149-4c19-393b-08d76f397c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:48:18.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmeWlIN0USc8cOdgzCL8vzEGP0AnKwUa/UOBSR9Y6O2M1tpiOg4i79mvASUhNyVxtoCI7bTYoff8+yV7UOPT7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming the imx_clk_pfdv2 register function to imx_clk_hw_pfdv2 to be
more obvious it is clk_hw based.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 16 ++++++++--------
 drivers/clk/imx/clk-pfdv2.c   |  2 +-
 drivers/clk/imx/clk.h         |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index afd2c2c..314f9c2 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -94,16 +94,16 @@ static void __init imx7ulp_clk_scg1_init(struct device_=
node *np)
 	clks[IMX7ULP_CLK_SPLL]		=3D imx_clk_hw_pllv4("spll",  "spll_pre_div", bas=
e + 0x600);
=20
 	/* APLL PFDs */
-	clks[IMX7ULP_CLK_APLL_PFD0]	=3D imx_clk_pfdv2("apll_pfd0", "apll", base +=
 0x50c, 0);
-	clks[IMX7ULP_CLK_APLL_PFD1]	=3D imx_clk_pfdv2("apll_pfd1", "apll", base +=
 0x50c, 1);
-	clks[IMX7ULP_CLK_APLL_PFD2]	=3D imx_clk_pfdv2("apll_pfd2", "apll", base +=
 0x50c, 2);
-	clks[IMX7ULP_CLK_APLL_PFD3]	=3D imx_clk_pfdv2("apll_pfd3", "apll", base +=
 0x50c, 3);
+	clks[IMX7ULP_CLK_APLL_PFD0]	=3D imx_clk_hw_pfdv2("apll_pfd0", "apll", bas=
e + 0x50c, 0);
+	clks[IMX7ULP_CLK_APLL_PFD1]	=3D imx_clk_hw_pfdv2("apll_pfd1", "apll", bas=
e + 0x50c, 1);
+	clks[IMX7ULP_CLK_APLL_PFD2]	=3D imx_clk_hw_pfdv2("apll_pfd2", "apll", bas=
e + 0x50c, 2);
+	clks[IMX7ULP_CLK_APLL_PFD3]	=3D imx_clk_hw_pfdv2("apll_pfd3", "apll", bas=
e + 0x50c, 3);
=20
 	/* SPLL PFDs */
-	clks[IMX7ULP_CLK_SPLL_PFD0]	=3D imx_clk_pfdv2("spll_pfd0", "spll", base +=
 0x60C, 0);
-	clks[IMX7ULP_CLK_SPLL_PFD1]	=3D imx_clk_pfdv2("spll_pfd1", "spll", base +=
 0x60C, 1);
-	clks[IMX7ULP_CLK_SPLL_PFD2]	=3D imx_clk_pfdv2("spll_pfd2", "spll", base +=
 0x60C, 2);
-	clks[IMX7ULP_CLK_SPLL_PFD3]	=3D imx_clk_pfdv2("spll_pfd3", "spll", base +=
 0x60C, 3);
+	clks[IMX7ULP_CLK_SPLL_PFD0]	=3D imx_clk_hw_pfdv2("spll_pfd0", "spll", bas=
e + 0x60C, 0);
+	clks[IMX7ULP_CLK_SPLL_PFD1]	=3D imx_clk_hw_pfdv2("spll_pfd1", "spll", bas=
e + 0x60C, 1);
+	clks[IMX7ULP_CLK_SPLL_PFD2]	=3D imx_clk_hw_pfdv2("spll_pfd2", "spll", bas=
e + 0x60C, 2);
+	clks[IMX7ULP_CLK_SPLL_PFD3]	=3D imx_clk_hw_pfdv2("spll_pfd3", "spll", bas=
e + 0x60C, 3);
=20
 	/* PLL Mux */
 	clks[IMX7ULP_CLK_APLL_PFD_SEL]	=3D imx_clk_hw_mux_flags("apll_pfd_sel", b=
ase + 0x508, 14, 2, apll_pfd_sels, ARRAY_SIZE(apll_pfd_sels), CLK_SET_RATE_=
PARENT | CLK_SET_PARENT_GATE);
diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
index a03bbed..de93ce7 100644
--- a/drivers/clk/imx/clk-pfdv2.c
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -166,7 +166,7 @@ static const struct clk_ops clk_pfdv2_ops =3D {
 	.is_enabled     =3D clk_pfdv2_is_enabled,
 };
=20
-struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pfdv2(const char *name, const char *parent_name,
 			     void __iomem *reg, u8 idx)
 {
 	struct clk_init_data init;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 5ca4615..c9f626e 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -199,7 +199,7 @@ struct clk_hw *imx_clk_hw_gate_exclusive(const char *na=
me, const char *parent,
 struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
=20
-struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pfdv2(const char *name, const char *parent_name,
 			     void __iomem *reg, u8 idx);
=20
 struct clk_hw *imx_clk_hw_busy_divider(const char *name, const char *paren=
t_name,
--=20
2.7.4

