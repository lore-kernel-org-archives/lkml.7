Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3F4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C0D208CC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fS7EkJ7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfKSOI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:08:56 -0500
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:9830
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfKSOIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:08:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsIGOv4pB6qrNHEm4tpW/BXogeKroFYkqd8RFhsKjxPlvXCpXjEtVu7bZFEi755kwlALKE00e9pgKeFexxfmrajBb84o8ExNYm1lcphgLXZb4riNNFn2Lrw1j9EZ8COOC6cYCCDV3xl8yyG76kVmAY9wDbMFYilfVzN3vvUqXGSY52sYL0fBd+/vhVksHhL+FAaeP89slahv8/6JuIItW09z8gk3kqH+rZROBXqE0XHaKdYLUjHvrs5vJnLWG4C3z9h2y8JBZaOfP6zEdW0mUs7h2WW4WQtjSwmpeQrXihw4raKjPSAyb4VfjZ1/z+buT05IrvaXVgGTyWY8Gya6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66s2Aw7dxP/eyz96U0KNgNLcES/gPmfT1c44nvQ8NCg=;
 b=AGoo1RHdiluYlbgZEIBPUp5rlPl+2TCSWrU2u/N+z5sZc8SfGk0GEArsTWkTqt59wEazo30PHjtoAc5Gd+dh+XJ5CWhTJWzTfDWF93aGRZuoaWA5wO6/eJON4qSgWnr+ru1BKbuQ2Omb4KMDxv6unjJxmz7nTnZhPeTMJIu7p0ALej5yv0yqSHqrqa/bdmjD1p9wz0OGjG5dkbfoug3fxTXZ2YyTJZ8Ag02IouDafhBkMdshy59uwttYp0wEAcwMFQZ5rSXaBrctCmnRcyAi7ieIX2jg0B774tCP53xEJ6+t7LwJZHXICKzzrjs37rErVlQ6FBBHP2BaKumSs9/RkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66s2Aw7dxP/eyz96U0KNgNLcES/gPmfT1c44nvQ8NCg=;
 b=fS7EkJ7uPii4Bs95m+FSHuREuq6vERrfyHdriN5dncRB3A9aFOucPUwtKuSPxp+XzIEz7lzxCSC0f0ktL0DsdxCY5bebOcfzPI/8+irTBxJcL0L3XvJRP6Hf5T0kBXCqOwtlHLFY/zFW7J25GMm7WZUT1YgyJtky2mpvUkMmXbc=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5428.eurprd04.prod.outlook.com (20.178.113.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 14:08:44 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 14:08:44 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 6/9] clk: imx: Rename the imx_clk_pllv4 to imply it's clk_hw
 based
Thread-Topic: [PATCH 6/9] clk: imx: Rename the imx_clk_pllv4 to imply it's
 clk_hw based
Thread-Index: AQHVnuLah5niBuRWuUeefZLYUMdtgw==
Date:   Tue, 19 Nov 2019 14:08:44 +0000
Message-ID: <1574172496-12987-7-git-send-email-abel.vesa@nxp.com>
References: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:208:122::39) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fab66bf9-096c-4004-e3f0-08d76cf9fd09
x-ms-traffictypediagnostic: AM0PR04MB5428:|AM0PR04MB5428:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5428D4C1B547AD30568128FBF64C0@AM0PR04MB5428.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(110136005)(256004)(86362001)(316002)(66446008)(66556008)(66476007)(64756008)(66946007)(36756003)(446003)(7736002)(305945005)(186003)(3846002)(6116002)(26005)(5660300002)(478600001)(52116002)(76176011)(99286004)(2616005)(66066001)(54906003)(2906002)(11346002)(6506007)(476003)(44832011)(386003)(6636002)(486006)(6486002)(102836004)(25786009)(8936002)(71200400001)(81156014)(81166006)(71190400001)(50226002)(6512007)(4326008)(6436002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5428;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bRUJ+b5mHbzDjrk93mSO+UFbk3JNcNeq+07EE0u4v0ym5KD6nBY5kwKPuv5Oenv70U7cOb2cEXW087ekB3lH+Bo6k63hMG715gJQoqEdoJaQssSXC9aRkdKWLZ7lKHJyzoWysprsC/KelQxBERc+Zry1wqdE+ImNsCwQM/tvaNVQaiyLo70zRsrCzevG2zFx96v53VjLIWun5HMKG5NyFDApIgBO6e38uvY2LRz8kHDAfTD3tMb0roZWcRBOCTePxSecIrDA4ppjRsQABHXbnmtzwKP6WhMK7rPVC41DjIskzekmGFl4Z6+dg7+/lhvOvHJ6E3ghBHVAK49GXZSpnhvIuaudVd49egHjNN1R6DZ6KLU1EUk/VU/d0NeyUCBVqeabWKn4xYdz6b1PUnelj3gv8U9r/tDJ41BqFg0rQYXMAeiXK6t3V8fg/cQk2M+d
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab66bf9-096c-4004-e3f0-08d76cf9fd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 14:08:44.6223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3F+w2UAvi1kZvb6od5jQ7qPbKwVhG+JtkQ8askCocQ1rSDRhdgmXU1fRz1/4HvDqpBQNNZGnTR3SKOFe5moGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5428
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming the imx_clk_pllv4 register function to imx_clk_hw_pllv4 to be
more obvious it is clk_hw based.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 4 ++--
 drivers/clk/imx/clk-pllv4.c   | 2 +-
 drivers/clk/imx/clk.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 64b79a8..afd2c2c 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -90,8 +90,8 @@ static void __init imx7ulp_clk_scg1_init(struct device_no=
de *np)
 	clks[IMX7ULP_CLK_SPLL_PRE_DIV]	=3D imx_clk_hw_divider_flags("spll_pre_div=
", "spll_pre_sel", base + 0x608,	8,	3,	CLK_SET_RATE_GATE);
=20
 	/*						name	 parent_name	 base */
-	clks[IMX7ULP_CLK_APLL]		=3D imx_clk_pllv4("apll",  "apll_pre_div", base +=
 0x500);
-	clks[IMX7ULP_CLK_SPLL]		=3D imx_clk_pllv4("spll",  "spll_pre_div", base +=
 0x600);
+	clks[IMX7ULP_CLK_APLL]		=3D imx_clk_hw_pllv4("apll",  "apll_pre_div", bas=
e + 0x500);
+	clks[IMX7ULP_CLK_SPLL]		=3D imx_clk_hw_pllv4("spll",  "spll_pre_div", bas=
e + 0x600);
=20
 	/* APLL PFDs */
 	clks[IMX7ULP_CLK_APLL_PFD0]	=3D imx_clk_pfdv2("apll_pfd0", "apll", base +=
 0x50c, 0);
diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
index 8155b12..f51a800 100644
--- a/drivers/clk/imx/clk-pllv4.c
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -206,7 +206,7 @@ static const struct clk_ops clk_pllv4_ops =3D {
 	.is_enabled	=3D clk_pllv4_is_enabled,
 };
=20
-struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pllv4(const char *name, const char *parent_name,
 			  void __iomem *base)
 {
 	struct clk_pllv4 *pll;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 15c6f54..0ac6614 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -175,7 +175,7 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type typ=
e, const char *name,
 		.kdiv	=3D	(_k),			\
 	}
=20
-struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pllv4(const char *name, const char *parent_name,
 			     void __iomem *base);
=20
 struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
--=20
2.7.4

