Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A38C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E562067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Dp2VUwas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfGaJUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:20:42 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:9358 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfGaJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:20:42 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: qQ5cWc+eRKzGyOF/pF6m+IUy/qq+PNF/cp6lgRid/BtBQoB+SjkN4zQMhO1eq7QIsyBZtq7Eaj
 8Y0kqOYUFvl6YYCw0058vIfC5y/xXhZQdONZGE71focu6FCD/waQo6LqwnPrw44IrNXP3U3+gA
 Jzvupv3WxS5bq28THuPZf2o0lW2wLY7Obkp2d2eGxNnbBmMlDkrWO5D9ufiF+vm3dNifgY1Jfr
 r8RZRl6jy7qp1SxFCgzfVGJPfC5znFO09obNInHd/0TvTVhLuMVYyKKjYSp05XnoinCuBExq0V
 eH0=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="44787492"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:20:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:18:50 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 31 Jul 2019 02:18:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erl2mwbusor0UuNaGEwE23hseHSb0xJn4bEPrPukeFVohxtr63ULD6BT0XcvqoMIiDaNHO6Ic8u+GBFCDaxn6qGtLk1ctrCFlEYw0SxMNmIz7d7AlpQHOwBRmQHvqkfZJsJmfEuDhOGNF9yhXxCRHX8i1awu/BM9pQIidcUqXfyTL9FpGHgdQ34e730HQmlGcXST9c25M4KVxEYaAzBo2CFi53xFQpeY9fXSFpSfAaH50xRfjWBwuI5ECWh7kocfBaZzNKinnIN1LOX4Mdd9XKivJE4JddKjrdx01Sk39QsHxW1cv0pzK0Jj6AkQ2DfQ/7KMQcAHLMm7glmH1gIagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUhc6o3/+XXP4yqYCU1hIe/HWiQytN7nIY9T4Ht6zIU=;
 b=McuQmiuopnf43uNfUNdI883Mmdajh2M8h/ALgOZ20RuFysyqh7nc4vQHOagrBNhZB06XMixr6GRflFksAOrWP/1d2SumEEDYtRu4dMgDq8LCe1S6RbV70DQp1ZOk9xXtnKXGisCsKEdj2cOkQPz6e2Z7kHXAYRud/KrbcP8DwTR6/rIUxQQ+WLS6YZwQQVww7Qsof3MerIpEgy9fOuJ3KENR92BBC0gY/cNIk3zv6pzB9/d6WJPzhUq1nKgzR701pWTF8Owiyl5IZu9SrBo1+bwlVp/IibgGsUlAHcufP8JDH6og9vZC7qtVsCZdSF1YcKhIDRIR/e+ga/X8V2SN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUhc6o3/+XXP4yqYCU1hIe/HWiQytN7nIY9T4Ht6zIU=;
 b=Dp2VUwas84B/eAo77qdMV2foCXL/iKEMBkjg0L9e7Cd4gQet+UoqlBWFlpedPzc+XAAgYI1rzNnBNqxEVXyKkVp28gFNrnFIBE+Lh0IepaMidFushifG2DfUvmKT/31XD/it1NSXVMXmE4Rw5T/Tz9m6Wlo48w2O6vB7W1KZMLs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3680.namprd11.prod.outlook.com (20.178.252.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Wed, 31 Jul 2019 09:18:49 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:18:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 3/3] mtd: spi-nor: Introduce spi_nor_get_flash_info()
