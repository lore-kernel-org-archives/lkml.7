Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEA4C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E812183F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gJj/66qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfE2M04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:26:56 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbfE2M0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLbpXdunSi7M2PQJawiliaDpmLbkuSrqoEAZsaPquhc=;
 b=gJj/66qmJ1Mczm/GkeRu6aLJL/jzF2inQxtl0/CGkAzSRQZI8PJnOjAQzu37Mal9B+CiblTt3sP63l8gb0/rttcKYiNxYe3aeb04ctFaoXwEnH2J+6fJ79RxE7gm+sQwxXYC6RWcBAbxhg8T9Y7Y1fv3JcEjSkIRqgWLURTDC0c=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:44 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:44 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND 07/18] clk: imx: clk-pllv3: Switch to clk_hw based API
Thread-Topic: [RESEND 07/18] clk: imx: clk-pllv3: Switch to clk_hw based API
Thread-Index: AQHVFhnGEsdfs+pU1Uuqkbzjv0pyIg==
Date:   Wed, 29 May 2019 12:26:43 +0000
Message-ID: <1559132773-12884-8-git-send-email-abel.vesa@nxp.com>
References: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc91ed79-8f07-4527-9f54-08d6e430e932
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB6049C4B6214C710BCACC23F0F61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(14444005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XNkJe/Wbl0nnJYHO4MVlwDimJFa850oQTz8RB2zK/7iPxv27rgN/aK8WgAyOlwg/4tn2G/N9OG4rQ9JjcSeEcXNvcnOhH0Cu5L+oEJ+k5j/xay9T0ygpXZk0jtrRseClo4YVaVuXoijW8nZ+tZTvDPgeNbqdT7Gi4waO66DwOU49cizsDeqAyhgHKXcjdUO6p2xGgA206nwVF1uw66YZQ4NL73rw98dCZTqeEd3SGWfnUzKAunUXWJddWcpY1hxr1Sw6qx+F4Pds1a0Em5T7wokYXro0UFf4iyUiJml2LA8P3hVUXdpSchtUjF0xRXayxZ/mbUIgKXzAB4xW70k66MIS+hh75W12bqVlghsf1IwRzdDdYmnyY+Xk6MB1pQ8GZWlF74xSErdwdGi2R+g5DEnI+MMc3ETPnmpXUCcgkuQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <792EE3B0587FB548AE139830902ADB57@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc91ed79-8f07-4527-9f54-08d6e430e932
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:43.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_hw_pllv3 function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us
to move closer to a clear split between consumer and provider clk
APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-pllv3.c | 14 +++++++++-----
 drivers/clk/imx/clk.h       |  5 ++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 4110e71..23aebca0 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -416,14 +416,15 @@ static const struct clk_ops clk_pllv3_enet_ops =3D {
 	.recalc_rate	=3D clk_pllv3_enet_recalc_rate,
 };
=20
-struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
+struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name=
,
 			  const char *parent_name, void __iomem *base,
 			  u32 div_mask)
 {
 	struct clk_pllv3 *pll;
 	const struct clk_ops *ops;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
@@ -484,10 +485,13 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, c=
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
index 9c5e20c..8aadc92 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -64,6 +64,9 @@ struct imx_pll14xx_clk {
 	clk_hw_register_gate2(dev, name, parent_name, flags, reg, bit_idx, \
 				cgr_val, clk_gate_flags, lock, share_count)->clk
=20
+#define imx_clk_pllv3(type, name, parent_name, base, div_mask) \
+	imx_clk_hw_pllv3(type, name, parent_name, base, div_mask)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -96,7 +99,7 @@ enum imx_pllv3_type {
 	IMX_PLLV3_AV_IMX7,
 };
=20
-struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
+struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name=
,
 		const char *parent_name, void __iomem *base, u32 div_mask);
=20
 struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
--=20
2.7.4
