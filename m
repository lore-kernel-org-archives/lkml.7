Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E145C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838A21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pLQ5W14O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfKGImD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:42:03 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9821 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfKGImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:42:02 -0500
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
IronPort-SDR: 4R0Fiy2pfkdMpBpFS0/oqZ1pA8xGnOH+9C+ryToxMCoIklAMvBI26p+QG4ihtfDnzwXzwdxClS
 JrbMVjjc41fEpuiXG/ApxuYAGYRz17hHXI09JkdM2rthgt5QTVkHyC8ueenUVQoaVtWEcdXNQT
 Sam6w9hN6rSRO0IDGsl2wuhJZdQSIbCa3yAR33mMq88G/KAjydqedSspohlFnOXrOJCRD7jPTT
 viVhKNe2THkA5PfR1TCBXBFH6gMvBKyY/KwbqZYW5xq06j/7cOZV80vZAh5A8rpXsW07kzCkVJ
 hx4=
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="54459154"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2019 01:42:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 01:41:58 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 01:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO1F1zMt8fOwf2cckOTQdjNs6ftC5JgnjxybUX00m8t1jKm9Zl111xMfeqSYikAV5Rz+eXuXRXJWYBLpz6yCK0vuyz4V9VZhLMV6cH8oxIxMsx6o7C/BQo6ifyuNobKteOCMidP8P9Ka1ERVIpbgfmt3QcxTaWYPAsWn9R6lCeBbreZmOt0NI250ZUlANjOmto82Qucy31W0y6jahY+hPpe4Rr10EPQv49cE0wn+oS5L242bbqGGxYVj0vpV4P0lOA/4FNe04jEiRy94pJXFve5n29NqcWFvgofBqNoFzH2A0s3XkYgsfrstv4+yuTVE6DVtEwfJ+jyQ1x2vBknwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaCkpLLU9xnrmSfCcIPduuJviKg99CfVp7fWj0940fc=;
 b=TE7WiXCgVv77NshItBrIVE+WKW5iyQR5hxysv47xNTGZCwpgpcNlCrAwnkXEhNUPmIxNu3N/gIdAdImE0m0EBQB2DhqXusfohV3czJBOwWXF0ZDMNGJNxTz6hi6qiVuEL0Ai6AimMxW46sCALUu3sGl+Xyj0Z3dcrZqZ4+YQicwBxeVheC0C2MAi5Pz+Y/0D9Akqd0AYSnHUAtRYmhVhoYxURMBTcXVsBpZp1qnrNX5xhb1hSl+vhFN2vUeyHyZ6Cj1PgBsPx8cwa6J2Ay3xLA/d9MgWRpXoeYlm7iX8Pn4hNhFsvNiBDi360HTFIPIMbMahndl3hDLJIBNEoW3r6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaCkpLLU9xnrmSfCcIPduuJviKg99CfVp7fWj0940fc=;
 b=pLQ5W14OR7A507xxGtba+gE+qOtxdwUHOVQvkgN6r7lZC8u8qFvQG2grBgXSsGOEXkRwSizqP5eAts4yZiKAuvV1YcBRxCXhCgkgNVjaRVa6fRwI4meuy8sariytzfyDXuN/TkX66wMhL2v2y1IYaxHqnelq0aFwnBayS2f5jzc=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3824.namprd11.prod.outlook.com (20.178.253.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 08:41:58 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.025; Thu, 7 Nov 2019
 08:41:58 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 3/6] mtd: spi-nor: Extend the SR Read Back test
