Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5991C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749AA20851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="dL1kFzgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391238AbfEXMtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:49:31 -0400
Received: from mail-eopbgr60116.outbound.protection.outlook.com ([40.107.6.116]:38531
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390946AbfEXMtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GHnpHUgZ8sy1MlP7Baa0UOp0J5ynHbnIhJtzq7Zu8o=;
 b=dL1kFzgM6aH0AJ/1vH/8p5900NT2BdzlYNm2vPyyx/m4k6hKd+zwmPWg5d9z0rAnrmdw66v4UzI/9/GoFCfEcojAdIdJM3GoFCUMUOxG3uO83qItQTAJSNrygI9cp4kRa4zjPlhk9rjU9eMoZ4xEk+hQfsXcXDbBEKw7bK0mKfc=
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com (10.170.247.12) by
 HE1PR07MB3065.eurprd07.prod.outlook.com (10.170.244.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.10; Fri, 24 May 2019 12:49:13 +0000
Received: from HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::d9d:d6d7:1e49:a316]) by HE1PR07MB3337.eurprd07.prod.outlook.com
 ([fe80::d9d:d6d7:1e49:a316%3]) with mapi id 15.20.1943.007; Fri, 24 May 2019
 12:49:13 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Subject: [PATCH] adm1275: support PMBUS_VIRT_*_SAMPLES
