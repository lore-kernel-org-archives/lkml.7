Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86252C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49226214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="U9VxM/rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503964AbfIXHq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:58 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:28119 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503950AbfIXHq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:56 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: C/08ldO9TfTripdui/nG8F2VLKxRXke32gdrQXN+yUgTUjT2UPRUuoBf3J72yxtkCBEn5vVFPN
 ozju5kHK6k8hYi5C6qXevn2PDmA8Zx3UEHezk1QZRbP6UDSjVPZA5Yum9Gg0a34WzIe5kvtA+f
 M6JOuLjp8MoAyXCTYyJWwnQNecju/UrOVyPMcOw3TMu2xZRKAeaCHGYu+hyC+ct+uH11QV5/NR
 dxZvROrPvEwYDo0NKLfluYcKwGRrFeU50ubJ9rUJSMTRz9kjan5daNOivMjoob/YJG8bo1slfE
 q2o=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="50281852"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:52 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPWnnD6yGTuzxqtm/y3WLoEIakwGlf5/cXRIKcw40JPCQOwVIUyox8mIJg2flSZbmNDM2Bd8KOkaR7aWbW3ppqGeI86+NeILvUtahNpXZmk+cUnvF1tS37+bWPtZ36MTXdw+S3ndf4kpVRDkWLfn31DFl9kNqdaM4whq+Vx4d54IPRcXaCtgpAY3JR06NN8zNNefjSM2jXyvc0nLg7RO71t8/SsBtJiq04Unjf9nwuEyCAS/thLSikLsNykOW6ikkDzhlppmDT/hSKQ8IEVZK7hEvszlwW+dGWgzs3dmOYCDLoBHL28cWQbO8otXOZJsMNZq8QzlRZRgV5QiVMw0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQk2JOlqJszkXyWMTVXKlHc3ol4s39R6XYJvc/hq46U=;
 b=EaV372oNnAg8BgcdTgd/wBetlSOVo3ytcF5YMNuDriqQeT7DnlmAnLOcjEzpxN7a0IUsmXmxl+oAKH+TBnxAqTAEZzmVVD7Aj5DAtrUiD/XkY+2EjiTwO11hNpixa34yk7Bxbdx2tHdN49nmrv0cBi8FbZjumLW47FG52anXIMT9A+ege3Clkb4o/BJQwOSoormigVseFcerK/lfx8C9gbPwQaC6HHIAAPcFuB/ulA/eS5lIctm3ZYCZHkj0y6nMOJciPnO1p5g28L2VX3p/H1pgLwc3Cx9SDcA2VKBYUX1B7/prSdhENsbufz1Phk0ti/2+KbyljuCBwE601YCNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQk2JOlqJszkXyWMTVXKlHc3ol4s39R6XYJvc/hq46U=;
 b=U9VxM/rQjoKGwl0YX6oMg4MAILu6tbFflYqbgpZ6ObtojwY2Ypd1CqkVSKC++VVedR0ZMaHhf4qdr8CH0Pro+qy5vCdf/UJUw2yOTq16suKO73PzFfqfiLtQmX/nOlgHoxBUxVyNlmUOlgPKX3eQqhJwtAgCxI9qQkOQqCqLzUM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:50 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 18/22] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Topic: [PATCH v2 18/22] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Index: AQHVcqw53EXz0xlEpUGaAOwjOxtARg==
Date:   Tue, 24 Sep 2019 07:46:50 +0000
Message-ID: <20190924074533.6618-19-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::50) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e970f92b-21a8-402d-ab24-08d740c35c22
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43198B2C0EFF44425737CAAEF0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(14444005)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r4eS2wvWFfAGUd9Z0MqWm+CbLMXlkU2+LoEGibwVUCXWnm2d5iVAriX3FyQpNXEoLY4LUpH8oJvXlRaqNFBW/D1/m8VW0fQB7/g2O7m0O5/iRrlwWegLQRtpqip63fcXsTi7i/HsCCy9LTeVrZxrVaabD5c+8jwpCGf7M5HqTU4DaxeQvd6GypIKxZtOL+GvyIlCuWwLgwAL9yqQ07/GFYxpgl7fP7rCemc8o4eNr2jREYzLq2LPj6j3sDWUUcURGm5s7okbFoKkRQfELAsTY9F1IJXlIS6af8OqLEamCz+XkkKGGhVe7HRH6XEPBjRKW7xaY/ocMaIsatHKC8tp9Wm8PUNgX9EKrbkDlmNltk8djdNnRXSmMKDHGtumvGfTc9d/CUwNbUuCcoLVUgCKXIRmpFltypn866f9U65HatM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e970f92b-21a8-402d-ab24-08d740c35c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:50.6429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rGRvmPs65U52dXkntbDVPmnne3lZSa/7Joakh+/In0qEg+VJPKL9jqKrlmp7sbjrXUWO53z/HdGaiHSCXdS/h0hB6rgqaFg+8p5Xa19aGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Make sure that when doing a lock() or an unlock() operation we don't clear
the QE bit from Status Register 2.

