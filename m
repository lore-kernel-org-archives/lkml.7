Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938B9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153F220850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uNwwI5n6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCVPho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:44 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:41091
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbfCVPhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77fVNcNyU7X2rBh0giDwsMRBkTIKtLkB8Nigz3SHbDk=;
 b=uNwwI5n6DD1Lq3fZpZHFnqgXXsLdCKI2SRxbApGpssw/gbMarDDFjhzyM6OHlVUsOW7mJnvD7xp1HxDVh++g6NhUG+Cr2fQylXe5XoYmdHviRfnSNARTpNayu/BL25NjZFtyiS3yCQkypAojTfJOIb39+t9PudaUs7FVW7jJql0=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:18 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:18 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 15/19] clk: imx6sl: Switch to clk_hw based API
Thread-Topic: [RFC 15/19] clk: imx6sl: Switch to clk_hw based API
Thread-Index: AQHU4MUiCHtI4sJXwU6czHq8no8WFQ==
Date:   Fri, 22 Mar 2019 15:37:18 +0000
Message-ID: <1553269010-15591-16-git-send-email-abel.vesa@nxp.com>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0170.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61950c1c-35d4-457f-f2c0-08d6aedc4248
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB5636EF8C63B31C6DCCEE278DF6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(53946003)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(386003)(4326008)(6116002)(30864003)(6486002)(50226002)(14444005)(6506007)(66066001)(256004)(76176011)(446003)(186003)(25786009)(11346002)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005)(32563001)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nEWp8nuNXlFCnhDU3gS+W5N7UGTIKs9M/Iflpl/X/9ZpdzjnkK0zY0oalW7SLfXJ/xzn4SE3jBUGqXjafMtyQaYw866aQRxEpxKTT2Hnj7ufgmQ7UbubZgGCnX6708o7l0yPOO1M0UWv/LApUwcg97lLC+eLmcBHutII9NEXZLMz5zxY47sSxWSQ8w2gtxv3u657wFm7UAI3ymUVSOUo4gyGn9Cu5XZeQPUtDzKvo6gQqowJcbRPg5Yr98iWWyGZjlxfClAtvZWpgilXZOAjmSTfL/nZS6EEttqNhLP9x/XCCooZ8AOwlZEXnQVttFd1BUEiUfknvkec2N+1yb3vxqVtD69XZQpJ/+j0t1pRcaT0ybZZYJHFKuXiPMHqCfssa1aaruWuYJDUkkE+rvAiPb1PIX0OIdNfheXc15jrbzE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61950c1c-35d4-457f-f2c0-08d6aedc4248
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:18.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the entire clk-imx6sl driver to clk_hw based API.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx6sl.c | 404 ++++++++++++++++++++++-----------------=
----
 1 file changed, 209 insertions(+), 195 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index e13d881..71a2d67 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -101,8 +101,8 @@ static unsigned int share_count_ssi2;
 static unsigned int share_count_ssi3;
 static unsigned int share_count_spdif;
=20
-static struct clk *clks[IMX6SL_CLK_END];
-static struct clk_onecell_data clk_data;
+static struct clk_hw **hws;
+static struct clk_hw_onecell_data *clk_hw_data;
 static void __iomem *ccm_base;
 static void __iomem *anatop_base;
=20
@@ -183,74 +183,84 @@ void imx6sl_set_wait_clk(bool enter)
 		imx6sl_enable_pll_arm(false);
 }
