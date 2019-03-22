Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18483C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D7820850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ixfRiIjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCVPiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:38:08 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:8337
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbfCVPiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0bDHRvtotG6Wd63hCLw2jxFOTxRLbbsXCmBXRsb/wk=;
 b=ixfRiIjCU9NJ1Bh+BXSmDu/ek327mp/WFaMkbh3/hsTDliFB8lm+frYrDVSxn513NtTItEr8+c3AvftYP55u1DVosHTIRbrx53dekQrhvniVKUNjsXcm071sYnYCduWUIz79gi/pD8gkuR7WjrB8fp270dtmRSJD+tF4RR95pts=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4802.eurprd04.prod.outlook.com (20.176.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 15:37:22 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:22 +0000
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
Subject: [RFC 18/19] clk: imx7d: Switch to clk_hw based API
Thread-Topic: [RFC 18/19] clk: imx7d: Switch to clk_hw based API
Thread-Index: AQHU4MUkOxO6s/1wakOiE6YsWLq7dQ==
Date:   Fri, 22 Mar 2019 15:37:22 +0000
Message-ID: <1553269010-15591-19-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 62f2a073-6a40-45f1-701c-08d6aedc4688
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4802;
x-ms-traffictypediagnostic: AM0PR04MB4802:
x-microsoft-antispam-prvs: <AM0PR04MB4802F5BED4BF95C369E341C2F6430@AM0PR04MB4802.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(446003)(71190400001)(99286004)(25786009)(8676002)(478600001)(71200400001)(256004)(66066001)(305945005)(7736002)(14444005)(4326008)(14454004)(68736007)(81166006)(5660300002)(8936002)(97736004)(53936002)(81156014)(50226002)(6512007)(36756003)(53946003)(26005)(186003)(105586002)(102836004)(6436002)(30864003)(3846002)(76176011)(52116002)(106356001)(6486002)(6116002)(386003)(486006)(44832011)(86362001)(476003)(2616005)(11346002)(54906003)(2906002)(6506007)(110136005)(316002)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4802;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M+XXe3ZD1B6XZN12e/V0ogdw2kUpXRCEIBgcxMtBLKbkgA1iVKg/EWoQeROtAfpsBK4iUCUHJPZtJ2tcPQMGNNbIY+iFZiiol69KKxCQ8eLiMvnml36gQoWPG+mfSkgxiHXKmKI9EWLqx1LV8yeKY9aQFhlGQyjREL2yn2qpnRhk0B4/Tyh2cjprRtXASIq7K7W3fg+vZFMfpsVkWJwlpDUgLyhi2o/kIhpe0shb+gShmPBXpT27PoomYPXiIu4MPi+wqIVS0Uqa3nRIXofxNcSeO01dv8AWvJJFZGku+hg733EEG23DmUhYH/LEjgh0xz09XYd2SiPXAp0t73/KVDSp6b8r07dOhyo//Y3oZ5jtmNfs9NvvEsIcAhc73AtPqW45YDUDcfIquciELa5dTZAYuDzUI0ISGaKG8bpOEBw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f2a073-6a40-45f1-701c-08d6aedc4688
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:22.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the entire clk-imx7d driver to clk_hw based API.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 983 ++++++++++++++++++++++------------------=
----
 1 file changed, 499 insertions(+), 484 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index cfbd8d4..8317d2f 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -45,7 +45,6 @@ static const struct clk_div_table post_div_table[] =3D {
 	{ }
 };
=20
-static struct clk *clks[IMX7D_CLK_END];
 static const char *arm_a7_sel[] =3D { "osc", "pll_arm_main_clk",
 	"pll_enet_500m_clk", "pll_dram_main_clk",
 	"pll_sys_main_clk", "pll_sys_pfd0_392m_clk", "pll_audio_post_div",
@@ -379,517 +378,533 @@ static const char *pll_enet_bypass_sel[] =3D { "pll=
_enet_main", "pll_enet_main_src
 static const char *pll_audio_bypass_sel[] =3D { "pll_audio_main", "pll_aud=
io_main_src", };
 static const char *pll_video_bypass_sel[] =3D { "pll_video_main", "pll_vid=
eo_main_src", };
=20
-static struct clk_onecell_data clk_data;
-
-static struct clk ** const uart_clks[] __initconst =3D {
-	&clks[IMX7D_UART1_ROOT_CLK],
-	&clks[IMX7D_UART2_ROOT_CLK],
-	&clks[IMX7D_UART3_ROOT_CLK],
-	&clks[IMX7D_UART4_ROOT_CLK],
-	&clks[IMX7D_UART5_ROOT_CLK],
-	&clks[IMX7D_UART6_ROOT_CLK],
-	&clks[IMX7D_UART7_ROOT_CLK],
-	NULL
+static struct clk_hw **hws;
+static struct clk_hw_onecell_data *clk_hw_data;
+
+static const int uart_clk_ids[] __initconst =3D {
+	IMX7D_UART1_ROOT_CLK,
+	IMX7D_UART2_ROOT_CLK,
+	IMX7D_UART3_ROOT_CLK,
+	IMX7D_UART4_ROOT_CLK,
+	IMX7D_UART5_ROOT_CLK,
+	IMX7D_UART6_ROOT_CLK,
+	IMX7D_UART7_ROOT_CLK,
 };
=20
+static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
+
 static void __init imx7d_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
+	int i;
+
+	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
+					  IMX7D_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return;
+
+	clk_hw_data->num =3D IMX7D_CLK_END;
+	hws =3D clk_hw_data->hws;
=20
-	clks[IMX7D_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
-	clks[IMX7D_OSC_24M_CLK] =3D of_clk_get_by_name(ccm_node, "osc");
-	clks[IMX7D_CKIL] =3D of_clk_get_by_name(ccm_node, "ckil");
+	hws[IMX7D_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
+	hws[IMX7D_OSC_24M_CLK] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "osc=
"));
+	hws[IMX7D_CKIL] =3D __clk_get_hw(of_clk_get_by_name(ccm_node, "ckil"));
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx7d-anatop");
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
 	of_node_put(np);
=20
-	clks[IMX7D_PLL_ARM_MAIN_SRC]  =3D imx_clk_mux("pll_arm_main_src", base + =
0x60, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-	clks[IMX7D_PLL_DRAM_MAIN_SRC] =3D imx_clk_mux("pll_dram_main_src", base +=
 0x70, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-	clks[IMX7D_PLL_SYS_MAIN_SRC]  =3D imx_clk_mux("pll_sys_main_src", base + =
0xb0, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-	clks[IMX7D_PLL_ENET_MAIN_SRC] =3D imx_clk_mux("pll_enet_main_src", base +=
 0xe0, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-	clks[IMX7D_PLL_AUDIO_MAIN_SRC] =3D imx_clk_mux("pll_audio_main_src", base=
 + 0xf0, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-	clks[IMX7D_PLL_VIDEO_MAIN_SRC] =3D imx_clk_mux("pll_video_main_src", base=
 + 0x130, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-
-	clks[IMX7D_PLL_ARM_MAIN]  =3D imx_clk_pllv3(IMX_PLLV3_SYS, "pll_arm_main"=
, "osc", base + 0x60, 0x7f);
-	clks[IMX7D_PLL_DRAM_MAIN] =3D imx_clk_pllv3(IMX_PLLV3_DDR_IMX7, "pll_dram=
_main", "osc", base + 0x70, 0x7f);
-	clks[IMX7D_PLL_SYS_MAIN]  =3D imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll_sys_m=
ain", "osc", base + 0xb0, 0x1);
-	clks[IMX7D_PLL_ENET_MAIN] =3D imx_clk_pllv3(IMX_PLLV3_ENET_IMX7, "pll_ene=
t_main", "osc", base + 0xe0, 0x0);
-	clks[IMX7D_PLL_AUDIO_MAIN] =3D imx_clk_pllv3(IMX_PLLV3_AV, "pll_audio_mai=
n", "osc", base + 0xf0, 0x7f);
-	clks[IMX7D_PLL_VIDEO_MAIN] =3D imx_clk_pllv3(IMX_PLLV3_AV, "pll_video_mai=
n", "osc", base + 0x130, 0x7f);
-
-	clks[IMX7D_PLL_ARM_MAIN_BYPASS]  =3D imx_clk_mux_flags("pll_arm_main_bypa=
ss", base + 0x60, 16, 1, pll_arm_bypass_sel, ARRAY_SIZE(pll_arm_bypass_sel)=
, CLK_SET_RATE_PARENT);
-	clks[IMX7D_PLL_DRAM_MAIN_BYPASS] =3D imx_clk_mux_flags("pll_dram_main_byp=
ass", base + 0x70, 16, 1, pll_dram_bypass_sel, ARRAY_SIZE(pll_dram_bypass_s=
el), CLK_SET_RATE_PARENT);
-	clks[IMX7D_PLL_SYS_MAIN_BYPASS]  =3D imx_clk_mux_flags("pll_sys_main_bypa=
ss", base + 0xb0, 16, 1, pll_sys_bypass_sel, ARRAY_SIZE(pll_sys_bypass_sel)=
, CLK_SET_RATE_PARENT);
-	clks[IMX7D_PLL_ENET_MAIN_BYPASS] =3D imx_clk_mux_flags("pll_enet_main_byp=
ass", base + 0xe0, 16, 1, pll_enet_bypass_sel, ARRAY_SIZE(pll_enet_bypass_s=
el), CLK_SET_RATE_PARENT);
-	clks[IMX7D_PLL_AUDIO_MAIN_BYPASS] =3D imx_clk_mux_flags("pll_audio_main_b=
ypass", base + 0xf0, 16, 1, pll_audio_bypass_sel, ARRAY_SIZE(pll_audio_bypa=
ss_sel), CLK_SET_RATE_PARENT);
-	clks[IMX7D_PLL_VIDEO_MAIN_BYPASS] =3D imx_clk_mux_flags("pll_video_main_b=
ypass", base + 0x130, 16, 1, pll_video_bypass_sel, ARRAY_SIZE(pll_video_byp=
ass_sel), CLK_SET_RATE_PARENT);
-
-	clks[IMX7D_PLL_ARM_MAIN_CLK] =3D imx_clk_gate("pll_arm_main_clk", "pll_ar=
m_main_bypass", base + 0x60, 13);
-	clks[IMX7D_PLL_DRAM_MAIN_CLK] =3D imx_clk_gate("pll_dram_main_clk", "pll_=
dram_test_div", base + 0x70, 13);
-	clks[IMX7D_PLL_SYS_MAIN_CLK] =3D imx_clk_gate("pll_sys_main_clk", "pll_sy=
s_main_bypass", base + 0xb0, 13);
-	clks[IMX7D_PLL_AUDIO_MAIN_CLK] =3D imx_clk_gate("pll_audio_main_clk", "pl=
l_audio_main_bypass", base + 0xf0, 13);
-	clks[IMX7D_PLL_VIDEO_MAIN_CLK] =3D imx_clk_gate("pll_video_main_clk", "pl=
l_video_main_bypass", base + 0x130, 13);
-
-	clks[IMX7D_PLL_DRAM_TEST_DIV]  =3D clk_register_divider_table(NULL, "pll_=
dram_test_div", "pll_dram_main_bypass",
+	hws[IMX7D_PLL_ARM_MAIN_SRC]  =3D imx_clk_hw_mux("pll_arm_main_src", base =
+ 0x60, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
+	hws[IMX7D_PLL_DRAM_MAIN_SRC] =3D imx_clk_hw_mux("pll_dram_main_src", base=
 + 0x70, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
+	hws[IMX7D_PLL_SYS_MAIN_SRC]  =3D imx_clk_hw_mux("pll_sys_main_src", base =
+ 0xb0, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
+	hws[IMX7D_PLL_ENET_MAIN_SRC] =3D imx_clk_hw_mux("pll_enet_main_src", base=
 + 0xe0, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
+	hws[IMX7D_PLL_AUDIO_MAIN_SRC] =3D imx_clk_hw_mux("pll_audio_main_src", ba=
se + 0xf0, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
+	hws[IMX7D_PLL_VIDEO_MAIN_SRC] =3D imx_clk_hw_mux("pll_video_main_src", ba=
se + 0x130, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
+
+	hws[IMX7D_PLL_ARM_MAIN]  =3D imx_clk_hw_pllv3(IMX_PLLV3_SYS, "pll_arm_mai=
n", "osc", base + 0x60, 0x7f);
+	hws[IMX7D_PLL_DRAM_MAIN] =3D imx_clk_hw_pllv3(IMX_PLLV3_DDR_IMX7, "pll_dr=
am_main", "osc", base + 0x70, 0x7f);
+	hws[IMX7D_PLL_SYS_MAIN]  =3D imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll_sys=
_main", "osc", base + 0xb0, 0x1);
+	hws[IMX7D_PLL_ENET_MAIN] =3D imx_clk_hw_pllv3(IMX_PLLV3_ENET_IMX7, "pll_e=
net_main", "osc", base + 0xe0, 0x0);
+	hws[IMX7D_PLL_AUDIO_MAIN] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV, "pll_audio_m=
ain", "osc", base + 0xf0, 0x7f);
+	hws[IMX7D_PLL_VIDEO_MAIN] =3D imx_clk_hw_pllv3(IMX_PLLV3_AV, "pll_video_m=
ain", "osc", base + 0x130, 0x7f);
+
+	hws[IMX7D_PLL_ARM_MAIN_BYPASS]  =3D imx_clk_hw_mux_flags("pll_arm_main_by=
pass", base + 0x60, 16, 1, pll_arm_bypass_sel, ARRAY_SIZE(pll_arm_bypass_se=
l), CLK_SET_RATE_PARENT);
+	hws[IMX7D_PLL_DRAM_MAIN_BYPASS] =3D imx_clk_hw_mux_flags("pll_dram_main_b=
ypass", base + 0x70, 16, 1, pll_dram_bypass_sel, ARRAY_SIZE(pll_dram_bypass=
_sel), CLK_SET_RATE_PARENT);
+	hws[IMX7D_PLL_SYS_MAIN_BYPASS]  =3D imx_clk_hw_mux_flags("pll_sys_main_by=
pass", base + 0xb0, 16, 1, pll_sys_bypass_sel, ARRAY_SIZE(pll_sys_bypass_se=
l), CLK_SET_RATE_PARENT);
+	hws[IMX7D_PLL_ENET_MAIN_BYPASS] =3D imx_clk_hw_mux_flags("pll_enet_main_b=
ypass", base + 0xe0, 16, 1, pll_enet_bypass_sel, ARRAY_SIZE(pll_enet_bypass=
_sel), CLK_SET_RATE_PARENT);
+	hws[IMX7D_PLL_AUDIO_MAIN_BYPASS] =3D imx_clk_hw_mux_flags("pll_audio_main=
_bypass", base + 0xf0, 16, 1, pll_audio_bypass_sel, ARRAY_SIZE(pll_audio_by=
pass_sel), CLK_SET_RATE_PARENT);
+	hws[IMX7D_PLL_VIDEO_MAIN_BYPASS] =3D imx_clk_hw_mux_flags("pll_video_main=
_bypass", base + 0x130, 16, 1, pll_video_bypass_sel, ARRAY_SIZE(pll_video_b=
ypass_sel), CLK_SET_RATE_PARENT);
+
+	hws[IMX7D_PLL_ARM_MAIN_CLK] =3D imx_clk_hw_gate("pll_arm_main_clk", "pll_=
arm_main_bypass", base + 0x60, 13);
+	hws[IMX7D_PLL_DRAM_MAIN_CLK] =3D imx_clk_hw_gate("pll_dram_main_clk", "pl=
l_dram_test_div", base + 0x70, 13);
+	hws[IMX7D_PLL_SYS_MAIN_CLK] =3D imx_clk_hw_gate("pll_sys_main_clk", "pll_=
sys_main_bypass", base + 0xb0, 13);
+	hws[IMX7D_PLL_AUDIO_MAIN_CLK] =3D imx_clk_hw_gate("pll_audio_main_clk", "=
pll_audio_main_bypass", base + 0xf0, 13);
+	hws[IMX7D_PLL_VIDEO_MAIN_CLK] =3D imx_clk_hw_gate("pll_video_main_clk", "=
pll_video_main_bypass", base + 0x130, 13);
+
+	hws[IMX7D_PLL_DRAM_TEST_DIV]  =3D clk_hw_register_divider_table(NULL, "pl=
l_dram_test_div", "pll_dram_main_bypass",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x70, 21, 2, 0, test_d=
iv_table, &imx_ccm_lock);
-	clks[IMX7D_PLL_AUDIO_TEST_DIV]  =3D clk_register_divider_table(NULL, "pll=
_audio_test_div", "pll_audio_main_clk",
+	hws[IMX7D_PLL_AUDIO_TEST_DIV]  =3D clk_hw_register_divider_table(NULL, "p=
ll_audio_test_div", "pll_audio_main_clk",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xf0, 19, 2, 0, test_d=
iv_table, &imx_ccm_lock);
-	clks[IMX7D_PLL_AUDIO_POST_DIV] =3D clk_register_divider_table(NULL, "pll_=
audio_post_div", "pll_audio_test_div",
+	hws[IMX7D_PLL_AUDIO_POST_DIV] =3D clk_hw_register_divider_table(NULL, "pl=
l_audio_post_div", "pll_audio_test_div",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0xf0, 22, 2, 0, post_d=
iv_table, &imx_ccm_lock);
-	clks[IMX7D_PLL_VIDEO_TEST_DIV]  =3D clk_register_divider_table(NULL, "pll=
_video_test_div", "pll_video_main_clk",
+	hws[IMX7D_PLL_VIDEO_TEST_DIV]  =3D clk_hw_register_divider_table(NULL, "p=
ll_video_test_div", "pll_video_main_clk",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x130, 19, 2, 0, test_=
div_table, &imx_ccm_lock);
-	clks[IMX7D_PLL_VIDEO_POST_DIV] =3D clk_register_divider_table(NULL, "pll_=
video_post_div", "pll_video_test_div",
+	hws[IMX7D_PLL_VIDEO_POST_DIV] =3D clk_hw_register_divider_table(NULL, "pl=
l_video_post_div", "pll_video_test_div",
 				CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, base + 0x130, 22, 2, 0, post_=
div_table, &imx_ccm_lock);
=20
-	clks[IMX7D_PLL_SYS_PFD0_392M_CLK] =3D imx_clk_pfd("pll_sys_pfd0_392m_clk"=
, "pll_sys_main_clk", base + 0xc0, 0);
-	clks[IMX7D_PLL_SYS_PFD1_332M_CLK] =3D imx_clk_pfd("pll_sys_pfd1_332m_clk"=
, "pll_sys_main_clk", base + 0xc0, 1);
-	clks[IMX7D_PLL_SYS_PFD2_270M_CLK] =3D imx_clk_pfd("pll_sys_pfd2_270m_clk"=
, "pll_sys_main_clk", base + 0xc0, 2);
-
-	clks[IMX7D_PLL_SYS_PFD3_CLK] =3D imx_clk_pfd("pll_sys_pfd3_clk", "pll_sys=
_main_clk", base + 0xc0, 3);
-	clks[IMX7D_PLL_SYS_PFD4_CLK] =3D imx_clk_pfd("pll_sys_pfd4_clk", "pll_sys=
_main_clk", base + 0xd0, 0);
-	clks[IMX7D_PLL_SYS_PFD5_CLK] =3D imx_clk_pfd("pll_sys_pfd5_clk", "pll_sys=
_main_clk", base + 0xd0, 1);
-	clks[IMX7D_PLL_SYS_PFD6_CLK] =3D imx_clk_pfd("pll_sys_pfd6_clk", "pll_sys=
_main_clk", base + 0xd0, 2);
-	clks[IMX7D_PLL_SYS_PFD7_CLK] =3D imx_clk_pfd("pll_sys_pfd7_clk", "pll_sys=
_main_clk", base + 0xd0, 3);
-
-	clks[IMX7D_PLL_SYS_MAIN_480M] =3D imx_clk_fixed_factor("pll_sys_main_480m=
", "pll_sys_main_clk", 1, 1);
-	clks[IMX7D_PLL_SYS_MAIN_240M] =3D imx_clk_fixed_factor("pll_sys_main_240m=
", "pll_sys_main_clk", 1, 2);
-	clks[IMX7D_PLL_SYS_MAIN_120M] =3D imx_clk_fixed_factor("pll_sys_main_120m=
", "pll_sys_main_clk", 1, 4);
-	clks[IMX7D_PLL_DRAM_MAIN_533M] =3D imx_clk_fixed_factor("pll_dram_533m", =
"pll_dram_main_clk", 1, 2);
-
-	clks[IMX7D_PLL_SYS_MAIN_480M_CLK] =3D imx_clk_gate_dis_flags("pll_sys_mai=
n_480m_clk", "pll_sys_main_480m", base + 0xb0, 4, CLK_IS_CRITICAL);
-	clks[IMX7D_PLL_SYS_MAIN_240M_CLK] =3D imx_clk_gate_dis("pll_sys_main_240m=
_clk", "pll_sys_main_240m", base + 0xb0, 5);
-	clks[IMX7D_PLL_SYS_MAIN_120M_CLK] =3D imx_clk_gate_dis("pll_sys_main_120m=
_clk", "pll_sys_main_120m", base + 0xb0, 6);
-	clks[IMX7D_PLL_DRAM_MAIN_533M_CLK] =3D imx_clk_gate("pll_dram_533m_clk", =
"pll_dram_533m", base + 0x70, 12);
-
-	clks[IMX7D_PLL_SYS_PFD0_196M] =3D imx_clk_fixed_factor("pll_sys_pfd0_196m=
", "pll_sys_pfd0_392m_clk", 1, 2);
-	clks[IMX7D_PLL_SYS_PFD1_166M] =3D imx_clk_fixed_factor("pll_sys_pfd1_166m=
", "pll_sys_pfd1_332m_clk", 1, 2);
-	clks[IMX7D_PLL_SYS_PFD2_135M] =3D imx_clk_fixed_factor("pll_sys_pfd2_135m=
", "pll_sys_pfd2_270m_clk", 1, 2);
-
-	clks[IMX7D_PLL_SYS_PFD0_196M_CLK] =3D imx_clk_gate_dis("pll_sys_pfd0_196m=
_clk", "pll_sys_pfd0_196m", base + 0xb0, 26);
-	clks[IMX7D_PLL_SYS_PFD1_166M_CLK] =3D imx_clk_gate_dis("pll_sys_pfd1_166m=
_clk", "pll_sys_pfd1_166m", base + 0xb0, 27);
-	clks[IMX7D_PLL_SYS_PFD2_135M_CLK] =3D imx_clk_gate_dis("pll_sys_pfd2_135m=
_clk", "pll_sys_pfd2_135m", base + 0xb0, 28);
-
-	clks[IMX7D_PLL_ENET_MAIN_CLK] =3D imx_clk_fixed_factor("pll_enet_main_clk=
", "pll_enet_main_bypass", 1, 1);
-	clks[IMX7D_PLL_ENET_MAIN_500M] =3D imx_clk_fixed_factor("pll_enet_500m", =
"pll_enet_main_clk", 1, 2);
-	clks[IMX7D_PLL_ENET_MAIN_250M] =3D imx_clk_fixed_factor("pll_enet_250m", =
"pll_enet_main_clk", 1, 4);
-	clks[IMX7D_PLL_ENET_MAIN_125M] =3D imx_clk_fixed_factor("pll_enet_125m", =
"pll_enet_main_clk", 1, 8);
-	clks[IMX7D_PLL_ENET_MAIN_100M] =3D imx_clk_fixed_factor("pll_enet_100m", =
"pll_enet_main_clk", 1, 10);
-	clks[IMX7D_PLL_ENET_MAIN_50M] =3D imx_clk_fixed_factor("pll_enet_50m", "p=
ll_enet_main_clk", 1, 20);
-	clks[IMX7D_PLL_ENET_MAIN_40M] =3D imx_clk_fixed_factor("pll_enet_40m", "p=
ll_enet_main_clk", 1, 25);
-	clks[IMX7D_PLL_ENET_MAIN_25M] =3D imx_clk_fixed_factor("pll_enet_25m", "p=
ll_enet_main_clk", 1, 40);
-
-	clks[IMX7D_PLL_ENET_MAIN_500M_CLK] =3D imx_clk_gate("pll_enet_500m_clk", =
"pll_enet_500m", base + 0xe0, 12);
-	clks[IMX7D_PLL_ENET_MAIN_250M_CLK] =3D imx_clk_gate("pll_enet_250m_clk", =
"pll_enet_250m", base + 0xe0, 11);
-	clks[IMX7D_PLL_ENET_MAIN_125M_CLK] =3D imx_clk_gate("pll_enet_125m_clk", =
"pll_enet_125m", base + 0xe0, 10);
-	clks[IMX7D_PLL_ENET_MAIN_100M_CLK] =3D imx_clk_gate("pll_enet_100m_clk", =
"pll_enet_100m", base + 0xe0, 9);
-	clks[IMX7D_PLL_ENET_MAIN_50M_CLK]  =3D imx_clk_gate("pll_enet_50m_clk", "=
pll_enet_50m", base + 0xe0, 8);
-	clks[IMX7D_PLL_ENET_MAIN_40M_CLK]  =3D imx_clk_gate("pll_enet_40m_clk", "=
pll_enet_40m", base + 0xe0, 7);
-	clks[IMX7D_PLL_ENET_MAIN_25M_CLK]  =3D imx_clk_gate("pll_enet_25m_clk", "=
pll_enet_25m", base + 0xe0, 6);
-
-	clks[IMX7D_LVDS1_OUT_SEL] =3D imx_clk_mux("lvds1_sel", base + 0x170, 0, 5=
, lvds1_sel, ARRAY_SIZE(lvds1_sel));
-	clks[IMX7D_LVDS1_OUT_CLK] =3D imx_clk_gate_exclusive("lvds1_out", "lvds1_=
sel", base + 0x170, 5, BIT(6));
+	hws[IMX7D_PLL_SYS_PFD0_392M_CLK] =3D imx_clk_hw_pfd("pll_sys_pfd0_392m_cl=
k", "pll_sys_main_clk", base + 0xc0, 0);
+	hws[IMX7D_PLL_SYS_PFD1_332M_CLK] =3D imx_clk_hw_pfd("pll_sys_pfd1_332m_cl=
k", "pll_sys_main_clk", base + 0xc0, 1);
+	hws[IMX7D_PLL_SYS_PFD2_270M_CLK] =3D imx_clk_hw_pfd("pll_sys_pfd2_270m_cl=
k", "pll_sys_main_clk", base + 0xc0, 2);
+
+	hws[IMX7D_PLL_SYS_PFD3_CLK] =3D imx_clk_hw_pfd("pll_sys_pfd3_clk", "pll_s=
ys_main_clk", base + 0xc0, 3);
+	hws[IMX7D_PLL_SYS_PFD4_CLK] =3D imx_clk_hw_pfd("pll_sys_pfd4_clk", "pll_s=
ys_main_clk", base + 0xd0, 0);
+	hws[IMX7D_PLL_SYS_PFD5_CLK] =3D imx_clk_hw_pfd("pll_sys_pfd5_clk", "pll_s=
ys_main_clk", base + 0xd0, 1);
+	hws[IMX7D_PLL_SYS_PFD6_CLK] =3D imx_clk_hw_pfd("pll_sys_pfd6_clk", "pll_s=
ys_main_clk", base + 0xd0, 2);
+	hws[IMX7D_PLL_SYS_PFD7_CLK] =3D imx_clk_hw_pfd("pll_sys_pfd7_clk", "pll_s=
ys_main_clk", base + 0xd0, 3);
+
+	hws[IMX7D_PLL_SYS_MAIN_480M] =3D imx_clk_hw_fixed_factor("pll_sys_main_48=
0m", "pll_sys_main_clk", 1, 1);
+	hws[IMX7D_PLL_SYS_MAIN_240M] =3D imx_clk_hw_fixed_factor("pll_sys_main_24=
0m", "pll_sys_main_clk", 1, 2);
+	hws[IMX7D_PLL_SYS_MAIN_120M] =3D imx_clk_hw_fixed_factor("pll_sys_main_12=
0m", "pll_sys_main_clk", 1, 4);
+	hws[IMX7D_PLL_DRAM_MAIN_533M] =3D imx_clk_hw_fixed_factor("pll_dram_533m"=
, "pll_dram_main_clk", 1, 2);
+
+	hws[IMX7D_PLL_SYS_MAIN_480M_CLK] =3D imx_clk_hw_gate_dis_flags("pll_sys_m=
ain_480m_clk", "pll_sys_main_480m", base + 0xb0, 4, CLK_IS_CRITICAL);
+	hws[IMX7D_PLL_SYS_MAIN_240M_CLK] =3D imx_clk_hw_gate_dis("pll_sys_main_24=
0m_clk", "pll_sys_main_240m", base + 0xb0, 5);
+	hws[IMX7D_PLL_SYS_MAIN_120M_CLK] =3D imx_clk_hw_gate_dis("pll_sys_main_12=
0m_clk", "pll_sys_main_120m", base + 0xb0, 6);
+	hws[IMX7D_PLL_DRAM_MAIN_533M_CLK] =3D imx_clk_hw_gate("pll_dram_533m_clk"=
, "pll_dram_533m", base + 0x70, 12);
+
+	hws[IMX7D_PLL_SYS_PFD0_196M] =3D imx_clk_hw_fixed_factor("pll_sys_pfd0_19=
6m", "pll_sys_pfd0_392m_clk", 1, 2);
+	hws[IMX7D_PLL_SYS_PFD1_166M] =3D imx_clk_hw_fixed_factor("pll_sys_pfd1_16=
6m", "pll_sys_pfd1_332m_clk", 1, 2);
+	hws[IMX7D_PLL_SYS_PFD2_135M] =3D imx_clk_hw_fixed_factor("pll_sys_pfd2_13=
5m", "pll_sys_pfd2_270m_clk", 1, 2);
+
+	hws[IMX7D_PLL_SYS_PFD0_196M_CLK] =3D imx_clk_hw_gate_dis("pll_sys_pfd0_19=
6m_clk", "pll_sys_pfd0_196m", base + 0xb0, 26);
+	hws[IMX7D_PLL_SYS_PFD1_166M_CLK] =3D imx_clk_hw_gate_dis("pll_sys_pfd1_16=
6m_clk", "pll_sys_pfd1_166m", base + 0xb0, 27);
+	hws[IMX7D_PLL_SYS_PFD2_135M_CLK] =3D imx_clk_hw_gate_dis("pll_sys_pfd2_13=
5m_clk", "pll_sys_pfd2_135m", base + 0xb0, 28);
+
+	hws[IMX7D_PLL_ENET_MAIN_CLK] =3D imx_clk_hw_fixed_factor("pll_enet_main_c=
lk", "pll_enet_main_bypass", 1, 1);
+	hws[IMX7D_PLL_ENET_MAIN_500M] =3D imx_clk_hw_fixed_factor("pll_enet_500m"=
, "pll_enet_main_clk", 1, 2);
+	hws[IMX7D_PLL_ENET_MAIN_250M] =3D imx_clk_hw_fixed_factor("pll_enet_250m"=
, "pll_enet_main_clk", 1, 4);
+	hws[IMX7D_PLL_ENET_MAIN_125M] =3D imx_clk_hw_fixed_factor("pll_enet_125m"=
, "pll_enet_main_clk", 1, 8);
+	hws[IMX7D_PLL_ENET_MAIN_100M] =3D imx_clk_hw_fixed_factor("pll_enet_100m"=
, "pll_enet_main_clk", 1, 10);
+	hws[IMX7D_PLL_ENET_MAIN_50M] =3D imx_clk_hw_fixed_factor("pll_enet_50m", =
"pll_enet_main_clk", 1, 20);
+	hws[IMX7D_PLL_ENET_MAIN_40M] =3D imx_clk_hw_fixed_factor("pll_enet_40m", =
"pll_enet_main_clk", 1, 25);
+	hws[IMX7D_PLL_ENET_MAIN_25M] =3D imx_clk_hw_fixed_factor("pll_enet_25m", =
"pll_enet_main_clk", 1, 40);
+
+	hws[IMX7D_PLL_ENET_MAIN_500M_CLK] =3D imx_clk_hw_gate("pll_enet_500m_clk"=
, "pll_enet_500m", base + 0xe0, 12);
+	hws[IMX7D_PLL_ENET_MAIN_250M_CLK] =3D imx_clk_hw_gate("pll_enet_250m_clk"=
, "pll_enet_250m", base + 0xe0, 11);
+	hws[IMX7D_PLL_ENET_MAIN_125M_CLK] =3D imx_clk_hw_gate("pll_enet_125m_clk"=
, "pll_enet_125m", base + 0xe0, 10);
+	hws[IMX7D_PLL_ENET_MAIN_100M_CLK] =3D imx_clk_hw_gate("pll_enet_100m_clk"=
, "pll_enet_100m", base + 0xe0, 9);
+	hws[IMX7D_PLL_ENET_MAIN_50M_CLK]  =3D imx_clk_hw_gate("pll_enet_50m_clk",=
 "pll_enet_50m", base + 0xe0, 8);
+	hws[IMX7D_PLL_ENET_MAIN_40M_CLK]  =3D imx_clk_hw_gate("pll_enet_40m_clk",=
 "pll_enet_40m", base + 0xe0, 7);
+	hws[IMX7D_PLL_ENET_MAIN_25M_CLK]  =3D imx_clk_hw_gate("pll_enet_25m_clk",=
 "pll_enet_25m", base + 0xe0, 6);
+
+	hws[IMX7D_LVDS1_OUT_SEL] =3D imx_clk_hw_mux("lvds1_sel", base + 0x170, 0,=
 5, lvds1_sel, ARRAY_SIZE(lvds1_sel));
+	hws[IMX7D_LVDS1_OUT_CLK] =3D imx_clk_hw_gate_exclusive("lvds1_out", "lvds=
1_sel", base + 0x170, 5, BIT(6));
=20
 	np =3D ccm_node;
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
-	clks[IMX7D_ARM_A7_ROOT_SRC] =3D imx_clk_mux2("arm_a7_src", base + 0x8000,=
 24, 3, arm_a7_sel, ARRAY_SIZE(arm_a7_sel));
-	clks[IMX7D_ARM_M4_ROOT_SRC] =3D imx_clk_mux2("arm_m4_src", base + 0x8080,=
 24, 3, arm_m4_sel, ARRAY_SIZE(arm_m4_sel));
-	clks[IMX7D_MAIN_AXI_ROOT_SRC] =3D imx_clk_mux2("axi_src", base + 0x8800, =
24, 3, axi_sel, ARRAY_SIZE(axi_sel));
-	clks[IMX7D_DISP_AXI_ROOT_SRC] =3D imx_clk_mux2("disp_axi_src", base + 0x8=
880, 24, 3, disp_axi_sel, ARRAY_SIZE(disp_axi_sel));
-	clks[IMX7D_ENET_AXI_ROOT_SRC] =3D imx_clk_mux2("enet_axi_src", base + 0x8=
900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel));
-	clks[IMX7D_NAND_USDHC_BUS_ROOT_SRC] =3D imx_clk_mux2("nand_usdhc_src", ba=
se + 0x8980, 24, 3, nand_usdhc_bus_sel, ARRAY_SIZE(nand_usdhc_bus_sel));
-	clks[IMX7D_AHB_CHANNEL_ROOT_SRC] =3D imx_clk_mux2("ahb_src", base + 0x900=
0, 24, 3, ahb_channel_sel, ARRAY_SIZE(ahb_channel_sel));
-	clks[IMX7D_DRAM_PHYM_ROOT_SRC] =3D imx_clk_mux2("dram_phym_src", base + 0=
x9800, 24, 1, dram_phym_sel, ARRAY_SIZE(dram_phym_sel));
-	clks[IMX7D_DRAM_ROOT_SRC] =3D imx_clk_mux2("dram_src", base + 0x9880, 24,=
 1, dram_sel, ARRAY_SIZE(dram_sel));
-	clks[IMX7D_DRAM_PHYM_ALT_ROOT_SRC] =3D imx_clk_mux2("dram_phym_alt_src", =
base + 0xa000, 24, 3, dram_phym_alt_sel, ARRAY_SIZE(dram_phym_alt_sel));
-	clks[IMX7D_DRAM_ALT_ROOT_SRC]  =3D imx_clk_mux2("dram_alt_src", base + 0x=
a080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel));
-	clks[IMX7D_USB_HSIC_ROOT_SRC] =3D imx_clk_mux2("usb_hsic_src", base + 0xa=
100, 24, 3, usb_hsic_sel, ARRAY_SIZE(usb_hsic_sel));
-	clks[IMX7D_PCIE_CTRL_ROOT_SRC] =3D imx_clk_mux2("pcie_ctrl_src", base + 0=
xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel));
-	clks[IMX7D_PCIE_PHY_ROOT_SRC] =3D imx_clk_mux2("pcie_phy_src", base + 0xa=
200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel));
-	clks[IMX7D_EPDC_PIXEL_ROOT_SRC] =3D imx_clk_mux2("epdc_pixel_src", base +=
 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel));
-	clks[IMX7D_LCDIF_PIXEL_ROOT_SRC] =3D imx_clk_mux2("lcdif_pixel_src", base=
 + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel));
-	clks[IMX7D_MIPI_DSI_ROOT_SRC] =3D imx_clk_mux2("mipi_dsi_src", base + 0xa=
380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel));
-	clks[IMX7D_MIPI_CSI_ROOT_SRC] =3D imx_clk_mux2("mipi_csi_src", base + 0xa=
400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel));
-	clks[IMX7D_MIPI_DPHY_ROOT_SRC] =3D imx_clk_mux2("mipi_dphy_src", base + 0=
xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel));
-	clks[IMX7D_SAI1_ROOT_SRC] =3D imx_clk_mux2("sai1_src", base + 0xa500, 24,=
 3, sai1_sel, ARRAY_SIZE(sai1_sel));
-	clks[IMX7D_SAI2_ROOT_SRC] =3D imx_clk_mux2("sai2_src", base + 0xa580, 24,=
 3, sai2_sel, ARRAY_SIZE(sai2_sel));
-	clks[IMX7D_SAI3_ROOT_SRC] =3D imx_clk_mux2("sai3_src", base + 0xa600, 24,=
 3, sai3_sel, ARRAY_SIZE(sai3_sel));
-	clks[IMX7D_SPDIF_ROOT_SRC] =3D imx_clk_mux2("spdif_src", base + 0xa680, 2=
4, 3, spdif_sel, ARRAY_SIZE(spdif_sel));
-	clks[IMX7D_ENET1_REF_ROOT_SRC] =3D imx_clk_mux2("enet1_ref_src", base + 0=
xa700, 24, 3, enet1_ref_sel, ARRAY_SIZE(enet1_ref_sel));
-	clks[IMX7D_ENET1_TIME_ROOT_SRC] =3D imx_clk_mux2("enet1_time_src", base +=
 0xa780, 24, 3, enet1_time_sel, ARRAY_SIZE(enet1_time_sel));
-	clks[IMX7D_ENET2_REF_ROOT_SRC] =3D imx_clk_mux2("enet2_ref_src", base + 0=
xa800, 24, 3, enet2_ref_sel, ARRAY_SIZE(enet2_ref_sel));
-	clks[IMX7D_ENET2_TIME_ROOT_SRC] =3D imx_clk_mux2("enet2_time_src", base +=
 0xa880, 24, 3, enet2_time_sel, ARRAY_SIZE(enet2_time_sel));
-	clks[IMX7D_ENET_PHY_REF_ROOT_SRC] =3D imx_clk_mux2("enet_phy_ref_src", ba=
se + 0xa900, 24, 3, enet_phy_ref_sel, ARRAY_SIZE(enet_phy_ref_sel));
-	clks[IMX7D_EIM_ROOT_SRC] =3D imx_clk_mux2("eim_src", base + 0xa980, 24, 3=
, eim_sel, ARRAY_SIZE(eim_sel));
-	clks[IMX7D_NAND_ROOT_SRC] =3D imx_clk_mux2("nand_src", base + 0xaa00, 24,=
 3, nand_sel, ARRAY_SIZE(nand_sel));
-	clks[IMX7D_QSPI_ROOT_SRC] =3D imx_clk_mux2("qspi_src", base + 0xaa80, 24,=
 3, qspi_sel, ARRAY_SIZE(qspi_sel));
-	clks[IMX7D_USDHC1_ROOT_SRC] =3D imx_clk_mux2("usdhc1_src", base + 0xab00,=
 24, 3, usdhc1_sel, ARRAY_SIZE(usdhc1_sel));
-	clks[IMX7D_USDHC2_ROOT_SRC] =3D imx_clk_mux2("usdhc2_src", base + 0xab80,=
 24, 3, usdhc2_sel, ARRAY_SIZE(usdhc2_sel));
-	clks[IMX7D_USDHC3_ROOT_SRC] =3D imx_clk_mux2("usdhc3_src", base + 0xac00,=
 24, 3, usdhc3_sel, ARRAY_SIZE(usdhc3_sel));
-	clks[IMX7D_CAN1_ROOT_SRC] =3D imx_clk_mux2("can1_src", base + 0xac80, 24,=
 3, can1_sel, ARRAY_SIZE(can1_sel));
-	clks[IMX7D_CAN2_ROOT_SRC] =3D imx_clk_mux2("can2_src", base + 0xad00, 24,=
 3, can2_sel, ARRAY_SIZE(can2_sel));
-	clks[IMX7D_I2C1_ROOT_SRC] =3D imx_clk_mux2("i2c1_src", base + 0xad80, 24,=
 3, i2c1_sel, ARRAY_SIZE(i2c1_sel));
-	clks[IMX7D_I2C2_ROOT_SRC] =3D imx_clk_mux2("i2c2_src", base + 0xae00, 24,=
 3, i2c2_sel, ARRAY_SIZE(i2c2_sel));
-	clks[IMX7D_I2C3_ROOT_SRC] =3D imx_clk_mux2("i2c3_src", base + 0xae80, 24,=
 3, i2c3_sel, ARRAY_SIZE(i2c3_sel));
-	clks[IMX7D_I2C4_ROOT_SRC] =3D imx_clk_mux2("i2c4_src", base + 0xaf00, 24,=
 3, i2c4_sel, ARRAY_SIZE(i2c4_sel));
-	clks[IMX7D_UART1_ROOT_SRC] =3D imx_clk_mux2("uart1_src", base + 0xaf80, 2=
4, 3, uart1_sel, ARRAY_SIZE(uart1_sel));
-	clks[IMX7D_UART2_ROOT_SRC] =3D imx_clk_mux2("uart2_src", base + 0xb000, 2=
4, 3, uart2_sel, ARRAY_SIZE(uart2_sel));
-	clks[IMX7D_UART3_ROOT_SRC] =3D imx_clk_mux2("uart3_src", base + 0xb080, 2=
4, 3, uart3_sel, ARRAY_SIZE(uart3_sel));
-	clks[IMX7D_UART4_ROOT_SRC] =3D imx_clk_mux2("uart4_src", base + 0xb100, 2=
4, 3, uart4_sel, ARRAY_SIZE(uart4_sel));
-	clks[IMX7D_UART5_ROOT_SRC] =3D imx_clk_mux2("uart5_src", base + 0xb180, 2=
4, 3, uart5_sel, ARRAY_SIZE(uart5_sel));
-	clks[IMX7D_UART6_ROOT_SRC] =3D imx_clk_mux2("uart6_src", base + 0xb200, 2=
4, 3, uart6_sel, ARRAY_SIZE(uart6_sel));
-	clks[IMX7D_UART7_ROOT_SRC] =3D imx_clk_mux2("uart7_src", base + 0xb280, 2=
4, 3, uart7_sel, ARRAY_SIZE(uart7_sel));
-	clks[IMX7D_ECSPI1_ROOT_SRC] =3D imx_clk_mux2("ecspi1_src", base + 0xb300,=
 24, 3, ecspi1_sel, ARRAY_SIZE(ecspi1_sel));
-	clks[IMX7D_ECSPI2_ROOT_SRC] =3D imx_clk_mux2("ecspi2_src", base + 0xb380,=
 24, 3, ecspi2_sel, ARRAY_SIZE(ecspi2_sel));
-	clks[IMX7D_ECSPI3_ROOT_SRC] =3D imx_clk_mux2("ecspi3_src", base + 0xb400,=
 24, 3, ecspi3_sel, ARRAY_SIZE(ecspi3_sel));
-	clks[IMX7D_ECSPI4_ROOT_SRC] =3D imx_clk_mux2("ecspi4_src", base + 0xb480,=
 24, 3, ecspi4_sel, ARRAY_SIZE(ecspi4_sel));
-	clks[IMX7D_PWM1_ROOT_SRC] =3D imx_clk_mux2("pwm1_src", base + 0xb500, 24,=
 3, pwm1_sel, ARRAY_SIZE(pwm1_sel));
-	clks[IMX7D_PWM2_ROOT_SRC] =3D imx_clk_mux2("pwm2_src", base + 0xb580, 24,=
 3, pwm2_sel, ARRAY_SIZE(pwm2_sel));
-	clks[IMX7D_PWM3_ROOT_SRC] =3D imx_clk_mux2("pwm3_src", base + 0xb600, 24,=
 3, pwm3_sel, ARRAY_SIZE(pwm3_sel));
-	clks[IMX7D_PWM4_ROOT_SRC] =3D imx_clk_mux2("pwm4_src", base + 0xb680, 24,=
 3, pwm4_sel, ARRAY_SIZE(pwm4_sel));
-	clks[IMX7D_FLEXTIMER1_ROOT_SRC] =3D imx_clk_mux2("flextimer1_src", base +=
 0xb700, 24, 3, flextimer1_sel, ARRAY_SIZE(flextimer1_sel));
-	clks[IMX7D_FLEXTIMER2_ROOT_SRC] =3D imx_clk_mux2("flextimer2_src", base +=
 0xb780, 24, 3, flextimer2_sel, ARRAY_SIZE(flextimer2_sel));
-	clks[IMX7D_SIM1_ROOT_SRC] =3D imx_clk_mux2("sim1_src", base + 0xb800, 24,=
 3, sim1_sel, ARRAY_SIZE(sim1_sel));
-	clks[IMX7D_SIM2_ROOT_SRC] =3D imx_clk_mux2("sim2_src", base + 0xb880, 24,=
 3, sim2_sel, ARRAY_SIZE(sim2_sel));
-	clks[IMX7D_GPT1_ROOT_SRC] =3D imx_clk_mux2("gpt1_src", base + 0xb900, 24,=
 3, gpt1_sel, ARRAY_SIZE(gpt1_sel));
-	clks[IMX7D_GPT2_ROOT_SRC] =3D imx_clk_mux2("gpt2_src", base + 0xb980, 24,=
 3, gpt2_sel, ARRAY_SIZE(gpt2_sel));
-	clks[IMX7D_GPT3_ROOT_SRC] =3D imx_clk_mux2("gpt3_src", base + 0xba00, 24,=
 3, gpt3_sel, ARRAY_SIZE(gpt3_sel));
-	clks[IMX7D_GPT4_ROOT_SRC] =3D imx_clk_mux2("gpt4_src", base + 0xba80, 24,=
 3, gpt4_sel, ARRAY_SIZE(gpt4_sel));
-	clks[IMX7D_TRACE_ROOT_SRC] =3D imx_clk_mux2("trace_src", base + 0xbb00, 2=
4, 3, trace_sel, ARRAY_SIZE(trace_sel));
-	clks[IMX7D_WDOG_ROOT_SRC] =3D imx_clk_mux2("wdog_src", base + 0xbb80, 24,=
 3, wdog_sel, ARRAY_SIZE(wdog_sel));
-	clks[IMX7D_CSI_MCLK_ROOT_SRC] =3D imx_clk_mux2("csi_mclk_src", base + 0xb=
c00, 24, 3, csi_mclk_sel, ARRAY_SIZE(csi_mclk_sel));
-	clks[IMX7D_AUDIO_MCLK_ROOT_SRC] =3D imx_clk_mux2("audio_mclk_src", base +=
 0xbc80, 24, 3, audio_mclk_sel, ARRAY_SIZE(audio_mclk_sel));
-	clks[IMX7D_WRCLK_ROOT_SRC] =3D imx_clk_mux2("wrclk_src", base + 0xbd00, 2=
4, 3, wrclk_sel, ARRAY_SIZE(wrclk_sel));
-	clks[IMX7D_CLKO1_ROOT_SRC] =3D imx_clk_mux2("clko1_src", base + 0xbd80, 2=
4, 3, clko1_sel, ARRAY_SIZE(clko1_sel));
-	clks[IMX7D_CLKO2_ROOT_SRC] =3D imx_clk_mux2("clko2_src", base + 0xbe00, 2=
4, 3, clko2_sel, ARRAY_SIZE(clko2_sel));
-
-	clks[IMX7D_ARM_A7_ROOT_CG] =3D imx_clk_gate3("arm_a7_cg", "arm_a7_src", b=
ase + 0x8000, 28);
-	clks[IMX7D_ARM_M4_ROOT_CG] =3D imx_clk_gate3("arm_m4_cg", "arm_m4_src", b=
ase + 0x8080, 28);
-	clks[IMX7D_MAIN_AXI_ROOT_CG] =3D imx_clk_gate3("axi_cg", "axi_src", base =
+ 0x8800, 28);
-	clks[IMX7D_DISP_AXI_ROOT_CG] =3D imx_clk_gate3("disp_axi_cg", "disp_axi_s=
rc", base + 0x8880, 28);
-	clks[IMX7D_ENET_AXI_ROOT_CG] =3D imx_clk_gate3("enet_axi_cg", "enet_axi_s=
rc", base + 0x8900, 28);
-	clks[IMX7D_NAND_USDHC_BUS_ROOT_CG] =3D imx_clk_gate3("nand_usdhc_cg", "na=
nd_usdhc_src", base + 0x8980, 28);
-	clks[IMX7D_AHB_CHANNEL_ROOT_CG] =3D imx_clk_gate3("ahb_cg", "ahb_src", ba=
se + 0x9000, 28);
-	clks[IMX7D_DRAM_PHYM_ROOT_CG] =3D imx_clk_gate3("dram_phym_cg", "dram_phy=
m_src", base + 0x9800, 28);
-	clks[IMX7D_DRAM_ROOT_CG] =3D imx_clk_gate3("dram_cg", "dram_src", base + =
0x9880, 28);
-	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CG] =3D imx_clk_gate3("dram_phym_alt_cg", "=
dram_phym_alt_src", base + 0xa000, 28);
-	clks[IMX7D_DRAM_ALT_ROOT_CG] =3D imx_clk_gate3("dram_alt_cg", "dram_alt_s=
rc", base + 0xa080, 28);
-	clks[IMX7D_USB_HSIC_ROOT_CG] =3D imx_clk_gate3("usb_hsic_cg", "usb_hsic_s=
rc", base + 0xa100, 28);
-	clks[IMX7D_PCIE_CTRL_ROOT_CG] =3D imx_clk_gate3("pcie_ctrl_cg", "pcie_ctr=
l_src", base + 0xa180, 28);
-	clks[IMX7D_PCIE_PHY_ROOT_CG] =3D imx_clk_gate3("pcie_phy_cg", "pcie_phy_s=
rc", base + 0xa200, 28);
-	clks[IMX7D_EPDC_PIXEL_ROOT_CG] =3D imx_clk_gate3("epdc_pixel_cg", "epdc_p=
ixel_src", base + 0xa280, 28);
-	clks[IMX7D_LCDIF_PIXEL_ROOT_CG] =3D imx_clk_gate3("lcdif_pixel_cg", "lcdi=
f_pixel_src", base + 0xa300, 28);
-	clks[IMX7D_MIPI_DSI_ROOT_CG] =3D imx_clk_gate3("mipi_dsi_cg", "mipi_dsi_s=
rc", base + 0xa380, 28);
-	clks[IMX7D_MIPI_CSI_ROOT_CG] =3D imx_clk_gate3("mipi_csi_cg", "mipi_csi_s=
rc", base + 0xa400, 28);
-	clks[IMX7D_MIPI_DPHY_ROOT_CG] =3D imx_clk_gate3("mipi_dphy_cg", "mipi_dph=
y_src", base + 0xa480, 28);
-	clks[IMX7D_SAI1_ROOT_CG] =3D imx_clk_gate3("sai1_cg", "sai1_src", base + =
0xa500, 28);
-	clks[IMX7D_SAI2_ROOT_CG] =3D imx_clk_gate3("sai2_cg", "sai2_src", base + =
0xa580, 28);
-	clks[IMX7D_SAI3_ROOT_CG] =3D imx_clk_gate3("sai3_cg", "sai3_src", base + =
0xa600, 28);
-	clks[IMX7D_SPDIF_ROOT_CG] =3D imx_clk_gate3("spdif_cg", "spdif_src", base=
 + 0xa680, 28);
-	clks[IMX7D_ENET1_REF_ROOT_CG] =3D imx_clk_gate3("enet1_ref_cg", "enet1_re=
f_src", base + 0xa700, 28);
-	clks[IMX7D_ENET1_TIME_ROOT_CG] =3D imx_clk_gate3("enet1_time_cg", "enet1_=
time_src", base + 0xa780, 28);
-	clks[IMX7D_ENET2_REF_ROOT_CG] =3D imx_clk_gate3("enet2_ref_cg", "enet2_re=
f_src", base + 0xa800, 28);
-	clks[IMX7D_ENET2_TIME_ROOT_CG] =3D imx_clk_gate3("enet2_time_cg", "enet2_=
time_src", base + 0xa880, 28);
-	clks[IMX7D_ENET_PHY_REF_ROOT_CG] =3D imx_clk_gate3("enet_phy_ref_cg", "en=
et_phy_ref_src", base + 0xa900, 28);
-	clks[IMX7D_EIM_ROOT_CG] =3D imx_clk_gate3("eim_cg", "eim_src", base + 0xa=
980, 28);
-	clks[IMX7D_NAND_ROOT_CG] =3D imx_clk_gate3("nand_cg", "nand_src", base + =
0xaa00, 28);
-	clks[IMX7D_QSPI_ROOT_CG] =3D imx_clk_gate3("qspi_cg", "qspi_src", base + =
0xaa80, 28);
-	clks[IMX7D_USDHC1_ROOT_CG] =3D imx_clk_gate3("usdhc1_cg", "usdhc1_src", b=
ase + 0xab00, 28);
-	clks[IMX7D_USDHC2_ROOT_CG] =3D imx_clk_gate3("usdhc2_cg", "usdhc2_src", b=
ase + 0xab80, 28);
-	clks[IMX7D_USDHC3_ROOT_CG] =3D imx_clk_gate3("usdhc3_cg", "usdhc3_src", b=
ase + 0xac00, 28);
-	clks[IMX7D_CAN1_ROOT_CG] =3D imx_clk_gate3("can1_cg", "can1_src", base + =
0xac80, 28);
-	clks[IMX7D_CAN2_ROOT_CG] =3D imx_clk_gate3("can2_cg", "can2_src", base + =
0xad00, 28);
-	clks[IMX7D_I2C1_ROOT_CG] =3D imx_clk_gate3("i2c1_cg", "i2c1_src", base + =
0xad80, 28);
-	clks[IMX7D_I2C2_ROOT_CG] =3D imx_clk_gate3("i2c2_cg", "i2c2_src", base + =
0xae00, 28);
-	clks[IMX7D_I2C3_ROOT_CG] =3D imx_clk_gate3("i2c3_cg", "i2c3_src", base + =
0xae80, 28);
-	clks[IMX7D_I2C4_ROOT_CG] =3D imx_clk_gate3("i2c4_cg", "i2c4_src", base + =
0xaf00, 28);
-	clks[IMX7D_UART1_ROOT_CG] =3D imx_clk_gate3("uart1_cg", "uart1_src", base=
 + 0xaf80, 28);
-	clks[IMX7D_UART2_ROOT_CG] =3D imx_clk_gate3("uart2_cg", "uart2_src", base=
 + 0xb000, 28);
-	clks[IMX7D_UART3_ROOT_CG] =3D imx_clk_gate3("uart3_cg", "uart3_src", base=
 + 0xb080, 28);
-	clks[IMX7D_UART4_ROOT_CG] =3D imx_clk_gate3("uart4_cg", "uart4_src", base=
 + 0xb100, 28);
-	clks[IMX7D_UART5_ROOT_CG] =3D imx_clk_gate3("uart5_cg", "uart5_src", base=
 + 0xb180, 28);
-	clks[IMX7D_UART6_ROOT_CG] =3D imx_clk_gate3("uart6_cg", "uart6_src", base=
 + 0xb200, 28);
-	clks[IMX7D_UART7_ROOT_CG] =3D imx_clk_gate3("uart7_cg", "uart7_src", base=
 + 0xb280, 28);
-	clks[IMX7D_ECSPI1_ROOT_CG] =3D imx_clk_gate3("ecspi1_cg", "ecspi1_src", b=
ase + 0xb300, 28);
-	clks[IMX7D_ECSPI2_ROOT_CG] =3D imx_clk_gate3("ecspi2_cg", "ecspi2_src", b=
ase + 0xb380, 28);
-	clks[IMX7D_ECSPI3_ROOT_CG] =3D imx_clk_gate3("ecspi3_cg", "ecspi3_src", b=
ase + 0xb400, 28);
-	clks[IMX7D_ECSPI4_ROOT_CG] =3D imx_clk_gate3("ecspi4_cg", "ecspi4_src", b=
ase + 0xb480, 28);
-	clks[IMX7D_PWM1_ROOT_CG] =3D imx_clk_gate3("pwm1_cg", "pwm1_src", base + =
0xb500, 28);
-	clks[IMX7D_PWM2_ROOT_CG] =3D imx_clk_gate3("pwm2_cg", "pwm2_src", base + =
0xb580, 28);
-	clks[IMX7D_PWM3_ROOT_CG] =3D imx_clk_gate3("pwm3_cg", "pwm3_src", base + =
0xb600, 28);
-	clks[IMX7D_PWM4_ROOT_CG] =3D imx_clk_gate3("pwm4_cg", "pwm4_src", base + =
0xb680, 28);
-	clks[IMX7D_FLEXTIMER1_ROOT_CG] =3D imx_clk_gate3("flextimer1_cg", "flexti=
mer1_src", base + 0xb700, 28);
-	clks[IMX7D_FLEXTIMER2_ROOT_CG] =3D imx_clk_gate3("flextimer2_cg", "flexti=
mer2_src", base + 0xb780, 28);
-	clks[IMX7D_SIM1_ROOT_CG] =3D imx_clk_gate3("sim1_cg", "sim1_src", base + =
0xb800, 28);
-	clks[IMX7D_SIM2_ROOT_CG] =3D imx_clk_gate3("sim2_cg", "sim2_src", base + =
0xb880, 28);
-	clks[IMX7D_GPT1_ROOT_CG] =3D imx_clk_gate3("gpt1_cg", "gpt1_src", base + =
0xb900, 28);
-	clks[IMX7D_GPT2_ROOT_CG] =3D imx_clk_gate3("gpt2_cg", "gpt2_src", base + =
0xb980, 28);
-	clks[IMX7D_GPT3_ROOT_CG] =3D imx_clk_gate3("gpt3_cg", "gpt3_src", base + =
0xbA00, 28);
-	clks[IMX7D_GPT4_ROOT_CG] =3D imx_clk_gate3("gpt4_cg", "gpt4_src", base + =
0xbA80, 28);
-	clks[IMX7D_TRACE_ROOT_CG] =3D imx_clk_gate3("trace_cg", "trace_src", base=
 + 0xbb00, 28);
-	clks[IMX7D_WDOG_ROOT_CG] =3D imx_clk_gate3("wdog_cg", "wdog_src", base + =
0xbb80, 28);
-	clks[IMX7D_CSI_MCLK_ROOT_CG] =3D imx_clk_gate3("csi_mclk_cg", "csi_mclk_s=
rc", base + 0xbc00, 28);
-	clks[IMX7D_AUDIO_MCLK_ROOT_CG] =3D imx_clk_gate3("audio_mclk_cg", "audio_=
mclk_src", base + 0xbc80, 28);
-	clks[IMX7D_WRCLK_ROOT_CG] =3D imx_clk_gate3("wrclk_cg", "wrclk_src", base=
 + 0xbd00, 28);
-	clks[IMX7D_CLKO1_ROOT_CG] =3D imx_clk_gate3("clko1_cg", "clko1_src", base=
 + 0xbd80, 28);
-	clks[IMX7D_CLKO2_ROOT_CG] =3D imx_clk_gate3("clko2_cg", "clko2_src", base=
 + 0xbe00, 28);
-
-	clks[IMX7D_MAIN_AXI_ROOT_PRE_DIV] =3D imx_clk_divider2("axi_pre_div", "ax=
i_cg", base + 0x8800, 16, 3);
-	clks[IMX7D_DISP_AXI_ROOT_PRE_DIV] =3D imx_clk_divider2("disp_axi_pre_div"=
, "disp_axi_cg", base + 0x8880, 16, 3);
-	clks[IMX7D_ENET_AXI_ROOT_PRE_DIV] =3D imx_clk_divider2("enet_axi_pre_div"=
, "enet_axi_cg", base + 0x8900, 16, 3);
-	clks[IMX7D_NAND_USDHC_BUS_ROOT_PRE_DIV] =3D imx_clk_divider2("nand_usdhc_=
pre_div", "nand_usdhc_cg", base + 0x8980, 16, 3);
-	clks[IMX7D_AHB_CHANNEL_ROOT_PRE_DIV] =3D imx_clk_divider2("ahb_pre_div", =
"ahb_cg", base + 0x9000, 16, 3);
-	clks[IMX7D_DRAM_PHYM_ALT_ROOT_PRE_DIV] =3D imx_clk_divider2("dram_phym_al=
t_pre_div", "dram_phym_alt_cg", base + 0xa000, 16, 3);
-	clks[IMX7D_DRAM_ALT_ROOT_PRE_DIV] =3D imx_clk_divider2("dram_alt_pre_div"=
, "dram_alt_cg", base + 0xa080, 16, 3);
-	clks[IMX7D_USB_HSIC_ROOT_PRE_DIV] =3D imx_clk_divider2("usb_hsic_pre_div"=
, "usb_hsic_cg", base + 0xa100, 16, 3);
-	clks[IMX7D_PCIE_CTRL_ROOT_PRE_DIV] =3D imx_clk_divider2("pcie_ctrl_pre_di=
v", "pcie_ctrl_cg", base + 0xa180, 16, 3);
-	clks[IMX7D_PCIE_PHY_ROOT_PRE_DIV] =3D imx_clk_divider2("pcie_phy_pre_div"=
, "pcie_phy_cg", base + 0xa200, 16, 3);
-	clks[IMX7D_EPDC_PIXEL_ROOT_PRE_DIV] =3D imx_clk_divider2("epdc_pixel_pre_=
div", "epdc_pixel_cg", base + 0xa280, 16, 3);
-	clks[IMX7D_LCDIF_PIXEL_ROOT_PRE_DIV] =3D imx_clk_divider2("lcdif_pixel_pr=
e_div", "lcdif_pixel_cg", base + 0xa300, 16, 3);
-	clks[IMX7D_MIPI_DSI_ROOT_PRE_DIV] =3D imx_clk_divider2("mipi_dsi_pre_div"=
, "mipi_dsi_cg", base + 0xa380, 16, 3);
-	clks[IMX7D_MIPI_CSI_ROOT_PRE_DIV] =3D imx_clk_divider2("mipi_csi_pre_div"=
, "mipi_csi_cg", base + 0xa400, 16, 3);
-	clks[IMX7D_MIPI_DPHY_ROOT_PRE_DIV] =3D imx_clk_divider2("mipi_dphy_pre_di=
v", "mipi_dphy_cg", base + 0xa480, 16, 3);
-	clks[IMX7D_SAI1_ROOT_PRE_DIV] =3D imx_clk_divider2("sai1_pre_div", "sai1_=
cg", base + 0xa500, 16, 3);
-	clks[IMX7D_SAI2_ROOT_PRE_DIV] =3D imx_clk_divider2("sai2_pre_div", "sai2_=
cg", base + 0xa580, 16, 3);
-	clks[IMX7D_SAI3_ROOT_PRE_DIV] =3D imx_clk_divider2("sai3_pre_div", "sai3_=
cg", base + 0xa600, 16, 3);
-	clks[IMX7D_SPDIF_ROOT_PRE_DIV] =3D imx_clk_divider2("spdif_pre_div", "spd=
if_cg", base + 0xa680, 16, 3);
-	clks[IMX7D_ENET1_REF_ROOT_PRE_DIV] =3D imx_clk_divider2("enet1_ref_pre_di=
v", "enet1_ref_cg", base + 0xa700, 16, 3);
-	clks[IMX7D_ENET1_TIME_ROOT_PRE_DIV] =3D imx_clk_divider2("enet1_time_pre_=
div", "enet1_time_cg", base + 0xa780, 16, 3);
-	clks[IMX7D_ENET2_REF_ROOT_PRE_DIV] =3D imx_clk_divider2("enet2_ref_pre_di=
v", "enet2_ref_cg", base + 0xa800, 16, 3);
-	clks[IMX7D_ENET2_TIME_ROOT_PRE_DIV] =3D imx_clk_divider2("enet2_time_pre_=
div", "enet2_time_cg", base + 0xa880, 16, 3);
-	clks[IMX7D_ENET_PHY_REF_ROOT_PRE_DIV] =3D imx_clk_divider2("enet_phy_ref_=
pre_div", "enet_phy_ref_cg", base + 0xa900, 16, 3);
-	clks[IMX7D_EIM_ROOT_PRE_DIV] =3D imx_clk_divider2("eim_pre_div", "eim_cg"=
, base + 0xa980, 16, 3);
-	clks[IMX7D_NAND_ROOT_PRE_DIV] =3D imx_clk_divider2("nand_pre_div", "nand_=
cg", base + 0xaa00, 16, 3);
-	clks[IMX7D_QSPI_ROOT_PRE_DIV] =3D imx_clk_divider2("qspi_pre_div", "qspi_=
cg", base + 0xaa80, 16, 3);
-	clks[IMX7D_USDHC1_ROOT_PRE_DIV] =3D imx_clk_divider2("usdhc1_pre_div", "u=
sdhc1_cg", base + 0xab00, 16, 3);
-	clks[IMX7D_USDHC2_ROOT_PRE_DIV] =3D imx_clk_divider2("usdhc2_pre_div", "u=
sdhc2_cg", base + 0xab80, 16, 3);
-	clks[IMX7D_USDHC3_ROOT_PRE_DIV] =3D imx_clk_divider2("usdhc3_pre_div", "u=
sdhc3_cg", base + 0xac00, 16, 3);
-	clks[IMX7D_CAN1_ROOT_PRE_DIV] =3D imx_clk_divider2("can1_pre_div", "can1_=
cg", base + 0xac80, 16, 3);
-	clks[IMX7D_CAN2_ROOT_PRE_DIV] =3D imx_clk_divider2("can2_pre_div", "can2_=
cg", base + 0xad00, 16, 3);
-	clks[IMX7D_I2C1_ROOT_PRE_DIV] =3D imx_clk_divider2("i2c1_pre_div", "i2c1_=
cg", base + 0xad80, 16, 3);
-	clks[IMX7D_I2C2_ROOT_PRE_DIV] =3D imx_clk_divider2("i2c2_pre_div", "i2c2_=
cg", base + 0xae00, 16, 3);
-	clks[IMX7D_I2C3_ROOT_PRE_DIV] =3D imx_clk_divider2("i2c3_pre_div", "i2c3_=
cg", base + 0xae80, 16, 3);
-	clks[IMX7D_I2C4_ROOT_PRE_DIV] =3D imx_clk_divider2("i2c4_pre_div", "i2c4_=
cg", base + 0xaf00, 16, 3);
-	clks[IMX7D_UART1_ROOT_PRE_DIV] =3D imx_clk_divider2("uart1_pre_div", "uar=
t1_cg", base + 0xaf80, 16, 3);
-	clks[IMX7D_UART2_ROOT_PRE_DIV] =3D imx_clk_divider2("uart2_pre_div", "uar=
t2_cg", base + 0xb000, 16, 3);
-	clks[IMX7D_UART3_ROOT_PRE_DIV] =3D imx_clk_divider2("uart3_pre_div", "uar=
t3_cg", base + 0xb080, 16, 3);
-	clks[IMX7D_UART4_ROOT_PRE_DIV] =3D imx_clk_divider2("uart4_pre_div", "uar=
t4_cg", base + 0xb100, 16, 3);
-	clks[IMX7D_UART5_ROOT_PRE_DIV] =3D imx_clk_divider2("uart5_pre_div", "uar=
t5_cg", base + 0xb180, 16, 3);
-	clks[IMX7D_UART6_ROOT_PRE_DIV] =3D imx_clk_divider2("uart6_pre_div", "uar=
t6_cg", base + 0xb200, 16, 3);
-	clks[IMX7D_UART7_ROOT_PRE_DIV] =3D imx_clk_divider2("uart7_pre_div", "uar=
t7_cg", base + 0xb280, 16, 3);
-	clks[IMX7D_ECSPI1_ROOT_PRE_DIV] =3D imx_clk_divider2("ecspi1_pre_div", "e=
cspi1_cg", base + 0xb300, 16, 3);
-	clks[IMX7D_ECSPI2_ROOT_PRE_DIV] =3D imx_clk_divider2("ecspi2_pre_div", "e=
cspi2_cg", base + 0xb380, 16, 3);
-	clks[IMX7D_ECSPI3_ROOT_PRE_DIV] =3D imx_clk_divider2("ecspi3_pre_div", "e=
cspi3_cg", base + 0xb400, 16, 3);
-	clks[IMX7D_ECSPI4_ROOT_PRE_DIV] =3D imx_clk_divider2("ecspi4_pre_div", "e=
cspi4_cg", base + 0xb480, 16, 3);
-	clks[IMX7D_PWM1_ROOT_PRE_DIV] =3D imx_clk_divider2("pwm1_pre_div", "pwm1_=
cg", base + 0xb500, 16, 3);
-	clks[IMX7D_PWM2_ROOT_PRE_DIV] =3D imx_clk_divider2("pwm2_pre_div", "pwm2_=
cg", base + 0xb580, 16, 3);
-	clks[IMX7D_PWM3_ROOT_PRE_DIV] =3D imx_clk_divider2("pwm3_pre_div", "pwm3_=
cg", base + 0xb600, 16, 3);
-	clks[IMX7D_PWM4_ROOT_PRE_DIV] =3D imx_clk_divider2("pwm4_pre_div", "pwm4_=
cg", base + 0xb680, 16, 3);
-	clks[IMX7D_FLEXTIMER1_ROOT_PRE_DIV] =3D imx_clk_divider2("flextimer1_pre_=
div", "flextimer1_cg", base + 0xb700, 16, 3);
-	clks[IMX7D_FLEXTIMER2_ROOT_PRE_DIV] =3D imx_clk_divider2("flextimer2_pre_=
div", "flextimer2_cg", base + 0xb780, 16, 3);
-	clks[IMX7D_SIM1_ROOT_PRE_DIV] =3D imx_clk_divider2("sim1_pre_div", "sim1_=
cg", base + 0xb800, 16, 3);
-	clks[IMX7D_SIM2_ROOT_PRE_DIV] =3D imx_clk_divider2("sim2_pre_div", "sim2_=
cg", base + 0xb880, 16, 3);
-	clks[IMX7D_GPT1_ROOT_PRE_DIV] =3D imx_clk_divider2("gpt1_pre_div", "gpt1_=
cg", base + 0xb900, 16, 3);
-	clks[IMX7D_GPT2_ROOT_PRE_DIV] =3D imx_clk_divider2("gpt2_pre_div", "gpt2_=
cg", base + 0xb980, 16, 3);
-	clks[IMX7D_GPT3_ROOT_PRE_DIV] =3D imx_clk_divider2("gpt3_pre_div", "gpt3_=
cg", base + 0xba00, 16, 3);
-	clks[IMX7D_GPT4_ROOT_PRE_DIV] =3D imx_clk_divider2("gpt4_pre_div", "gpt4_=
cg", base + 0xba80, 16, 3);
-	clks[IMX7D_TRACE_ROOT_PRE_DIV] =3D imx_clk_divider2("trace_pre_div", "tra=
ce_cg", base + 0xbb00, 16, 3);
-	clks[IMX7D_WDOG_ROOT_PRE_DIV] =3D imx_clk_divider2("wdog_pre_div", "wdog_=
cg", base + 0xbb80, 16, 3);
-	clks[IMX7D_CSI_MCLK_ROOT_PRE_DIV] =3D imx_clk_divider2("csi_mclk_pre_div"=
, "csi_mclk_cg", base + 0xbc00, 16, 3);
-	clks[IMX7D_AUDIO_MCLK_ROOT_PRE_DIV] =3D imx_clk_divider2("audio_mclk_pre_=
div", "audio_mclk_cg", base + 0xbc80, 16, 3);
-	clks[IMX7D_WRCLK_ROOT_PRE_DIV] =3D imx_clk_divider2("wrclk_pre_div", "wrc=
lk_cg", base + 0xbd00, 16, 3);
-	clks[IMX7D_CLKO1_ROOT_PRE_DIV] =3D imx_clk_divider2("clko1_pre_div", "clk=
o1_cg", base + 0xbd80, 16, 3);
-	clks[IMX7D_CLKO2_ROOT_PRE_DIV] =3D imx_clk_divider2("clko2_pre_div", "clk=
o2_cg", base + 0xbe00, 16, 3);
-
-	clks[IMX7D_ARM_A7_ROOT_DIV] =3D imx_clk_divider2("arm_a7_div", "arm_a7_cg=
", base + 0x8000, 0, 3);
-	clks[IMX7D_ARM_M4_ROOT_DIV] =3D imx_clk_divider2("arm_m4_div", "arm_m4_cg=
", base + 0x8080, 0, 3);
-	clks[IMX7D_MAIN_AXI_ROOT_DIV] =3D imx_clk_divider2("axi_post_div", "axi_p=
re_div", base + 0x8800, 0, 6);
-	clks[IMX7D_DISP_AXI_ROOT_DIV] =3D imx_clk_divider2("disp_axi_post_div", "=
disp_axi_pre_div", base + 0x8880, 0, 6);
-	clks[IMX7D_ENET_AXI_ROOT_DIV] =3D imx_clk_divider2("enet_axi_post_div", "=
enet_axi_pre_div", base + 0x8900, 0, 6);
-	clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] =3D imx_clk_divider2("nand_usdhc_root=
_clk", "nand_usdhc_pre_div", base + 0x8980, 0, 6);
-	clks[IMX7D_AHB_CHANNEL_ROOT_DIV] =3D imx_clk_divider2("ahb_root_clk", "ah=
b_pre_div", base + 0x9000, 0, 6);
-	clks[IMX7D_IPG_ROOT_CLK] =3D imx_clk_divider_flags("ipg_root_clk", "ahb_r=
oot_clk", base + 0x9080, 0, 2, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE | CL=
K_SET_RATE_PARENT);
-	clks[IMX7D_DRAM_ROOT_DIV] =3D imx_clk_divider2("dram_post_div", "dram_cg"=
, base + 0x9880, 0, 3);
-	clks[IMX7D_DRAM_PHYM_ALT_ROOT_DIV] =3D imx_clk_divider2("dram_phym_alt_po=
st_div", "dram_phym_alt_pre_div", base + 0xa000, 0, 3);
-	clks[IMX7D_DRAM_ALT_ROOT_DIV] =3D imx_clk_divider2("dram_alt_post_div", "=
dram_alt_pre_div", base + 0xa080, 0, 3);
-	clks[IMX7D_USB_HSIC_ROOT_DIV] =3D imx_clk_divider2("usb_hsic_post_div", "=
usb_hsic_pre_div", base + 0xa100, 0, 6);
-	clks[IMX7D_PCIE_CTRL_ROOT_DIV] =3D imx_clk_divider2("pcie_ctrl_post_div",=
 "pcie_ctrl_pre_div", base + 0xa180, 0, 6);
-	clks[IMX7D_PCIE_PHY_ROOT_DIV] =3D imx_clk_divider2("pcie_phy_post_div", "=
pcie_phy_pre_div", base + 0xa200, 0, 6);
-	clks[IMX7D_EPDC_PIXEL_ROOT_DIV] =3D imx_clk_divider2("epdc_pixel_post_div=
", "epdc_pixel_pre_div", base + 0xa280, 0, 6);
-	clks[IMX7D_LCDIF_PIXEL_ROOT_DIV] =3D imx_clk_divider2("lcdif_pixel_post_d=
iv", "lcdif_pixel_pre_div", base + 0xa300, 0, 6);
-	clks[IMX7D_MIPI_DSI_ROOT_DIV] =3D imx_clk_divider2("mipi_dsi_post_div", "=
mipi_dsi_pre_div", base + 0xa380, 0, 6);
-	clks[IMX7D_MIPI_CSI_ROOT_DIV] =3D imx_clk_divider2("mipi_csi_post_div", "=
mipi_csi_pre_div", base + 0xa400, 0, 6);
-	clks[IMX7D_MIPI_DPHY_ROOT_DIV] =3D imx_clk_divider2("mipi_dphy_post_div",=
 "mipi_dphy_pre_div", base + 0xa480, 0, 6);
-	clks[IMX7D_SAI1_ROOT_DIV] =3D imx_clk_divider2("sai1_post_div", "sai1_pre=
_div", base + 0xa500, 0, 6);
-	clks[IMX7D_SAI2_ROOT_DIV] =3D imx_clk_divider2("sai2_post_div", "sai2_pre=
_div", base + 0xa580, 0, 6);
-	clks[IMX7D_SAI3_ROOT_DIV] =3D imx_clk_divider2("sai3_post_div", "sai3_pre=
_div", base + 0xa600, 0, 6);
-	clks[IMX7D_SPDIF_ROOT_DIV] =3D imx_clk_divider2("spdif_post_div", "spdif_=
pre_div", base + 0xa680, 0, 6);
-	clks[IMX7D_ENET1_REF_ROOT_DIV] =3D imx_clk_divider2("enet1_ref_post_div",=
 "enet1_ref_pre_div", base + 0xa700, 0, 6);
-	clks[IMX7D_ENET1_TIME_ROOT_DIV] =3D imx_clk_divider2("enet1_time_post_div=
", "enet1_time_pre_div", base + 0xa780, 0, 6);
-	clks[IMX7D_ENET2_REF_ROOT_DIV] =3D imx_clk_divider2("enet2_ref_post_div",=
 "enet2_ref_pre_div", base + 0xa800, 0, 6);
-	clks[IMX7D_ENET2_TIME_ROOT_DIV] =3D imx_clk_divider2("enet2_time_post_div=
", "enet2_time_pre_div", base + 0xa880, 0, 6);
-	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =3D imx_clk_divider2("enet_phy_ref_root=
_clk", "enet_phy_ref_pre_div", base + 0xa900, 0, 6);
-	clks[IMX7D_EIM_ROOT_DIV] =3D imx_clk_divider2("eim_post_div", "eim_pre_di=
v", base + 0xa980, 0, 6);
-	clks[IMX7D_NAND_ROOT_CLK] =3D imx_clk_divider2("nand_root_clk", "nand_pre=
_div", base + 0xaa00, 0, 6);
-	clks[IMX7D_QSPI_ROOT_DIV] =3D imx_clk_divider2("qspi_post_div", "qspi_pre=
_div", base + 0xaa80, 0, 6);
-	clks[IMX7D_USDHC1_ROOT_DIV] =3D imx_clk_divider2("usdhc1_post_div", "usdh=
c1_pre_div", base + 0xab00, 0, 6);
-	clks[IMX7D_USDHC2_ROOT_DIV] =3D imx_clk_divider2("usdhc2_post_div", "usdh=
c2_pre_div", base + 0xab80, 0, 6);
-	clks[IMX7D_USDHC3_ROOT_DIV] =3D imx_clk_divider2("usdhc3_post_div", "usdh=
c3_pre_div", base + 0xac00, 0, 6);
-	clks[IMX7D_CAN1_ROOT_DIV] =3D imx_clk_divider2("can1_post_div", "can1_pre=
_div", base + 0xac80, 0, 6);
-	clks[IMX7D_CAN2_ROOT_DIV] =3D imx_clk_divider2("can2_post_div", "can2_pre=
_div", base + 0xad00, 0, 6);
-	clks[IMX7D_I2C1_ROOT_DIV] =3D imx_clk_divider2("i2c1_post_div", "i2c1_pre=
_div", base + 0xad80, 0, 6);
-	clks[IMX7D_I2C2_ROOT_DIV] =3D imx_clk_divider2("i2c2_post_div", "i2c2_pre=
_div", base + 0xae00, 0, 6);
-	clks[IMX7D_I2C3_ROOT_DIV] =3D imx_clk_divider2("i2c3_post_div", "i2c3_pre=
_div", base + 0xae80, 0, 6);
-	clks[IMX7D_I2C4_ROOT_DIV] =3D imx_clk_divider2("i2c4_post_div", "i2c4_pre=
_div", base + 0xaf00, 0, 6);
-	clks[IMX7D_UART1_ROOT_DIV] =3D imx_clk_divider2("uart1_post_div", "uart1_=
pre_div", base + 0xaf80, 0, 6);
-	clks[IMX7D_UART2_ROOT_DIV] =3D imx_clk_divider2("uart2_post_div", "uart2_=
pre_div", base + 0xb000, 0, 6);
-	clks[IMX7D_UART3_ROOT_DIV] =3D imx_clk_divider2("uart3_post_div", "uart3_=
pre_div", base + 0xb080, 0, 6);
-	clks[IMX7D_UART4_ROOT_DIV] =3D imx_clk_divider2("uart4_post_div", "uart4_=
pre_div", base + 0xb100, 0, 6);
-	clks[IMX7D_UART5_ROOT_DIV] =3D imx_clk_divider2("uart5_post_div", "uart5_=
pre_div", base + 0xb180, 0, 6);
-	clks[IMX7D_UART6_ROOT_DIV] =3D imx_clk_divider2("uart6_post_div", "uart6_=
pre_div", base + 0xb200, 0, 6);
-	clks[IMX7D_UART7_ROOT_DIV] =3D imx_clk_divider2("uart7_post_div", "uart7_=
pre_div", base + 0xb280, 0, 6);
-	clks[IMX7D_ECSPI1_ROOT_DIV] =3D imx_clk_divider2("ecspi1_post_div", "ecsp=
i1_pre_div", base + 0xb300, 0, 6);
-	clks[IMX7D_ECSPI2_ROOT_DIV] =3D imx_clk_divider2("ecspi2_post_div", "ecsp=
i2_pre_div", base + 0xb380, 0, 6);
-	clks[IMX7D_ECSPI3_ROOT_DIV] =3D imx_clk_divider2("ecspi3_post_div", "ecsp=
i3_pre_div", base + 0xb400, 0, 6);
-	clks[IMX7D_ECSPI4_ROOT_DIV] =3D imx_clk_divider2("ecspi4_post_div", "ecsp=
i4_pre_div", base + 0xb480, 0, 6);
-	clks[IMX7D_PWM1_ROOT_DIV] =3D imx_clk_divider2("pwm1_post_div", "pwm1_pre=
_div", base + 0xb500, 0, 6);
-	clks[IMX7D_PWM2_ROOT_DIV] =3D imx_clk_divider2("pwm2_post_div", "pwm2_pre=
_div", base + 0xb580, 0, 6);
-	clks[IMX7D_PWM3_ROOT_DIV] =3D imx_clk_divider2("pwm3_post_div", "pwm3_pre=
_div", base + 0xb600, 0, 6);
-	clks[IMX7D_PWM4_ROOT_DIV] =3D imx_clk_divider2("pwm4_post_div", "pwm4_pre=
_div", base + 0xb680, 0, 6);
-	clks[IMX7D_FLEXTIMER1_ROOT_DIV] =3D imx_clk_divider2("flextimer1_post_div=
", "flextimer1_pre_div", base + 0xb700, 0, 6);
-	clks[IMX7D_FLEXTIMER2_ROOT_DIV] =3D imx_clk_divider2("flextimer2_post_div=
", "flextimer2_pre_div", base + 0xb780, 0, 6);
-	clks[IMX7D_SIM1_ROOT_DIV] =3D imx_clk_divider2("sim1_post_div", "sim1_pre=
_div", base + 0xb800, 0, 6);
-	clks[IMX7D_SIM2_ROOT_DIV] =3D imx_clk_divider2("sim2_post_div", "sim2_pre=
_div", base + 0xb880, 0, 6);
-	clks[IMX7D_GPT1_ROOT_DIV] =3D imx_clk_divider2("gpt1_post_div", "gpt1_pre=
_div", base + 0xb900, 0, 6);
-	clks[IMX7D_GPT2_ROOT_DIV] =3D imx_clk_divider2("gpt2_post_div", "gpt2_pre=
_div", base + 0xb980, 0, 6);
-	clks[IMX7D_GPT3_ROOT_DIV] =3D imx_clk_divider2("gpt3_post_div", "gpt3_pre=
_div", base + 0xba00, 0, 6);
-	clks[IMX7D_GPT4_ROOT_DIV] =3D imx_clk_divider2("gpt4_post_div", "gpt4_pre=
_div", base + 0xba80, 0, 6);
-	clks[IMX7D_TRACE_ROOT_DIV] =3D imx_clk_divider2("trace_post_div", "trace_=
pre_div", base + 0xbb00, 0, 6);
-	clks[IMX7D_WDOG_ROOT_DIV] =3D imx_clk_divider2("wdog_post_div", "wdog_pre=
_div", base + 0xbb80, 0, 6);
-	clks[IMX7D_CSI_MCLK_ROOT_DIV] =3D imx_clk_divider2("csi_mclk_post_div", "=
csi_mclk_pre_div", base + 0xbc00, 0, 6);
-	clks[IMX7D_AUDIO_MCLK_ROOT_DIV] =3D imx_clk_divider2("audio_mclk_post_div=
", "audio_mclk_pre_div", base + 0xbc80, 0, 6);
-	clks[IMX7D_WRCLK_ROOT_DIV] =3D imx_clk_divider2("wrclk_post_div", "wrclk_=
pre_div", base + 0xbd00, 0, 6);
-	clks[IMX7D_CLKO1_ROOT_DIV] =3D imx_clk_divider2("clko1_post_div", "clko1_=
pre_div", base + 0xbd80, 0, 6);
-	clks[IMX7D_CLKO2_ROOT_DIV] =3D imx_clk_divider2("clko2_post_div", "clko2_=
pre_div", base + 0xbe00, 0, 6);
-
-	clks[IMX7D_ARM_A7_ROOT_CLK] =3D imx_clk_gate2_flags("arm_a7_root_clk", "a=
rm_a7_div", base + 0x4000, 0, CLK_OPS_PARENT_ENABLE);
-	clks[IMX7D_ARM_M4_ROOT_CLK] =3D imx_clk_gate4("arm_m4_root_clk", "arm_m4_=
div", base + 0x4010, 0);
-	clks[IMX7D_MAIN_AXI_ROOT_CLK] =3D imx_clk_gate2_flags("main_axi_root_clk"=
, "axi_post_div", base + 0x4040, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE=
);
-	clks[IMX7D_DISP_AXI_ROOT_CLK] =3D imx_clk_gate4("disp_axi_root_clk", "dis=
p_axi_post_div", base + 0x4050, 0);
-	clks[IMX7D_ENET_AXI_ROOT_CLK] =3D imx_clk_gate4("enet_axi_root_clk", "ene=
t_axi_post_div", base + 0x4060, 0);
-	clks[IMX7D_OCRAM_CLK] =3D imx_clk_gate4("ocram_clk", "main_axi_root_clk",=
 base + 0x4110, 0);
-	clks[IMX7D_OCRAM_S_CLK] =3D imx_clk_gate4("ocram_s_clk", "ahb_root_clk", =
base + 0x4120, 0);
-	clks[IMX7D_DRAM_ROOT_CLK] =3D imx_clk_gate2_flags("dram_root_clk", "dram_=
post_div", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
-	clks[IMX7D_DRAM_PHYM_ROOT_CLK] =3D imx_clk_gate2_flags("dram_phym_root_cl=
k", "dram_phym_cg", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENAB=
LE);
-	clks[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] =3D imx_clk_gate2_flags("dram_phym_alt=
_root_clk", "dram_phym_alt_post_div", base + 0x4130, 0, CLK_IS_CRITICAL | C=
LK_OPS_PARENT_ENABLE);
-	clks[IMX7D_DRAM_ALT_ROOT_CLK] =3D imx_clk_gate2_flags("dram_alt_root_clk"=
, "dram_alt_post_div", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_E=
NABLE);
-	clks[IMX7D_OCOTP_CLK] =3D imx_clk_gate4("ocotp_clk", "ipg_root_clk", base=
 + 0x4230, 0);
-	clks[IMX7D_SNVS_CLK] =3D imx_clk_gate4("snvs_clk", "ipg_root_clk", base +=
 0x4250, 0);
-	clks[IMX7D_MU_ROOT_CLK] =3D imx_clk_gate4("mu_root_clk", "ipg_root_clk", =
base + 0x4270, 0);
-	clks[IMX7D_CAAM_CLK] =3D imx_clk_gate4("caam_clk", "ipg_root_clk", base +=
 0x4240, 0);
-	clks[IMX7D_USB_HSIC_ROOT_CLK] =3D imx_clk_gate4("usb_hsic_root_clk", "usb=
_hsic_post_div", base + 0x4690, 0);
-	clks[IMX7D_SDMA_CORE_CLK] =3D imx_clk_gate4("sdma_root_clk", "ahb_root_cl=
k", base + 0x4480, 0);
-	clks[IMX7D_PCIE_CTRL_ROOT_CLK] =3D imx_clk_gate4("pcie_ctrl_root_clk", "p=
cie_ctrl_post_div", base + 0x4600, 0);
-	clks[IMX7D_PCIE_PHY_ROOT_CLK] =3D imx_clk_gate4("pcie_phy_root_clk", "pci=
e_phy_post_div", base + 0x4600, 0);
-	clks[IMX7D_EPDC_PIXEL_ROOT_CLK] =3D imx_clk_gate4("epdc_pixel_root_clk", =
"epdc_pixel_post_div", base + 0x44a0, 0);
-	clks[IMX7D_LCDIF_PIXEL_ROOT_CLK] =3D imx_clk_gate4("lcdif_pixel_root_clk"=
, "lcdif_pixel_post_div", base + 0x44b0, 0);
-	clks[IMX7D_MIPI_DSI_ROOT_CLK] =3D imx_clk_gate4("mipi_dsi_root_clk", "mip=
i_dsi_post_div", base + 0x4650, 0);
-	clks[IMX7D_MIPI_CSI_ROOT_CLK] =3D imx_clk_gate4("mipi_csi_root_clk", "mip=
i_csi_post_div", base + 0x4640, 0);
-	clks[IMX7D_MIPI_DPHY_ROOT_CLK] =3D imx_clk_gate4("mipi_dphy_root_clk", "m=
ipi_dphy_post_div", base + 0x4660, 0);
-	clks[IMX7D_ENET1_IPG_ROOT_CLK] =3D imx_clk_gate2_shared2("enet1_ipg_root_=
clk", "enet_axi_post_div", base + 0x4700, 0, &share_count_enet1);
-	clks[IMX7D_ENET1_TIME_ROOT_CLK] =3D imx_clk_gate2_shared2("enet1_time_roo=
t_clk", "enet1_time_post_div", base + 0x4700, 0, &share_count_enet1);
-	clks[IMX7D_ENET2_IPG_ROOT_CLK] =3D imx_clk_gate2_shared2("enet2_ipg_root_=
clk", "enet_axi_post_div", base + 0x4710, 0, &share_count_enet2);
-	clks[IMX7D_ENET2_TIME_ROOT_CLK] =3D imx_clk_gate2_shared2("enet2_time_roo=
t_clk", "enet2_time_post_div", base + 0x4710, 0, &share_count_enet2);
-	clks[IMX7D_SAI1_ROOT_CLK] =3D imx_clk_gate2_shared2("sai1_root_clk", "sai=
1_post_div", base + 0x48c0, 0, &share_count_sai1);
-	clks[IMX7D_SAI1_IPG_CLK]  =3D imx_clk_gate2_shared2("sai1_ipg_clk",  "ipg=
_root_clk",  base + 0x48c0, 0, &share_count_sai1);
-	clks[IMX7D_SAI2_ROOT_CLK] =3D imx_clk_gate2_shared2("sai2_root_clk", "sai=
2_post_div", base + 0x48d0, 0, &share_count_sai2);
-	clks[IMX7D_SAI2_IPG_CLK]  =3D imx_clk_gate2_shared2("sai2_ipg_clk",  "ipg=
_root_clk",  base + 0x48d0, 0, &share_count_sai2);
-	clks[IMX7D_SAI3_ROOT_CLK] =3D imx_clk_gate2_shared2("sai3_root_clk", "sai=
3_post_div", base + 0x48e0, 0, &share_count_sai3);
-	clks[IMX7D_SAI3_IPG_CLK]  =3D imx_clk_gate2_shared2("sai3_ipg_clk",  "ipg=
_root_clk",  base + 0x48e0, 0, &share_count_sai3);
-	clks[IMX7D_SPDIF_ROOT_CLK] =3D imx_clk_gate4("spdif_root_clk", "spdif_pos=
t_div", base + 0x44d0, 0);
-	clks[IMX7D_EIM_ROOT_CLK] =3D imx_clk_gate4("eim_root_clk", "eim_post_div"=
, base + 0x4160, 0);
-	clks[IMX7D_NAND_RAWNAND_CLK] =3D imx_clk_gate2_shared2("nand_rawnand_clk"=
, "nand_root_clk", base + 0x4140, 0, &share_count_nand);
-	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] =3D imx_clk_gate2_shared2("nand_us=
dhc_rawnand_clk", "nand_usdhc_root_clk", base + 0x4140, 0, &share_count_nan=
d);
-	clks[IMX7D_QSPI_ROOT_CLK] =3D imx_clk_gate4("qspi_root_clk", "qspi_post_d=
iv", base + 0x4150, 0);
-	clks[IMX7D_USDHC1_ROOT_CLK] =3D imx_clk_gate4("usdhc1_root_clk", "usdhc1_=
post_div", base + 0x46c0, 0);
-	clks[IMX7D_USDHC2_ROOT_CLK] =3D imx_clk_gate4("usdhc2_root_clk", "usdhc2_=
post_div", base + 0x46d0, 0);
-	clks[IMX7D_USDHC3_ROOT_CLK] =3D imx_clk_gate4("usdhc3_root_clk", "usdhc3_=
post_div", base + 0x46e0, 0);
-	clks[IMX7D_CAN1_ROOT_CLK] =3D imx_clk_gate4("can1_root_clk", "can1_post_d=
iv", base + 0x4740, 0);
-	clks[IMX7D_CAN2_ROOT_CLK] =3D imx_clk_gate4("can2_root_clk", "can2_post_d=
iv", base + 0x4750, 0);
-	clks[IMX7D_I2C1_ROOT_CLK] =3D imx_clk_gate4("i2c1_root_clk", "i2c1_post_d=
iv", base + 0x4880, 0);
-	clks[IMX7D_I2C2_ROOT_CLK] =3D imx_clk_gate4("i2c2_root_clk", "i2c2_post_d=
iv", base + 0x4890, 0);
-	clks[IMX7D_I2C3_ROOT_CLK] =3D imx_clk_gate4("i2c3_root_clk", "i2c3_post_d=
iv", base + 0x48a0, 0);
-	clks[IMX7D_I2C4_ROOT_CLK] =3D imx_clk_gate4("i2c4_root_clk", "i2c4_post_d=
iv", base + 0x48b0, 0);
-	clks[IMX7D_UART1_ROOT_CLK] =3D imx_clk_gate4("uart1_root_clk", "uart1_pos=
t_div", base + 0x4940, 0);
-	clks[IMX7D_UART2_ROOT_CLK] =3D imx_clk_gate4("uart2_root_clk", "uart2_pos=
t_div", base + 0x4950, 0);
-	clks[IMX7D_UART3_ROOT_CLK] =3D imx_clk_gate4("uart3_root_clk", "uart3_pos=
t_div", base + 0x4960, 0);
-	clks[IMX7D_UART4_ROOT_CLK] =3D imx_clk_gate4("uart4_root_clk", "uart4_pos=
t_div", base + 0x4970, 0);
-	clks[IMX7D_UART5_ROOT_CLK] =3D imx_clk_gate4("uart5_root_clk", "uart5_pos=
t_div", base + 0x4980, 0);
-	clks[IMX7D_UART6_ROOT_CLK] =3D imx_clk_gate4("uart6_root_clk", "uart6_pos=
t_div", base + 0x4990, 0);
-	clks[IMX7D_UART7_ROOT_CLK] =3D imx_clk_gate4("uart7_root_clk", "uart7_pos=
t_div", base + 0x49a0, 0);
-	clks[IMX7D_ECSPI1_ROOT_CLK] =3D imx_clk_gate4("ecspi1_root_clk", "ecspi1_=
post_div", base + 0x4780, 0);
-	clks[IMX7D_ECSPI2_ROOT_CLK] =3D imx_clk_gate4("ecspi2_root_clk", "ecspi2_=
post_div", base + 0x4790, 0);
-	clks[IMX7D_ECSPI3_ROOT_CLK] =3D imx_clk_gate4("ecspi3_root_clk", "ecspi3_=
post_div", base + 0x47a0, 0);
-	clks[IMX7D_ECSPI4_ROOT_CLK] =3D imx_clk_gate4("ecspi4_root_clk", "ecspi4_=
post_div", base + 0x47b0, 0);
-	clks[IMX7D_PWM1_ROOT_CLK] =3D imx_clk_gate4("pwm1_root_clk", "pwm1_post_d=
iv", base + 0x4840, 0);
-	clks[IMX7D_PWM2_ROOT_CLK] =3D imx_clk_gate4("pwm2_root_clk", "pwm2_post_d=
iv", base + 0x4850, 0);
-	clks[IMX7D_PWM3_ROOT_CLK] =3D imx_clk_gate4("pwm3_root_clk", "pwm3_post_d=
iv", base + 0x4860, 0);
-	clks[IMX7D_PWM4_ROOT_CLK] =3D imx_clk_gate4("pwm4_root_clk", "pwm4_post_d=
iv", base + 0x4870, 0);
-	clks[IMX7D_FLEXTIMER1_ROOT_CLK] =3D imx_clk_gate4("flextimer1_root_clk", =
"flextimer1_post_div", base + 0x4800, 0);
-	clks[IMX7D_FLEXTIMER2_ROOT_CLK] =3D imx_clk_gate4("flextimer2_root_clk", =
"flextimer2_post_div", base + 0x4810, 0);
-	clks[IMX7D_SIM1_ROOT_CLK] =3D imx_clk_gate4("sim1_root_clk", "sim1_post_d=
iv", base + 0x4900, 0);
-	clks[IMX7D_SIM2_ROOT_CLK] =3D imx_clk_gate4("sim2_root_clk", "sim2_post_d=
iv", base + 0x4910, 0);
-	clks[IMX7D_GPT1_ROOT_CLK] =3D imx_clk_gate4("gpt1_root_clk", "gpt1_post_d=
iv", base + 0x47c0, 0);
-	clks[IMX7D_GPT2_ROOT_CLK] =3D imx_clk_gate4("gpt2_root_clk", "gpt2_post_d=
iv", base + 0x47d0, 0);
-	clks[IMX7D_GPT3_ROOT_CLK] =3D imx_clk_gate4("gpt3_root_clk", "gpt3_post_d=
iv", base + 0x47e0, 0);
-	clks[IMX7D_GPT4_ROOT_CLK] =3D imx_clk_gate4("gpt4_root_clk", "gpt4_post_d=
iv", base + 0x47f0, 0);
-	clks[IMX7D_TRACE_ROOT_CLK] =3D imx_clk_gate4("trace_root_clk", "trace_pos=
t_div", base + 0x4300, 0);
-	clks[IMX7D_WDOG1_ROOT_CLK] =3D imx_clk_gate4("wdog1_root_clk", "wdog_post=
_div", base + 0x49c0, 0);
-	clks[IMX7D_WDOG2_ROOT_CLK] =3D imx_clk_gate4("wdog2_root_clk", "wdog_post=
_div", base + 0x49d0, 0);
-	clks[IMX7D_WDOG3_ROOT_CLK] =3D imx_clk_gate4("wdog3_root_clk", "wdog_post=
_div", base + 0x49e0, 0);
-	clks[IMX7D_WDOG4_ROOT_CLK] =3D imx_clk_gate4("wdog4_root_clk", "wdog_post=
_div", base + 0x49f0, 0);
-	clks[IMX7D_KPP_ROOT_CLK] =3D imx_clk_gate4("kpp_root_clk", "ipg_root_clk"=
, base + 0x4aa0, 0);
-	clks[IMX7D_CSI_MCLK_ROOT_CLK] =3D imx_clk_gate4("csi_mclk_root_clk", "csi=
_mclk_post_div", base + 0x4490, 0);
-	clks[IMX7D_AUDIO_MCLK_ROOT_CLK] =3D imx_clk_gate4("audio_mclk_root_clk", =
"audio_mclk_post_div", base + 0x4790, 0);
-	clks[IMX7D_WRCLK_ROOT_CLK] =3D imx_clk_gate4("wrclk_root_clk", "wrclk_pos=
t_div", base + 0x47a0, 0);
-	clks[IMX7D_USB_CTRL_CLK] =3D imx_clk_gate4("usb_ctrl_clk", "ahb_root_clk"=
, base + 0x4680, 0);
-	clks[IMX7D_USB_PHY1_CLK] =3D imx_clk_gate4("usb_phy1_clk", "pll_usb1_main=
_clk", base + 0x46a0, 0);
-	clks[IMX7D_USB_PHY2_CLK] =3D imx_clk_gate4("usb_phy2_clk", "pll_usb_main_=
clk", base + 0x46b0, 0);
-	clks[IMX7D_ADC_ROOT_CLK] =3D imx_clk_gate4("adc_root_clk", "ipg_root_clk"=
, base + 0x4200, 0);
-
-	clks[IMX7D_GPT_3M_CLK] =3D imx_clk_fixed_factor("gpt_3m", "osc", 1, 8);
-
-	clks[IMX7D_CLK_ARM] =3D imx_clk_cpu("arm", "arm_a7_root_clk",
-					 clks[IMX7D_ARM_A7_ROOT_CLK],
-					 clks[IMX7D_ARM_A7_ROOT_SRC],
-					 clks[IMX7D_PLL_ARM_MAIN_CLK],
-					 clks[IMX7D_PLL_SYS_MAIN_CLK]);
-
-	imx_check_clocks(clks, ARRAY_SIZE(clks));
-
-	clk_data.clks =3D clks;
-	clk_data.clk_num =3D ARRAY_SIZE(clks);
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-
-	clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN])=
;
-	clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN=
]);
-	clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN])=
;
-	clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN=
]);
-	clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MA=
IN]);
-	clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MA=
IN]);
-
-	clk_set_parent(clks[IMX7D_MIPI_CSI_ROOT_SRC], clks[IMX7D_PLL_SYS_PFD3_CLK=
]);
+	hws[IMX7D_ARM_A7_ROOT_SRC] =3D imx_clk_hw_mux2("arm_a7_src", base + 0x800=
0, 24, 3, arm_a7_sel, ARRAY_SIZE(arm_a7_sel));
+	hws[IMX7D_ARM_M4_ROOT_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x808=
0, 24, 3, arm_m4_sel, ARRAY_SIZE(arm_m4_sel));
+	hws[IMX7D_MAIN_AXI_ROOT_SRC] =3D imx_clk_hw_mux2("axi_src", base + 0x8800=
, 24, 3, axi_sel, ARRAY_SIZE(axi_sel));
+	hws[IMX7D_DISP_AXI_ROOT_SRC] =3D imx_clk_hw_mux2("disp_axi_src", base + 0=
x8880, 24, 3, disp_axi_sel, ARRAY_SIZE(disp_axi_sel));
+	hws[IMX7D_ENET_AXI_ROOT_SRC] =3D imx_clk_hw_mux2("enet_axi_src", base + 0=
x8900, 24, 3, enet_axi_sel, ARRAY_SIZE(enet_axi_sel));
+	hws[IMX7D_NAND_USDHC_BUS_ROOT_SRC] =3D imx_clk_hw_mux2("nand_usdhc_src", =
base + 0x8980, 24, 3, nand_usdhc_bus_sel, ARRAY_SIZE(nand_usdhc_bus_sel));
+	hws[IMX7D_AHB_CHANNEL_ROOT_SRC] =3D imx_clk_hw_mux2("ahb_src", base + 0x9=
000, 24, 3, ahb_channel_sel, ARRAY_SIZE(ahb_channel_sel));
+	hws[IMX7D_DRAM_PHYM_ROOT_SRC] =3D imx_clk_hw_mux2("dram_phym_src", base +=
 0x9800, 24, 1, dram_phym_sel, ARRAY_SIZE(dram_phym_sel));
+	hws[IMX7D_DRAM_ROOT_SRC] =3D imx_clk_hw_mux2("dram_src", base + 0x9880, 2=
4, 1, dram_sel, ARRAY_SIZE(dram_sel));
+	hws[IMX7D_DRAM_PHYM_ALT_ROOT_SRC] =3D imx_clk_hw_mux2("dram_phym_alt_src"=
, base + 0xa000, 24, 3, dram_phym_alt_sel, ARRAY_SIZE(dram_phym_alt_sel));
+	hws[IMX7D_DRAM_ALT_ROOT_SRC]  =3D imx_clk_hw_mux2("dram_alt_src", base + =
0xa080, 24, 3, dram_alt_sel, ARRAY_SIZE(dram_alt_sel));
+	hws[IMX7D_USB_HSIC_ROOT_SRC] =3D imx_clk_hw_mux2("usb_hsic_src", base + 0=
xa100, 24, 3, usb_hsic_sel, ARRAY_SIZE(usb_hsic_sel));
+	hws[IMX7D_PCIE_CTRL_ROOT_SRC] =3D imx_clk_hw_mux2("pcie_ctrl_src", base +=
 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel));
+	hws[IMX7D_PCIE_PHY_ROOT_SRC] =3D imx_clk_hw_mux2("pcie_phy_src", base + 0=
xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel));
+	hws[IMX7D_EPDC_PIXEL_ROOT_SRC] =3D imx_clk_hw_mux2("epdc_pixel_src", base=
 + 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel));
+	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] =3D imx_clk_hw_mux2("lcdif_pixel_src", ba=
se + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel));
+	hws[IMX7D_MIPI_DSI_ROOT_SRC] =3D imx_clk_hw_mux2("mipi_dsi_src", base + 0=
xa380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel));
+	hws[IMX7D_MIPI_CSI_ROOT_SRC] =3D imx_clk_hw_mux2("mipi_csi_src", base + 0=
xa400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel));
+	hws[IMX7D_MIPI_DPHY_ROOT_SRC] =3D imx_clk_hw_mux2("mipi_dphy_src", base +=
 0xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel));
+	hws[IMX7D_SAI1_ROOT_SRC] =3D imx_clk_hw_mux2("sai1_src", base + 0xa500, 2=
4, 3, sai1_sel, ARRAY_SIZE(sai1_sel));
+	hws[IMX7D_SAI2_ROOT_SRC] =3D imx_clk_hw_mux2("sai2_src", base + 0xa580, 2=
4, 3, sai2_sel, ARRAY_SIZE(sai2_sel));
+	hws[IMX7D_SAI3_ROOT_SRC] =3D imx_clk_hw_mux2("sai3_src", base + 0xa600, 2=
4, 3, sai3_sel, ARRAY_SIZE(sai3_sel));
+	hws[IMX7D_SPDIF_ROOT_SRC] =3D imx_clk_hw_mux2("spdif_src", base + 0xa680,=
 24, 3, spdif_sel, ARRAY_SIZE(spdif_sel));
+	hws[IMX7D_ENET1_REF_ROOT_SRC] =3D imx_clk_hw_mux2("enet1_ref_src", base +=
 0xa700, 24, 3, enet1_ref_sel, ARRAY_SIZE(enet1_ref_sel));
+	hws[IMX7D_ENET1_TIME_ROOT_SRC] =3D imx_clk_hw_mux2("enet1_time_src", base=
 + 0xa780, 24, 3, enet1_time_sel, ARRAY_SIZE(enet1_time_sel));
+	hws[IMX7D_ENET2_REF_ROOT_SRC] =3D imx_clk_hw_mux2("enet2_ref_src", base +=
 0xa800, 24, 3, enet2_ref_sel, ARRAY_SIZE(enet2_ref_sel));
+	hws[IMX7D_ENET2_TIME_ROOT_SRC] =3D imx_clk_hw_mux2("enet2_time_src", base=
 + 0xa880, 24, 3, enet2_time_sel, ARRAY_SIZE(enet2_time_sel));
+	hws[IMX7D_ENET_PHY_REF_ROOT_SRC] =3D imx_clk_hw_mux2("enet_phy_ref_src", =
base + 0xa900, 24, 3, enet_phy_ref_sel, ARRAY_SIZE(enet_phy_ref_sel));
+	hws[IMX7D_EIM_ROOT_SRC] =3D imx_clk_hw_mux2("eim_src", base + 0xa980, 24,=
 3, eim_sel, ARRAY_SIZE(eim_sel));
+	hws[IMX7D_NAND_ROOT_SRC] =3D imx_clk_hw_mux2("nand_src", base + 0xaa00, 2=
4, 3, nand_sel, ARRAY_SIZE(nand_sel));
+	hws[IMX7D_QSPI_ROOT_SRC] =3D imx_clk_hw_mux2("qspi_src", base + 0xaa80, 2=
4, 3, qspi_sel, ARRAY_SIZE(qspi_sel));
+	hws[IMX7D_USDHC1_ROOT_SRC] =3D imx_clk_hw_mux2("usdhc1_src", base + 0xab0=
0, 24, 3, usdhc1_sel, ARRAY_SIZE(usdhc1_sel));
+	hws[IMX7D_USDHC2_ROOT_SRC] =3D imx_clk_hw_mux2("usdhc2_src", base + 0xab8=
0, 24, 3, usdhc2_sel, ARRAY_SIZE(usdhc2_sel));
+	hws[IMX7D_USDHC3_ROOT_SRC] =3D imx_clk_hw_mux2("usdhc3_src", base + 0xac0=
0, 24, 3, usdhc3_sel, ARRAY_SIZE(usdhc3_sel));
+	hws[IMX7D_CAN1_ROOT_SRC] =3D imx_clk_hw_mux2("can1_src", base + 0xac80, 2=
4, 3, can1_sel, ARRAY_SIZE(can1_sel));
+	hws[IMX7D_CAN2_ROOT_SRC] =3D imx_clk_hw_mux2("can2_src", base + 0xad00, 2=
4, 3, can2_sel, ARRAY_SIZE(can2_sel));
+	hws[IMX7D_I2C1_ROOT_SRC] =3D imx_clk_hw_mux2("i2c1_src", base + 0xad80, 2=
4, 3, i2c1_sel, ARRAY_SIZE(i2c1_sel));
+	hws[IMX7D_I2C2_ROOT_SRC] =3D imx_clk_hw_mux2("i2c2_src", base + 0xae00, 2=
4, 3, i2c2_sel, ARRAY_SIZE(i2c2_sel));
+	hws[IMX7D_I2C3_ROOT_SRC] =3D imx_clk_hw_mux2("i2c3_src", base + 0xae80, 2=
4, 3, i2c3_sel, ARRAY_SIZE(i2c3_sel));
+	hws[IMX7D_I2C4_ROOT_SRC] =3D imx_clk_hw_mux2("i2c4_src", base + 0xaf00, 2=
4, 3, i2c4_sel, ARRAY_SIZE(i2c4_sel));
+	hws[IMX7D_UART1_ROOT_SRC] =3D imx_clk_hw_mux2("uart1_src", base + 0xaf80,=
 24, 3, uart1_sel, ARRAY_SIZE(uart1_sel));
+	hws[IMX7D_UART2_ROOT_SRC] =3D imx_clk_hw_mux2("uart2_src", base + 0xb000,=
 24, 3, uart2_sel, ARRAY_SIZE(uart2_sel));
+	hws[IMX7D_UART3_ROOT_SRC] =3D imx_clk_hw_mux2("uart3_src", base + 0xb080,=
 24, 3, uart3_sel, ARRAY_SIZE(uart3_sel));
+	hws[IMX7D_UART4_ROOT_SRC] =3D imx_clk_hw_mux2("uart4_src", base + 0xb100,=
 24, 3, uart4_sel, ARRAY_SIZE(uart4_sel));
+	hws[IMX7D_UART5_ROOT_SRC] =3D imx_clk_hw_mux2("uart5_src", base + 0xb180,=
 24, 3, uart5_sel, ARRAY_SIZE(uart5_sel));
+	hws[IMX7D_UART6_ROOT_SRC] =3D imx_clk_hw_mux2("uart6_src", base + 0xb200,=
 24, 3, uart6_sel, ARRAY_SIZE(uart6_sel));
+	hws[IMX7D_UART7_ROOT_SRC] =3D imx_clk_hw_mux2("uart7_src", base + 0xb280,=
 24, 3, uart7_sel, ARRAY_SIZE(uart7_sel));
+	hws[IMX7D_ECSPI1_ROOT_SRC] =3D imx_clk_hw_mux2("ecspi1_src", base + 0xb30=
0, 24, 3, ecspi1_sel, ARRAY_SIZE(ecspi1_sel));
+	hws[IMX7D_ECSPI2_ROOT_SRC] =3D imx_clk_hw_mux2("ecspi2_src", base + 0xb38=
0, 24, 3, ecspi2_sel, ARRAY_SIZE(ecspi2_sel));
+	hws[IMX7D_ECSPI3_ROOT_SRC] =3D imx_clk_hw_mux2("ecspi3_src", base + 0xb40=
0, 24, 3, ecspi3_sel, ARRAY_SIZE(ecspi3_sel));
+	hws[IMX7D_ECSPI4_ROOT_SRC] =3D imx_clk_hw_mux2("ecspi4_src", base + 0xb48=
0, 24, 3, ecspi4_sel, ARRAY_SIZE(ecspi4_sel));
+	hws[IMX7D_PWM1_ROOT_SRC] =3D imx_clk_hw_mux2("pwm1_src", base + 0xb500, 2=
4, 3, pwm1_sel, ARRAY_SIZE(pwm1_sel));
+	hws[IMX7D_PWM2_ROOT_SRC] =3D imx_clk_hw_mux2("pwm2_src", base + 0xb580, 2=
4, 3, pwm2_sel, ARRAY_SIZE(pwm2_sel));
+	hws[IMX7D_PWM3_ROOT_SRC] =3D imx_clk_hw_mux2("pwm3_src", base + 0xb600, 2=
4, 3, pwm3_sel, ARRAY_SIZE(pwm3_sel));
+	hws[IMX7D_PWM4_ROOT_SRC] =3D imx_clk_hw_mux2("pwm4_src", base + 0xb680, 2=
4, 3, pwm4_sel, ARRAY_SIZE(pwm4_sel));
+	hws[IMX7D_FLEXTIMER1_ROOT_SRC] =3D imx_clk_hw_mux2("flextimer1_src", base=
 + 0xb700, 24, 3, flextimer1_sel, ARRAY_SIZE(flextimer1_sel));
+	hws[IMX7D_FLEXTIMER2_ROOT_SRC] =3D imx_clk_hw_mux2("flextimer2_src", base=
 + 0xb780, 24, 3, flextimer2_sel, ARRAY_SIZE(flextimer2_sel));
+	hws[IMX7D_SIM1_ROOT_SRC] =3D imx_clk_hw_mux2("sim1_src", base + 0xb800, 2=
4, 3, sim1_sel, ARRAY_SIZE(sim1_sel));
+	hws[IMX7D_SIM2_ROOT_SRC] =3D imx_clk_hw_mux2("sim2_src", base + 0xb880, 2=
4, 3, sim2_sel, ARRAY_SIZE(sim2_sel));
+	hws[IMX7D_GPT1_ROOT_SRC] =3D imx_clk_hw_mux2("gpt1_src", base + 0xb900, 2=
4, 3, gpt1_sel, ARRAY_SIZE(gpt1_sel));
+	hws[IMX7D_GPT2_ROOT_SRC] =3D imx_clk_hw_mux2("gpt2_src", base + 0xb980, 2=
4, 3, gpt2_sel, ARRAY_SIZE(gpt2_sel));
+	hws[IMX7D_GPT3_ROOT_SRC] =3D imx_clk_hw_mux2("gpt3_src", base + 0xba00, 2=
4, 3, gpt3_sel, ARRAY_SIZE(gpt3_sel));
+	hws[IMX7D_GPT4_ROOT_SRC] =3D imx_clk_hw_mux2("gpt4_src", base + 0xba80, 2=
4, 3, gpt4_sel, ARRAY_SIZE(gpt4_sel));
+	hws[IMX7D_TRACE_ROOT_SRC] =3D imx_clk_hw_mux2("trace_src", base + 0xbb00,=
 24, 3, trace_sel, ARRAY_SIZE(trace_sel));
+	hws[IMX7D_WDOG_ROOT_SRC] =3D imx_clk_hw_mux2("wdog_src", base + 0xbb80, 2=
4, 3, wdog_sel, ARRAY_SIZE(wdog_sel));
+	hws[IMX7D_CSI_MCLK_ROOT_SRC] =3D imx_clk_hw_mux2("csi_mclk_src", base + 0=
xbc00, 24, 3, csi_mclk_sel, ARRAY_SIZE(csi_mclk_sel));
+	hws[IMX7D_AUDIO_MCLK_ROOT_SRC] =3D imx_clk_hw_mux2("audio_mclk_src", base=
 + 0xbc80, 24, 3, audio_mclk_sel, ARRAY_SIZE(audio_mclk_sel));
+	hws[IMX7D_WRCLK_ROOT_SRC] =3D imx_clk_hw_mux2("wrclk_src", base + 0xbd00,=
 24, 3, wrclk_sel, ARRAY_SIZE(wrclk_sel));
+	hws[IMX7D_CLKO1_ROOT_SRC] =3D imx_clk_hw_mux2("clko1_src", base + 0xbd80,=
 24, 3, clko1_sel, ARRAY_SIZE(clko1_sel));
+	hws[IMX7D_CLKO2_ROOT_SRC] =3D imx_clk_hw_mux2("clko2_src", base + 0xbe00,=
 24, 3, clko2_sel, ARRAY_SIZE(clko2_sel));
+
+	hws[IMX7D_ARM_A7_ROOT_CG] =3D imx_clk_hw_gate3("arm_a7_cg", "arm_a7_src",=
 base + 0x8000, 28);
+	hws[IMX7D_ARM_M4_ROOT_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src",=
 base + 0x8080, 28);
+	hws[IMX7D_MAIN_AXI_ROOT_CG] =3D imx_clk_hw_gate3("axi_cg", "axi_src", bas=
e + 0x8800, 28);
+	hws[IMX7D_DISP_AXI_ROOT_CG] =3D imx_clk_hw_gate3("disp_axi_cg", "disp_axi=
_src", base + 0x8880, 28);
+	hws[IMX7D_ENET_AXI_ROOT_CG] =3D imx_clk_hw_gate3("enet_axi_cg", "enet_axi=
_src", base + 0x8900, 28);
+	hws[IMX7D_NAND_USDHC_BUS_ROOT_CG] =3D imx_clk_hw_gate3("nand_usdhc_cg", "=
nand_usdhc_src", base + 0x8980, 28);
+	hws[IMX7D_AHB_CHANNEL_ROOT_CG] =3D imx_clk_hw_gate3("ahb_cg", "ahb_src", =
base + 0x9000, 28);
+	hws[IMX7D_DRAM_PHYM_ROOT_CG] =3D imx_clk_hw_gate3("dram_phym_cg", "dram_p=
hym_src", base + 0x9800, 28);
+	hws[IMX7D_DRAM_ROOT_CG] =3D imx_clk_hw_gate3("dram_cg", "dram_src", base =
+ 0x9880, 28);
+	hws[IMX7D_DRAM_PHYM_ALT_ROOT_CG] =3D imx_clk_hw_gate3("dram_phym_alt_cg",=
 "dram_phym_alt_src", base + 0xa000, 28);
+	hws[IMX7D_DRAM_ALT_ROOT_CG] =3D imx_clk_hw_gate3("dram_alt_cg", "dram_alt=
_src", base + 0xa080, 28);
+	hws[IMX7D_USB_HSIC_ROOT_CG] =3D imx_clk_hw_gate3("usb_hsic_cg", "usb_hsic=
_src", base + 0xa100, 28);
+	hws[IMX7D_PCIE_CTRL_ROOT_CG] =3D imx_clk_hw_gate3("pcie_ctrl_cg", "pcie_c=
trl_src", base + 0xa180, 28);
+	hws[IMX7D_PCIE_PHY_ROOT_CG] =3D imx_clk_hw_gate3("pcie_phy_cg", "pcie_phy=
_src", base + 0xa200, 28);
+	hws[IMX7D_EPDC_PIXEL_ROOT_CG] =3D imx_clk_hw_gate3("epdc_pixel_cg", "epdc=
_pixel_src", base + 0xa280, 28);
+	hws[IMX7D_LCDIF_PIXEL_ROOT_CG] =3D imx_clk_hw_gate3("lcdif_pixel_cg", "lc=
dif_pixel_src", base + 0xa300, 28);
+	hws[IMX7D_MIPI_DSI_ROOT_CG] =3D imx_clk_hw_gate3("mipi_dsi_cg", "mipi_dsi=
_src", base + 0xa380, 28);
+	hws[IMX7D_MIPI_CSI_ROOT_CG] =3D imx_clk_hw_gate3("mipi_csi_cg", "mipi_csi=
_src", base + 0xa400, 28);
+	hws[IMX7D_MIPI_DPHY_ROOT_CG] =3D imx_clk_hw_gate3("mipi_dphy_cg", "mipi_d=
phy_src", base + 0xa480, 28);
+	hws[IMX7D_SAI1_ROOT_CG] =3D imx_clk_hw_gate3("sai1_cg", "sai1_src", base =
+ 0xa500, 28);
+	hws[IMX7D_SAI2_ROOT_CG] =3D imx_clk_hw_gate3("sai2_cg", "sai2_src", base =
+ 0xa580, 28);
+	hws[IMX7D_SAI3_ROOT_CG] =3D imx_clk_hw_gate3("sai3_cg", "sai3_src", base =
+ 0xa600, 28);
+	hws[IMX7D_SPDIF_ROOT_CG] =3D imx_clk_hw_gate3("spdif_cg", "spdif_src", ba=
se + 0xa680, 28);
+	hws[IMX7D_ENET1_REF_ROOT_CG] =3D imx_clk_hw_gate3("enet1_ref_cg", "enet1_=
ref_src", base + 0xa700, 28);
+	hws[IMX7D_ENET1_TIME_ROOT_CG] =3D imx_clk_hw_gate3("enet1_time_cg", "enet=
1_time_src", base + 0xa780, 28);
+	hws[IMX7D_ENET2_REF_ROOT_CG] =3D imx_clk_hw_gate3("enet2_ref_cg", "enet2_=
ref_src", base + 0xa800, 28);
+	hws[IMX7D_ENET2_TIME_ROOT_CG] =3D imx_clk_hw_gate3("enet2_time_cg", "enet=
2_time_src", base + 0xa880, 28);
+	hws[IMX7D_ENET_PHY_REF_ROOT_CG] =3D imx_clk_hw_gate3("enet_phy_ref_cg", "=
enet_phy_ref_src", base + 0xa900, 28);
+	hws[IMX7D_EIM_ROOT_CG] =3D imx_clk_hw_gate3("eim_cg", "eim_src", base + 0=
xa980, 28);
+	hws[IMX7D_NAND_ROOT_CG] =3D imx_clk_hw_gate3("nand_cg", "nand_src", base =
+ 0xaa00, 28);
+	hws[IMX7D_QSPI_ROOT_CG] =3D imx_clk_hw_gate3("qspi_cg", "qspi_src", base =
+ 0xaa80, 28);
+	hws[IMX7D_USDHC1_ROOT_CG] =3D imx_clk_hw_gate3("usdhc1_cg", "usdhc1_src",=
 base + 0xab00, 28);
+	hws[IMX7D_USDHC2_ROOT_CG] =3D imx_clk_hw_gate3("usdhc2_cg", "usdhc2_src",=
 base + 0xab80, 28);
+	hws[IMX7D_USDHC3_ROOT_CG] =3D imx_clk_hw_gate3("usdhc3_cg", "usdhc3_src",=
 base + 0xac00, 28);
+	hws[IMX7D_CAN1_ROOT_CG] =3D imx_clk_hw_gate3("can1_cg", "can1_src", base =
+ 0xac80, 28);
+	hws[IMX7D_CAN2_ROOT_CG] =3D imx_clk_hw_gate3("can2_cg", "can2_src", base =
+ 0xad00, 28);
+	hws[IMX7D_I2C1_ROOT_CG] =3D imx_clk_hw_gate3("i2c1_cg", "i2c1_src", base =
+ 0xad80, 28);
+	hws[IMX7D_I2C2_ROOT_CG] =3D imx_clk_hw_gate3("i2c2_cg", "i2c2_src", base =
+ 0xae00, 28);
+	hws[IMX7D_I2C3_ROOT_CG] =3D imx_clk_hw_gate3("i2c3_cg", "i2c3_src", base =
+ 0xae80, 28);
+	hws[IMX7D_I2C4_ROOT_CG] =3D imx_clk_hw_gate3("i2c4_cg", "i2c4_src", base =
+ 0xaf00, 28);
+	hws[IMX7D_UART1_ROOT_CG] =3D imx_clk_hw_gate3("uart1_cg", "uart1_src", ba=
se + 0xaf80, 28);
+	hws[IMX7D_UART2_ROOT_CG] =3D imx_clk_hw_gate3("uart2_cg", "uart2_src", ba=
se + 0xb000, 28);
+	hws[IMX7D_UART3_ROOT_CG] =3D imx_clk_hw_gate3("uart3_cg", "uart3_src", ba=
se + 0xb080, 28);
+	hws[IMX7D_UART4_ROOT_CG] =3D imx_clk_hw_gate3("uart4_cg", "uart4_src", ba=
se + 0xb100, 28);
+	hws[IMX7D_UART5_ROOT_CG] =3D imx_clk_hw_gate3("uart5_cg", "uart5_src", ba=
se + 0xb180, 28);
+	hws[IMX7D_UART6_ROOT_CG] =3D imx_clk_hw_gate3("uart6_cg", "uart6_src", ba=
se + 0xb200, 28);
+	hws[IMX7D_UART7_ROOT_CG] =3D imx_clk_hw_gate3("uart7_cg", "uart7_src", ba=
se + 0xb280, 28);
+	hws[IMX7D_ECSPI1_ROOT_CG] =3D imx_clk_hw_gate3("ecspi1_cg", "ecspi1_src",=
 base + 0xb300, 28);
+	hws[IMX7D_ECSPI2_ROOT_CG] =3D imx_clk_hw_gate3("ecspi2_cg", "ecspi2_src",=
 base + 0xb380, 28);
+	hws[IMX7D_ECSPI3_ROOT_CG] =3D imx_clk_hw_gate3("ecspi3_cg", "ecspi3_src",=
 base + 0xb400, 28);
+	hws[IMX7D_ECSPI4_ROOT_CG] =3D imx_clk_hw_gate3("ecspi4_cg", "ecspi4_src",=
 base + 0xb480, 28);
+	hws[IMX7D_PWM1_ROOT_CG] =3D imx_clk_hw_gate3("pwm1_cg", "pwm1_src", base =
+ 0xb500, 28);
+	hws[IMX7D_PWM2_ROOT_CG] =3D imx_clk_hw_gate3("pwm2_cg", "pwm2_src", base =
+ 0xb580, 28);
+	hws[IMX7D_PWM3_ROOT_CG] =3D imx_clk_hw_gate3("pwm3_cg", "pwm3_src", base =
+ 0xb600, 28);
+	hws[IMX7D_PWM4_ROOT_CG] =3D imx_clk_hw_gate3("pwm4_cg", "pwm4_src", base =
+ 0xb680, 28);
+	hws[IMX7D_FLEXTIMER1_ROOT_CG] =3D imx_clk_hw_gate3("flextimer1_cg", "flex=
timer1_src", base + 0xb700, 28);
+	hws[IMX7D_FLEXTIMER2_ROOT_CG] =3D imx_clk_hw_gate3("flextimer2_cg", "flex=
timer2_src", base + 0xb780, 28);
+	hws[IMX7D_SIM1_ROOT_CG] =3D imx_clk_hw_gate3("sim1_cg", "sim1_src", base =
+ 0xb800, 28);
+	hws[IMX7D_SIM2_ROOT_CG] =3D imx_clk_hw_gate3("sim2_cg", "sim2_src", base =
+ 0xb880, 28);
+	hws[IMX7D_GPT1_ROOT_CG] =3D imx_clk_hw_gate3("gpt1_cg", "gpt1_src", base =
+ 0xb900, 28);
+	hws[IMX7D_GPT2_ROOT_CG] =3D imx_clk_hw_gate3("gpt2_cg", "gpt2_src", base =
+ 0xb980, 28);
+	hws[IMX7D_GPT3_ROOT_CG] =3D imx_clk_hw_gate3("gpt3_cg", "gpt3_src", base =
+ 0xbA00, 28);
+	hws[IMX7D_GPT4_ROOT_CG] =3D imx_clk_hw_gate3("gpt4_cg", "gpt4_src", base =
+ 0xbA80, 28);
+	hws[IMX7D_TRACE_ROOT_CG] =3D imx_clk_hw_gate3("trace_cg", "trace_src", ba=
se + 0xbb00, 28);
+	hws[IMX7D_WDOG_ROOT_CG] =3D imx_clk_hw_gate3("wdog_cg", "wdog_src", base =
+ 0xbb80, 28);
+	hws[IMX7D_CSI_MCLK_ROOT_CG] =3D imx_clk_hw_gate3("csi_mclk_cg", "csi_mclk=
_src", base + 0xbc00, 28);
+	hws[IMX7D_AUDIO_MCLK_ROOT_CG] =3D imx_clk_hw_gate3("audio_mclk_cg", "audi=
o_mclk_src", base + 0xbc80, 28);
+	hws[IMX7D_WRCLK_ROOT_CG] =3D imx_clk_hw_gate3("wrclk_cg", "wrclk_src", ba=
se + 0xbd00, 28);
+	hws[IMX7D_CLKO1_ROOT_CG] =3D imx_clk_hw_gate3("clko1_cg", "clko1_src", ba=
se + 0xbd80, 28);
+	hws[IMX7D_CLKO2_ROOT_CG] =3D imx_clk_hw_gate3("clko2_cg", "clko2_src", ba=
se + 0xbe00, 28);
+
+	hws[IMX7D_MAIN_AXI_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("axi_pre_div", "=
axi_cg", base + 0x8800, 16, 3);
+	hws[IMX7D_DISP_AXI_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("disp_axi_pre_di=
v", "disp_axi_cg", base + 0x8880, 16, 3);
+	hws[IMX7D_ENET_AXI_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("enet_axi_pre_di=
v", "enet_axi_cg", base + 0x8900, 16, 3);
+	hws[IMX7D_NAND_USDHC_BUS_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("nand_usdh=
c_pre_div", "nand_usdhc_cg", base + 0x8980, 16, 3);
+	hws[IMX7D_AHB_CHANNEL_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("ahb_pre_div"=
, "ahb_cg", base + 0x9000, 16, 3);
+	hws[IMX7D_DRAM_PHYM_ALT_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("dram_phym_=
alt_pre_div", "dram_phym_alt_cg", base + 0xa000, 16, 3);
+	hws[IMX7D_DRAM_ALT_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("dram_alt_pre_di=
v", "dram_alt_cg", base + 0xa080, 16, 3);
+	hws[IMX7D_USB_HSIC_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("usb_hsic_pre_di=
v", "usb_hsic_cg", base + 0xa100, 16, 3);
+	hws[IMX7D_PCIE_CTRL_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("pcie_ctrl_pre_=
div", "pcie_ctrl_cg", base + 0xa180, 16, 3);
+	hws[IMX7D_PCIE_PHY_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("pcie_phy_pre_di=
v", "pcie_phy_cg", base + 0xa200, 16, 3);
+	hws[IMX7D_EPDC_PIXEL_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("epdc_pixel_pr=
e_div", "epdc_pixel_cg", base + 0xa280, 16, 3);
+	hws[IMX7D_LCDIF_PIXEL_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("lcdif_pixel_=
pre_div", "lcdif_pixel_cg", base + 0xa300, 16, 3);
+	hws[IMX7D_MIPI_DSI_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("mipi_dsi_pre_di=
v", "mipi_dsi_cg", base + 0xa380, 16, 3);
+	hws[IMX7D_MIPI_CSI_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("mipi_csi_pre_di=
v", "mipi_csi_cg", base + 0xa400, 16, 3);
+	hws[IMX7D_MIPI_DPHY_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("mipi_dphy_pre_=
div", "mipi_dphy_cg", base + 0xa480, 16, 3);
+	hws[IMX7D_SAI1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("sai1_pre_div", "sai=
1_cg", base + 0xa500, 16, 3);
+	hws[IMX7D_SAI2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("sai2_pre_div", "sai=
2_cg", base + 0xa580, 16, 3);
+	hws[IMX7D_SAI3_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("sai3_pre_div", "sai=
3_cg", base + 0xa600, 16, 3);
+	hws[IMX7D_SPDIF_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("spdif_pre_div", "s=
pdif_cg", base + 0xa680, 16, 3);
+	hws[IMX7D_ENET1_REF_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("enet1_ref_pre_=
div", "enet1_ref_cg", base + 0xa700, 16, 3);
+	hws[IMX7D_ENET1_TIME_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("enet1_time_pr=
e_div", "enet1_time_cg", base + 0xa780, 16, 3);
+	hws[IMX7D_ENET2_REF_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("enet2_ref_pre_=
div", "enet2_ref_cg", base + 0xa800, 16, 3);
+	hws[IMX7D_ENET2_TIME_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("enet2_time_pr=
e_div", "enet2_time_cg", base + 0xa880, 16, 3);
+	hws[IMX7D_ENET_PHY_REF_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("enet_phy_re=
f_pre_div", "enet_phy_ref_cg", base + 0xa900, 16, 3);
+	hws[IMX7D_EIM_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("eim_pre_div", "eim_c=
g", base + 0xa980, 16, 3);
+	hws[IMX7D_NAND_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("nand_pre_div", "nan=
d_cg", base + 0xaa00, 16, 3);
+	hws[IMX7D_QSPI_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("qspi_pre_div", "qsp=
i_cg", base + 0xaa80, 16, 3);
+	hws[IMX7D_USDHC1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("usdhc1_pre_div", =
"usdhc1_cg", base + 0xab00, 16, 3);
+	hws[IMX7D_USDHC2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("usdhc2_pre_div", =
"usdhc2_cg", base + 0xab80, 16, 3);
+	hws[IMX7D_USDHC3_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("usdhc3_pre_div", =
"usdhc3_cg", base + 0xac00, 16, 3);
+	hws[IMX7D_CAN1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("can1_pre_div", "can=
1_cg", base + 0xac80, 16, 3);
+	hws[IMX7D_CAN2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("can2_pre_div", "can=
2_cg", base + 0xad00, 16, 3);
+	hws[IMX7D_I2C1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("i2c1_pre_div", "i2c=
1_cg", base + 0xad80, 16, 3);
+	hws[IMX7D_I2C2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("i2c2_pre_div", "i2c=
2_cg", base + 0xae00, 16, 3);
+	hws[IMX7D_I2C3_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("i2c3_pre_div", "i2c=
3_cg", base + 0xae80, 16, 3);
+	hws[IMX7D_I2C4_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("i2c4_pre_div", "i2c=
4_cg", base + 0xaf00, 16, 3);
+	hws[IMX7D_UART1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("uart1_pre_div", "u=
art1_cg", base + 0xaf80, 16, 3);
+	hws[IMX7D_UART2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("uart2_pre_div", "u=
art2_cg", base + 0xb000, 16, 3);
+	hws[IMX7D_UART3_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("uart3_pre_div", "u=
art3_cg", base + 0xb080, 16, 3);
+	hws[IMX7D_UART4_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("uart4_pre_div", "u=
art4_cg", base + 0xb100, 16, 3);
+	hws[IMX7D_UART5_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("uart5_pre_div", "u=
art5_cg", base + 0xb180, 16, 3);
+	hws[IMX7D_UART6_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("uart6_pre_div", "u=
art6_cg", base + 0xb200, 16, 3);
+	hws[IMX7D_UART7_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("uart7_pre_div", "u=
art7_cg", base + 0xb280, 16, 3);
+	hws[IMX7D_ECSPI1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("ecspi1_pre_div", =
"ecspi1_cg", base + 0xb300, 16, 3);
+	hws[IMX7D_ECSPI2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("ecspi2_pre_div", =
"ecspi2_cg", base + 0xb380, 16, 3);
+	hws[IMX7D_ECSPI3_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("ecspi3_pre_div", =
"ecspi3_cg", base + 0xb400, 16, 3);
+	hws[IMX7D_ECSPI4_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("ecspi4_pre_div", =
"ecspi4_cg", base + 0xb480, 16, 3);
+	hws[IMX7D_PWM1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("pwm1_pre_div", "pwm=
1_cg", base + 0xb500, 16, 3);
+	hws[IMX7D_PWM2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("pwm2_pre_div", "pwm=
2_cg", base + 0xb580, 16, 3);
+	hws[IMX7D_PWM3_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("pwm3_pre_div", "pwm=
3_cg", base + 0xb600, 16, 3);
+	hws[IMX7D_PWM4_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("pwm4_pre_div", "pwm=
4_cg", base + 0xb680, 16, 3);
+	hws[IMX7D_FLEXTIMER1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("flextimer1_pr=
e_div", "flextimer1_cg", base + 0xb700, 16, 3);
+	hws[IMX7D_FLEXTIMER2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("flextimer2_pr=
e_div", "flextimer2_cg", base + 0xb780, 16, 3);
+	hws[IMX7D_SIM1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("sim1_pre_div", "sim=
1_cg", base + 0xb800, 16, 3);
+	hws[IMX7D_SIM2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("sim2_pre_div", "sim=
2_cg", base + 0xb880, 16, 3);
+	hws[IMX7D_GPT1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("gpt1_pre_div", "gpt=
1_cg", base + 0xb900, 16, 3);
+	hws[IMX7D_GPT2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("gpt2_pre_div", "gpt=
2_cg", base + 0xb980, 16, 3);
+	hws[IMX7D_GPT3_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("gpt3_pre_div", "gpt=
3_cg", base + 0xba00, 16, 3);
+	hws[IMX7D_GPT4_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("gpt4_pre_div", "gpt=
4_cg", base + 0xba80, 16, 3);
+	hws[IMX7D_TRACE_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("trace_pre_div", "t=
race_cg", base + 0xbb00, 16, 3);
+	hws[IMX7D_WDOG_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("wdog_pre_div", "wdo=
g_cg", base + 0xbb80, 16, 3);
+	hws[IMX7D_CSI_MCLK_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("csi_mclk_pre_di=
v", "csi_mclk_cg", base + 0xbc00, 16, 3);
+	hws[IMX7D_AUDIO_MCLK_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("audio_mclk_pr=
e_div", "audio_mclk_cg", base + 0xbc80, 16, 3);
+	hws[IMX7D_WRCLK_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("wrclk_pre_div", "w=
rclk_cg", base + 0xbd00, 16, 3);
+	hws[IMX7D_CLKO1_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("clko1_pre_div", "c=
lko1_cg", base + 0xbd80, 16, 3);
+	hws[IMX7D_CLKO2_ROOT_PRE_DIV] =3D imx_clk_hw_divider2("clko2_pre_div", "c=
lko2_cg", base + 0xbe00, 16, 3);
+
+	hws[IMX7D_ARM_A7_ROOT_DIV] =3D imx_clk_hw_divider2("arm_a7_div", "arm_a7_=
cg", base + 0x8000, 0, 3);
+	hws[IMX7D_ARM_M4_ROOT_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_=
cg", base + 0x8080, 0, 3);
+	hws[IMX7D_MAIN_AXI_ROOT_DIV] =3D imx_clk_hw_divider2("axi_post_div", "axi=
_pre_div", base + 0x8800, 0, 6);
+	hws[IMX7D_DISP_AXI_ROOT_DIV] =3D imx_clk_hw_divider2("disp_axi_post_div",=
 "disp_axi_pre_div", base + 0x8880, 0, 6);
+	hws[IMX7D_ENET_AXI_ROOT_DIV] =3D imx_clk_hw_divider2("enet_axi_post_div",=
 "enet_axi_pre_div", base + 0x8900, 0, 6);
+	hws[IMX7D_NAND_USDHC_BUS_ROOT_CLK] =3D imx_clk_hw_divider2("nand_usdhc_ro=
ot_clk", "nand_usdhc_pre_div", base + 0x8980, 0, 6);
+	hws[IMX7D_AHB_CHANNEL_ROOT_DIV] =3D imx_clk_hw_divider2("ahb_root_clk", "=
ahb_pre_div", base + 0x9000, 0, 6);
+	hws[IMX7D_IPG_ROOT_CLK] =3D imx_clk_hw_divider_flags("ipg_root_clk", "ahb=
_root_clk", base + 0x9080, 0, 2, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE | =
CLK_SET_RATE_PARENT);
+	hws[IMX7D_DRAM_ROOT_DIV] =3D imx_clk_hw_divider2("dram_post_div", "dram_c=
g", base + 0x9880, 0, 3);
+	hws[IMX7D_DRAM_PHYM_ALT_ROOT_DIV] =3D imx_clk_hw_divider2("dram_phym_alt_=
post_div", "dram_phym_alt_pre_div", base + 0xa000, 0, 3);
+	hws[IMX7D_DRAM_ALT_ROOT_DIV] =3D imx_clk_hw_divider2("dram_alt_post_div",=
 "dram_alt_pre_div", base + 0xa080, 0, 3);
+	hws[IMX7D_USB_HSIC_ROOT_DIV] =3D imx_clk_hw_divider2("usb_hsic_post_div",=
 "usb_hsic_pre_div", base + 0xa100, 0, 6);
+	hws[IMX7D_PCIE_CTRL_ROOT_DIV] =3D imx_clk_hw_divider2("pcie_ctrl_post_div=
", "pcie_ctrl_pre_div", base + 0xa180, 0, 6);
+	hws[IMX7D_PCIE_PHY_ROOT_DIV] =3D imx_clk_hw_divider2("pcie_phy_post_div",=
 "pcie_phy_pre_div", base + 0xa200, 0, 6);
+	hws[IMX7D_EPDC_PIXEL_ROOT_DIV] =3D imx_clk_hw_divider2("epdc_pixel_post_d=
iv", "epdc_pixel_pre_div", base + 0xa280, 0, 6);
+	hws[IMX7D_LCDIF_PIXEL_ROOT_DIV] =3D imx_clk_hw_divider2("lcdif_pixel_post=
_div", "lcdif_pixel_pre_div", base + 0xa300, 0, 6);
+	hws[IMX7D_MIPI_DSI_ROOT_DIV] =3D imx_clk_hw_divider2("mipi_dsi_post_div",=
 "mipi_dsi_pre_div", base + 0xa380, 0, 6);
+	hws[IMX7D_MIPI_CSI_ROOT_DIV] =3D imx_clk_hw_divider2("mipi_csi_post_div",=
 "mipi_csi_pre_div", base + 0xa400, 0, 6);
+	hws[IMX7D_MIPI_DPHY_ROOT_DIV] =3D imx_clk_hw_divider2("mipi_dphy_post_div=
", "mipi_dphy_pre_div", base + 0xa480, 0, 6);
+	hws[IMX7D_SAI1_ROOT_DIV] =3D imx_clk_hw_divider2("sai1_post_div", "sai1_p=
re_div", base + 0xa500, 0, 6);
+	hws[IMX7D_SAI2_ROOT_DIV] =3D imx_clk_hw_divider2("sai2_post_div", "sai2_p=
re_div", base + 0xa580, 0, 6);
+	hws[IMX7D_SAI3_ROOT_DIV] =3D imx_clk_hw_divider2("sai3_post_div", "sai3_p=
re_div", base + 0xa600, 0, 6);
+	hws[IMX7D_SPDIF_ROOT_DIV] =3D imx_clk_hw_divider2("spdif_post_div", "spdi=
f_pre_div", base + 0xa680, 0, 6);
+	hws[IMX7D_ENET1_REF_ROOT_DIV] =3D imx_clk_hw_divider2("enet1_ref_post_div=
", "enet1_ref_pre_div", base + 0xa700, 0, 6);
+	hws[IMX7D_ENET1_TIME_ROOT_DIV] =3D imx_clk_hw_divider2("enet1_time_post_d=
iv", "enet1_time_pre_div", base + 0xa780, 0, 6);
+	hws[IMX7D_ENET2_REF_ROOT_DIV] =3D imx_clk_hw_divider2("enet2_ref_post_div=
", "enet2_ref_pre_div", base + 0xa800, 0, 6);
+	hws[IMX7D_ENET2_TIME_ROOT_DIV] =3D imx_clk_hw_divider2("enet2_time_post_d=
iv", "enet2_time_pre_div", base + 0xa880, 0, 6);
+	hws[IMX7D_ENET_PHY_REF_ROOT_CLK] =3D imx_clk_hw_divider2("enet_phy_ref_ro=
ot_clk", "enet_phy_ref_pre_div", base + 0xa900, 0, 6);
+	hws[IMX7D_EIM_ROOT_DIV] =3D imx_clk_hw_divider2("eim_post_div", "eim_pre_=
div", base + 0xa980, 0, 6);
+	hws[IMX7D_NAND_ROOT_CLK] =3D imx_clk_hw_divider2("nand_root_clk", "nand_p=
re_div", base + 0xaa00, 0, 6);
+	hws[IMX7D_QSPI_ROOT_DIV] =3D imx_clk_hw_divider2("qspi_post_div", "qspi_p=
re_div", base + 0xaa80, 0, 6);
+	hws[IMX7D_USDHC1_ROOT_DIV] =3D imx_clk_hw_divider2("usdhc1_post_div", "us=
dhc1_pre_div", base + 0xab00, 0, 6);
+	hws[IMX7D_USDHC2_ROOT_DIV] =3D imx_clk_hw_divider2("usdhc2_post_div", "us=
dhc2_pre_div", base + 0xab80, 0, 6);
+	hws[IMX7D_USDHC3_ROOT_DIV] =3D imx_clk_hw_divider2("usdhc3_post_div", "us=
dhc3_pre_div", base + 0xac00, 0, 6);
+	hws[IMX7D_CAN1_ROOT_DIV] =3D imx_clk_hw_divider2("can1_post_div", "can1_p=
re_div", base + 0xac80, 0, 6);
+	hws[IMX7D_CAN2_ROOT_DIV] =3D imx_clk_hw_divider2("can2_post_div", "can2_p=
re_div", base + 0xad00, 0, 6);
+	hws[IMX7D_I2C1_ROOT_DIV] =3D imx_clk_hw_divider2("i2c1_post_div", "i2c1_p=
re_div", base + 0xad80, 0, 6);
+	hws[IMX7D_I2C2_ROOT_DIV] =3D imx_clk_hw_divider2("i2c2_post_div", "i2c2_p=
re_div", base + 0xae00, 0, 6);
+	hws[IMX7D_I2C3_ROOT_DIV] =3D imx_clk_hw_divider2("i2c3_post_div", "i2c3_p=
re_div", base + 0xae80, 0, 6);
+	hws[IMX7D_I2C4_ROOT_DIV] =3D imx_clk_hw_divider2("i2c4_post_div", "i2c4_p=
re_div", base + 0xaf00, 0, 6);
+	hws[IMX7D_UART1_ROOT_DIV] =3D imx_clk_hw_divider2("uart1_post_div", "uart=
1_pre_div", base + 0xaf80, 0, 6);
+	hws[IMX7D_UART2_ROOT_DIV] =3D imx_clk_hw_divider2("uart2_post_div", "uart=
2_pre_div", base + 0xb000, 0, 6);
+	hws[IMX7D_UART3_ROOT_DIV] =3D imx_clk_hw_divider2("uart3_post_div", "uart=
3_pre_div", base + 0xb080, 0, 6);
+	hws[IMX7D_UART4_ROOT_DIV] =3D imx_clk_hw_divider2("uart4_post_div", "uart=
4_pre_div", base + 0xb100, 0, 6);
+	hws[IMX7D_UART5_ROOT_DIV] =3D imx_clk_hw_divider2("uart5_post_div", "uart=
5_pre_div", base + 0xb180, 0, 6);
+	hws[IMX7D_UART6_ROOT_DIV] =3D imx_clk_hw_divider2("uart6_post_div", "uart=
6_pre_div", base + 0xb200, 0, 6);
+	hws[IMX7D_UART7_ROOT_DIV] =3D imx_clk_hw_divider2("uart7_post_div", "uart=
7_pre_div", base + 0xb280, 0, 6);
+	hws[IMX7D_ECSPI1_ROOT_DIV] =3D imx_clk_hw_divider2("ecspi1_post_div", "ec=
spi1_pre_div", base + 0xb300, 0, 6);
+	hws[IMX7D_ECSPI2_ROOT_DIV] =3D imx_clk_hw_divider2("ecspi2_post_div", "ec=
spi2_pre_div", base + 0xb380, 0, 6);
+	hws[IMX7D_ECSPI3_ROOT_DIV] =3D imx_clk_hw_divider2("ecspi3_post_div", "ec=
spi3_pre_div", base + 0xb400, 0, 6);
+	hws[IMX7D_ECSPI4_ROOT_DIV] =3D imx_clk_hw_divider2("ecspi4_post_div", "ec=
spi4_pre_div", base + 0xb480, 0, 6);
+	hws[IMX7D_PWM1_ROOT_DIV] =3D imx_clk_hw_divider2("pwm1_post_div", "pwm1_p=
re_div", base + 0xb500, 0, 6);
+	hws[IMX7D_PWM2_ROOT_DIV] =3D imx_clk_hw_divider2("pwm2_post_div", "pwm2_p=
re_div", base + 0xb580, 0, 6);
+	hws[IMX7D_PWM3_ROOT_DIV] =3D imx_clk_hw_divider2("pwm3_post_div", "pwm3_p=
re_div", base + 0xb600, 0, 6);
+	hws[IMX7D_PWM4_ROOT_DIV] =3D imx_clk_hw_divider2("pwm4_post_div", "pwm4_p=
re_div", base + 0xb680, 0, 6);
+	hws[IMX7D_FLEXTIMER1_ROOT_DIV] =3D imx_clk_hw_divider2("flextimer1_post_d=
iv", "flextimer1_pre_div", base + 0xb700, 0, 6);
+	hws[IMX7D_FLEXTIMER2_ROOT_DIV] =3D imx_clk_hw_divider2("flextimer2_post_d=
iv", "flextimer2_pre_div", base + 0xb780, 0, 6);
+	hws[IMX7D_SIM1_ROOT_DIV] =3D imx_clk_hw_divider2("sim1_post_div", "sim1_p=
re_div", base + 0xb800, 0, 6);
+	hws[IMX7D_SIM2_ROOT_DIV] =3D imx_clk_hw_divider2("sim2_post_div", "sim2_p=
re_div", base + 0xb880, 0, 6);
+	hws[IMX7D_GPT1_ROOT_DIV] =3D imx_clk_hw_divider2("gpt1_post_div", "gpt1_p=
re_div", base + 0xb900, 0, 6);
+	hws[IMX7D_GPT2_ROOT_DIV] =3D imx_clk_hw_divider2("gpt2_post_div", "gpt2_p=
re_div", base + 0xb980, 0, 6);
+	hws[IMX7D_GPT3_ROOT_DIV] =3D imx_clk_hw_divider2("gpt3_post_div", "gpt3_p=
re_div", base + 0xba00, 0, 6);
+	hws[IMX7D_GPT4_ROOT_DIV] =3D imx_clk_hw_divider2("gpt4_post_div", "gpt4_p=
re_div", base + 0xba80, 0, 6);
+	hws[IMX7D_TRACE_ROOT_DIV] =3D imx_clk_hw_divider2("trace_post_div", "trac=
e_pre_div", base + 0xbb00, 0, 6);
+	hws[IMX7D_WDOG_ROOT_DIV] =3D imx_clk_hw_divider2("wdog_post_div", "wdog_p=
re_div", base + 0xbb80, 0, 6);
+	hws[IMX7D_CSI_MCLK_ROOT_DIV] =3D imx_clk_hw_divider2("csi_mclk_post_div",=
 "csi_mclk_pre_div", base + 0xbc00, 0, 6);
+	hws[IMX7D_AUDIO_MCLK_ROOT_DIV] =3D imx_clk_hw_divider2("audio_mclk_post_d=
iv", "audio_mclk_pre_div", base + 0xbc80, 0, 6);
+	hws[IMX7D_WRCLK_ROOT_DIV] =3D imx_clk_hw_divider2("wrclk_post_div", "wrcl=
k_pre_div", base + 0xbd00, 0, 6);
+	hws[IMX7D_CLKO1_ROOT_DIV] =3D imx_clk_hw_divider2("clko1_post_div", "clko=
1_pre_div", base + 0xbd80, 0, 6);
+	hws[IMX7D_CLKO2_ROOT_DIV] =3D imx_clk_hw_divider2("clko2_post_div", "clko=
2_pre_div", base + 0xbe00, 0, 6);
+
+	hws[IMX7D_ARM_A7_ROOT_CLK] =3D imx_clk_hw_gate2_flags("arm_a7_root_clk", =
"arm_a7_div", base + 0x4000, 0, CLK_OPS_PARENT_ENABLE);
+	hws[IMX7D_ARM_M4_ROOT_CLK] =3D imx_clk_hw_gate4("arm_m4_root_clk", "arm_m=
4_div", base + 0x4010, 0);
+	hws[IMX7D_MAIN_AXI_ROOT_CLK] =3D imx_clk_hw_gate2_flags("main_axi_root_cl=
k", "axi_post_div", base + 0x4040, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENAB=
LE);
+	hws[IMX7D_DISP_AXI_ROOT_CLK] =3D imx_clk_hw_gate4("disp_axi_root_clk", "d=
isp_axi_post_div", base + 0x4050, 0);
+	hws[IMX7D_ENET_AXI_ROOT_CLK] =3D imx_clk_hw_gate4("enet_axi_root_clk", "e=
net_axi_post_div", base + 0x4060, 0);
+	hws[IMX7D_OCRAM_CLK] =3D imx_clk_hw_gate4("ocram_clk", "main_axi_root_clk=
", base + 0x4110, 0);
+	hws[IMX7D_OCRAM_S_CLK] =3D imx_clk_hw_gate4("ocram_s_clk", "ahb_root_clk"=
, base + 0x4120, 0);
+	hws[IMX7D_DRAM_ROOT_CLK] =3D imx_clk_hw_gate2_flags("dram_root_clk", "dra=
m_post_div", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_ENABLE);
+	hws[IMX7D_DRAM_PHYM_ROOT_CLK] =3D imx_clk_hw_gate2_flags("dram_phym_root_=
clk", "dram_phym_cg", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT_EN=
ABLE);
+	hws[IMX7D_DRAM_PHYM_ALT_ROOT_CLK] =3D imx_clk_hw_gate2_flags("dram_phym_a=
lt_root_clk", "dram_phym_alt_post_div", base + 0x4130, 0, CLK_IS_CRITICAL |=
 CLK_OPS_PARENT_ENABLE);
+	hws[IMX7D_DRAM_ALT_ROOT_CLK] =3D imx_clk_hw_gate2_flags("dram_alt_root_cl=
k", "dram_alt_post_div", base + 0x4130, 0, CLK_IS_CRITICAL | CLK_OPS_PARENT=
_ENABLE);
+	hws[IMX7D_OCOTP_CLK] =3D imx_clk_hw_gate4("ocotp_clk", "ipg_root_clk", ba=
se + 0x4230, 0);
+	hws[IMX7D_SNVS_CLK] =3D imx_clk_hw_gate4("snvs_clk", "ipg_root_clk", base=
 + 0x4250, 0);
+	hws[IMX7D_MU_ROOT_CLK] =3D imx_clk_hw_gate4("mu_root_clk", "ipg_root_clk"=
, base + 0x4270, 0);
+	hws[IMX7D_CAAM_CLK] =3D imx_clk_hw_gate4("caam_clk", "ipg_root_clk", base=
 + 0x4240, 0);
+	hws[IMX7D_USB_HSIC_ROOT_CLK] =3D imx_clk_hw_gate4("usb_hsic_root_clk", "u=
sb_hsic_post_div", base + 0x4690, 0);
+	hws[IMX7D_SDMA_CORE_CLK] =3D imx_clk_hw_gate4("sdma_root_clk", "ahb_root_=
clk", base + 0x4480, 0);
+	hws[IMX7D_PCIE_CTRL_ROOT_CLK] =3D imx_clk_hw_gate4("pcie_ctrl_root_clk", =
"pcie_ctrl_post_div", base + 0x4600, 0);
+	hws[IMX7D_PCIE_PHY_ROOT_CLK] =3D imx_clk_hw_gate4("pcie_phy_root_clk", "p=
cie_phy_post_div", base + 0x4600, 0);
+	hws[IMX7D_EPDC_PIXEL_ROOT_CLK] =3D imx_clk_hw_gate4("epdc_pixel_root_clk"=
, "epdc_pixel_post_div", base + 0x44a0, 0);
+	hws[IMX7D_LCDIF_PIXEL_ROOT_CLK] =3D imx_clk_hw_gate4("lcdif_pixel_root_cl=
k", "lcdif_pixel_post_div", base + 0x44b0, 0);
+	hws[IMX7D_MIPI_DSI_ROOT_CLK] =3D imx_clk_hw_gate4("mipi_dsi_root_clk", "m=
ipi_dsi_post_div", base + 0x4650, 0);
+	hws[IMX7D_MIPI_CSI_ROOT_CLK] =3D imx_clk_hw_gate4("mipi_csi_root_clk", "m=
ipi_csi_post_div", base + 0x4640, 0);
+	hws[IMX7D_MIPI_DPHY_ROOT_CLK] =3D imx_clk_hw_gate4("mipi_dphy_root_clk", =
"mipi_dphy_post_div", base + 0x4660, 0);
+	hws[IMX7D_ENET1_IPG_ROOT_CLK] =3D imx_clk_hw_gate2_shared2("enet1_ipg_roo=
t_clk", "enet_axi_post_div", base + 0x4700, 0, &share_count_enet1);
+	hws[IMX7D_ENET1_TIME_ROOT_CLK] =3D imx_clk_hw_gate2_shared2("enet1_time_r=
oot_clk", "enet1_time_post_div", base + 0x4700, 0, &share_count_enet1);
+	hws[IMX7D_ENET2_IPG_ROOT_CLK] =3D imx_clk_hw_gate2_shared2("enet2_ipg_roo=
t_clk", "enet_axi_post_div", base + 0x4710, 0, &share_count_enet2);
+	hws[IMX7D_ENET2_TIME_ROOT_CLK] =3D imx_clk_hw_gate2_shared2("enet2_time_r=
oot_clk", "enet2_time_post_div", base + 0x4710, 0, &share_count_enet2);
+	hws[IMX7D_SAI1_ROOT_CLK] =3D imx_clk_hw_gate2_shared2("sai1_root_clk", "s=
ai1_post_div", base + 0x48c0, 0, &share_count_sai1);
+	hws[IMX7D_SAI1_IPG_CLK]  =3D imx_clk_hw_gate2_shared2("sai1_ipg_clk",  "i=
pg_root_clk",  base + 0x48c0, 0, &share_count_sai1);
+	hws[IMX7D_SAI2_ROOT_CLK] =3D imx_clk_hw_gate2_shared2("sai2_root_clk", "s=
ai2_post_div", base + 0x48d0, 0, &share_count_sai2);
+	hws[IMX7D_SAI2_IPG_CLK]  =3D imx_clk_hw_gate2_shared2("sai2_ipg_clk",  "i=
pg_root_clk",  base + 0x48d0, 0, &share_count_sai2);
+	hws[IMX7D_SAI3_ROOT_CLK] =3D imx_clk_hw_gate2_shared2("sai3_root_clk", "s=
ai3_post_div", base + 0x48e0, 0, &share_count_sai3);
+	hws[IMX7D_SAI3_IPG_CLK]  =3D imx_clk_hw_gate2_shared2("sai3_ipg_clk",  "i=
pg_root_clk",  base + 0x48e0, 0, &share_count_sai3);
+	hws[IMX7D_SPDIF_ROOT_CLK] =3D imx_clk_hw_gate4("spdif_root_clk", "spdif_p=
ost_div", base + 0x44d0, 0);
+	hws[IMX7D_EIM_ROOT_CLK] =3D imx_clk_hw_gate4("eim_root_clk", "eim_post_di=
v", base + 0x4160, 0);
+	hws[IMX7D_NAND_RAWNAND_CLK] =3D imx_clk_hw_gate2_shared2("nand_rawnand_cl=
k", "nand_root_clk", base + 0x4140, 0, &share_count_nand);
+	hws[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] =3D imx_clk_hw_gate2_shared2("nand_=
usdhc_rawnand_clk", "nand_usdhc_root_clk", base + 0x4140, 0, &share_count_n=
and);
+	hws[IMX7D_QSPI_ROOT_CLK] =3D imx_clk_hw_gate4("qspi_root_clk", "qspi_post=
_div", base + 0x4150, 0);
+	hws[IMX7D_USDHC1_ROOT_CLK] =3D imx_clk_hw_gate4("usdhc1_root_clk", "usdhc=
1_post_div", base + 0x46c0, 0);
+	hws[IMX7D_USDHC2_ROOT_CLK] =3D imx_clk_hw_gate4("usdhc2_root_clk", "usdhc=
2_post_div", base + 0x46d0, 0);
+	hws[IMX7D_USDHC3_ROOT_CLK] =3D imx_clk_hw_gate4("usdhc3_root_clk", "usdhc=
3_post_div", base + 0x46e0, 0);
+	hws[IMX7D_CAN1_ROOT_CLK] =3D imx_clk_hw_gate4("can1_root_clk", "can1_post=
_div", base + 0x4740, 0);
+	hws[IMX7D_CAN2_ROOT_CLK] =3D imx_clk_hw_gate4("can2_root_clk", "can2_post=
_div", base + 0x4750, 0);
+	hws[IMX7D_I2C1_ROOT_CLK] =3D imx_clk_hw_gate4("i2c1_root_clk", "i2c1_post=
_div", base + 0x4880, 0);
+	hws[IMX7D_I2C2_ROOT_CLK] =3D imx_clk_hw_gate4("i2c2_root_clk", "i2c2_post=
_div", base + 0x4890, 0);
+	hws[IMX7D_I2C3_ROOT_CLK] =3D imx_clk_hw_gate4("i2c3_root_clk", "i2c3_post=
_div", base + 0x48a0, 0);
+	hws[IMX7D_I2C4_ROOT_CLK] =3D imx_clk_hw_gate4("i2c4_root_clk", "i2c4_post=
_div", base + 0x48b0, 0);
+	hws[IMX7D_UART1_ROOT_CLK] =3D imx_clk_hw_gate4("uart1_root_clk", "uart1_p=
ost_div", base + 0x4940, 0);
+	hws[IMX7D_UART2_ROOT_CLK] =3D imx_clk_hw_gate4("uart2_root_clk", "uart2_p=
ost_div", base + 0x4950, 0);
+	hws[IMX7D_UART3_ROOT_CLK] =3D imx_clk_hw_gate4("uart3_root_clk", "uart3_p=
ost_div", base + 0x4960, 0);
+	hws[IMX7D_UART4_ROOT_CLK] =3D imx_clk_hw_gate4("uart4_root_clk", "uart4_p=
ost_div", base + 0x4970, 0);
+	hws[IMX7D_UART5_ROOT_CLK] =3D imx_clk_hw_gate4("uart5_root_clk", "uart5_p=
ost_div", base + 0x4980, 0);
+	hws[IMX7D_UART6_ROOT_CLK] =3D imx_clk_hw_gate4("uart6_root_clk", "uart6_p=
ost_div", base + 0x4990, 0);
+	hws[IMX7D_UART7_ROOT_CLK] =3D imx_clk_hw_gate4("uart7_root_clk", "uart7_p=
ost_div", base + 0x49a0, 0);
+	hws[IMX7D_ECSPI1_ROOT_CLK] =3D imx_clk_hw_gate4("ecspi1_root_clk", "ecspi=
1_post_div", base + 0x4780, 0);
+	hws[IMX7D_ECSPI2_ROOT_CLK] =3D imx_clk_hw_gate4("ecspi2_root_clk", "ecspi=
2_post_div", base + 0x4790, 0);
+	hws[IMX7D_ECSPI3_ROOT_CLK] =3D imx_clk_hw_gate4("ecspi3_root_clk", "ecspi=
3_post_div", base + 0x47a0, 0);
+	hws[IMX7D_ECSPI4_ROOT_CLK] =3D imx_clk_hw_gate4("ecspi4_root_clk", "ecspi=
4_post_div", base + 0x47b0, 0);
+	hws[IMX7D_PWM1_ROOT_CLK] =3D imx_clk_hw_gate4("pwm1_root_clk", "pwm1_post=
_div", base + 0x4840, 0);
+	hws[IMX7D_PWM2_ROOT_CLK] =3D imx_clk_hw_gate4("pwm2_root_clk", "pwm2_post=
_div", base + 0x4850, 0);
+	hws[IMX7D_PWM3_ROOT_CLK] =3D imx_clk_hw_gate4("pwm3_root_clk", "pwm3_post=
_div", base + 0x4860, 0);
+	hws[IMX7D_PWM4_ROOT_CLK] =3D imx_clk_hw_gate4("pwm4_root_clk", "pwm4_post=
_div", base + 0x4870, 0);
+	hws[IMX7D_FLEXTIMER1_ROOT_CLK] =3D imx_clk_hw_gate4("flextimer1_root_clk"=
, "flextimer1_post_div", base + 0x4800, 0);
+	hws[IMX7D_FLEXTIMER2_ROOT_CLK] =3D imx_clk_hw_gate4("flextimer2_root_clk"=
, "flextimer2_post_div", base + 0x4810, 0);
+	hws[IMX7D_SIM1_ROOT_CLK] =3D imx_clk_hw_gate4("sim1_root_clk", "sim1_post=
_div", base + 0x4900, 0);
+	hws[IMX7D_SIM2_ROOT_CLK] =3D imx_clk_hw_gate4("sim2_root_clk", "sim2_post=
_div", base + 0x4910, 0);
+	hws[IMX7D_GPT1_ROOT_CLK] =3D imx_clk_hw_gate4("gpt1_root_clk", "gpt1_post=
_div", base + 0x47c0, 0);
+	hws[IMX7D_GPT2_ROOT_CLK] =3D imx_clk_hw_gate4("gpt2_root_clk", "gpt2_post=
_div", base + 0x47d0, 0);
+	hws[IMX7D_GPT3_ROOT_CLK] =3D imx_clk_hw_gate4("gpt3_root_clk", "gpt3_post=
_div", base + 0x47e0, 0);
+	hws[IMX7D_GPT4_ROOT_CLK] =3D imx_clk_hw_gate4("gpt4_root_clk", "gpt4_post=
_div", base + 0x47f0, 0);
+	hws[IMX7D_TRACE_ROOT_CLK] =3D imx_clk_hw_gate4("trace_root_clk", "trace_p=
ost_div", base + 0x4300, 0);
+	hws[IMX7D_WDOG1_ROOT_CLK] =3D imx_clk_hw_gate4("wdog1_root_clk", "wdog_po=
st_div", base + 0x49c0, 0);
+	hws[IMX7D_WDOG2_ROOT_CLK] =3D imx_clk_hw_gate4("wdog2_root_clk", "wdog_po=
st_div", base + 0x49d0, 0);
+	hws[IMX7D_WDOG3_ROOT_CLK] =3D imx_clk_hw_gate4("wdog3_root_clk", "wdog_po=
st_div", base + 0x49e0, 0);
+	hws[IMX7D_WDOG4_ROOT_CLK] =3D imx_clk_hw_gate4("wdog4_root_clk", "wdog_po=
st_div", base + 0x49f0, 0);
+	hws[IMX7D_KPP_ROOT_CLK] =3D imx_clk_hw_gate4("kpp_root_clk", "ipg_root_cl=
k", base + 0x4aa0, 0);
+	hws[IMX7D_CSI_MCLK_ROOT_CLK] =3D imx_clk_hw_gate4("csi_mclk_root_clk", "c=
si_mclk_post_div", base + 0x4490, 0);
+	hws[IMX7D_AUDIO_MCLK_ROOT_CLK] =3D imx_clk_hw_gate4("audio_mclk_root_clk"=
, "audio_mclk_post_div", base + 0x4790, 0);
+	hws[IMX7D_WRCLK_ROOT_CLK] =3D imx_clk_hw_gate4("wrclk_root_clk", "wrclk_p=
ost_div", base + 0x47a0, 0);
+	hws[IMX7D_USB_CTRL_CLK] =3D imx_clk_hw_gate4("usb_ctrl_clk", "ahb_root_cl=
k", base + 0x4680, 0);
+	hws[IMX7D_USB_PHY1_CLK] =3D imx_clk_hw_gate4("usb_phy1_clk", "pll_usb1_ma=
in_clk", base + 0x46a0, 0);
+	hws[IMX7D_USB_PHY2_CLK] =3D imx_clk_hw_gate4("usb_phy2_clk", "pll_usb_mai=
n_clk", base + 0x46b0, 0);
+	hws[IMX7D_ADC_ROOT_CLK] =3D imx_clk_hw_gate4("adc_root_clk", "ipg_root_cl=
k", base + 0x4200, 0);
+
+	hws[IMX7D_GPT_3M_CLK] =3D imx_clk_hw_fixed_factor("gpt_3m", "osc", 1, 8);
+
+	hws[IMX7D_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a7_root_clk",
+					 hws[IMX7D_ARM_A7_ROOT_CLK]->clk,
+					 hws[IMX7D_ARM_A7_ROOT_SRC]->clk,
+					 hws[IMX7D_PLL_ARM_MAIN_CLK]->clk,
+					 hws[IMX7D_PLL_SYS_MAIN_CLK]->clk);
+
+	imx_check_clk_hws(hws, IMX7D_CLK_END);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+
+	clk_set_parent(hws[IMX7D_PLL_ARM_MAIN_BYPASS]->clk, hws[IMX7D_PLL_ARM_MAI=
N]->clk);
+	clk_set_parent(hws[IMX7D_PLL_DRAM_MAIN_BYPASS]->clk, hws[IMX7D_PLL_DRAM_M=
AIN]->clk);
+	clk_set_parent(hws[IMX7D_PLL_SYS_MAIN_BYPASS]->clk, hws[IMX7D_PLL_SYS_MAI=
N]->clk);
+	clk_set_parent(hws[IMX7D_PLL_ENET_MAIN_BYPASS]->clk, hws[IMX7D_PLL_ENET_M=
AIN]->clk);
+	clk_set_parent(hws[IMX7D_PLL_AUDIO_MAIN_BYPASS]->clk, hws[IMX7D_PLL_AUDIO=
_MAIN]->clk);
+	clk_set_parent(hws[IMX7D_PLL_VIDEO_MAIN_BYPASS]->clk, hws[IMX7D_PLL_VIDEO=
_MAIN]->clk);
+
+	clk_set_parent(hws[IMX7D_MIPI_CSI_ROOT_SRC]->clk, hws[IMX7D_PLL_SYS_PFD3_=
CLK]->clk);
=20
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter fr=
eq */
-	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
+	clk_set_parent(hws[IMX7D_GPT1_ROOT_SRC]->clk, hws[IMX7D_OSC_24M_CLK]->clk=
);
=20
 	/* Set clock rate for USBPHY, the USB_PLL at CCM is from USBOTG2 */
-	clks[IMX7D_USB1_MAIN_480M_CLK] =3D imx_clk_fixed_factor("pll_usb1_main_cl=
k", "osc", 20, 1);
-	clks[IMX7D_USB_MAIN_480M_CLK] =3D imx_clk_fixed_factor("pll_usb_main_clk"=
, "osc", 20, 1);
+	hws[IMX7D_USB1_MAIN_480M_CLK] =3D imx_clk_hw_fixed_factor("pll_usb1_main_=
clk", "osc", 20, 1);
+	hws[IMX7D_USB_MAIN_480M_CLK] =3D imx_clk_hw_fixed_factor("pll_usb_main_cl=
k", "osc", 20, 1);
+
+	for (i =3D 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
+		int index =3D uart_clk_ids[i];
+
+		uart_clks[i] =3D &hws[index]->clk;
+	}
+
=20
 	imx_register_uart_clocks(uart_clks);
=20
--=20
2.7.4

