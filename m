Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E714CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A14A2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrIhn/XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbfJ2Nk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:40:59 -0400
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:56291
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726858AbfJ2Nk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:40:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+epHnL7HRhw8geFkgBBQTRVTm+Rhfc5YeB89E/y4HIafureSWnukKjjZlOM2+kUgnsZw5Z0300TfdpVDcRyAcQ+UEjAvQUGD/kTii1rWixkWMGRpZqZeAJVt8vp5XOFEFAB0kLPASsjXQw/U/+2e9CV7AoUXNuCVvFv24jW0p6vnhRwVVV9Psy/nsGGYsZeyCCsSwbpXoRevnLhr/uVKVJm3vyw5U3dt2zUarwskjAawS92BTRpXHeEXE9Oi8jjQyYve+DsnBSnE7BT/zjn6Sb4qqefYGyMyKa2xWzB8yrCtSm1uL2qbx57+qJA7nxygIa5mDEun43LmK9mz7BA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+eVfGsjCWdf4WkfHzYME8GXxw5D7OLLAFA2jT61tdg=;
 b=KENxGICY8oSKf6iUxtc/Zdx2AAZvlrBCRZkyJs7ws25hk5ibxrTaxVDfMEylc6lzqz2auMrw2l7lY7cRLY1EF6oXUbywgEPTE3zUDJ5m2D+189WnX2pPvAZNLtM3FAv7RbiatFu4BAEcwMhsqgSrbW1Qa0EGEARniQSKM6veO/EkbYhyhE+f2tYKWWbQhALul7qL9ZQrvdfazneD2HwQCBgX/XhMrB+x6pu5PV4x34eKDNtEkoi/Fqo72RHcZXRqL5SutRxlbgsHvc94z94RPSo51ycbfsQwO4a+k2+KEB69kMQ6XKskUZ7X4vxz2ST7PjOZ2eVeFBCpvK9ZDC2aZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+eVfGsjCWdf4WkfHzYME8GXxw5D7OLLAFA2jT61tdg=;
 b=ZrIhn/XDnydjukMOEhOynOs2DrhCaYGces8DuP8s9lBJTMvOvaLO326c41RLgzF3Zr+L2MWhbtrWAox3Zuas4/0Rv3vlmiDmM03L/kLT0OV69Ktl42x0n3YNju26NZ/cy+cCHNnIUqLQzrl/YGRFoc5aFPP7MkVxCFg2Gfq0jmU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4177.eurprd04.prod.outlook.com (52.134.92.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Tue, 29 Oct 2019 13:40:55 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 13:40:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Thread-Topic: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Thread-Index: AQHVjl58vmyH5lHO9kisrA51FWxJAA==
Date:   Tue, 29 Oct 2019 13:40:54 +0000
Message-ID: <1572356175-24950-2-git-send-email-peng.fan@nxp.com>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f3aebb3-b9e2-4c0c-e430-08d75c759f22
x-ms-traffictypediagnostic: AM0PR04MB4177:|AM0PR04MB4177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB41775E2A562EFDE085124A1188610@AM0PR04MB4177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:270;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(2501003)(6436002)(5660300002)(8676002)(25786009)(6116002)(44832011)(486006)(3846002)(81166006)(81156014)(476003)(256004)(71190400001)(6512007)(2201001)(86362001)(71200400001)(6486002)(36756003)(478600001)(14454004)(186003)(8936002)(66556008)(66476007)(66066001)(6636002)(50226002)(316002)(66446008)(64756008)(66946007)(102836004)(6506007)(386003)(110136005)(4326008)(54906003)(305945005)(446003)(11346002)(2616005)(52116002)(99286004)(2906002)(76176011)(7736002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4177;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvjjeECQgQp7vYT08Hvc5Ca7f+Nxd5cRtsRQ+ZmC+jg778hAtz0Tq6XW9WapcYlmArUE8ZMWEAoarOW9F5VbyYMaAbQes4hdA4Ldui7GBpDmOreelTR+LKPJ+GXcVuMelWgN2lObYR7d/U5X3Skq5tu/41QuBlxxHAOFhtr/Rj5ekvdJBAglPRj38+MspEAJJjxAJO7QEhUCT6IK5glOYs2GcICBx+pH4SNx3veGGGXrSbpGFFKG6s+sDz8iFaC14ujyDZdINIpN133xLlXm0RsxNQAV65cyetFNdRpkr5hONnEuCPgEdMM+eIUf+Jw44b0yV2N6OUzT/YnNNEd8cwZwEsWnzsZhMY9IgCzg5XDil9NVCSfKfqS4gcWZWx9rWyGprp8PPV7BX7OGTLLw3ClUZ7R10i1z7nKEgPTb2yz9aY3xqRzSbiam+SR1Utgj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3aebb3-b9e2-4c0c-e430-08d75c759f22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:40:54.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXHDTFeQVFhyxfiEZUh4nmy56RgGAK1U4abueQm+ImZtt+z5RZGonRAUrpLexq0fLCnu4txEB6J6yScGAtcmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the imx_clk_pll14xx function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 22 +++++++++++++---------
 drivers/clk/imx/clk.h         |  8 ++++++--
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 5c458199060a..fa76e04251c4 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -369,13 +369,14 @@ static const struct clk_ops clk_pll1443x_ops =3D {
 	.set_rate	=3D clk_pll1443x_set_rate,
 };
=20
-struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
-			    void __iomem *base,
-			    const struct imx_pll14xx_clk *pll_clk)
+struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_nam=
e,
+				  void __iomem *base,
+				  const struct imx_pll14xx_clk *pll_clk)
 {
 	struct clk_pll14xx *pll;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 	u32 val;
=20
 	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
@@ -412,12 +413,15 @@ struct clk *imx_clk_pll14xx(const char *name, const c=
har *parent_name,
 	val &=3D ~BYPASS_MASK;
 	writel_relaxed(val, pll->base + GNRL_CTL);
=20
-	clk =3D clk_register(NULL, &pll->hw);
-	if (IS_ERR(clk)) {
-		pr_err("%s: failed to register pll %s %lu\n",
-			__func__, name, PTR_ERR(clk));
+	hw =3D &pll->hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
+		pr_err("%s: failed to register pll %s %d\n",
+			__func__, name, ret);
 		kfree(pll);
+		return ERR_PTR(ret);
 	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index bc5bb6ac8636..5038622f1a72 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -97,8 +97,12 @@ extern struct imx_pll14xx_clk imx_1443x_pll;
 #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \
 	imx_clk_hw_mux(name, reg, shift, width, parents, num_parents)->clk
=20
-struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
-		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
+#define imx_clk_pll14xx(name, parent_name, base, pll_clk) \
+	imx_clk_hw_pll14xx(name, parent_name, base, pll_clk)->clk
+
+struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_nam=
e,
+				  void __iomem *base,
+				  const struct imx_pll14xx_clk *pll_clk);
=20
 struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
--=20
2.16.4

