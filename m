Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B369CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D8721929
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ksx0a45r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKBLYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:24:12 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:31081 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfKBLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:59 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: JdUGV/WMeuQGeQZkK9iYG/k22eE3WxE5SXsB6x1mpkM2L/d+DhOp5BYFcf2biEynHkpwrpurIv
 sY1cEf1k+A3rst/sB6uSNpoNoIxvvWG0hvwSCEypED0F5ePnYwkK17a4aweisVCaDtwQpj5LdF
 TFF/rg3G8hLwrkesbZK84uQWt/hrE5VwetsmvQ1DWxLfpIqQpjWaHj/2kepmF03o6Z+TQVD6/b
 swPXbpJkUHYZrCJMsAUeDjMYtFLhTDeXwNahwFvImUcMscjwZIAcYD4iJ8690iQ5mKruxkOrEl
 fBE=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53870323"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:57 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVDpkTh7UYUoWFKOH8I3bMD5Khyi+hQzHreftVEFBPi4k+AodSw+TbO70cqWK0cSxwbXv39x6cmIk7YjY4qIcZWY3iGwweKaVFETrzktQ2opSsa0J5Sdmt4n4PqxId5hAueW8rdw3VfQKZjF+5OUxoSqb4XvrpFr72VyHMyQ6e891hq5NLjIkoqfhlrTp+4lbAHCxbM5P6FvO9zHkxONrLJwrBRhWDHla3fStZavH/ipZbTgYAqZvBJIAY2VLt500+u1GmayK9XitOcI3z02ctl3h+7YuyBqnHuQfa6A9+lGnxCzWOaKbF5BNVZCGoSIRZPJgIn/pO1aCey5WzD1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9P054MaXSdfZyzciDQ9c6wsq1QayE5hk8eVcXStzco=;
 b=ak6aUsNe4f0VJbz+iFcHEmBlIVZAKwbnA0OddM/pDbF+9mortib4kdOyAtUaxLq7RRJkMfZ0zGd5UcbEyvg18Vhn58sBRa9CXHOcCfP0EjNToMgKaaga738NWe28GXCsdbSyNe68gWSFxcPXMsO3qZbaMEDRTNNfcih0xy1xuuwGFtgfDhn93mQ1dsrovjhFyj8oPolCm1wFGBdb+KACkOj36YmgApoHT/PC8EYm+iQmrc5FyybTBHrx+g+td3iiSbopayFsLvOC5LfnatYbYzm4RjMWveHAthbXnN/zsLWoZ/0mEFk0RwGdyeMeQ5YBFIEdXNTKNrlU4KuRPcYUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9P054MaXSdfZyzciDQ9c6wsq1QayE5hk8eVcXStzco=;
 b=Ksx0a45rWT3cssnmM0O1Npg1fvsQqV3CPHpC96NK6HqTH6qwkaMbLJg1FBWdichek1xAXoRcb5WkbE8uhZyQvwUahha0nGmpY17yh53Ft2Xb5oCFV0b5mYmlxqF0IFOB0UoUEWqm09MKIeuentkh1mWxyOaggmpMF/4U9DvD/Mg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:56 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 18/20] mtd: spi-nor: Rename macronix_quad_enable to
 spi_nor_sr1_bit6_quad_enable
Thread-Topic: [PATCH v4 18/20] mtd: spi-nor: Rename macronix_quad_enable to
 spi_nor_sr1_bit6_quad_enable
Thread-Index: AQHVkXADY6j1zfPLZU+XlaRtPvq+6A==
Date:   Sat, 2 Nov 2019 11:23:56 +0000
Message-ID: <20191102112316.20715-19-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: f59bb2b8-a19e-4d6d-b50a-08d75f87262c
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371152C2A10517ABD48BCDD8F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(136003)(346002)(376002)(396003)(39850400004)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(14444005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jg5805awfYoR8FdgomsTp2jy3ESHm6RJtBQf7Rxs94fuKpMQgdpXTdxpxYbv4mYLKga7Hlcp0vjm91XPHhbBN2h2bHyBlvLQxh9eZ2CXrGXUJmMreqCBT7tWpIWMmUoD2D5UhAkH596NE7x54CntZ3CMqjVTIVRdhIpFPL6511DFTc+SSpjV6uPtDF25C4R1GkK5QbJl29LgnMlu5Ccf/uPsgfPmLQK9XNQ0k0suX7per6CNH7Z/hO9VSon8ZFxsEQEZ1cDyUqSSgcHjx+23sHLSx6/XF3S/SG4MM00rVQh4tzsuT6oGI9EkFx7YgfO9n8jVZq4nRnzd6NkxTGhD6hqmpT9T9UmIxnlk0CRWntze9HZsTuR3DoJmeCBbkuZFuivp51yx1Jf8Sd/3iC0ArcdzcmXfN9XGzFrEFoJBZ5olfowtZGjaEAFCQ5WoLBWz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f59bb2b8-a19e-4d6d-b50a-08d75f87262c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:56.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Kw8DSlM0F71xJTab8Gegy9CqglxQv6DVZTYFH+K1FerutHWsuQ5VqGRLKLAo2Spnykr+3JkVf/pVkGraqCVikTE4LocZgxj/+ArTWnNJ+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rename method to a generic name: spi_nor_sr1_bit6_quad_enable().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 19 +++++++++----------
 include/linux/mtd/spi-nor.h   |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8bc29cc073a0..85e5a56fb2d7 100644
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
@@ -2349,7 +2348,7 @@ static void gd25q256_default_init(struct spi_nor *nor=
)
 	 * indicate the quad_enable method for this case, we need
 	 * to set it in the default_init fixup hook.
 	 */
-	nor->params.quad_enable =3D macronix_quad_enable;
+	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 }
=20
 static struct spi_nor_fixups gd25q256_fixups =3D {
@@ -3729,7 +3728,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
=20
 	case BFPT_DWORD15_QER_SR1_BIT6:
 		nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
-		params->quad_enable =3D macronix_quad_enable;
+		params->quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 		break;
=20
 	case BFPT_DWORD15_QER_SR2_BIT7:
@@ -4627,7 +4626,7 @@ static int spi_nor_setup(struct spi_nor *nor,
=20
 static void macronix_set_default_init(struct spi_nor *nor)
 {
-	nor->params.quad_enable =3D macronix_quad_enable;
+	nor->params.quad_enable =3D spi_nor_sr1_bit6_quad_enable;
 	nor->params.set_4byte =3D macronix_set_4byte;
 }
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f626e0e52909..6d703df97f13 100644
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

