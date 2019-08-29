Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82576C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B23F233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KLNvENOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfH2HKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:10:40 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:29778 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfH2HKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:10:39 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: LOPxGC8V+2B+t7nkIhP6WZgt8hJZKCNHebQsjnwiAni12IVQvuNZTqqwvXMq97jWkiMRZn5rGp
 lb1zHTK3FfH/DiKD5bsy/7lENdt8Zj9+eFEniyw2+Pn4xEUZoRVObTTnt1co4glDbQt9Vz1F/Q
 rwkF1t75UBJhzdkBULKia3lcPFtk62NkYwb36jCze5njJKNHqeViPypL9oMbqGW8UgIr4WvKXK
 fCKsc6dn7qFNfvBj7BLzmi7kODMfvMRq5VIlEIW1t2mNfNGebsdt12iBJlow1kovbnCQZsZPsW
 dL8=
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="44117227"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2019 00:10:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Aug 2019 00:10:32 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 29 Aug 2019 00:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoN8NRc5pqSiTm0w7CoY/YqyJHgls12NhIveUGlIoDDu+BoQkzKhL/c/dBx+oNSp/2+6FAKF+9sr74M0ypt5MRjJxcEgnVTyk/c8Hh1gVqpaKcuVgzx9hT7phTStVlGeVzzgZA90osSsoZk1yQ8cNxvfUGpF/Pvk4NCgHON5HyQSZ/AQl3L2aw7Xj6v8WjMauHIgzr8G/kWcskgeMaehKjFoh2EgAD64I5TtqqwPQsedtFMAsQkQX1o1E89ypKwRmxULVTiqom6JBw7j9QLBRJVA+luOiMh9nsHCPHAlx9gQAEhcwFy4zqIi73AsCIOUuXrx4cMlmj6TeV57XhtoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18JlN5qOLP7rxtqVUq7DV9SzLeMXkK6J1oCNXJ3WDMc=;
 b=dZtuNa8rx2Pl5PxCMFtzs7FoO+8CLyLizVHcyHpELIfYYV48+kFIP+jYVlyHlKrydTJJltLBurC3Z02Mjv9yif9J2ZBrzWpRSX2IP7+8G0VNQPnrlEIHVc8+TXIEB9tDTIX0HWKU6xV+D4EnVckSINGcb4MS8Jljp4Z0P6/M3oT64A6U9qUAd+t3uo7+EJcf8fszqNTBcqsZl/KTUAQvMhUPUPDl+V6OrJDdjo7t3Wep4Bux5UgO9+dyVC9Os3QBs23Iuvcsd7cTIvqebjJJWVmXO8ETulbDzIF05nECVqAzd8pMOrSa3OObBVZGpB1vN3JuL5rXknEPlW7YcYRToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18JlN5qOLP7rxtqVUq7DV9SzLeMXkK6J1oCNXJ3WDMc=;
 b=KLNvENOJyBMuz0R+QTTS+EXAQfHUM8F0Fhi097TRFTb0+g8roanswe091jVHpg8i+a3mhwpC/nTS6f+/JYJW9FEf/T0Xh8uQmy41CpBe8pYPF/3V1OWsT7FXT1dPd3aP5YKecrT0CYWeaApTVRp1FJDsd39xBX78LOjByZ2bORk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3726.namprd11.prod.outlook.com (20.178.251.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 07:10:33 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 07:10:33 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhuohao@chromium.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/2] mtd: spi-nor: enable the debugfs for the partname and
 partid
Thread-Topic: [PATCH 2/2] mtd: spi-nor: enable the debugfs for the partname
 and partid
Thread-Index: AQHVXjjZ1JUC2tOYnkmU6+Gr1cjiGQ==
Date:   Thu, 29 Aug 2019 07:10:33 +0000
Message-ID: <20190829071019.2495-3-tudor.ambarus@microchip.com>
References: <20190829071019.2495-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190829071019.2495-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0165.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::22) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3300f88-e05e-42c8-6450-08d72c4ffb6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3726;
x-ms-traffictypediagnostic: MN2PR11MB3726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3726A50BE50BDC66B43136C6F0A20@MN2PR11MB3726.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(71190400001)(50226002)(66446008)(66556008)(64756008)(66946007)(81156014)(71200400001)(1076003)(3846002)(66476007)(2906002)(14444005)(256004)(305945005)(36756003)(66066001)(5660300002)(7736002)(478600001)(26005)(6512007)(6436002)(81166006)(11346002)(2616005)(2201001)(486006)(6486002)(4326008)(86362001)(476003)(52116002)(25786009)(99286004)(8936002)(102836004)(6506007)(386003)(6116002)(76176011)(110136005)(53936002)(186003)(8676002)(316002)(2501003)(446003)(14454004)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3726;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LQD0HvR42eBsuRIDRcpeJmxa3n9jmRxUOeFOafkbywPZq84U5XcTnx88Z10tUqJ1TG1eeuRbHIx5bPHJZxgWTtvQq7N6U6cYsiHUpzbIE1oHKZFAY0BJBs4XK5OgdX1PpamTLfJpo0ioiOWRUbcDfYPuwH883D5TCRgYFu+aAtfRj74UpvrKaQsPDpmQ4DRlSXMbKrDZJHNBXXYAY8UPUd+uXFCd/aq2hxLPv6+g5kQddmyFHkzypIySimJTEj+mO5DsGJwRNFmlQlMLh8MnwEs77vFT4sakZZn+o74cN8/Ehhn6Dv/4SNKTMeG1QJoa25An80KE7EH8ygfK5B5eROd66XWykEaaCXWgTI970TUpuHminwlMJJeP/sUnMlqgnY59ljsG7R12cqgUxg0evdBS4fDTn/aqpZG3IP98o/c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c3300f88-e05e-42c8-6450-08d72c4ffb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 07:10:33.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrxfK7ndSmuhw+osgqKICjiutx6yT/KcXlUcomWvxPgYVLYCypBEikgW51KopiV7JaHeoapEwSLQa3o25AnG7L8NOXNIb3tBsM233u3Br1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhuohao Lee <zhuohao@chromium.org>

This patch adds spi_nor_debugfs_init() for the debugfs initialization.
With this patch, we can read the partname and partid through the
debugfs.

The output of new debugfs nodes on my device are:
cat /sys/kernel/debug/mtd/mtd0/partid
spi-nor:ef6017
cat /sys/kernel/debug/mtd/mtd0/partname
w25q64dw

Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 79c8f1dd8c6b..6a2fff0598af 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4767,6 +4767,16 @@ static int spi_nor_set_addr_width(struct spi_nor *no=
r)
 	return 0;
 }
=20
+static void spi_nor_debugfs_init(struct spi_nor *nor,
+				 const struct flash_info *info)
+{
+	struct mtd_info *mtd =3D &nor->mtd;
+
+	mtd->dbg.partname =3D info->name;
+	mtd->dbg.partid =3D devm_kasprintf(nor->dev, GFP_KERNEL, "spi-nor:%*phN",
+					 info->id_len, info->id);
+}
+
 static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor=
,
 						       const char *name)
 {
@@ -4847,6 +4857,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
=20
 	nor->info =3D info;
=20
+	spi_nor_debugfs_init(nor, info);
+
 	mutex_init(&nor->lock);
=20
 	/*
--=20
2.9.5

