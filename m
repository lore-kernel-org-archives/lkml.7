Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BC4C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C624653
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RE3GWBYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfLLC7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:59:45 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:2682
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727879AbfLLC7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:59:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNyWguSWJwICkC0bN68d+OAA8IRtG7x3dAFqUtQ8AifatsjMkPakHGxX8SofFZ1GXjJoapysOqsiA3dYiacnAEulvQOyRXTjk7CvvdgRXc8pd4xFlLA+lZoJvZKbVWEG336AxzdwQshPkA33I8WcodmNiBKzUfO9YIPg6Nn4u+4DOTGHsQMjSiKwONWMuanvZUAZrh9XMJW7k5irvuIjw4d3Vn+HB0LLbKizIbrRgayn1B5Bt+V7JAm1Uwv7i1ybQgAqCq2sgWGaBY/J/PGo7NuHyBFdv9isklwsN0SsJp9RaMomJ2DzdSprPZxM7TTarIU8ibbSojUhG+tj9yTyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8iBqxcfML0xNGrErksqfNGaEQ4b+KjPCHLs5gbQmuo=;
 b=QiE6Yc3tEwN347Eof3jgf0fkuXRhxklDd0ci0moDP/WPFH9wbfez5TmrlZS5xAJoMjsuoxTkgN7u41PfKxF6VFtsCWAJCGnNweYyJbmwzShm5LFgiCA9+e0ufLerE26pblm03Jk6tlz/HnufqrXbnHYXW9ItQuigYpvPUGh5uYlTpwiNxRAHsI4b/R6AtENr57Hc7mp2aL1cwEO616WwolsCKUGz+Qpb0lEOplaCLenUUJ4Henjq4Y+DDnWU1vAO3kwCkYUFVMUwotHhlVI6z3ckMGfilljijqFcJhsHDN4zXAH6gUlTwjyjpdRChhTPLBEVayG/EiwC+pVmxh/nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8iBqxcfML0xNGrErksqfNGaEQ4b+KjPCHLs5gbQmuo=;
 b=RE3GWBYk0nlldN6jPw+HyMzWwNuPa8HfHIdwATsrF7ATYB+lb7s44e2iAJofUe0ToInG/4Zv02i75mIvpsPJOr/mg1GHwcIQoy8x8+0cjqQUACMdZhnA+LXqqCExDm3NQNRysTYwU+oY9GAbOMKvVQEfFVpA/OikI+cT0e2llkc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6196.eurprd04.prod.outlook.com (20.179.34.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 02:59:18 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 02:59:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 7/9] clk: imx: imx8mn: Switch to clk_hw based API
Thread-Topic: [PATCH V2 7/9] clk: imx: imx8mn: Switch to clk_hw based API
Thread-Index: AQHVsJgkun/od2vV30mWtyAzNY2Vnw==
Date:   Thu, 12 Dec 2019 02:59:17 +0000
Message-ID: <1576119353-26679-8-git-send-email-peng.fan@nxp.com>
References: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54596e36-6622-49a7-7043-08d77eaf4675
x-ms-traffictypediagnostic: AM0PR04MB6196:|AM0PR04MB6196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB619662DF59FEFAD8EE6C1B8488550@AM0PR04MB6196.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(81156014)(8936002)(30864003)(316002)(81166006)(8676002)(36756003)(52116002)(478600001)(6512007)(6486002)(71200400001)(110136005)(54906003)(86362001)(186003)(66476007)(4326008)(5660300002)(2906002)(66446008)(64756008)(44832011)(26005)(6636002)(66946007)(6506007)(2616005)(66556008)(32563001)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6196;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /oPg4Cvu3EEOAEiuLi7cAwG4MlOkX8PRNCJYRRgs9vJzuMyUsYX6XiU4So53jaoFrQ2kkx/ABXILlUx7ef6Ph66tZKBBipLUsLngs8Wjz7KCqqQxUbkYUKxwBsFLu98okb1PvmgXs2M7uM9kzTiQfaTXxHmbbDsqqIOEe/1ZwWGcouCgITtvAgmAWUEulZuruLaWs5XoG5YlPaO8/ONbAdyUBEw8dRx+WuizDAViAekwjZ3SybH3pBynf0d6sypi7+Jks3pZpgH/R241DTfBWyPKs4mj+lMOP991R5XxLKppRGzRZAMxAdLTKWvNIQF5e7gTv4J9mthOlaB6DFgmgcM9S+8I/vu+OCuW/1mdWpBWW75F6PZscaN2H2S7CbIetfQ1o1voKYKkRxGHJHcYcVRhiIcuTzIT834kB0sCo9+bQrErXCMRw4DchjSSjiAQwjKEWz6Qwo8qN3lLycpHLuX6PjY7B3V2RuhDKg86EgZ4f2XPB5dtxr1JZyv+YHcu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54596e36-6622-49a7-7043-08d77eaf4675
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 02:59:17.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ss5a47gFHWfBf4e6HSl15Yk34WofMqcLG1fVPRkz730ecuzflInChfqxUIjlBTbg/kpu322LT20wmmY2Tloadg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the entire clk-imx8mn driver to clk_hw based API.
This allows us to move closer to a clear split between
consumer and provider clk APIs.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 489 ++++++++++++++++++++++-----------------=
----
 1 file changed, 251 insertions(+), 238 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 2c46d772294a..c5e7316b4c66 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/types.h>
=20
 #include "clk.h"
@@ -280,290 +281,302 @@ static const char * const imx8mn_clko2_sels[] =3D {=
"osc_24m", "sys_pll2_200m", "sy
 						 "sys_pll2_166m", "sys_pll3_out", "audio_pll1_out",
 						 "video_pll1_out", "osc_32k", };
