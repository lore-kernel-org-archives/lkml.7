Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A027CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE70214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jabil.com header.i=@jabil.com header.b="pA0SqOyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfJZILE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 04:11:04 -0400
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:37344
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfJZILD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 04:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TViaHqTZXJR0OEGGPN3JqkJ0hr7SMUrN4MR98gHBAn1So8YNoAxAKZ1HH1w5+i7UaOhYFR6YSftFKOTWditwD9BbqUOEBXj2aH1FlzCTKYZWBQVGluv3TC2w9BjgafGk69r//rpCVG/RGa8O3nPEYD1YWbrfC2AFKrV+ThoIVmN8ccEtMAhXOBzbwP+DxEZ3bCBAv6LI8y9O0yiZ8gZWOrr7R5002QSl+622/aU+4vYgh7T/eUay/QwjHLoUnMyIzImWCmKt47SApPBtH4rbwAfmB0D32r7O6//AsZqD9QJZ6FBTuPvQ53SIl92e27oWBxZw1Mlonh6CTCwxjamrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XFB6AhYhZzv1k4oQ9J6OWAkGMLH3JX/1RXqIVOvp0Q=;
 b=b5Tg00hM1ACsdASPfzvAM7IxeoKkzbujcVhxYVENSW4O5ez7I2DivLK2bMvWT2hqANRqfa+jn3sJrq3UfP62zXacNl+0i3ZFZxm2EwmCyEqQ6bpMuVfyNVwVWB8BvKv/jW7D29fzKLnaGbsMIkSwycDp4lE1R8CBJb273hZIVe9WIXs75zv+PXt4m5d4B5JQNwRLAXD7KWpxpQQ326VDeud1LFd/ItzOVnlh1ISufW9rq+N9AtE30SGZ0o8QsOh0a/ynihaSvmxNIBHof2dKk9UZyQA8qEchhzRjcTvy9lnHP9EdkIQZgdeEJMQkyMxWU2WYxdsrcDZpEq2lS0RnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XFB6AhYhZzv1k4oQ9J6OWAkGMLH3JX/1RXqIVOvp0Q=;
 b=pA0SqOyMx7fJY/VC1AMUoXhOGXIy8H8Ci5/q2EiBNZQBiX/UxrUNThEGGrClS5F9v4lk8lvc6/pCMIIetr+6JnAcvOV8iOb4zr/ZSphyTCK6q0eimlwD1QYITXvKcB0+Er7e9HwRM3+6ldw9GOkP2uYDMzb/+nYoX0//aqyp/6I=
