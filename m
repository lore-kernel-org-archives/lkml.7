Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7730C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A1620828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPoS/+By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDAFJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:09:55 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:61254
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfDAFJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4qv/eO5sgZ7mo0kyQEAX/mFjghqEqm8kvawzkOybcA=;
 b=XPoS/+BymwH3wt6pjP22gqfC1QUNPGapgy59kZWtnzYxziSrHR0sbtQIpQNREZB2fYwPyDm0Kr6lMQ4FtqtRK2gKThDaoaDCfoM/mocdvMgZyWE838cF8gXejqL5EzSuJoFnejxhUTZ2mSEKcUPI5f0+Wt7/N0rwhleIydhFgtQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 05:09:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:09:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] gpio: mxc: use devm_platform_ioremap_resource() to simplify
 code
Thread-Topic: [PATCH] gpio: mxc: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6Ekh3lwBw6UO20ek9Qw4M7JZeQ==
Date:   Mon, 1 Apr 2019 05:09:50 +0000
Message-ID: <1554095107-15003-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0005.apcprd03.prod.outlook.com
 (2603:1096:202::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fd3a25c-250c-4597-d57c-08d6b660442f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB388318483B8AFC6066F5BBEBF5550@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(2501003)(2201001)(25786009)(5660300002)(6116002)(8676002)(6512007)(105586002)(81166006)(4326008)(4744005)(53936002)(6436002)(71200400001)(486006)(71190400001)(26005)(81156014)(36756003)(86362001)(6486002)(476003)(50226002)(305945005)(7736002)(2616005)(6506007)(386003)(99286004)(52116002)(8936002)(2906002)(102836004)(14454004)(66066001)(97736004)(110136005)(106356001)(3846002)(478600001)(256004)(68736007)(316002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f9cEO5zYrTIKAkZdFKfO3Fat1F1WYaGRI28mtALpy8qq8q7Vy6ykK/ObxgRqGxW6HZ0KllNM3wY48lEjIn/b+IMXLcu4w98Vo9Wad8sKRE8R6KotHrqzKF8Y5GYS/wqU6jjrL371STWkrwBekw0R1UL+iIrFuNVGL8CwbSnN+nqLjk0m3FR4oxW8lueSJR086eyiF0bGIFTOU5l2rin68KGk/ASw6Nptp7VuTww/k2QLJ4y5jBk8pTzPdx3RDRFm1sr4gk5/kueC1OZibyFdI682Wd2s/vFQObX67rrIHNBhbtcSO4Bz6OS99rAhCN7tW24ue8rDJEPy1O6xxaZg2yx/KoI1LWQA+JBF25Brs0vwlUcqo1uOtBS8dBAaWaHLY9fdVdr8XlNh2qrCi0oPjwm0cXd3DOHfMO4+ibbjY2o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd3a25c-250c-4597-d57c-08d6b660442f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:09:50.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index e86e61d..b281358 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -411,7 +411,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np =3D pdev->dev.of_node;
 	struct mxc_gpio_port *port;
-	struct resource *iores;
 	int irq_base;
 	int err;
=20
@@ -423,8 +422,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
=20
 	port->dev =3D &pdev->dev;
=20
-	iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	port->base =3D devm_ioremap_resource(&pdev->dev, iores);
+	port->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(port->base))
 		return PTR_ERR(port->base);
=20
--=20
2.7.4