JESD216 revB or later offers information about the *default* Status
Register commands to use (see BFPT DWORDS[15], bits 22:20). In this
standard, Status Register 1 refers to the first data byte transferred on a
Read Status (05h) or Write Status (01h) command. Status register 2 refers
to the byte read using instruction 35h. Status register 2 is the second
byte transferred in a Write Status (01h) command.

Industry naming and definitions of these Status Registers may differ.
The definitions are described in JESD216B, BFPT DWORDS[15], bits 22:20.
There are cases in which writing only one byte to the Status Register 1
has the side-effect of clearing Status Register 2 and implicitly the Quad
Enable bit. This side-effect is hit just by the
BFPT_DWORD15_QER_SR2_BIT1_BUGGY and BFPT_DWORD15_QER_SR2_BIT1 cases.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 165 +++++++++++++++++++++++++++++++++++++-=
----
 include/linux/mtd/spi-nor.h   |   2 +
 2 files changed, 147 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 48bcb2ee1be5..8ada2003f1c9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -836,6 +836,127 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *=
sr2)
 	return ret;
 }
=20
+/**
+ * spi_nor_write_sr1_and_check() - Write one byte to the Status Register 1=
 and
+ * ensure that the byte written match the received value.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * @sr1:	byte value to be written to the Status Register.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_sr1_and_check(struct spi_nor *nor, u8 sr1)
+{
+	int ret;
+
+	nor->bouncebuf[0] =3D sr1;
+
+	ret =3D spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
+	if (ret)
+		return ret;
+
+	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	if (nor->bouncebuf[0] !=3D sr1) {
+		dev_err(nor->dev, "SR1: read back test failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * spi_nor_write_16bit_sr_and_check() - Write the Status Register 1 and th=
e
+ * Status Register 2 in one shot. Ensure that the byte written in the Stat=
us
+ * Register 1 match the received value, and that the 16-bit Write did not
+ * affect what was already in the Status Register 2.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * @sr1:	byte value to be written to the Status Register 1.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
+{
+	int ret;
+	u8 *sr_cr =3D nor->bouncebuf;
+	u8 cr_written;
+
+	/* Make sure we don't overwrite the contents of Status Register 2. */
+	if (!(nor->flags & SNOR_F_NO_READ_CR)) {
+		ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+		if (ret)
+			return ret;
+	} else if (nor->flash.quad_enable) {
+		/*
+		 * If the Status Register 2 Read command (35h) is not
+		 * supported, we should at least be sure we don't
+		 * change the value of the SR2 Quad Enable bit.
+		 *
+		 * We can safely assume that when the Quad Enable method is
+		 * set, the value of the QE bit is one, as a consequence of the
+		 * nor->flash.quad_enable() call.
+		 *
+		 * We can safely assume that the Quad Enable bit is present in
+		 * the Status Register 2 at BIT(1). According to the JESD216
+		 * revB standard, BFPT DWORDS[15], bits 22:20, the 16-bit
+		 * Write Status (01h) command is available just for the cases
+		 * in which the QE bit is described in SR2 at BIT(1).
+		 */
+		sr_cr[1] =3D CR_QUAD_EN_SPAN;
+	} else {
+		sr_cr[1] =3D 0;
+	}
+
+	sr_cr[0] =3D sr1;
+
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
+	if (ret)
+		return ret;
+
+	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
+	if (ret)
+		return ret;
+
+	if (sr_cr[0] !=3D sr1) {
+		dev_err(nor->dev, "SR1: read back test failed\n");
+		return -EIO;
+	}
+
+	if (nor->flags & SNOR_F_NO_READ_CR)
+		return 0;
+
+	cr_written =3D sr_cr[1];
+
+	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
+		return ret;
+
+	if (cr_written !=3D sr_cr[1]) {
+		dev_err(nor->dev, "CR: read back test failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * spi_nor_write_sr_and_check() - Write the Status Register 1 and ensure t=
hat
+ * the byte written match the received value without affecting other bits =
in the
+ * Status Register 1 and 2.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * @sr1:	byte value to be written to the Status Register 1.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1)
+{
+	if (nor->flags & SNOR_F_HAS_16BIT_SR)
+		return spi_nor_write_16bit_sr_and_check(nor, sr1);
+
+	return spi_nor_write_sr1_and_check(nor, sr1);
+}
+
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
@@ -1492,24 +1613,6 @@ static int spi_nor_erase(struct mtd_info *mtd, struc=
t erase_info *instr)
 	return ret;
 }
