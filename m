Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A155FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA6D20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQObsyyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfL3JNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:13:15 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:20292
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727267AbfL3JNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:13:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGK9XFDY5UmY8HtbqmD2v1kUGlXJFFP1SB4UXbRP6Wo/8l7z/+NOmZTZNncsZmRLruoqayfImMa+K0zIAShGDCLVYgStSfeYw8m2fIky+qirTphadYPvSidB1N/lRdVSYdNAofZImyxE2okZULvMEs9zkzL3ebrDthsAkZSNT9wNSWQaeVeJzGyi9cZqLwlVG5RdnkoGaB/k8a8iBWZ3jhgZdcSGbPDfx6iz6g4oMsua19U0z0ixgX+xOAtgXHFKCzO7cP7PHfrvnQzP/ipsflToddHpVK2Itkih/WcUWxc1elMhfBoeoJIog44hSEMFrbnP5COR1uPIjdRPkqpNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozk4iXgh/7e/KqpdllhBQgFjyUvd8vUZ0U4pzwDjvxU=;
 b=PP1cIlR3by9GPG+VsNe0cB31k78e9BOvDjrdUDnDifrTBVfz1HhUDjetaoXw5AdQg4AknNPZrB7Bx+t22CywYBYcre4NltJCIN7RjAUSSfgdWFtIQMkHjT9R87t31edzDsqRCw2rfudwWR9s+pz+fqWtns18WCZ435b8BIks8I7DZN/q+vJjVWhDmP2lgS17uWkhNIJZfaZdIIqhlXQ+QIX3SAf8ygqT6oALSi12BuoHaPjh+F5HOcfNXUHqe7lK7fV/IG16tH3Kqqc6DVGD8C4anX/AKDuhogbEDY3J+4B9BveIQIXIeFT5EqgD6rfqJUL05tIMs3HdpjRNZB+LsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozk4iXgh/7e/KqpdllhBQgFjyUvd8vUZ0U4pzwDjvxU=;
 b=fQObsyyvpWfB3qLMsdz0c2RbAMrGPRfwoHH+kTB82Vjk1yguY7CmOF47IxgdWRCCTmKV8sooxuvir99cwTZMfWeEhGTTK4sNr2oLTGFikl8UqYKu7PStCwkRhFOpeQhLwcTIrAjCgOpqaxxaNmOxoVcBDAXqLKw9viDtDNjxHgU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6401.eurprd04.prod.outlook.com (20.179.254.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 09:13:10 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::c58c:e631:a110:ba58%6]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 09:13:10 +0000
Received: from localhost.localdomain (119.31.174.67) by HK2PR03CA0057.apcprd03.prod.outlook.com (2603:1096:202:17::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.8 via Frontend Transport; Mon, 30 Dec 2019 09:13:06 +0000
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
Subject: [PATCH 3/3] clk: imx: imx8m: use imx_clk_hw_pll14xx_flags for dram
 pll
Thread-Topic: [PATCH 3/3] clk: imx: imx8m: use imx_clk_hw_pll14xx_flags for
 dram pll
Thread-Index: AQHVvvFbxKyPeAf2oEWw9V8pqxLyug==
Date:   Mon, 30 Dec 2019 09:13:10 +0000
Message-ID: <1577696903-27870-4-git-send-email-peng.fan@nxp.com>
References: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1577696903-27870-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42829551-2c58-46b1-3b16-08d78d087d85
x-ms-traffictypediagnostic: AM0PR04MB6401:|AM0PR04MB6401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB64015307A4C988EB80AC453588270@AM0PR04MB6401.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(81166006)(81156014)(6506007)(66946007)(69590400006)(71200400001)(66476007)(66556008)(8676002)(52116002)(4326008)(66446008)(64756008)(26005)(8936002)(2616005)(110136005)(6486002)(54906003)(6666004)(956004)(86362001)(6636002)(316002)(16526019)(186003)(478600001)(36756003)(5660300002)(2906002)(6512007)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6401;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/Aj+4H26luSTUJBNYrwQfvdkPAIE7fquu+FLEi9++KkPnwB/ki1q3nbOloRy00mNxdgujlYC79WWRUp+PKEWibflD+STroTw1dorur4hHMrRAc2fKK42/Ewk4fobfXKgbX/YRTaOw7C+Cz6ZMWP/beygU6O1EY/yhEWEGl2od1a56oYFYWuM8tN9UbLs9ZxUV9Vlhk0GsKrnMNn/YHuW1bSquCJbWIwMsCWbuWkOsVXXFgzp3Ll8zcMBGuTad7lWMNHmXcg2/MYQyg0INigZpQYy/3IkcOTC3+BOc1nKD0yE9PzsTYW4G6MjOp2I1F70F5dBhj3/nqK8RSt1V+RL5ca0tjex7TA5dDdoTFaguqCscvMjwvLcnq6dg4FWP24c1a1juZWkWtcjanmP6Bf2WJWTH3Nmla5hpHi4W0PQnXsXTCPR8k5i9FKQAL+rbBo9o5s1uM9xCohaxmAdj6u8KasRuCqmeJnw3NtgE+kLlRMimLg0ZwHHEAO5rhl/j6uLXucTeRypps5EENDTPiMQg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42829551-2c58-46b1-3b16-08d78d087d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 09:13:10.4560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzNACm0XTZut76tukBFkfWnywltQrevlk8vez33vt7IeHWRAg90C5ALTuoRGic6S6hc8p+AW393xn2XKFcYQOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use imx_clk_hw_pll14xx_flags for dram pll.
Modify imx_1443x_dram_pll to imx_1443x_dram_readonly, because dram pll
is not expected to be modified from Linux.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c  | 2 +-
 drivers/clk/imx/clk-imx8mn.c  | 2 +-
 drivers/clk/imx/clk-pll14xx.c | 3 +--
 drivers/clk/imx/clk.h         | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 2ed93fc25087..55862652b19f 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -337,7 +337,7 @@ static int imx8mm_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MM_AUDIO_PLL1] =3D imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_r=
