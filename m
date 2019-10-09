Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A210ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EC821721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qAU1i7Yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfJIJ63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:58:29 -0400
Received: from mail-eopbgr00046.outbound.protection.outlook.com ([40.107.0.46]:60973
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfJIJ62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:58:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpKoBv1E2xUHgOOVYJ5TMES6wRrRxkD8AyBra/hnH/OnRArqdywOC2Bt0c70D71/uqjI0bSBmZVGjImCbAyHJSDhGY5F3BmUA0w3XhYPzEFVDee5jGSlXgfLFdUIXfa0QuJjabzGm6uT/C/opAjpLq+2qH7luqMOp/fq48xjpvkpm5as7zM8KDn6d/M4+bV1VbltGyohztf7co8WRnORv8+PdvPmlRu7X/tUzKPDV6p243WSchwJfCSL8Kv6nQG1xvC7gFgwulio8XBu/Jpdid5gpvi6w+2nxw9uxjLOJsGs+BIBf5J7PPle2enMYJDh4vDWeJmNCAjBHegWyK4/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSzFpODKc67XYuOCxswXfSw5qiLz15M5+3ZAx/FYuyE=;
 b=MMTlyku0CE0m/0Jki5CtvIMwcF3SZNZZ3KZiTqxoVjaEXyt9qPJjkklCpvXhQyuteOYDG0ZqOBMPRBmJo3i2213sebbNVGTUOuQLoPtB8AmXfrqP9og6eLPc/KFhWFduFq69GPMcUZXTYseOTYvhh1aQyr542Cj2/6kRKg/OcUR48NSOVXdeUHZhd9tD/xTRa+26IdmndGueHf/YEartViP1gT7bDeiKvvX/s4C5kdv4x8fGFqMFicvpIhwkSexlTfmhIFSTYuP4TM3kFb5vocat3jZlkeqy4pVbZtUBNqSnynXqVQlhObsjEyk87vud9/0gm4K3xxEoE+riWzM3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSzFpODKc67XYuOCxswXfSw5qiLz15M5+3ZAx/FYuyE=;
 b=qAU1i7YiJxMRLoCN6xGhFztR2ShjMUmwikBldStk3LvzThhbCzR9CTcQ9KlDnwJOeHj3W+/4PF63W0ouxfRCdyvFZWnI62qb2RlIJ2eLKTlrT+5SVj89RifLtpCvhZyc81lNktUP7ZYi8/i2KlUXhsZw/bdrBAlSfZGL8/AlfUs=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4177.eurprd04.prod.outlook.com (52.134.92.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 09:58:24 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 09:58:24 +0000
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
Subject: [PATCH 3/3] clk: imx: imx8mq: mark sys1/2_pll as fixed clock
Thread-Topic: [PATCH 3/3] clk: imx: imx8mq: mark sys1/2_pll as fixed clock
Thread-Index: AQHVfogX6prUJXTnUkuiKNz4VeFjwQ==
Date:   Wed, 9 Oct 2019 09:58:24 +0000
Message-ID: <1570614940-17239-3-git-send-email-peng.fan@nxp.com>
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
x-ms-office365-filtering-correlation-id: e73fbee9-136c-4fe9-0080-08d74c9f3984
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB4177:|AM0PR04MB4177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB417737051DD81A201749C37988950@AM0PR04MB4177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(476003)(64756008)(478600001)(8676002)(14454004)(81166006)(81156014)(4326008)(446003)(11346002)(5660300002)(66556008)(2906002)(36756003)(66446008)(66476007)(256004)(3846002)(186003)(66946007)(486006)(26005)(6116002)(6486002)(2616005)(305945005)(25786009)(7736002)(316002)(110136005)(66066001)(54906003)(2201001)(6436002)(52116002)(99286004)(6512007)(44832011)(50226002)(102836004)(71190400001)(71200400001)(76176011)(8936002)(2501003)(86362001)(386003)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4177;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CuLJ+J7e7AK/2qGFiUwZNBldMMPlQZ/vfzWD2AVtrSNpBK2ZiinD4WkrwdWNSPDdru+rE2lbvj5RpACfpw3871bWjCeXztEi44KSJ6ADcmlPL8aMxctZrUapK26mL5HSpprODjRn+6QHESoEZsAyf8rxrpBbqOJY1woh9whph/oTnIA9mvo6CIn+13DBkdJ6XR+mQlrheNilVLghzBg4EyEvypH9GjgM6+FNn6ElG5TeMmYuXkm/ktsQO4JxzIs1mCMjL04drbUORbdQak2WsquAbwMX2ETKMoUigcGJvLdAIY+HVvP4OdVBGWQatfjhiVCBtlQttCguPJ1MQky1LpsCqK5+Fv8ZZ5NsnwprJ3eHATc91TsBdTr2392UgWRUCbMleTLHVlZrfIu8ZELzKYaeSZGFBTJncclij3mbTT8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73fbee9-136c-4fe9-0080-08d74c9f3984
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 09:58:24.6616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nfnw5wL/s1gkJnMquYh+WXbJfqivPupn/+NMuqOa6B/IAmLiEvKyZCgHZOyB0SvEwT9/Dk5EL5hiAUe2kT4DqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According Architecture definition guide, SYS1_PLL is fixed at
800MHz, SYS2_PLL is fixed at 1000MHz, so let's use imx_clk_fixed
to register the clocks and drop code that could change the rate.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 41fc9c63356e..403f6ba4c638 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -34,8 +34,6 @@ static const char * const audio_pll1_bypass_sels[] =3D {"=
audio_pll1", "audio_pll1_
 static const char * const audio_pll2_bypass_sels[] =3D {"audio_pll2", "aud=
io_pll2_ref_sel", };
 static const char * const video_pll1_bypass_sels[] =3D {"video_pll1", "vid=
eo_pll1_ref_sel", };
=20
-static const char * const sys1_pll_out_sels[] =3D {"sys1_pll1_ref_sel", };
-static const char * const sys2_pll_out_sels[] =3D {"sys1_pll1_ref_sel", "s=
ys2_pll1_ref_sel", };
 static const char * const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel", "s=
ys2_pll1_ref_sel", };
 static const char * const dram_pll_out_sels[] =3D {"dram_pll1_ref_sel", };
=20
@@ -307,8 +305,6 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MQ_AUDIO_PLL1_REF_SEL] =3D imx_clk_mux("audio_pll1_ref_sel", bas=
e + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_AUDIO_PLL2_REF_SEL] =3D imx_clk_mux("audio_pll2_ref_sel", bas=
e + 0x8, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_VIDEO_PLL1_REF_SEL] =3D imx_clk_mux("video_pll1_ref_sel", bas=
e + 0x10, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MQ_SYS1_PLL1_REF_SEL]	=3D imx_clk_mux("sys1_pll1_ref_sel", base =
+ 0x30, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MQ_SYS2_PLL1_REF_SEL]	=3D imx_clk_mux("sys2_pll1_ref_sel", base =
+ 0x3c, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_SYS3_PLL1_REF_SEL]	=3D imx_clk_mux("sys3_pll1_ref_sel", base =
+ 0x48, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_DRAM_PLL1_REF_SEL]	=3D imx_clk_mux("dram_pll1_ref_sel", base =
+ 0x60, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
=20
@@ -342,8 +338,8 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MQ_AUDIO_PLL2_OUT] =3D imx_clk_gate("audio_pll2_out", "audio_pll=
2_bypass", base + 0x8, 21);
 	clks[IMX8MQ_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "video_pll=
1_bypass", base + 0x10, 21);
=20
-	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_sccg_pll("sys1_pll_out", sys1_pll_o=
ut_sels, ARRAY_SIZE(sys1_pll_out_sels), 0, 0, 0, base + 0x30, CLK_IS_CRITIC=
AL);
-	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_sccg_pll("sys2_pll_out", sys2_pll_o=
ut_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 1, base + 0x3c, CLK_IS_CRITIC=
AL);
+	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_fixed("sys1_pll_out", 800000000);
+	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_fixed("sys2_pll_out", 1000000000);
 	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll_o=
ut_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 0x48, CLK_IS_CRITIC=
AL);
 	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_pll_o=
ut_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRITIC=
AL);
 	/* SYS PLL fixed output */
--=20
2.16.4

