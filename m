Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67334C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA072190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvqaWcrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfCVPhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:25 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:41091
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727688AbfCVPhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btKJ5FGyzzP9pxXLkRJpg7Kvk8SPr1AEzM1dDXpEM58=;
 b=hvqaWcrBJKRCw86grfM9MYiI5Wnrj4g2zAia6/t4OJFg0vwdd1GUlMKpkqnXa7bn6JOj0XKrVgdeHfBjbhpmTpBYAmSED8FHEfgnir2DgDudMDxPQ5AlQG2i//zpp2dGtP0ugKBm7tdrDSP0AqvgkH9dsQxw1et0ZETdawaun1w=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:10 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:10 +0000
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
Subject: [RFC 10/19] clk: imx: clk-gate-exclusive: Switch to clk_hw based API
Thread-Topic: [RFC 10/19] clk: imx: clk-gate-exclusive: Switch to clk_hw based
 API
Thread-Index: AQHU4MUd5TM9gVzL0EeZqBGUyz/9xw==
Date:   Fri, 22 Mar 2019 15:37:10 +0000
Message-ID: <1553269010-15591-11-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 6dc0290d-de41-4f40-b593-08d6aedc3f6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB563694E7BC2BD8E68184DAE0F6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(386003)(4326008)(6116002)(6486002)(50226002)(6506007)(66066001)(256004)(76176011)(446003)(186003)(25786009)(11346002)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xO9xXvOkJvCv5LAU8zfIjldloUwh9yEpzPq0MuEvDvaNMF1hLvax/yW45jpsKdN5kp0tmRG9MDIgHkdXdPQ6UD7VBxr9RDaF9Mr+9vLhRRkj2UdsQNNSspNcR6fp8NQ/auEpTLQeSCIzJg/mxf82BmYNnXJqotQ0O8j8Ib1vH2uVJKTd8WjuFQrKQ0OngXwkUiHekJek4fSFL2PDioUGCPNt0t4yG4OxvGKe1ZG8kEtYK/55z1fy94Ojp0Do3uR9GosatUQwAt81AVkgEx/HvlVuAoIa1qx/qfu+bUHwB4LERQYW8eYpXEiEzqVr61o3GITF8w+GEDtnXrauLmIXWrEjZ5LbFGd0PqlrnbyaPTR6ak1eSLTJb2udChLxxubYsJP9+0pw/0hSissJVjGLSTlUZrui7jge+FA69uc9OLs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc0290d-de41-4f40-b593-08d6aedc3f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:10.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_gate_exclusive function to clk_hw based API,
rename accordingly and add a macro for clk based legacy.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-gate-exclusive.c | 17 +++++++++++------
 drivers/clk/imx/clk.h                |  5 ++++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-gate-exclusive.c b/drivers/clk/imx/clk-gat=
e-exclusive.c
index 3bd9dee..7bd9f14 100644
--- a/drivers/clk/imx/clk-gate-exclusive.c
+++ b/drivers/clk/imx/clk-gate-exclusive.c
@@ -58,13 +58,14 @@ static const struct clk_ops clk_gate_exclusive_ops =3D =
{
 	.is_enabled =3D clk_gate_exclusive_is_enabled,
 };
=20
-struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_gate_exclusive(const char *name, const char *par=
ent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask)
 {
 	struct clk_gate_exclusive *exgate;
 	struct clk_gate *gate;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	if (exclusive_mask =3D=3D 0)
 		return ERR_PTR(-EINVAL);
@@ -86,9 +87,13 @@ struct clk *imx_clk_gate_exclusive(const char *name, con=
st char *parent,
 	gate->hw.init =3D &init;
 	exgate->exclusive_mask =3D exclusive_mask;
=20
-	clk =3D clk_register(NULL, &gate->hw);
-	if (IS_ERR(clk))
-		kfree(exgate);
+	hw =3D &gate->hw;
=20
-	return clk;
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(gate);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 14c410e..1abbb0f 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -69,6 +69,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_pfd(name, parent_name, reg, idx) \
 	imx_clk_hw_pfd(name, parent_name, reg, idx)->clk
=20
+#define imx_clk_gate_exclusive(name, parent, reg, shift, exclusive_mask) \
+	imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_mask)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -121,7 +124,7 @@ struct clk_hw *imx_obtain_fixed_clock_hw(
 struct clk_hw *imx_obtain_fixed_clk_hw(struct device_node *np,
 				       const char *name);
=20
-struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_gate_exclusive(const char *name, const char *par=
ent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
=20
 struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
--=20
2.7.4

