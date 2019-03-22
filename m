Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FDDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36145218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="glINx5MC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfCVPig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:38:36 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:56385
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfCVPhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzksQQx2LPv93hAcs8NXmXCIZLnGKLZgdSTDzJItgew=;
 b=glINx5MCNJJrXeUO/haq1VctM4GesYZLdPvHTG1xsydLZ7e2uxH6Z762KKQ2eYNpUKR+fKdnEYwnK7OluMQiL99lzdHfQphBIwAfZzfpn6Hu1opBSw+zZTGZm5nyungX3Lm72v/VDaxFqVNOBByZroKQR6q0fw+XNv2p7t/vbW4=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:05 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:05 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 05/19] clk: imx: clk-busy: Switch to clk_hw based API
Thread-Topic: [RFC 05/19] clk: imx: clk-busy: Switch to clk_hw based API
Thread-Index: AQHU4MUZ2DSWHdnM7E6B7Au7JegLMg==
Date:   Fri, 22 Mar 2019 15:37:04 +0000
Message-ID: <1553269010-15591-6-git-send-email-abel.vesa@nxp.com>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0170.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2dafced-138e-4304-42da-08d6aedc3c44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB5636A24F9E6C326261B2D908F6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(386003)(4326008)(6116002)(6486002)(50226002)(14444005)(6506007)(66066001)(256004)(76176011)(446003)(186003)(25786009)(11346002)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qa5aH9HgqTW8wkSfK0BEUD9TwjNYduCqH2GSoMqSz6huu2DzZDHNy7POIuKT7eaCtVdxGpAkYYN3jVrCrgmj+5z7qjXUjKd73hy6ZIpFKRwycKjlOeZiy9f3R8xYTlHgUOFPjaXlVmYSWLRi2E5dnhDRNrzpGmXN2bo7ejk5iJJ1Fcpx9S0Irm12hg2ebQ68dBPYRiCwu1c5UoVaHlilnblPMECKaqD1pHYXylnnMQEBTjtdJA27QabBQBdl30LpLyfNwkcyQ3Glhk/agS/8EXkTMsHpO7VsvJQ0Bb/aIczDJ24TmtChri1YTfq163B+K3joiuXk569lPj+Owsfv47/v/3ATzfnAWsPkdQdY9XkEdMl5Cym9fCuVnSEU0jsX2RwvxZtnbwJOh7dFve0T3mi/BO8gWNdnQz0MqbduwFg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dafced-138e-4304-42da-08d6aedc3c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:04.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch all the clk_busy clock registering functions
to clk_hw based API.

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
index e78519c..69b2a13 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -10,6 +10,7 @@ extern spinlock_t imx_ccm_lock;
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 void imx_register_uart_clocks(struct clk ** const clks[]);
+void imx_register_uart_clocks_hws(struct clk_hw ** const hws[]);
=20
 extern void imx_cscmr1_fixup(u32 *val);
=20
@@ -48,6 +49,12 @@ struct imx_pll14xx_clk {
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
@@ -109,11 +116,11 @@ struct clk *imx_clk_pfd(const char *name, const char =
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

