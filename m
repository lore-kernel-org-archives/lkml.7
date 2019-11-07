Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6B0C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8885421D82
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Zop8Eg+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfKGImT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:42:19 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9855 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbfKGImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:42:18 -0500
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
IronPort-SDR: 4FiolenDgtnemgCAj/1uhLsA2MKNFQx35Hu2BPVgDGqgcGiFcybfa1Knx0eVxZ0uQ4aN2TfDBu
 quZQ9/kUmBcyomuQxtzA1EqoZHHL5JLD2tQ7OpfNxUh/jbEvJr4Qhv7AEyjOtx9QM2FfWnxLZ3
 vAVAHMaipB6N+TqUY7FxZDRElu7Nq3UcpI6+Ebbsw6QFIlcbnyk94qwaqu0nA+I/+bsGT5Y00h
 4fEc+UDfbFYXyoUOPQlt6cbhy0EHqQyEzpUxbwWEnl+A/U1UJDryKMI/KNYXSsVpKlhwVMvL4B
 MvQ=
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="54459251"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2019 01:42:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 01:42:15 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Nov 2019 01:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcniKryFU5pcaSrejexWE7NL73axCJnsLcCzQYHiMOXodaLqfLi0T908ISqCXL58hlb4aMQarU46VYwtx13n6N6LYpYy0O+sD3pkcUyNnP9hXkBw02QFnx2UOo3xrNkfL/O2gRSvHqyJcvYHPe0OkAQ5+mE+6/z7mj4YH3hzFKPKp2tdZ2t9Y/EKqxiAi13lf9ABcV72ktp4J+I23hPurHvfeSwlCse2qZ21iLitD7USN9CSIhWCJLmQMdBqDFAY7jCel/A+JWcZsQaxF1GoD2q+y0xx9P180XbeH6XP4mrlc8eqD2rBZRieR8O9FmDfYXcendxh5bJzfXJhjT+2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36sHq4xLRN2V1HUoPMFRPhk+SUtyao3Upkx6ETT2xb4=;
 b=kJJOVxZexRp87eH+kEM5ImO+Kmm2zmvziBENxTP2ExA+G1+TbY0HVNapnCmgrAVf7ypSVivrcrY+PzUJx9SYTK9R5HqPPNQpPmuVQ0ICrVb2XB7N9YVzKPrbaU1QlUT7Kbb2pLWS0CCBzU/Paa4ilKItvAZPFkvB1ROThyYH4UOI8bkihbbCniU0q9LahOb0wpd9+Ju3F7HdFrOgBjtg8O8BVa8xzAgyaNPxJsxGTm13UM0gw5yEESWhANi3q/x6ndqnc/rBNK3z9fKA4OkmCZf/jbo+wRE0UtYDQol0/MOrEHTqQxMx4Myvn3UtvVrjqjm2MeLelwKRkhfW9dUrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36sHq4xLRN2V1HUoPMFRPhk+SUtyao3Upkx6ETT2xb4=;
 b=Zop8Eg+pAplGfLeWYZlZ6a8IV1pjrgZwQN7wI6Tczc23K5Y4MltuuY+ookwaFe64hcLaW1WCdE4a+8Ri7Jm3kqYGdAhs7Z/DbRus7eOaGZbDE0Sz0S7+j2V9G3WWVtoi4FXCHYgq3gOv/P3hRabvsEPQdDTPSaUT5JYny3oyJ6Q=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3824.namprd11.prod.outlook.com (20.178.253.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 08:42:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.025; Thu, 7 Nov 2019
 08:42:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 6/6] mtd: spi-nor: Rename Quad Enable methods
