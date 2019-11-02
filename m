Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7869CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B364221897
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KSNf8RYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKBLYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:24:03 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39961 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfKBLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:53 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: bNlqeY8+svd624CMZb2FNCmIfGPnlh2HcxSjcgsocTUL+B75wQOhzkVMtenvIBno8lFEGwUcSO
 5brPwMauor8YwcJOUYvuUjqlFlBD+pQiPZx7kjjaJ87JZ0WffvPOCIqH7FhtLS6zhww6Qe1c0c
 xv9GUyrZTYQ6aKsZ3Vir8dvc3w6P6bQtTGQasduPurTgnVlpsiFf+Us3nHxoUwP/FaeiNNeujh
 CILg7GEa0tzGY2JyQjUagwxLeKRXtkbzmZ6VdyWAdyx4QM45lwVyCIxEw4XHWaW8MWtKwSFa8J
 t8o=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53900887"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:52 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 04:23:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPD0nG60Z1Os5nzIlge5WpgdFU7Qjw2DHpteJ+a82i2TRZRz3zdVmLQtP4kKw2Zal4c/YwU9g/s9nxt2Ta5afGXayK0Ku+Bh2L5es6WXMRzoVhC7awhk7dOFK+7uDZNASjq26e6gXVpN8WP3To1TqjG/N/nhphc94aVhEr26gCxVqdkeQXKhyue9TJLEwc1rhe1aJUEoNOEizeer7BMu9DuHJjHJ+fiGmA3nlmReAIlXbW9aC+U1lDS5WMaPi+ttbWz+itFNZN1A9uwf7WgjYSFwp9yXXlemHIRe+eL6D00YfEkldNGx9RRR/k9U27T9jgDjcvIg7M33xmR4xHjzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voAuWLve2k5+v7MEc1jGJBgrKtUSFIXYy3UcsYC9Aak=;
 b=FH4yE1QmxqaYKs2Fw8xSrrf+OR3EvOfT+qvh4rFF5pAPevUVAh5PNbx/mCP7Flytoa/meJ0bBsZN83H+x/zprshFbn0kDQUMf0IrEmxlL0VvTYqmnInsLGLzVzMwVCweozeJUH556pLR+dkexkTWmOM/xF6yxeKWlQMmp6LRnIriM2fHmNOJd36E95A7ocAOBded+Jjp2f3h+OUtqnPSTyc0oBSRjuFx07/gXRLfd0anyrc2uCPM4nX/eWykX9GsYQlEwQnmraErPJ4UmZxHlHtwQLfMXQ0mdVCR1g/Nl1yud4H6XUOlSq75bd/PVXQt5aWKcbfPYo6lA9nQILw/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voAuWLve2k5+v7MEc1jGJBgrKtUSFIXYy3UcsYC9Aak=;
 b=KSNf8RYEqhPKa65LoYQ8XERPEoKzmy0PijWetI1rDtefmwRHoqbQW/ICu7Y1xUFCjORDUoaUhASfnIVCQM/f+b/TngK1OPxmz58zgmxfequFZSxZi7RZuOi7aEGYeLdD6P0isit32FIxzZAWYHEACmIjmCcc7jPb7eSFUaNzxzE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:51 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 15/20] mtd: spi-nor: Extend the QE Read Back test to both
 SR1 and SR2
Thread-Topic: [PATCH v4 15/20] mtd: spi-nor: Extend the QE Read Back test to
 both SR1 and SR2
Thread-Index: AQHVkXAAobnx9/kxgESK6sIIzhHB/g==
Date:   Sat, 2 Nov 2019 11:23:50 +0000
Message-ID: <20191102112316.20715-16-tudor.ambarus@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191102112316.20715-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0143.eurprd07.prod.outlook.com
 (2603:10a6:802:16::30) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e88365af-509a-4ba6-6082-08d75f8722f3
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3711723279F3EF207A5E0B8DF07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(14444005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zIvi//GQK9ncSuczn2DCSdoeulw+397YglmpUG7eq6fF52K0oShCWUvqoCQRNCGQ240+XzLQ5POyeJhwXS/iXnySS9eKNNGAeYN9CuIMEcIsQWlfIiniarZ0ERWbGZIW8Z+hLOSxutOiqDgNGYgb2N7c56lIepmYqTPd8GO0ovRNRgvwEn7d1twE541/veVLjJpo3xmxr2h9n993YJgY0NvHeA6I9yxGTNScBSkA1PeS2cstqiApGfn9LDInrpEKSaUnlCpccggfIVb+72kkkPuj1dkaR3J+r27cNe+xw5XQshCQdkiMxj4WWyNhIMtmmAiXvQKqQ5pJzP54ZafN2ftkScUfQ7BSrwBK//rHYnhhb6oF16SBdcNILeEmo3iwjfWaqxKDr/L/5XXqyWa4gwNnqXkMramZcUP0uZdGpBHPOF4sgU3XKgVo4hSjkcbE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e88365af-509a-4ba6-6082-08d75f8722f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:51.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72N3gKvGKGQjAw+oR9x9Ir7KE5ZSBV5T3LQ/swzxJrxVN+3CO6/1sBZmLV4IwNCnh+53ZJSbCmzqhodU9Ku0MjrcVPdKMNcahxTgx6tSv44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

In case of 16-bit Write Status Register, check that both SR1 and
SR2 were written correctly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 08fd2c97897d..8f11c00e8ae5 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2067,6 +2067,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
 {
 	u8 *sr_cr =3D nor->bouncebuf;
 	int ret;
+	u8 sr_written;
=20
 	/* Keep the current value of the Status Register. */
 	ret =3D spi_nor_read_sr(nor, sr_cr);
@@ -2075,7 +2076,22 @@ static int spansion_no_read_cr_quad_enable(struct sp=
i_nor *nor)
=20
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
=20
-	return spi_nor_write_sr(nor, sr_cr, 2);
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
+	if (ret)
+		return ret;
+
+	sr_written =3D sr_cr[0];
+
+	ret =3D spi_nor_read_sr(nor, sr_cr);
+	if (ret)
+		return ret;
+
+	if (sr_cr[0] !=3D sr_written) {
+		dev_err(nor->dev, "SR: Read back test failed\n");
+		return -EIO;
+	}
+
+	return 0;
 }
=20
 /**
@@ -2116,6 +2132,17 @@ static int spansion_read_cr_quad_enable(struct spi_n=
or *nor)
 	if (ret)
 		return ret;
=20
+	sr_written =3D sr_cr[0];
+
+	ret =3D spi_nor_read_sr(nor, sr_cr);
+	if (ret)
+		return ret;
+
+	if (sr_written !=3D sr_cr[0]) {
+		dev_err(nor->dev, "SR: Read back test failed\n");
+		return -EIO;
+	}
+
 	sr_written =3D sr_cr[1];
=20
 	/* Read back and check it. */
--=20
2.9.5

