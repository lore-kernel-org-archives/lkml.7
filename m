Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097BBC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF032214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="r2uP49bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfIQPzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:55:37 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23603 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbfIQPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:31 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: uMDpyttlFCL+8hYuDXQ6gI3yCcBkshfBfxDTHwZwCOVLXh5xTfGLW/HMsA6Sk9PSw5ZHSm02aN
 F4sm2Bf8Ga5FsHlQ/vOE8Z2Jt7H1nqDM582a3O5CS3zXHEfIlFveRxiIfV7X37SG2ykWG99lSX
 vayvma7RVMuhCJt/jNZtdRr2AGC0QtVc7HeLaYbRdEKc32bmyuJhVghCs8q7cK9u2QnF1OSlV/
 noM+yHJWNyNnvpYI1LrMY/t21wjH0pjU1JeqcJ/s9VAMcjHx1eiP+x8UWuYtCJx3kHg6XRQspq
 m7o=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="50797897"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:55:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:55:27 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:55:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWpXtRIPiveQyzUoV3zz9UcotWAJylQCpPJJOvHWiV1MFUOQaLRiRXHyIGZavcuqysxfEKEXJ5xunyZl6zMa7GFrmgNqMdHiFRWBWGPLxQxq+S8HXiiCpWXhiY4Xo0Bo4st1LFm8FO9o9GRx1VfT0zmSR571UZb6riXZsfv/NbI19HUEUxtUHZuUsxntK6Vb1UEjDltAUulhkPg7w17eVIeZviuuqtpKgRiLK+rI0WTmqgQBf8nkoXLlncRUvPeMRWoTg+KYxuDhinsHsuXfUXd0cusnZMJcvs1rq262OJlJILGo6Uao5p+/KobpoNwWJttVUOrwwNwUkhNLe1cEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC32JdAt86fa7oXSG6f0EqDhlEmzIFrJvA9LI5zuTPI=;
 b=CZnjaxPj2baF/FOrpKdjgDkY4+YJ+ZDTE/ZFNp3+bGH4rmKrIhu20bhJoTyq2wEHulFEz8fEoe3jB1UidkUJJi5JM8Cc6c1v04ZVRhOgwr87KP1B2g0kbk1YcSU5P7u0wkUaCM3BTOHsSAaKTO2MnP4+7qd75+Hb/ze9jlMLhh5KSFn1xUxjwGNXyj5ll9h0bnU00vB60LVf9HclnJ5Q1Zm1pxMbw6qdNt/rPZBPttCWQvRFI9eWBmEaienmC8F8meDRh03NMtrREnclMJWrkdqd3B+b7UVxS7eq94MpQd0EzZLtlBzWXHvIsmEgdtwtjV2eKTflkbhFDcOuAPaWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC32JdAt86fa7oXSG6f0EqDhlEmzIFrJvA9LI5zuTPI=;
 b=r2uP49bIePSxKFHO2kAj6MPO/8/hzxAhjtkkUpnUBVoz25KfU2spX3xbWoI69F3GjGQES1iD3QZVFL5XxVx7c/6uP7BxQPy7YKUVZelvwI4FDJoZ6Lo6SaIHhZLwLGvacVo3UjnLGPdIOn+hRZ7U9fkXGcpJOVseuERAT7ZCL/0=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:55:16 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:55:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 11/23] mtd: spi-nor: Rework spi_nor_read/write_sr2()