=20
-static struct clk *clks[IMX8MN_CLK_END];
-static struct clk_onecell_data clk_data;
+static struct clk_hw_onecell_data *clk_hw_data;
+static struct clk_hw **hws;
=20
-static struct clk ** const uart_clks[] =3D {
-	&clks[IMX8MN_CLK_UART1_ROOT],
-	&clks[IMX8MN_CLK_UART2_ROOT],
-	&clks[IMX8MN_CLK_UART3_ROOT],
-	&clks[IMX8MN_CLK_UART4_ROOT],
-	NULL
+static const int uart_clk_ids[] =3D {
+	IMX8MN_CLK_UART1_ROOT,
+	IMX8MN_CLK_UART2_ROOT,
+	IMX8MN_CLK_UART3_ROOT,
+	IMX8MN_CLK_UART4_ROOT,
 };
+static struct clk **uart_hws[ARRAY_SIZE(uart_clk_ids) + 1];
=20
 static int imx8mn_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct device_node *np =3D dev->of_node;
 	void __iomem *base;
-	int ret;
+	int ret, i;
=20
-	clks[IMX8MN_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
-	clks[IMX8MN_CLK_24M] =3D of_clk_get_by_name(np, "osc_24m");
-	clks[IMX8MN_CLK_32K] =3D of_clk_get_by_name(np, "osc_32k");
-	clks[IMX8MN_CLK_EXT1] =3D of_clk_get_by_name(np, "clk_ext1");
-	clks[IMX8MN_CLK_EXT2] =3D of_clk_get_by_name(np, "clk_ext2");
-	clks[IMX8MN_CLK_EXT3] =3D of_clk_get_by_name(np, "clk_ext3");
-	clks[IMX8MN_CLK_EXT4] =3D of_clk_get_by_name(np, "clk_ext4");
+	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
+					  IMX8MN_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return -ENOMEM;
+
+	clk_hw_data->num =3D IMX8MN_CLK_END;
+	hws =3D clk_hw_data->hws;
+
+	hws[IMX8MN_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
+	hws[IMX8MN_CLK_24M] =3D imx_obtain_fixed_clk_hw(np, "osc_24m");
+	hws[IMX8MN_CLK_32K] =3D imx_obtain_fixed_clk_hw(np, "osc_32k");
+	hws[IMX8MN_CLK_EXT1] =3D imx_obtain_fixed_clk_hw(np, "clk_ext1");
+	hws[IMX8MN_CLK_EXT2] =3D imx_obtain_fixed_clk_hw(np, "clk_ext2");
+	hws[IMX8MN_CLK_EXT3] =3D imx_obtain_fixed_clk_hw(np, "clk_ext3");
+	hws[IMX8MN_CLK_EXT4] =3D imx_obtain_fixed_clk_hw(np, "clk_ext4");
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
 	base =3D of_iomap(np, 0);
 	if (WARN_ON(!base)) {
 		ret =3D -ENOMEM;
-		goto unregister_clks;
+		goto unregister_hws;
 	}
=20
-	clks[IMX8MN_AUDIO_PLL1_REF_SEL] =3D imx_clk_mux("audio_pll1_ref_sel", bas=
e + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_AUDIO_PLL2_REF_SEL] =3D imx_clk_mux("audio_pll2_ref_sel", bas=
e + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_VIDEO_PLL1_REF_SEL] =3D imx_clk_mux("video_pll1_ref_sel", bas=
e + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_DRAM_PLL_REF_SEL] =3D imx_clk_mux("dram_pll_ref_sel", base + =
0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", base + 0x=
64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel", base + 0x=
74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", base + 0x=
84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel", base + =
0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-
-	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1", "audio_pll1_ref=
_sel", base, &imx_1443x_pll);
-	clks[IMX8MN_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2", "audio_pll2_ref=
_sel", base + 0x14, &imx_1443x_pll);
-	clks[IMX8MN_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1", "video_pll1_ref=
_sel", base + 0x28, &imx_1443x_pll);
-	clks[IMX8MN_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel",=
 base + 0x50, &imx_1443x_dram_pll);
-	clks[IMX8MN_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", ba=
se + 0x64, &imx_1416x_pll);
-	clks[IMX8MN_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", ba=
se + 0x74, &imx_1416x_pll);
-	clks[IMX8MN_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", ba=
se + 0x84, &imx_1416x_pll);
-	clks[IMX8MN_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
-	clks[IMX8MN_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);
-	clks[IMX8MN_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",=
 base + 0x114, &imx_1416x_pll);
+	hws[IMX8MN_AUDIO_PLL1_REF_SEL] =3D imx_clk_hw_mux("audio_pll1_ref_sel", b=
ase + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_AUDIO_PLL2_REF_SEL] =3D imx_clk_hw_mux("audio_pll2_ref_sel", b=
ase + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_VIDEO_PLL1_REF_SEL] =3D imx_clk_hw_mux("video_pll1_ref_sel", b=
ase + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_DRAM_PLL_REF_SEL] =3D imx_clk_hw_mux("dram_pll_ref_sel", base =
+ 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_GPU_PLL_REF_SEL] =3D imx_clk_hw_mux("gpu_pll_ref_sel", base + =
0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_VPU_PLL_REF_SEL] =3D imx_clk_hw_mux("vpu_pll_ref_sel", base + =
0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_ARM_PLL_REF_SEL] =3D imx_clk_hw_mux("arm_pll_ref_sel", base + =
0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MN_SYS_PLL3_REF_SEL] =3D imx_clk_hw_mux("sys_pll3_ref_sel", base =
+ 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+
+	hws[IMX8MN_AUDIO_PLL1] =3D imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_r=
ef_sel", base, &imx_1443x_pll);
+	hws[IMX8MN_AUDIO_PLL2] =3D imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_r=
ef_sel", base + 0x14, &imx_1443x_pll);
+	hws[IMX8MN_VIDEO_PLL1] =3D imx_clk_hw_pll14xx("video_pll1", "video_pll1_r=
ef_sel", base + 0x28, &imx_1443x_pll);
+	hws[IMX8MN_DRAM_PLL] =3D imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel=
", base + 0x50, &imx_1443x_dram_pll);
+	hws[IMX8MN_GPU_PLL] =3D imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", =
base + 0x64, &imx_1416x_pll);
+	hws[IMX8MN_VPU_PLL] =3D imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", =
base + 0x74, &imx_1416x_pll);
+	hws[IMX8MN_ARM_PLL] =3D imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", =
base + 0x84, &imx_1416x_pll);
+	hws[IMX8MN_SYS_PLL1] =3D imx_clk_hw_fixed("sys_pll1", 800000000);
+	hws[IMX8MN_SYS_PLL2] =3D imx_clk_hw_fixed("sys_pll2", 1000000000);
+	hws[IMX8MN_SYS_PLL3] =3D imx_clk_hw_pll14xx("sys_pll3", "sys_pll3_ref_sel=
", base + 0x114, &imx_1416x_pll);
=20
 	/* PLL bypass out */
-	clks[IMX8MN_AUDIO_PLL1_BYPASS] =3D imx_clk_mux_flags("audio_pll1_bypass",=
 base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), C=
LK_SET_RATE_PARENT);
-	clks[IMX8MN_AUDIO_PLL2_BYPASS] =3D imx_clk_mux_flags("audio_pll2_bypass",=
 base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_s=
els), CLK_SET_RATE_PARENT);
-	clks[IMX8MN_VIDEO_PLL1_BYPASS] =3D imx_clk_mux_flags("video_pll1_bypass",=
 base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_s=
els), CLK_SET_RATE_PARENT);
-	clks[IMX8MN_DRAM_PLL_BYPASS] =3D imx_clk_mux_flags("dram_pll_bypass", bas=
e + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CL=
K_SET_RATE_PARENT);
-	clks[IMX8MN_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", base =
+ 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
-	clks[IMX8MN_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", base =
+ 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
-	clks[IMX8MN_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
-	clks[IMX8MN_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", bas=
e + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), C=
LK_SET_RATE_PARENT);
+	hws[IMX8MN_AUDIO_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("audio_pll1_bypass=
", base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels),=
 CLK_SET_RATE_PARENT);
+	hws[IMX8MN_AUDIO_PLL2_BYPASS] =3D imx_clk_hw_mux_flags("audio_pll2_bypass=
", base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass=
_sels), CLK_SET_RATE_PARENT);
+	hws[IMX8MN_VIDEO_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("video_pll1_bypass=
", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass=
_sels), CLK_SET_RATE_PARENT);
+	hws[IMX8MN_DRAM_PLL_BYPASS] =3D imx_clk_hw_mux_flags("dram_pll_bypass", b=
ase + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), =
CLK_SET_RATE_PARENT);
+	hws[IMX8MN_GPU_PLL_BYPASS] =3D imx_clk_hw_mux_flags("gpu_pll_bypass", bas=
e + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_=
SET_RATE_PARENT);
+	hws[IMX8MN_VPU_PLL_BYPASS] =3D imx_clk_hw_mux_flags("vpu_pll_bypass", bas=
e + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_=
SET_RATE_PARENT);
+	hws[IMX8MN_ARM_PLL_BYPASS] =3D imx_clk_hw_mux_flags("arm_pll_bypass", bas=
e + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_=
SET_RATE_PARENT);
+	hws[IMX8MN_SYS_PLL3_BYPASS] =3D imx_clk_hw_mux_flags("sys_pll3_bypass", b=
ase + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels),=
 CLK_SET_RATE_PARENT);
=20
 	/* PLL out gate */
-	clks[IMX8MN_AUDIO_PLL1_OUT] =3D imx_clk_gate("audio_pll1_out", "audio_pll=
1_bypass", base, 13);
-	clks[IMX8MN_AUDIO_PLL2_OUT] =3D imx_clk_gate("audio_pll2_out", "audio_pll=
2_bypass", base + 0x14, 13);
-	clks[IMX8MN_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "video_pll=
1_bypass", base + 0x28, 13);
-	clks[IMX8MN_DRAM_PLL_OUT] =3D imx_clk_gate("dram_pll_out", "dram_pll_bypa=
ss", base + 0x50, 13);
-	clks[IMX8MN_GPU_PLL_OUT] =3D imx_clk_gate("gpu_pll_out", "gpu_pll_bypass"=
, base + 0x64, 11);
-	clks[IMX8MN_VPU_PLL_OUT] =3D imx_clk_gate("vpu_pll_out", "vpu_pll_bypass"=
, base + 0x74, 11);
-	clks[IMX8MN_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll_bypass"=
, base + 0x84, 11);
-	clks[IMX8MN_SYS_PLL3_OUT] =3D imx_clk_gate("sys_pll3_out", "sys_pll3_bypa=
ss", base + 0x114, 11);
+	hws[IMX8MN_AUDIO_PLL1_OUT] =3D imx_clk_hw_gate("audio_pll1_out", "audio_p=
ll1_bypass", base, 13);
+	hws[IMX8MN_AUDIO_PLL2_OUT] =3D imx_clk_hw_gate("audio_pll2_out", "audio_p=
ll2_bypass", base + 0x14, 13);
+	hws[IMX8MN_VIDEO_PLL1_OUT] =3D imx_clk_hw_gate("video_pll1_out", "video_p=
ll1_bypass", base + 0x28, 13);
+	hws[IMX8MN_DRAM_PLL_OUT] =3D imx_clk_hw_gate("dram_pll_out", "dram_pll_by=
pass", base + 0x50, 13);
+	hws[IMX8MN_GPU_PLL_OUT] =3D imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypas=
s", base + 0x64, 11);
+	hws[IMX8MN_VPU_PLL_OUT] =3D imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypas=
s", base + 0x74, 11);
+	hws[IMX8MN_ARM_PLL_OUT] =3D imx_clk_hw_gate("arm_pll_out", "arm_pll_bypas=
s", base + 0x84, 11);
+	hws[IMX8MN_SYS_PLL3_OUT] =3D imx_clk_hw_gate("sys_pll3_out", "sys_pll3_by=
pass", base + 0x114, 11);
=20
 	/* SYS PLL1 fixed output */
-	clks[IMX8MN_SYS_PLL1_40M_CG] =3D imx_clk_gate("sys_pll1_40m_cg", "sys_pll=
1", base + 0x94, 27);
-	clks[IMX8MN_SYS_PLL1_80M_CG] =3D imx_clk_gate("sys_pll1_80m_cg", "sys_pll=
1", base + 0x94, 25);
-	clks[IMX8MN_SYS_PLL1_100M_CG] =3D imx_clk_gate("sys_pll1_100m_cg", "sys_p=
ll1", base + 0x94, 23);
-	clks[IMX8MN_SYS_PLL1_133M_CG] =3D imx_clk_gate("sys_pll1_133m_cg", "sys_p=
ll1", base + 0x94, 21);
-	clks[IMX8MN_SYS_PLL1_160M_CG] =3D imx_clk_gate("sys_pll1_160m_cg", "sys_p=
ll1", base + 0x94, 19);
-	clks[IMX8MN_SYS_PLL1_200M_CG] =3D imx_clk_gate("sys_pll1_200m_cg", "sys_p=
ll1", base + 0x94, 17);
-	clks[IMX8MN_SYS_PLL1_266M_CG] =3D imx_clk_gate("sys_pll1_266m_cg", "sys_p=
ll1", base + 0x94, 15);
-	clks[IMX8MN_SYS_PLL1_400M_CG] =3D imx_clk_gate("sys_pll1_400m_cg", "sys_p=
ll1", base + 0x94, 13);
-	clks[IMX8MN_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1", ba=
se + 0x94, 11);
-
-	clks[IMX8MN_SYS_PLL1_40M] =3D imx_clk_fixed_factor("sys_pll1_40m", "sys_p=
ll1_40m_cg", 1, 20);
-	clks[IMX8MN_SYS_PLL1_80M] =3D imx_clk_fixed_factor("sys_pll1_80m", "sys_p=
ll1_80m_cg", 1, 10);
-	clks[IMX8MN_SYS_PLL1_100M] =3D imx_clk_fixed_factor("sys_pll1_100m", "sys=
_pll1_100m_cg", 1, 8);
-	clks[IMX8MN_SYS_PLL1_133M] =3D imx_clk_fixed_factor("sys_pll1_133m", "sys=
_pll1_133m_cg", 1, 6);
-	clks[IMX8MN_SYS_PLL1_160M] =3D imx_clk_fixed_factor("sys_pll1_160m", "sys=
_pll1_160m_cg", 1, 5);
-	clks[IMX8MN_SYS_PLL1_200M] =3D imx_clk_fixed_factor("sys_pll1_200m", "sys=
_pll1_200m_cg", 1, 4);
-	clks[IMX8MN_SYS_PLL1_266M] =3D imx_clk_fixed_factor("sys_pll1_266m", "sys=
_pll1_266m_cg", 1, 3);
-	clks[IMX8MN_SYS_PLL1_400M] =3D imx_clk_fixed_factor("sys_pll1_400m", "sys=
_pll1_400m_cg", 1, 2);
-	clks[IMX8MN_SYS_PLL1_800M] =3D imx_clk_fixed_factor("sys_pll1_800m", "sys=
_pll1_out", 1, 1);
+	hws[IMX8MN_SYS_PLL1_40M_CG] =3D imx_clk_hw_gate("sys_pll1_40m_cg", "sys_p=
ll1", base + 0x94, 27);
+	hws[IMX8MN_SYS_PLL1_80M_CG] =3D imx_clk_hw_gate("sys_pll1_80m_cg", "sys_p=
ll1", base + 0x94, 25);
+	hws[IMX8MN_SYS_PLL1_100M_CG] =3D imx_clk_hw_gate("sys_pll1_100m_cg", "sys=
_pll1", base + 0x94, 23);
+	hws[IMX8MN_SYS_PLL1_133M_CG] =3D imx_clk_hw_gate("sys_pll1_133m_cg", "sys=
_pll1", base + 0x94, 21);
+	hws[IMX8MN_SYS_PLL1_160M_CG] =3D imx_clk_hw_gate("sys_pll1_160m_cg", "sys=
_pll1", base + 0x94, 19);
+	hws[IMX8MN_SYS_PLL1_200M_CG] =3D imx_clk_hw_gate("sys_pll1_200m_cg", "sys=
_pll1", base + 0x94, 17);
+	hws[IMX8MN_SYS_PLL1_266M_CG] =3D imx_clk_hw_gate("sys_pll1_266m_cg", "sys=
_pll1", base + 0x94, 15);
+	hws[IMX8MN_SYS_PLL1_400M_CG] =3D imx_clk_hw_gate("sys_pll1_400m_cg", "sys=
_pll1", base + 0x94, 13);
+	hws[IMX8MN_SYS_PLL1_OUT] =3D imx_clk_hw_gate("sys_pll1_out", "sys_pll1", =
base + 0x94, 11);
+
+	hws[IMX8MN_SYS_PLL1_40M] =3D imx_clk_hw_fixed_factor("sys_pll1_40m", "sys=
_pll1_40m_cg", 1, 20);
+	hws[IMX8MN_SYS_PLL1_80M] =3D imx_clk_hw_fixed_factor("sys_pll1_80m", "sys=
_pll1_80m_cg", 1, 10);
+	hws[IMX8MN_SYS_PLL1_100M] =3D imx_clk_hw_fixed_factor("sys_pll1_100m", "s=
ys_pll1_100m_cg", 1, 8);
+	hws[IMX8MN_SYS_PLL1_133M] =3D imx_clk_hw_fixed_factor("sys_pll1_133m", "s=
ys_pll1_133m_cg", 1, 6);
+	hws[IMX8MN_SYS_PLL1_160M] =3D imx_clk_hw_fixed_factor("sys_pll1_160m", "s=
ys_pll1_160m_cg", 1, 5);
+	hws[IMX8MN_SYS_PLL1_200M] =3D imx_clk_hw_fixed_factor("sys_pll1_200m", "s=
ys_pll1_200m_cg", 1, 4);
+	hws[IMX8MN_SYS_PLL1_266M] =3D imx_clk_hw_fixed_factor("sys_pll1_266m", "s=
ys_pll1_266m_cg", 1, 3);
+	hws[IMX8MN_SYS_PLL1_400M] =3D imx_clk_hw_fixed_factor("sys_pll1_400m", "s=
ys_pll1_400m_cg", 1, 2);
+	hws[IMX8MN_SYS_PLL1_800M] =3D imx_clk_hw_fixed_factor("sys_pll1_800m", "s=
ys_pll1_out", 1, 1);
=20
 	/* SYS PLL2 fixed output */
-	clks[IMX8MN_SYS_PLL2_50M_CG] =3D imx_clk_gate("sys_pll2_50m_cg", "sys_pll=
2", base + 0x104, 27);
-	clks[IMX8MN_SYS_PLL2_100M_CG] =3D imx_clk_gate("sys_pll2_100m_cg", "sys_p=
ll2", base + 0x104, 25);
-	clks[IMX8MN_SYS_PLL2_125M_CG] =3D imx_clk_gate("sys_pll2_125m_cg", "sys_p=
ll2", base + 0x104, 23);
-	clks[IMX8MN_SYS_PLL2_166M_CG] =3D imx_clk_gate("sys_pll2_166m_cg", "sys_p=
ll2", base + 0x104, 21);
-	clks[IMX8MN_SYS_PLL2_200M_CG] =3D imx_clk_gate("sys_pll2_200m_cg", "sys_p=
ll2", base + 0x104, 19);
-	clks[IMX8MN_SYS_PLL2_250M_CG] =3D imx_clk_gate("sys_pll2_250m_cg", "sys_p=
ll2", base + 0x104, 17);
-	clks[IMX8MN_SYS_PLL2_333M_CG] =3D imx_clk_gate("sys_pll2_333m_cg", "sys_p=
ll2", base + 0x104, 15);
-	clks[IMX8MN_SYS_PLL2_500M_CG] =3D imx_clk_gate("sys_pll2_500m_cg", "sys_p=
ll2", base + 0x104, 13);
-	clks[IMX8MN_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2", ba=
se + 0x104, 11);
-
-	clks[IMX8MN_SYS_PLL2_50M] =3D imx_clk_fixed_factor("sys_pll2_50m", "sys_p=
ll2_50m_cg", 1, 20);
-	clks[IMX8MN_SYS_PLL2_100M] =3D imx_clk_fixed_factor("sys_pll2_100m", "sys=
_pll2_100m_cg", 1, 10);
-	clks[IMX8MN_SYS_PLL2_125M] =3D imx_clk_fixed_factor("sys_pll2_125m", "sys=
_pll2_125m_cg", 1, 8);
-	clks[IMX8MN_SYS_PLL2_166M] =3D imx_clk_fixed_factor("sys_pll2_166m", "sys=
_pll2_166m_cg", 1, 6);
-	clks[IMX8MN_SYS_PLL2_200M] =3D imx_clk_fixed_factor("sys_pll2_200m", "sys=
_pll2_200m_cg", 1, 5);
-	clks[IMX8MN_SYS_PLL2_250M] =3D imx_clk_fixed_factor("sys_pll2_250m", "sys=
_pll2_250m_cg", 1, 4);
-	clks[IMX8MN_SYS_PLL2_333M] =3D imx_clk_fixed_factor("sys_pll2_333m", "sys=
_pll2_333m_cg", 1, 3);
-	clks[IMX8MN_SYS_PLL2_500M] =3D imx_clk_fixed_factor("sys_pll2_500m", "sys=
_pll2_500m_cg", 1, 2);
-	clks[IMX8MN_SYS_PLL2_1000M] =3D imx_clk_fixed_factor("sys_pll2_1000m", "s=
ys_pll2_out", 1, 1);
+	hws[IMX8MN_SYS_PLL2_50M_CG] =3D imx_clk_hw_gate("sys_pll2_50m_cg", "sys_p=
ll2", base + 0x104, 27);
+	hws[IMX8MN_SYS_PLL2_100M_CG] =3D imx_clk_hw_gate("sys_pll2_100m_cg", "sys=
_pll2", base + 0x104, 25);
+	hws[IMX8MN_SYS_PLL2_125M_CG] =3D imx_clk_hw_gate("sys_pll2_125m_cg", "sys=
_pll2", base + 0x104, 23);
+	hws[IMX8MN_SYS_PLL2_166M_CG] =3D imx_clk_hw_gate("sys_pll2_166m_cg", "sys=
_pll2", base + 0x104, 21);
+	hws[IMX8MN_SYS_PLL2_200M_CG] =3D imx_clk_hw_gate("sys_pll2_200m_cg", "sys=
_pll2", base + 0x104, 19);
+	hws[IMX8MN_SYS_PLL2_250M_CG] =3D imx_clk_hw_gate("sys_pll2_250m_cg", "sys=
_pll2", base + 0x104, 17);
+	hws[IMX8MN_SYS_PLL2_333M_CG] =3D imx_clk_hw_gate("sys_pll2_333m_cg", "sys=
_pll2", base + 0x104, 15);
+	hws[IMX8MN_SYS_PLL2_500M_CG] =3D imx_clk_hw_gate("sys_pll2_500m_cg", "sys=
_pll2", base + 0x104, 13);
+	hws[IMX8MN_SYS_PLL2_OUT] =3D imx_clk_hw_gate("sys_pll2_out", "sys_pll2", =
base + 0x104, 11);
+
+	hws[IMX8MN_SYS_PLL2_50M] =3D imx_clk_hw_fixed_factor("sys_pll2_50m", "sys=
_pll2_50m_cg", 1, 20);
+	hws[IMX8MN_SYS_PLL2_100M] =3D imx_clk_hw_fixed_factor("sys_pll2_100m", "s=
ys_pll2_100m_cg", 1, 10);
+	hws[IMX8MN_SYS_PLL2_125M] =3D imx_clk_hw_fixed_factor("sys_pll2_125m", "s=
ys_pll2_125m_cg", 1, 8);
+	hws[IMX8MN_SYS_PLL2_166M] =3D imx_clk_hw_fixed_factor("sys_pll2_166m", "s=
ys_pll2_166m_cg", 1, 6);
+	hws[IMX8MN_SYS_PLL2_200M] =3D imx_clk_hw_fixed_factor("sys_pll2_200m", "s=
ys_pll2_200m_cg", 1, 5);
+	hws[IMX8MN_SYS_PLL2_250M] =3D imx_clk_hw_fixed_factor("sys_pll2_250m", "s=
ys_pll2_250m_cg", 1, 4);
+	hws[IMX8MN_SYS_PLL2_333M] =3D imx_clk_hw_fixed_factor("sys_pll2_333m", "s=
ys_pll2_333m_cg", 1, 3);
+	hws[IMX8MN_SYS_PLL2_500M] =3D imx_clk_hw_fixed_factor("sys_pll2_500m", "s=
ys_pll2_500m_cg", 1, 2);
+	hws[IMX8MN_SYS_PLL2_1000M] =3D imx_clk_hw_fixed_factor("sys_pll2_1000m", =
"sys_pll2_out", 1, 1);
=20
 	np =3D dev->of_node;
 	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(IS_ERR(base))) {
 		ret =3D PTR_ERR(base);
-		goto unregister_clks;
+		goto unregister_hws;
 	}
=20
 	/* CORE */
-	clks[IMX8MN_CLK_A53_SRC] =3D imx_clk_mux2("arm_a53_src", base + 0x8000, 2=
4, 3, imx8mn_a53_sels, ARRAY_SIZE(imx8mn_a53_sels));
-	clks[IMX8MN_CLK_GPU_CORE_SRC] =3D imx_clk_mux2("gpu_core_src", base + 0x8=
180, 24, 3,  imx8mn_gpu_core_sels, ARRAY_SIZE(imx8mn_gpu_core_sels));
-	clks[IMX8MN_CLK_GPU_SHADER_SRC] =3D imx_clk_mux2("gpu_shader_src", base +=
 0x8200, 24, 3, imx8mn_gpu_shader_sels,  ARRAY_SIZE(imx8mn_gpu_shader_sels)=
);
-	clks[IMX8MN_CLK_A53_CG] =3D imx_clk_gate3("arm_a53_cg", "arm_a53_src", ba=
se + 0x8000, 28);
-	clks[IMX8MN_CLK_GPU_CORE_CG] =3D imx_clk_gate3("gpu_core_cg", "gpu_core_s=
rc", base + 0x8180, 28);
-	clks[IMX8MN_CLK_GPU_SHADER_CG] =3D imx_clk_gate3("gpu_shader_cg", "gpu_sh=
ader_src", base + 0x8200, 28);
+	hws[IMX8MN_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x8000,=
 24, 3, imx8mn_a53_sels, ARRAY_SIZE(imx8mn_a53_sels));
+	hws[IMX8MN_CLK_GPU_CORE_SRC] =3D imx_clk_hw_mux2("gpu_core_src", base + 0=
x8180, 24, 3,  imx8mn_gpu_core_sels, ARRAY_SIZE(imx8mn_gpu_core_sels));
+	hws[IMX8MN_CLK_GPU_SHADER_SRC] =3D imx_clk_hw_mux2("gpu_shader_src", base=
 + 0x8200, 24, 3, imx8mn_gpu_shader_sels,  ARRAY_SIZE(imx8mn_gpu_shader_sel=
s));
+	hws[IMX8MN_CLK_A53_CG] =3D imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src", =
base + 0x8000, 28);
+	hws[IMX8MN_CLK_GPU_CORE_CG] =3D imx_clk_hw_gate3("gpu_core_cg", "gpu_core=
_src", base + 0x8180, 28);
+	hws[IMX8MN_CLK_GPU_SHADER_CG] =3D imx_clk_hw_gate3("gpu_shader_cg", "gpu_=
shader_src", base + 0x8200, 28);
=20
-	clks[IMX8MN_CLK_A53_DIV] =3D imx_clk_divider2("arm_a53_div", "arm_a53_cg"=
, base + 0x8000, 0, 3);
-	clks[IMX8MN_CLK_GPU_CORE_DIV] =3D imx_clk_divider2("gpu_core_div", "gpu_c=
ore_cg", base + 0x8180, 0, 3);
-	clks[IMX8MN_CLK_GPU_SHADER_DIV] =3D imx_clk_divider2("gpu_shader_div", "g=
pu_shader_cg", base + 0x8200, 0, 3);
+	hws[IMX8MN_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a53_c=
g", base + 0x8000, 0, 3);
+	hws[IMX8MN_CLK_GPU_CORE_DIV] =3D imx_clk_hw_divider2("gpu_core_div", "gpu=
_core_cg", base + 0x8180, 0, 3);
+	hws[IMX8MN_CLK_GPU_SHADER_DIV] =3D imx_clk_hw_divider2("gpu_shader_div", =
"gpu_shader_cg", base + 0x8200, 0, 3);
=20
 	/* BUS */
-	clks[IMX8MN_CLK_MAIN_AXI] =3D imx8m_clk_composite_critical("main_axi", im=
x8mn_main_axi_sels, base + 0x8800);
-	clks[IMX8MN_CLK_ENET_AXI] =3D imx8m_clk_composite("enet_axi", imx8mn_enet=
_axi_sels, base + 0x8880);
-	clks[IMX8MN_CLK_NAND_USDHC_BUS] =3D imx8m_clk_composite("nand_usdhc_bus",=
 imx8mn_nand_usdhc_sels, base + 0x8900);
-	clks[IMX8MN_CLK_DISP_AXI] =3D imx8m_clk_composite("disp_axi", imx8mn_disp=
_axi_sels, base + 0x8a00);
-	clks[IMX8MN_CLK_DISP_APB] =3D imx8m_clk_composite("disp_apb", imx8mn_disp=
_apb_sels, base + 0x8a80);
-	clks[IMX8MN_CLK_USB_BUS] =3D imx8m_clk_composite("usb_bus", imx8mn_usb_bu=
s_sels, base + 0x8b80);
-	clks[IMX8MN_CLK_GPU_AXI] =3D imx8m_clk_composite("gpu_axi", imx8mn_gpu_ax=
i_sels, base + 0x8c00);
-	clks[IMX8MN_CLK_GPU_AHB] =3D imx8m_clk_composite("gpu_ahb", imx8mn_gpu_ah=
b_sels, base + 0x8c80);
-	clks[IMX8MN_CLK_NOC] =3D imx8m_clk_composite_critical("noc", imx8mn_noc_s=
els, base + 0x8d00);
-
-	clks[IMX8MN_CLK_AHB] =3D imx8m_clk_composite_critical("ahb", imx8mn_ahb_s=
els, base + 0x9000);
-	clks[IMX8MN_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb", imx8mn_au=
dio_ahb_sels, base + 0x9100);
-	clks[IMX8MN_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", base + =
0x9080, 0, 1);
-	clks[IMX8MN_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_root", "a=
udio_ahb", base + 0x9180, 0, 1);
-	clks[IMX8MN_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", base +=
 0x9800, 24, 1, imx8mn_dram_core_sels, ARRAY_SIZE(imx8mn_dram_core_sels), C=
LK_IS_CRITICAL);
+	hws[IMX8MN_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi", =
imx8mn_main_axi_sels, base + 0x8800);
+	hws[IMX8MN_CLK_ENET_AXI] =3D imx8m_clk_hw_composite("enet_axi", imx8mn_en=
et_axi_sels, base + 0x8880);
+	hws[IMX8MN_CLK_NAND_USDHC_BUS] =3D imx8m_clk_hw_composite("nand_usdhc_bus=
", imx8mn_nand_usdhc_sels, base + 0x8900);
+	hws[IMX8MN_CLK_DISP_AXI] =3D imx8m_clk_hw_composite("disp_axi", imx8mn_di=
sp_axi_sels, base + 0x8a00);
+	hws[IMX8MN_CLK_DISP_APB] =3D imx8m_clk_hw_composite("disp_apb", imx8mn_di=
sp_apb_sels, base + 0x8a80);
+	hws[IMX8MN_CLK_USB_BUS] =3D imx8m_clk_hw_composite("usb_bus", imx8mn_usb_=
bus_sels, base + 0x8b80);
+	hws[IMX8MN_CLK_GPU_AXI] =3D imx8m_clk_hw_composite("gpu_axi", imx8mn_gpu_=
axi_sels, base + 0x8c00);
+	hws[IMX8MN_CLK_GPU_AHB] =3D imx8m_clk_hw_composite("gpu_ahb", imx8mn_gpu_=
ahb_sels, base + 0x8c80);
+	hws[IMX8MN_CLK_NOC] =3D imx8m_clk_hw_composite_critical("noc", imx8mn_noc=
_sels, base + 0x8d00);
+
+	hws[IMX8MN_CLK_AHB] =3D imx8m_clk_hw_composite_critical("ahb", imx8mn_ahb=
_sels, base + 0x9000);
+	hws[IMX8MN_CLK_AUDIO_AHB] =3D imx8m_clk_hw_composite("audio_ahb", imx8mn_=
audio_ahb_sels, base + 0x9100);
+	hws[IMX8MN_CLK_IPG_ROOT] =3D imx_clk_hw_divider2("ipg_root", "ahb", base =
+ 0x9080, 0, 1);
+	hws[IMX8MN_CLK_IPG_AUDIO_ROOT] =3D imx_clk_hw_divider2("ipg_audio_root", =
"audio_ahb", base + 0x9180, 0, 1);
+	hws[IMX8MN_CLK_DRAM_CORE] =3D imx_clk_hw_mux2_flags("dram_core_clk", base=
 + 0x9800, 24, 1, imx8mn_dram_core_sels, ARRAY_SIZE(imx8mn_dram_core_sels),=
 CLK_IS_CRITICAL);
=20
 	/*
 	 * DRAM clocks are manipulated from TF-A outside clock framework.
 	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
 	 */
-	clks[IMX8MN_CLK_DRAM_ALT] =3D __imx8m_clk_composite("dram_alt", imx8mn_dr=
am_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
-	clks[IMX8MN_CLK_DRAM_APB] =3D __imx8m_clk_composite("dram_apb", imx8mn_dr=
am_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
-
-	clks[IMX8MN_CLK_DISP_PIXEL] =3D imx8m_clk_composite("disp_pixel", imx8mn_=
disp_pixel_sels, base + 0xa500);
-	clks[IMX8MN_CLK_SAI2] =3D imx8m_clk_composite("sai2", imx8mn_sai2_sels, b=
ase + 0xa600);
-	clks[IMX8MN_CLK_SAI3] =3D imx8m_clk_composite("sai3", imx8mn_sai3_sels, b=
ase + 0xa680);
-	clks[IMX8MN_CLK_SAI5] =3D imx8m_clk_composite("sai5", imx8mn_sai5_sels, b=
ase + 0xa780);
-	clks[IMX8MN_CLK_SAI6] =3D imx8m_clk_composite("sai6", imx8mn_sai6_sels, b=
ase + 0xa800);
-	clks[IMX8MN_CLK_SPDIF1] =3D imx8m_clk_composite("spdif1", imx8mn_spdif1_s=
els, base + 0xa880);
-	clks[IMX8MN_CLK_ENET_REF] =3D imx8m_clk_composite("enet_ref", imx8mn_enet=
_ref_sels, base + 0xa980);
-	clks[IMX8MN_CLK_ENET_TIMER] =3D imx8m_clk_composite("enet_timer", imx8mn_=
enet_timer_sels, base + 0xaa00);
-	clks[IMX8MN_CLK_ENET_PHY_REF] =3D imx8m_clk_composite("enet_phy", imx8mn_=
enet_phy_sels, base + 0xaa80);
-	clks[IMX8MN_CLK_NAND] =3D imx8m_clk_composite("nand", imx8mn_nand_sels, b=
ase + 0xab00);
-	clks[IMX8MN_CLK_QSPI] =3D imx8m_clk_composite("qspi", imx8mn_qspi_sels, b=
ase + 0xab80);
-	clks[IMX8MN_CLK_USDHC1] =3D imx8m_clk_composite("usdhc1", imx8mn_usdhc1_s=
els, base + 0xac00);
-	clks[IMX8MN_CLK_USDHC2] =3D imx8m_clk_composite("usdhc2", imx8mn_usdhc2_s=
els, base + 0xac80);
-	clks[IMX8MN_CLK_I2C1] =3D imx8m_clk_composite("i2c1", imx8mn_i2c1_sels, b=
ase + 0xad00);
-	clks[IMX8MN_CLK_I2C2] =3D imx8m_clk_composite("i2c2", imx8mn_i2c2_sels, b=
ase + 0xad80);
-	clks[IMX8MN_CLK_I2C3] =3D imx8m_clk_composite("i2c3", imx8mn_i2c3_sels, b=
ase + 0xae00);
-	clks[IMX8MN_CLK_I2C4] =3D imx8m_clk_composite("i2c4", imx8mn_i2c4_sels, b=
ase + 0xae80);
-	clks[IMX8MN_CLK_UART1] =3D imx8m_clk_composite("uart1", imx8mn_uart1_sels=
, base + 0xaf00);
-	clks[IMX8MN_CLK_UART2] =3D imx8m_clk_composite("uart2", imx8mn_uart2_sels=
, base + 0xaf80);
-	clks[IMX8MN_CLK_UART3] =3D imx8m_clk_composite("uart3", imx8mn_uart3_sels=
, base + 0xb000);
-	clks[IMX8MN_CLK_UART4] =3D imx8m_clk_composite("uart4", imx8mn_uart4_sels=
, base + 0xb080);
-	clks[IMX8MN_CLK_USB_CORE_REF] =3D imx8m_clk_composite("usb_core_ref", imx=
8mn_usb_core_sels, base + 0xb100);
-	clks[IMX8MN_CLK_USB_PHY_REF] =3D imx8m_clk_composite("usb_phy_ref", imx8m=
n_usb_phy_sels, base + 0xb180);
-	clks[IMX8MN_CLK_GIC] =3D imx8m_clk_composite_critical("gic", imx8mn_gic_s=
els, base + 0xb200);
-	clks[IMX8MN_CLK_ECSPI1] =3D imx8m_clk_composite("ecspi1", imx8mn_ecspi1_s=
els, base + 0xb280);
-	clks[IMX8MN_CLK_ECSPI2] =3D imx8m_clk_composite("ecspi2", imx8mn_ecspi2_s=
els, base + 0xb300);
-	clks[IMX8MN_CLK_PWM1] =3D imx8m_clk_composite("pwm1", imx8mn_pwm1_sels, b=
ase + 0xb380);
-	clks[IMX8MN_CLK_PWM2] =3D imx8m_clk_composite("pwm2", imx8mn_pwm2_sels, b=
ase + 0xb400);
-	clks[IMX8MN_CLK_PWM3] =3D imx8m_clk_composite("pwm3", imx8mn_pwm3_sels, b=
ase + 0xb480);
-	clks[IMX8MN_CLK_PWM4] =3D imx8m_clk_composite("pwm4", imx8mn_pwm4_sels, b=
ase + 0xb500);
-	clks[IMX8MN_CLK_WDOG] =3D imx8m_clk_composite("wdog", imx8mn_wdog_sels, b=
ase + 0xb900);
-	clks[IMX8MN_CLK_WRCLK] =3D imx8m_clk_composite("wrclk", imx8mn_wrclk_sels=
, base + 0xb980);
-	clks[IMX8MN_CLK_CLKO1] =3D imx8m_clk_composite("clko1", imx8mn_clko1_sels=
, base + 0xba00);
-	clks[IMX8MN_CLK_CLKO2] =3D imx8m_clk_composite("clko2", imx8mn_clko2_sels=
, base + 0xba80);
-	clks[IMX8MN_CLK_DSI_CORE] =3D imx8m_clk_composite("dsi_core", imx8mn_dsi_=
core_sels, base + 0xbb00);
-	clks[IMX8MN_CLK_DSI_PHY_REF] =3D imx8m_clk_composite("dsi_phy_ref", imx8m=
n_dsi_phy_sels, base + 0xbb80);
-	clks[IMX8MN_CLK_DSI_DBI] =3D imx8m_clk_composite("dsi_dbi", imx8mn_dsi_db=
i_sels, base + 0xbc00);
-	clks[IMX8MN_CLK_USDHC3] =3D imx8m_clk_composite("usdhc3", imx8mn_usdhc3_s=
els, base + 0xbc80);
-	clks[IMX8MN_CLK_CAMERA_PIXEL] =3D imx8m_clk_composite("camera_pixel", imx=
8mn_camera_pixel_sels, base + 0xbd00);
-	clks[IMX8MN_CLK_CSI1_PHY_REF] =3D imx8m_clk_composite("csi1_phy_ref", imx=
8mn_csi1_phy_sels, base + 0xbd80);
-	clks[IMX8MN_CLK_CSI2_PHY_REF] =3D imx8m_clk_composite("csi2_phy_ref", imx=
8mn_csi2_phy_sels, base + 0xbf00);
-	clks[IMX8MN_CLK_CSI2_ESC] =3D imx8m_clk_composite("csi2_esc", imx8mn_csi2=
_esc_sels, base + 0xbf80);
-	clks[IMX8MN_CLK_ECSPI3] =3D imx8m_clk_composite("ecspi3", imx8mn_ecspi3_s=
els, base + 0xc180);
-	clks[IMX8MN_CLK_PDM] =3D imx8m_clk_composite("pdm", imx8mn_pdm_sels, base=
 + 0xc200);
-	clks[IMX8MN_CLK_SAI7] =3D imx8m_clk_composite("sai7", imx8mn_sai7_sels, b=
ase + 0xc300);
-
-	clks[IMX8MN_CLK_ECSPI1_ROOT] =3D imx_clk_gate4("ecspi1_root_clk", "ecspi1=
", base + 0x4070, 0);
-	clks[IMX8MN_CLK_ECSPI2_ROOT] =3D imx_clk_gate4("ecspi2_root_clk", "ecspi2=
", base + 0x4080, 0);
-	clks[IMX8MN_CLK_ECSPI3_ROOT] =3D imx_clk_gate4("ecspi3_root_clk", "ecspi3=
", base + 0x4090, 0);
-	clks[IMX8MN_CLK_ENET1_ROOT] =3D imx_clk_gate4("enet1_root_clk", "enet_axi=
", base + 0x40a0, 0);
-	clks[IMX8MN_CLK_GPIO1_ROOT] =3D imx_clk_gate4("gpio1_root_clk", "ipg_root=
", base + 0x40b0, 0);
-	clks[IMX8MN_CLK_GPIO2_ROOT] =3D imx_clk_gate4("gpio2_root_clk", "ipg_root=
", base + 0x40c0, 0);
-	clks[IMX8MN_CLK_GPIO3_ROOT] =3D imx_clk_gate4("gpio3_root_clk", "ipg_root=
", base + 0x40d0, 0);
-	clks[IMX8MN_CLK_GPIO4_ROOT] =3D imx_clk_gate4("gpio4_root_clk", "ipg_root=
", base + 0x40e0, 0);
-	clks[IMX8MN_CLK_GPIO5_ROOT] =3D imx_clk_gate4("gpio5_root_clk", "ipg_root=
", base + 0x40f0, 0);
-	clks[IMX8MN_CLK_I2C1_ROOT] =3D imx_clk_gate4("i2c1_root_clk", "i2c1", bas=
e + 0x4170, 0);
-	clks[IMX8MN_CLK_I2C2_ROOT] =3D imx_clk_gate4("i2c2_root_clk", "i2c2", bas=
e + 0x4180, 0);
-	clks[IMX8MN_CLK_I2C3_ROOT] =3D imx_clk_gate4("i2c3_root_clk", "i2c3", bas=
e + 0x4190, 0);
-	clks[IMX8MN_CLK_I2C4_ROOT] =3D imx_clk_gate4("i2c4_root_clk", "i2c4", bas=
e + 0x41a0, 0);
-	clks[IMX8MN_CLK_MU_ROOT] =3D imx_clk_gate4("mu_root_clk", "ipg_root", bas=
e + 0x4210, 0);
-	clks[IMX8MN_CLK_OCOTP_ROOT] =3D imx_clk_gate4("ocotp_root_clk", "ipg_root=
", base + 0x4220, 0);
-	clks[IMX8MN_CLK_PWM1_ROOT] =3D imx_clk_gate4("pwm1_root_clk", "pwm1", bas=
e + 0x4280, 0);
-	clks[IMX8MN_CLK_PWM2_ROOT] =3D imx_clk_gate4("pwm2_root_clk", "pwm2", bas=
e + 0x4290, 0);
-	clks[IMX8MN_CLK_PWM3_ROOT] =3D imx_clk_gate4("pwm3_root_clk", "pwm3", bas=
e + 0x42a0, 0);
-	clks[IMX8MN_CLK_PWM4_ROOT] =3D imx_clk_gate4("pwm4_root_clk", "pwm4", bas=
e + 0x42b0, 0);
-	clks[IMX8MN_CLK_QSPI_ROOT] =3D imx_clk_gate4("qspi_root_clk", "qspi", bas=
e + 0x42f0, 0);
-	clks[IMX8MN_CLK_NAND_ROOT] =3D imx_clk_gate2_shared2("nand_root_clk", "na=
nd", base + 0x4300, 0, &share_count_nand);
-	clks[IMX8MN_CLK_NAND_USDHC_BUS_RAWNAND_CLK] =3D imx_clk_gate2_shared2("na=
nd_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_nan=
d);
-	clks[IMX8MN_CLK_SAI2_ROOT] =3D imx_clk_gate2_shared2("sai2_root_clk", "sa=
i2", base + 0x4340, 0, &share_count_sai2);
-	clks[IMX8MN_CLK_SAI2_IPG] =3D imx_clk_gate2_shared2("sai2_ipg_clk", "ipg_=
audio_root", base + 0x4340, 0, &share_count_sai2);
-	clks[IMX8MN_CLK_SAI3_ROOT] =3D imx_clk_gate2_shared2("sai3_root_clk", "sa=
i3", base + 0x4350, 0, &share_count_sai3);
-	clks[IMX8MN_CLK_SAI3_IPG] =3D imx_clk_gate2_shared2("sai3_ipg_clk", "ipg_=
audio_root", base + 0x4350, 0, &share_count_sai3);
-	clks[IMX8MN_CLK_SAI5_ROOT] =3D imx_clk_gate2_shared2("sai5_root_clk", "sa=
i5", base + 0x4370, 0, &share_count_sai5);
-	clks[IMX8MN_CLK_SAI5_IPG] =3D imx_clk_gate2_shared2("sai5_ipg_clk", "ipg_=
audio_root", base + 0x4370, 0, &share_count_sai5);
-	clks[IMX8MN_CLK_SAI6_ROOT] =3D imx_clk_gate2_shared2("sai6_root_clk", "sa=
i6", base + 0x4380, 0, &share_count_sai6);
-	clks[IMX8MN_CLK_SAI6_IPG] =3D imx_clk_gate2_shared2("sai6_ipg_clk", "ipg_=
audio_root", base + 0x4380, 0, &share_count_sai6);
-	clks[IMX8MN_CLK_UART1_ROOT] =3D imx_clk_gate4("uart1_root_clk", "uart1", =
base + 0x4490, 0);
-	clks[IMX8MN_CLK_UART2_ROOT] =3D imx_clk_gate4("uart2_root_clk", "uart2", =
base + 0x44a0, 0);
-	clks[IMX8MN_CLK_UART3_ROOT] =3D imx_clk_gate4("uart3_root_clk", "uart3", =
base + 0x44b0, 0);
-	clks[IMX8MN_CLK_UART4_ROOT] =3D imx_clk_gate4("uart4_root_clk", "uart4", =
base + 0x44c0, 0);
-	clks[IMX8MN_CLK_USB1_CTRL_ROOT] =3D imx_clk_gate4("usb1_ctrl_root_clk", "=
usb_bus", base + 0x44d0, 0);
-	clks[IMX8MN_CLK_GPU_CORE_ROOT] =3D imx_clk_gate4("gpu_core_root_clk", "gp=
u_core_div", base + 0x44f0, 0);
-	clks[IMX8MN_CLK_USDHC1_ROOT] =3D imx_clk_gate4("usdhc1_root_clk", "usdhc1=
", base + 0x4510, 0);
-	clks[IMX8MN_CLK_USDHC2_ROOT] =3D imx_clk_gate4("usdhc2_root_clk", "usdhc2=
", base + 0x4520, 0);
-	clks[IMX8MN_CLK_WDOG1_ROOT] =3D imx_clk_gate4("wdog1_root_clk", "wdog", b=
ase + 0x4530, 0);
-	clks[IMX8MN_CLK_WDOG2_ROOT] =3D imx_clk_gate4("wdog2_root_clk", "wdog", b=
ase + 0x4540, 0);
-	clks[IMX8MN_CLK_WDOG3_ROOT] =3D imx_clk_gate4("wdog3_root_clk", "wdog", b=
ase + 0x4550, 0);
-	clks[IMX8MN_CLK_GPU_BUS_ROOT] =3D imx_clk_gate4("gpu_root_clk", "gpu_axi"=
, base + 0x4570, 0);
-	clks[IMX8MN_CLK_ASRC_ROOT] =3D imx_clk_gate4("asrc_root_clk", "audio_ahb"=
, base + 0x4580, 0);
-	clks[IMX8MN_CLK_PDM_ROOT] =3D imx_clk_gate2_shared2("pdm_root_clk", "pdm"=
, base + 0x45b0, 0, &share_count_pdm);
-	clks[IMX8MN_CLK_PDM_IPG]  =3D imx_clk_gate2_shared2("pdm_ipg_clk", "ipg_a=
udio_root", base + 0x45b0, 0, &share_count_pdm);
-	clks[IMX8MN_CLK_DISP_AXI_ROOT]  =3D imx_clk_gate2_shared2("disp_axi_root_=
clk", "disp_axi", base + 0x45d0, 0, &share_count_disp);
-	clks[IMX8MN_CLK_DISP_APB_ROOT]  =3D imx_clk_gate2_shared2("disp_apb_root_=
clk", "disp_apb", base + 0x45d0, 0, &share_count_disp);
-	clks[IMX8MN_CLK_CAMERA_PIXEL_ROOT] =3D imx_clk_gate2_shared2("camera_pixe=
l_clk", "camera_pixel", base + 0x45d0, 0, &share_count_disp);
-	clks[IMX8MN_CLK_DISP_PIXEL_ROOT] =3D imx_clk_gate2_shared2("disp_pixel_cl=
k", "disp_pixel", base + 0x45d0, 0, &share_count_disp);
-	clks[IMX8MN_CLK_USDHC3_ROOT] =3D imx_clk_gate4("usdhc3_root_clk", "usdhc3=
", base + 0x45e0, 0);
-	clks[IMX8MN_CLK_TMU_ROOT] =3D imx_clk_gate4("tmu_root_clk", "ipg_root", b=
ase + 0x4620, 0);
-	clks[IMX8MN_CLK_SDMA1_ROOT] =3D imx_clk_gate4("sdma1_clk", "ipg_root", ba=
se + 0x43a0, 0);
-	clks[IMX8MN_CLK_SDMA2_ROOT] =3D imx_clk_gate4("sdma2_clk", "ipg_audio_roo=
t", base + 0x43b0, 0);
-	clks[IMX8MN_CLK_SDMA3_ROOT] =3D imx_clk_gate4("sdma3_clk", "ipg_audio_roo=
t", base + 0x45f0, 0);
-	clks[IMX8MN_CLK_SAI7_ROOT] =3D imx_clk_gate2_shared2("sai7_root_clk", "sa=
i7", base + 0x4650, 0, &share_count_sai7);
-
-	clks[IMX8MN_CLK_DRAM_ALT_ROOT] =3D imx_clk_fixed_factor("dram_alt_root", =
"dram_alt", 1, 4);
-
-	clks[IMX8MN_CLK_ARM] =3D imx_clk_cpu("arm", "arm_a53_div",
-					   clks[IMX8MN_CLK_A53_DIV],
-					   clks[IMX8MN_CLK_A53_SRC],
-					   clks[IMX8MN_ARM_PLL_OUT],
-					   clks[IMX8MN_SYS_PLL1_800M]);
-
-	imx_check_clocks(clks, ARRAY_SIZE(clks));
-
-	clk_data.clks =3D clks;
-	clk_data.clk_num =3D ARRAY_SIZE(clks);
-	ret =3D of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	hws[IMX8MN_CLK_DRAM_ALT] =3D __imx8m_clk_hw_composite("dram_alt", imx8mn_=
dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
+	hws[IMX8MN_CLK_DRAM_APB] =3D __imx8m_clk_hw_composite("dram_apb", imx8mn_=
dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
+
+	hws[IMX8MN_CLK_DISP_PIXEL] =3D imx8m_clk_hw_composite("disp_pixel", imx8m=
n_disp_pixel_sels, base + 0xa500);
+	hws[IMX8MN_CLK_SAI2] =3D imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels,=
 base + 0xa600);
+	hws[IMX8MN_CLK_SAI3] =3D imx8m_clk_hw_composite("sai3", imx8mn_sai3_sels,=
 base + 0xa680);
+	hws[IMX8MN_CLK_SAI5] =3D imx8m_clk_hw_composite("sai5", imx8mn_sai5_sels,=
 base + 0xa780);
+	hws[IMX8MN_CLK_SAI6] =3D imx8m_clk_hw_composite("sai6", imx8mn_sai6_sels,=
 base + 0xa800);
+	hws[IMX8MN_CLK_SPDIF1] =3D imx8m_clk_hw_composite("spdif1", imx8mn_spdif1=
_sels, base + 0xa880);
+	hws[IMX8MN_CLK_ENET_REF] =3D imx8m_clk_hw_composite("enet_ref", imx8mn_en=
et_ref_sels, base + 0xa980);
+	hws[IMX8MN_CLK_ENET_TIMER] =3D imx8m_clk_hw_composite("enet_timer", imx8m=
n_enet_timer_sels, base + 0xaa00);
+	hws[IMX8MN_CLK_ENET_PHY_REF] =3D imx8m_clk_hw_composite("enet_phy", imx8m=
n_enet_phy_sels, base + 0xaa80);
+	hws[IMX8MN_CLK_NAND] =3D imx8m_clk_hw_composite("nand", imx8mn_nand_sels,=
 base + 0xab00);
+	hws[IMX8MN_CLK_QSPI] =3D imx8m_clk_hw_composite("qspi", imx8mn_qspi_sels,=
 base + 0xab80);
+	hws[IMX8MN_CLK_USDHC1] =3D imx8m_clk_hw_composite("usdhc1", imx8mn_usdhc1=
_sels, base + 0xac00);
+	hws[IMX8MN_CLK_USDHC2] =3D imx8m_clk_hw_composite("usdhc2", imx8mn_usdhc2=
_sels, base + 0xac80);
+	hws[IMX8MN_CLK_I2C1] =3D imx8m_clk_hw_composite("i2c1", imx8mn_i2c1_sels,=
 base + 0xad00);
+	hws[IMX8MN_CLK_I2C2] =3D imx8m_clk_hw_composite("i2c2", imx8mn_i2c2_sels,=
 base + 0xad80);
+	hws[IMX8MN_CLK_I2C3] =3D imx8m_clk_hw_composite("i2c3", imx8mn_i2c3_sels,=
 base + 0xae00);
+	hws[IMX8MN_CLK_I2C4] =3D imx8m_clk_hw_composite("i2c4", imx8mn_i2c4_sels,=
 base + 0xae80);
+	hws[IMX8MN_CLK_UART1] =3D imx8m_clk_hw_composite("uart1", imx8mn_uart1_se=
ls, base + 0xaf00);
+	hws[IMX8MN_CLK_UART2] =3D imx8m_clk_hw_composite("uart2", imx8mn_uart2_se=
ls, base + 0xaf80);
+	hws[IMX8MN_CLK_UART3] =3D imx8m_clk_hw_composite("uart3", imx8mn_uart3_se=
ls, base + 0xb000);
+	hws[IMX8MN_CLK_UART4] =3D imx8m_clk_hw_composite("uart4", imx8mn_uart4_se=
ls, base + 0xb080);
+	hws[IMX8MN_CLK_USB_CORE_REF] =3D imx8m_clk_hw_composite("usb_core_ref", i=
mx8mn_usb_core_sels, base + 0xb100);
+	hws[IMX8MN_CLK_USB_PHY_REF] =3D imx8m_clk_hw_composite("usb_phy_ref", imx=
8mn_usb_phy_sels, base + 0xb180);
+	hws[IMX8MN_CLK_GIC] =3D imx8m_clk_hw_composite_critical("gic", imx8mn_gic=
_sels, base + 0xb200);
+	hws[IMX8MN_CLK_ECSPI1] =3D imx8m_clk_hw_composite("ecspi1", imx8mn_ecspi1=
_sels, base + 0xb280);
+	hws[IMX8MN_CLK_ECSPI2] =3D imx8m_clk_hw_composite("ecspi2", imx8mn_ecspi2=
_sels, base + 0xb300);
+	hws[IMX8MN_CLK_PWM1] =3D imx8m_clk_hw_composite("pwm1", imx8mn_pwm1_sels,=
 base + 0xb380);
+	hws[IMX8MN_CLK_PWM2] =3D imx8m_clk_hw_composite("pwm2", imx8mn_pwm2_sels,=
 base + 0xb400);
+	hws[IMX8MN_CLK_PWM3] =3D imx8m_clk_hw_composite("pwm3", imx8mn_pwm3_sels,=
 base + 0xb480);
+	hws[IMX8MN_CLK_PWM4] =3D imx8m_clk_hw_composite("pwm4", imx8mn_pwm4_sels,=
 base + 0xb500);
+	hws[IMX8MN_CLK_WDOG] =3D imx8m_clk_hw_composite("wdog", imx8mn_wdog_sels,=
 base + 0xb900);
+	hws[IMX8MN_CLK_WRCLK] =3D imx8m_clk_hw_composite("wrclk", imx8mn_wrclk_se=
ls, base + 0xb980);
+	hws[IMX8MN_CLK_CLKO1] =3D imx8m_clk_hw_composite("clko1", imx8mn_clko1_se=
ls, base + 0xba00);
+	hws[IMX8MN_CLK_CLKO2] =3D imx8m_clk_hw_composite("clko2", imx8mn_clko2_se=
ls, base + 0xba80);
+	hws[IMX8MN_CLK_DSI_CORE] =3D imx8m_clk_hw_composite("dsi_core", imx8mn_ds=
i_core_sels, base + 0xbb00);
+	hws[IMX8MN_CLK_DSI_PHY_REF] =3D imx8m_clk_hw_composite("dsi_phy_ref", imx=
8mn_dsi_phy_sels, base + 0xbb80);
+	hws[IMX8MN_CLK_DSI_DBI] =3D imx8m_clk_hw_composite("dsi_dbi", imx8mn_dsi_=
dbi_sels, base + 0xbc00);
+	hws[IMX8MN_CLK_USDHC3] =3D imx8m_clk_hw_composite("usdhc3", imx8mn_usdhc3=
_sels, base + 0xbc80);
+	hws[IMX8MN_CLK_CAMERA_PIXEL] =3D imx8m_clk_hw_composite("camera_pixel", i=
mx8mn_camera_pixel_sels, base + 0xbd00);
+	hws[IMX8MN_CLK_CSI1_PHY_REF] =3D imx8m_clk_hw_composite("csi1_phy_ref", i=
mx8mn_csi1_phy_sels, base + 0xbd80);
+	hws[IMX8MN_CLK_CSI2_PHY_REF] =3D imx8m_clk_hw_composite("csi2_phy_ref", i=
mx8mn_csi2_phy_sels, base + 0xbf00);
+	hws[IMX8MN_CLK_CSI2_ESC] =3D imx8m_clk_hw_composite("csi2_esc", imx8mn_cs=
i2_esc_sels, base + 0xbf80);
+	hws[IMX8MN_CLK_ECSPI3] =3D imx8m_clk_hw_composite("ecspi3", imx8mn_ecspi3=
_sels, base + 0xc180);
+	hws[IMX8MN_CLK_PDM] =3D imx8m_clk_hw_composite("pdm", imx8mn_pdm_sels, ba=
se + 0xc200);
+	hws[IMX8MN_CLK_SAI7] =3D imx8m_clk_hw_composite("sai7", imx8mn_sai7_sels,=
 base + 0xc300);
+
+	hws[IMX8MN_CLK_ECSPI1_ROOT] =3D imx_clk_hw_gate4("ecspi1_root_clk", "ecsp=
i1", base + 0x4070, 0);
+	hws[IMX8MN_CLK_ECSPI2_ROOT] =3D imx_clk_hw_gate4("ecspi2_root_clk", "ecsp=
i2", base + 0x4080, 0);
+	hws[IMX8MN_CLK_ECSPI3_ROOT] =3D imx_clk_hw_gate4("ecspi3_root_clk", "ecsp=
i3", base + 0x4090, 0);
+	hws[IMX8MN_CLK_ENET1_ROOT] =3D imx_clk_hw_gate4("enet1_root_clk", "enet_a=
xi", base + 0x40a0, 0);
+	hws[IMX8MN_CLK_GPIO1_ROOT] =3D imx_clk_hw_gate4("gpio1_root_clk", "ipg_ro=
ot", base + 0x40b0, 0);
+	hws[IMX8MN_CLK_GPIO2_ROOT] =3D imx_clk_hw_gate4("gpio2_root_clk", "ipg_ro=
ot", base + 0x40c0, 0);
+	hws[IMX8MN_CLK_GPIO3_ROOT] =3D imx_clk_hw_gate4("gpio3_root_clk", "ipg_ro=
ot", base + 0x40d0, 0);
+	hws[IMX8MN_CLK_GPIO4_ROOT] =3D imx_clk_hw_gate4("gpio4_root_clk", "ipg_ro=
ot", base + 0x40e0, 0);
+	hws[IMX8MN_CLK_GPIO5_ROOT] =3D imx_clk_hw_gate4("gpio5_root_clk", "ipg_ro=
ot", base + 0x40f0, 0);
+	hws[IMX8MN_CLK_I2C1_ROOT] =3D imx_clk_hw_gate4("i2c1_root_clk", "i2c1", b=
ase + 0x4170, 0);
+	hws[IMX8MN_CLK_I2C2_ROOT] =3D imx_clk_hw_gate4("i2c2_root_clk", "i2c2", b=
ase + 0x4180, 0);
+	hws[IMX8MN_CLK_I2C3_ROOT] =3D imx_clk_hw_gate4("i2c3_root_clk", "i2c3", b=
ase + 0x4190, 0);
+	hws[IMX8MN_CLK_I2C4_ROOT] =3D imx_clk_hw_gate4("i2c4_root_clk", "i2c4", b=
ase + 0x41a0, 0);
+	hws[IMX8MN_CLK_MU_ROOT] =3D imx_clk_hw_gate4("mu_root_clk", "ipg_root", b=
ase + 0x4210, 0);
+	hws[IMX8MN_CLK_OCOTP_ROOT] =3D imx_clk_hw_gate4("ocotp_root_clk", "ipg_ro=
ot", base + 0x4220, 0);
+	hws[IMX8MN_CLK_PWM1_ROOT] =3D imx_clk_hw_gate4("pwm1_root_clk", "pwm1", b=
ase + 0x4280, 0);
+	hws[IMX8MN_CLK_PWM2_ROOT] =3D imx_clk_hw_gate4("pwm2_root_clk", "pwm2", b=
ase + 0x4290, 0);
+	hws[IMX8MN_CLK_PWM3_ROOT] =3D imx_clk_hw_gate4("pwm3_root_clk", "pwm3", b=
ase + 0x42a0, 0);
+	hws[IMX8MN_CLK_PWM4_ROOT] =3D imx_clk_hw_gate4("pwm4_root_clk", "pwm4", b=
ase + 0x42b0, 0);
+	hws[IMX8MN_CLK_QSPI_ROOT] =3D imx_clk_hw_gate4("qspi_root_clk", "qspi", b=
ase + 0x42f0, 0);
+	hws[IMX8MN_CLK_NAND_ROOT] =3D imx_clk_hw_gate2_shared2("nand_root_clk", "=
nand", base + 0x4300, 0, &share_count_nand);
+	hws[IMX8MN_CLK_NAND_USDHC_BUS_RAWNAND_CLK] =3D imx_clk_hw_gate2_shared2("=
nand_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_n=
and);
+	hws[IMX8MN_CLK_SAI2_ROOT] =3D imx_clk_hw_gate2_shared2("sai2_root_clk", "=
sai2", base + 0x4340, 0, &share_count_sai2);
+	hws[IMX8MN_CLK_SAI2_IPG] =3D imx_clk_hw_gate2_shared2("sai2_ipg_clk", "ip=
g_audio_root", base + 0x4340, 0, &share_count_sai2);
+	hws[IMX8MN_CLK_SAI3_ROOT] =3D imx_clk_hw_gate2_shared2("sai3_root_clk", "=
sai3", base + 0x4350, 0, &share_count_sai3);
+	hws[IMX8MN_CLK_SAI3_IPG] =3D imx_clk_hw_gate2_shared2("sai3_ipg_clk", "ip=
g_audio_root", base + 0x4350, 0, &share_count_sai3);
+	hws[IMX8MN_CLK_SAI5_ROOT] =3D imx_clk_hw_gate2_shared2("sai5_root_clk", "=
sai5", base + 0x4370, 0, &share_count_sai5);
+	hws[IMX8MN_CLK_SAI5_IPG] =3D imx_clk_hw_gate2_shared2("sai5_ipg_clk", "ip=
g_audio_root", base + 0x4370, 0, &share_count_sai5);
+	hws[IMX8MN_CLK_SAI6_ROOT] =3D imx_clk_hw_gate2_shared2("sai6_root_clk", "=
sai6", base + 0x4380, 0, &share_count_sai6);
+	hws[IMX8MN_CLK_SAI6_IPG] =3D imx_clk_hw_gate2_shared2("sai6_ipg_clk", "ip=
g_audio_root", base + 0x4380, 0, &share_count_sai6);
+	hws[IMX8MN_CLK_UART1_ROOT] =3D imx_clk_hw_gate4("uart1_root_clk", "uart1"=
, base + 0x4490, 0);
+	hws[IMX8MN_CLK_UART2_ROOT] =3D imx_clk_hw_gate4("uart2_root_clk", "uart2"=
, base + 0x44a0, 0);
+	hws[IMX8MN_CLK_UART3_ROOT] =3D imx_clk_hw_gate4("uart3_root_clk", "uart3"=
, base + 0x44b0, 0);
+	hws[IMX8MN_CLK_UART4_ROOT] =3D imx_clk_hw_gate4("uart4_root_clk", "uart4"=
, base + 0x44c0, 0);
+	hws[IMX8MN_CLK_USB1_CTRL_ROOT] =3D imx_clk_hw_gate4("usb1_ctrl_root_clk",=
 "usb_bus", base + 0x44d0, 0);
+	hws[IMX8MN_CLK_GPU_CORE_ROOT] =3D imx_clk_hw_gate4("gpu_core_root_clk", "=
gpu_core_div", base + 0x44f0, 0);
+	hws[IMX8MN_CLK_USDHC1_ROOT] =3D imx_clk_hw_gate4("usdhc1_root_clk", "usdh=
c1", base + 0x4510, 0);
+	hws[IMX8MN_CLK_USDHC2_ROOT] =3D imx_clk_hw_gate4("usdhc2_root_clk", "usdh=
c2", base + 0x4520, 0);
+	hws[IMX8MN_CLK_WDOG1_ROOT] =3D imx_clk_hw_gate4("wdog1_root_clk", "wdog",=
 base + 0x4530, 0);
+	hws[IMX8MN_CLK_WDOG2_ROOT] =3D imx_clk_hw_gate4("wdog2_root_clk", "wdog",=
 base + 0x4540, 0);
+	hws[IMX8MN_CLK_WDOG3_ROOT] =3D imx_clk_hw_gate4("wdog3_root_clk", "wdog",=
 base + 0x4550, 0);
+	hws[IMX8MN_CLK_GPU_BUS_ROOT] =3D imx_clk_hw_gate4("gpu_root_clk", "gpu_ax=
i", base + 0x4570, 0);
+	hws[IMX8MN_CLK_ASRC_ROOT] =3D imx_clk_hw_gate4("asrc_root_clk", "audio_ah=
b", base + 0x4580, 0);
+	hws[IMX8MN_CLK_PDM_ROOT] =3D imx_clk_hw_gate2_shared2("pdm_root_clk", "pd=
m", base + 0x45b0, 0, &share_count_pdm);
+	hws[IMX8MN_CLK_PDM_IPG]  =3D imx_clk_hw_gate2_shared2("pdm_ipg_clk", "ipg=
_audio_root", base + 0x45b0, 0, &share_count_pdm);
+	hws[IMX8MN_CLK_DISP_AXI_ROOT]  =3D imx_clk_hw_gate2_shared2("disp_axi_roo=
t_clk", "disp_axi", base + 0x45d0, 0, &share_count_disp);
+	hws[IMX8MN_CLK_DISP_APB_ROOT]  =3D imx_clk_hw_gate2_shared2("disp_apb_roo=
t_clk", "disp_apb", base + 0x45d0, 0, &share_count_disp);
+	hws[IMX8MN_CLK_CAMERA_PIXEL_ROOT] =3D imx_clk_hw_gate2_shared2("camera_pi=
xel_clk", "camera_pixel", base + 0x45d0, 0, &share_count_disp);
+	hws[IMX8MN_CLK_DISP_PIXEL_ROOT] =3D imx_clk_hw_gate2_shared2("disp_pixel_=
clk", "disp_pixel", base + 0x45d0, 0, &share_count_disp);
+	hws[IMX8MN_CLK_USDHC3_ROOT] =3D imx_clk_hw_gate4("usdhc3_root_clk", "usdh=
c3", base + 0x45e0, 0);
+	hws[IMX8MN_CLK_TMU_ROOT] =3D imx_clk_hw_gate4("tmu_root_clk", "ipg_root",=
 base + 0x4620, 0);
+	hws[IMX8MN_CLK_SDMA1_ROOT] =3D imx_clk_hw_gate4("sdma1_clk", "ipg_root", =
base + 0x43a0, 0);
+	hws[IMX8MN_CLK_SDMA2_ROOT] =3D imx_clk_hw_gate4("sdma2_clk", "ipg_audio_r=
oot", base + 0x43b0, 0);
+	hws[IMX8MN_CLK_SDMA3_ROOT] =3D imx_clk_hw_gate4("sdma3_clk", "ipg_audio_r=
oot", base + 0x45f0, 0);
+	hws[IMX8MN_CLK_SAI7_ROOT] =3D imx_clk_hw_gate2_shared2("sai7_root_clk", "=
sai7", base + 0x4650, 0, &share_count_sai7);
+
+	hws[IMX8MN_CLK_DRAM_ALT_ROOT] =3D imx_clk_hw_fixed_factor("dram_alt_root"=
, "dram_alt", 1, 4);
+
+	hws[IMX8MN_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
+					   hws[IMX8MN_CLK_A53_DIV]->clk,
+					   hws[IMX8MN_CLK_A53_SRC]->clk,
+					   hws[IMX8MN_ARM_PLL_OUT]->clk,
+					   hws[IMX8MN_SYS_PLL1_800M]->clk);
+
+	imx_check_clk_hws(hws, IMX8MN_CLK_END);
+
+	ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
-		dev_err(dev, "failed to register clks for i.MX8MN\n");
-		goto unregister_clks;
+		dev_err(dev, "failed to register hws for i.MX8MN\n");
+		goto unregister_hws;
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
+		int index =3D uart_clk_ids[i];
+
+		uart_hws[i] =3D &hws[index]->clk;
 	}
=20
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks(uart_hws);
=20
 	return 0;
=20
-unregister_clks:
-	imx_unregister_clocks(clks, ARRAY_SIZE(clks));
+unregister_hws:
+	imx_unregister_hw_clocks(hws, IMX8MN_CLK_END);
=20
 	return ret;
 }
--=20
2.16.4

