Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98236C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654C4206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tlT7X/7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbfC0GSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:18:25 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:38375
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732747AbfC0GSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3B/9ZeH+jmINYwbHiWMEpxHFpdzNqXzsF9dOSOHi5k=;
 b=tlT7X/7uktZqr55t5mZ0VndD8vOC4xxor4DgE1wxXGwYG9VSgk68BUboXdaIuj1j1OqpSaBpb1JHncHVTWeNKaVDSveLJ5QNKV7lCVthtmu5CeijFnNCDamiuU04JCSu3XlL/fOv1PBUAgCJ7nE5TG1L3Hbg7sWuRuIXt19KVUA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 06:18:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 06:18:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] rtc: snvs: use dev_pm_set_wake_irq() to simplify code
Thread-Topic: [PATCH] rtc: snvs: use dev_pm_set_wake_irq() to simplify code
Thread-Index: AQHU5GTgLxQ0a0WHkkmkrqXTE18V/g==
Date:   Wed, 27 Mar 2019 06:18:20 +0000
Message-ID: <1553667192-16665-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de0dac7a-1703-443c-ed4f-08d6b27c0278
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3708;
x-ms-traffictypediagnostic: DB3PR0402MB3708:
x-microsoft-antispam-prvs: <DB3PR0402MB37082F87978E3E07EDE5A865F5580@DB3PR0402MB3708.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(346002)(136003)(199004)(189003)(105586002)(106356001)(81166006)(81156014)(8676002)(14454004)(478600001)(71190400001)(71200400001)(386003)(97736004)(6506007)(6436002)(6486002)(2201001)(2501003)(86362001)(4326008)(110136005)(53936002)(256004)(68736007)(14444005)(102836004)(5660300002)(50226002)(186003)(26005)(8936002)(6512007)(52116002)(486006)(36756003)(7736002)(305945005)(2616005)(476003)(2906002)(99286004)(316002)(25786009)(66066001)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3708;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OobH46l2Ra+PaqTay9kJvOTHUAVbISB/f3ayBVsgmCkQcfx+pR2ZlacJqcGQxY9NsgokWTDILysWjqRRNRodLA8N7/ZyAZwTpeLat5ezNOmTEPWaCqpSyb/rDb6SsE3kQbRxBcot4hrSmDlEK04n86JxOCTTTftJdjBcK1nTMoYWTTyAUQ07kA3ePQ1/+uNPQZAMK1OZyWrj4uRZ/ghmVEMRGvKQWVba25HMKUhDs9gnPlrmMtUneTOV7igyBqtRdzjHj3IO6dYdUFRdXhIk7T113E8nTqDtyGCexAqJjP7SlYhf0BIb7vdQRpsyzNSlVGdC0EW2oCfxU+5l6ZO6eokqI82V9VnqUFlCi5EEob2ecwPlVseUul8vDrsQD5EXNDoVLCltQaZPAUtfEgTNwBVxw2zsptyKawb3atpGnM4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0dac7a-1703-443c-ed4f-08d6b27c0278
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 06:18:20.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With calling dev_pm_set_wake_irq() to set SNVS RTC as wakeup
source for suspend, generic wake irq mechanism will automatically
enable it as wakeup source when suspend, then the suspend/resume
callback which are ONLY for enabling/disabling irq wake can be
removed, it simplifies the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/rtc/rtc-snvs.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 0b9eff1..ce73eab 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/rtc.h>
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
@@ -332,6 +333,9 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 	}
=20
 	device_init_wakeup(&pdev->dev, true);
+	ret =3D dev_pm_set_wake_irq(&pdev->dev, data->irq);
+	if (ret)
+		dev_err(&pdev->dev, "failed to enable irq wake\n");
=20
 	ret =3D devm_request_irq(&pdev->dev, data->irq, snvs_rtc_irq_handler,
 			       IRQF_SHARED, "rtc alarm", &pdev->dev);
@@ -359,15 +363,6 @@ static int snvs_rtc_probe(struct platform_device *pdev=
)
 }
=20
 #ifdef CONFIG_PM_SLEEP
-static int snvs_rtc_suspend(struct device *dev)
-{
-	struct snvs_rtc_data *data =3D dev_get_drvdata(dev);
-
-	if (device_may_wakeup(dev))
-		return enable_irq_wake(data->irq);
-
-	return 0;
-}
=20
 static int snvs_rtc_suspend_noirq(struct device *dev)
 {
@@ -379,16 +374,6 @@ static int snvs_rtc_suspend_noirq(struct device *dev)
 	return 0;
 }
=20
-static int snvs_rtc_resume(struct device *dev)
-{
-	struct snvs_rtc_data *data =3D dev_get_drvdata(dev);
-
-	if (device_may_wakeup(dev))
-		return disable_irq_wake(data->irq);
-
-	return 0;
-}
-
 static int snvs_rtc_resume_noirq(struct device *dev)
 {
 	struct snvs_rtc_data *data =3D dev_get_drvdata(dev);
@@ -400,9 +385,7 @@ static int snvs_rtc_resume_noirq(struct device *dev)
 }
=20
 static const struct dev_pm_ops snvs_rtc_pm_ops =3D {
-	.suspend =3D snvs_rtc_suspend,
 	.suspend_noirq =3D snvs_rtc_suspend_noirq,
-	.resume =3D snvs_rtc_resume,
 	.resume_noirq =3D snvs_rtc_resume_noirq,
 };
=20
--=20
2.7.4