=20
-/* Write status register and ensure bits in mask match written values */
-static int write_sr_and_check(struct spi_nor *nor, u8 status_new)
-{
-	int ret;
-
-	nor->bouncebuf[0] =3D status_new;
-
-	ret =3D spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
-	if (ret)
-		return ret;
-
-	return (nor->bouncebuf[0] !=3D status_new) ? -EIO : 0;
-}
-
 static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
 				 uint64_t *len)
 {
@@ -1673,7 +1776,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, =
uint64_t len)
 	if ((status_new & mask) < (status_old & mask))
 		return -EINVAL;
=20
-	return write_sr_and_check(nor, status_new);
+	return spi_nor_write_sr_and_check(nor, status_new);
 }
=20
 /*
@@ -1758,7 +1861,7 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs=
, uint64_t len)
 	if ((status_new & mask) > (status_old & mask))
 		return -EINVAL;
=20
-	return write_sr_and_check(nor, status_new);
+	return spi_nor_write_sr_and_check(nor, status_new);
 }
=20
 /*
@@ -3536,19 +3639,39 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
+		/*
+		 * Writing only one byte to the Status Register has the
+		 * side-effect of clearing Status Register 2.
+		 */
+		/* fall through */
 	case BFPT_DWORD15_QER_SR2_BIT1_NO_RD:
+		nor->flags |=3D SNOR_F_HAS_16BIT_SR;
+		/*
+		 * Read Configuration Register (35h) instruction is not
+		 * supported.
+		 */
+		nor->flags |=3D SNOR_F_NO_READ_CR;
 		flash->quad_enable =3D spansion_no_read_cr_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR1_BIT6:
+		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
 		flash->quad_enable =3D macronix_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT7:
+		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
 		flash->quad_enable =3D sr2_bit7_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1:
+		/*
+		 * JESD216 rev B or later does not specify if writing only one
+		 * byte to the Status Register clears or not the Status
+		 * Register 2, so let's be cautious and keep the default
+		 * assumption of a 16-bit Write Status (01h) command.
+		 */
+		nor->flags |=3D SNOR_F_HAS_16BIT_SR;
 		flash->quad_enable =3D spansion_read_cr_quad_enable;
 		break;
=20
@@ -4515,6 +4638,8 @@ static void spi_nor_info_init_flash_params(struct spi=
_nor *nor)
 	flash->quad_enable =3D spansion_read_cr_quad_enable;
 	flash->set_4byte =3D spansion_set_4byte;
 	flash->setup =3D spi_nor_default_setup;
+	/* Default to 16-bit Write Status (01h) Command */
+	nor->flags |=3D SNOR_F_HAS_16BIT_SR;
=20
 	/* Set SPI NOR sizes. */
 	flash->size =3D (u64)info->sector_size * info->n_sectors;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 12961b157743..fc3a8f5209f0 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -243,6 +243,8 @@ enum spi_nor_option_flags {
 	SNOR_F_4B_OPCODES	=3D BIT(6),
 	SNOR_F_HAS_4BAIT	=3D BIT(7),
 	SNOR_F_HAS_LOCK		=3D BIT(8),
+	SNOR_F_HAS_16BIT_SR	=3D BIT(9),
+	SNOR_F_NO_READ_CR	=3D BIT(10),
 };
=20
 /**
--=20
2.9.5