Received: from MN2PR02MB6703.namprd02.prod.outlook.com (52.135.48.83) by
 MN2PR02MB6749.namprd02.prod.outlook.com (52.135.48.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Sat, 26 Oct 2019 08:10:59 +0000
Received: from MN2PR02MB6703.namprd02.prod.outlook.com
 ([fe80::524:774a:6751:7177]) by MN2PR02MB6703.namprd02.prod.outlook.com
 ([fe80::524:774a:6751:7177%5]) with mapi id 15.20.2387.023; Sat, 26 Oct 2019
 08:10:59 +0000
From:   Rain Wang <Rain_Wang@Jabil.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] lm75: add lm75b detection
Thread-Topic: [PATCH] lm75: add lm75b detection
Thread-Index: AQHVi9TmDrxen4j80EuOn1QRxLtsQA==
Date:   Sat, 26 Oct 2019 08:10:59 +0000
Message-ID: <20191026081049.GA16839@rainw-fedora28-jabil.corp.JABIL.ORG>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.230.226]
x-clientproxiedby: SG2PR0601CA0007.apcprd06.prod.outlook.com (2603:1096:3::17)
 To MN2PR02MB6703.namprd02.prod.outlook.com (2603:10b6:208:1d2::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rain_Wang@Jabil.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f9fff31-0937-433d-f856-08d759ec08f1
x-ms-traffictypediagnostic: MN2PR02MB6749:|MN2PR02MB6749:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6749C5970F45FB49AFA361138D640@MN2PR02MB6749.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0202D21D2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(33656002)(66446008)(66476007)(71200400001)(6486002)(26005)(66946007)(4326008)(6436002)(6512007)(8936002)(186003)(25786009)(66066001)(478600001)(6116002)(3846002)(316002)(14454004)(7736002)(305945005)(110136005)(9686003)(102836004)(476003)(5660300002)(486006)(256004)(2906002)(14444005)(6506007)(86362001)(386003)(64756008)(66556008)(99286004)(71190400001)(52116002)(8676002)(81156014)(81166006)(1076003)(80792005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR02MB6749;H:MN2PR02MB6703.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: Jabil.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdTtInM2I7dMsx/jtgR+xoheIR1n/aiUqbTVmkLKijqr8unWp8SyRPxnNOHG8iFQIHZDVn/cKQYraNFZz4uoBT7RBCpFX8DccpJpqfJWiBHPAaZGaHC+MxsDaJpx2l+R7uq56RUzbD0oFI2jMAewI6QvKx45Tj1ovPNVA2yJ73Noz52DvCRfOS5PQXinMJgceNgUbpYstgYvgZayabhHvyT59qILGJtTH3efNIOfbJCV5qskF4VCmBvYGsiLL09rcR4X+ErVudZRp19TvBQocHda1zpW1rFRX1Xw78ruseTkAnGqaeELG9q8vZWT2xAh0wKH6DDsQt9RvL1FI/GlZHXKmDUGc79wgs4f+4vJ/lvNqHuVRsygtXXqVn58DHVgBjFGcEFpzIlFnVPtUvnzbrHglw8tHiQ7iT/he98hSA4h2qtUuTfHL8fHt6MbcuNa
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B1E8AAFB53B8A7468CC39E72BE7607A8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9fff31-0937-433d-f856-08d759ec08f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2019 08:10:59.6958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBeIysC68t0qBqgp5uo/xtdNLM4yX3h0wJhzdw6cGl7d7B2ZLjpEmvln1eiuxij2azmCtjg5Y9w9WHOgyeG9ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The National Semiconductor LM75B is very similar as the
LM75A, but it has no ID byte register 7, and unused registers
return 0xff rather than the last read value like LM75A.

Signed-off-by: Rain Wang <rain_wang@jabil.com>
---
 drivers/hwmon/lm75.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 5e6392294c03..a718f9eb4d72 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -760,6 +760,7 @@ static int lm75_detect(struct i2c_client *new_client,
 	int i;
 	int conf, hyst, os;
 	bool is_lm75a =3D 0;
+	bool is_lm75b =3D 0;
=20
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
@@ -780,8 +781,12 @@ static int lm75_detect(struct i2c_client *new_client,
 	 * register 7, and unused registers return 0xff rather than the
 	 * last read value.
 	 *
+	 * The National Semiconductor LM75B is very similar as the
+	 * LM75A, but it has no ID byte register 7, and unused registers=20
+	 * return 0xff rather than the last read value like LM75A.
+	 *
 	 * Note that this function only detects the original National
-	 * Semiconductor LM75 and the LM75A. Clones from other vendors
+	 * Semiconductor LM75 and the LM75A/B. Clones from other vendors
 	 * aren't detected, on purpose, because they are typically never
 	 * found on PC hardware. They are found on embedded designs where
 	 * they can be instantiated explicitly so detection is not needed.
@@ -806,6 +811,13 @@ static int lm75_detect(struct i2c_client *new_client,
 		is_lm75a =3D 1;
 		hyst =3D i2c_smbus_read_byte_data(new_client, 2);
 		os =3D i2c_smbus_read_byte_data(new_client, 3);
+	} else if (i2c_smbus_read_byte_data(new_client, 4) =3D=3D 0xff
+		 && i2c_smbus_read_byte_data(new_client, 5) =3D=3D 0xff
+		 && i2c_smbus_read_byte_data(new_client, 6) =3D=3D 0xff) {
+		/* LM75B detection */
+		is_lm75b =3D 1;
+		hyst =3D i2c_smbus_read_byte_data(new_client, 2);
+		os =3D i2c_smbus_read_byte_data(new_client, 3);
 	} else { /* Traditional style LM75 detection */
 		/* Unused addresses */
 		hyst =3D i2c_smbus_read_byte_data(new_client, 2);
@@ -839,7 +851,8 @@ static int lm75_detect(struct i2c_client *new_client,
 			return -ENODEV;
 	}
=20
-	strlcpy(info->type, is_lm75a ? "lm75a" : "lm75", I2C_NAME_SIZE);
+	strlcpy(info->type, is_lm75a ?=20
+		"lm75a" : (is_lm75b ? "lm75b" : "lm75"), I2C_NAME_SIZE);
=20
 	return 0;
 }
--=20
2.21.0

