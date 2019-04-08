Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9163C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB8620883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="EzSOjBqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDHIwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:52:43 -0400
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:60910
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfDHIwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrFOUv8gIxNZogmXnnSBAib6ng5Zf8yfqkRqI1wMsLg=;
 b=EzSOjBqPx1ZEvZhvjja8QUh1sZdUYgTUCBI+0mN03QrPKk8NW9B+boh7RIf1JX2LrV/EyOosDnsgVNJjpdebObS6EjNyP84QZtG1FkOzoZVMbLESKJxCwrony5H0J+Gq1DabqnU7RvE8bIuatmR8qYwRwO5yLzhDhfcuSxUQdb8=
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com (20.178.104.212) by
 DB7PR06MB5765.eurprd06.prod.outlook.com (20.177.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 08:52:39 +0000
Received: from DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478]) by DB7PR06MB5563.eurprd06.prod.outlook.com
 ([fe80::edef:902c:11a7:478%6]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 08:52:39 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v2 1/1] rtc: ds3232: get SRAM access using NVMEM Framework
Thread-Topic: [PATCH v2 1/1] rtc: ds3232: get SRAM access using NVMEM
 Framework
Thread-Index: AQHU7ehrOoyWKU0ZoEy/KheJ21Jy6w==
Date:   Mon, 8 Apr 2019 08:52:39 +0000
Message-ID: <20190408085141.21284-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:7:67::18) To DB7PR06MB5563.eurprd06.prod.outlook.com
 (2603:10a6:10:83::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95fc2d0e-ed9f-44a5-e2f9-08d6bbff8ded
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DB7PR06MB5765;
x-ms-traffictypediagnostic: DB7PR06MB5765:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <DB7PR06MB57652285181AA3FE44CDAD33852C0@DB7PR06MB5765.eurprd06.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39850400004)(376002)(396003)(136003)(189003)(199004)(81166006)(99286004)(14444005)(256004)(7736002)(53936002)(5660300002)(2616005)(316002)(186003)(105586002)(4326008)(102836004)(50226002)(97736004)(68736007)(81156014)(26005)(486006)(305945005)(107886003)(6506007)(386003)(106356001)(476003)(8936002)(8676002)(2501003)(1076003)(6512007)(6436002)(36756003)(2201001)(6116002)(86362001)(2906002)(66066001)(25786009)(3846002)(478600001)(6486002)(71200400001)(71190400001)(14454004)(110136005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR06MB5765;H:DB7PR06MB5563.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PUUgDQCu+T540wEawOwRaalMv9owhjGf0w0nCIsSgrLY/aGKgIvOL+IW1FpJR90ES8nCIW08iUijRXbeN3E95yS6atMQTFodLzCqh/CY19jPCkPlw0Bmlm0bWV2BKlFBsGDblgyFDUpaFRy2NjSKvCPc68R6DcauFJc3JXGHssYU+1JCFOO4YH3XV2pdbYloTuW2WB3HNDnxXZ7TnEoXB7RGP9IAiwCMHhHGImvEdqA9LrB6ofTsDIq8cxVEh8tzhzcHmI2+wKY5UiuuHY1SF9W8gawJGwNDlo4EFQiN6m47/dDnSJ6ZYNkAFMZkhyoRdyAGUdUmTDQo1CW7qCYyyo5QT04yAGCIfHkDUBERN83Ycr+ky/i2nthKgsIzsUsChGR4X11jWNZYWc+1ggqhBjWTyDLq2JFDoc99J9Be7eo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fc2d0e-ed9f-44a5-e2f9-08d6bbff8ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 08:52:39.5708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB5765
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

Testing on Kernel v5.1.0-rc3

1. Update `arch/arm/configs/imx_v6_v7_defconfig` to contain
`CONFIG_RTC_DRV_DS3232=3Dy`
2. Verify that building the kernel is successful: PASS
`
make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnu- imx_v6_v7_defconfig zImage
...
CC      drivers/rtc/rtc-ds3232.o
...
Kernel: arch/arm/boot/zImage is ready
`

Changes since v1
----------------
 - remove the unnecessary header "rtc-core.h"
 - use nvmem_config from the stack
 - configure the nvmem type
 - remove the `of_node` configuration


 drivers/rtc/rtc-ds3232.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 7184e5145f12..77908c9e5e09 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -48,6 +48,10 @@
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
@@ -461,11 +465,30 @@ static const struct rtc_class_ops ds3232_rtc_ops =3D =
{
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
 	struct ds3232 *ds3232;
 	int ret;
+	struct nvmem_config nvmem_cfg;
=20
 	ds3232 =3D devm_kzalloc(dev, sizeof(*ds3232), GFP_KERNEL);
 	if (!ds3232)
@@ -476,6 +499,15 @@ static int ds3232_probe(struct device *dev, struct reg=
map *regmap, int irq,
 	ds3232->dev =3D dev;
 	dev_set_drvdata(dev, ds3232);
=20
+	nvmem_cfg.name =3D "ds3232_sram";
+	nvmem_cfg.stride =3D 1;
+	nvmem_cfg.size =3D DS3232_REG_SRAM_SIZE;
+	nvmem_cfg.word_size =3D 1;
+	nvmem_cfg.reg_read =3D ds3232_nvmem_read;
+	nvmem_cfg.reg_write =3D ds3232_nvmem_write;
+	nvmem_cfg.priv =3D ds3232;
+	nvmem_cfg.type =3D NVMEM_TYPE_BATTERY_BACKED;
+
 	ret =3D ds3232_check_rtc_status(dev);
 	if (ret)
 		return ret;
@@ -490,6 +522,10 @@ static int ds3232_probe(struct device *dev, struct reg=
map *regmap, int irq,
 	if (IS_ERR(ds3232->rtc))
 		return PTR_ERR(ds3232->rtc);
=20
+	ret =3D rtc_nvmem_register(ds3232->rtc, &nvmem_cfg);
+	if(ret)
+		return ret;
+
 	if (ds3232->irq > 0) {
 		ret =3D devm_request_threaded_irq(dev, ds3232->irq, NULL,
 						ds3232_irq,
@@ -542,7 +578,7 @@ static int ds3232_i2c_probe(struct i2c_client *client,
 	static const struct regmap_config config =3D {
 		.reg_bits =3D 8,
 		.val_bits =3D 8,
-		.max_register =3D 0x13,
+		.max_register =3D DS3232_REG_SRAM_END,
 	};
=20
 	regmap =3D devm_regmap_init_i2c(client, &config);
@@ -609,7 +645,7 @@ static int ds3234_probe(struct spi_device *spi)
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

