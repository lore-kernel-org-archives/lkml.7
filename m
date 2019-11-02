Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8EACA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37AE21897
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="igYnU2Vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKBLX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39961 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfKBLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:49 -0400
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
IronPort-SDR: Hu5eiDlkaRD2pGwGNKc4C+c3+1tMxR7kI24l3CsIhI+9RUIFs9kv9eX5RkwIo+yfF7SwAWtg8U
 I/NWBDBpnCiAVH9SqfaeJ/yrMXkCeWw0LP1FKN2lqBOfrABb2ZaIwWgCu5Us1G1CZjXS8L2PQC
 EW4PcG6xx5ZMv2QsJYkY45SYMdFf4Giv0a/S9bm6fDoo0GQP8AMcmLFbTiVjuLuEbjRQMZ+MzG
 RLGJwtPmoZLqjtggnniSVxJREOZjCpQjaNPwix08NY1TFXMGTyyADDmWJkmuMfyD+1X6sgjYlA
 OKw=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53900879"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:49 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 2 Nov 2019 04:23:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqtys4NhS7Fj9aN9G+nD98sScQKOV+GW7L43COUWObIqfoLA5XB/6nAH3yE2K2FRYQmjNUhMzn1MsSDhdnv/wbrqCNe0FzQfwLGiy9vwgwxOMD5Ebeo+tX6Z/CDbZp2aBvoQFBqjg1906d2ypD3sESWEjGnWu2BWmVYSqLMnL4liY3qrrIN98tyvTtZdvDxRiHyikkvlFLVMrccA4v4oxkFrP6r9utzojBUK6ZXaTsB0NY4BM4e5gaKO2wQt8vO9qXmELxkWGJ/72vCYaicTSTEKUCJA4KiGfnVn/i25D5SBnq+Ucsi+DsB22peQNDsc/U9R2+l4qZaju/dbfBE+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNOfa2RbndFTMhDq+I8Mqm9eef0GwUvpqVSuVRWBQuc=;
 b=FJHbuAqBuvfqei7Zt+kdb8YYd92zZYHHB0h4yE7QBbihOTcRxolXjOkkgRGYq024r7sKQExeyZTlfBojkSSBB+9EBE3WhqPH893Jmq+xUVuZ+FbfZ0MFAQ8AImjraCZJsNLKgYhD0IPBi9OZMBD7XbfhesWKwJlBtoD6wKqb+1qf4B3QNXp57LdQp4tnGOaA2cGKGmdDSFBviANNYwDxFabGJ2RrdKSnHEK/LxmgafutAO2oDyjgRp2WK4fdozpndk2uTYnQd5KoRd8iJLTYCYLkk1lKD9rZ6nPHbIuZC3UAWhH2DZk9p/MqzFIvb84nlKNGjTvDOLpvkVrC7Eu5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNOfa2RbndFTMhDq+I8Mqm9eef0GwUvpqVSuVRWBQuc=;
 b=igYnU2VuocrMTKIiba78PQUu7HbvndFEV06LvjhhCrHkwTvh16ILiaKlwvxSAMwKtHTVTsmgW6CTQYuSiFwtDOpVhHn1YBfWOclra3N5ejuWZmbvLcMQovnh7Ad01peeInks7zeXbEvbkgWv6/Qm5hqjUbN/b5krIQh+ZJlcGvQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:47 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 13/20] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Topic: [PATCH v4 13/20] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Index: AQHVkW/+ecEbRc4nfkO7skTHWA7uQg==
Date:   Sat, 2 Nov 2019 11:23:47 +0000
Message-ID: <20191102112316.20715-14-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 970966d9-a805-4dca-8f2f-08d75f87209f
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371143C984AB559E75065824F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(14444005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaUjPVkXIWsu1uUz7JUfgBBj5w1MzQ8lmxBwM1BUjA/hfmHI3gSOLMo9Ycl6aES1TLIK1xtg/gwnFB7TIb1BdSsQYaAcwn9va9juZR1x+9AKqk1OM8fWZtufKYl6/j274LDiyOln3qOLlifQQtbSWBnJjcI/zs/4XOu0WpL0SDxi6g2iKiI8hN3MgGXgKBnbekyuQHeotngjOibWT67PGw3n0PKDDKI91jlY7pDuQynEdTS5OKwV6Y7eRUgPR9sdqm2mKB5wMMBFgS4qDrAi6CPN5DPKC3py+1BVfJdkkhnjIEaMdbr58ZVoK2eISmAh2npdfhJqmFmr0iClOoY6r0EbrOvcq4yx6PyieqLBieylyIpqMZjIhEP4lP63R3dfMrxTYJ7mwb2JXMjA03gAK1obT4RRGqO30BJzTjXuNZwQloL1HYUbDLXvYogFfcXW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 970966d9-a805-4dca-8f2f-08d75f87209f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:47.1854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCGhjMaVrLAp0e+m5M1v0tr3z35xcO/2sNDhizishLO2bDFDuBCnINjpwctQwl5ZCzY0AIlyDnd8PmJodnfPpJB4lYrXH2ILLnzzX6wQVQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
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
 drivers/mtd/spi-nor/spi-nor.c | 120 ++++++++++++++++++++++++++++++++++++++=
++--
 include/linux/mtd/spi-nor.h   |   3 ++
 2 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 725dab241271..f96bc80c0ed1 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -959,12 +959,19 @@ static int spi_nor_write_sr(struct spi_nor *nor, cons=
t u8 *sr, size_t len)
 	return spi_nor_wait_till_ready(nor);
 }
