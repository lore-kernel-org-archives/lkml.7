Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB87C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE27520843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LIQZSvUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfEOM2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:28:30 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:55713
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbfEOM2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUKTTWtdup4kcg1hBTn5GgCNlMToZqlxuuoKC0uuBVk=;
 b=LIQZSvUGyMttw+e7AywSOcWi40wz/wUhZKXuMGqw/H+re7CIW4+I0QwFCNO8jAjq1w1LPE43G1+KJ86ytI9hPa7mNflxt7/b9nEpYDe2PoYpfc8yZBUHZg8cm6M9netBtXZ3zRBSm/rKATNuZzkX5xstR4TdQjpV1xGJTdMIY3g=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 12:28:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 12:28:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "pp@emlix.com" <pp@emlix.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/2] clk: imx: Use imx_mmdc_mask_handshake() API for
 masking MMDC channel
Thread-Topic: [PATCH V2 2/2] clk: imx: Use imx_mmdc_mask_handshake() API for
 masking MMDC channel
Thread-Index: AQHVCxmupCy7lBV1C029aC5p17PIAg==
Date:   Wed, 15 May 2019 12:28:19 +0000
Message-ID: <1557922984-20811-2-git-send-email-Anson.Huang@nxp.com>
References: <1557922984-20811-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557922984-20811-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0031.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da266132-ffc7-4753-38ee-08d6d930d064
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB39465E32DA38DC19F7AE2DCCF5090@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(5660300002)(68736007)(99286004)(8676002)(36756003)(2501003)(50226002)(66066001)(256004)(110136005)(14454004)(478600001)(81166006)(81156014)(8936002)(52116002)(66556008)(3846002)(73956011)(6116002)(6486002)(64756008)(66446008)(446003)(7416002)(2906002)(2201001)(76176011)(11346002)(66946007)(6506007)(102836004)(6436002)(7736002)(305945005)(6512007)(386003)(316002)(26005)(86362001)(486006)(71200400001)(71190400001)(4326008)(25786009)(476003)(2616005)(186003)(66476007)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yx3VXDHEMZ7gHl/mBCf+77MNXxpvpCxQFH5bvDu50lFFSK4fuPk4gsRHNPJUGdPkrwqzubeBH2Rg+M7WG5Goj2lIbRINwBPqHGooWMtzzHBb9/iT1Y2tHTraya2Q7U+hy2FqEeX3130LKIcMTKmpc3sqCDdtEKMsq3uhbvp/wIHGQ3ToMWcsTlq5hW5ylUsu1RKZS3NWXBSAv2SVzi8xN+mYzYtX6editvH69fIIoFgMLjE3Bvs/c2iE8XEF3dvz37rc+UJvQID3rTdTsWYq6nHaZYAPHLTEK/hARaW+olblI9jfTa+pgn3/yB5zBfh+NdbNdkbMnHV7gYiWA0PbHQss9QeJWzsDS0PY4xxIW0eUQricfSjVOpKZ8LvqGIltf5nDko0p0p19UY5UaHffq8YDg07zk+VMeeh7c1R4mEE=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <51EF862EDC503D40B06F3F92E712B7C5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da266132-ffc7-4753-38ee-08d6d930d064
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 12:28:20.0102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use imx_mmdc_mask_handshake() API instead of programming CCM
register directly in each platform to mask unused MMDC channel's
handshake.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
No changes.
---
 drivers/clk/imx/clk-imx6q.c   | 13 +------------
 drivers/clk/imx/clk-imx6sl.c  |  5 +----
 drivers/clk/imx/clk-imx6sll.c |  3 +--
 drivers/clk/imx/clk-imx6sx.c  |  5 +----
 drivers/clk/imx/clk-imx6ul.c  |  5 +----
 5 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 708e7c5..077276b 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -260,25 +260,14 @@ static bool pll6_bypassed(struct device_node *node)
 	return false;
 }
=20
-#define CCM_CCDR		0x04
 #define CCM_CCSR		0x0c
 #define CCM_CS2CDR		0x2c
=20
-#define CCDR_MMDC_CH1_MASK		BIT(16)
 #define CCSR_PLL3_SW_CLK_SEL		BIT(0)
=20
 #define CS2CDR_LDB_DI0_CLK_SEL_SHIFT	9
 #define CS2CDR_LDB_DI1_CLK_SEL_SHIFT	12
