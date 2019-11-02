Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D63CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F4D21726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nX0KBM/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfKBLX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:28 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39918 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKBLX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:27 -0400
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
IronPort-SDR: 55W+p0ZxhcPdYyzDUfscrJXleBwDT1Wehnrcd9GE3xqkj2WmSP6pjiBnk8GBMocaS1AjvMrx9j
 /vORzUMT4KPlCAUPo81BPFd8+4ppyuML2/mKEWsGFZoYmYvUsUa6ihhJQwlQ5wiquc/arKC5JV
 LEg28PuwK+kT8+LZ4zsVnaBhzkl5fWKkGhJbfRCkXX+DXhLvXJX+xdXkKJbj/qvRqtSXfVH6bq
 /C/uj2sni3gi0Ty/PY5JeUle1UZwJB3qSxlooHzJFS7mdcP3a9UtfUv+95UhonL5XUHIOSqnn+
 oHU=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53900845"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:27 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbVu6Jg8oVdG35Xa8UfLEq4vC0/nXZL++iDvutjWHkCT/fTyU8pIp3ckda85Yk2wQs6TPPfCejvCzKquYruZbclxHY+bnv0/Na7ItwQeD4//B7Z6HjjVimiCs44NXGW7+E9/Cxl0XXvuQv6JKT+slgjX4l8sg+yWIGHCQQ3SoHrhYlBw37GfxN6KiK5NQeBZVswHyq9HaC+Od08MVqaSJOdKdPNjz6ONvJh/dVHzAEqRBsreMOn0cbMuLGvsZUtp1oqLcgbQliOKLskASpR2es+mak2cQ9RFp4lZ4tJFHszutjB5j+ygkofSdx1WJKurbeexxypRxWHkLZyWZOh1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ySbZXCT5Lbk1TtlzqI8Z6uPxrxLIzfvbGW472AMzPo=;
 b=W/pD6iNoyUOAvWIThLkhfmK5P5XVmteC1nZ66TZErALIqKKatguIrUwCYgWRHBS/GVOzu9H48ac0ssNxpejVByA/FzrHeAl7FZCK2Yh98pDk1Lr8S6Kg26plqC9BulbZBC7Z18td8TQF9Ir+ZFTlyszmjd1ykgpyZHCkuWkx5NVMjNiIFWAXXEDA0Sw+oe0EERNotkkWKtfBsqgIyljASxDQJbrNLYv+DdsGP7FSIKcAdey31pVzqp9bTj/aWa6Fc00ubxnJOdqi7p5gZ+5pElEE2NMa1YX9BFS6meb10S4OEiClbSOc1vLpVogl7zlvwfmFP4NgctWelUi0RBs4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ySbZXCT5Lbk1TtlzqI8Z6uPxrxLIzfvbGW472AMzPo=;
 b=nX0KBM/aucwo7a1oWBofuryLtGnj1JfjCHbYQDFE2XaE5HlHRkh6fTZTBLSbw4eeXoNgpgLQpw7PBJvfMgklCtr5ETiodBNtqYIebG3XE+U5KjKMAm30NjLis9AKyfEBhd1AdoJC7asNs6VXRF+PVPC1iZ41f/+6o026dCQn814=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:25 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 01/20] mtd: spi-nor: Use dev_dbg insted of dev_err for low
 level info
Thread-Topic: [PATCH v4 01/20] mtd: spi-nor: Use dev_dbg insted of dev_err for
 low level info
Thread-Index: AQHVkW/xBgAv7ThozEyzMFjaioqIiA==
Date:   Sat, 2 Nov 2019 11:23:25 +0000
Message-ID: <20191102112316.20715-2-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: bdd7911c-be9e-4fca-8d40-08d75f87139f
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37110E962217E33AAFE99AF3F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39850400004)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dk+VbxPhWw6vRMplSAfOWEjjWYTmk7mnSFM1SC2lX/ZLBWawBstAODuRWCHms1NUo5fp97Jo3BIXLfa9qMKBQwXyzenbIDP46v47tKsfH86qXjQn8B3WlbkRxWkhnaBeYxoQX0AbocU4qXuhse0iWBd967i+KxABL8aJ6OIWEWFp2RtIFak/VuImPKddD52CDRZgGK7A1JhJLsS+z1v4tkuvj75t2NH+5vtP2q/aWNXlLfwS0n8bK8wxTWM1or9lrCve33S7lW3d04RVa21eOjYSBdtOUWoQ8AjxEMXwTMs7Q97El14aUirmMZH9CfhK1bCl0nTMl2VWy/9dnUQpW/5rxMwp0hHcwZrVBwsf5pG4DK6iRuK5AXIgcLCkXyC56RJYa07VEUIwd5TNQL0646AuLuI98yGrPvA/7bJRo1VW850fSidh6sy8MRwVudTp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd7911c-be9e-4fca-8d40-08d75f87139f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:25.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os1WVJktK7uhAG+Mi3e4IhjAT4bcFHXIdi3SLKztFOVWPMdSQHCEWybLj7e47k0O5Gl3ecv3Y2GIMKkwuWv+drbC8VMgc6dGnDtqLthMzaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