Thread-Topic: [PATCH] adm1275: support PMBUS_VIRT_*_SAMPLES
Thread-Index: AQHVEi8WZbhhz1TyCEmlx6WeByshdA==
Date:   Fri, 24 May 2019 12:49:13 +0000
Message-ID: <20190524124841.GA25728@localhost.localdomain>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0386.eurprd05.prod.outlook.com
 (2603:10a6:7:94::45) To HE1PR07MB3337.eurprd07.prod.outlook.com
 (2603:10a6:7:2d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eef1b52c-1ff8-4707-a999-08d6e0463925
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB3065;
x-ms-traffictypediagnostic: HE1PR07MB3065:
x-microsoft-antispam-prvs: <HE1PR07MB3065E340D80C188D55B820FDEF020@HE1PR07MB3065.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(1076003)(5660300002)(4326008)(316002)(9686003)(6486002)(66946007)(73956011)(66476007)(6436002)(186003)(6116002)(6512007)(66446008)(64756008)(3846002)(66556008)(53936002)(305945005)(7736002)(54906003)(110136005)(508600001)(386003)(99286004)(52116002)(68736007)(25786009)(81156014)(81166006)(8936002)(86362001)(8676002)(6506007)(107886003)(61506002)(66066001)(71200400001)(14444005)(102836004)(14454004)(33656002)(71190400001)(2906002)(476003)(486006)(256004)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB3065;H:HE1PR07MB3337.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AGq9m7/FNg+lH8EiEjNC34Gc/Seto4OQxS4cGIOW+MQ1N9tv0jYStH98AEaGECuBzkI7ztMdB9RZhP9eXg6q51EoHCf1FZPlSFwwKblPLZtqBStwJeqWioWWUlzFl4ApGqB0rANH2CcH6kqw/7s3gzbEc6GW7uspjxKNUr6Kh3k+wSBGzvlb69JpeTofOlrk55WBmf54YSC2JTuYXW1fFwNQcL9O4jRAQ6APKWOVdb93W1LsrFzf0fLU4W0ykqs9BJf7T6A6j1+oHLR2LXK4SpYI5aRzQRN8ONffLuh+0IS7oHdLwu1NFvIudkPMl0lHGeIcVU+4IaxfDyDVvBxMWLox5d+Y5ySX7txqMOQFhNDBsj116585Zip+hcvgq2iY8MKNGKGhl2N+Hj0QzyNexHm+AJyMKGl0peI+V3e+94M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <611976EE7C5C6F4F8DA16AE6543EFBB1@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef1b52c-1ff8-4707-a999-08d6e0463925
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 12:49:13.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krzysztof.adamski@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device supports setting the number of samples for averaging the
measurements. There are two separate settings - PWR_AVG for averaging
PIN and VI_AVG for averaging VIN/VAUX/IOUT, both being part of
PMON_CONFIG register. The values are stored as exponent of base 2 of the
actual number of samples that will be taken.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 drivers/hwmon/pmbus/adm1275.c | 68 ++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index f569372c9204..4efe1a9df563 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -23,6 +23,8 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/log2.h>
 #include "pmbus.h"
=20
 enum chips { adm1075, adm1272, adm1275, adm1276, adm1278, adm1293, adm1294=
 };
@@ -78,6 +80,10 @@ enum chips { adm1075, adm1272, adm1275, adm1276, adm1278=
, adm1293, adm1294 };
 #define ADM1075_VAUX_OV_WARN		BIT(7)
 #define ADM1075_VAUX_UV_WARN		BIT(6)
=20
+#define ADM1275_PWR_AVG_MASK		GENMASK(13, 11)
+#define ADM1275_VI_AVG_MASK		GENMASK(10, 8)
+#define ADM1275_SAMPLES_AVG_MAX	128
+
 struct adm1275_data {
 	int id;
 	bool have_oc_fault;
@@ -90,6 +96,7 @@ struct adm1275_data {
 	bool have_pin_max;
 	bool have_temp_max;
 	struct pmbus_driver_info info;
+	struct mutex lock;
 };
=20
 #define to_adm1275_data(x)  container_of(x, struct adm1275_data, info)
@@ -164,6 +171,38 @@ static const struct coefficients adm1293_coefficients[=
] =3D {
 	[18] =3D { 7658, 0, -3 },		/* power, 21V, irange200 */
 };
=20
+static inline int adm1275_read_pmon_config(struct i2c_client *client, u64 =
mask)
+{
+	int ret;
+
+	ret =3D i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(mask, ret);
+}
+
+static inline int adm1275_write_pmon_config(struct i2c_client *client, u64=
 mask,
+					    u16 word)
+{
+	const struct pmbus_driver_info *info =3D pmbus_get_driver_info(client);
+	struct adm1275_data *data =3D to_adm1275_data(info);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret =3D i2c_smbus_read_word_data(client, ADM1275_PMON_CONFIG);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	word =3D FIELD_PREP(mask, word) | (ret & ~mask);
+	ret =3D i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, word);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
 static int adm1275_read_word_data(struct i2c_client *client, int page, int=
 reg)
 {
 	const struct pmbus_driver_info *info =3D pmbus_get_driver_info(client);
@@ -242,6 +281,19 @@ static int adm1275_read_word_data(struct i2c_client *c=
lient, int page, int reg)
 		if (!data->have_temp_max)
 			return -ENXIO;
 		break;
+	case PMBUS_VIRT_POWER_SAMPLES:
+		ret =3D adm1275_read_pmon_config(client, ADM1275_PWR_AVG_MASK);
+		if (ret < 0)
+			break;
+		ret =3D 1 << ret;
+		break;
+	case PMBUS_VIRT_IN_SAMPLES:
+	case PMBUS_VIRT_CURR_SAMPLES:
+		ret =3D adm1275_read_pmon_config(client, ADM1275_VI_AVG_MASK);
+		if (ret < 0)
+			break;
+		ret =3D 1 << ret;
+		break;
 	default:
 		ret =3D -ENODATA;
 		break;
@@ -286,6 +338,17 @@ static int adm1275_write_word_data(struct i2c_client *=
client, int page, int reg,
 	case PMBUS_VIRT_RESET_TEMP_HISTORY:
 		ret =3D pmbus_write_word_data(client, 0, ADM1278_PEAK_TEMP, 0);
 		break;
+	case PMBUS_VIRT_POWER_SAMPLES:
+		word =3D clamp_val(word, 1, ADM1275_SAMPLES_AVG_MAX);
+		ret =3D adm1275_write_pmon_config(client, ADM1275_PWR_AVG_MASK,
+						ilog2(word));
+		break;
+	case PMBUS_VIRT_IN_SAMPLES:
+	case PMBUS_VIRT_CURR_SAMPLES:
+		word =3D clamp_val(word, 1, ADM1275_SAMPLES_AVG_MAX);
+		ret =3D adm1275_write_pmon_config(client, ADM1275_VI_AVG_MASK,
+						ilog2(word));
+		break;
 	default:
 		ret =3D -ENODATA;
 		break;
@@ -422,6 +485,8 @@ static int adm1275_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
=20
+	mutex_init(&data->lock);
+
 	if (of_property_read_u32(client->dev.of_node,
 				 "shunt-resistor-micro-ohms", &shunt))
 		shunt =3D 1000; /* 1 mOhm if not set via DT */
@@ -439,7 +504,8 @@ static int adm1275_probe(struct i2c_client *client,
 	info->format[PSC_CURRENT_OUT] =3D direct;
 	info->format[PSC_POWER] =3D direct;
 	info->format[PSC_TEMPERATURE] =3D direct;
-	info->func[0] =3D PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
+	info->func[0] =3D PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			PMBUS_HAVE_SAMPLES;
=20
 	info->read_word_data =3D adm1275_read_word_data;
 	info->read_byte_data =3D adm1275_read_byte_data;
--=20
2.20.1

