Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F3721019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jhNy7wOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfE2M07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:26:59 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbfE2M04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKqWuXfwnh3w+ek/x97sagMDlqoHboTZIFrrg1B+nlc=;
 b=jhNy7wOuXwW5T3nfaJs/ZrONIQO/TMC1zRIdOqZbTcFVBC73hUkPQ0tS68D+eiPKhPNF5/1UNseZ4vLcsAwIBEKGfLDnd3pgZlBVoGYmzNPZuSkJUD0kMURUlKzATuUfNVWmr2raLLRUBp3j8B8fqPuWx7eOfqoX1UP4eH2V180=
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
Subject: [RESEND 08/18] clk: imx: clk-pfd: Switch to clk_hw based API
Thread-Topic: [RESEND 08/18] clk: imx: clk-pfd: Switch to clk_hw based API
Thread-Index: AQHVFhnGDH4gbz1m4EOfBZyn4s+epQ==
Date:   Wed, 29 May 2019 12:26:43 +0000
Message-ID: <1559132773-12884-9-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 18437734-e8c3-469d-eea6-08d6e430e99a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB6049E92B3425708A2BF9558FF61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s3KyLtkTM/m+KmAXMcvx3K9YzZ5aQr98qIgoTg8DboJorfpZVs36SRhedkcTJCm2gBw5AXk5MxCg0/q/2+IAr4KT3A4Grlv9ScaSAKCcX/HjimMrTaFuQ2taMMPQ2hb7tnvWUbb4oqF8qZIFqOmT6vyP8R1i3ewPz0JJHtqU1DHILwvRc/HmHqAed10rYcYFZ3DgQI4X0/0oKAERpyD9dc8AHVgB4u90r1G3rsWWBkm94CMDUO5n9cYRuAHhD1/ALPr6PJnmaAnUwFHBhPfRffvbDFGDOOb3jBgKBW0yPDNkirDdKuDpfPzCCtZxINFw5tKaeIl+mHGiwrCGEOgXIxFsoB3ns4Z8Vo2Vwnxr1VihM8+jDEdsKPAF8vzAxTIkyHxSjMv3zToUWVXUxDlaiTfIWc3vV9P5zZPRwh9sDQQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A50375AB4485C5488EFCAF2E8E2D8134@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18437734-e8c3-469d-eea6-08d6e430e99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:43.6508
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

Switch the imx_clk_pfd function to clk_hw based API, rename accordingly
and add a macro for clk based legacy. This allows us to move closer to
a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-pfd.c | 14 +++++++++-----
 drivers/clk/imx/clk.h     |  5 ++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
index 04a3e78..3b43d29 100644
--- a/drivers/clk/imx/clk-pfd.c
+++ b/drivers/clk/imx/clk-pfd.c
@@ -127,12 +127,13 @@ static const struct clk_ops clk_pfd_ops =3D {
 	.is_enabled     =3D clk_pfd_is_enabled,
 };
=20
-struct clk *imx_clk_pfd(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
 			void __iomem *reg, u8 idx)
 {
 	struct clk_pfd *pfd;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	pfd =3D kzalloc(sizeof(*pfd), GFP_KERNEL);
 	if (!pfd)
@@ -148,10 +149,13 @@ struct clk *imx_clk_pfd(const char *name, const char =
*parent_name,
 	init.num_parents =3D 1;
=20
 	pfd->hw.init =3D &init;
+	hw =3D &pfd->hw;
=20
-	clk =3D clk_register(NULL, &pfd->hw);
-	if (IS_ERR(clk))
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(pfd);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8aadc92..87a1a88 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -67,6 +67,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_pllv3(type, name, parent_name, base, div_mask) \
 	imx_clk_hw_pllv3(type, name, parent_name, base, div_mask)->clk
=20
+#define imx_clk_pfd(name, parent_name, reg, idx) \
+	imx_clk_hw_pfd(name, parent_name, reg, idx)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -123,7 +126,7 @@ struct clk_hw *imx_obtain_fixed_clk_hw(struct device_no=
de *np,
 struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
=20
-struct clk *imx_clk_pfd(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
=20
 struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
--=20
2.7.4
