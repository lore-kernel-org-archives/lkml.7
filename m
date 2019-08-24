Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5927AC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B6C233FD
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Uu1K54uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHXMTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:19:33 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56602 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfHXMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:19:26 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: VnfZNauAfnpmPsuQScodRlSRfP2CxNY7YwpayywfomKyp0OGV1GQRAVB+k3P2B1xV8Ss6E9E56
 RRoRLMjUFg7b97UsngNLC2hPRGp6M9Q3qQvUEfhdKwa30eIkAHAv+p/7h9jksgw7iEMSnCjdxR
 PLV+khLHeGn1kPuPXTo2cgFwwgVyadllL8OyQWIQvKKxjfgffx+LNdGJDk3tRMCWnrcP69mmnK
 MwXv4krZOh07aXjW3zdXNkR4N3IVojBVmv22PeE+4Z+xoHX35/KazjM5CGReBP3/fA69g+IV1u
 kxY=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="46393054"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:19:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:19:24 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 24 Aug 2019 05:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Rjhv1FeT7CCCAUZKfQUlMrV/6eljJnM+QcF8pZoCMqFHzzwf1459TcXqK+yUtWG1ReDA51HJxgbPc0APv9wKaOOemKhscz6Jrm/BHb+4Obfs5yLRxfSm7zS7wREx6WbQtGzu3LNEBWEYlKjo6S3LpHTlObEwoHbLMLDXS/st3ekQ4x+Q72yo8LhstLcJyvQuuYC4yuofvWC3VIbVTzECmLZbJ5aOLAtpV5vOId8NhgQqVulwwzUCtnJ0cxz2QaTILVhbMUiAOs9CyzVxfsNPsC5QAYAPprpoaJzjREhO7myN78CBuxJD665mXalcd+5D+/ReuPk16StEybGDHCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvtBFNFgEONvIlG7ZSlpX92LWyJivrHulz+wbaLFvTk=;
 b=XzIwRU+tL02jsmPtk2biETam23tv5V8/gikv94DwkdcacU9Ic1ysSwW8xbDzdQ05Q5jLmxuaMYSMCX7Pu7kKMbpSy2ifQGlfqLZZnDD5qUzj4gbQfW8ZJsQfv+u46xxiSrMgVi5PcOOMH2ET2AoBRhNL46LekMgIvrJgkpxnuTVNmULJlbuhtQoRtDrN9lwyGjcNpkfBC6kHUYNX9Z0sij5mKJXevgY2ZeH/Y2f9/AqR8zcP5Vu0huFTUeNp19xscH6FWS87hSrr77kkK9GGbVdUbNL74wCKWJN3ZZDtjd1wIyD52lyj3JDqSZVcJXGBJc4l2LmY+8hQSEw5y+Hr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvtBFNFgEONvIlG7ZSlpX92LWyJivrHulz+wbaLFvTk=;
 b=Uu1K54uvwXbj+I0nUDXLGjB9H6n/J0w0g2OkzWvd7R41gVMR4ZYkcHM0teGH5rH7N5/iZsgA9kzyRLXRxjVEevNuuzIqyVgJCsax46qnHh5D3AwvJcnbhjd3gCBcw4eKCAwOZ0PpR3Wb0JVBzhcoSU+Pu5naeVB1mo+abYIDdX0=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4317.namprd11.prod.outlook.com (52.135.36.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 24 Aug 2019 12:19:24 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:19:24 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 3/3] mtd: spi-nor: Introduce spi_nor_get_flash_info()
