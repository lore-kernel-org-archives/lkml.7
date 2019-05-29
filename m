Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0283FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BFD21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o9Uu/O6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfE2M0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:26:55 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:23783
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbfE2M0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH7LUYpa90/z3Z5zCgjC8vTdHEsZmiJ2VXLXqsaNXGQ=;
 b=o9Uu/O6WKqKbygei+hiwjYWb4xnz6moCVg7z2zqSg/SDPbMfq3kptBF9XplNw2ARwfp+Ryc0oKU5SK6J6f4XylEZlgskULg8puDe14lewSAhH7AH2ydicijq6WVM+8zKcQ7H4vj56UDviCPGWUTlFABuNQHJZSoF95Po3U4D1PA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:43 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:43 +0000
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
Subject: [RESEND 06/18] clk: imx: clk-gate2: Switch to clk_hw based API
Thread-Topic: [RESEND 06/18] clk: imx: clk-gate2: Switch to clk_hw based API
Thread-Index: AQHVFhnFpPGMIKlRFkOL8q7C6G1ODQ==
Date:   Wed, 29 May 2019 12:26:42 +0000
Message-ID: <1559132773-12884-7-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5b06102d-6e70-4577-c3da-08d6e430e8dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB604950C8A550D2E74CDAE294F61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(14444005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hr3AkyS6WxYyjxD7k7/lAKxUc+Sw9O8hMjbzS7lhgTKyvwSwPeaX6UK7Um+zmgBma33d6fA9s/j6pNkVBZWgoLphHo9GP4LEeNzHAL7t+9tZ9M35jbpqfODQP4edK2Ggor8V8XkdzANSi9GrZn6vH0/IuQuPdwV/jTXe6V31Pnmj+PEA+dMuZxHoyA95m1miyn5aqBrDluBsajpr/b/YG2bPLa60bH9NKW8MfipTVopLJ0QZkGrB2bCs1fTzcXTqY298tYBnRHHfJY6wgsBV8dHEU/S4ljMWRFc4l4VHzKH0sf8mjtV20b+KoWs7mfUqKR/KnZ2fwsshEt9tgM12YYUTMsAGkrhNDcFzXUgVuvS4h0A+NDJkxJw/4e7ySbLNYP9721mlphvW+hKBy4xWZBMVNtfRfSCv5zkc0JcWe+I=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C4F155DE73BBE442B1C155A3554BBF12@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b06102d-6e70-4577-c3da-08d6e430e8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:42.9642
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

Switch the clk_register_gate2 function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-gate2.c | 14 +++++++++-----
 drivers/clk/imx/clk.h       |  7 ++++++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 60fc9d7..14551fd3 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -125,15 +125,16 @@ static const struct clk_ops clk_gate2_ops =3D {
 	.is_enabled =3D clk_gate2_is_enabled,
 };
=20
-struct clk *clk_register_gate2(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
 		u8 clk_gate2_flags, spinlock_t *lock,
 		unsigned int *share_count)
 {
 	struct clk_gate2 *gate;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	gate =3D kzalloc(sizeof(struct clk_gate2), GFP_KERNEL);
 	if (!gate)
@@ -154,10 +155,13 @@ struct clk *clk_register_gate2(struct device *dev, co=
nst char *name,
 	init.num_parents =3D parent_name ? 1 : 0;
=20
 	gate->hw.init =3D &init;
+	hw =3D &gate->hw;
=20
-	clk =3D clk_register(dev, &gate->hw);
-	if (IS_ERR(clk))
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(gate);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 2bbae81..9c5e20c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -59,6 +59,11 @@ struct imx_pll14xx_clk {
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	imx_clk_hw_cpu(name, parent_name, div, mux, pll, step)->clk
=20
+#define clk_register_gate2(dev, name, parent_name, flags, reg, bit_idx, \
+				cgr_val, clk_gate_flags, lock, share_count) \
+	clk_hw_register_gate2(dev, name, parent_name, flags, reg, bit_idx, \
+				cgr_val, clk_gate_flags, lock, share_count)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -97,7 +102,7 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, cons=
t char *name,
 struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
 			     void __iomem *base);
=20
-struct clk *clk_register_gate2(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
 		u8 clk_gate_flags, spinlock_t *lock,
--=20
2.7.4
