Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11010C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC714205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KNab1Tlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409338AbfIXHqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:22 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18373 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406024AbfIXHqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:20 -0400
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
IronPort-SDR: zb/k+oSHtr5P0TTMdH8fJU5ex8sFm6w3nfhHaLT0579x2y1iam2twBKmCRuO7FgnU8fYneUPYL
 fekTL72ylnLhSiQ+UEbQ2U0KBaU81W+9nfYzpN2DCT8B/+vjdxdlI9/nYoFZt/6co963walun7
 qJha9DykXv1RWVRt45RVc8moRVQC4ygmPTyQhB+JqDjPme3aDqcLFSHXx33H4rqwEyx+aiI0CV
 Jxer6WKMA6kaetWN4ntWQvwr0NdvG3hpYthaHl3RvXxiTJG5CHSGgfdwj8DcmNawFUjtQGvsqt
 r90=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="49066024"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:13 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwXINIzEMXj6ABAm2q8YhdqwcrR29zKX0zxex3/a7I0S5KBDrvdQ7ZIMDtEo7MJ2DnUd0+pkvgcs2keji33rzD3uofKlnrJXk5FmbQ82rQc50TdGihOaz1HH1xoxJjMtIJizF4RonfeQHAAMTF9QH/5sDmO9nF8rL7rGEVFG/K8Dd7uVszQ8wSvvdyJatlyL1SRrfRhfR0t22r6S3U0NZkOTbyyfhgQVnh3rZGZlGvjpVP2ii/BaD3ECe45Pu07XIGYDu9w08RgeM2YQKiGi38vTspa4YD6l+tTycEwfDB56K1TnHOEUMPVr8YgU+kQucNcfm/goLJHfBAy1k4ljew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah4m8qbOplFVF1mTbFMxOSWfMYHHblFYFN2vdDu33cU=;
 b=XUzzWewKjbF78OkSnYqBgmA/7Patkdx1JoUm3j9xf9NPhyVeXEasFcRACdZ3PQvaOxDX0HXqS5mUC4n37BrpczcUfvGobzboGdJw76CTd0LdwEc0yACFQGIGoJeMuwCK0OomGuUklhEOJ1MSq2H8cWLY7BzEFA8VcYKOaLn9RhIRObstcI3uO9S0ykgyYb9q0CpcbO/9WYqF+o41TzueQB7AIwtt6xK67J3GjYMYZjNViDcDgRjoxuaHJw2+3x8gzRk/9wIJ66VJHHVMtzGuFIe+2048CRRLZauJ40DZ+o8K6DAUkfU34G4OMFMpe6gdT8Xn3H90XfNEH0UbFKllow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah4m8qbOplFVF1mTbFMxOSWfMYHHblFYFN2vdDu33cU=;
 b=KNab1TlkilHL4eO/e1dwfia2K5+XSWM5oMRCpxTGU+by8T0yomu7GHA+vEXlW/GsQY0sDYm+98lbL3M14++XRBBTUTvxrIoZ4SEmvTCTtgnLKG/E6Z/7u+Cyp73w7sLGz2iEgoIQ/GOnNmgrfrb3g1nq7P3/aFo37CEFjkPh0OM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:12 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:12 +0000
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
Subject: [PATCH v2 06/22] mtd: spi-nor: Rework read_fsr()
Thread-Topic: [PATCH v2 06/22] mtd: spi-nor: Rework read_fsr()
Thread-Index: AQHVcqwiPDAQ/vcf40iCdD7mR7ncdA==
Date:   Tue, 24 Sep 2019 07:46:12 +0000
Message-ID: <20190924074533.6618-7-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: da4eb390-c5ad-4005-86ae-08d740c34512
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43195C20FB94B0B996B3142FF0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DsRi6M7mg9gfB50NH6IvmQqDsvhjGoVYrK8Qh8YmXzMwJxTTOOv+17+Q1poXyXgBFavw/MsMYQgaJFOXSXGyQJYTfjB+eFzbrXmUg3PGKoFVooLTsj/wsK1xoOAy7Ve/oOS+uEXOu/UfIcaNpKaCR4RSHRLYG8htzF25V5bKgTPHPveKMg0gCyl7uFUJeDxaI/GjGzAsLsfsfI0CvfyQlEszf9KXVhW1N2w+Sfq+RMVgZ8t5y8BqaCHArkBHag8LjlnAa8qHCr7vb259BCjMJFsPutO3iClUBNxtXPJJ1rTXK73pf0+bcOTqm5F8egPhoPpaaOZy4ot/8zEXqGT2TfLAtehfDEGMzhKm5NrT61MJGyXxLNjqCPM807y2uiLjlBpXwPiPfEuVRTQ3hK1sHode2fpJUfC5Ry7QbcgbD9c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: da4eb390-c5ad-4005-86ae-08d740c34512
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:12.1025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaISPBV33+nZoERXLaGjR4AASfS8PrkBliA2saKpJJmqwv0zk6CQ7IENcZpdJmxUyE5nL6SlcfoM8xM7s9LXEcTOSs/z+rGecGZOxCr92GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