Thread-Topic: [PATCH v2 3/3] mtd: spi-nor: Introduce spi_nor_get_flash_info()
Thread-Index: AQHVWnYqsaBgY0z+y0ChKE2/G9euMQ==
Date:   Sat, 24 Aug 2019 12:19:24 +0000
Message-ID: <20190824121910.15267-4-tudor.ambarus@microchip.com>
References: <20190824121910.15267-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190824121910.15267-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0602CA0013.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::23) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c4fb2cd-cf72-411c-90ef-08d7288d4cc9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4317;
x-ms-traffictypediagnostic: MN2PR11MB4317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4317A4DBC8EEC29A3C523CD2F0A70@MN2PR11MB4317.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(39860400002)(376002)(189003)(199004)(52314003)(81156014)(110136005)(6436002)(3846002)(8936002)(8676002)(6512007)(50226002)(305945005)(25786009)(7736002)(478600001)(53936002)(2906002)(316002)(66066001)(81166006)(99286004)(36756003)(6486002)(107886003)(386003)(6506007)(102836004)(476003)(2616005)(52116002)(76176011)(446003)(486006)(26005)(186003)(6116002)(2501003)(4326008)(11346002)(71190400001)(71200400001)(2201001)(66946007)(66476007)(66556008)(64756008)(14454004)(1076003)(256004)(14444005)(66446008)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4317;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /z8rJ+xBPNrhZqoqVzjBw0WfJSNwBPv5k6N6BBe3GuH8YPnvgplSNiQG4lngedt4oNDep6nWNgQBaGLw3SoUgPmtONe6a/sF1cCakGT18xuuV4nJJDcdzmyfRerL+ntn5UrCrlmwq9Cpkm9fs+LEWrw518uhi1A1/xnSO0DCQBRoQAkbO5SPnvAfp7Ta1BkCmk2JNSbIjVprSTjiFcHm1KfOi4bY6MyEk4d7yiRWMIRhEnzghncn7hLTeii9ubUpoLvqAlxcD8vpXQ9tXD8mzlaI+9f/yoZ91X41lrdFcaWIxF9LMIqwZjX6lxGnpJ0Hk9oR82SSsmCNkY3ZQ8GHmFSKgTTxeD08+V8DN3gfDha9dn3lAf9MlaojAFSVUbyuUTgbW5+FyT4RbOVJxUD4ITfzsOUCWMn5v9avdFQ8WPU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4fb2cd-cf72-411c-90ef-08d7288d4cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:19:24.1941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CT9YxynvAx6q48LHPgPw5EJiv5j52Kzd07iLefjO51DM+PjSeu+V9g2FSTuZTcJ0Nz2Fd+BaP5ymflq6nCnmywdrYGxEMIh/zG93J4x3PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Dedicate a function for getting the pointer to the flash_info
const struct. Trim a bit the spi_nor_scan() huge function.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 76 +++++++++++++++++++++++++--------------=
----
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 449d2c4918ca..1896d36a7d11 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4807,10 +4807,50 @@ static int spi_nor_set_addr_width(struct spi_nor *n=
or)
 	return 0;
 }
=20
+static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor=
,
+						       const char *name)
+{
+	const struct flash_info *info =3D NULL;
+
+	if (name)
+		info =3D spi_nor_match_id(name);
+	/* Try to auto-detect if chip name wasn't specified or not found */
+	if (!info)
+		info =3D spi_nor_read_id(nor);
+	if (IS_ERR_OR_NULL(info))
+		return ERR_PTR(-ENOENT);
+
+	/*
+	 * If caller has specified name of flash model that can normally be
+	 * detected using JEDEC, let's verify it.
+	 */
+	if (name && info->id_len) {
+		const struct flash_info *jinfo;
+
+		jinfo =3D spi_nor_read_id(nor);
+		if (IS_ERR(jinfo)) {
+			return jinfo;
+		} else if (jinfo !=3D info) {
+			/*
+			 * JEDEC knows better, so overwrite platform ID. We
+			 * can't trust partitions any longer, but we'll let
+			 * mtd apply them anyway, since some partitions may be
+			 * marked read-only, and we don't want to lose that
+			 * information, even if it's not 100% accurate.
+			 */
+			dev_warn(nor->dev, "found %s, expected %s\n",
+				 jinfo->name, info->name);
+			info =3D jinfo;
+		}
+	}
+
+	return info;
+}
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
-	const struct flash_info *info =3D NULL;
+	const struct flash_info *info;
 	struct device *dev =3D nor->dev;
 	struct mtd_info *mtd =3D &nor->mtd;
 	struct device_node *np =3D spi_nor_get_flash_node(nor);
@@ -4841,37 +4881,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 	if (!nor->bouncebuf)
 		return -ENOMEM;
=20
-	if (name)
-		info =3D spi_nor_match_id(name);
-	/* Try to auto-detect if chip name wasn't specified or not found */
-	if (!info)
-		info =3D spi_nor_read_id(nor);
-	if (IS_ERR_OR_NULL(info))
-		return -ENOENT;
-
-	/*
-	 * If caller has specified name of flash model that can normally be
-	 * detected using JEDEC, let's verify it.
-	 */
-	if (name && info->id_len) {
-		const struct flash_info *jinfo;
-
-		jinfo =3D spi_nor_read_id(nor);
-		if (IS_ERR(jinfo)) {
-			return PTR_ERR(jinfo);
-		} else if (jinfo !=3D info) {
-			/*
-			 * JEDEC knows better, so overwrite platform ID. We
-			 * can't trust partitions any longer, but we'll let
-			 * mtd apply them anyway, since some partitions may be
-			 * marked read-only, and we don't want to lose that
-			 * information, even if it's not 100% accurate.
-			 */
-			dev_warn(dev, "found %s, expected %s\n",
-				 jinfo->name, info->name);
-			info =3D jinfo;
-		}
-	}
+	info =3D spi_nor_get_flash_info(nor, name);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
=20
 	nor->info =3D info;
=20
--=20
2.9.5

