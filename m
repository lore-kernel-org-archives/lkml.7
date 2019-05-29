Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197D0C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D8221734
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jE55iXJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfE2M0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:26:52 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfE2M0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tA6qCgZbgKyGnEQpr6zfmRKP/Z9pn3yUafynMaIuLo=;
 b=jE55iXJ4e29Cntmbt2yMtl2YEjE1TEl0yG91/rWSAEDVxUWXT2u7fhW1QYT/7bGrJDEj/tBsSmXlEFEFQGf/mtwrQvHlBIVb0eef8zqTBdYj2FPQP0C0Gys1Mhy6BOOKLhoEdcn+AGAHEmRsFwnk5eyA8mftKpYi7UjrmyAXUIc=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:42 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:42 +0000
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
Subject: [RESEND 04/18] clk: imx: clk-busy: Switch to clk_hw based API
Thread-Topic: [RESEND 04/18] clk: imx: clk-busy: Switch to clk_hw based API
Thread-Index: AQHVFhnF7C645KVHO0+XcE0dN+o1PA==
Date:   Wed, 29 May 2019 12:26:42 +0000
Message-ID: <1559132773-12884-5-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8da6ae1a-05cf-488a-471f-08d6e430e817
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB6049E4AF7E4CB401ADDEA870F61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(14444005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bUzrbtXrcUyCVHkXPKzHeDFLhYroB/ktmlusM9GV8uIVPtIUKrbcnHK5hGAfELyhXmOd5Cx0d3YwPKfMY4nWS93M9KRZut3HMSyoZX5icPaVOBTjdQDnsQEp4yciGdtpQeWIjXareKGp71683FUziVWIBI0pFsLwzbTbV2lo9WiKC0DKsU74YnOhKILDHllOYbSyrCGTeSNd+BY9eyT78jjo8J40kckfCSiQQXXAccV3CvWRrmjkCyLbBQ4N6unFuZpN7fWs6vGpZJyjd7OmEQdVHf2BhPk189jXn+UtGeFNWzr/915TKdm+6YxfjLGKrc48HNsjPXiC9t/LcJvcctgbHgQ72RVXbD7gwDJD4FH8vhljT/cJXyYz8rqYe1S+J5dwRs06Eqvesw0GMsSnUWCLM0k/OO+NX24llf9IdtY=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3AB785E18E119B47B5109BF26F82DF7B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da6ae1a-05cf-488a-471f-08d6e430e817
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:42.1847
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

Switch all the clk_busy clock registering functions to clk_hw based API.
Keep around some clk based wrappers to be used by older imx platforms.
This allows us to move closer to a clear split of consumer and provider
clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-busy.c | 30 ++++++++++++++++++++----------
 drivers/clk/imx/clk.h      | 11 +++++++++--
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index e695622..51f75500 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -78,13 +78,14 @@ static const struct clk_ops clk_busy_divider_ops =3D {
 	.set_rate =3D clk_busy_divider_set_rate,
 };
=20
-struct clk *imx_clk_busy_divider(const char *name, const char *parent_name=
,
+struct clk_hw *imx_clk_hw_busy_divider(const char *name, const char *paren=
t_name,
 				 void __iomem *reg, u8 shift, u8 width,
 				 void __iomem *busy_reg, u8 busy_shift)
 {
 	struct clk_busy_divider *busy;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	busy =3D kzalloc(sizeof(*busy), GFP_KERNEL);
 	if (!busy)
@@ -107,11 +108,15 @@ struct clk *imx_clk_busy_divider(const char *name, co=
nst char *parent_name,
=20
 	busy->div.hw.init =3D &init;
=20
-	clk =3D clk_register(NULL, &busy->div.hw);
-	if (IS_ERR(clk))
+	hw =3D &busy->div.hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(busy);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
=20
 struct clk_busy_mux {
@@ -152,13 +157,14 @@ static const struct clk_ops clk_busy_mux_ops =3D {
 	.set_parent =3D clk_busy_mux_set_parent,
 };
=20
-struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift=
,
+struct clk_hw *imx_clk_hw_busy_mux(const char *name, void __iomem *reg, u8=
 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char * const *parent_names, int num_parents)
 {
 	struct clk_busy_mux *busy;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	busy =3D kzalloc(sizeof(*busy), GFP_KERNEL);
 	if (!busy)
@@ -181,9 +187,13 @@ struct clk *imx_clk_busy_mux(const char *name, void __=
iomem *reg, u8 shift,
=20
 	busy->mux.hw.init =3D &init;
=20
-	clk =3D clk_register(NULL, &busy->mux.hw);
-	if (IS_ERR(clk))
+	hw =3D &busy->mux.hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(busy);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 77c2ce8..f13770c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -10,6 +10,7 @@ extern spinlock_t imx_ccm_lock;
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 void imx_register_uart_clocks(struct clk ** const clks[]);
+void imx_register_uart_clocks_hws(struct clk_hw ** const hws[]);
 void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
=20
 extern void imx_cscmr1_fixup(u32 *val);
@@ -49,6 +50,12 @@ struct imx_pll14xx_clk {
 	int flags;
 };
=20
+#define imx_clk_busy_divider(name, parent_name, reg, shift, width, busy_re=
g, busy_shift) \
+	imx_clk_hw_busy_divider(name, parent_name, reg, shift, width, busy_reg, b=
usy_shift)->clk
+
+#define imx_clk_busy_mux(name, reg, shift, width, busy_reg, busy_shift, pa=
rent_names, num_parents) \
+	imx_clk_hw_busy_mux(name, reg, shift, width, busy_reg, busy_shift, parent=
_names, num_parents)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -111,11 +118,11 @@ struct clk *imx_clk_pfd(const char *name, const char =
*parent_name,
 struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
 			     void __iomem *reg, u8 idx);
=20
-struct clk *imx_clk_busy_divider(const char *name, const char *parent_name=
,
+struct clk_hw *imx_clk_hw_busy_divider(const char *name, const char *paren=
t_name,
 				 void __iomem *reg, u8 shift, u8 width,
 				 void __iomem *busy_reg, u8 busy_shift);
=20
-struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift=
,
+struct clk_hw *imx_clk_hw_busy_mux(const char *name, void __iomem *reg, u8=
 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char * const *parent_names, int num_parents);
=20
--=20
2.7.4