ef_sel", base, &imx_1443x_pll);
 	hws[IMX8MM_AUDIO_PLL2] =3D imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_r=
ef_sel", base + 0x14, &imx_1443x_pll);
 	hws[IMX8MM_VIDEO_PLL1] =3D imx_clk_hw_pll14xx("video_pll1", "video_pll1_r=
ef_sel", base + 0x28, &imx_1443x_pll);
-	hws[IMX8MM_DRAM_PLL] =3D imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel=
", base + 0x50, &imx_1443x_dram_pll);
+	hws[IMX8MM_DRAM_PLL] =3D imx_clk_hw_pll14xx_flags("dram_pll", "dram_pll_r=
ef_sel", base + 0x50, &imx_1443x_pll_readonly, CLK_GET_RATE_NOCACHE);
 	hws[IMX8MM_GPU_PLL] =3D imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", =
base + 0x64, &imx_1416x_pll);
 	hws[IMX8MM_VPU_PLL] =3D imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", =
base + 0x74, &imx_1416x_pll);
 	hws[IMX8MM_ARM_PLL] =3D imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", =
base + 0x84, &imx_1416x_pll);
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index c5e7316b4c66..e4710d3cf3e0 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -334,7 +334,7 @@ static int imx8mn_clocks_probe(struct platform_device *=
pdev)
 	hws[IMX8MN_AUDIO_PLL1] =3D imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_r=
ef_sel", base, &imx_1443x_pll);
 	hws[IMX8MN_AUDIO_PLL2] =3D imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_r=
ef_sel", base + 0x14, &imx_1443x_pll);
 	hws[IMX8MN_VIDEO_PLL1] =3D imx_clk_hw_pll14xx("video_pll1", "video_pll1_r=
ef_sel", base + 0x28, &imx_1443x_pll);
-	hws[IMX8MN_DRAM_PLL] =3D imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel=
", base + 0x50, &imx_1443x_dram_pll);
+	hws[IMX8MN_DRAM_PLL] =3D imx_clk_hw_pll14xx_flags("dram_pll", "dram_pll_r=
ef_sel", base + 0x50, &imx_1443x_pll_readonly, CLK_GET_RATE_NOCACHE);
 	hws[IMX8MN_GPU_PLL] =3D imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", =
base + 0x64, &imx_1416x_pll);
 	hws[IMX8MN_VPU_PLL] =3D imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", =
base + 0x74, &imx_1416x_pll);
 	hws[IMX8MN_ARM_PLL] =3D imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", =
base + 0x84, &imx_1416x_pll);
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 030159dc4884..33236d8580a6 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -67,9 +67,8 @@ struct imx_pll14xx_clk imx_1443x_pll =3D {
 	.rate_count =3D ARRAY_SIZE(imx_pll1443x_tbl),
 };
=20
-struct imx_pll14xx_clk imx_1443x_dram_pll =3D {
+struct imx_pll14xx_clk imx_1443x_pll_readonly =3D {
 	.type =3D PLL_1443X,
-	.flags =3D CLK_GET_RATE_NOCACHE,
 };
=20
 struct imx_pll14xx_clk imx_1416x_pll =3D {
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 35a9d294b6df..ea84d2993b57 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -53,7 +53,7 @@ struct imx_pll14xx_clk {
=20
 extern struct imx_pll14xx_clk imx_1416x_pll;
 extern struct imx_pll14xx_clk imx_1443x_pll;
-extern struct imx_pll14xx_clk imx_1443x_dram_pll;
+extern struct imx_pll14xx_clk imx_1443x_pll_readonly;
=20
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
--=20
2.16.4

