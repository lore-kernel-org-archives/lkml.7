Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74647CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3454C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RRA/SXC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfJ2LSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:18:06 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7499 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbfJ2LRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:51 -0400
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
IronPort-SDR: iCha2jbw5kEt28OWy9nRbVfJAXxFLHjGnCUpfXF3RmAC5IYPu08SUjWXJlT0qnQ31gR0LvnvS8
 AreW/OTCdwwY1aCH3afjEPKeCum4IlcisZMKZnG1DzgTg/xAIWAzMvozameYK5u/FxGqbU1+G7
 fmvmGeBveXqtzRI6G6B86yMR/p5rHBtAcDiZeN6KBeyMFOFLswlMFf4Hq7wCX9cIHVpZdu6nd+
 X88SwEnly1TEee8vR9oyuE+EkkQM4LLtpJukSPzNuESWIROdF0ETPwyvbi4kALqiwL1kjvT0rg
 z64=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="54794610"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:37 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tsli+PpRnH4rKWc9o9R1keO2d2bHWcA4pdjGd7rRNYRDDTHEYU9NFN+Zh4SaToVXeLv2oLRb9r1kTTYz0N99FSOTNtbcRH/0A4gbaAnUNbgyiXcKUNZqEizkhe2PqpbNt14lsO7ivNkcQH70OaN8RXrTqTw8ey2ygI5WCRyJ4rJoiKY0WNgWAZ3YVuyW0BkYD0fgtGGf/iTb248SMOpwLZfdCOh8v3VWgJ8ElPg/OQlPfJtU7YkBIbhTLg0SoFDWE35+zNMTzktY6MyF8KwxvlWL8QvL6wI6f7h7IsfBdz8fwlmHbjZIgJ68boIXhc9oHkIh0w9+24874pBqQCvczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxtrFvhP6uoNSqBI0GhGlRh3b5CR0jY7mt/+a7V40PA=;
 b=nqCdEQpCRKMfE2q/Zj9YWoFs8jHte5/d6+etcehCXU6pBsfx5T8MTNB1R6gjO65aAIaOSoaQKmvAnj8hD9AHD8NPrSh31hQNOS8XLZg5gEbjb91BGmF/WdX0LFZBOejpJOJ0a7zpTj3/PqVTnmPD9B8yhRnJSzgAYF3ZBlVMCIFxXXK74SuaIMPGHjFDaFRGdwmRuSafU5lifbEUJZc5T829V5DULASZr+0wszlcci06oNM+ehPGWHrriRR4fJf3/aQUHjZppg9iUURH6ypefijTSOPlt3EzRyMTiC4XCRVCkOlHKIBeKbT/JtQetEdwwc7a42OeycjuFbq+7VWaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxtrFvhP6uoNSqBI0GhGlRh3b5CR0jY7mt/+a7V40PA=;
 b=RRA/SXC1foKU22wsJSB7FN0kycE9Vunbeeirmvm/D29ZfI61WLsLxT+kbQu5snyrcaUUFHybTjdtWRoy4PAG7qiiDur4bTRvhI7Rm3Ry48hSv9boW1m7G6vj0tLMCmLBVJB3Ecb/rWze3aNq4YUKZWnwY7/i8m1kjGNgwo9OSuI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:35 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 29/32] mtd: spi-nor: Merge spansion Quad Enable methods
Thread-Topic: [PATCH v3 29/32] mtd: spi-nor: Merge spansion Quad Enable
 methods
