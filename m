Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AF5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C833220828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ewD2Cs8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfDAFEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:04:35 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:33462
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726531AbfDAFEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eld6+yw0bHfEqawlUYjEjSIhSRqrtOR4Nk75k05a30=;
 b=ewD2Cs8tDS7RuMTSGi6jBN1tLuKbZ3+ZPnLJQ85GzREVgeZmIXjT1Tr53LqiRmHgCXEPrYb4zHgrEQH3Z2YYawGEOxcSROIRT58LYxsZqpVxowHngavzUT8Iu1qjIKnf3ar54Q3UfQw/PU65PjM6Q3zjOe1Tq2qus7DTXd9zedY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 05:04:31 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:04:31 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] watchdog: imx2_wdt: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH] watchdog: imx2_wdt: use devm_platform_ioremap_resource()
 to simplify code
Thread-Index: AQHU6Ehj3pOP+tVUHUG9L2wc4efo6A==
Date:   Mon, 1 Apr 2019 05:04:30 +0000
Message-ID: <1554094787-14766-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:203:2e::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5588015-a37b-4013-8044-08d6b65f85ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB3850BEAAEC758F8ACBE83F84F5550@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(2906002)(2201001)(110136005)(71200400001)(6436002)(316002)(52116002)(6486002)(99286004)(5660300002)(71190400001)(14454004)(186003)(478600001)(4744005)(102836004)(26005)(2616005)(2501003)(486006)(97736004)(81156014)(68736007)(86362001)(6506007)(386003)(66066001)(106356001)(305945005)(7736002)(476003)(81166006)(256004)(25786009)(8676002)(6116002)(105586002)(4326008)(6512007)(36756003)(8936002)(53936002)(3846002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: whryskMc3u4y2Cunb23nZjqW3mrdt+EpMnz71lH8TOOmDESPNZLcY7W3JY9Liv1e2DdyZhcKXGrKF7Ig029d3z/cDfdYg+K0yh3bCvGtz1QVbP3SMqcKByzhO9BZkqidXhDWe576hbj/2zLvJ5CgNKT/GQ0oKD7uCD0qavhg8GJBvd2NktZ51mMpK/MxsZJZeHW8rXF2m1Lrrel6fnoP9T2yYqH7PSuqonywpmqgzARn3QCro0jySr+JYLcGEoTxZ0h05JMwfoksDE5nEQfHuf41Jj3mReEodSuuBVaGHi0eRFk29zyn60ZbE7xJWStw5mTLQUOts5cZIh49mtqQcG8cScqNnV/l5wT6MRLE349eImOQvpqCu6bV0dC17DsOKuIXN1Di+SQ72quh4KcuIPxmowkQr1jp3Fpi18mjLXE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5588015-a37b-4013-8044-08d6b65f85ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:04:30.9371
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
 drivers/watchdog/imx2_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 2b52514..1b0faa2 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -247,7 +247,6 @@ static int __init imx2_wdt_probe(struct platform_device=
 *pdev)
 {
 	struct imx2_wdt_device *wdev;
 	struct watchdog_device *wdog;
-	struct resource *res;
 	void __iomem *base;
 	int ret;
 	u32 val;
@@ -256,8 +255,7 @@ static int __init imx2_wdt_probe(struct platform_device=
 *pdev)
 	if (!wdev)
 		return -ENOMEM;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base =3D devm_ioremap_resource(&pdev->dev, res);
+	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
=20
--=20
2.7.4

