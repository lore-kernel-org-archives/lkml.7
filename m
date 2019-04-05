Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA9AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24A32186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="WAF/0RyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfDELPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:15:19 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:17282
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730596AbfDELPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QElaM6p9aA7sjRAUh6b2AVsJK7Z56K1x57AuugQLrqU=;
 b=WAF/0RyId60osSK7K+XIMgbOVd5h3r99x+byAW9hdQRtTvMVS1BIZjKeeMyf+lBIwVwRsUvBvlYJDDjWZwLB89DQuU2KoG20gOuVSXgpBfwK4JyqKtQBJhanrmqOdDiG+kadf4WtuRW2iy3kVMRpAyu/6lYu9aIDfQc+gBVDvGI=
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com (20.178.94.211) by
 AM6PR06MB5944.eurprd06.prod.outlook.com (20.178.95.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Fri, 5 Apr 2019 11:14:35 +0000
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476]) by AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476%4]) with mapi id 15.20.1750.014; Fri, 5 Apr 2019
 11:14:35 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH 1/1] rtc: ds3232: get SRAM access using NVMEM Framework
Thread-Topic: [PATCH 1/1] rtc: ds3232: get SRAM access using NVMEM Framework
Thread-Index: AQHU66DAdPJX3q+9E0y1tHM/Hisrmw==
Date:   Fri, 5 Apr 2019 11:14:35 +0000
Message-ID: <20190405111348.28935-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0062.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::30) To AM6PR06MB5557.eurprd06.prod.outlook.com
 (2603:10a6:20b:9c::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 102e48dc-8f74-4e23-5732-08d6b9b7e26f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR06MB5944;
x-ms-traffictypediagnostic: AM6PR06MB5944:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <AM6PR06MB59444527B3420178C541A67785510@AM6PR06MB5944.eurprd06.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39850400004)(189003)(199004)(86362001)(53936002)(6486002)(5660300002)(2201001)(305945005)(68736007)(256004)(71200400001)(14454004)(105586002)(14444005)(6116002)(6512007)(106356001)(71190400001)(66066001)(4326008)(3846002)(6436002)(8676002)(7736002)(107886003)(2906002)(81166006)(50226002)(36756003)(386003)(99286004)(478600001)(81156014)(110136005)(102836004)(316002)(1076003)(8936002)(52116002)(186003)(2616005)(486006)(476003)(2501003)(97736004)(25786009)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR06MB5944;H:AM6PR06MB5557.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CJX6A0Aij/FtqS7qovOB5Wg9zhTXr3I4VnnfL3wi67YDz00Q4vxpNInVC7oj0zTU0+zmFvyxfZEdFmnYswoCMSZ4Nv7sK/xC+Qy57Rt+Bu72tzXTAbIpuCV1kn0EXP/GanKyYW36U2v1SHw23T68lmkwpVqCZsdG6GjAW6LAS650vWvkR+NwHy5ZQoFYozUymxgqglX/FgpziyB+UpHsrxlQis9a4E60EL6nCduDIhMAF7pnvpps7oEmHJpNPaUEKrpvz1zcVWG0+DGoOkSOwfh0MGxKWm4A2lWXW3okjf3SENUq7mTM9chfWSJKkJ/C3nMLeZyxzzXKShrAh01pjolBcF2mw07AaGKugYH+YtqnoiGRXlEjnwxtlJ1cBQ84lLSgqrB+xA9fjCFwX1vXeYzH84zGzSt7rHoIge1DfGs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102e48dc-8f74-4e23-5732-08d6b9b7e26f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 11:14:35.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DS3232 RTC has 236 bytes of persistent memory.

Add RTC SRAM read and write access using
the NVMEM Framework.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---

Description
-----------
Provides DS3232 RTC SRAM access using NVMEM framework.

Testing
-------
The test was done on a custom board which contains a
DS3232 RTC device.
Kernel Version: 4.14.60 (Just for clarity, the patch is against master)