Thread-Index: AQHVjkp3lnwsMoAClkS5KjFD3sxgZQ==
Date:   Tue, 29 Oct 2019 11:17:35 +0000
Message-ID: <20191029111615.3706-30-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [83.166.207.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d2517e6-c5e4-4c3b-01fe-08d75c619990
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371254DEF426439287AFB18BF0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(11346002)(446003)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(26005)(99286004)(386003)(76176011)(52116002)(1076003)(102836004)(71200400001)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GVPAQeveUgVzNV+d435PIG31am3YPeJt+zznvDi58GUjAOOIN3VEm4zVCSbI3fqdfKweBaiAvyT28s6XntURykBR4DFj1haOWIspR4c3Lk5fRJuO4Dduv8HVxEORvoAuFBXWEWzr9LakAOG7d6t9DSJ7E7uGCcaQOoOxgvHACkqAfuFkbnNSlx9cRQL3kTG9++m2rf+LCgl6FKJkuDX0fGXFlTxvFzCIIxQdu4YCkmQx+oxDSftVMNUwbvEuTNLXZiPVqTJWyAX6QV+4bgZLOHJemJg5dHwfOK25F1C0ttO/d33yvYA3HAANWXqgLeTHcQb4BcL2+9o61XBng8vm93dXc5Nwt5v4RtY+BKrLYBh3MNjPJKq7Pa8y0AVhKD0VYc9arwQwviDj8CNPBbBf3/miz6NP27/+X38siQOr5l5hrsULjlvHlqxk0LpT3Zo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2517e6-c5e4-4c3b-01fe-08d75c619990
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:35.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6dacZyPpHraXwU6MRbUZehwBOfidE5vCi09jAVJtKYmm6aJ+kUx7B8YNJpl2CQkYXbFRG5TtQ+eL7V5HXhdYeHWqkpjN19fMjBJOLhHsow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Merge
    spansion_no_read_cr_quad_enable()
    spansion_read_cr_quad_enable()
into
    spi_nor_sr2_bit1_quad_enable().

Reduce code duplication by introducing spi_nor_write_16bit_cr_and_check().
The Configuration Register contains bits that can be updated in future:
FREEZE, CMP. Provide a generic method that allows updating all bits
of the Configuration Register.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 165 +++++++++++++++++---------------------=
----
 1 file changed, 68 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1f7ccd80b8ed..ab028afc503f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1055,6 +1055,59 @@ static int spi_nor_write_16bit_sr_and_check(struct s=
pi_nor *nor, u8 sr1)
 }
