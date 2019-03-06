Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E60420663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="GHPFp6su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfCFXQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:16:20 -0500
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:32096
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfCFXQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEDsSkcy2Dl+pZMj925hy09I5tHTZNUpLAFoVOaWT7E=;
 b=GHPFp6su/WADVz5MJQaQEtJsnAEAFCiGqgz/Xd54+TjuDm3hzf0RiIYvgBEepZMtUCLSqJ+srYJbBuFegJweZ8WfqZvfex78wNOJOejiyAIWJ/C50p/Qn5KwfVspfiboFRkvd3Kxwpr5RjnxLTx+24aE9I/nvgwGwy9qQEaXEP8=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4592.eurprd02.prod.outlook.com (20.178.12.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 23:15:46 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 23:15:46 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
Subject: [PATCH v2 3/5] i2c: mux: pca9541: prepare for PCA9641 support
Thread-Topic: [PATCH v2 3/5] i2c: mux: pca9541: prepare for PCA9641 support
Thread-Index: AQHU1HKH44/iJB6yF0CBwnJOj23PjQ==
Date:   Wed, 6 Mar 2019 23:15:45 +0000
Message-ID: <20190306231521.29367-4-peda@axentia.se>
References: <20190306231521.29367-1-peda@axentia.se>
In-Reply-To: <20190306231521.29367-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 115f7e9d-4c7b-4635-9a82-08d6a289a98a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4592;
x-ms-traffictypediagnostic: VI1PR02MB4592:
x-microsoft-antispam-prvs: <VI1PR02MB45921B5F7F87D963F2C988A7BC730@VI1PR02MB4592.eurprd02.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(366004)(346002)(136003)(189003)(199004)(5640700003)(53936002)(6486002)(71200400001)(6436002)(2501003)(71190400001)(99286004)(4326008)(6916009)(476003)(102836004)(76176011)(256004)(446003)(486006)(52116002)(3846002)(86362001)(386003)(74482002)(6506007)(6512007)(26005)(6116002)(97736004)(66066001)(305945005)(7736002)(2351001)(186003)(2616005)(14444005)(11346002)(25786009)(106356001)(36756003)(8936002)(8676002)(68736007)(81156014)(81166006)(5660300002)(508600001)(2906002)(54906003)(1076003)(50226002)(316002)(14454004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4592;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR02MB4592;23:6jdWfkUmVI0r0ow5QOOAXc0ve/ZbxajTwtYC8tI?=
 =?iso-8859-1?Q?/7Bo+pSPVehhZHvzwGKIBj7ElgMloC55LM1ZNpH02Z1cNo9GGdBiCnTaJA?=
 =?iso-8859-1?Q?+raFM2iNdSUgKiaZqLszTTBP5dEovZBXvyCh0WjzQq7dUvesNSh1o3hEHG?=
 =?iso-8859-1?Q?B7u2W3Fr7YYGYD7UF4fTBsXgbRS1ycIGihD9bKUp5VHsFVm7P/ZfXetSzh?=
 =?iso-8859-1?Q?IwlirXW3f86VsTIr12qVP/dMRVkODU5OtXrBPIcJurUxQZK6mKOfqfeoY8?=
 =?iso-8859-1?Q?Syfe1+BXrS5gIa757YOLGvpD7Jno4s+x22EfHtI9EpvBfr+zsKD+bD9i07?=
 =?iso-8859-1?Q?q187FQFkA29c6MD03BR6KzF9a3CuD7nIjErNzY1ec8vD8nfopB/dNG+w0T?=
 =?iso-8859-1?Q?EBRhaS+gGp4XGm6pHj+gRPvYlnPbnlK30/sa57ESmyJJO6tG+AWVrURjFs?=
 =?iso-8859-1?Q?ArTwZUxBVE1sWnIHFeyBBLMkfy0Nav1A1OjUyMsLUP2689bMbNHBHB+Byv?=
 =?iso-8859-1?Q?n/Qoj4+0txqmajmN9u+MkiyOltKv7T0jYGUZFGrSW0QOhNJ7F6TF7iIRiK?=
 =?iso-8859-1?Q?nVVeNhcVlfMmmmCxHSRwmHwgF/n8fHJIyF1nlQufz178mVi5zF9fCIkTGO?=
 =?iso-8859-1?Q?a+/aawSqgRDiSsFYi6LIRJY1sUXEWWF/GiWlPGeMyfeAI9kXKneaZo7scz?=
 =?iso-8859-1?Q?5/yikmyuveWttiV+8R1lCvbJjVMLSr3evW2k6fU3bciVojCwvLLd+53e0b?=
 =?iso-8859-1?Q?cdl9hrJ0yoJHKouZzMR4eYekIFoQ86ApvkT8SEKzIuWjXUDoj6WLYQ5O+1?=
 =?iso-8859-1?Q?gGbtgMOmWozpInYUx5AxiT/QJMYNa9RttmOgp/NKjUhBvxtR+UoJhcAtwZ?=
 =?iso-8859-1?Q?IPBSL64XxzLxHrBLVgPgG0t7aX1bpUw9iDy/BOltzm2wSzuKPJ08Un7zL3?=
 =?iso-8859-1?Q?9fdweJOXYJ+SFlsuslTVW+NSuOYHkqjhHS2zH7+MkJsjVsgJHoBH/5c6+C?=
 =?iso-8859-1?Q?Aaqoemoz4gN8gnin15Rr+HXFOGN6reH4pVizKqZHZLrDkxkxIczGr57N6N?=
 =?iso-8859-1?Q?1RY9HujB0wh5hmXQDzm6c4BDGgkFfltvVlwikZfBn5GdxRkA+pnvc8nGJD?=
 =?iso-8859-1?Q?XWXGr59Stxb1JAiX/oIKuHJ8iCY7utD67eQaJOA3PmxuBJUTlPCqdjGhRI?=
 =?iso-8859-1?Q?DzUUmVPvDGoynPJN0z3eI8B4Yl2HmzNJeHYIh0KFF88IdtunaFJXyFQ+CX?=
 =?iso-8859-1?Q?V+cHe0ua9arVgZP9Q+HDdrDOJLTDEAveuG3SqjB1RP4/NOdi3yf0Lte5zV?=
 =?iso-8859-1?Q?Jw400eS0oAsFS3K5DtzkyX8w7RAgYZD0mebAx4FmZGRgahwE8csS6upcco?=
 =?iso-8859-1?Q?b4ZyqOPQ=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KiN0cHHlCCcK/GIOOWWh1mOMJ+dFxzbsA4IpWQwfcizwxKAcL5Fo8mtcoBRHQoTTiszucWawI3VGQcawrbpt9vr2rAgBSSbrRLAr+M79hIMGlc2XP9I6vXr8neoZ77GqtQbl/36APQq+qJloA/dUXgA+e2Re2yy9fz+GvtpVpq77S9cBRXhrcxx7oS5hlyNThYWFXkjdS8CDAKuHxXVljVjUYxPlIIwUScMvPPL/b45ooGPaGFzT3iz8/gF4LX9dCGALGoRJQeShTQyaKtCurIuXNwJgbjH5RbxGh162qNMR5bqG7yyy2lh4KyL5AQwWjZWnss9CjQWX72h6AOQAiwRk1UA1bHBBVUg7l52zA6KEfE1vs/uLKDhRLQ573ZAn1qHHAJ+FGXliOCcxfTGqaXoIpV+SjOqtp6xg7h8g1TA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 115f7e9d-4c7b-4635-9a82-08d6a289a98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 23:15:45.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the arbitrate and release_bus implementation chip specific.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 62 +++++++++++++++++++++++++++------=
----
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mu=
x-pca9541.c
index 28f46450f4b4..5eb36e3223d5 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -23,6 +23,7 @@
 #include <linux/i2c-mux.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_data/pca954x.h>
 #include <linux/slab.h>
=20
@@ -70,26 +71,22 @@
 #define SELECT_DELAY_SHORT	50
 #define SELECT_DELAY_LONG	1000
=20
-struct pca9541 {
-	struct i2c_client *client;
-	unsigned long select_timeout;
-	unsigned long arb_timeout;
+enum chip_name {
+	pca9541,
 };
=20
-static const struct i2c_device_id pca9541_id[] =3D {
-	{"pca9541", 0},
-	{}
+struct chip_desc {
+	int (*arbitrate)(struct i2c_client *client);
+	void (*release_bus)(struct i2c_client *client);
 };
=20
-MODULE_DEVICE_TABLE(i2c, pca9541_id);
+struct pca9541 {
+	const struct chip_desc *chip;
=20
-#ifdef CONFIG_OF
-static const struct of_device_id pca9541_of_match[] =3D {
-	{ .compatible =3D "nxp,pca9541" },
-	{}
+	struct i2c_client *client;
+	unsigned long select_timeout;
+	unsigned long arb_timeout;
 };
-MODULE_DEVICE_TABLE(of, pca9541_of_match);
-#endif
=20
 static bool pca9541_mybus(int ctl)
 {
@@ -271,7 +268,7 @@ static int pca9541_select_chan(struct i2c_mux_core *mux=
c, u32 chan)
 		/* force bus ownership after this time */
=20
 	do {
-		ret =3D pca9541_arbitrate(client);
+		ret =3D data->chip->arbitrate(client);
 		if (ret)
 			return ret < 0 ? ret : 0;
=20
@@ -289,10 +286,32 @@ static int pca9541_release_chan(struct i2c_mux_core *=
muxc, u32 chan)
 	struct pca9541 *data =3D i2c_mux_priv(muxc);
 	struct i2c_client *client =3D data->client;
=20
-	pca9541_release_bus(client);
+	data->chip->release_bus(client);
 	return 0;
 }
=20
+static const struct chip_desc chips[] =3D {
+	[pca9541] =3D {
+		.arbitrate =3D pca9541_arbitrate,
+		.release_bus =3D pca9541_release_bus,
+	},
+};
+
+static const struct i2c_device_id pca9541_id[] =3D {
+	{ "pca9541", pca9541 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pca9541_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pca9541_of_match[] =3D {
+	{ .compatible =3D "nxp,pca9541", .data =3D &chips[pca9541] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pca9541_of_match);
+#endif
+
 /*
  * I2C init/probing/exit functions
  */
@@ -301,6 +320,8 @@ static int pca9541_probe(struct i2c_client *client,
 {
 	struct i2c_adapter *adap =3D client->adapter;
 	struct pca954x_platform_data *pdata =3D dev_get_platdata(&client->dev);
+	const struct of_device_id *match;
+	const struct chip_desc *chip;
 	struct i2c_mux_core *muxc;
 	struct pca9541 *data;
 	int force;
@@ -309,12 +330,18 @@ static int pca9541_probe(struct i2c_client *client,
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
=20
+	match =3D of_match_device(of_match_ptr(pca9541_of_match), &client->dev);
+	if (match)
+		chip =3D of_device_get_match_data(&client->dev);
+	else
+		chip =3D &chips[id->driver_data];
+
 	/*
 	 * I2C accesses are unprotected here.
 	 * We have to lock the I2C segment before releasing the bus.
 	 */
 	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
-	pca9541_release_bus(client);
+	chip->release_bus(client);
 	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
=20
 	/* Create mux adapter */
@@ -329,6 +356,7 @@ static int pca9541_probe(struct i2c_client *client,
 		return -ENOMEM;
=20
 	data =3D i2c_mux_priv(muxc);
+	data->chip =3D chip;
 	data->client =3D client;
=20
 	i2c_set_clientdata(client, muxc);
--=20
2.11.0

