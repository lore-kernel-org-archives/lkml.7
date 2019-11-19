Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828EAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B612084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IidN1p51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfKSOIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:08:46 -0500
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:9830
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfKSOIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:08:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN/tDrGZO+wQlNuj6At81mxKr3o0wBRCtqWdSWhkehw350NHMFXg37BuE++Mq0kwKrehtPXMNZdizZSNyWZNnuWXlZ8w0wlPDuf7S6oG7jNfe/WmVE1WK7CQPwmJCWZQYr8lyvF6PGTSZrdcKEErXwP4TmhNtLm94l1uDPp4N3js06cI94LWbXj9Dmd+Gmrs8uGqQ5tweQ6Gkqfq09KGz/N+I/VJ4siVqehEsqEo6xSdPB50OByOduHTc99seaj1vxdBf4WL1hEBxwvDCncUeCbFml+NvLwJLT472DZOmWE7QMvujTDdYT0767pmmlbLWPGUywQu2ly2byFmyu697Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9o9cq9TzC6cC27ZBSd5J5BJyLR4OaDIdjpiH84qvtE=;
 b=JV6WboQfxTrxtiw9dE1hIO8LOl0boBdSF9zi8z8xTm0uyl9IpIiuDbkBvnqPuCO5fjf8+P+iX5b/wit0q3r701YslgRwkn0LTOcz2BsJioBgdmE7s6kgU+EM6G3jjBK13HNe6JL/y9mQCQB+F5+E4EgsqL+QCHzWEyaDBNOsx3My6NdZiwIvTXvGBP3i0KEEIbTBdpI+VpJvJ549eCsnFnOt/fLl+Ren2Ozg5A0NbqhkutjGFp0bzFynywhC/yfizOVZqP3bytSrquHzvuxs5GGBJmtloQ4wHAPWEXEdGpMtctj+XG+EnVy3ejBFCaOEP+q2A8LEkKrI/vvzZPjAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9o9cq9TzC6cC27ZBSd5J5BJyLR4OaDIdjpiH84qvtE=;
 b=IidN1p51Ym+TvBBnfjlo6Ek5bxxbSk5pOrC+iYZd9kqx/t0b95/UvOIMpTZqrBXf/GQLHVv7k0F9Is+wbKKqG0abLwW7XnRmMh6/YN63eiSPa1cfNVusvETDCnmgIKKvScjXmd8Wx0J5QRhmWposq/CkHqJ7dwD52ICbpCcGb6I=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5428.eurprd04.prod.outlook.com (20.178.113.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 14:08:40 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 14:08:40 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/9] clk: imx: pllv1: Switch to clk_hw based API
Thread-Topic: [PATCH 2/9] clk: imx: pllv1: Switch to clk_hw based API
Thread-Index: AQHVnuLXtPo0oM/VL0SGxgLMTYi0hQ==
Date:   Tue, 19 Nov 2019 14:08:39 +0000
Message-ID: <1574172496-12987-3-git-send-email-abel.vesa@nxp.com>
References: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:208:122::39) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6b15f31-06a7-470b-b712-08d76cf9fa41
x-ms-traffictypediagnostic: AM0PR04MB5428:|AM0PR04MB5428:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB54281D02E7B3C21C52FC3D03F64C0@AM0PR04MB5428.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(110136005)(256004)(86362001)(316002)(66446008)(66556008)(66476007)(64756008)(66946007)(36756003)(446003)(7736002)(305945005)(186003)(3846002)(6116002)(26005)(5660300002)(478600001)(52116002)(76176011)(99286004)(2616005)(66066001)(54906003)(2906002)(11346002)(6506007)(476003)(44832011)(386003)(6636002)(486006)(6486002)(102836004)(25786009)(8936002)(71200400001)(81156014)(81166006)(71190400001)(50226002)(6512007)(4326008)(6436002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5428;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciYASkefnzprbcD6oVVyMiMGEgBdvvw26ktRZXMfhR9tUml/qVUwNohlW0h3noqdrzY245Vj4dd+KizEsRAmhEXkK9+cfT9V8W7xP7m6WroHwZFQQ0R2YKZJWCDWh6ZpA5bQpvq5vCeXfSomwdzorY3gmBOOExKqtgvk8d468aG6EAWs+l4LRS4xDytbWMLINodg+lfHe4kYXBZhSb5KEme5St2Rd+BGyFxD+yAjgBoweDYXttnsYuBQD17eKhlD+KZcQ4KTs0DoSdF34lUclStOyj57z7wbW3MzHRAqcD8krwYFoXIAkZMd8GZ4T8D8gq+4zd8C0ONMa0X39Z6RpSI+K1v5sk0I2kf2wP02b5Gv2pcx+qHcBWis4yAjXW/lzx8CVoxS6PMx6/TOlFnn+s8v6puEPK93etUx5Xe/Iub8R2GME3lGbBJc2cMg6gA8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b15f31-06a7-470b-b712-08d76cf9fa41
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 14:08:39.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AIrRhsJCtUHaS2zGkmL2YVlRTnekPAsYIHccdANAbuHDveptecXFJ5M7MhRirVO5XFmxrfeeyoZ81+v/R1GNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5428
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_pllv1 register function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
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
index 945ce4d..af69fc1 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -109,10 +109,13 @@ extern struct imx_pll14xx_clk imx_1443x_pll;
 #define imx_clk_fixed(name, rate) \
 	imx_clk_hw_fixed(name, rate)->clk
=20
+#define imx_clk_pllv1(type, name, parent, base) \
+	imx_clk_hw_pllv1(type, name, parent, base)->clk
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

