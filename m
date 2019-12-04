Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F08C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE1E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pIp91el2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfLDKOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:14:51 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:22069
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLDKOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:14:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dE35T5DiSl8TIrF8C4Pkkp7QhE3X2lyzC+1YDwP8lHsa+ysXypIDjS/LcKYSgz9mAK86B7epD0hwWX6SBjjARFdoSH+1M+wuMzNwz+YlTgz8lTU2d9NrHMYh9yrttLWo4BTYjXIEnIu3aP92npyPbniWT0zqAYk/tfF/xghbGf/RgpLudd5Ag1S+S8mXkwg2Z0xOIQCW7oIEUInf9tRKfl9e+PwWwU9D4vftnWee1jHzfZbzInG80SaBmQz2IME2cRioxVGz9KDEE3T97XQDRmLq1UWj9uOdu2+7kEhjTtcJanbt1qcd9NYWjkZBjJsayuWEAsnC7DRsg2VtTtRJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0g7+wVaxCT4BL0eA5hYKi+ApQuWHuHAggNhic9ms+0=;
 b=mtBIRYsxjyfT5ER7cUpGecOO/APMejNOwKOPX8r8iRfEra2hjc1ldEiSd9ZBq9K9Kq/psfMI4U5VN33vPsWR7Je6L821vsvzvp4dbENQYOieFXqzRYM+lJFTtoIevLRDa8cFg78dBi525KFqSM0yBgww4WQuCmOTEa5C+v+3HI9B3ABjIiyMlzWbbRBL+2+jAQBxRXEV/uw39nbEYMrT0W/OoCVacIKSVQOmLkoRJ065T83W05CU6kolDpVLzMqfIutE15wv+p4fW0r70BZdoA3+9uoP7ui67a3mh/y/7E92K9NLm+wv3/6oFuhV9duYx7MmnDA9CXHcZqGyHLptiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0g7+wVaxCT4BL0eA5hYKi+ApQuWHuHAggNhic9ms+0=;
 b=pIp91el2bgvkJMaoBGRQ4LrTUGWqQLAhiNiVRwjLmT91G3O1uIh68DS48Gj/AgZbbZAGcXpS/2TDv3uBbiLKR0qX4Ek1va8nhC+6EySU5BQF8+yKQqSXgOjS8hqdzBnUyEvf8F5sGehhpco/QpvbyITn+r2oSmcQZDTxRSx6WGk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4513.eurprd04.prod.outlook.com (52.135.149.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 10:14:45 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 10:14:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx8qxp-lpcg: use devm_platform_ioremap_resource
Thread-Topic: [PATCH] clk: imx: imx8qxp-lpcg: use
 devm_platform_ioremap_resource
Thread-Index: AQHVqoum7IH7ZRFDgESKl5wnHnxd3Q==
Date:   Wed, 4 Dec 2019 10:14:45 +0000
Message-ID: <1575454349-5762-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05331911-3731-4a97-dc40-08d778a2c8fa
x-ms-traffictypediagnostic: AM0PR04MB4513:|AM0PR04MB4513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4513F213591974817CF17408885D0@AM0PR04MB4513.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(199004)(66946007)(54906003)(7736002)(305945005)(6486002)(50226002)(6506007)(6512007)(8676002)(99286004)(71190400001)(316002)(102836004)(26005)(64756008)(81166006)(8936002)(66556008)(81156014)(2616005)(186003)(86362001)(66476007)(14454004)(66446008)(25786009)(71200400001)(110136005)(4326008)(2201001)(6116002)(6436002)(2501003)(6636002)(2906002)(5660300002)(478600001)(36756003)(3846002)(52116002)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4513;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52Ia2fKFInVG21yKa56vGM35EWLqauAd03C64dRjGUe2HfvRvj8VAayU9pxEAh//9kC2nHdQAM2Qd8e7y8aUr7jPtPfgvc0ottON0UeIZnEWyAttoOgN5GnYzpc+syYb5neV38683M+ryavicbYTCRqY8KeJx6T/YCx3LU4djiqT4JTA5p2WvCS/wllOui/bpITFWjjn+SUqzRnVBKWViIPs5IpU4pa1y0TnSPZ0KftTlSenOI+Z3+Am0h8MuVlaG3igdABAhdwaCsf4Fpwi72/d5XjwQ20Qc63pGX7l7Y96/SnuDdxFghAjk8Ev0AxgS68qsPnWg6D2CHH86/mrR54O3UqM6nSxlBF07//37k7Y/Y+wgMOFBBmOhwRpbchv5qp8BTnRjDeaaxo8dZdY0TDeH/ZNk5+epBpPPhQoBx/TTaVX3W0yf6fpTcxWrwtNSWHmRSk1jZb4OWMhs9BseWW84KJH4f0jVzDzomHU+2Xj9rtTx0B8C+OrKo4YmaAV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05331911-3731-4a97-dc40-08d778a2c8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 10:14:45.1721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bOjnaCqWk3uHteP1LlSXiKpOcWiIokJ5ZDWu5+LglNjnaTfQMCm4p2pEupTBWEIiEOmweZy6Sb5KP2aN94goIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

devm_platform_ioremap_resource() wraps platform_get_resource() and
devm_ioremap_resource(), we could use this API to simplify the code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8q=
xp-lpcg.c
index c0aff7ca6374..3f2c2b068c73 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -164,7 +164,6 @@ static int imx8qxp_lpcg_clk_probe(struct platform_devic=
e *pdev)
 	struct clk_hw_onecell_data *clk_data;
 	const struct imx8qxp_ss_lpcg *ss_lpcg;
 	const struct imx8qxp_lpcg_data *lpcg;
-	struct resource *res;
 	struct clk_hw **clks;
 	void __iomem *base;
 	int i;
@@ -173,12 +172,9 @@ static int imx8qxp_lpcg_clk_probe(struct platform_devi=
ce *pdev)
 	if (!ss_lpcg)
 		return -ENODEV;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-	base =3D devm_ioremap(dev, res->start, resource_size(res));
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (!base)
-		return -ENOMEM;
+		return PTR_ERR(base);
=20
 	clk_data =3D devm_kzalloc(&pdev->dev, struct_size(clk_data, hws,
 				ss_lpcg->num_max), GFP_KERNEL);
--=20
2.16.4