Thread-Topic: [PATCH v5 6/6] mtd: spi-nor: Rename Quad Enable methods
Thread-Index: AQHVlUc9BWwlfYjUPU2i4/h3qfOjVQ==
Date:   Thu, 7 Nov 2019 08:42:09 +0000
Message-ID: <20191107084135.22122-7-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 7e5230ff-74c0-4446-a485-08d7635e5fba
x-ms-traffictypediagnostic: MN2PR11MB3824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3824636DFDD99C0447AB58D0F0780@MN2PR11MB3824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(25786009)(6512007)(66476007)(6486002)(110136005)(66946007)(6116002)(66446008)(71200400001)(86362001)(54906003)(66556008)(64756008)(2906002)(6436002)(14444005)(256004)(36756003)(478600001)(66066001)(14454004)(8936002)(186003)(76176011)(52116002)(316002)(2616005)(99286004)(102836004)(71190400001)(107886003)(81156014)(81166006)(4326008)(2501003)(26005)(1076003)(11346002)(305945005)(7736002)(446003)(6506007)(5660300002)(486006)(476003)(386003)(8676002)(3846002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3824;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /l8d8VN0bjPjCOSvpvsPDNcNiuCHnWAzKNXrH6HbN83XBjyHFse82jEotm78fxZzMUosfq3r8u6sq4X1WCjnYsHHXakfTKl43rU0TQhIsD4yM8Rf4yspiVgTjfdpSprfarAdUiOf/4zvFhpMpvVSA3gXG0ywagkcWyLgSWfgClQJvtYX2lmyz+xmPaa+NHkLzy5U9o9/ce2wrBn/NzizjyA66olfeEeJdrqfalR0Mn0ahmfyNp+vqAu4sF3C2H3XLr5033WNb6rGcNRaiRFhioxwveUWJj8+xlYWop2C9qnkkgd/EKEgI6RdvZE3ctD0sTnEJbHGwMX+jAtn651bqpFONat6DyOCOkM3awxVulOKfT2TcAd/HHshM45p2yR8PDmRznw0JXMeho608GdsfkEgliihNGFwaXlmN8c8Xw0yEaf4DYfjQfDPSEzv2WHp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5230ff-74c0-4446-a485-08d7635e5fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 08:42:09.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKLyGfoXY3sZkj2AlzG3rql8GLSVvLRLtk3xKDpoxPG/VGgaLaDSoopwzqnzRGq3IVLHqWp+dPwXZGLdoddZLFqteAQ8N04GpzqA377BHZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rename macronix_quad_enable() to a generic name:
spi_nor_sr1_bit6_quad_enable().

Prepend "spi_nor_" to "sr2_bit7_quad_enable". All SPI NOR generic
methods should be prepended by "spi_nor_".

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 25 ++++++++++++-------------
 include/linux/mtd/spi-nor.h   |  2 +-
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 16fb3c7d0daf..824649eecd59 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2078,16 +2078,15 @@ static int spi_nor_is_locked(struct mtd_info *mtd, =
loff_t ofs, uint64_t len)
 }
=20
 /**
- * macronix_quad_enable() - set QE bit in Status Register.
+ * spi_nor_sr1_bit6_quad_enable() - Set the Quad Enable BIT(6) in the Stat=
us
+ * Register 1.
  * @nor:	pointer to a 'struct spi_nor'
  *
- * Set the Quad Enable (QE) bit in the Status Register.
- *
- * bit 6 of the Status Register is the QE bit for Macronix like QSPI memor=
ies.
+ * Bit 6 of the Status Register 1 is the QE bit for Macronix like QSPI mem=
ories.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int macronix_quad_enable(struct spi_nor *nor)
+static int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor)
 {
 	int ret;
=20
@@ -2095,10 +2094,10 @@ static int macronix_quad_enable(struct spi_nor *nor=
)
 	if (ret)
 		return ret;
=20
-	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
+	if (nor->bouncebuf[0] & SR1_QUAD_EN_BIT6)
 		return 0;
=20
-	nor->bouncebuf[0] |=3D SR_QUAD_EN_MX;
+	nor->bouncebuf[0] |=3D SR1_QUAD_EN_BIT6;
=20
 	return spi_nor_write_sr1_and_check(nor, nor->bouncebuf[0]);
 }
@@ -2130,7 +2129,7 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_no=
r *nor)
 }
=20
 /**
- * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
+ * spi_nor_sr2_bit7_quad_enable() - set QE bit in Status Register 2.
  * @nor:	pointer to a 'struct spi_nor'
  *
  * Set the Quad Enable (QE) bit in the Status Register 2.
@@ -2141,7 +2140,7 @@ static int spi_nor_sr2_bit1_quad_enable(struct spi_no=
r *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int sr2_bit7_quad_enable(struct spi_nor *nor)
+static int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
 {
 	u8 *sr2 =3D nor->bouncebuf;
 	int ret;
@@ -2281,7 +2280,7 @@ static void gd25q256_default_init(struct spi_nor *nor=
)
 	 * indicate the quad_enable method for this case, we need
 	 * to set it in the default_init fixup hook.
 	 */
-	nor->params.quad_enable =3D macronix_quad_enable;
+	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 }
=20
 static struct spi_nor_fixups gd25q256_fixups =3D {
@@ -3661,12 +3660,12 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
=20
 	case BFPT_DWORD15_QER_SR1_BIT6:
 		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
-		params->quad_enable =3D macronix_quad_enable;
+		params->quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT7:
 		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
-		params->quad_enable =3D sr2_bit7_quad_enable;
+		params->quad_enable =3D spi_nor_sr2_bit7_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1:
@@ -4569,7 +4568,7 @@ static void intel_set_default_init(struct spi_nor *no=
r)
=20
 static void macronix_set_default_init(struct spi_nor *nor)
 {
-	nor->params.quad_enable =3D macronix_quad_enable;
+	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 	nor->params.set_4byte =3D macronix_set_4byte;
 }
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 364309845de0..9eae35c60bce 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -133,7 +133,7 @@
 #define SR_E_ERR		BIT(5)
 #define SR_P_ERR		BIT(6)
=20
-#define SR_QUAD_EN_MX		BIT(6)	/* Macronix Quad I/O */
+#define SR1_QUAD_EN_BIT6	BIT(6)
=20
 /* Enhanced Volatile Configuration Register bits */
 #define EVCR_QUAD_EN_MICRON	BIT(7)	/* Micron Quad I/O */
--=20
2.9.5

