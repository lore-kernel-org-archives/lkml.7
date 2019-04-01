Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C57C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FE520879
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lzmfy9Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbfDAGHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:07:12 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:12271
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726610AbfDAGHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kPa3aodjOXONXMUwg66a1dFlXs/UUbLXUnPq+xrVyY=;
 b=lzmfy9OaU2Xe2JpmtT09O9LkrIsSCuvWJQ+mUMweKjOToe2WgDFEZtCGRnH7y78Z/4EZoENV9SJSnhdr1xi0xjtyHmTC0Q89KsAXUbOQ+QSbghB/LHEJFJuZwfdAItBD6vOyUIJK7+QFm4+Qw+FOlVMa4akLzzUCYZ15RzOIQDs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 06:07:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 06:07:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Sven.Schmitt@mixed-mode.de" <Sven.Schmitt@mixed-mode.de>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] soc: imx: gpc: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH 1/2] soc: imx: gpc: use devm_platform_ioremap_resource()
 to simplify code
Thread-Index: AQHU6FEjjQ4fZciTSEadlrEaF62hSA==
Date:   Mon, 1 Apr 2019 06:07:08 +0000
Message-ID: <1554098543-5036-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7482f64-f288-44fe-203a-08d6b6684593
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-microsoft-antispam-prvs: <DB3PR0402MB385251829FA05C08E0717628F5550@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(6486002)(14454004)(86362001)(106356001)(7736002)(81166006)(81156014)(4744005)(8676002)(71190400001)(99286004)(6116002)(36756003)(3846002)(105586002)(71200400001)(256004)(6506007)(110136005)(316002)(386003)(6512007)(25786009)(5660300002)(305945005)(102836004)(478600001)(7416002)(53936002)(186003)(66066001)(2501003)(52116002)(97736004)(50226002)(2201001)(2616005)(476003)(6436002)(8936002)(2906002)(26005)(4326008)(68736007)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZZ111vZ7vy/xSC3Gt4xeTJ55H5+x9hjdaBn03oOGVaOCsuW9H65aB1aOH0VtBNVLxPWnUqJ33wDcLnck7PnhmFgNhjINXiL12PyGz3IaSV/EIvDP7lRYHHNUiwIHz0VR7zgreoSq8XSKOzoN8sDBaEsvZAgcfP4+gXOLwU0sKrjTZxs1CLsHTH/23vYsE5RnvcSo/Hpb7n5zhSK4v619Xae5dg93kNM1PynmqqwAOXw+FxehMMDPs91EGHyrzAA6tJFQ71z3GBUTTUB74l5/XjXrIHhUTl11foCzKm9B4TlzXFI7/GnckprAIkw1F9ugimIhUPaYEshWiKJL2CIkosCotq9HmNuL+BtDjk9T7iftJlsyIxATVvoVJ2gDU9vgRsa/al14gZuPkcAC2J8gBrhRIWVB5D7mKHqkVP+9l9o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7482f64-f288-44fe-203a-08d6b6684593
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 06:07:08.4881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/gpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 7d14a4b..a8f1e47 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -406,7 +406,6 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	const struct imx_gpc_dt_data *of_id_data =3D of_id->data;
 	struct device_node *pgc_node;
 	struct regmap *regmap;
-	struct resource *res;
 	void __iomem *base;
 	int ret;
=20
@@ -417,8 +416,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	    !pgc_node)
 		return 0;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base =3D devm_ioremap_resource(&pdev->dev, res);
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
=20
--=20
2.7.4