Thread-Topic: [PATCH 3/3] mtd: spi-nor: Introduce spi_nor_get_flash_info()
Thread-Index: AQHVR4D2dVyQUM7xR0KDZRbhf1XpYg==
Date:   Wed, 31 Jul 2019 09:18:49 +0000
Message-ID: <20190731091835.27766-4-tudor.ambarus@microchip.com>
References: <20190731091835.27766-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190731091835.27766-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:803:64::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b743723-9d7f-4713-43c4-08d7159818e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3680;
x-ms-traffictypediagnostic: MN2PR11MB3680:
x-microsoft-antispam-prvs: <MN2PR11MB3680C945F88859442FAB5008F0DF0@MN2PR11MB3680.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:517;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(8676002)(81166006)(4326008)(81156014)(53936002)(7736002)(256004)(25786009)(68736007)(8936002)(50226002)(14444005)(478600001)(6486002)(11346002)(2906002)(107886003)(14454004)(2501003)(102836004)(86362001)(6436002)(71190400001)(71200400001)(476003)(1076003)(305945005)(5660300002)(66556008)(66476007)(64756008)(66946007)(2201001)(66446008)(36756003)(486006)(3846002)(99286004)(76176011)(6512007)(6506007)(66066001)(386003)(446003)(316002)(6116002)(26005)(54906003)(186003)(110136005)(52116002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3680;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 66WROcukXeSIqSC55CS/6ch9eNkJlDHKIowqmUEJ2nEL/oJ9I0XlzWDZUQDT9GHUyE4LqkAZ9eYA7oIqN7ZzyKWOr4jJo1HRsGb1RfBSgrwG5Jtg7BAzPNpZ6grTipO92r4l3ZTH2VBx53pIXgQsrpqNFKuPS4R264QO4ekjkU95JUVhKFxEAnb70o+kSxt/LNTqk1ybG+8Ury1DivcSI60mqjOM1/xlm37ZGdU6NZU67mlT1vJlO7R/VZgtj9vapM/3uCR9CzZyoN8lNtrWZoGxfFOwljA6LG6S3hAvEkg621XuEyA6Aneaw3ef2m6ppFf+7y5TQD4NhBCfbdtPyzgBEBTxylKF43x3ktwcwZKey0ky8alGpql/0Eo2Pls5IChEoLtELIVyJkLo6jNO6FmWTWxtujmOAMED0oPu6Lw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b743723-9d7f-4713-43c4-08d7159818e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:18:49.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Dedicate a function for getting the pointer to the flash_info
const struct. Trim a bit the spi_nor_scan() huge function.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 52 ++++++++++++++++++++++++++-------------=
----
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c322d7cd8216..636f065cc869 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4800,25 +4800,10 @@ static int spi_nor_set_addr_width(struct spi_nor *n=
or)
 	return 0;
 }
=20
-int spi_nor_scan(struct spi_nor *nor, const char *name,
-		 const struct spi_nor_hwcaps *hwcaps)
+static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor=
,
+						       const char *name)
 {
-	struct spi_nor_flash_parameter params;
 	const struct flash_info *info =3D NULL;
-	struct device *dev =3D nor->dev;
-	struct mtd_info *mtd =3D &nor->mtd;
-	struct device_node *np =3D spi_nor_get_flash_node(nor);
-	int ret;
-	int i;
-
-	ret =3D spi_nor_check(nor);
-	if (ret)
-		return ret;
-
-	/* Reset SPI protocol for all commands. */
-	nor->reg_proto =3D SNOR_PROTO_1_1_1;
-	nor->read_proto =3D SNOR_PROTO_1_1_1;
-	nor->write_proto =3D SNOR_PROTO_1_1_1;
=20
 	if (name)
 		info =3D spi_nor_match_id(name);
@@ -4826,7 +4811,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	if (!info)
 		info =3D spi_nor_read_id(nor);
 	if (IS_ERR_OR_NULL(info))
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
=20
 	/*
 	 * If caller has specified name of flash model that can normally be
@@ -4837,7 +4822,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
=20
 		jinfo =3D spi_nor_read_id(nor);
 		if (IS_ERR(jinfo)) {
-			return PTR_ERR(jinfo);
+			return jinfo;
 		} else if (jinfo !=3D info) {
 			/*
 			 * JEDEC knows better, so overwrite platform ID. We
@@ -4846,12 +4831,39 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame,
 			 * marked read-only, and we don't want to lose that
 			 * information, even if it's not 100% accurate.
 			 */
-			dev_warn(dev, "found %s, expected %s\n",
+			dev_warn(nor->dev, "found %s, expected %s\n",
 				 jinfo->name, info->name);
 			info =3D jinfo;
 		}
 	}
=20
+	return info;
+}
+
+int spi_nor_scan(struct spi_nor *nor, const char *name,
+		 const struct spi_nor_hwcaps *hwcaps)
+{
+	struct spi_nor_flash_parameter params;
+	const struct flash_info *info;
+	struct device *dev =3D nor->dev;
+	struct mtd_info *mtd =3D &nor->mtd;
+	struct device_node *np =3D spi_nor_get_flash_node(nor);
+	int ret;
+	int i;
+
+	ret =3D spi_nor_check(nor);
+	if (ret)
+		return ret;
+
+	/* Reset SPI protocol for all commands. */
+	nor->reg_proto =3D SNOR_PROTO_1_1_1;
+	nor->read_proto =3D SNOR_PROTO_1_1_1;
+	nor->write_proto =3D SNOR_PROTO_1_1_1;
+
+	info =3D spi_nor_get_flash_info(nor, name);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
 	nor->info =3D info;
=20
 	mutex_init(&nor->lock);
--=20
2.9.5

