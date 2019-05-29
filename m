Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57165C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263402070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aG0kK9di"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfE2M2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:28:02 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfE2M0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5foXyyVMu0pL8JUnIi7oepkFPpRmM0Qy5eRilGAkdSs=;
 b=aG0kK9diS5Q/6Dw4ysW1WbAVspVT3xXpw2ohHV27bzF1qkcYLHU8otOyEd7rvBNRf/c3z6P/aXVfDZLL7B6zcxJUVBLyndqEXpT7m2aiUZ9flvQKAK1dZ+AANQVeepSAjU/yzeSVbh6hdE1pC2cVJcZo1aIbd1AUn1Nj/Gzt9z8=
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
Subject: [RESEND 05/18] clk: imx: clk-cpu: Switch to clk_hw based API
Thread-Topic: [RESEND 05/18] clk: imx: clk-cpu: Switch to clk_hw based API
Thread-Index: AQHVFhnFsw73CTqNqEq9CTHTt9iqXg==
Date:   Wed, 29 May 2019 12:26:42 +0000
Message-ID: <1559132773-12884-6-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: d360aa3a-311b-425f-8c30-08d6e430e895
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB6049BE86A529AE826E4619B9F61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(14444005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ENRZN2ZhOuH2xkWVdC2eCvigYO3VuKIAsDWgEiRkPT0p8LiEf9VeyWl2p/fsekp6KepfA6oF7miXHlgDIevzZEY7lwsLDV/ApM673sGbXFU1zjpShzysImruJuhOrhVgOkA4k5pHsbzoGA1d+lV7kVt4/PfmtYn9VMXCdF/YUz1GfIW86L+DpzRvJfo9w4pjPkO5L9UBqJfB1UPwvH+S66o+y3t+5XvxnZRREka1FYPurrMPfUXoukF+ORyaU7MpAv7Vgc9f6cn/QHZTgz9UXbTt1mTTvy2f4szIvTBQMykpvjtO8X2jTg6QbcpgvfyIYEIlngTy2Qx1CG0MrAEZRBkUb8pzzQpkmdL32qMtqVREoeWTIlpYmOiMbGlHoOcDYGcFMzgFaZDDVsDYpvHohUKYl4h8nj3ymPVH1KAKYVU=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5DA1A735B7B54B4AA540EAC9D6EECAB0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d360aa3a-311b-425f-8c30-08d6e430e895
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:42.5655
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

Switch the clk_cpu clock registering function to clk_hw based API and add
a macro for clk based legacy. This allows us to move closer to a clear
split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-cpu.c | 14 +++++++++-----
 drivers/clk/imx/clk.h     |  5 ++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
index ed1b7e9..a7b9005 100644
--- a/drivers/clk/imx/clk-cpu.c
+++ b/drivers/clk/imx/clk-cpu.c
@@ -75,13 +75,14 @@ static const struct clk_ops clk_cpu_ops =3D {
 	.set_rate	=3D clk_cpu_set_rate,
 };
=20
-struct clk *imx_clk_cpu(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step)
 {
 	struct clk_cpu *cpu;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	cpu =3D kzalloc(sizeof(*cpu), GFP_KERNEL);
 	if (!cpu)
@@ -99,10 +100,13 @@ struct clk *imx_clk_cpu(const char *name, const char *=
parent_name,
 	init.num_parents =3D 1;
=20
 	cpu->hw.init =3D &init;
+	hw =3D &cpu->hw;
=20
-	clk =3D clk_register(NULL, &cpu->hw);
-	if (IS_ERR(clk))
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(cpu);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index f13770c..2bbae81 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -56,6 +56,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_busy_mux(name, reg, shift, width, busy_reg, busy_shift, pa=
rent_names, num_parents) \
 	imx_clk_hw_busy_mux(name, reg, shift, width, busy_reg, busy_shift, parent=
_names, num_parents)->clk
=20
+#define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
+	imx_clk_hw_cpu(name, parent_name, div, mux, pll, step)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -384,7 +387,7 @@ static inline struct clk_hw *imx_clk_hw_mux_flags(const=
 char *name,
 				   reg, shift, width, 0, &imx_ccm_lock);
 }
=20
-struct clk *imx_clk_cpu(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
=20
--=20
2.7.4