=20
 /**
+ * spi_nor_write_16bit_cr_and_check() - Write the Status Register 1 and th=
e
+ * Configuration Register in one shot. Ensure that the byte written in the
+ * Configuration Register match the received value, and that the 16-bit Wr=
ite
+ * did not affect what was already in the Status Register 1.
+ * @nor:	pointer to a 'struct spi_nor'.
+ * @cr:		byte value to be written to the Configuration Register.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr)
+{
+	int ret;
+	u8 *sr_cr =3D nor->bouncebuf;
+	u8 sr_written;
+
+	/* Keep the current value of the Status Register 1. */
+	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
+	if (ret)
+		return ret;
+
+	sr_cr[1] =3D cr;
+
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
+	if (ret)
+		return ret;
+
+	sr_written =3D sr_cr[0];
+
+	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
+	if (ret)
+		return ret;
+
+	if (sr_written !=3D sr_cr[0]) {
+		dev_err(nor->dev, "SR1: Read back test failed\n");
+		return -EIO;
+	}
+
+	if (nor->flags & SNOR_F_NO_READ_CR)
+		return 0;
+
+	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	if (ret)
+		return ret;
+
+	if (cr !=3D sr_cr[1]) {
+		dev_err(nor->dev, "CR: read back test failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
  * spi_nor_write_sr_and_check() - Write the Status Register 1 and ensure t=
hat
  * the byte written match the received value without affecting other bits =
in the
  * Status Register 1 and 2.
@@ -2051,111 +2104,29 @@ static int macronix_quad_enable(struct spi_nor *no=
r)
 }
=20
 /**
- * spansion_no_read_cr_quad_enable() - set QE bit in Configuration Registe=
r.
- * @nor:	pointer to a 'struct spi_nor'
+ * spi_nor_sr2_bit1_quad_enable() - set the Quad Enable BIT(1) in the Stat=
us
+ * Register 2.
+ * @nor:       pointer to a 'struct spi_nor'.
  *
- * Set the Quad Enable (QE) bit in the Configuration Register.
- * This function should be used with QSPI memories not supporting the Read
- * Configuration Register (35h) instruction.
- *
- * bit 1 of the Configuration Register is the QE bit for Spansion like QSP=
I
- * memories.
+ * Bit 1 of the Status Register 2 is the QE bit for Spansion like QSPI mem=
ories.
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spansion_no_read_cr_quad_enable(struct spi_nor *nor)
+static int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor)
 {
-	u8 *sr_cr =3D nor->bouncebuf;
 	int ret;
-	u8 sr_written;
-
-	/* Keep the current value of the Status Register. */
-	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
-	if (ret)
-		return ret;
-
-	sr_cr[1] =3D SR2_QUAD_EN_BIT1;
-
-	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
-	if (ret)
-		return ret;
=20
-	sr_written =3D sr_cr[0];
-
-	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
-	if (ret)
-		return ret;
-
-	if (sr_cr[0] !=3D sr_written) {
-		dev_err(nor->dev, "SR1: Read back test failed\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/**
- * spansion_read_cr_quad_enable() - set QE bit in Configuration Register.
- * @nor:	pointer to a 'struct spi_nor'
- *
- * Set the Quad Enable (QE) bit in the Configuration Register.
- * This function should be used with QSPI memories supporting the Read
- * Configuration Register (35h) instruction.
- *
- * bit 1 of the Configuration Register is the QE bit for Spansion like QSP=
I
- * memories.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int spansion_read_cr_quad_enable(struct spi_nor *nor)
-{
-	u8 *sr_cr =3D nor->bouncebuf;
-	int ret;
-	u8 sr_written;
+	if (nor->flags & SNOR_F_NO_READ_CR)
+		return spi_nor_write_16bit_cr_and_check(nor, SR2_QUAD_EN_BIT1);
=20
-	/* Check current Quad Enable bit value. */
-	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
+	ret =3D spi_nor_read_cr(nor, &nor->bouncebuf[0]);
 	if (ret)
 		return ret;
=20
-	if (sr_cr[1] & SR2_QUAD_EN_BIT1)
+	if (nor->bouncebuf[0] & SR2_QUAD_EN_BIT1)
 		return 0;
=20
-	sr_cr[1] |=3D SR2_QUAD_EN_BIT1;
-
-	/* Keep the current value of the Status Register. */
-	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
-	if (ret)
-		return ret;
-
-	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
-	if (ret)
-		return ret;
-
-	sr_written =3D sr_cr[0];
-
-	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
-	if (ret)
-		return ret;
-
-	if (sr_written !=3D sr_cr[0]) {
-		dev_err(nor->dev, "SR1: Read back test failed\n");
-		return -EIO;
-	}
-
-	sr_written =3D sr_cr[1];
-
-	/* Read back and check it. */
-	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
-	if (ret)
-		return ret;
-
-	if (sr_cr[1] !=3D sr_written) {
-		dev_err(nor->dev, "SR2: Read back test failed\n");
-		return -EIO;
-	}
-
-	return 0;
+	return spi_nor_write_16bit_cr_and_check(nor, nor->bouncebuf[0]);
 }
=20
 /**
@@ -2235,7 +2206,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
  *
  * Read-modify-write function that clears the Block Protection bits from t=
he
  * Status Register without affecting other bits. The function is tightly
- * coupled with the spansion_read_cr_quad_enable() function. Both assume t=
hat
+ * coupled with the spi_nor_sr2_bit1_quad_enable() function. Both assume t=
hat
  * the Write Register with 16 bits, together with the Read Configuration
  * Register (35h) instructions are supported.
  *
@@ -3753,7 +3724,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		 * supported.
 		 */
 		nor->flags |=3D SNOR_F_HAS_16BIT_SR | SNOR_F_NO_READ_CR;
-		params->quad_enable =3D spansion_no_read_cr_quad_enable;
+		params->quad_enable =3D spi_nor_sr2_bit1_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR1_BIT6:
@@ -3775,7 +3746,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		 */
 		nor->flags |=3D SNOR_F_HAS_16BIT_SR;
=20
-		params->quad_enable =3D spansion_read_cr_quad_enable;
+		params->quad_enable =3D spi_nor_sr2_bit1_quad_enable;
 		break;
=20
 	default:
@@ -4738,7 +4709,7 @@ static void spi_nor_info_init_params(struct spi_nor *=
nor)
 	u8 i, erase_mask;
=20
 	/* Initialize legacy flash parameters and settings. */
-	params->quad_enable =3D spansion_read_cr_quad_enable;
+	params->quad_enable =3D spi_nor_sr2_bit1_quad_enable;
 	params->set_4byte =3D spansion_set_4byte;
 	params->setup =3D spi_nor_default_setup;
 	/* Default to 16-bit Write Status (01h) Command */
@@ -4955,7 +4926,7 @@ static int spi_nor_init(struct spi_nor *nor)
 	int err;
=20
 	if (nor->clear_sr_bp) {
-		if (nor->params.quad_enable =3D=3D spansion_read_cr_quad_enable)
+		if (nor->params.quad_enable =3D=3D spi_nor_sr2_bit1_quad_enable)
 			nor->clear_sr_bp =3D spi_nor_spansion_clear_sr_bp;
=20
 		err =3D nor->clear_sr_bp(nor);
--=20
2.9.5