1. Verify that SRAM is accessible using NVMEM interface: PASS
`
# hexdump /sys/bus/nvmem/devices/ds3232_sram0/nvmem
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
00000e0
`
2. Modify the content.
`
# echo testing > /sys/bus/nvmem/devices/ds3232_sram0/nvmem
#
`
3. Power cycle the board and verify that contents are preserved: PASS
`
# hexdump -n 10 -C /sys/bus/nvmem/devices/ds3232_sram0/nvmem
00000000  74 65 73 74 69 6e 67 0a  00 00                    |testing...|
0000000a
`

 drivers/rtc/rtc-ds3232.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7184e5145f12..fe615aedaa9a 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -24,6 +24,8 @@
 #include <linux/regmap.h>
 #include <linux/hwmon.h>
=20
+#include "rtc-core.h"
+
 #define DS3232_REG_SECONDS      0x00
 #define DS3232_REG_MINUTES      0x01
 #define DS3232_REG_HOURS        0x02
@@ -48,12 +50,17 @@
 #       define DS3232_REG_SR_A1F     0x01
=20
 #define DS3232_REG_TEMPERATURE	0x11
+#define DS3232_REG_SRAM_START   0x14
+#define DS3232_REG_SRAM_END     0xFF
+
+#define DS3232_REG_SRAM_SIZE    236
=20
 struct ds3232 {
 	struct device *dev;
 	struct regmap *regmap;
 	int irq;
 	struct rtc_device *rtc;
+	struct nvmem_config	nvmem_cfg;
=20
 	bool suspended;
 };
@@ -461,6 +468,24 @@ static const struct rtc_class_ops ds3232_rtc_ops =3D {
 	.alarm_irq_enable =3D ds3232_alarm_irq_enable,
 };
=20
+static int ds3232_nvmem_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct ds3232 *ds3232 =3D (struct ds3232 *)priv;
+
+	return regmap_bulk_read(ds3232->regmap, DS3232_REG_SRAM_START + offset,
+				val, bytes);
+}
+
+static int ds3232_nvmem_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct ds3232 *ds3232 =3D (struct ds3232 *)priv;
+
+	return regmap_bulk_write(ds3232->regmap, DS3232_REG_SRAM_START + offset,
+				 val, bytes);
+}
+
 static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq=
,
 			const char *name)
 {
@@ -476,6 +501,14 @@ static int ds3232_probe(struct device *dev, struct reg=
map *regmap, int irq,
 	ds3232->dev =3D dev;
 	dev_set_drvdata(dev, ds3232);
=20
+	ds3232->nvmem_cfg.name =3D "ds3232_sram";
+	ds3232->nvmem_cfg.stride =3D 1;
+	ds3232->nvmem_cfg.size =3D DS3232_REG_SRAM_SIZE;
+	ds3232->nvmem_cfg.word_size =3D 1;
+	ds3232->nvmem_cfg.reg_read =3D ds3232_nvmem_read;
+	ds3232->nvmem_cfg.reg_write =3D ds3232_nvmem_write;
+	ds3232->nvmem_cfg.priv =3D ds3232;
+
 	ret =3D ds3232_check_rtc_status(dev);
 	if (ret)
 		return ret;
@@ -490,6 +523,10 @@ static int ds3232_probe(struct device *dev, struct reg=
map *regmap, int irq,
 	if (IS_ERR(ds3232->rtc))
 		return PTR_ERR(ds3232->rtc);
=20
+	ds3232->rtc->dev.of_node =3D dev->of_node;
+	ds3232->rtc->nvmem_config =3D &ds3232->nvmem_cfg;
+	rtc_nvmem_register(ds3232->rtc);
+
 	if (ds3232->irq > 0) {
 		ret =3D devm_request_threaded_irq(dev, ds3232->irq, NULL,
 						ds3232_irq,
@@ -542,7 +579,7 @@ static int ds3232_i2c_probe(struct i2c_client *client,
 	static const struct regmap_config config =3D {
 		.reg_bits =3D 8,
 		.val_bits =3D 8,
-		.max_register =3D 0x13,
+		.max_register =3D DS3232_REG_SRAM_END,
 	};
=20
 	regmap =3D devm_regmap_init_i2c(client, &config);
@@ -609,7 +646,7 @@ static int ds3234_probe(struct spi_device *spi)
 	static const struct regmap_config config =3D {
 		.reg_bits =3D 8,
 		.val_bits =3D 8,
-		.max_register =3D 0x13,
+		.max_register =3D DS3232_REG_SRAM_END,
 		.write_flag_mask =3D 0x80,
 	};
 	struct regmap *regmap;
--=20
2.17.2

