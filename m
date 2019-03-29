Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59410C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B83B2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="St8oea1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfC2HAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:00:52 -0400
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:32131
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728719AbfC2HAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0p3nav0h+E5m1b7JOSH5tauxn0XW6KkmEXUy4n5WYE=;
 b=St8oea1Na88aCkuKvSDCjpyb7qV8svDFsx+6XidZsJxLfzBcru6n2+80wfXShsOz7jFoJT54zn/ohPr0cP8iVHAybnPgbOG8SmdK2sYvMhIY849OP5F+F5l9gqKXrJK1cMJSJUTyWpe+mHgBmXRh9TC85ujNWnqIDwWRiadQMnk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 07:00:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 07:00:47 +0000
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
Subject: [PATCH 2/2] input: keyboard: imx: make sure keyboard can always wake
 up system
Thread-Topic: [PATCH 2/2] input: keyboard: imx: make sure keyboard can always
 wake up system
Thread-Index: AQHU5f0iWX9TLLtu/k286fhNdOUt7A==
Date:   Fri, 29 Mar 2019 07:00:46 +0000
Message-ID: <1553842562-8481-2-git-send-email-Anson.Huang@nxp.com>
References: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1553842562-8481-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:36::25) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdfab784-3275-4f62-0657-08d6b41444b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3708;
x-ms-traffictypediagnostic: DB3PR0402MB3708:
x-microsoft-antispam-prvs: <DB3PR0402MB37083EEEE272989F3F0925C1F55A0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(8936002)(50226002)(5660300002)(26005)(186003)(110136005)(4326008)(102836004)(256004)(14444005)(6512007)(99286004)(25786009)(305945005)(316002)(36756003)(11346002)(66066001)(486006)(2906002)(476003)(7736002)(2616005)(52116002)(446003)(68736007)(53936002)(6486002)(71200400001)(71190400001)(81156014)(14454004)(8676002)(81166006)(478600001)(3846002)(105586002)(6116002)(106356001)(76176011)(2501003)(2201001)(6506007)(6436002)(97736004)(386003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3708;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zOYn6PfMebZZ1sbRMhJNVnlX4ooWlR0z1U07WzRlZ/iutu/9LfmMPvIs44hucg57hsziBbPwN6wj56RXxg6pkdsacw+3M5HmZmoxlAAgnIwjzPxKa+0sEg78jUQf0sr9XYcXtha22lPVMnNyjy4CF7qhxVtRxZ0s8sV5pc/mCExBR2bfE9yeAzScI01CDRO9ITZO1h0An87JcvP2k54y8nQziop4euZ5YPGSH6vecYURHbw9If2DOPi1ipn7IUi2tSWjgmtEbNN94Y6jXOnCsfHKGIQ/2h+pOaWormDCvvuVbami3HY7AdbkC2kExM8Kwqr1i8X4ymCZOapzVYV1doB1rWyzQIB/2nh5G7Q3NgJfEZ+NpFwqneOOeizxrN6CUr0NsuC0Dh56KUs9hMnL840p9ixWWd4+ikXZmJPdMrk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfab784-3275-4f62-0657-08d6b41444b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 07:00:46.9601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3708
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
index 7e32c36..9ae2090 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -521,11 +521,12 @@ static int imx_keypad_probe(struct platform_device *p=
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
@@ -535,13 +536,20 @@ static int __maybe_unused imx_kbd_suspend(struct devi=
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
@@ -565,7 +573,9 @@ static int __maybe_unused imx_kbd_resume(struct device =
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

