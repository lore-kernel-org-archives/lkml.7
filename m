Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79106CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ADC20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DeBwBqXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408123AbfJXB6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:58:49 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:33668
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408092AbfJXB6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB1P4IC7DKy4d5Is1z2TgfyjLs1+0m/phsv8h/XGP0/8V4ebKO9BZUK4WRzKhpFH/rIeHGU51T6YVCVuy7hzWNnyTuaoBBxVMBWSixG6YEszSs1+EwUxYjyjIp/uKr18VyKSWxxf01IJX7Fd6otDSYF+E0w3mgTTuZ24M9Nt+PMVa1i2UqV1wcWYcicb8gXvYxOfZYe3AN1qniCRaL3u2V43ETkH1AYBTfdRUjuhBTLhFxuzf3vYuoJlEGeJkmHQTXS5M5d7gwefwgaU+Ry1jxju3VH/UdqrA71R07eHeF3ljyhDcUf33DbQ4xcNXcR7x4pPJCDo1L09rkbVxwSrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED7ioHK4Y7AoPLFvnjFdiDtz71KvIiMkGZMro4Df5B0=;
 b=C5KQ1+SbK4uX2VOGTnPcO1g9CRrLMJJwJpEfGDI775fI3iq26T3yOZmfmuWUdFlNCH7vcWP96Un1OMpXl4ifnrzk/zdLzPkNgpZnqS2badgFd7SAi3Iv9cFlOs7kI1DmckBc6hPf2IXtuph+3LZvbV+8hCPvwAmhH4eHJfFBSrj9/05DoXo5MnL8kj3sKp3oQmVYmMfbnUAxJrY7u1HU0+veC6GM+ljmmfqSgFlrnEXQrrYeNWuXKC1PQVXKOO4nlAz/d4AgM3MXwosmY4WzNNqkHNESGAqoX5lgjlXcO3vq0xOct3P7FyIXLKoYojgLUVh3/OHuswI2aNoiBMjFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED7ioHK4Y7AoPLFvnjFdiDtz71KvIiMkGZMro4Df5B0=;
 b=DeBwBqXozCLa3v5R5ViYLRpEmen/SzBV7mEY4BNdizetD104xI7EIV8KZnoXkKJVbL4JxabhrLXZaOZUeERTpVz+JJiDE+5QiABgToO2U6eanojrUzNwxtvKgNWjPEL2HUtY7/sKV3zawZAaTfbU+raAp/wqRyQ3OqNV7ZEp0Oc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5988.eurprd04.prod.outlook.com (20.178.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 01:58:42 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 01:58:42 +0000
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
Subject: [PATCH V2 2/3] clk: imx: imx8mn: mark sys_pll1/2 as fixed clock
Thread-Topic: [PATCH V2 2/3] clk: imx: imx8mn: mark sys_pll1/2 as fixed clock
Thread-Index: AQHVig6P41yetq9QFECH96p+Tgs8nA==
Date:   Thu, 24 Oct 2019 01:58:42 +0000
Message-ID: <1571882110-10191-3-git-send-email-peng.fan@nxp.com>
References: <1571882110-10191-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1571882110-10191-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2004e7f5-2492-4f6d-aa46-08d75825b22a
x-ms-traffictypediagnostic: AM0PR04MB5988:|AM0PR04MB5988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB59887B1A79DBBC7995313E18886A0@AM0PR04MB5988.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(186003)(26005)(316002)(4326008)(64756008)(6116002)(71190400001)(6512007)(6436002)(2201001)(76176011)(305945005)(25786009)(36756003)(14454004)(54906003)(71200400001)(478600001)(110136005)(2501003)(5660300002)(7736002)(52116002)(66556008)(2616005)(99286004)(6486002)(476003)(446003)(8936002)(256004)(44832011)(386003)(86362001)(50226002)(6506007)(486006)(102836004)(2906002)(11346002)(66946007)(81156014)(81166006)(66066001)(66476007)(8676002)(66446008)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5988;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPIP/BBGGXaQmWQB1Gnwv2iIPQYfX7tnXhXRArV8ViW7FRMGrji4D2ZA/4qhskRDNtSKxOc8gxsv7tUHYMDmFbl96/uW/WtaV15uKO5/lxeF7MZ0Ty5Qdhlh652csZXY/vsuqaF4RnctNiz+No6neADOvlu04jLwIi9SP2fYQOtIQ1b5c8+1XGPBayBVahdkqRepdQ3aJsBhMEHFuL1B3m8HUfwSWnhc/Sxf3AY3+BM84tJGa7hQgsGw3wFu+DIYZOTcAEOuArJdntkJColhjNC66Duz5CX8PqjzlD4JPw9Yu2oq0FMaVWWqnhsMguy72ZjWymW6jS6Zj9E0ou+NxzghzQtYlfqIZpNoaYrdKzdNZgJuLsR+GDlEO3de9YsIVvNnH4FuY3WS1SfcS7j2EDBlGvck941Ak4rTaqkXxaB0NJJitnoWC/uiCMj1HMIO
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2004e7f5-2492-4f6d-aa46-08d75825b22a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 01:58:42.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bdqm8YSzXzECEwxVfv6OslObzdEO6p5szGDCgUye6gegpdZC2jfh9nmwP6FlSE7UqnzrWtFqhQK4umEQhKVqRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According Architecture definition guide, SYS_PLL1 is fixed at
800MHz, SYS_PLL2 is fixed at 1000MHz, so let's use imx_clk_fixed
to register the clocks and drop code that could change the rate.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 46 +++++++++++++++++++---------------------=
----
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index edc9c35669e6..def10a4da603 100644
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
@@ -374,15 +368,15 @@ static int imx8mn_clocks_probe(struct platform_device=
 *pdev)
 	clks[IMX8MN_SYS_PLL3_OUT] =3D imx_clk_gate("sys_pll3_out", "sys_pll3_bypa=
ss", base + 0x114, 11);
=20
 	/* SYS PLL1 fixed output */
-	clks[IMX8MN_SYS_PLL1_40M_CG] =3D imx_clk_gate("sys_pll1_40m_cg", "sys_pll=
1_bypass", base + 0x94, 27);
-	clks[IMX8MN_SYS_PLL1_80M_CG] =3D imx_clk_gate("sys_pll1_80m_cg", "sys_pll=
1_bypass", base + 0x94, 25);
-	clks[IMX8MN_SYS_PLL1_100M_CG] =3D imx_clk_gate("sys_pll1_100m_cg", "sys_p=
ll1_bypass", base + 0x94, 23);
-	clks[IMX8MN_SYS_PLL1_133M_CG] =3D imx_clk_gate("sys_pll1_133m_cg", "sys_p=
ll1_bypass", base + 0x94, 21);
-	clks[IMX8MN_SYS_PLL1_160M_CG] =3D imx_clk_gate("sys_pll1_160m_cg", "sys_p=
ll1_bypass", base + 0x94, 19);
-	clks[IMX8MN_SYS_PLL1_200M_CG] =3D imx_clk_gate("sys_pll1_200m_cg", "sys_p=
ll1_bypass", base + 0x94, 17);
-	clks[IMX8MN_SYS_PLL1_266M_CG] =3D imx_clk_gate("sys_pll1_266m_cg", "sys_p=
ll1_bypass", base + 0x94, 15);
-	clks[IMX8MN_SYS_PLL1_400M_CG] =3D imx_clk_gate("sys_pll1_400m_cg", "sys_p=
ll1_bypass", base + 0x94, 13);
-	clks[IMX8MN_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1_bypa=
ss", base + 0x94, 11);
+	clks[IMX8MN_SYS_PLL1_40M_CG] =3D imx_clk_gate("sys_pll1_40m_cg", "sys_pll=
1", base + 0x94, 27);
+	clks[IMX8MN_SYS_PLL1_80M_CG] =3D imx_clk_gate("sys_pll1_80m_cg", "sys_pll=
1", base + 0x94, 25);
+	clks[IMX8MN_SYS_PLL1_100M_CG] =3D imx_clk_gate("sys_pll1_100m_cg", "sys_p=
ll1", base + 0x94, 23);
+	clks[IMX8MN_SYS_PLL1_133M_CG] =3D imx_clk_gate("sys_pll1_133m_cg", "sys_p=
ll1", base + 0x94, 21);
+	clks[IMX8MN_SYS_PLL1_160M_CG] =3D imx_clk_gate("sys_pll1_160m_cg", "sys_p=
ll1", base + 0x94, 19);
+	clks[IMX8MN_SYS_PLL1_200M_CG] =3D imx_clk_gate("sys_pll1_200m_cg", "sys_p=
ll1", base + 0x94, 17);
+	clks[IMX8MN_SYS_PLL1_266M_CG] =3D imx_clk_gate("sys_pll1_266m_cg", "sys_p=
ll1", base + 0x94, 15);
+	clks[IMX8MN_SYS_PLL1_400M_CG] =3D imx_clk_gate("sys_pll1_400m_cg", "sys_p=
ll1", base + 0x94, 13);
+	clks[IMX8MN_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1", ba=
se + 0x94, 11);
=20
 	clks[IMX8MN_SYS_PLL1_40M] =3D imx_clk_fixed_factor("sys_pll1_40m", "sys_p=
ll1_40m_cg", 1, 20);
 	clks[IMX8MN_SYS_PLL1_80M] =3D imx_clk_fixed_factor("sys_pll1_80m", "sys_p=
ll1_80m_cg", 1, 10);
@@ -395,15 +389,15 @@ static int imx8mn_clocks_probe(struct platform_device=
 *pdev)
 	clks[IMX8MN_SYS_PLL1_800M] =3D imx_clk_fixed_factor("sys_pll1_800m", "sys=
_pll1_out", 1, 1);
=20
 	/* SYS PLL2 fixed output */
-	clks[IMX8MN_SYS_PLL2_50M_CG] =3D imx_clk_gate("sys_pll2_50m_cg", "sys_pll=
2_bypass", base + 0x104, 27);
-	clks[IMX8MN_SYS_PLL2_100M_CG] =3D imx_clk_gate("sys_pll2_100m_cg", "sys_p=
ll2_bypass", base + 0x104, 25);
-	clks[IMX8MN_SYS_PLL2_125M_CG] =3D imx_clk_gate("sys_pll2_125m_cg", "sys_p=
ll2_bypass", base + 0x104, 23);
-	clks[IMX8MN_SYS_PLL2_166M_CG] =3D imx_clk_gate("sys_pll2_166m_cg", "sys_p=
ll2_bypass", base + 0x104, 21);
-	clks[IMX8MN_SYS_PLL2_200M_CG] =3D imx_clk_gate("sys_pll2_200m_cg", "sys_p=
ll2_bypass", base + 0x104, 19);
-	clks[IMX8MN_SYS_PLL2_250M_CG] =3D imx_clk_gate("sys_pll2_250m_cg", "sys_p=
ll2_bypass", base + 0x104, 17);
-	clks[IMX8MN_SYS_PLL2_333M_CG] =3D imx_clk_gate("sys_pll2_333m_cg", "sys_p=
ll2_bypass", base + 0x104, 15);
-	clks[IMX8MN_SYS_PLL2_500M_CG] =3D imx_clk_gate("sys_pll2_500m_cg", "sys_p=
ll2_bypass", base + 0x104, 13);
-	clks[IMX8MN_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2_bypa=
ss", base + 0x104, 11);
+	clks[IMX8MN_SYS_PLL2_50M_CG] =3D imx_clk_gate("sys_pll2_50m_cg", "sys_pll=
2", base + 0x104, 27);
+	clks[IMX8MN_SYS_PLL2_100M_CG] =3D imx_clk_gate("sys_pll2_100m_cg", "sys_p=
ll2", base + 0x104, 25);
+	clks[IMX8MN_SYS_PLL2_125M_CG] =3D imx_clk_gate("sys_pll2_125m_cg", "sys_p=
ll2", base + 0x104, 23);
+	clks[IMX8MN_SYS_PLL2_166M_CG] =3D imx_clk_gate("sys_pll2_166m_cg", "sys_p=
ll2", base + 0x104, 21);
+	clks[IMX8MN_SYS_PLL2_200M_CG] =3D imx_clk_gate("sys_pll2_200m_cg", "sys_p=
ll2", base + 0x104, 19);
+	clks[IMX8MN_SYS_PLL2_250M_CG] =3D imx_clk_gate("sys_pll2_250m_cg", "sys_p=
ll2", base + 0x104, 17);
+	clks[IMX8MN_SYS_PLL2_333M_CG] =3D imx_clk_gate("sys_pll2_333m_cg", "sys_p=
ll2", base + 0x104, 15);
+	clks[IMX8MN_SYS_PLL2_500M_CG] =3D imx_clk_gate("sys_pll2_500m_cg", "sys_p=
ll2", base + 0x104, 13);
+	clks[IMX8MN_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2", ba=
se + 0x104, 11);
=20
 	clks[IMX8MN_SYS_PLL2_50M] =3D imx_clk_fixed_factor("sys_pll2_50m", "sys_p=
ll2_50m_cg", 1, 20);
 	clks[IMX8MN_SYS_PLL2_100M] =3D imx_clk_fixed_factor("sys_pll2_100m", "sys=
_pll2_100m_cg", 1, 10);
--=20
2.16.4

