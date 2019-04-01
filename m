Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D524C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2C820856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RSeGnP81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDAFP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:15:29 -0400
Received: from mail-eopbgr130078.outbound.protection.outlook.com ([40.107.13.78]:27883
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfDAFP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvsec+yqf6R7hVofzwGVQcTHv9am0uia8rzJkyLumSI=;
 b=RSeGnP81v3WQObMwhi3SmcftFs1MaBPU6Le2hn9+Tocwr9/4G+NVWy0xNrz+muvORkVegt+A6dj7HGFf9Ukoh9/HwirO50YmzOO2t37NPI37CU6/ivYQOa1i1FToaHAbTlCGrPfVtl2x1z88k3VWIR+Hh0HBSFQEOr5M89W/MFw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Mon, 1 Apr 2019 05:15:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:15:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] mailbox: imx: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] mailbox: imx: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6Enp8Rg1WsmI0EedzzVUaGgENg==
Date:   Mon, 1 Apr 2019 05:15:24 +0000
Message-ID: <1554095441-15220-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed78cc66-9d3b-472a-779e-08d6b6610b85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB39469785D829871D8F099CE2F5550@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(366004)(39860400002)(189003)(199004)(15650500001)(316002)(14454004)(386003)(53936002)(50226002)(6486002)(6506007)(102836004)(26005)(5660300002)(6512007)(2201001)(110136005)(99286004)(71190400001)(6436002)(52116002)(486006)(86362001)(2616005)(476003)(186003)(71200400001)(66066001)(478600001)(68736007)(106356001)(105586002)(7736002)(6116002)(36756003)(25786009)(2906002)(305945005)(3846002)(4326008)(4744005)(8676002)(2501003)(97736004)(81156014)(256004)(8936002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RkcMDWst0uIg6dWIYdWjasWsC1l1b6dwgejxrNwjCxGV4KvBjQyYgmfh1L9kHuVGBFAL83q6YvzDFnvhZSto/yUnmn7CVW6YX0DljabOk0cz1uyYQUSqWoBeefPrwLDvGJLOF09osh2fVIgo2KvJXBDzHi9XZAWGiOeQSUzF71b7LCwaPm8htAapvEcc1GGv6PteHtrrG0s6jCk0yg8XRpqbrLFgJlBZ/rEhQmCY0w1+ZavS8kxFrfhGwEksCQC/RuaqGoOcC5dxUqFWarrZuqi9nRZtXkbYteUQcNpHbsA2F6nPws7onp0Z1luOqlR8iRj4nhVfgQi4Fgypp3ywWgo/t/xm8IdCJWj412NIQzs6zzexq7yqJIJueartXB7gg1TomdT1+4NV5Lxx1JpflhvPJMpIGUzGJotNp6oGfK8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed78cc66-9d3b-472a-779e-08d6b6610b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:15:24.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 85fc5b5..25be8bb 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -264,7 +264,6 @@ static int imx_mu_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct device_node *np =3D dev->of_node;
-	struct resource *iomem;
 	struct imx_mu_priv *priv;
 	unsigned int i;
 	int ret;
@@ -275,8 +274,7 @@ static int imx_mu_probe(struct platform_device *pdev)
=20
 	priv->dev =3D dev;
=20
-	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base =3D devm_ioremap_resource(&pdev->dev, iomem);
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
=20
--=20
2.7.4

