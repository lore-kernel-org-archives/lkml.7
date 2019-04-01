Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA03E20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IC5DlKfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfDAE70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:59:26 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:20914
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfDAE70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrr3tBZVPWSNdGmXq2KUZe+R8K17eEE/qegXAw3Dx9Q=;
 b=IC5DlKfatCVg6JNsJ+G6osLD7ZtR7TTb8wlG4IGs1N9EAjy3q81xFWZcaQfIw/9ON8OshDjpPzP0XQZ9BwuWxdCbKEVgY1N1cFSdb/CttYKPJdfEvOf0VX9e6KjmqsGFP1rSybmzeDm6kMM9WAv9DEH4AaPx4V/5a4BnuI+ut6M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 04:59:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 04:59:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] nvmem: imx-ocotp: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH 1/3] nvmem: imx-ocotp: use
 devm_platform_ioremap_resource() to simplify code
Thread-Index: AQHU6Eer2Z58vV2AQUS2GbFqx7Jd0Q==
Date:   Mon, 1 Apr 2019 04:59:22 +0000
Message-ID: <1554094479-14596-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:203:72::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2751cba6-9ff7-48af-2db0-08d6b65ecdfa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB3850DFC53753A060BA399B34F5550@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(386003)(6506007)(86362001)(476003)(256004)(25786009)(81166006)(7736002)(305945005)(106356001)(66066001)(486006)(97736004)(68736007)(81156014)(36756003)(8936002)(4326008)(6512007)(50226002)(3846002)(53936002)(105586002)(8676002)(6116002)(52116002)(316002)(5660300002)(6486002)(99286004)(2906002)(2201001)(110136005)(6436002)(71200400001)(71190400001)(102836004)(2616005)(26005)(4744005)(2501003)(14454004)(186003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2aphxbwXJ0u9SkTWq148ZJxvTDT9DVz81q6pt38iz3awKpu0LuINdVbwMWV8fMqriYtmRP8YO/Mq3op8AcN1tzy9MKAmhDDfnhqpm4wK3/jKiiDGgTLwbBx26J7ptJPeTXGm8OfS1Ad1QF6d9m8Mpe0kuernhRR6Tgvq72JyQCUadZp6P1K0pC7eJFFnU8lRvnojbq0RaDCQAYSY0+hyhIN73N+5aSTY82WGuqCwGnyDXURo9nMrRyIJk4vgOZnKtNSXZ2AJiHpi2WE2YvDiRl1eVP25MbM+o8x8isn6bOVxFhatErFZBvzNIzXIgzSUW2fdIsELERFwfUTLVn7IWqfgVG2cuewe59qO/xRABcaY/wiudM7xGdxA+NRZlfx6P0EhQjALpFYI+vEsESCgX0p2NZTbTvXi0tOYl+v3g3Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2751cba6-9ff7-48af-2db0-08d6b65ecdfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 04:59:22.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index e0b22b6..4cf7b61 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -467,7 +467,6 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 static int imx_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	struct resource *res;
 	struct ocotp_priv *priv;
 	struct nvmem_device *nvmem;
=20
@@ -477,8 +476,7 @@ static int imx_ocotp_probe(struct platform_device *pdev=
)
=20
 	priv->dev =3D dev;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base =3D devm_ioremap_resource(dev, res);
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
=20
--=20
2.7.4