What most users care about is "my dev is not working properly".
All low level information should be discovered when activating
the debug traces.

Keep error messages for just three cases:
- when the JEDEC ID is not recognized
- when the resume() call fails
- when the spi_nor_check() fails.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 52 +++++++++++++++++++++------------------=
----
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f89620005198..eca6bce7c336 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -451,7 +451,7 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 	}
=20
 	if (ret)
-		dev_err(nor->dev, "error %d reading SR\n", ret);
+		dev_dbg(nor->dev, "error %d reading SR\n", ret);
=20
 	return ret;
 }
@@ -482,7 +482,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fs=
r)
 	}
=20
 	if (ret)
-		dev_err(nor->dev, "error %d reading FSR\n", ret);
+		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
=20
 	return ret;
 }
@@ -513,7 +513,7 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 	}
=20
 	if (ret)
-		dev_err(nor->dev, "error %d reading CR\n", ret);
+		dev_dbg(nor->dev, "error %d reading CR\n", ret);
=20
 	return ret;
 }
@@ -647,7 +647,7 @@ static int s3an_sr_ready(struct spi_nor *nor)
=20
 	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
 	if (ret) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", ret);
+		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
 		return ret;
 	}
=20
@@ -679,9 +679,9 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
 	if (nor->flags & SNOR_F_USE_CLSR &&
 	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
 		if (nor->bouncebuf[0] & SR_E_ERR)
-			dev_err(nor->dev, "Erase Error occurred\n");
+			dev_dbg(nor->dev, "Erase Error occurred\n");
 		else
-			dev_err(nor->dev, "Programming Error occurred\n");
+			dev_dbg(nor->dev, "Programming Error occurred\n");
=20
 		spi_nor_clear_sr(nor);
 		return -EIO;
@@ -714,12 +714,12 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
=20
 	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
 		if (nor->bouncebuf[0] & FSR_E_ERR)
-			dev_err(nor->dev, "Erase operation failed.\n");
+			dev_dbg(nor->dev, "Erase operation failed.\n");
 		else
-			dev_err(nor->dev, "Program operation failed.\n");
+			dev_dbg(nor->dev, "Program operation failed.\n");
=20
 		if (nor->bouncebuf[0] & FSR_PT_ERR)
-			dev_err(nor->dev,
+			dev_dbg(nor->dev,
 			"Attempted to modify a protected sector.\n");
=20
 		spi_nor_clear_fsr(nor);
@@ -770,7 +770,7 @@ static int spi_nor_wait_till_ready_with_timeout(struct =
spi_nor *nor,
 		cond_resched();
 	}
=20
-	dev_err(nor->dev, "flash operation timed out\n");
+	dev_dbg(nor->dev, "flash operation timed out\n");
=20
 	return -ETIMEDOUT;
 }
@@ -807,7 +807,7 @@ static int spi_nor_write_sr_cr(struct spi_nor *nor, con=
st u8 *sr_cr)
 	}
=20
 	if (ret) {
-		dev_err(nor->dev,
+		dev_dbg(nor->dev,
 			"error while writing configuration register\n");
 		return -EINVAL;
 	}
@@ -1771,7 +1771,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
 		return ret;
=20
 	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
-		dev_err(nor->dev, "Macronix Quad bit not set\n");
+		dev_dbg(nor->dev, "Macronix Quad bit not set\n");
 		return -EINVAL;
 	}
=20
@@ -1819,7 +1819,7 @@ static int spansion_quad_enable(struct spi_nor *nor)
 		return ret;
