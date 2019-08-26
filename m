Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB1CC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E076E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TMJvAev6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfHZJnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:43:07 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:64203
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfHZJnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:43:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi6RYD+SjeurhXpLE3nPlQmGAVSTfxQlXH2gBxfcLTtWy1JVFKMlZCKg2XdAj9nMmra03jKsTKPvc/sur/d9fJG9ja85Yk2CQHTQQDHeRBQp2to6Ye34DwYfeDET2PqLU8b7rjbZYp4xDnSCZt+CbFQZfZqZrieK9mviPQEc2tjeVtqUhn3EDtvFC6ZPQ361Tec5zUF4SnFIGg5jE2we/wIkKDBC7MAE+70kgGGU6tBHnrVr3TGpG0MUC+djw9/Y/12KVCcHH39LlpaP+Xbs7WcmOwRfhlnDV4kA97/HX7oecVz2/FWd68esg1qs/eddpruXRngJoizTXK+Ai6U9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB2bynW8QQSEPsZGZKK19Pks/PspI/99iPJ5kYvB8Sg=;
 b=H/RilT3W6lwtTeC39y3pcs+8V5SGjPEXCH5iaxzMZDdRmMu5GaRsazwfU+ZDAf5i1B8WBt0bm32QWv3uZSf7slzb0jvRO+FUYUHKgwx/Cf3DK57hTCdtzY66FDf9hAt4Yp1LZddfEZPYeWOYODB7Y3+IM0bvLP0dZW09aKoiTRssc4WomtxQETVqtAlt3puPLh5dOJxD0jn+SeY9BzimiwgtA/hZ9wko9I7C0Ym6BmuqkUutvKSfoecb4bsq2VaV1W3R+8PKeumNw3rj3PKPViMyXmAeIaB1j/dYops9k8Hl6NY++yLbHvTjzChVtms6Ls9TzXEPt1ZgzPeh5QuKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB2bynW8QQSEPsZGZKK19Pks/PspI/99iPJ5kYvB8Sg=;
 b=TMJvAev65BrFn02dFD8PswmXO1UOxPGE8uF6AYWbPhuQD5EwZJvj0IHzeCQbOfKgko2lYWSc9L0g/IPjGP9i5mhzFTLCw/s7LpsPBpvcOR95XtXTb9oaJP1FBPSgGY/MBlL1qZjlxO1VuH8f2rfntUA8y3/iadXpqXzZSdxJ+Nc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4194.eurprd04.prod.outlook.com (52.134.126.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 09:42:29 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.022; Mon, 26 Aug 2019
 09:42:29 +0000
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
Subject: [PATCH V2 4/4] clk: imx: imx8mn: fix pll mux bit
Thread-Topic: [PATCH V2 4/4] clk: imx: imx8mn: fix pll mux bit
Thread-Index: AQHVW/KT//ZDiQGtQ06vuK52YZANww==
Date:   Mon, 26 Aug 2019 09:42:29 +0000
Message-ID: <1566855676-11510-4-git-send-email-peng.fan@nxp.com>
References: <1566855676-11510-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1566855676-11510-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b2324b1-f90a-4c46-5c4d-08d72a09b5ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4194;
x-ms-traffictypediagnostic: AM0PR04MB4194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4194F443F09D48DE0A14311188A10@AM0PR04MB4194.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(478600001)(2501003)(25786009)(66066001)(81166006)(81156014)(66476007)(44832011)(7736002)(486006)(305945005)(2616005)(476003)(36756003)(8676002)(66946007)(66556008)(66446008)(64756008)(14454004)(316002)(110136005)(54906003)(6116002)(256004)(8936002)(50226002)(2201001)(99286004)(4326008)(6512007)(2906002)(86362001)(53936002)(386003)(76176011)(71200400001)(71190400001)(6506007)(102836004)(186003)(11346002)(446003)(26005)(5660300002)(52116002)(3846002)(6436002)(6486002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4194;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H024aMziwpUMF9sYG4r4gJaiZhcyCtyBXa8bdRcVom4eTjdH8JrMtOCDQoi391CUySONK47owh2nPvdmb8xMHSyGlUQHQSek8WgIaVGWoVXQ8H6esRf7qEK41962sPUAEhzXdJZvny3JwenuELWrNYIVFFF5dF2n68ViUh+dpJEr3FKuzjF6BNUd5jAvlWw/p3h8freFwcbFq3SI2xpjEAToZU4rvTcIlnj3ia8V0c3voN0Fg54e88V7/cR9ZIYrYDfMf+lHKMLu6pBcF6gscZWlrjpLZS+1QpMK6d0ezwp9JrhIiXZl4TYzO3yQd4GUyt2Q8LMSSVdJAj17I4v6yZT5YyuvCebvdt5KkkU4F6mxC4IjIn64PFk4S2Eoc35Av/zgjvIGCdiG+zL3F9Afn/uSQIJ9esbZUp2kcnho1xw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2324b1-f90a-4c46-5c4d-08d72a09b5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 09:42:29.3720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p28SuTpz8xrgyTj54uohO+B9OowvOWxm/Lsiz2W3GxktqEK7/4hhNnmtwiatuvzvi3Ela6Ys6RRt8t3L+0NzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

pll BYPASS bit should be kept inside pll driver for glitchless freq
setting following spec. If exposing the bit, that means pll driver and
clk driver has two paths to touch this bit, which is wrong.

So use EXT_BYPASS bit here.

And drop uneeded set parent, because EXT_BYPASS default is 0.

Suggested-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 New patch

 drivers/clk/imx/clk-imx8mn.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index f41116d59749..f767d18679ea 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -421,28 +421,16 @@ static int imx8mn_clocks_probe(struct platform_device=
 *pdev)
 	clks[IMX8MN_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",=
 base + 0x114, &imx8mn_sys_pll);
=20
 	/* PLL bypass out */
-	clks[IMX8MN_AUDIO_PLL1_BYPASS] =3D imx_clk_mux_flags("audio_pll1_bypass",=
 base, 4, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CL=
K_SET_RATE_PARENT);
-	clks[IMX8MN_AUDIO_PLL2_BYPASS] =3D imx_clk_mux_flags("audio_pll2_bypass",=
 base + 0x14, 4, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_se=
ls), CLK_SET_RATE_PARENT);
-	clks[IMX8MN_VIDEO_PLL1_BYPASS] =3D imx_clk_mux_flags("video_pll1_bypass",=
 base + 0x28, 4, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_se=
ls), CLK_SET_RATE_PARENT);
-	clks[IMX8MN_DRAM_PLL_BYPASS] =3D imx_clk_mux_flags("dram_pll_bypass", bas=
e + 0x50, 4, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK=
_SET_RATE_PARENT);
-	clks[IMX8MN_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", base =
+ 0x64, 4, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET=
_RATE_PARENT);
-	clks[IMX8MN_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", base =
+ 0x74, 4, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET=
_RATE_PARENT);
-	clks[IMX8MN_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x84, 4, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET=
_RATE_PARENT);
-	clks[IMX8MN_SYS_PLL1_BYPASS] =3D imx_clk_mux_flags("sys_pll1_bypass", bas=
e + 0x94, 4, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CLK=
_SET_RATE_PARENT);
-	clks[IMX8MN_SYS_PLL2_BYPASS] =3D imx_clk_mux_flags("sys_pll2_bypass", bas=
e + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CL=
K_SET_RATE_PARENT);
-	clks[IMX8MN_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", bas=
e + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CL=
K_SET_RATE_PARENT);
-
-	/* unbypass all the plls */
-	clk_set_parent(clks[IMX8MN_AUDIO_PLL1_BYPASS], clks[IMX8MN_AUDIO_PLL1]);
-	clk_set_parent(clks[IMX8MN_AUDIO_PLL2_BYPASS], clks[IMX8MN_AUDIO_PLL2]);
-	clk_set_parent(clks[IMX8MN_VIDEO_PLL1_BYPASS], clks[IMX8MN_VIDEO_PLL1]);
-	clk_set_parent(clks[IMX8MN_DRAM_PLL_BYPASS], clks[IMX8MN_DRAM_PLL]);
-	clk_set_parent(clks[IMX8MN_GPU_PLL_BYPASS], clks[IMX8MN_GPU_PLL]);
-	clk_set_parent(clks[IMX8MN_VPU_PLL_BYPASS], clks[IMX8MN_VPU_PLL]);
-	clk_set_parent(clks[IMX8MN_ARM_PLL_BYPASS], clks[IMX8MN_ARM_PLL]);
-	clk_set_parent(clks[IMX8MN_SYS_PLL1_BYPASS], clks[IMX8MN_SYS_PLL1]);
-	clk_set_parent(clks[IMX8MN_SYS_PLL2_BYPASS], clks[IMX8MN_SYS_PLL2]);
-	clk_set_parent(clks[IMX8MN_SYS_PLL3_BYPASS], clks[IMX8MN_SYS_PLL3]);
+	clks[IMX8MN_AUDIO_PLL1_BYPASS] =3D imx_clk_mux_flags("audio_pll1_bypass",=
 base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), C=
