Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6128CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CFD21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TpnsDIYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfE2M1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:27:03 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbfE2M06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8rlSu4NycoYaeBoIMrwBz49h9AqacUShrIygP+EAe4=;
 b=TpnsDIYAd+uKR28RMAbx8U177jsH4TnKVKQ+k1LF7EV9la3M34klfANxMMpH5pWdBF7K8xVbTRDODNh3fN/gix1gZs/WOMaqvkfjdts77ovOE3l0AVMmK1mX4BrWmLASjwB3deoWlHqwoJx3FalK7KaDxoF0fJNUXpSYjcMbe+0=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:47 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:47 +0000
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
Subject: [RESEND 11/18] clk: imx: clk-fixup-mux: Switch to clk_hw based API
Thread-Topic: [RESEND 11/18] clk: imx: clk-fixup-mux: Switch to clk_hw based
 API
Thread-Index: AQHVFhnH4Nk5mvjvukedO4eroeg2tw==
Date:   Wed, 29 May 2019 12:26:44 +0000
Message-ID: <1559132773-12884-12-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8aa1f3b6-6c1f-45b5-9a13-08d6e430eae8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB60492D86CFB40A4F0550E40CF61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(6666004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GNqK4pWpJ7fUscnI378wUF1FhUkdEI13FHMWM5zQFjKNmeb+dfSQS7yW+fPlVBV9J93P+mNIA00nJdkC48THXH4A/FQYyAi/ZgZVdry67xSQpjMI8CRKumHKDGbQcaP3zoeAEc0mJR7KEoIackRe49c+diNxUvMf1Tj6U1/5w61aDvUtz/ouAOmBzNDRUiRg23jepLzjw05SS9gawNMkHL9kEVZUZHngU7cDyZzaLukAhK4GsVeKzt1w4p6Tvt7xcDnuQ+BogOgFaovTNvetNe17kq7e56oY34pnzyPXfWhUPXnK9YjXhmatBjcA9JqCHr3Tv4d8rpuGUicrVQ6jdZCOkOf/v0q5J4y9WI6HmTpDh07ZAv/TGm4Q9MNxxSL6abr32D/vJFDF54FAtiKW4yU43uFeOXf9pc56Lkjf7IQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <04DFB09EA899414B8A0B6A19D4F2AD68@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa1f3b6-6c1f-45b5-9a13-08d6e430eae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:44.7862
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

Switch the imx_clk_fixup_mux function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. a macro for clk
based legacy. This allows us to move closer to a clear split between
consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-fixup-mux.c | 15 ++++++++++-----
 drivers/clk/imx/clk.h           |  3 +++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-fixup-mux.c b/drivers/clk/imx/clk-fixup-mu=
x.c
index 44817c1..f3c4ec2 100644
--- a/drivers/clk/imx/clk-fixup-mux.c
+++ b/drivers/clk/imx/clk-fixup-mux.c
@@ -69,13 +69,14 @@ static const struct clk_ops clk_fixup_mux_ops =3D {
 	.set_parent =3D clk_fixup_mux_set_parent,
 };
=20
-struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
+struct clk_hw *imx_clk_hw_fixup_mux(const char *name, void __iomem *reg,
 			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val))
 {
 	struct clk_fixup_mux *fixup_mux;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	if (!fixup)
 		return ERR_PTR(-EINVAL);
@@ -98,9 +99,13 @@ struct clk *imx_clk_fixup_mux(const char *name, void __i=
omem *reg,
 	fixup_mux->ops =3D &clk_mux_ops;
 	fixup_mux->fixup =3D fixup;
=20
-	clk =3D clk_register(NULL, &fixup_mux->mux.hw);
-	if (IS_ERR(clk))
+	hw =3D &fixup_mux->mux.hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(fixup_mux);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index e199d73..5fa8b7c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -76,6 +76,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_fixup_divider(name, parent, reg, shift, width, fixup) \
 	imx_clk_hw_fixup_divider(name, parent, reg, shift, width, fixup)->clk
=20
+#define imx_clk_fixup_mux(name, reg, shift, width, parents, num_parents, f=
ixup) \
+	imx_clk_hw_fixup_mux(name, reg, shift, width, parents, num_parents, fixup=
)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
--=20
2.7.4
