Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7DDCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76923214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="sMzg35jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbfJ2LRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:54 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36194 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbfJ2LRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:48 -0400
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
IronPort-SDR: lkpmhJ9/5XzCYalZS3JKUv7jtb9t6eHjBf9vidbyeIo7V0fSV19soD9vRA645cquGmHT7MV900
 1zIyPUDjch5Z9/tZnaU5dYy7hFNRXs7tQdVtGJBa9507qRzCLUalFDJR+bItCXYRywzLJhAc5Q
 xUh2ukWFhpaFcaBUPLBwvu/TEBcu14SpE8hfkZHZoK9Wf6Bz9kI3Wry14tcd5jYAVuU1oSUord
 PgdfQAZbGnta0EePrXp6fVzjKD4+oaOfzu+i1IhmydexGCZLIkkd9G1a/RFUq17vCC9HDk3xEs
 lXs=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292172"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:35 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhKoMdAcHmCvUTbvxa6Mb1IXPZOvf9T9rA20zI270ftdrYeduCgAQdh6kVL/QaXslswW0vzEKN8lJSqRnz1MoI+LfO6bp6kBAxuFagMyXjCxn7XQ5jm0az43U5Krht0f9xHY1OBw/cCIKhXa+S4lFuOVuiIVu5M5QGOteR4LNuYr4y3PnokFlTz+G6gRRH4rDeL9L6SYyV9m/5hnlq+djbZZC6kJFXrtTmbpzk15Ib9wVtJYNoqZaEEgr7CEoKVYX/u3OIejR6fTFvg93fkGVJSvzCPes5g2aLZuGNu6bNoPmS9iemfaGTHkZFe0XF2c1BoD5eMgw9N6ZI4i3rqszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwXLhxL3WyVVhmnZPAoGLAXg2e4utuPFyWNpXqa+g/I=;
 b=feaZGVEreBaoDpRvGKJnEiZFJqa79+4W8GG3shV8y9sgp/bAqDG4f4bYESYcLar0b62mB0MNqqTIIV5dcXVgzk0dfNcajNdBtdcF3WMT18g15CRsf2rKMA6Znj6cNIJ45DqT07UKRNnsNoYRIiG1FFME0RjKJgc20/cCn1KnU0r8Gp4628/CP3V50b3AbiNJ9Nk24ctrrNgvmYKj6VUXNmxdpYOeG10rJf2BE2uQWCFWXcx6j2Puhb7NOIdS99WgOk9eLB0DuSx3fW4jzUjk+ft5hYIJzrhlK7D1Hz/t3oEReq2vFPkcieMexIUdJr+VESwkr2HapWaji6Q74zPVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwXLhxL3WyVVhmnZPAoGLAXg2e4utuPFyWNpXqa+g/I=;
 b=sMzg35jF+/smNEtiyQ5q0STuCxJY65+qqKaMRvnrlWv7iy3dxNSvf8Jgui4/439mDOrhRpeno35EoIrTcs1xGsUJOYywLJAPntyGM5Inzk/76MZGLlE+DIjyIz3tIwneCBA2yQ8AH30/HvG9XvsVYmbNgqdgtLDnNvetNtLNqEQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:34 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 28/32] mtd: spi-nor: Rename CR_QUAD_EN_SPAN to
 SR2_QUAD_EN_BIT1
Thread-Topic: [PATCH v3 28/32] mtd: spi-nor: Rename CR_QUAD_EN_SPAN to
 SR2_QUAD_EN_BIT1