=20
-static void __init imx6q_mmdc_ch1_mask_handshake(void __iomem *ccm_base)
-{
-	unsigned int reg;
-
-	reg =3D readl_relaxed(ccm_base + CCM_CCDR);
-	reg |=3D CCDR_MMDC_CH1_MASK;
-	writel_relaxed(reg, ccm_base + CCM_CCDR);
-}
-
 /*
  * The only way to disable the MMDC_CH1 clock is to move it to pll3_sw_clk
  * via periph2_clk2_sel and then to disable pll3_sw_clk by selecting the
@@ -651,7 +640,7 @@ static void __init imx6q_clocks_init(struct device_node=
 *ccm_node)
=20
 	disable_anatop_clocks(anatop_base);
=20
-	imx6q_mmdc_ch1_mask_handshake(base);
+	imx_mmdc_mask_handshake(base, 1);
=20
 	if (clk_on_imx6qp()) {
 		clk[IMX6QDL_CLK_LDB_DI0_SEL]      =3D imx_clk_mux_flags("ldb_di0_sel", b=
ase + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_=
PARENT);
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index e13d881..acb5983 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -17,8 +17,6 @@
=20
 #include "clk.h"
=20
-#define CCDR				0x4
-#define BM_CCM_CCDR_MMDC_CH0_MASK	(1 << 17)
 #define CCSR			0xc
 #define BM_CCSR_PLL1_SW_CLK_SEL	(1 << 2)
 #define CACRR			0x10
@@ -414,8 +412,7 @@ static void __init imx6sl_clocks_init(struct device_nod=
e *ccm_node)
 	clks[IMX6SL_CLK_USDHC4]       =3D imx_clk_gate2("usdhc4",       "usdhc4_p=
odf",       base + 0x80, 8);
=20
 	/* Ensure the MMDC CH0 handshake is bypassed */
-	writel_relaxed(readl_relaxed(base + CCDR) |
-		BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
+	imx_mmdc_mask_handshake(base, 0);
=20
 	imx_check_clocks(clks, ARRAY_SIZE(clks));
=20
diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 7eea448..3aa71c9 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -16,7 +16,6 @@
 #include "clk.h"
=20
 #define CCM_ANALOG_PLL_BYPASS		(0x1 << 16)
-#define BM_CCM_CCDR_MMDC_CH0_MASK	(0x2 << 16)
 #define xPLL_CLR(offset)		(offset + 0x8)
=20
 static const char *pll_bypass_src_sels[] =3D { "osc", "dummy", };
@@ -340,7 +339,7 @@ static void __init imx6sll_clocks_init(struct device_no=
de *ccm_node)
 	clks[IMX6SLL_CLK_USDHC3]	=3D imx_clk_gate2("usdhc3", "usdhc3_podf",  base=
 + 0x80,	6);
=20
 	/* mask handshake of mmdc */
-	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + 0x4);
+	imx_mmdc_mask_handshake(base, 0);
=20
 	imx_check_clocks(clks, ARRAY_SIZE(clks));
=20
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 91558b0..24f7b4d 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -22,9 +22,6 @@
=20
 #include "clk.h"
=20
-#define CCDR    0x4
-#define BM_CCM_CCDR_MMDC_CH0_MASK       (0x2 << 16)
-
 static const char *step_sels[]		=3D { "osc", "pll2_pfd2_396m", };
 static const char *pll1_sw_sels[]	=3D { "pll1_sys", "step", };
 static const char *periph_pre_sels[]	=3D { "pll2_bus", "pll2_pfd2_396m", "=
pll2_pfd0_352m", "pll2_198m", };
@@ -488,7 +485,7 @@ static void __init imx6sx_clocks_init(struct device_nod=
e *ccm_node)
 	clks[IMX6SX_CLK_CKO2]         =3D imx_clk_gate("cko2",           "cko2_po=
df",         base + 0x60, 24);
=20
 	/* mask handshake of mmdc */
-	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
+	imx_mmdc_mask_handshake(base, 0);
=20
 	imx_check_clocks(clks, ARRAY_SIZE(clks));
=20
diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index fd60d15..4bf3226 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -22,9 +22,6 @@
=20
 #include "clk.h"
=20
-#define BM_CCM_CCDR_MMDC_CH0_MASK	(0x2 << 16)
-#define CCDR	0x4
-
 static const char *pll_bypass_src_sels[] =3D { "osc", "dummy", };
 static const char *pll1_bypass_sels[] =3D { "pll1", "pll1_bypass_src", };
 static const char *pll2_bypass_sels[] =3D { "pll2", "pll2_bypass_src", };
@@ -464,7 +461,7 @@ static void __init imx6ul_clocks_init(struct device_nod=
e *ccm_node)
 	clks[IMX6UL_CLK_CKO2]		=3D imx_clk_gate("cko2",		"cko2_podf",	 base + 0x6=
0,	24);
=20
 	/* mask handshake of mmdc */
-	writel_relaxed(BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
+	imx_mmdc_mask_handshake(base, 0);
=20
 	imx_check_clocks(clks, ARRAY_SIZE(clks));
=20
--=20
2.7.4