Thread-Topic: [PATCH v5 3/6] mtd: spi-nor: Extend the SR Read Back test
Thread-Index: AQHVlUc31PrXripn0kSSky8YgxkzJg==
Date:   Thu, 7 Nov 2019 08:41:58 +0000
Message-ID: <20191107084135.22122-4-tudor.ambarus@microchip.com>
References: <20191107084135.22122-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191107084135.22122-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0060.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::40) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [109.166.128.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3db4467b-7ad9-4052-55fe-08d7635e5981
x-ms-traffictypediagnostic: MN2PR11MB3824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB38247A83CAEAE8809AC73995F0780@MN2PR11MB3824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(25786009)(6512007)(66476007)(6486002)(110136005)(66946007)(6116002)(66446008)(71200400001)(86362001)(54906003)(66556008)(64756008)(2906002)(6436002)(256004)(36756003)(478600001)(66066001)(14454004)(8936002)(186003)(76176011)(52116002)(316002)(2616005)(99286004)(102836004)(71190400001)(107886003)(81156014)(81166006)(4326008)(2501003)(26005)(1076003)(11346002)(305945005)(7736002)(446003)(6506007)(5660300002)(486006)(476003)(386003)(8676002)(3846002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3824;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fk3UBQdxsQypix799/Hxxk7zdpBDQKTKDZKiaVEZXYEbXfNQ5jlwchzqy4DzdMuySn0B5/mEjG6wvn6NHYpGtT8iJ8BfW9bYBZn+uIcHQJaiO6gGNyNOXuOpeMxt1AJZv31CCCkYDPijBGUJc6N2YevswWfPZLXMxfQwNdNV1j9QtrVXzW77gX0UrZL2Wivhe5SfVVjjYLFYSwXFVM/Nj+BPuyGunnlcNXy3dZiixTuoImPUtHV7O2/hL9Pd+Ab8FAJPreS1c+Kd/0rX3eIfVB5ZB9teqyppOkCYAaoYrvINu02sRw9Y/YiQKJce8Vd1OJqJPJW8rQ2i6kQ4x4f2oxSn5BU4YvxGAOWDo3DF5pIy+GoWHcWcT9rhAm1Xo3TaL42GKS2knl0g2iALdSOACzGftYLvrJ7X7QqBgymvhzRSUvJnb0ZGhFee3vFDI3qC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db4467b-7ad9-4052-55fe-08d7635e5981
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 08:41:58.2714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCC19Bd9iQYOSKFaTdE0Zj1K/6pxqbtYceRfrtxujlPCAOwlV6GFcduV2VXsxANWravAI/MpkpUbP+lk31IAEWxBQSnXEgwnnwxETwoqjHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Test that all the bits from Status Register 1 and Status Register 2
were written correctly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 58 +++++++++++++++++++++++++++++----------=
----
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 06aac894ee6d..d33ad56d3b67 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2047,20 +2047,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
=20
 	nor->bouncebuf[0] |=3D SR_QUAD_EN_MX;
=20
-	ret =3D spi_nor_write_sr(nor, nor->bouncebuf, 1);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
-		dev_dbg(nor->dev, "Macronix Quad bit not set\n");
-		return -EIO;
-	}
-
-	return 0;
+	return spi_nor_write_sr1_and_check(nor, nor->bouncebuf[0]);
 }
=20
 /**
@@ -2080,6 +2067,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
 {
 	u8 *sr_cr =3D nor->bouncebuf;
 	int ret;
+	u8 sr_written;
=20
 	/* Keep the current value of the Status Register. */
 	ret =3D spi_nor_read_sr(nor, sr_cr);
@@ -2088,7 +2076,22 @@ static int spansion_no_read_cr_quad_enable(struct sp=
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
@@ -2108,6 +2111,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 {
 	u8 *sr_cr =3D nor->bouncebuf;
 	int ret;
+	u8 sr_written;
=20
 	/* Check current Quad Enable bit value. */
 	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
@@ -2128,13 +2132,26 @@ static int spansion_read_cr_quad_enable(struct spi_=
nor *nor)
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
+	sr_written =3D sr_cr[1];
+
 	/* Read back and check it. */
 	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
 	if (ret)
 		return ret;
=20
-	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
-		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
+	if (sr_cr[1] !=3D sr_written) {
+		dev_dbg(nor->dev, "CR: Read back test failed\n");
 		return -EIO;
 	}
=20
@@ -2157,6 +2174,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 {
 	u8 *sr2 =3D nor->bouncebuf;
 	int ret;
+	u8 sr2_written;
=20
 	/* Check current Quad Enable bit value. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
@@ -2172,13 +2190,15 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor=
)
 	if (ret)
 		return ret;
=20
+	sr2_written =3D *sr2;
+
 	/* Read back and check it. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
 	if (ret)
 		return ret;
=20
-	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
-		dev_dbg(nor->dev, "SR2 Quad bit not set\n");
+	if (*sr2 !=3D sr2_written) {
+		dev_dbg(nor->dev, "SR2: Read back test failed\n");
 		return -EIO;
 	}
=20
--=20
2.9.5