static int read_fsr(struct spi_nor *nor)
becomes
static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)

The new function returns 0 on success and -errno otherwise.
We let the callers pass the pointer to the buffer where the
value of the Flag Status Register will be written. This way
we avoid the casts between int and u8, which can be confusing.

Prepend spi_nor_ to the function name, all functions should begin
with that.

S/pr_err/dev_err and drop duplicated dev_err in callers, in case the
function returns error.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 42 ++++++++++++++++++++++-----------------=
---
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index a23783641146..8cd1cadcb8b1 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -417,12 +417,15 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *s=
r)
 	return ret;
 }
=20
-/*
- * Read the flag status register, returning its value in the location
- * Return the status register value.
- * Returns negative if error occurred.
+/**
+ * spi_nor_read_fsr() - Read the Flag Status Register.
+ * @nor:	pointer to 'struct spi_nor'
+ * @fsr:	buffer where the value of the Flag Status Register will be
+ *		written.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int read_fsr(struct spi_nor *nor)
+static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 {
 	int ret;
=20
@@ -431,20 +434,18 @@ static int read_fsr(struct spi_nor *nor)
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_IN(1, fsr, 1));
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
 		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
-						    nor->bouncebuf, 1);
+						    fsr, 1);
 	}
=20
-	if (ret < 0) {
-		pr_err("error %d reading FSR\n", ret);
-		return ret;
-	}
+	if (ret)
+		dev_err(nor->dev, "error %d reading FSR\n", ret);
=20
-	return nor->bouncebuf[0];
+	return ret;
 }
=20
 /*
@@ -787,25 +788,26 @@ static int spi_nor_clear_fsr(struct spi_nor *nor)
=20
 static int spi_nor_fsr_ready(struct spi_nor *nor)
 {
-	int fsr =3D read_fsr(nor);
-	if (fsr < 0)
-		return fsr;
+	int ret =3D spi_nor_read_fsr(nor, &nor->bouncebuf[0]);
+
+	if (ret)
+		return ret;
=20
-	if (fsr & (FSR_E_ERR | FSR_P_ERR)) {
-		if (fsr & FSR_E_ERR)
+	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
+		if (nor->bouncebuf[0] & FSR_E_ERR)
 			dev_err(nor->dev, "Erase operation failed.\n");
 		else
 			dev_err(nor->dev, "Program operation failed.\n");
=20
-		if (fsr & FSR_PT_ERR)
+		if (nor->bouncebuf[0] & FSR_PT_ERR)
 			dev_err(nor->dev,
-			"Attempted to modify a protected sector.\n");
+				"Attempted to modify a protected sector.\n");
=20
 		spi_nor_clear_fsr(nor);
 		return -EIO;
 	}
=20
-	return fsr & FSR_READY;
+	return nor->bouncebuf[0] & FSR_READY;
 }
=20
 static int spi_nor_ready(struct spi_nor *nor)
--=20
2.9.5

