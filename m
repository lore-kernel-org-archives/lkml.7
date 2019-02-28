Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF1A218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plantronics.onmicrosoft.com header.i=@plantronics.onmicrosoft.com header.b="NdwKADd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbfB1REf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:04:35 -0500
Received: from mail-eopbgr820095.outbound.protection.outlook.com ([40.107.82.95]:58430
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726093AbfB1REf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=plantronics.onmicrosoft.com; s=selector1-plantronics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm/DP1Oan1yNSD1V96ThreD5hrwSuP81PfVSLOYQtoM=;
 b=NdwKADd3kQArqL3OQGyjTA8F3avTZveBIGlyBUehxnUgy4nFaVlRD1Ip/gb1/2lB9fLFeZjptdYaCvLxO65X17aTiEC+fHRC3Ng7847z4UebucdHjQNN7S8dMrgnu6yeFtCvpc4AJgAqV0alUwfdHw9CVCUxLjPWc2Y3ssauqxg=
Received: from BYAPR02MB5607.namprd02.prod.outlook.com (20.177.230.93) by
 BYAPR02MB4152.namprd02.prod.outlook.com (20.176.249.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 17:02:50 +0000
Received: from BYAPR02MB5607.namprd02.prod.outlook.com
 ([fe80::f892:37d9:9328:ab3e]) by BYAPR02MB5607.namprd02.prod.outlook.com
 ([fe80::f892:37d9:9328:ab3e%6]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 17:02:50 +0000
From:   "Junge, Terry" <Terry.Junge@plantronics.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     "oneukum@suse.de" <oneukum@suse.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor
Thread-Topic: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor
Thread-Index: AQHUz21e8UMJGxDHs0SWc7XgOye1ZKX1bT+w
Date:   Thu, 28 Feb 2019 17:02:50 +0000
Message-ID: <BYAPR02MB56078ADD429292DF89F8C694ED750@BYAPR02MB5607.namprd02.prod.outlook.com>
References: <20190228135556.14713-1-nsaenzjulienne@suse.de>
In-Reply-To: <20190228135556.14713-1-nsaenzjulienne@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Terry.Junge@plantronics.com; 
x-originating-ip: [198.231.9.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15b2eff3-fccc-4dfc-10ea-08d69d9e926d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4152;
x-ms-traffictypediagnostic: BYAPR02MB4152:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR02MB4152;23:ApmTKZem2ssexvZc2OHoO9LWElV6U+fkU1oUtytln?=
 =?us-ascii?Q?A+GI4SVOD3zo79zYVai8prchjI2fq9zpwWNvVjPG8XdwA+IpA8GQ29ZKkqHI?=
 =?us-ascii?Q?x42W0vHdqpz2iQsrIyO5D7wu2l5xPfpyXh9gf8QPQQdB6piNJM0VyLQB5vWG?=
 =?us-ascii?Q?oQa8gD/VEfyFBv3ONFPh8COV9xp8YlX/YompDeznNa2MJFaO1YvSl7vfwFmm?=
 =?us-ascii?Q?1hBaA3COrdGnNlfiIvU+TQEEHJHQFNACtl0GCbk9mQ07Qmw9VXxl8dATH4TI?=
 =?us-ascii?Q?nU1JoHSbMPwJuKDi/U4QpnUV/BGT9iw0xpsNm6y5xXn2TTjQwqikv1IHQ14V?=
 =?us-ascii?Q?l3c8RAIhV5mvzBxGvSoq84QBJYz7UAEHW7rh6g0gus+KEbb4WO68VaOQApvf?=
 =?us-ascii?Q?3BV7Yg24QFXCklGxEtoBmtQFrb4E+194ymztrhBG1Q29xBa7T6kr0WbV0qd+?=
 =?us-ascii?Q?G8rFXYuiNpFVpEniBt3u94TwJRG3W87BV7utMdTtHK0jnvuKsOcqJFA+Fia3?=
 =?us-ascii?Q?QKQNDr6/3u6mGju1dy7tFx9aR30tDH7THHU24N28RMnoZMxD6X0NH69XKeng?=
 =?us-ascii?Q?6M5Nz8+ZBY/lnJRIcSqQqsWQ1uASo/B4x07VBjRZZAQf0/C3qo6LT3VwCG+n?=
 =?us-ascii?Q?DNgFWUzy6YOwLuXvL9wmbbg4IrKz/TBvrmqWtablZqiaoGzHu2zZtItFLjdM?=
 =?us-ascii?Q?ObEkb7chpU5wCddsYqtP8uclQZvNg9fwXNAHAlXZfuXTmKnNqIAB9282WkW4?=
 =?us-ascii?Q?N4QR7PhHuYa2HrrBrUB1MgpylKIB9nYlvi36OWX5SQbnHYJ8NKfw0LqFOzlf?=
 =?us-ascii?Q?YrfNKlt2JxfmXLNU58K/OdWZNsdA3lEbOPhapqhVLoHL5HJsskSljujanP3V?=
 =?us-ascii?Q?91dEXnr6RqR9cvOUshfdTjHk6qM0KTd2v5hb5zxsCCbSTN8uyItWxFKeeY0o?=
 =?us-ascii?Q?3xrwIjnE9P/avqMMh13HJvjAvZ7rRQeNy7xN0pXj/8rAXwjQrht2FP6nKvsO?=
 =?us-ascii?Q?BFtbt9prqk7CyzzNGKV3J+yLMxvjAdYlTeAnwiT0o7Tz8mqBR1CILUt1dUXl?=
 =?us-ascii?Q?8aWo9+xJJ/6aFnxVUVhgCtWZzAJR3hE3MQ2BG70Q2sTdF/Me/5zwcqU0kZrI?=
 =?us-ascii?Q?Z++zOC9ctaPcGPX7CB2O7WkX5WaCAQDTqYV0S3Uu1N9SygNKqQe3TaVxbXHf?=
 =?us-ascii?Q?JDY3Z9sXn3buXVgNhr64CQ1UZ5AzwCqd2THSmjAlNSmRIMOaQEsWUMgG41Ax?=
 =?us-ascii?Q?ZxN0wsAhX0WJpwE/gpuR4/IwoDuB4ixLzCXcSTwqoc0JA2KDSb0p7p2k0O5k?=
 =?us-ascii?Q?97H/yhjbCHN8rQ9Q3UudOSWe2MD4/W1WDXUsGLaWFLoEhfNmmlRVqksrc0Uf?=
 =?us-ascii?Q?t87Bw=3D=3D?=
x-microsoft-antispam-prvs: <BYAPR02MB41525D0A70EE9B351D2D5CDCED750@BYAPR02MB4152.namprd02.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39860400002)(13464003)(199004)(189003)(7696005)(6116002)(110136005)(3846002)(68736007)(76176011)(316002)(72206003)(6506007)(99286004)(8676002)(97736004)(478600001)(81156014)(81166006)(53546011)(486006)(8936002)(2906002)(11346002)(6436002)(446003)(6306002)(476003)(26005)(9686003)(55016002)(186003)(105586002)(7736002)(305945005)(53936002)(4326008)(106356001)(74316002)(25786009)(33656002)(229853002)(54906003)(71190400001)(71200400001)(14454004)(14444005)(66066001)(86362001)(52536013)(966005)(5660300002)(256004)(102836004)(6246003)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4152;H:BYAPR02MB5607.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: plantronics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tfSGtWBrxod6gjm7PM+ITvFYomteo2t8TZ6nOl0Q9XbFPrhK1i0JPKO7z0oISsnJwkuQUeoMRF8n20rYVbZwoVTxiZfrB5CoxaQC9pb9sp3otmODzs1ocuhzkNsuYtp8o1er0c0XI19wnGC4V+FYEOOT8mXDB0xAKaX1PxSc2jsyBUJjtilz3Z9ffnwkVZOqjsimGdmJyvSurB6Hz5RI5/mmSmuV4se4w+RUN7oxiIl822odjJYl2eeF1la39RGIHd6JQnPAqkVLHJkCBRylWG7mpHcT9WJ/vSB7ZBPS0zuStQXbRJ5cvluKc+lPbK0ENCNEAUeeBerDipQOlbv7sDhKXR4vOVrljOzmemUEcAvloPsCSy7pgAIaB0S0iHnd9pHIvbNfkFZeF61NJ2QkYaiSRJ33noVwW7hohH0x+bM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: plantronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b2eff3-fccc-4dfc-10ea-08d69d9e926d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 17:02:50.4667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc7c5f16-c55e-417d-aac0-ff6bbfc27f76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This could also be a parser error. In the HID specification section 6.2.2.8=
 it states that the last declared Usage Page is applied to Usages when the =
Main item is encountered.

"If the bSize field =3D 1 or 2 then the Usage is interpreted as an unsigned=
 value
that selects a Usage ID on the currently defined Usage Page. When the parse=
r
encounters a main item it concatenates the last declared Usage Page with a
Usage to form a complete usage value. Extended usages can be used to
override the currently defined Usage Page for individual usages."

-----Original Message-----
From: linux-input-owner@vger.kernel.org <linux-input-owner@vger.kernel.org>=
 On Behalf Of Nicolas Saenz Julienne
Sent: Thursday, February 28, 2019 5:56 AM
To: Jiri Kosina <jikos@kernel.org>; Benjamin Tissoires <benjamin.tissoires@=
redhat.com>
Cc: oneukum@suse.de; Nicolas Saenz Julienne <nsaenzjulienne@suse.de>; linux=
-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor

A whole set of Primax manufactured wireless keyboards won't work out of the=
 box as they provide wrong HID descriptors. In this case the offense being =
defining the "Usage Maximum/Minimum" local items before the "Usage Page". T=
his will make the parser use the previous "Usage Page" on those local items=
, generating a wrong HID report. This is not a parser error as the spec cle=
arly states that "Usage Page" applies to any item that follows it (see 6.2.=
2.7).

In other words, we get this:

15 00          Logical Minimum (0),
26 ff 00       Logical Maximum (255),
19 00          Usage Minimum (00h),
2a ff 00       Usage Maximum (FFh),
05 07          Usage Page (Keyboard),          ; Keyboard/keypad (07h)
75 08          Report Size (8),
95 06          Report Count (6),
81 00          Input,

Yet they meant this:

15 00          Logical Minimum (0),
26 ff 00       Logical Maximum (255),
05 07          Usage Page (Keyboard),          ; Keyboard/keypad (07h)
19 00          Usage Minimum (00h),
2a ff 00       Usage Maximum (FFh),
75 08          Report Size (8),
95 06          Report Count (6),
81 00          Input,

This patch fixes the issue by overwriting the offending report with a corre=
ct one.

This was made thanks to the user's answers provided here, also full HID des=
criptors are available there:
https://unix.stackexchange.com/questions/377830/linux-hid-driver-for-primax=
-wireless-keyboards/

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

NOTE: This is an RFC as I'm unable to test my fix. Apart from the
  devices mentioned in the patch there is a whole list of them, yet I
  didn't include them as I was unable to access their HID descriptors.

 drivers/hid/hid-ids.h    |  3 +++
 drivers/hid/hid-primax.c | 30 +++++++++++++++++++++++++++++-  drivers/hid/=
hid-quirks.c |  3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h index 24f846d674=
78..b39f9f36d41f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -714,6 +714,7 @@
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
+#define USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL	0x609b
=20
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
@@ -1225,6 +1226,8 @@
 #define USB_DEVICE_ID_PRIMAX_REZEL	0x4e72
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F	0x4d0f
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
+#define USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E63	0x4e63
+#define USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E80	0x4e80
=20
=20
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
diff --git a/drivers/hid/hid-primax.c b/drivers/hid/hid-primax.c index 3a1c=
3c4c50dc..033f6660e8b6 100644
--- a/drivers/hid/hid-primax.c
+++ b/drivers/hid/hid-primax.c
@@ -2,9 +2,11 @@
  * HID driver for primax and similar keyboards with in-band modifiers
  *
  * Copyright 2011 Google Inc. All Rights Reserved
+ * Copyright 2019 Nicolas Saenz Julienne
  *
- * Author:
+ * Authors:
  *	Terry Lambert <tlambert@google.com>
+ *	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and @@=
 -27,6 +29,9 @@ static int px_raw_event(struct hid_device *hid, struct hid_=
report *report,  {
 	int idx =3D size;
=20
+	if (hid->product !=3D USB_DEVICE_ID_PRIMAX_KEYBOARD)
+		return 0;
+
 	switch (report->id) {
 	case 0:		/* keyboard input */
 		/*
@@ -64,8 +69,29 @@ static int px_raw_event(struct hid_device *hid, struct h=
id_report *report,
 	return 0;
 }
=20
+/*
+ * Some Primax manufactured keyboards set "Usage Minimum/Maximum"=20
+values before
+ * setting the "Usage Page". This is not supported as per spec 6.2.2.7.
+ */
+static __u8 *px_fixup(struct hid_device *hid, __u8 *rdesc, unsigned int=20
+*rsize) {
+	__u8 wrong_report[] =3D { 0x19, 0x00, 0x2a, 0xff, 0x05, 0x07 };
+	__u8 fixed_report[] =3D { 0x05, 0x07, 0x19, 0x00, 0x2a, 0xff };
+
+	if (*rsize > 57 &&
+	    !memcmp(&rdesc[51], wrong_report, ARRAY_SIZE(wrong_report))) {
+		hid_info(hid, "fixing up Primax report descriptor\n");
+		memcpy(&rdesc[51], fixed_report, ARRAY_SIZE(fixed_report));
+	}
+
+	return rdesc;
+}
+
 static const struct hid_device_id px_devices[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYB=
OARD_4E63) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYB=
OARD_4E80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO,=20
+USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, px_devices);
@@ -74,8 +100,10 @@ static struct hid_driver px_driver =3D {
 	.name =3D "primax",
 	.id_table =3D px_devices,
 	.raw_event =3D px_raw_event,
+	.report_fixup =3D px_fixup,
 };
 module_hid_driver(px_driver);
=20
 MODULE_AUTHOR("Terry Lambert <tlambert@google.com>");
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c index 9408=
8c0ed68a..9fd256fea231 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -563,6 +563,9 @@ static const struct hid_device_id hid_have_special_driv=
er[] =3D {  #endif  #if IS_ENABLED(CONFIG_HID_PRIMAX)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYB=
OARD_4E63) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYB=
OARD_4E80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO,=20
+USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL) },
 #endif
 #if IS_ENABLED(CONFIG_HID_PRODIKEYS)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMI=
DI) },
--
2.20.1