Thread-Index: AQHVjkp26pJ1MWTLYUy7Qtu7L2cePw==
Date:   Tue, 29 Oct 2019 11:17:33 +0000
Message-ID: <20191029111615.3706-29-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 1795e557-28ab-462d-ca68-08d75c619891
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3712CD7F0F93753844296E5EF0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(11346002)(446003)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(26005)(99286004)(386003)(76176011)(52116002)(1076003)(102836004)(71200400001)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0invncgQH89jCx1k6JRnl02PGIozopkE5pbPzqAasgvv3vJBEx7VjYon+KyaKNbnPQncmFR3c+NFoGl1YH1ChM9PJrNiEvHUvao0kTNdY4Aglhnrztcv55Ozh2Q4+aCB4LOzUFMYUjESHDihk3iuY4hTsu7q45FENjCVPhXOma744RRelIkadsRt4tuFsr4uMEv+CO2iDdvreHpriNKCLksGKbjnm+YUWTQhVeXcMswZ/3ERNsm/o0BQoWmi4xPKMlIDgD5+D0i4KCg9FCQ87YyMbGQvtM8jT+3Pp9aFE1QWiwzn8JETw+9gbjdqbmhxpSlJegRCJaNvv00B63NnfTWQ+uu99CNYPNPsIg82TvTQqnXiBMtC2UJecLQFOgxb5Ev4jZYGtXdGLsDhEQFVBLpMSOUVXcmScnu5y03SO46Vqx4c669XMgvc7TQ4CH3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1795e557-28ab-462d-ca68-08d75c619891
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:33.9517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAW1WKrbHR9DnZKYydWT0wbUHNmqr4mZq9JRt+4bNFzc6DRVRUkL8c8cjq1xaHlIiAdWP1+lAoh6iSwKzUVyjmfvHV4XElabOgOGW6BH4ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

JEDEC Basic Flash Parameter Table, 15th DWORD, bits 22:20,
refers to this bit as "bit 1 of the status register 2".
Rename the macro accordingly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 10 +++++-----
 include/linux/mtd/spi-nor.h   |  4 +---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index eecbd161df25..1f7ccd80b8ed 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1026,7 +1026,7 @@ static int spi_nor_write_16bit_sr_and_check(struct sp=
i_nor *nor, u8 sr1)
 		 * Write Status (01h) command is available just for the cases
 		 * in which the QE bit is described in SR2 at BIT(1).
 		 */
-		sr_cr[1] =3D CR_QUAD_EN_SPAN;
+		sr_cr[1] =3D SR2_QUAD_EN_BIT1;
 	} else {
 		sr_cr[1] =3D 0;
 	}
@@ -2074,7 +2074,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
 	if (ret)
 		return ret;
=20
-	sr_cr[1] =3D CR_QUAD_EN_SPAN;
+	sr_cr[1] =3D SR2_QUAD_EN_BIT1;
=20
 	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
@@ -2118,10 +2118,10 @@ static int spansion_read_cr_quad_enable(struct spi_=
nor *nor)
 	if (ret)
 		return ret;
=20
-	if (sr_cr[1] & CR_QUAD_EN_SPAN)
+	if (sr_cr[1] & SR2_QUAD_EN_BIT1)
 		return 0;
=20
-	sr_cr[1] |=3D CR_QUAD_EN_SPAN;
+	sr_cr[1] |=3D SR2_QUAD_EN_BIT1;
=20
 	/* Keep the current value of the Status Register. */
 	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
@@ -2256,7 +2256,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
 	 * When the configuration register Quad Enable bit is one, only the
 	 * Write Status (01h) command with two data bytes may be used.
 	 */
-	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
+	if (sr_cr[1] & SR2_QUAD_EN_BIT1) {
 		ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
 		if (ret)
 			return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d6ec55cc6d97..f626e0e52909 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -144,10 +144,8 @@
 #define FSR_P_ERR		BIT(4)	/* Program operation status */
 #define FSR_PT_ERR		BIT(1)	/* Protection error bit */
=20
-/* Configuration Register bits. */
-#define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
-
 /* Status Register 2 bits. */
+#define SR2_QUAD_EN_BIT1	BIT(1)
 #define SR2_QUAD_EN_BIT7	BIT(7)
=20
 /* Supported SPI protocols */
--=20
2.9.5

