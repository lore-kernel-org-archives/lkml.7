Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12F020693
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h25twfrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfC0GIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:08:09 -0400
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:60645
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbfC0GII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RT9BzQFICdJjIpsQByNcMB7hBxRoXNWQNUFOPYjtmk8=;
 b=h25twfrGmIFkaduNYD13VZoTtoK5IOBpKZ97/wcaHW8QLwLWZ0RQLnUeHAb0VcWX1QLQdc/yCqehL760HIC+JmTpPTbORUC9huaDqgp4uM9waCO6oRoJDafKwprYLv/zvHC3SSXQx+O9Ujk55Svsw05k+HYcPQCDNjYnKrjU6r4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 06:08:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 06:08:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] input: keyboard: snvs: use dev_pm_set_wake_irq() to simplify
 code
Thread-Topic: [PATCH] input: keyboard: snvs: use dev_pm_set_wake_irq() to
 simplify code
Thread-Index: AQHU5GNxl3eV+FLEkESTXkKgUt0EFw==
Date:   Wed, 27 Mar 2019 06:08:05 +0000
Message-ID: <1553666576-21621-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0055.apcprd04.prod.outlook.com
 (2603:1096:202:14::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd072566-89ba-4add-64ef-08d6b27a9361
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-microsoft-antispam-prvs: <DB3PR0402MB3900264A833C5D5FAC2E4261F5580@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(7736002)(68736007)(2906002)(8936002)(97736004)(81156014)(305945005)(14454004)(8676002)(81166006)(53936002)(6512007)(478600001)(2501003)(50226002)(6436002)(106356001)(4326008)(25786009)(105586002)(6486002)(36756003)(66066001)(316002)(5660300002)(99286004)(52116002)(6506007)(3846002)(6116002)(2201001)(110136005)(476003)(486006)(14444005)(256004)(186003)(86362001)(71190400001)(71200400001)(102836004)(2616005)(26005)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sqKADj/mGXkM+n5PxCdRbUNCYEptMt5Sg17kavILUaKQl+DvvLeiJMGmecXBMCi5e90HLc4Uk0iQ2mg+oJ2QDLaX36c59kNVBr1WXTBAOeVtYjq/hnJ0qhcNGtosua9eLbKEDgd8+hJ+M9XW9MMPQA8bz/9kYXzIKgJfndU0Im7md7e4UKB6C5Bz447XDxg6Ztne+tkwtpdzAiVwARmajSkieY41VZfeXg6J35+IZm6HVFYGL18QbkCAtyTmlHtEjXJociDz4jhPy3/IBXHY/F/lGOXImMa7xLD/VoZH3y62xOGOXB6u3S+i5Ln25w+xpVzFwF9FiU6pkHs1GaGm5RKOjjvr+zq7AJGiGtmkc5xqGfVKzpyNryB0zb6AATt7eTzPh87XXNg5PPPSG9+iMUQt/nfjD6ToWyo7QFu6Lag=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd072566-89ba-4add-64ef-08d6b27a9361
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 06:08:05.1254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With calling dev_pm_set_wake_irq() to set SNVS ON/OFF button
as wakeup source for suspend, generic wake irq mechanism
will automatically enable it as wakeup source when suspend,
then the enable_irq_wake()/disable_irq_wake() can be removed
in suspend/resume callback, it simplifies the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/=
snvs_pwrkey.c
index 4c67cf3..5342d8d 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
=20
@@ -167,28 +168,9 @@ static int imx_snvs_pwrkey_probe(struct platform_devic=
e *pdev)
 	}
=20
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
-
-	return 0;
-}
-
-static int __maybe_unused imx_snvs_pwrkey_suspend(struct device *dev)
-{
-	struct platform_device *pdev =3D to_platform_device(dev);
-	struct pwrkey_drv_data *pdata =3D platform_get_drvdata(pdev);
-
-	if (device_may_wakeup(&pdev->dev))
-		enable_irq_wake(pdata->irq);
-
-	return 0;
-}
-
-static int __maybe_unused imx_snvs_pwrkey_resume(struct device *dev)
-{
-	struct platform_device *pdev =3D to_platform_device(dev);
-	struct pwrkey_drv_data *pdata =3D platform_get_drvdata(pdev);
-
-	if (device_may_wakeup(&pdev->dev))
-		disable_irq_wake(pdata->irq);
+	error =3D dev_pm_set_wake_irq(&pdev->dev, pdata->irq);
+	if (error)
+		dev_err(&pdev->dev, "irq wake enable failed.\n");
=20
 	return 0;
 }
@@ -199,13 +181,9 @@ static const struct of_device_id imx_snvs_pwrkey_ids[]=
 =3D {
 };
 MODULE_DEVICE_TABLE(of, imx_snvs_pwrkey_ids);
=20
-static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops, imx_snvs_pwrkey_suspend,
-				imx_snvs_pwrkey_resume);
-
 static struct platform_driver imx_snvs_pwrkey_driver =3D {
 	.driver =3D {
 		.name =3D "snvs_pwrkey",
-		.pm     =3D &imx_snvs_pwrkey_pm_ops,
 		.of_match_table =3D imx_snvs_pwrkey_ids,
 	},
 	.probe =3D imx_snvs_pwrkey_probe,
--=20
2.7.4

