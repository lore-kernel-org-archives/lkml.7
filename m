Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4015C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7B5206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="axVpS9Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDAFYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:24:07 -0400
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:14804
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbfDAFYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rcdJMz4YKsRpyHy3QGgMtbJqgMW4j+I/K9NWUuqgAs=;
 b=axVpS9IoKm7f7diu8j8B4OwmyHf/BMzrESg2jzI1HxsOH2eP5yAUWTU8CeqXUk/Pmn+PGB9aB98hKFZhFCxr0Z99sCyAvkk9yDW4eqVVbeJMw5ZnmG/QvJhhoZZ0VwiCslWCJGHWBM42chQaDQW7EpgSVnzV3BBdrJ4NGelMFq4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 05:24:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 05:24:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to simplify
 code
Thread-Topic: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to
 simplify code
Thread-Index: AQHU6Eses7WpkEQM7UuKKaAl029asQ==
Date:   Mon, 1 Apr 2019 05:24:02 +0000
Message-ID: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29804db0-d157-4da4-e99f-08d6b6624069
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB3673A91FEEFF89B1CC054891F5550@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(186003)(97736004)(86362001)(3846002)(8676002)(68736007)(99286004)(478600001)(2616005)(8936002)(2501003)(7736002)(386003)(50226002)(81166006)(81156014)(316002)(71200400001)(6486002)(25786009)(256004)(4326008)(476003)(53936002)(110136005)(52116002)(6506007)(26005)(71190400001)(14454004)(305945005)(36756003)(66066001)(5660300002)(6512007)(106356001)(2201001)(6436002)(6116002)(486006)(102836004)(2906002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y3UJDpYSfi4eZx6D36DgCqNldZ3QQ4M7Wel2TieNap3lBLCMRid/0WyZiyjbWBrquYtdsGuuuV5m3LwfCgp0pqsYt3KlitZ2EN/zfkJAnc/l1z0D7QCVlZywGnSv8lcchL/JurROmlhy90L6VLa9BZzV/RPARMSxPK1JGvq2/szoGtROZVlev40YOTn7lzW3TFvL5x06t+xJ6aAIsOC7rYsgzTnCadmVR4T2Tb2vr1uBXwUBKUiMklRJzBPNg3rzP4y6nFVdAFx+qSRGBjXDmsb3IGjsiTvWdyFgzqCQluf6fFKO/UE3wBBMD4Lwu2cWedKOi6LNeRgbqX2YQFP9aISVg8687DcCSNEjsc8vfDc3+1WTV0SruFmeo1of4cr9/cIqItN9EjC7HbcdwKhL1PkJGnVvsc66jbSbRzpI1j8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29804db0-d157-4da4-e99f-08d6b6624069
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 05:24:02.7820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 8061306..434a351 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -291,7 +291,6 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
 	struct pwm_imx27_chip *imx;
-	struct resource *r;
=20
 	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx =3D=3D NULL)
@@ -326,8 +325,7 @@ static int pwm_imx27_probe(struct platform_device *pdev=
)
 	imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
 	imx->chip.of_pwm_n_cells =3D 3;
=20
-	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	imx->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
+	imx->mmio_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
=20
--=20
2.7.4