Thread-Topic: [PATCH 11/23] mtd: spi-nor: Rework spi_nor_read/write_sr2()
Thread-Index: AQHVbXBMGRFdS0Dx4UqQ4KTJNdCVXA==
Date:   Tue, 17 Sep 2019 15:55:16 +0000
Message-ID: <20190917155426.7432-12-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54e804e3-defb-468b-8759-08d73b876e91
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3984DB535FC3642415859105F08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(14444005)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(2906002)(446003)(52116002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uidy9oD4+KPaxmJIbXIxn4Yd5BekidyWNSsO7cczcs6YdOCr6Xv3SiN5NRvPHprQHr5L3VKfK/LZlIAuTuufptNkPdoYdWckb1CKyLKciozdnkXDt7MawKeVnTHCEWwWg94t3sz3ppHoDYXEB3zlcHPckDfjkIMUOHyLxLRc2keeTmchY75XvIDPtMk/IlX9bhDIqaWdTy+go7iM3oCJ/DOd3rgrpJ2NUOOlyFuoZKehv/fGRu9Q2twRZOuKIpMev089MBj+l0HzYrYohQZjqKI9EuAWZRWr7nKx61x5nwAyx56qQjUhF/0m/SOMrU49S736dSLUfpqJ0bK03GFo8gqRfoqCKtGNks7ysqWKNFMfDsMdPdcEu6aW46x/2AKWxSpxc7lm83X4XaSPetiDSxZJhdDqwVwkx4K10+4DncU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e804e3-defb-468b-8759-08d73b876e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:55:16.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNGAP3C5tHlTsJG6LxXmPAtmkUXxgtp8G5P5cpE36eFAuavi1NrqZHvEhUCHEKUFJ+Eo/20I27x80PQy9YKNJLLvo0L9x8gPGLUiqOaYlbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Move the methods up in the file, where the other Register
operations reside.

The error is reported inside each SR2 function, to spare the callers
of duplicating code.

Constify sr2 in spi_nor_write_sr2(). Do the spi_nor_write_enable() and
spi_nor_wait_till_ready() inside spi_nor_write_sr2(), as the
spi_nor_write_sr() does.

While modyfing sr2_bit7_quad_enable(), add a new line for better code
readability.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 118 ++++++++++++++++++++++++++------------=
----
 1 file changed, 74 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 89800bbaa179..c06de7ad6434 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -731,6 +731,74 @@ static int spi_nor_write_sr(struct spi_nor *nor, const=
 u8 *sr, size_t len)
 	return ret;
 }
=20
+/**
+ * spi_nor_write_sr2() - Write the Status Register 2 using the
+ * SPINOR_OP_WRSR2 (3eh) command.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr2:	buffer to write to the Status Register.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
+{
+	int ret;
+
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
+
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
+						     sr2, 1);
+	}
+
+	if (ret)
+		dev_err(nor->dev, "error while writing Status Register 2\n");
+
+	ret =3D spi_nor_wait_till_ready(nor);
+
+	return ret;
+}
+
+/**
+ * spi_nor_read_sr2() - Read the Status Register 2 using the
+ * SPINOR_OP_RDSR2 (3fh) command.
+ * @nor:	pointer to 'struct spi_nor'
+ * @sr2:	buffer where the value of the Status Register will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
+
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
+						    sr2, 1);
+	}
+
+	if (ret)
+		dev_err(nor->dev, "error while reading Status Register 2\n");
+
+	return ret;
+}
+
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
@@ -1890,36 +1958,6 @@ static int spansion_read_cr_quad_enable(struct spi_n=
or *nor)
 	return 0;
 }
=20
-static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
-}
-
-static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
-}
-
 /**
  * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
  * @nor:	pointer to a 'struct spi_nor'
@@ -1941,31 +1979,23 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor=
)
 	ret =3D spi_nor_read_sr2(nor, sr2);
 	if (ret)
 		return ret;
+
 	if (*sr2 & SR2_QUAD_EN_BIT7)
 		return 0;
=20
 	/* Update the Quad Enable bit. */
 	*sr2 |=3D SR2_QUAD_EN_BIT7;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
 	ret =3D spi_nor_write_sr2(nor, sr2);
-	if (ret < 0) {
-		dev_err(nor->dev, "error while writing status register 2\n");
-		return -EINVAL;
-	}
-
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret < 0) {
-		dev_err(nor->dev, "timeout while writing status register 2\n");
+	if (ret)
 		return ret;
-	}
=20
 	/* Read back and check it. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
-	if (!(ret > 0 && (*sr2 & SR2_QUAD_EN_BIT7))) {
+	if (ret)
+		return ret;
+
+	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
 		dev_err(nor->dev, "SR2 Quad bit not set\n");
 		return -EINVAL;
 	}
--=20
2.9.5

