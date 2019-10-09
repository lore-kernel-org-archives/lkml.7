Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ADBECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA3021721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YdXczMdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfJIJ6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:58:24 -0400
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:59204
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfJIJ6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDvyTiVyzRYesn69J5Wg6XmOlRJilxC0jUQrCI7cv7n2lnlqtiS4puZiF/ByjqqktqmK70bmdEcGrpgMVzyswLOUZlGtWiLo+i8pwhCxKcR8nfvSB7S/BLODpL6nuTd6viJ7meSY3NqnVmUjYs8NUn9CKkW5eNUu/bXbx62efVWaUyO0lUbVQYtggqkD47y3c3RyOVl5RFIC64uPVWClAdQ7Uqz612iyshdEVCHf6NS3hzcGRUe6oWHKwryBwtw2kiZfYRlPYAZ7cpg1E80CJgjdxBy64iLDozzc/Nq208FkxjL46gSNa/QPCOLMBsKi1RFjPfH00+3vk3dWOEwH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx6xQhBeT3miQSSHXDt3BkM19Wlt/qX9j5PSxDmP5Wg=;
 b=J9PkazD6+Kg3bwtQh5PPqmkcvc6s7Wq+cRZpo3lam7IhnuqSrAH6SvZCjedjbjzOf+yWx6t09LbdcKSbun9phJYtE3sFMIrrF98TrtUiXuYehnmXNz3TiekXAQfFmSe8H/DTTUKol6PrEHtJGEyAp8FmjUpqzebCO6UH14hZon4ynL4SCx9dCOxIn3V8kWxPyoykxIBW/5h1ME0OMaOCagcmEcFAk8HLKZDJ9BNXb1cmuQzbB9W78ZVNjLR8m9wqg/cYvaaDEOgBp0FEs0Ih0iwJ75H0g1bCix4zqufAJTIxrWeaWo02HEJvcRSvA0iNYqWKCjZiJzUK2Rk7Ot1ksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx6xQhBeT3miQSSHXDt3BkM19Wlt/qX9j5PSxDmP5Wg=;
 b=YdXczMdQeOPRcfeuvVV2GbMwpIGc9NqptAK5MUf1IoSsNTEul8Wics7UJ7x0Vyu3SKjeU6b3HCsjynmBT9mHxwmTzCG0JqBO8BVgh7BdGfNX+W2g5Ot6kJxw0hXGISTeV+nPleQsPkxIHwzesd4JOAiaNCEyzl+XEglbqMZyIjk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4177.eurprd04.prod.outlook.com (52.134.92.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 09:58:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 09:58:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] clk: imx: imx8mn: mark sys_pll1/2 as fixed clock