LK_SET_RATE_PARENT);
+	clks[IMX8MN_AUDIO_PLL2_BYPASS] =3D imx_clk_mux_flags("audio_pll2_bypass",=
 base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_s=
els), CLK_SET_RATE_PARENT);
+	clks[IMX8MN_VIDEO_PLL1_BYPASS] =3D imx_clk_mux_flags("video_pll1_bypass",=
 base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_s=
els), CLK_SET_RATE_PARENT);
+	clks[IMX8MN_DRAM_PLL_BYPASS] =3D imx_clk_mux_flags("dram_pll_bypass", bas=
e + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CL=
K_SET_RATE_PARENT);
+	clks[IMX8MN_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", base =
+ 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
+	clks[IMX8MN_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", base =
+ 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
+	clks[IMX8MN_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
+	clks[IMX8MN_SYS_PLL1_BYPASS] =3D imx_clk_mux_flags("sys_pll1_bypass", bas=
e + 0x94, 28, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CL=
K_SET_RATE_PARENT);
+	clks[IMX8MN_SYS_PLL2_BYPASS] =3D imx_clk_mux_flags("sys_pll2_bypass", bas=
e + 0x104, 28, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), C=
LK_SET_RATE_PARENT);
+	clks[IMX8MN_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", bas=
e + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), C=
LK_SET_RATE_PARENT);
=20
 	/* PLL out gate */
 	clks[IMX8MN_AUDIO_PLL1_OUT] =3D imx_clk_gate("audio_pll1_out", "audio_pll=
1_bypass", base, 13);
--=20
2.16.4