=20
-/* Write status register and ensure bits in mask match written values */
-static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new)
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
 {
 	int ret;
=20
-	nor->bouncebuf[0] =3D status_new;
+	nor->bouncebuf[0] =3D sr1;
=20
 	ret =3D spi_nor_write_sr(nor, nor->bouncebuf, 1);
 	if (ret)
@@ -974,8 +981,73 @@ static int spi_nor_write_sr_and_check(struct spi_nor *=
nor, u8 status_new)
 	if (ret)
 		return ret;
=20
-	if (nor->bouncebuf[0] !=3D status_new) {
-		dev_dbg(nor->dev, "SR: read back test failed\n");
+	if (nor->bouncebuf[0] !=3D sr1) {
+		dev_dbg(nor->dev, "SR1: read back test failed\n");
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
+	} else if (nor->params.quad_enable) {
+		/*
+		 * If the Status Register 2 Read command (35h) is not
+		 * supported, we should at least be sure we don't
+		 * change the value of the SR2 Quad Enable bit.
+		 *
+		 * We can safely assume that when the Quad Enable method is
+		 * set, the value of the QE bit is one, as a consequence of the
+		 * nor->params.quad_enable() call.
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
+		dev_dbg(nor->dev, "CR: read back test failed\n");
 		return -EIO;
 	}
=20
@@ -983,6 +1055,23 @@ static int spi_nor_write_sr_and_check(struct spi_nor =
*nor, u8 status_new)
 }
=20
 /**
+ * spi_nor_write_sr_and_check() - Write the Status Register 1 and ensure t=
hat
+ * the byte written match the received value without affecting other bits =
in the
+ * Status Register 1 and 2.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * @sr1:	byte value to be written to the Status Register.
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
+/**
  * spi_nor_write_sr2() - Write the Status Register 2 using the
  * SPINOR_OP_WRSR2 (3eh) command.
  * @nor:	pointer to 'struct spi_nor'.
@@ -3634,19 +3723,38 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
+		/*
+		 * Writing only one byte to the Status Register has the
+		 * side-effect of clearing Status Register 2.
+		 */
 	case BFPT_DWORD15_QER_SR2_BIT1_NO_RD:
+		/*
+		 * Read Configuration Register (35h) instruction is not
+		 * supported.
+		 */
+		nor->flags |=3D SNOR_F_HAS_16BIT_SR | SNOR_F_NO_READ_CR;
 		params->quad_enable =3D spansion_no_read_cr_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR1_BIT6:
+		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
 		params->quad_enable =3D macronix_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT7:
+		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
 		params->quad_enable =3D sr2_bit7_quad_enable;
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
+
 		params->quad_enable =3D spansion_read_cr_quad_enable;
 		break;
=20
@@ -4613,6 +4721,8 @@ static void spi_nor_info_init_params(struct spi_nor *=
nor)
 	params->quad_enable =3D spansion_read_cr_quad_enable;
 	params->set_4byte =3D spansion_set_4byte;
 	params->setup =3D spi_nor_default_setup;
+	/* Default to 16-bit Write Status (01h) Command */
+	nor->flags |=3D SNOR_F_HAS_16BIT_SR;
=20
 	/* Set SPI NOR sizes. */
 	params->size =3D (u64)info->sector_size * info->n_sectors;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d1d736d3c8ab..d6ec55cc6d97 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -243,6 +243,9 @@ enum spi_nor_option_flags {
 	SNOR_F_4B_OPCODES	=3D BIT(6),
 	SNOR_F_HAS_4BAIT	=3D BIT(7),
 	SNOR_F_HAS_LOCK		=3D BIT(8),
+	SNOR_F_HAS_16BIT_SR	=3D BIT(9),
+	SNOR_F_NO_READ_CR	=3D BIT(10),
+
 };
=20
 /**
--=20
2.9.5