Thread-Topic: [PATCH 2/3] clk: imx: imx8mn: mark sys_pll1/2 as fixed clock
Thread-Index: AQHVfogUuHLKbUNJ2kqpC4SQkCQqqg==
Date:   Wed, 9 Oct 2019 09:58:19 +0000
Message-ID: <1570614940-17239-2-git-send-email-peng.fan@nxp.com>
References: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::19) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 863e8bd9-88e8-499b-53d7-08d74c9f36a6
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB4177:|AM0PR04MB4177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4177453ECCD694D28E1B562A88950@AM0PR04MB4177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(476003)(64756008)(478600001)(8676002)(14454004)(81166006)(81156014)(4326008)(446003)(11346002)(5660300002)(66556008)(2906002)(36756003)(66446008)(66476007)(256004)(3846002)(186003)(66946007)(486006)(26005)(6116002)(6486002)(2616005)(305945005)(25786009)(7736002)(316002)(110136005)(66066001)(54906003)(2201001)(6436002)(52116002)(99286004)(6512007)(44832011)(50226002)(102836004)(71190400001)(71200400001)(76176011)(8936002)(2501003)(86362001)(386003)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4177;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDUobCPoukW1j5n1XsxFiqOFl0a3gqw1qvZv4NEdEZLYuNeNv9/Zvdub3jFWAGwsoU/NBm00c4RB5xdj0NsNx0+0IxxiShbqdUE3UOo+Htczgv2p8bFK+AfxvtAxhlYikKj9kr5czHY/lPuuD6SrgvbXCez38F9PxZflEvdHabI641AUlGVdSBHyZ0bI5rBallJTR3jPnb0Yra7riET/p2te3+Pn+hl11+4AqtqmZQhuG21dSW58nsicCUdgg+4nX4cAQ6yaapem12eI/90Rz6wtRSAj8qQJrg6lwixToz4RBMclHp979b4hH/p1Gi7rQx3l+ThpTqXNELWt7xNfAfb9UpHRtoAJGmJNsOV8DxeUlqxKbney2+wd9RHtnk3DwiChfObrSAUzZysYxSueUUtvDiudv3aVgGaMEEHiYh0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e8bd9-88e8-499b-53d7-08d74c9f36a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 09:58:19.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jt8eKTFlDviLA5f1cmjtaX3VViosV7ZbWTE6QDEZREfQsf1x6e28nQ070vOSf6vUdBlMGrVkj2EEaHxMocoQpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According Architecture definition guide, SYS_PLL1 is fixed at
800MHz, SYS_PLL2 is fixed at 1000MHz, so let's use imx_clk_fixed
to register the clocks and drop code that could change the rate.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 7a5590b967d5..28467db10c69 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -47,8 +47,6 @@ static const char * const dram_pll_bypass_sels[] =3D {"dr=
am_pll", "dram_pll_ref_se
 static const char * const gpu_pll_bypass_sels[] =3D {"gpu_pll", "gpu_pll_r=
ef_sel", };
 static const char * const vpu_pll_bypass_sels[] =3D {"vpu_pll", "vpu_pll_r=
ef_sel", };
 static const char * const arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_r=
ef_sel", };
-static const char * const sys_pll1_bypass_sels[] =3D {"sys_pll1", "sys_pll=
1_ref_sel", };
-static const char * const sys_pll2_bypass_sels[] =3D {"sys_pll2", "sys_pll=
2_ref_sel", };
 static const char * const sys_pll3_bypass_sels[] =3D {"sys_pll3", "sys_pll=
3_ref_sel", };
=20
 static const char * const imx8mn_a53_sels[] =3D {"osc_24m", "arm_pll_out",=
 "sys_pll2_500m",
@@ -336,8 +334,6 @@ static int imx8mn_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MN_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", base + 0x=
64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MN_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel", base + 0x=
74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MN_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", base + 0x=
84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_SYS_PLL1_REF_SEL] =3D imx_clk_mux("sys_pll1_ref_sel", base + =
0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MN_SYS_PLL2_REF_SEL] =3D imx_clk_mux("sys_pll2_ref_sel", base + =
0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MN_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel", base + =
0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
=20
 	clks[IMX8MN_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1", "audio_pll1_ref=
_sel", base, &imx_1443x_pll);
@@ -347,8 +343,8 @@ static int imx8mn_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MN_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", ba=
se + 0x64, &imx_1416x_pll);
 	clks[IMX8MN_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", ba=
se + 0x74, &imx_1416x_pll);
 	clks[IMX8MN_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", ba=
se + 0x84, &imx_1416x_pll);
-	clks[IMX8MN_SYS_PLL1] =3D imx_clk_pll14xx("sys_pll1", "sys_pll1_ref_sel",=
 base + 0x94, &imx_1416x_pll);
-	clks[IMX8MN_SYS_PLL2] =3D imx_clk_pll14xx("sys_pll2", "sys_pll2_ref_sel",=
 base + 0x104, &imx_1416x_pll);
+	clks[IMX8MN_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
+	clks[IMX8MN_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);
 	clks[IMX8MN_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",=
 base + 0x114, &imx_1416x_pll);
=20
 	/* PLL bypass out */
@@ -359,8 +355,6 @@ static int imx8mn_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MN_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", base =
+ 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
 	clks[IMX8MN_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", base =
+ 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
 	clks[IMX8MN_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
-	clks[IMX8MN_SYS_PLL1_BYPASS] =3D imx_clk_mux_flags("sys_pll1_bypass", bas=
e + 0x94, 28, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CL=
K_SET_RATE_PARENT);
-	clks[IMX8MN_SYS_PLL2_BYPASS] =3D imx_clk_mux_flags("sys_pll2_bypass", bas=
e + 0x104, 28, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), C=
LK_SET_RATE_PARENT);
 	clks[IMX8MN_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", bas=
e + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), C=
LK_SET_RATE_PARENT);
=20
 	/* PLL out gate */
@@ -371,8 +365,8 @@ static int imx8mn_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MN_GPU_PLL_OUT] =3D imx_clk_gate("gpu_pll_out", "gpu_pll_bypass"=
, base + 0x64, 11);
 	clks[IMX8MN_VPU_PLL_OUT] =3D imx_clk_gate("vpu_pll_out", "vpu_pll_bypass"=
, base + 0x74, 11);
 	clks[IMX8MN_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll_bypass"=
, base + 0x84, 11);
-	clks[IMX8MN_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1_bypa=
ss", base + 0x94, 11);
-	clks[IMX8MN_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2_bypa=
ss", base + 0x104, 11);
+	clks[IMX8MN_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1", ba=
se + 0x94, 11);
+	clks[IMX8MN_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2", ba=
se + 0x104, 11);
 	clks[IMX8MN_SYS_PLL3_OUT] =3D imx_clk_gate("sys_pll3_out", "sys_pll3_bypa=
ss", base + 0x114, 11);
=20
 	/* SYS PLL fixed output */
--=20
2.16.4

