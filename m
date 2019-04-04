Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09572206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w/rA/pWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfDDBkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:40:23 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:20463
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDDBkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9AZco5422ZehIdKir2N0iZaqcbW2n+bBnxo/k40hlQ=;
 b=w/rA/pWZ2f3l/FufAkuwmDZMXl1ETtSoxgPuMyuwHVHYJRtxy3pv5PpVCPOBzKIfBAvwXzEm0CFuVkV6ke4ravlprpfubxUu806w+jEbgjimH7DGigpJ+hDigJpjHCekyGiEsl01EVSoL1PD3j/sjaGe0+6g5Fv75MndJ60wyJY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3770.eurprd04.prod.outlook.com (52.134.73.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Thu, 4 Apr 2019 01:40:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Thu, 4 Apr 2019
 01:40:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [RESEND] input: keyboard: imx: make sure keyboard can always wake up
 system
Thread-Topic: [RESEND] input: keyboard: imx: make sure keyboard can always
 wake up system
Thread-Index: AQHU6odaZd/8EWsin0yXXO1zjKS4qw==
Date:   Thu, 4 Apr 2019 01:40:16 +0000
Message-ID: <1554341727-16084-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0038.apcprd03.prod.outlook.com
 (2603:1096:203:2f::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6b49fd1-5ea8-434e-1d9c-08d6b89e7d10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3770;
x-ms-traffictypediagnostic: DB3PR0402MB3770:
x-microsoft-antispam-prvs: <DB3PR0402MB37709A6A933D7978CC1FB6C6F5500@DB3PR0402MB3770.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(52116002)(99286004)(71190400001)(71200400001)(25786009)(50226002)(256004)(66066001)(2201001)(36756003)(4326008)(68736007)(105586002)(2616005)(81166006)(476003)(478600001)(2906002)(8936002)(14454004)(14444005)(186003)(6436002)(2501003)(386003)(110136005)(81156014)(97736004)(53936002)(86362001)(486006)(6486002)(5660300002)(106356001)(8676002)(6506007)(3846002)(6116002)(102836004)(6512007)(316002)(26005)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3770;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mtlpFNmKPurjY1hvUDy97xv0jltP2fDWKBO8o6g/WB3xMKRo73XjZ/2CTRkHoX4yd7ofWT7pJzieVdwhm/ycIzZlBZi9Wm0h0NF6oGS1Y+kAX+DY2DgijoARg2seBqv8spJBwEzxqlJqum0WNgmwTV8CmRIJttwKMvRglYqy76fNwj0I1iYNNLQNxtsRysW6r71GPrgcoISVpAyMSqtjnWcHVXh88f2WeMFptgnDyg4Fpt+2jwfbROuPg/TycH8bgCrOVCxBk71L3rv/Z2AIWDqMHhy0I1eBrCE5hW0N1O0vSyUbR32Cb7nedleXOreFr0GI1ZyVE3kJm46/JVTKWzL4olsd2d1emcv7uCa9QraXmGvBAV58ZBNE7f2Ox/UZFQ/q4DzQvfoiwehDsgWir8zB4d+7ZMwVtPyM6d+epbk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b49fd1-5ea8-434e-1d9c-08d6b89e7d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 01:40:16.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several scenarios that keyboard can NOT wake up system
from suspend, e.g., if a keyboard is depressed between system
device suspend phase and device noirq suspend phase, the keyboard
ISR will be called and both keyboard depress and release interrupts
will be disabled, then keyboard will no longer be able to wake up
system. Another scenario would be, if a keyboard is kept depressed,
and then system goes into suspend, the expected behavior would be
when keyboard is released, system will be waked up, but current
implementation can NOT achieve that, because both depress and release
interrupts are disabled in ISR, and the event check is still in
progress.

To fix these issues, need to make sure keyboard's depress or release
interrupt is enabled after noirq device suspend phase, this patch
moves the suspend/resume callback to noirq suspend/resume phase, and
enable the corresponding interrupt according to current keyboard status.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/imx_keypad.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/i=
mx_keypad.c
index cf08f4a..97500a2 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -524,11 +524,12 @@ static int imx_keypad_probe(struct platform_device *p=
dev)
 	return 0;
 }
=20
-static int __maybe_unused imx_kbd_suspend(struct device *dev)
+static int __maybe_unused imx_kbd_noirq_suspend(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct imx_keypad *kbd =3D platform_get_drvdata(pdev);
 	struct input_dev *input_dev =3D kbd->input_dev;
+	unsigned short reg_val =3D readw(kbd->mmio_base + KPSR);
=20
 	/* imx kbd can wake up system even clock is disabled */
 	mutex_lock(&input_dev->mutex);
@@ -538,13 +539,20 @@ static int __maybe_unused imx_kbd_suspend(struct devi=
ce *dev)
=20
 	mutex_unlock(&input_dev->mutex);
=20
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(&pdev->dev)) {
+		if (reg_val & KBD_STAT_KPKD)
+			reg_val |=3D KBD_STAT_KRIE;
+		if (reg_val & KBD_STAT_KPKR)
+			reg_val |=3D KBD_STAT_KDIE;
+		writew(reg_val, kbd->mmio_base + KPSR);
+
 		enable_irq_wake(kbd->irq);
+	}
=20
 	return 0;
 }
=20
-static int __maybe_unused imx_kbd_resume(struct device *dev)
+static int __maybe_unused imx_kbd_noirq_resume(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct imx_keypad *kbd =3D platform_get_drvdata(pdev);
@@ -568,7 +576,9 @@ static int __maybe_unused imx_kbd_resume(struct device =
*dev)
 	return ret;
 }
=20
-static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend, imx_kbd_resume);
+static const struct dev_pm_ops imx_kbd_pm_ops =3D {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_kbd_noirq_suspend, imx_kbd_noirq_resume=
)
+};
=20
 static struct platform_driver imx_keypad_driver =3D {
 	.driver		=3D {
--=20
2.7.4

