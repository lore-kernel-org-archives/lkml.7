Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EE0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF772196F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XYFtd5jQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfIIDkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:40:21 -0400
Received: from mail-eopbgr20065.outbound.protection.outlook.com ([40.107.2.65]:12275
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728389AbfIIDkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzOM9Rgc5hzpZ2hszR+vi5PY3vr+YD+N0B0NcX/Du7qhTN5urmMptIRlSrmcLnxRRAV6vNceuQ/99ve/igcSnD8qJP9Ez6CplppaeWz+b9pJ+E8p2EbDRiJyl3uQna/nmxBJ+Xr6TaSN1g2ZSIEr42Q+B87Zy+Ws2LjX3CJnCyStHH439rKKY0tq2ZN14sZOPJX1sohY1bLCafFEZeikdQNx4V5Z5o8sncqFxWs9c8Sa7EQQMtFfAuO3GkZ0Bf4YcJEYHkOASYo4DCdjD31lT+ysgchwPwixCzPYsTEx50vsQR3CKYMnzhxKCczfAUPmFN2/W2zVxG6rXiss2RKzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q33wQNymR4+vJB/pc/bOj2rdH7HOEkJ6ySFDdRLt3DY=;
 b=kuiF2pne9QUNf0xofi0sybxB33jPugYb89/nmTVBPjKGqAAYyeNDs9DrQMyyc/OnpzH3gVs4/DFlXZUGIPO0Ph0wiViocqfLHaC70KL06oIyCNAuCBauGMyh8lpZKrgsfXy/VBivkuK09iOAkuO2sXpRke4QEERMLLiytIO+S0MdWS6N7qcus5eWGAXwUvI2LpF37LZQCnDwUSk7yrqbKZ6D5H7Nt7vlrq1TNaJwWipeq005PVdZ4DCaSXeeAZzVTGRXOtGSwBqYCDGpGelxMeimOe+hlCdcWeIDfIet5rQJvjzkKa8JaIyJ49uqdT6j8lN0dNJy45ouj6Yyfzpu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q33wQNymR4+vJB/pc/bOj2rdH7HOEkJ6ySFDdRLt3DY=;
 b=XYFtd5jQHSjxMf8kt8D6KPLJCSFcakJxtv86rwCZZDtrep+npVPJYNurbJcmWoCZyGmJZn2s7fuvM+MIrNlD4Wn3p+qnQUEDwQ8V1CAOyEbKh/OM6xvExLjTl0dhVvT/n/0QarxCcBDjRuLhMRQAZwu4iuuV2dv8m6AzXK2SgUA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6020.eurprd04.prod.outlook.com (20.179.32.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.19; Mon, 9 Sep 2019 03:39:45 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 03:39:45 +0000
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
Subject: [PATCH V3 3/4] clk: imx: imx8mm: fix pll mux bit
Thread-Topic: [PATCH V3 3/4] clk: imx: imx8mm: fix pll mux bit
Thread-Index: AQHVZsA4ERpqffdI60SGSU5jC9Bhww==
Date:   Mon, 9 Sep 2019 03:39:44 +0000
Message-ID: <1568043491-20680-4-git-send-email-peng.fan@nxp.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1568043491-20680-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:2e::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30e16abb-598a-4503-9225-08d734d75b27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6020;
x-ms-traffictypediagnostic: AM0PR04MB6020:|AM0PR04MB6020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB602076F7E88C472AB81AB50088B70@AM0PR04MB6020.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(7736002)(186003)(26005)(54906003)(316002)(66446008)(64756008)(76176011)(50226002)(446003)(2616005)(4326008)(6512007)(11346002)(44832011)(3846002)(6116002)(66946007)(102836004)(110136005)(2201001)(25786009)(8676002)(52116002)(2501003)(386003)(478600001)(36756003)(14454004)(99286004)(66556008)(5660300002)(66476007)(86362001)(71190400001)(6506007)(2906002)(256004)(476003)(486006)(53936002)(8936002)(6486002)(66066001)(81166006)(6436002)(71200400001)(81156014)(305945005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6020;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 97c4oZ+WoE+SAW/4xBauLYgrMW0b0cK6tadIxsI8ayBmSvemj7YBAHREA4E68r96/rzhaVseJeihN0YQD/76pHEy/IoGgas1x2F8aL8SVRyYLM7Uc7QTDR5TuBFvm9UHnBGDuMWY1rcWgdtc5SmI0Srky1gUaJywlzInkfPwQ7CtKox8sbmqr6R0j7TYyuAAYzIalGdewsRsGOj73sl5103R/ev4SgUjY5D5QKmLssZkrVFRaFhXSBQ++nPWt/rNYMZKEjkwLiHd78JKAN2qZdgln/kmV8DJhbZZ3wpslXpIxZel2KTyEbmOur/le8seH0rc/mDzMFtt7r99mJ1MaGmOB+GC5cJoFavQWElJscM7aVEnRgy7LC273R1jKhMmb/kgzVkGU89gQEIu0a/v/XEL9NhMPH+v5/7y6rSdEGU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e16abb-598a-4503-9225-08d734d75b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 03:39:44.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvwImkMeIbRkv2OQnOx2w5dARSUVyxTLvZLRSrXT45tzo3TaRLPZVr21cTlK7hwY3ua1rqP6cq0WaaXd1X3OEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6020
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

Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
Suggested-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 None
V2:
 New patch


 drivers/clk/imx/clk-imx8mm.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 2758e3f0d15d..067ab876911d 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -408,28 +408,16 @@ static int imx8mm_clocks_probe(struct platform_device=
 *pdev)
 	clks[IMX8MM_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",=
 base + 0x114, &imx8mm_sys_pll);
=20
 	/* PLL bypass out */
-	clks[IMX8MM_AUDIO_PLL1_BYPASS] =3D imx_clk_mux_flags("audio_pll1_bypass",=
 base, 4, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CL=
K_SET_RATE_PARENT);
-	clks[IMX8MM_AUDIO_PLL2_BYPASS] =3D imx_clk_mux_flags("audio_pll2_bypass",=
 base + 0x14, 4, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_se=
ls), CLK_SET_RATE_PARENT);
-	clks[IMX8MM_VIDEO_PLL1_BYPASS] =3D imx_clk_mux_flags("video_pll1_bypass",=
 base + 0x28, 4, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_se=
ls), CLK_SET_RATE_PARENT);
-	clks[IMX8MM_DRAM_PLL_BYPASS] =3D imx_clk_mux_flags("dram_pll_bypass", bas=
e + 0x50, 4, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK=
_SET_RATE_PARENT);
-	clks[IMX8MM_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", base =
+ 0x64, 4, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET=
_RATE_PARENT);
-	clks[IMX8MM_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", base =
+ 0x74, 4, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET=
_RATE_PARENT);
-	clks[IMX8MM_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x84, 4, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET=
_RATE_PARENT);
-	clks[IMX8MM_SYS_PLL1_BYPASS] =3D imx_clk_mux_flags("sys_pll1_bypass", bas=
e + 0x94, 4, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CLK=
_SET_RATE_PARENT);
-	clks[IMX8MM_SYS_PLL2_BYPASS] =3D imx_clk_mux_flags("sys_pll2_bypass", bas=
e + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CL=
K_SET_RATE_PARENT);
-	clks[IMX8MM_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", bas=
e + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CL=
K_SET_RATE_PARENT);
-
-	/* unbypass all the plls */
-	clk_set_parent(clks[IMX8MM_AUDIO_PLL1_BYPASS], clks[IMX8MM_AUDIO_PLL1]);
-	clk_set_parent(clks[IMX8MM_AUDIO_PLL2_BYPASS], clks[IMX8MM_AUDIO_PLL2]);
-	clk_set_parent(clks[IMX8MM_VIDEO_PLL1_BYPASS], clks[IMX8MM_VIDEO_PLL1]);
-	clk_set_parent(clks[IMX8MM_DRAM_PLL_BYPASS], clks[IMX8MM_DRAM_PLL]);
-	clk_set_parent(clks[IMX8MM_GPU_PLL_BYPASS], clks[IMX8MM_GPU_PLL]);
-	clk_set_parent(clks[IMX8MM_VPU_PLL_BYPASS], clks[IMX8MM_VPU_PLL]);
-	clk_set_parent(clks[IMX8MM_ARM_PLL_BYPASS], clks[IMX8MM_ARM_PLL]);
-	clk_set_parent(clks[IMX8MM_SYS_PLL1_BYPASS], clks[IMX8MM_SYS_PLL1]);
-	clk_set_parent(clks[IMX8MM_SYS_PLL2_BYPASS], clks[IMX8MM_SYS_PLL2]);
-	clk_set_parent(clks[IMX8MM_SYS_PLL3_BYPASS], clks[IMX8MM_SYS_PLL3]);
+	clks[IMX8MM_AUDIO_PLL1_BYPASS] =3D imx_clk_mux_flags("audio_pll1_bypass",=
 base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), C=
LK_SET_RATE_PARENT);
+	clks[IMX8MM_AUDIO_PLL2_BYPASS] =3D imx_clk_mux_flags("audio_pll2_bypass",=
 base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_s=
els), CLK_SET_RATE_PARENT);
+	clks[IMX8MM_VIDEO_PLL1_BYPASS] =3D imx_clk_mux_flags("video_pll1_bypass",=
 base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_s=
els), CLK_SET_RATE_PARENT);
+	clks[IMX8MM_DRAM_PLL_BYPASS] =3D imx_clk_mux_flags("dram_pll_bypass", bas=
e + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CL=
K_SET_RATE_PARENT);
+	clks[IMX8MM_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", base =
+ 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
+	clks[IMX8MM_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", base =
+ 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
+	clks[IMX8MM_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
+	clks[IMX8MM_SYS_PLL1_BYPASS] =3D imx_clk_mux_flags("sys_pll1_bypass", bas=
e + 0x94, 28, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CL=
K_SET_RATE_PARENT);
+	clks[IMX8MM_SYS_PLL2_BYPASS] =3D imx_clk_mux_flags("sys_pll2_bypass", bas=
e + 0x104, 28, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), C=
LK_SET_RATE_PARENT);
+	clks[IMX8MM_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", bas=
e + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), C=
LK_SET_RATE_PARENT);
=20
 	/* PLL out gate */
 	clks[IMX8MM_AUDIO_PLL1_OUT] =3D imx_clk_gate("audio_pll1_out", "audio_pll=
1_bypass", base, 13);
--=20
2.16.4