=20
-static struct clk ** const uart_clks[] __initconst =3D {
-	&clks[IMX6SL_CLK_UART],
-	&clks[IMX6SL_CLK_UART_SERIAL],
-	NULL
+static const int uart_clk_ids[] __initconst =3D {
+	IMX6SL_CLK_UART,
+	IMX6SL_CLK_UART_SERIAL,
 };
=20
+static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
+
 static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
 	int ret;
+	int i;
+
+	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
+					  IMX6SL_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return;
+
+	clk_hw_data->num =3D IMX6SL_CLK_END;
+	hws =3D clk_hw_data->hws;
=20
-	clks[IMX6SL_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
-	clks[IMX6SL_CLK_CKIL] =3D imx_obtain_fixed_clock("ckil", 0);
-	clks[IMX6SL_CLK_OSC] =3D imx_obtain_fixed_clock("osc", 0);
+	hws[IMX6SL_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
+	hws[IMX6SL_CLK_CKIL] =3D imx_obtain_fixed_clock_hw("ckil", 0);
+	hws[IMX6SL_CLK_OSC] =3D imx_obtain_fixed_clock_hw("osc", 0);
 	/* Clock source from external clock via CLK1 PAD */
-	clks[IMX6SL_CLK_ANACLK1] =3D imx_obtain_fixed_clock("anaclk1", 0);
+	hws[IMX6SL_CLK_ANACLK1] =3D imx_obtain_fixed_clock_hw("anaclk1", 0);
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6sl-anatop");
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
 	anatop_base =3D base;
=20
-	clks[IMX6SL_PLL1_BYPASS_SRC] =3D imx_clk_mux("pll1_bypass_src", base + 0x=
00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SL_PLL2_BYPASS_SRC] =3D imx_clk_mux("pll2_bypass_src", base + 0x=
30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SL_PLL3_BYPASS_SRC] =3D imx_clk_mux("pll3_bypass_src", base + 0x=
10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SL_PLL4_BYPASS_SRC] =3D imx_clk_mux("pll4_bypass_src", base + 0x=
70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SL_PLL5_BYPASS_SRC] =3D imx_clk_mux("pll5_bypass_src", base + 0x=
a0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SL_PLL6_BYPASS_SRC] =3D imx_clk_mux("pll6_bypass_src", base + 0x=
e0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-	clks[IMX6SL_PLL7_BYPASS_SRC] =3D imx_clk_mux("pll7_bypass_src", base + 0x=
20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SL_PLL1_BYPASS_SRC] =3D imx_clk_hw_mux("pll1_bypass_src", base + =
0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SL_PLL2_BYPASS_SRC] =3D imx_clk_hw_mux("pll2_bypass_src", base + =
0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SL_PLL3_BYPASS_SRC] =3D imx_clk_hw_mux("pll3_bypass_src", base + =
0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SL_PLL4_BYPASS_SRC] =3D imx_clk_hw_mux("pll4_bypass_src", base + =
0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SL_PLL5_BYPASS_SRC] =3D imx_clk_hw_mux("pll5_bypass_src", base + =
0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SL_PLL6_BYPASS_SRC] =3D imx_clk_hw_mux("pll6_bypass_src", base + =
0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
+	hws[IMX6SL_PLL7_BYPASS_SRC] =3D imx_clk_hw_mux("pll7_bypass_src", base + =
0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
=20
 	/*                                    type               name    parent_n=
ame        base         div_mask */
-	clks[IMX6SL_CLK_PLL1] =3D imx_clk_pllv3(IMX_PLLV3_SYS,     "pll1", "osc",=
 base + 0x00, 0x7f);
-	clks[IMX6SL_CLK_PLL2] =3D imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc",=
 base + 0x30, 0x1);
-	clks[IMX6SL_CLK_PLL3] =3D imx_clk_pllv3(IMX_PLLV3_USB,     "pll3", "osc",=
 base + 0x10, 0x3);
-	clks[IMX6SL_CLK_PLL4] =3D imx_clk_pllv3(IMX_PLLV3_AV,      "pll4", "osc",=
 base + 0x70, 0x7f);
-	clks[IMX6SL_CLK_PLL5] =3D imx_clk_pllv3(IMX_PLLV3_AV,      "pll5", "osc",=
 base + 0xa0, 0x7f);
-	clks[IMX6SL_CLK_PLL6] =3D imx_clk_pllv3(IMX_PLLV3_ENET,    "pll6", "osc",=
 base + 0xe0, 0x3);
-	clks[IMX6SL_CLK_PLL7] =3D imx_clk_pllv3(IMX_PLLV3_USB,     "pll7", "osc",=
 base + 0x20, 0x3);
-
-	clks[IMX6SL_PLL1_BYPASS] =3D imx_clk_mux_flags("pll1_bypass", base + 0x00=
, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SL_PLL2_BYPASS] =3D imx_clk_mux_flags("pll2_bypass", base + 0x30=
, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SL_PLL3_BYPASS] =3D imx_clk_mux_flags("pll3_bypass", base + 0x10=
, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SL_PLL4_BYPASS] =3D imx_clk_mux_flags("pll4_bypass", base + 0x70=
, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SL_PLL5_BYPASS] =3D imx_clk_mux_flags("pll5_bypass", base + 0xa0=
, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SL_PLL6_BYPASS] =3D imx_clk_mux_flags("pll6_bypass", base + 0xe0=
, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PAREN=
T);
-	clks[IMX6SL_PLL7_BYPASS] =3D imx_clk_mux_flags("pll7_bypass", base + 0x20=
, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PAREN=
T);
+	hws[IMX6SL_CLK_PLL1] =3D imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc=
", base + 0x00, 0x7f);
+	hws[IMX6SL_CLK_PLL2] =3D imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc=
", base + 0x30, 0x1);
+	hws[IMX6SL_CLK_PLL3] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc=
", base + 0x10, 0x3);
+	hws[IMX6SL_CLK_PLL4] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc=
", base + 0x70, 0x7f);
+	hws[IMX6SL_CLK_PLL5] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc=
", base + 0xa0, 0x7f);
+	hws[IMX6SL_CLK_PLL6] =3D imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc=
", base + 0xe0, 0x3);
+	hws[IMX6SL_CLK_PLL7] =3D imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc=
", base + 0x20, 0x3);
+
+	hws[IMX6SL_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("pll1_bypass", base + 0x=
00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SL_PLL2_BYPASS] =3D imx_clk_hw_mux_flags("pll2_bypass", base + 0x=
30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SL_PLL3_BYPASS] =3D imx_clk_hw_mux_flags("pll3_bypass", base + 0x=
10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SL_PLL4_BYPASS] =3D imx_clk_hw_mux_flags("pll4_bypass", base + 0x=
70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SL_PLL5_BYPASS] =3D imx_clk_hw_mux_flags("pll5_bypass", base + 0x=
a0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SL_PLL6_BYPASS] =3D imx_clk_hw_mux_flags("pll6_bypass", base + 0x=
e0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PAR=
ENT);
+	hws[IMX6SL_PLL7_BYPASS] =3D imx_clk_hw_mux_flags("pll7_bypass", base + 0x=
20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PAR=
ENT);
=20
 	/* Do not bypass PLLs initially */
-	clk_set_parent(clks[IMX6SL_PLL1_BYPASS], clks[IMX6SL_CLK_PLL1]);
-	clk_set_parent(clks[IMX6SL_PLL2_BYPASS], clks[IMX6SL_CLK_PLL2]);
-	clk_set_parent(clks[IMX6SL_PLL3_BYPASS], clks[IMX6SL_CLK_PLL3]);
-	clk_set_parent(clks[IMX6SL_PLL4_BYPASS], clks[IMX6SL_CLK_PLL4]);
-	clk_set_parent(clks[IMX6SL_PLL5_BYPASS], clks[IMX6SL_CLK_PLL5]);
-	clk_set_parent(clks[IMX6SL_PLL6_BYPASS], clks[IMX6SL_CLK_PLL6]);
-	clk_set_parent(clks[IMX6SL_PLL7_BYPASS], clks[IMX6SL_CLK_PLL7]);
-
-	clks[IMX6SL_CLK_PLL1_SYS]      =3D imx_clk_gate("pll1_sys",      "pll1_by=
pass", base + 0x00, 13);
-	clks[IMX6SL_CLK_PLL2_BUS]      =3D imx_clk_gate("pll2_bus",      "pll2_by=
pass", base + 0x30, 13);
-	clks[IMX6SL_CLK_PLL3_USB_OTG]  =3D imx_clk_gate("pll3_usb_otg",  "pll3_by=
pass", base + 0x10, 13);
-	clks[IMX6SL_CLK_PLL4_AUDIO]    =3D imx_clk_gate("pll4_audio",    "pll4_by=
pass", base + 0x70, 13);
-	clks[IMX6SL_CLK_PLL5_VIDEO]    =3D imx_clk_gate("pll5_video",    "pll5_by=
pass", base + 0xa0, 13);
-	clks[IMX6SL_CLK_PLL6_ENET]     =3D imx_clk_gate("pll6_enet",     "pll6_by=
pass", base + 0xe0, 13);
-	clks[IMX6SL_CLK_PLL7_USB_HOST] =3D imx_clk_gate("pll7_usb_host", "pll7_by=
pass", base + 0x20, 13);
-
-	clks[IMX6SL_CLK_LVDS1_SEL] =3D imx_clk_mux("lvds1_sel", base + 0x160, 0, =
5, lvds_sels, ARRAY_SIZE(lvds_sels));
-	clks[IMX6SL_CLK_LVDS1_OUT] =3D imx_clk_gate_exclusive("lvds1_out", "lvds1=
_sel", base + 0x160, 10, BIT(12));
-	clks[IMX6SL_CLK_LVDS1_IN] =3D imx_clk_gate_exclusive("lvds1_in", "anaclk1=
", base + 0x160, 12, BIT(10));
+	clk_set_parent(hws[IMX6SL_PLL1_BYPASS]->clk, hws[IMX6SL_CLK_PLL1]->clk);
+	clk_set_parent(hws[IMX6SL_PLL2_BYPASS]->clk, hws[IMX6SL_CLK_PLL2]->clk);
+	clk_set_parent(hws[IMX6SL_PLL3_BYPASS]->clk, hws[IMX6SL_CLK_PLL3]->clk);
+	clk_set_parent(hws[IMX6SL_PLL4_BYPASS]->clk, hws[IMX6SL_CLK_PLL4]->clk);
+	clk_set_parent(hws[IMX6SL_PLL5_BYPASS]->clk, hws[IMX6SL_CLK_PLL5]->clk);
+	clk_set_parent(hws[IMX6SL_PLL6_BYPASS]->clk, hws[IMX6SL_CLK_PLL6]->clk);
+	clk_set_parent(hws[IMX6SL_PLL7_BYPASS]->clk, hws[IMX6SL_CLK_PLL7]->clk);
+
+	hws[IMX6SL_CLK_PLL1_SYS]      =3D imx_clk_hw_gate("pll1_sys",      "pll1_=
bypass", base + 0x00, 13);
+	hws[IMX6SL_CLK_PLL2_BUS]      =3D imx_clk_hw_gate("pll2_bus",      "pll2_=
bypass", base + 0x30, 13);
+	hws[IMX6SL_CLK_PLL3_USB_OTG]  =3D imx_clk_hw_gate("pll3_usb_otg",  "pll3_=
bypass", base + 0x10, 13);
+	hws[IMX6SL_CLK_PLL4_AUDIO]    =3D imx_clk_hw_gate("pll4_audio",    "pll4_=
bypass", base + 0x70, 13);
+	hws[IMX6SL_CLK_PLL5_VIDEO]    =3D imx_clk_hw_gate("pll5_video",    "pll5_=
bypass", base + 0xa0, 13);
+	hws[IMX6SL_CLK_PLL6_ENET]     =3D imx_clk_hw_gate("pll6_enet",     "pll6_=
bypass", base + 0xe0, 13);
+	hws[IMX6SL_CLK_PLL7_USB_HOST] =3D imx_clk_hw_gate("pll7_usb_host", "pll7_=
bypass", base + 0x20, 13);
+
+	hws[IMX6SL_CLK_LVDS1_SEL] =3D imx_clk_hw_mux("lvds1_sel", base + 0x160, 0=
, 5, lvds_sels, ARRAY_SIZE(lvds_sels));
+	hws[IMX6SL_CLK_LVDS1_OUT] =3D imx_clk_hw_gate_exclusive("lvds1_out", "lvd=
s1_sel", base + 0x160, 10, BIT(12));
+	hws[IMX6SL_CLK_LVDS1_IN] =3D imx_clk_hw_gate_exclusive("lvds1_in", "anacl=
k1", base + 0x160, 12, BIT(10));
=20
 	/*
 	 * usbphy1 and usbphy2 are implemented as dummy gates using reserve
@@ -259,32 +269,32 @@ static void __init imx6sl_clocks_init(struct device_n=
ode *ccm_node)
 	 * turned on during boot, and software will not need to control it
 	 * anymore after that.
 	 */
-	clks[IMX6SL_CLK_USBPHY1]      =3D imx_clk_gate("usbphy1",      "pll3_usb_=
otg",  base + 0x10, 20);
-	clks[IMX6SL_CLK_USBPHY2]      =3D imx_clk_gate("usbphy2",      "pll7_usb_=
host", base + 0x20, 20);
-	clks[IMX6SL_CLK_USBPHY1_GATE] =3D imx_clk_gate("usbphy1_gate", "dummy",  =
       base + 0x10, 6);
-	clks[IMX6SL_CLK_USBPHY2_GATE] =3D imx_clk_gate("usbphy2_gate", "dummy",  =
       base + 0x20, 6);
+	hws[IMX6SL_CLK_USBPHY1]      =3D imx_clk_hw_gate("usbphy1",      "pll3_us=
b_otg",  base + 0x10, 20);
+	hws[IMX6SL_CLK_USBPHY2]      =3D imx_clk_hw_gate("usbphy2",      "pll7_us=
b_host", base + 0x20, 20);
+	hws[IMX6SL_CLK_USBPHY1_GATE] =3D imx_clk_hw_gate("usbphy1_gate", "dummy",=
         base + 0x10, 6);
+	hws[IMX6SL_CLK_USBPHY2_GATE] =3D imx_clk_hw_gate("usbphy2_gate", "dummy",=
         base + 0x20, 6);
=20
 	/*                                                           dev   name  =
            parent_name      flags                reg        shift width di=
v: flags, div_table lock */
-	clks[IMX6SL_CLK_PLL4_POST_DIV]  =3D clk_register_divider_table(NULL, "pll=
4_post_div",  "pll4_audio",    CLK_SET_RATE_PARENT, base + 0x70,  19, 2,   =
0, post_div_table, &imx_ccm_lock);
-	clks[IMX6SL_CLK_PLL4_AUDIO_DIV] =3D       clk_register_divider(NULL, "pll=
4_audio_div", "pll4_post_div", CLK_SET_RATE_PARENT, base + 0x170, 15, 1,   =
0, &imx_ccm_lock);
-	clks[IMX6SL_CLK_PLL5_POST_DIV]  =3D clk_register_divider_table(NULL, "pll=
5_post_div",  "pll5_video",    CLK_SET_RATE_PARENT, base + 0xa0,  19, 2,   =
0, post_div_table, &imx_ccm_lock);
-	clks[IMX6SL_CLK_PLL5_VIDEO_DIV] =3D clk_register_divider_table(NULL, "pll=
5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2,   =
0, video_div_table, &imx_ccm_lock);
-	clks[IMX6SL_CLK_ENET_REF]       =3D clk_register_divider_table(NULL, "ene=
t_ref",       "pll6_enet",     0,                   base + 0xe0,  0,  2,   =
0, clk_enet_ref_table, &imx_ccm_lock);
+	hws[IMX6SL_CLK_PLL4_POST_DIV]  =3D clk_hw_register_divider_table(NULL, "p=
ll4_post_div",  "pll4_audio",    CLK_SET_RATE_PARENT, base + 0x70,  19, 2, =
  0, post_div_table, &imx_ccm_lock);
+	hws[IMX6SL_CLK_PLL4_AUDIO_DIV] =3D       clk_hw_register_divider(NULL, "p=
ll4_audio_div", "pll4_post_div", CLK_SET_RATE_PARENT, base + 0x170, 15, 1, =
  0, &imx_ccm_lock);
+	hws[IMX6SL_CLK_PLL5_POST_DIV]  =3D clk_hw_register_divider_table(NULL, "p=
ll5_post_div",  "pll5_video",    CLK_SET_RATE_PARENT, base + 0xa0,  19, 2, =
  0, post_div_table, &imx_ccm_lock);
+	hws[IMX6SL_CLK_PLL5_VIDEO_DIV] =3D clk_hw_register_divider_table(NULL, "p=
ll5_video_div", "pll5_post_div", CLK_SET_RATE_PARENT, base + 0x170, 30, 2, =
  0, video_div_table, &imx_ccm_lock);
+	hws[IMX6SL_CLK_ENET_REF]       =3D clk_hw_register_divider_table(NULL, "e=
net_ref",       "pll6_enet",     0,                   base + 0xe0,  0,  2, =
  0, clk_enet_ref_table, &imx_ccm_lock);
=20
 	/*                                       name         parent_name     reg=
           idx */
-	clks[IMX6SL_CLK_PLL2_PFD0] =3D imx_clk_pfd("pll2_pfd0", "pll2_bus",     b=
ase + 0x100, 0);
-	clks[IMX6SL_CLK_PLL2_PFD1] =3D imx_clk_pfd("pll2_pfd1", "pll2_bus",     b=
ase + 0x100, 1);
-	clks[IMX6SL_CLK_PLL2_PFD2] =3D imx_clk_pfd("pll2_pfd2", "pll2_bus",     b=
ase + 0x100, 2);
-	clks[IMX6SL_CLK_PLL3_PFD0] =3D imx_clk_pfd("pll3_pfd0", "pll3_usb_otg", b=
ase + 0xf0,  0);
-	clks[IMX6SL_CLK_PLL3_PFD1] =3D imx_clk_pfd("pll3_pfd1", "pll3_usb_otg", b=
ase + 0xf0,  1);
-	clks[IMX6SL_CLK_PLL3_PFD2] =3D imx_clk_pfd("pll3_pfd2", "pll3_usb_otg", b=
ase + 0xf0,  2);
-	clks[IMX6SL_CLK_PLL3_PFD3] =3D imx_clk_pfd("pll3_pfd3", "pll3_usb_otg", b=
ase + 0xf0,  3);
+	hws[IMX6SL_CLK_PLL2_PFD0] =3D imx_clk_hw_pfd("pll2_pfd0", "pll2_bus",    =
 base + 0x100, 0);
+	hws[IMX6SL_CLK_PLL2_PFD1] =3D imx_clk_hw_pfd("pll2_pfd1", "pll2_bus",    =
 base + 0x100, 1);
+	hws[IMX6SL_CLK_PLL2_PFD2] =3D imx_clk_hw_pfd("pll2_pfd2", "pll2_bus",    =
 base + 0x100, 2);
+	hws[IMX6SL_CLK_PLL3_PFD0] =3D imx_clk_hw_pfd("pll3_pfd0", "pll3_usb_otg",=
 base + 0xf0,  0);
+	hws[IMX6SL_CLK_PLL3_PFD1] =3D imx_clk_hw_pfd("pll3_pfd1", "pll3_usb_otg",=
 base + 0xf0,  1);
+	hws[IMX6SL_CLK_PLL3_PFD2] =3D imx_clk_hw_pfd("pll3_pfd2", "pll3_usb_otg",=
 base + 0xf0,  2);
+	hws[IMX6SL_CLK_PLL3_PFD3] =3D imx_clk_hw_pfd("pll3_pfd3", "pll3_usb_otg",=
 base + 0xf0,  3);
=20
 	/*                                                name         parent_nam=
e     mult div */
-	clks[IMX6SL_CLK_PLL2_198M] =3D imx_clk_fixed_factor("pll2_198m", "pll2_pf=
d2",      1, 2);
-	clks[IMX6SL_CLK_PLL3_120M] =3D imx_clk_fixed_factor("pll3_120m", "pll3_us=
b_otg",   1, 4);
-	clks[IMX6SL_CLK_PLL3_80M]  =3D imx_clk_fixed_factor("pll3_80m",  "pll3_us=
b_otg",   1, 6);
-	clks[IMX6SL_CLK_PLL3_60M]  =3D imx_clk_fixed_factor("pll3_60m",  "pll3_us=
b_otg",   1, 8);
+	hws[IMX6SL_CLK_PLL2_198M] =3D imx_clk_hw_fixed_factor("pll2_198m", "pll2_=
pfd2",      1, 2);
+	hws[IMX6SL_CLK_PLL3_120M] =3D imx_clk_hw_fixed_factor("pll3_120m", "pll3_=
usb_otg",   1, 4);
+	hws[IMX6SL_CLK_PLL3_80M]  =3D imx_clk_hw_fixed_factor("pll3_80m",  "pll3_=
usb_otg",   1, 6);
+	hws[IMX6SL_CLK_PLL3_60M]  =3D imx_clk_hw_fixed_factor("pll3_60m",  "pll3_=
usb_otg",   1, 8);
=20
 	np =3D ccm_node;
 	base =3D of_iomap(np, 0);
@@ -292,157 +302,161 @@ static void __init imx6sl_clocks_init(struct device=
_node *ccm_node)
 	ccm_base =3D base;
=20
 	/*                                              name                reg  =
     shift width parent_names     num_parents */
-	clks[IMX6SL_CLK_STEP]             =3D imx_clk_mux("step",             bas=
e + 0xc,  8,  1, step_sels,         ARRAY_SIZE(step_sels));
-	clks[IMX6SL_CLK_PLL1_SW]          =3D imx_clk_mux("pll1_sw",          bas=
e + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
-	clks[IMX6SL_CLK_OCRAM_ALT_SEL]    =3D imx_clk_mux("ocram_alt_sel",    bas=
e + 0x14, 7,  1, ocram_alt_sels,    ARRAY_SIZE(ocram_alt_sels));
-	clks[IMX6SL_CLK_OCRAM_SEL]        =3D imx_clk_mux("ocram_sel",        bas=
e + 0x14, 6,  1, ocram_sels,        ARRAY_SIZE(ocram_sels));
-	clks[IMX6SL_CLK_PRE_PERIPH2_SEL]  =3D imx_clk_mux("pre_periph2_sel",  bas=
e + 0x18, 21, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
-	clks[IMX6SL_CLK_PRE_PERIPH_SEL]   =3D imx_clk_mux("pre_periph_sel",   bas=
e + 0x18, 18, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
-	clks[IMX6SL_CLK_PERIPH2_CLK2_SEL] =3D imx_clk_mux("periph2_clk2_sel", bas=
e + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
-	clks[IMX6SL_CLK_PERIPH_CLK2_SEL]  =3D imx_clk_mux("periph_clk2_sel",  bas=
e + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
-	clks[IMX6SL_CLK_CSI_SEL]          =3D imx_clk_mux("csi_sel",          bas=
e + 0x3c, 9,  2, csi_sels,          ARRAY_SIZE(csi_sels));
-	clks[IMX6SL_CLK_LCDIF_AXI_SEL]    =3D imx_clk_mux("lcdif_axi_sel",    bas=
e + 0x3c, 14, 2, lcdif_axi_sels,    ARRAY_SIZE(lcdif_axi_sels));
-	clks[IMX6SL_CLK_USDHC1_SEL]       =3D imx_clk_fixup_mux("usdhc1_sel", bas=
e + 0x1c, 16, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fix=
up);
-	clks[IMX6SL_CLK_USDHC2_SEL]       =3D imx_clk_fixup_mux("usdhc2_sel", bas=
e + 0x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fix=
up);
-	clks[IMX6SL_CLK_USDHC3_SEL]       =3D imx_clk_fixup_mux("usdhc3_sel", bas=
e + 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fix=
up);
-	clks[IMX6SL_CLK_USDHC4_SEL]       =3D imx_clk_fixup_mux("usdhc4_sel", bas=
e + 0x1c, 19, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_fix=
up);
-	clks[IMX6SL_CLK_SSI1_SEL]         =3D imx_clk_fixup_mux("ssi1_sel",   bas=
e + 0x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),    imx_cscmr1_fix=
up);
-	clks[IMX6SL_CLK_SSI2_SEL]         =3D imx_clk_fixup_mux("ssi2_sel",   bas=
e + 0x1c, 12, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),    imx_cscmr1_fix=
up);
-	clks[IMX6SL_CLK_SSI3_SEL]         =3D imx_clk_fixup_mux("ssi3_sel",   bas=
e + 0x1c, 14, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),    imx_cscmr1_fix=
up);
-	clks[IMX6SL_CLK_PERCLK_SEL]       =3D imx_clk_fixup_mux("perclk_sel", bas=
e + 0x1c, 6,  1, perclk_sels,       ARRAY_SIZE(perclk_sels), imx_cscmr1_fix=
up);
-	clks[IMX6SL_CLK_PXP_AXI_SEL]      =3D imx_clk_mux("pxp_axi_sel",      bas=
e + 0x34, 6,  3, pxp_axi_sels,      ARRAY_SIZE(pxp_axi_sels));
-	clks[IMX6SL_CLK_EPDC_AXI_SEL]     =3D imx_clk_mux("epdc_axi_sel",     bas=
e + 0x34, 15, 3, epdc_axi_sels,     ARRAY_SIZE(epdc_axi_sels));
-	clks[IMX6SL_CLK_GPU2D_OVG_SEL]    =3D imx_clk_mux("gpu2d_ovg_sel",    bas=
e + 0x18, 4,  2, gpu2d_ovg_sels,    ARRAY_SIZE(gpu2d_ovg_sels));
-	clks[IMX6SL_CLK_GPU2D_SEL]        =3D imx_clk_mux("gpu2d_sel",        bas=
e + 0x18, 8,  2, gpu2d_sels,        ARRAY_SIZE(gpu2d_sels));
-	clks[IMX6SL_CLK_LCDIF_PIX_SEL]    =3D imx_clk_mux("lcdif_pix_sel",    bas=
e + 0x38, 6,  3, lcdif_pix_sels,    ARRAY_SIZE(lcdif_pix_sels));
-	clks[IMX6SL_CLK_EPDC_PIX_SEL]     =3D imx_clk_mux("epdc_pix_sel",     bas=
e + 0x38, 15, 3, epdc_pix_sels,     ARRAY_SIZE(epdc_pix_sels));
-	clks[IMX6SL_CLK_SPDIF0_SEL]       =3D imx_clk_mux("spdif0_sel",       bas=
e + 0x30, 20, 2, audio_sels,        ARRAY_SIZE(audio_sels));
-	clks[IMX6SL_CLK_SPDIF1_SEL]       =3D imx_clk_mux("spdif1_sel",       bas=
e + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
-	clks[IMX6SL_CLK_EXTERN_AUDIO_SEL] =3D imx_clk_mux("extern_audio_sel", bas=
e + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
-	clks[IMX6SL_CLK_ECSPI_SEL]        =3D imx_clk_mux("ecspi_sel",        bas=
e + 0x38, 18, 1, ecspi_sels,        ARRAY_SIZE(ecspi_sels));
-	clks[IMX6SL_CLK_UART_SEL]         =3D imx_clk_mux("uart_sel",         bas=
e + 0x24, 6,  1, uart_sels,         ARRAY_SIZE(uart_sels));
+	hws[IMX6SL_CLK_STEP]             =3D imx_clk_hw_mux("step",             b=
ase + 0xc,  8,  1, step_sels,         ARRAY_SIZE(step_sels));
+	hws[IMX6SL_CLK_PLL1_SW]          =3D imx_clk_hw_mux("pll1_sw",          b=
ase + 0xc,  2,  1, pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
+	hws[IMX6SL_CLK_OCRAM_ALT_SEL]    =3D imx_clk_hw_mux("ocram_alt_sel",    b=
ase + 0x14, 7,  1, ocram_alt_sels,    ARRAY_SIZE(ocram_alt_sels));
+	hws[IMX6SL_CLK_OCRAM_SEL]        =3D imx_clk_hw_mux("ocram_sel",        b=
ase + 0x14, 6,  1, ocram_sels,        ARRAY_SIZE(ocram_sels));
+	hws[IMX6SL_CLK_PRE_PERIPH2_SEL]  =3D imx_clk_hw_mux("pre_periph2_sel",  b=
ase + 0x18, 21, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
+	hws[IMX6SL_CLK_PRE_PERIPH_SEL]   =3D imx_clk_hw_mux("pre_periph_sel",   b=
ase + 0x18, 18, 2, pre_periph_sels,   ARRAY_SIZE(pre_periph_sels));
+	hws[IMX6SL_CLK_PERIPH2_CLK2_SEL] =3D imx_clk_hw_mux("periph2_clk2_sel", b=
ase + 0x18, 20, 1, periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
+	hws[IMX6SL_CLK_PERIPH_CLK2_SEL]  =3D imx_clk_hw_mux("periph_clk2_sel",  b=
ase + 0x18, 12, 2, periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
+	hws[IMX6SL_CLK_CSI_SEL]          =3D imx_clk_hw_mux("csi_sel",          b=
ase + 0x3c, 9,  2, csi_sels,          ARRAY_SIZE(csi_sels));
+	hws[IMX6SL_CLK_LCDIF_AXI_SEL]    =3D imx_clk_hw_mux("lcdif_axi_sel",    b=
ase + 0x3c, 14, 2, lcdif_axi_sels,    ARRAY_SIZE(lcdif_axi_sels));
+	hws[IMX6SL_CLK_USDHC1_SEL]       =3D imx_clk_hw_fixup_mux("usdhc1_sel", b=
ase + 0x1c, 16, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_f=
ixup);
+	hws[IMX6SL_CLK_USDHC2_SEL]       =3D imx_clk_hw_fixup_mux("usdhc2_sel", b=
ase + 0x1c, 17, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_f=
ixup);
+	hws[IMX6SL_CLK_USDHC3_SEL]       =3D imx_clk_hw_fixup_mux("usdhc3_sel", b=
ase + 0x1c, 18, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_f=
ixup);
+	hws[IMX6SL_CLK_USDHC4_SEL]       =3D imx_clk_hw_fixup_mux("usdhc4_sel", b=
ase + 0x1c, 19, 1, usdhc_sels,        ARRAY_SIZE(usdhc_sels),  imx_cscmr1_f=
ixup);
+	hws[IMX6SL_CLK_SSI1_SEL]         =3D imx_clk_hw_fixup_mux("ssi1_sel",   b=
ase + 0x1c, 10, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),    imx_cscmr1_f=
ixup);
+	hws[IMX6SL_CLK_SSI2_SEL]         =3D imx_clk_hw_fixup_mux("ssi2_sel",   b=
ase + 0x1c, 12, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),    imx_cscmr1_f=
ixup);
+	hws[IMX6SL_CLK_SSI3_SEL]         =3D imx_clk_hw_fixup_mux("ssi3_sel",   b=
ase + 0x1c, 14, 2, ssi_sels,          ARRAY_SIZE(ssi_sels),    imx_cscmr1_f=
ixup);
+	hws[IMX6SL_CLK_PERCLK_SEL]       =3D imx_clk_hw_fixup_mux("perclk_sel", b=
ase + 0x1c, 6,  1, perclk_sels,       ARRAY_SIZE(perclk_sels), imx_cscmr1_f=
ixup);
+	hws[IMX6SL_CLK_PXP_AXI_SEL]      =3D imx_clk_hw_mux("pxp_axi_sel",      b=
ase + 0x34, 6,  3, pxp_axi_sels,      ARRAY_SIZE(pxp_axi_sels));
+	hws[IMX6SL_CLK_EPDC_AXI_SEL]     =3D imx_clk_hw_mux("epdc_axi_sel",     b=
ase + 0x34, 15, 3, epdc_axi_sels,     ARRAY_SIZE(epdc_axi_sels));
+	hws[IMX6SL_CLK_GPU2D_OVG_SEL]    =3D imx_clk_hw_mux("gpu2d_ovg_sel",    b=
ase + 0x18, 4,  2, gpu2d_ovg_sels,    ARRAY_SIZE(gpu2d_ovg_sels));
+	hws[IMX6SL_CLK_GPU2D_SEL]        =3D imx_clk_hw_mux("gpu2d_sel",        b=
ase + 0x18, 8,  2, gpu2d_sels,        ARRAY_SIZE(gpu2d_sels));
+	hws[IMX6SL_CLK_LCDIF_PIX_SEL]    =3D imx_clk_hw_mux("lcdif_pix_sel",    b=
ase + 0x38, 6,  3, lcdif_pix_sels,    ARRAY_SIZE(lcdif_pix_sels));
+	hws[IMX6SL_CLK_EPDC_PIX_SEL]     =3D imx_clk_hw_mux("epdc_pix_sel",     b=
ase + 0x38, 15, 3, epdc_pix_sels,     ARRAY_SIZE(epdc_pix_sels));
+	hws[IMX6SL_CLK_SPDIF0_SEL]       =3D imx_clk_hw_mux("spdif0_sel",       b=
ase + 0x30, 20, 2, audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6SL_CLK_SPDIF1_SEL]       =3D imx_clk_hw_mux("spdif1_sel",       b=
ase + 0x30, 7,  2, audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6SL_CLK_EXTERN_AUDIO_SEL] =3D imx_clk_hw_mux("extern_audio_sel", b=
ase + 0x20, 19, 2, audio_sels,        ARRAY_SIZE(audio_sels));
+	hws[IMX6SL_CLK_ECSPI_SEL]        =3D imx_clk_hw_mux("ecspi_sel",        b=
ase + 0x38, 18, 1, ecspi_sels,        ARRAY_SIZE(ecspi_sels));
+	hws[IMX6SL_CLK_UART_SEL]         =3D imx_clk_hw_mux("uart_sel",         b=
ase + 0x24, 6,  1, uart_sels,         ARRAY_SIZE(uart_sels));
=20
 	/*                                          name       reg        shift w=
idth busy: reg, shift parent_names  num_parents */
-	clks[IMX6SL_CLK_PERIPH]  =3D imx_clk_busy_mux("periph",  base + 0x14, 25,=
  1,   base + 0x48, 5,  periph_sels,  ARRAY_SIZE(periph_sels));
-	clks[IMX6SL_CLK_PERIPH2] =3D imx_clk_busy_mux("periph2", base + 0x14, 26,=
  1,   base + 0x48, 3,  periph2_sels, ARRAY_SIZE(periph2_sels));
+	hws[IMX6SL_CLK_PERIPH]  =3D imx_clk_hw_busy_mux("periph",  base + 0x14, 2=
5,  1,   base + 0x48, 5,  periph_sels,  ARRAY_SIZE(periph_sels));
+	hws[IMX6SL_CLK_PERIPH2] =3D imx_clk_hw_busy_mux("periph2", base + 0x14, 2=
6,  1,   base + 0x48, 3,  periph2_sels, ARRAY_SIZE(periph2_sels));
=20
 	/*                                                   name                =
 parent_name          reg       shift width */
-	clks[IMX6SL_CLK_OCRAM_PODF]        =3D imx_clk_busy_divider("ocram_podf",=
   "ocram_sel",         base + 0x14, 16, 3, base + 0x48, 0);
-	clks[IMX6SL_CLK_PERIPH_CLK2_PODF]  =3D imx_clk_divider("periph_clk2_podf"=
,  "periph_clk2_sel",   base + 0x14, 27, 3);
-	clks[IMX6SL_CLK_PERIPH2_CLK2_PODF] =3D imx_clk_divider("periph2_clk2_podf=
", "periph2_clk2_sel",  base + 0x14, 0,  3);
-	clks[IMX6SL_CLK_IPG]               =3D imx_clk_divider("ipg",            =
   "ahb",               base + 0x14, 8,  2);
-	clks[IMX6SL_CLK_CSI_PODF]          =3D imx_clk_divider("csi_podf",       =
   "csi_sel",           base + 0x3c, 11, 3);
-	clks[IMX6SL_CLK_LCDIF_AXI_PODF]    =3D imx_clk_divider("lcdif_axi_podf", =
   "lcdif_axi_sel",     base + 0x3c, 16, 3);
-	clks[IMX6SL_CLK_USDHC1_PODF]       =3D imx_clk_divider("usdhc1_podf",    =
   "usdhc1_sel",        base + 0x24, 11, 3);
-	clks[IMX6SL_CLK_USDHC2_PODF]       =3D imx_clk_divider("usdhc2_podf",    =
   "usdhc2_sel",        base + 0x24, 16, 3);
-	clks[IMX6SL_CLK_USDHC3_PODF]       =3D imx_clk_divider("usdhc3_podf",    =
   "usdhc3_sel",        base + 0x24, 19, 3);
-	clks[IMX6SL_CLK_USDHC4_PODF]       =3D imx_clk_divider("usdhc4_podf",    =
   "usdhc4_sel",        base + 0x24, 22, 3);
-	clks[IMX6SL_CLK_SSI1_PRED]         =3D imx_clk_divider("ssi1_pred",      =
   "ssi1_sel",          base + 0x28, 6,  3);
-	clks[IMX6SL_CLK_SSI1_PODF]         =3D imx_clk_divider("ssi1_podf",      =
   "ssi1_pred",         base + 0x28, 0,  6);
-	clks[IMX6SL_CLK_SSI2_PRED]         =3D imx_clk_divider("ssi2_pred",      =
   "ssi2_sel",          base + 0x2c, 6,  3);
-	clks[IMX6SL_CLK_SSI2_PODF]         =3D imx_clk_divider("ssi2_podf",      =
   "ssi2_pred",         base + 0x2c, 0,  6);
-	clks[IMX6SL_CLK_SSI3_PRED]         =3D imx_clk_divider("ssi3_pred",      =
   "ssi3_sel",          base + 0x28, 22, 3);
-	clks[IMX6SL_CLK_SSI3_PODF]         =3D imx_clk_divider("ssi3_podf",      =
   "ssi3_pred",         base + 0x28, 16, 6);
-	clks[IMX6SL_CLK_PERCLK]            =3D imx_clk_fixup_divider("perclk",   =
   "perclk_sel",        base + 0x1c, 0,  6, imx_cscmr1_fixup);
-	clks[IMX6SL_CLK_PXP_AXI_PODF]      =3D imx_clk_divider("pxp_axi_podf",   =
   "pxp_axi_sel",       base + 0x34, 3,  3);
-	clks[IMX6SL_CLK_EPDC_AXI_PODF]     =3D imx_clk_divider("epdc_axi_podf",  =
   "epdc_axi_sel",      base + 0x34, 12, 3);
-	clks[IMX6SL_CLK_GPU2D_OVG_PODF]    =3D imx_clk_divider("gpu2d_ovg_podf", =
   "gpu2d_ovg_sel",     base + 0x18, 26, 3);
-	clks[IMX6SL_CLK_GPU2D_PODF]        =3D imx_clk_divider("gpu2d_podf",     =
   "gpu2d_sel",         base + 0x18, 29, 3);
-	clks[IMX6SL_CLK_LCDIF_PIX_PRED]    =3D imx_clk_divider("lcdif_pix_pred", =
   "lcdif_pix_sel",     base + 0x38, 3,  3);
-	clks[IMX6SL_CLK_EPDC_PIX_PRED]     =3D imx_clk_divider("epdc_pix_pred",  =
   "epdc_pix_sel",      base + 0x38, 12, 3);
-	clks[IMX6SL_CLK_LCDIF_PIX_PODF]    =3D imx_clk_fixup_divider("lcdif_pix_p=
odf", "lcdif_pix_pred", base + 0x1c, 20, 3, imx_cscmr1_fixup);
-	clks[IMX6SL_CLK_EPDC_PIX_PODF]     =3D imx_clk_divider("epdc_pix_podf",  =
   "epdc_pix_pred",     base + 0x18, 23, 3);
-	clks[IMX6SL_CLK_SPDIF0_PRED]       =3D imx_clk_divider("spdif0_pred",    =
   "spdif0_sel",        base + 0x30, 25, 3);
-	clks[IMX6SL_CLK_SPDIF0_PODF]       =3D imx_clk_divider("spdif0_podf",    =
   "spdif0_pred",       base + 0x30, 22, 3);
-	clks[IMX6SL_CLK_SPDIF1_PRED]       =3D imx_clk_divider("spdif1_pred",    =
   "spdif1_sel",        base + 0x30, 12, 3);
-	clks[IMX6SL_CLK_SPDIF1_PODF]       =3D imx_clk_divider("spdif1_podf",    =
   "spdif1_pred",       base + 0x30, 9,  3);
-	clks[IMX6SL_CLK_EXTERN_AUDIO_PRED] =3D imx_clk_divider("extern_audio_pred=
", "extern_audio_sel",  base + 0x28, 9,  3);
-	clks[IMX6SL_CLK_EXTERN_AUDIO_PODF] =3D imx_clk_divider("extern_audio_podf=
", "extern_audio_pred", base + 0x28, 25, 3);
-	clks[IMX6SL_CLK_ECSPI_ROOT]        =3D imx_clk_divider("ecspi_root",     =
   "ecspi_sel",         base + 0x38, 19, 6);
-	clks[IMX6SL_CLK_UART_ROOT]         =3D imx_clk_divider("uart_root",      =
   "uart_sel",          base + 0x24, 0,  6);
+	hws[IMX6SL_CLK_OCRAM_PODF]        =3D imx_clk_hw_busy_divider("ocram_podf=
",   "ocram_sel",         base + 0x14, 16, 3, base + 0x48, 0);
+	hws[IMX6SL_CLK_PERIPH_CLK2_PODF]  =3D imx_clk_hw_divider("periph_clk2_pod=
f",  "periph_clk2_sel",   base + 0x14, 27, 3);
+	hws[IMX6SL_CLK_PERIPH2_CLK2_PODF] =3D imx_clk_hw_divider("periph2_clk2_po=
df", "periph2_clk2_sel",  base + 0x14, 0,  3);
+	hws[IMX6SL_CLK_IPG]               =3D imx_clk_hw_divider("ipg",          =
     "ahb",               base + 0x14, 8,  2);
+	hws[IMX6SL_CLK_CSI_PODF]          =3D imx_clk_hw_divider("csi_podf",     =
     "csi_sel",           base + 0x3c, 11, 3);
+	hws[IMX6SL_CLK_LCDIF_AXI_PODF]    =3D imx_clk_hw_divider("lcdif_axi_podf"=
,    "lcdif_axi_sel",     base + 0x3c, 16, 3);
+	hws[IMX6SL_CLK_USDHC1_PODF]       =3D imx_clk_hw_divider("usdhc1_podf",  =
     "usdhc1_sel",        base + 0x24, 11, 3);
+	hws[IMX6SL_CLK_USDHC2_PODF]       =3D imx_clk_hw_divider("usdhc2_podf",  =
     "usdhc2_sel",        base + 0x24, 16, 3);
+	hws[IMX6SL_CLK_USDHC3_PODF]       =3D imx_clk_hw_divider("usdhc3_podf",  =
     "usdhc3_sel",        base + 0x24, 19, 3);
+	hws[IMX6SL_CLK_USDHC4_PODF]       =3D imx_clk_hw_divider("usdhc4_podf",  =
     "usdhc4_sel",        base + 0x24, 22, 3);
+	hws[IMX6SL_CLK_SSI1_PRED]         =3D imx_clk_hw_divider("ssi1_pred",    =
     "ssi1_sel",          base + 0x28, 6,  3);
+	hws[IMX6SL_CLK_SSI1_PODF]         =3D imx_clk_hw_divider("ssi1_podf",    =
     "ssi1_pred",         base + 0x28, 0,  6);
+	hws[IMX6SL_CLK_SSI2_PRED]         =3D imx_clk_hw_divider("ssi2_pred",    =
     "ssi2_sel",          base + 0x2c, 6,  3);
+	hws[IMX6SL_CLK_SSI2_PODF]         =3D imx_clk_hw_divider("ssi2_podf",    =
     "ssi2_pred",         base + 0x2c, 0,  6);
+	hws[IMX6SL_CLK_SSI3_PRED]         =3D imx_clk_hw_divider("ssi3_pred",    =
     "ssi3_sel",          base + 0x28, 22, 3);
+	hws[IMX6SL_CLK_SSI3_PODF]         =3D imx_clk_hw_divider("ssi3_podf",    =
     "ssi3_pred",         base + 0x28, 16, 6);
+	hws[IMX6SL_CLK_PERCLK]            =3D imx_clk_hw_fixup_divider("perclk", =
     "perclk_sel",        base + 0x1c, 0,  6, imx_cscmr1_fixup);
+	hws[IMX6SL_CLK_PXP_AXI_PODF]      =3D imx_clk_hw_divider("pxp_axi_podf", =
     "pxp_axi_sel",       base + 0x34, 3,  3);
+	hws[IMX6SL_CLK_EPDC_AXI_PODF]     =3D imx_clk_hw_divider("epdc_axi_podf",=
     "epdc_axi_sel",      base + 0x34, 12, 3);
+	hws[IMX6SL_CLK_GPU2D_OVG_PODF]    =3D imx_clk_hw_divider("gpu2d_ovg_podf"=
,    "gpu2d_ovg_sel",     base + 0x18, 26, 3);
+	hws[IMX6SL_CLK_GPU2D_PODF]        =3D imx_clk_hw_divider("gpu2d_podf",   =
     "gpu2d_sel",         base + 0x18, 29, 3);
+	hws[IMX6SL_CLK_LCDIF_PIX_PRED]    =3D imx_clk_hw_divider("lcdif_pix_pred"=
,    "lcdif_pix_sel",     base + 0x38, 3,  3);
+	hws[IMX6SL_CLK_EPDC_PIX_PRED]     =3D imx_clk_hw_divider("epdc_pix_pred",=
     "epdc_pix_sel",      base + 0x38, 12, 3);
+	hws[IMX6SL_CLK_LCDIF_PIX_PODF]    =3D imx_clk_hw_fixup_divider("lcdif_pix=
_podf", "lcdif_pix_pred", base + 0x1c, 20, 3, imx_cscmr1_fixup);
+	hws[IMX6SL_CLK_EPDC_PIX_PODF]     =3D imx_clk_hw_divider("epdc_pix_podf",=
     "epdc_pix_pred",     base + 0x18, 23, 3);
+	hws[IMX6SL_CLK_SPDIF0_PRED]       =3D imx_clk_hw_divider("spdif0_pred",  =
     "spdif0_sel",        base + 0x30, 25, 3);
+	hws[IMX6SL_CLK_SPDIF0_PODF]       =3D imx_clk_hw_divider("spdif0_podf",  =
     "spdif0_pred",       base + 0x30, 22, 3);
+	hws[IMX6SL_CLK_SPDIF1_PRED]       =3D imx_clk_hw_divider("spdif1_pred",  =
     "spdif1_sel",        base + 0x30, 12, 3);
+	hws[IMX6SL_CLK_SPDIF1_PODF]       =3D imx_clk_hw_divider("spdif1_podf",  =
     "spdif1_pred",       base + 0x30, 9,  3);
+	hws[IMX6SL_CLK_EXTERN_AUDIO_PRED] =3D imx_clk_hw_divider("extern_audio_pr=
ed", "extern_audio_sel",  base + 0x28, 9,  3);
+	hws[IMX6SL_CLK_EXTERN_AUDIO_PODF] =3D imx_clk_hw_divider("extern_audio_po=
df", "extern_audio_pred", base + 0x28, 25, 3);
+	hws[IMX6SL_CLK_ECSPI_ROOT]        =3D imx_clk_hw_divider("ecspi_root",   =
     "ecspi_sel",         base + 0x38, 19, 6);
+	hws[IMX6SL_CLK_UART_ROOT]         =3D imx_clk_hw_divider("uart_root",    =
     "uart_sel",          base + 0x24, 0,  6);
=20
 	/*                                                name         parent_nam=
e reg       shift width busy: reg, shift */
-	clks[IMX6SL_CLK_AHB]       =3D imx_clk_busy_divider("ahb",       "periph"=
,  base + 0x14, 10, 3,    base + 0x48, 1);
-	clks[IMX6SL_CLK_MMDC_ROOT] =3D imx_clk_busy_divider("mmdc",      "periph2=
", base + 0x14, 3,  3,    base + 0x48, 2);
-	clks[IMX6SL_CLK_ARM]       =3D imx_clk_busy_divider("arm",       "pll1_sw=
", base + 0x10, 0,  3,    base + 0x48, 16);
+	hws[IMX6SL_CLK_AHB]       =3D imx_clk_hw_busy_divider("ahb",       "perip=
h",  base + 0x14, 10, 3,    base + 0x48, 1);
+	hws[IMX6SL_CLK_MMDC_ROOT] =3D imx_clk_hw_busy_divider("mmdc",      "perip=
h2", base + 0x14, 3,  3,    base + 0x48, 2);
+	hws[IMX6SL_CLK_ARM]       =3D imx_clk_hw_busy_divider("arm",       "pll1_=
sw", base + 0x10, 0,  3,    base + 0x48, 16);
=20
 	/*                                            name            parent_name=
          reg         shift */
-	clks[IMX6SL_CLK_ECSPI1]       =3D imx_clk_gate2("ecspi1",       "ecspi_ro=
ot",        base + 0x6c, 0);
-	clks[IMX6SL_CLK_ECSPI2]       =3D imx_clk_gate2("ecspi2",       "ecspi_ro=
ot",        base + 0x6c, 2);
-	clks[IMX6SL_CLK_ECSPI3]       =3D imx_clk_gate2("ecspi3",       "ecspi_ro=
ot",        base + 0x6c, 4);
-	clks[IMX6SL_CLK_ECSPI4]       =3D imx_clk_gate2("ecspi4",       "ecspi_ro=
ot",        base + 0x6c, 6);
-	clks[IMX6SL_CLK_ENET]         =3D imx_clk_gate2("enet",         "ipg",   =
            base + 0x6c, 10);
-	clks[IMX6SL_CLK_EPIT1]        =3D imx_clk_gate2("epit1",        "perclk",=
            base + 0x6c, 12);
-	clks[IMX6SL_CLK_EPIT2]        =3D imx_clk_gate2("epit2",        "perclk",=
            base + 0x6c, 14);
-	clks[IMX6SL_CLK_EXTERN_AUDIO] =3D imx_clk_gate2("extern_audio", "extern_a=
udio_podf", base + 0x6c, 16);
-	clks[IMX6SL_CLK_GPT]          =3D imx_clk_gate2("gpt",          "perclk",=
            base + 0x6c, 20);
-	clks[IMX6SL_CLK_GPT_SERIAL]   =3D imx_clk_gate2("gpt_serial",   "perclk",=
            base + 0x6c, 22);
-	clks[IMX6SL_CLK_GPU2D_OVG]    =3D imx_clk_gate2("gpu2d_ovg",    "gpu2d_ov=
g_podf",    base + 0x6c, 26);
-	clks[IMX6SL_CLK_I2C1]         =3D imx_clk_gate2("i2c1",         "perclk",=
            base + 0x70, 6);
-	clks[IMX6SL_CLK_I2C2]         =3D imx_clk_gate2("i2c2",         "perclk",=
            base + 0x70, 8);
-	clks[IMX6SL_CLK_I2C3]         =3D imx_clk_gate2("i2c3",         "perclk",=
            base + 0x70, 10);
-	clks[IMX6SL_CLK_OCOTP]        =3D imx_clk_gate2("ocotp",        "ipg",   =
            base + 0x70, 12);
-	clks[IMX6SL_CLK_CSI]          =3D imx_clk_gate2("csi",          "csi_podf=
",          base + 0x74, 0);
-	clks[IMX6SL_CLK_PXP_AXI]      =3D imx_clk_gate2("pxp_axi",      "pxp_axi_=
podf",      base + 0x74, 2);
-	clks[IMX6SL_CLK_EPDC_AXI]     =3D imx_clk_gate2("epdc_axi",     "epdc_axi=
_podf",     base + 0x74, 4);
-	clks[IMX6SL_CLK_LCDIF_AXI]    =3D imx_clk_gate2("lcdif_axi",    "lcdif_ax=
i_podf",    base + 0x74, 6);
-	clks[IMX6SL_CLK_LCDIF_PIX]    =3D imx_clk_gate2("lcdif_pix",    "lcdif_pi=
x_podf",    base + 0x74, 8);
-	clks[IMX6SL_CLK_EPDC_PIX]     =3D imx_clk_gate2("epdc_pix",     "epdc_pix=
_podf",     base + 0x74, 10);
-	clks[IMX6SL_CLK_MMDC_P0_IPG]  =3D imx_clk_gate2_flags("mmdc_p0_ipg",  "ip=
g",         base + 0x74,	24, CLK_IS_CRITICAL);
-	clks[IMX6SL_CLK_MMDC_P1_IPG]  =3D imx_clk_gate2("mmdc_p1_ipg",  "ipg",	  =
	   base + 0x74,	26);
-	clks[IMX6SL_CLK_OCRAM]        =3D imx_clk_gate2("ocram",        "ocram_po=
df",        base + 0x74, 28);
-	clks[IMX6SL_CLK_PWM1]         =3D imx_clk_gate2("pwm1",         "perclk",=
            base + 0x78, 16);
-	clks[IMX6SL_CLK_PWM2]         =3D imx_clk_gate2("pwm2",         "perclk",=
            base + 0x78, 18);
-	clks[IMX6SL_CLK_PWM3]         =3D imx_clk_gate2("pwm3",         "perclk",=
            base + 0x78, 20);
-	clks[IMX6SL_CLK_PWM4]         =3D imx_clk_gate2("pwm4",         "perclk",=
            base + 0x78, 22);
-	clks[IMX6SL_CLK_SDMA]         =3D imx_clk_gate2("sdma",         "ipg",   =
            base + 0x7c, 6);
-	clks[IMX6SL_CLK_SPBA]         =3D imx_clk_gate2("spba",         "ipg",   =
            base + 0x7c, 12);
-	clks[IMX6SL_CLK_SPDIF]        =3D imx_clk_gate2_shared("spdif",     "spdi=
f0_podf",   base + 0x7c, 14, &share_count_spdif);
-	clks[IMX6SL_CLK_SPDIF_GCLK]   =3D imx_clk_gate2_shared("spdif_gclk",  "ip=
g",         base + 0x7c, 14, &share_count_spdif);
-	clks[IMX6SL_CLK_SSI1_IPG]     =3D imx_clk_gate2_shared("ssi1_ipg",     "i=
pg",        base + 0x7c, 18, &share_count_ssi1);
-	clks[IMX6SL_CLK_SSI2_IPG]     =3D imx_clk_gate2_shared("ssi2_ipg",     "i=
pg",        base + 0x7c, 20, &share_count_ssi2);
-	clks[IMX6SL_CLK_SSI3_IPG]     =3D imx_clk_gate2_shared("ssi3_ipg",     "i=
pg",        base + 0x7c, 22, &share_count_ssi3);
-	clks[IMX6SL_CLK_SSI1]         =3D imx_clk_gate2_shared("ssi1",         "s=
si1_podf",  base + 0x7c, 18, &share_count_ssi1);
-	clks[IMX6SL_CLK_SSI2]         =3D imx_clk_gate2_shared("ssi2",         "s=
si2_podf",  base + 0x7c, 20, &share_count_ssi2);
-	clks[IMX6SL_CLK_SSI3]         =3D imx_clk_gate2_shared("ssi3",         "s=
si3_podf",  base + 0x7c, 22, &share_count_ssi3);
-	clks[IMX6SL_CLK_UART]         =3D imx_clk_gate2("uart",         "ipg",   =
            base + 0x7c, 24);
-	clks[IMX6SL_CLK_UART_SERIAL]  =3D imx_clk_gate2("uart_serial",  "uart_roo=
t",         base + 0x7c, 26);
-	clks[IMX6SL_CLK_USBOH3]       =3D imx_clk_gate2("usboh3",       "ipg",   =
            base + 0x80, 0);
-	clks[IMX6SL_CLK_USDHC1]       =3D imx_clk_gate2("usdhc1",       "usdhc1_p=
odf",       base + 0x80, 2);
-	clks[IMX6SL_CLK_USDHC2]       =3D imx_clk_gate2("usdhc2",       "usdhc2_p=
odf",       base + 0x80, 4);
-	clks[IMX6SL_CLK_USDHC3]       =3D imx_clk_gate2("usdhc3",       "usdhc3_p=
odf",       base + 0x80, 6);
-	clks[IMX6SL_CLK_USDHC4]       =3D imx_clk_gate2("usdhc4",       "usdhc4_p=
odf",       base + 0x80, 8);
+	hws[IMX6SL_CLK_ECSPI1]       =3D imx_clk_hw_gate2("ecspi1",       "ecspi_=
root",        base + 0x6c, 0);
+	hws[IMX6SL_CLK_ECSPI2]       =3D imx_clk_hw_gate2("ecspi2",       "ecspi_=
root",        base + 0x6c, 2);
+	hws[IMX6SL_CLK_ECSPI3]       =3D imx_clk_hw_gate2("ecspi3",       "ecspi_=
root",        base + 0x6c, 4);
+	hws[IMX6SL_CLK_ECSPI4]       =3D imx_clk_hw_gate2("ecspi4",       "ecspi_=
root",        base + 0x6c, 6);
+	hws[IMX6SL_CLK_ENET]         =3D imx_clk_hw_gate2("enet",         "ipg", =
              base + 0x6c, 10);
+	hws[IMX6SL_CLK_EPIT1]        =3D imx_clk_hw_gate2("epit1",        "perclk=
",            base + 0x6c, 12);
+	hws[IMX6SL_CLK_EPIT2]        =3D imx_clk_hw_gate2("epit2",        "perclk=
",            base + 0x6c, 14);
+	hws[IMX6SL_CLK_EXTERN_AUDIO] =3D imx_clk_hw_gate2("extern_audio", "extern=
_audio_podf", base + 0x6c, 16);
+	hws[IMX6SL_CLK_GPT]          =3D imx_clk_hw_gate2("gpt",          "perclk=
",            base + 0x6c, 20);
+	hws[IMX6SL_CLK_GPT_SERIAL]   =3D imx_clk_hw_gate2("gpt_serial",   "perclk=
",            base + 0x6c, 22);
+	hws[IMX6SL_CLK_GPU2D_OVG]    =3D imx_clk_hw_gate2("gpu2d_ovg",    "gpu2d_=
ovg_podf",    base + 0x6c, 26);
+	hws[IMX6SL_CLK_I2C1]         =3D imx_clk_hw_gate2("i2c1",         "perclk=
",            base + 0x70, 6);
+	hws[IMX6SL_CLK_I2C2]         =3D imx_clk_hw_gate2("i2c2",         "perclk=
",            base + 0x70, 8);
+	hws[IMX6SL_CLK_I2C3]         =3D imx_clk_hw_gate2("i2c3",         "perclk=
",            base + 0x70, 10);
+	hws[IMX6SL_CLK_OCOTP]        =3D imx_clk_hw_gate2("ocotp",        "ipg", =
              base + 0x70, 12);
+	hws[IMX6SL_CLK_CSI]          =3D imx_clk_hw_gate2("csi",          "csi_po=
df",          base + 0x74, 0);
+	hws[IMX6SL_CLK_PXP_AXI]      =3D imx_clk_hw_gate2("pxp_axi",      "pxp_ax=
i_podf",      base + 0x74, 2);
+	hws[IMX6SL_CLK_EPDC_AXI]     =3D imx_clk_hw_gate2("epdc_axi",     "epdc_a=
xi_podf",     base + 0x74, 4);
+	hws[IMX6SL_CLK_LCDIF_AXI]    =3D imx_clk_hw_gate2("lcdif_axi",    "lcdif_=
axi_podf",    base + 0x74, 6);
+	hws[IMX6SL_CLK_LCDIF_PIX]    =3D imx_clk_hw_gate2("lcdif_pix",    "lcdif_=
pix_podf",    base + 0x74, 8);
+	hws[IMX6SL_CLK_EPDC_PIX]     =3D imx_clk_hw_gate2("epdc_pix",     "epdc_p=
ix_podf",     base + 0x74, 10);
+	hws[IMX6SL_CLK_MMDC_P0_IPG]  =3D imx_clk_hw_gate2_flags("mmdc_p0_ipg",  "=
ipg",         base + 0x74, 24, CLK_IS_CRITICAL);
+	hws[IMX6SL_CLK_MMDC_P1_IPG]  =3D imx_clk_hw_gate2("mmdc_p1_ipg",  "ipg", =
              base + 0x74, 26);
+	hws[IMX6SL_CLK_OCRAM]        =3D imx_clk_hw_gate2("ocram",        "ocram_=
podf",        base + 0x74, 28);
+	hws[IMX6SL_CLK_PWM1]         =3D imx_clk_hw_gate2("pwm1",         "perclk=
",            base + 0x78, 16);
+	hws[IMX6SL_CLK_PWM2]         =3D imx_clk_hw_gate2("pwm2",         "perclk=
",            base + 0x78, 18);
+	hws[IMX6SL_CLK_PWM3]         =3D imx_clk_hw_gate2("pwm3",         "perclk=
",            base + 0x78, 20);
+	hws[IMX6SL_CLK_PWM4]         =3D imx_clk_hw_gate2("pwm4",         "perclk=
",            base + 0x78, 22);
+	hws[IMX6SL_CLK_SDMA]         =3D imx_clk_hw_gate2("sdma",         "ipg", =
              base + 0x7c, 6);
+	hws[IMX6SL_CLK_SPBA]         =3D imx_clk_hw_gate2("spba",         "ipg", =
              base + 0x7c, 12);
+	hws[IMX6SL_CLK_SPDIF]        =3D imx_clk_hw_gate2_shared("spdif",     "sp=
dif0_podf",   base + 0x7c, 14, &share_count_spdif);
+	hws[IMX6SL_CLK_SPDIF_GCLK]   =3D imx_clk_hw_gate2_shared("spdif_gclk",  "=
ipg",         base + 0x7c, 14, &share_count_spdif);
+	hws[IMX6SL_CLK_SSI1_IPG]     =3D imx_clk_hw_gate2_shared("ssi1_ipg",     =
"ipg",        base + 0x7c, 18, &share_count_ssi1);
+	hws[IMX6SL_CLK_SSI2_IPG]     =3D imx_clk_hw_gate2_shared("ssi2_ipg",     =
"ipg",        base + 0x7c, 20, &share_count_ssi2);
+	hws[IMX6SL_CLK_SSI3_IPG]     =3D imx_clk_hw_gate2_shared("ssi3_ipg",     =
"ipg",        base + 0x7c, 22, &share_count_ssi3);
+	hws[IMX6SL_CLK_SSI1]         =3D imx_clk_hw_gate2_shared("ssi1",         =
"ssi1_podf",  base + 0x7c, 18, &share_count_ssi1);
+	hws[IMX6SL_CLK_SSI2]         =3D imx_clk_hw_gate2_shared("ssi2",         =
"ssi2_podf",  base + 0x7c, 20, &share_count_ssi2);
+	hws[IMX6SL_CLK_SSI3]         =3D imx_clk_hw_gate2_shared("ssi3",         =
"ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
+	hws[IMX6SL_CLK_UART]         =3D imx_clk_hw_gate2("uart",         "ipg", =
              base + 0x7c, 24);
+	hws[IMX6SL_CLK_UART_SERIAL]  =3D imx_clk_hw_gate2("uart_serial",  "uart_r=
oot",         base + 0x7c, 26);
+	hws[IMX6SL_CLK_USBOH3]       =3D imx_clk_hw_gate2("usboh3",       "ipg", =
              base + 0x80, 0);
+	hws[IMX6SL_CLK_USDHC1]       =3D imx_clk_hw_gate2("usdhc1",       "usdhc1=
_podf",       base + 0x80, 2);
+	hws[IMX6SL_CLK_USDHC2]       =3D imx_clk_hw_gate2("usdhc2",       "usdhc2=
_podf",       base + 0x80, 4);
+	hws[IMX6SL_CLK_USDHC3]       =3D imx_clk_hw_gate2("usdhc3",       "usdhc3=
_podf",       base + 0x80, 6);
+	hws[IMX6SL_CLK_USDHC4]       =3D imx_clk_hw_gate2("usdhc4",       "usdhc4=
_podf",       base + 0x80, 8);
=20
 	/* Ensure the MMDC CH0 handshake is bypassed */
 	writel_relaxed(readl_relaxed(base + CCDR) |
 		BM_CCM_CCDR_MMDC_CH0_MASK, base + CCDR);
=20
-	imx_check_clocks(clks, ARRAY_SIZE(clks));
+	imx_check_clk_hws(hws, IMX6SL_CLK_END);
=20
-	clk_data.clks =3D clks;
-	clk_data.clk_num =3D ARRAY_SIZE(clks);
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
=20
 	/* Ensure the AHB clk is at 132MHz. */
-	ret =3D clk_set_rate(clks[IMX6SL_CLK_AHB], 132000000);
+	ret =3D clk_set_rate(hws[IMX6SL_CLK_AHB]->clk, 132000000);
 	if (ret)
 		pr_warn("%s: failed to set AHB clock rate %d!\n",
 			__func__, ret);
=20
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
-		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY1_GATE]);
-		clk_prepare_enable(clks[IMX6SL_CLK_USBPHY2_GATE]);
+		clk_prepare_enable(hws[IMX6SL_CLK_USBPHY1_GATE]->clk);
+		clk_prepare_enable(hws[IMX6SL_CLK_USBPHY2_GATE]->clk);
 	}
=20
 	/* Audio-related clocks configuration */
-	clk_set_parent(clks[IMX6SL_CLK_SPDIF0_SEL], clks[IMX6SL_CLK_PLL3_PFD3]);
+	clk_set_parent(hws[IMX6SL_CLK_SPDIF0_SEL]->clk, hws[IMX6SL_CLK_PLL3_PFD3]=
->clk);
=20
 	/* set PLL5 video as lcdif pix parent clock */
-	clk_set_parent(clks[IMX6SL_CLK_LCDIF_PIX_SEL],
-			clks[IMX6SL_CLK_PLL5_VIDEO_DIV]);
+	clk_set_parent(hws[IMX6SL_CLK_LCDIF_PIX_SEL]->clk,
+			hws[IMX6SL_CLK_PLL5_VIDEO_DIV]->clk);
=20
-	clk_set_parent(clks[IMX6SL_CLK_LCDIF_AXI_SEL],
-		       clks[IMX6SL_CLK_PLL2_PFD2]);
+	clk_set_parent(hws[IMX6SL_CLK_LCDIF_AXI_SEL]->clk,
+		       hws[IMX6SL_CLK_PLL2_PFD2]->clk);
+
+	for (i =3D 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
+		int index =3D uart_clk_ids[i];
+
+		uart_clks[i] =3D &hws[index]->clk;
+	}
=20
 	imx_register_uart_clocks(uart_clks);
 }
--=20
2.7.4

