Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5701AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DCF20730
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B26G/BPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfKVKsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:48:33 -0500
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:34373
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729922AbfKVKs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+alRPxoEcGqA5Vo00h5dyJbvBQZqPA392MDwoVMgIh+kao9YUM/gJU0QOfo910kfihhZLVQdLSZoIGTKJwEXALtheaKlHuBV0Ojtq1XFLGgkh6kxJtK9MC4u1ULPuEti+gdn4iXsPY6hHXCx01EhehxrGGJ04buLTNGyyoV4jSUpWapYMNGiy1E2orOpdGqORLONVhagu5eeuu0C8Ee7n1yr8ecVUx71CxGJW1GKyH+UmSyAY7zwgqZELz1LJ/mT7whjuG7I9J2hT+DAKcfDSm7VkXKoT/M4SkZFunP/WZl/WQoG7/R5WPNPwtGv2MC7VUawIXH/9mD7+xTPvaiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjpNt3BKobqblXOtBaq8pdvK3XqmVPORcjlWWWAh5Rc=;
 b=iKoc3e8j8GJj7Viw8A/XsmVfaNTyg9e0gTFiFuNWlNPkF0DaRBOEM/E6ar1W/A9/qSLLanhaC0p6WNya8ED1GSSAclS+xRxEDE7s9zc665xzckTEYvqro+Ovw3vXptp6Cys85+PZ8LP0MfclWesOYemuYHo+pRD/mpHQH0Wo65CYZuD/gmymURbDIel8ogQtYBfDh/zO942SIRKKfyjPx7g5RB1wl44TSb4cyg5k8RW7oR8MuQ9Y2hzwpSh47VjmP4iTHnVtC4pSQ8bKK9kuew6+m2LUATJLD4xrYlrpJp/dtMb8nMh8d5JsoViDPo4XO4P2H0vEv8KRbHA8M98tFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjpNt3BKobqblXOtBaq8pdvK3XqmVPORcjlWWWAh5Rc=;
 b=B26G/BPX47IXXMNpFTNiea5/Gt057Kn5G3j6KarvgMIeF/ITqffjw4Jdmyk0IzbMNlvYGUAoavNvxixZziar9hjidhAFuKbPOji15Y+ytPjOGXKpgWoFaNfdjdAIcmbenGmdBkDhKP9oF6o2+hu7TQwKI5TZ0XwXIOe4qpfPoOY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5074.eurprd04.prod.outlook.com (20.177.42.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:48:14 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:48:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 04/11] clk: imx: pllv1: Switch to clk_hw based API
Thread-Topic: [PATCH v2 04/11] clk: imx: pllv1: Switch to clk_hw based API
Thread-Index: AQHVoSJXY0stcOmqOE+UvoibgGHUaQ==
Date:   Fri, 22 Nov 2019 10:48:13 +0000
Message-ID: <1574419679-3813-5-git-send-email-abel.vesa@nxp.com>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:15::33) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 982772e9-97d8-4925-07d6-08d76f39797c
x-ms-traffictypediagnostic: AM0PR04MB5074:|AM0PR04MB5074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB50749B883A9396EF391C9AEEF6490@AM0PR04MB5074.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(478600001)(256004)(6506007)(54906003)(7736002)(305945005)(316002)(71200400001)(5660300002)(110136005)(102836004)(186003)(86362001)(66066001)(71190400001)(2906002)(4326008)(76176011)(99286004)(36756003)(26005)(52116002)(386003)(8936002)(3846002)(2616005)(446003)(44832011)(11346002)(66556008)(66476007)(66446008)(64756008)(6486002)(66946007)(6436002)(81166006)(8676002)(81156014)(6636002)(6512007)(25786009)(14454004)(50226002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5074;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPdSnzOEUo3of75HJggUUlW4XnpK87N49wpoZsy/A5c1eNY2z5cLzllU9E5pBfN0XNDW2i6f/vBDCwWiWDfxLphsTYAdUGYeRdaz1PkqocPk3wsxVfSBQ1k8BVNJ+eJkx18tMd8/s2BrDP9ZBOQ9jFxrXUslkbsLVmk5YPGDLK7AU/xZS+sjYpJq4iw90dHqKnK/S0z8RhYNhvXGIXOOG+GtUXtij/gIZC3CeFUFHaXzyIGF73av3SN6PA+4sYS9+gjGjoED9+9ToqGlND2zY6kUKgg23ogde4s3sM8kzlyPG2dB/TrF16Nyf62HG1dBqXaCdbGOj7yd7lhQrdENDIfikKYG7LpAY0lyP670o3+BcfO0H+Ui5dPyjEfUTyW2nkc5DRzhD3dKqIjCSLyJ4INH14YhuxQZLNjBk09XJs9zRFKeZdPPVW96t36PPNCD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982772e9-97d8-4925-07d6-08d76f39797c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:48:13.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hMArpO0L/3Vh+x+H0DkTw5iWlDJ4pKn6gWt70uiwPocKOvk7j3GBhFpIKMpVxt5529s+cxg+xLfuHBSIWxirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_pllv1 register function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pllv1.c | 14 +++++++++-----
 drivers/clk/imx/clk.h       |  5 ++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv1.c b/drivers/clk/imx/clk-pllv1.c
index 4ba9973..de4f8a4 100644
--- a/drivers/clk/imx/clk-pllv1.c
+++ b/drivers/clk/imx/clk-pllv1.c
@@ -111,12 +111,13 @@ static const struct clk_ops clk_pllv1_ops =3D {
 	.recalc_rate =3D clk_pllv1_recalc_rate,
 };
=20
-struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
+struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type type, const char *name=
,
 		const char *parent, void __iomem *base)
 {
 	struct clk_pllv1 *pll;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	pll =3D kmalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
@@ -132,10 +133,13 @@ struct clk *imx_clk_pllv1(enum imx_pllv1_type type, c=
onst char *name,
 	init.num_parents =3D 1;
=20
 	pll->hw.init =3D &init;
+	hw =3D &pll->hw;
=20
-	clk =3D clk_register(NULL, &pll->hw);
-	if (IS_ERR(clk))
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(pll);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 3ed17a1..bd6a592 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -109,10 +109,13 @@ extern struct imx_pll14xx_clk imx_1443x_pll;
 #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \
 	to_clk(imx_clk_hw_mux(name, reg, shift, width, parents, num_parents))
=20
+#define imx_clk_pllv1(type, name, parent, base) \
+	to_clk(imx_clk_hw_pllv1(type, name, parent, base))
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
-struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
+struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type type, const char *name=
,
 		const char *parent, void __iomem *base);
=20
 struct clk *imx_clk_pllv2(const char *name, const char *parent,
--=20
2.7.4