=20
 	if (!(nor->bouncebuf[0] & CR_QUAD_EN_SPAN)) {
-		dev_err(nor->dev, "Spansion Quad bit not set\n");
+		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
 	}
=20
@@ -1897,7 +1897,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 		return ret;
=20
 	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
-		dev_err(nor->dev, "Spansion Quad bit not set\n");
+		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
 	}
=20
@@ -1935,7 +1935,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
=20
 	ret =3D spi_nor_write_sr2(nor, sr2);
 	if (ret) {
-		dev_err(nor->dev, "error while writing status register 2\n");
+		dev_dbg(nor->dev, "error while writing status register 2\n");
 		return ret;
 	}
=20
@@ -1949,7 +1949,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 		return ret;
=20
 	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
-		dev_err(nor->dev, "SR2 Quad bit not set\n");
+		dev_dbg(nor->dev, "SR2 Quad bit not set\n");
 		return -EINVAL;
 	}
=20
@@ -1978,7 +1978,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
=20
 	ret =3D spi_nor_write_sr(nor, nor->bouncebuf[0] & ~mask);
 	if (ret) {
-		dev_err(nor->dev, "write to status register failed\n");
+		dev_dbg(nor->dev, "write to status register failed\n");
 		return ret;
 	}
=20
@@ -2525,7 +2525,7 @@ static const struct flash_info *spi_nor_read_id(struc=
t spi_nor *nor)
 						    SPI_NOR_MAX_ID_LEN);
 	}
 	if (tmp) {
-		dev_err(nor->dev, "error %d reading JEDEC ID\n", tmp);
+		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
 		return ERR_PTR(tmp);
 	}
=20
@@ -2740,7 +2740,7 @@ static int s3an_nor_setup(struct spi_nor *nor,
=20
 	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
 	if (ret) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", ret);
+		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
 		return ret;
 	}
=20
@@ -4102,7 +4102,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 		err =3D spi_nor_read_sfdp(nor, sizeof(header),
 					psize, param_headers);
 		if (err < 0) {
-			dev_err(dev, "failed to read SFDP parameter headers\n");
+			dev_dbg(dev, "failed to read SFDP parameter headers\n");
 			goto exit;
 		}
 	}
@@ -4349,7 +4349,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 	/* Select the (Fast) Read command. */
 	err =3D spi_nor_select_read(nor, shared_mask);
 	if (err) {
-		dev_err(nor->dev,
+		dev_dbg(nor->dev,
 			"can't select read settings supported by both the SPI controller and me=
mory.\n");
 		return err;
 	}
@@ -4357,7 +4357,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 	/* Select the Page Program command. */
 	err =3D spi_nor_select_pp(nor, shared_mask);
 	if (err) {
-		dev_err(nor->dev,
+		dev_dbg(nor->dev,
 			"can't select write settings supported by both the SPI controller and m=
emory.\n");
 		return err;
 	}
@@ -4365,7 +4365,7 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 	/* Select the Sector Erase command. */
 	err =3D spi_nor_select_erase(nor);
 	if (err) {
-		dev_err(nor->dev,
+		dev_dbg(nor->dev,
 			"can't select erase settings supported by both the SPI controller and m=
emory.\n");
 		return err;
 	}
@@ -4686,7 +4686,7 @@ static int spi_nor_init(struct spi_nor *nor)
=20
 		err =3D nor->clear_sr_bp(nor);
 		if (err) {
-			dev_err(nor->dev,
+			dev_dbg(nor->dev,
 				"fail to clear block protection bits\n");
 			return err;
 		}
@@ -4694,7 +4694,7 @@ static int spi_nor_init(struct spi_nor *nor)
=20
 	err =3D spi_nor_quad_enable(nor);
 	if (err) {
-		dev_err(nor->dev, "quad mode not supported\n");
+		dev_dbg(nor->dev, "quad mode not supported\n");
 		return err;
 	}
=20
@@ -4762,7 +4762,7 @@ static int spi_nor_set_addr_width(struct spi_nor *nor=
)
 	}
=20
 	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
-		dev_err(nor->dev, "address width is too large: %u\n",
+		dev_dbg(nor->dev, "address width is too large: %u\n",
 			nor->addr_width);
 		return -EINVAL;
 	}
--=20
2.9.5

