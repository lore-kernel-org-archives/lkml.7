Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D76AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10F9214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HzZyp2tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409405AbfIXHqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:40 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:29769 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409394AbfIXHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:38 -0400
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
IronPort-SDR: SiyliYSjsFYsCgmOqnFs4IDQwwbOsKxw8nGFQ4SYTtTK1CXrjIrlx4H66blz3YKSI8ktY/4nuh
 O5h5HhfZ5Ix9pAeSu0wlAvF4uc5OB0wQr4FV1nbfTenrBdcL888LlAleYcT5/oveBZYUa5D24k
 /bAIK3CNcEU8ziHBfskGhfR0P2bTyKj9gnXW0PY8K4hxeAmSl1XQTrWWIkUgZHmi2Hlq2Dyt4r
 rF8EPqueIwbrMQFLO0FEzblixApl4KoYMlryRxyszqivMCWj1ZlQ91TfsnzKTqRd33dXqYMqpO
 CUQ=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="51606529"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:31 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Sep 2019 00:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myXiIUbvSQDBICrM8A+QGJa6O306se/i4l88c+BqEviVsU3uzcNxxCgrrjGvYB3jcxYJr/7oNX5Q485VAAWDQzE2Set1L7iPV7c92GLtaBNUKFgDpFCY0rfrPnw+yr/+fS287lmY7PKQ+bR3RJ508e1E82tJm0w5T1mURIcnmGv/s9jV0c0IPao7q2F31Mc1EKpj+qoMF80g/H7oYl3COFhfgvLsXrNwhVueDtzkgVzQzqGDxEJFyjdxIhLSNsh5ntrYAmAMkis9jRGBJc+z5ZX5KEQrIo7yW0t7r64Wj9Lb8Trag1PTKwPHiUNzYiIMa5gfZIfts2HdHytohD/+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP0sP98Sf2HxaEgnnEQ69H4ar7RhoPr/39cIaFuAF6s=;
 b=IV9OHLqwo5l3JU411wiJqk/KGv05JnTZMsxtUtQ07OFFyYznH0ncDrq+i4U1uSF5fndbMu3uXcE+M3uxmaidISudY8mDTsezQwLo6ZHtS+kdmrq30484g8RlNFOuQZnkAAshXkrKW5ZwZuU7TEiqgZ2kjWt0kdNKiTtPJPdktv7Tk7SibNktD31c0+7/hO8g/tJQZmE/BhH1zvpHKGrxMzhTynL6ovkfb2oFfafooTE5MfjBhv3N56s4sQsfKQNHJSJvpRGyOxB+wrQcwNuWNURa3Hku1NqZcWHMC14oXeFWplDhOBy0DlWK45agISKsJizKqVLZ6ia5fsUXihV5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP0sP98Sf2HxaEgnnEQ69H4ar7RhoPr/39cIaFuAF6s=;
 b=HzZyp2twRzlFX/6E9WGiRRjOOjBQjzNlFyO6xQG0K7LvD3Zvb4OdfO3QwAAoyhzQWVZCzfWlGpJgK8mxwrZSGnEEgfjcX3wCihNLWEFAmOjHTR22odhEvqgOcZ1T8nItOCfi8di9ToXKVlwFyI6H3Ap5BPLAIg0c2EAsLF6srDg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:29 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:29 +0000
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
Subject: [PATCH v2 11/22] mtd: spi-nor: Rework spi_nor_read/write_sr2()
Thread-Topic: [PATCH v2 11/22] mtd: spi-nor: Rework spi_nor_read/write_sr2()
Thread-Index: AQHVcqws4BSMXyqrs0alxYsMfkKjqA==
Date:   Tue, 24 Sep 2019 07:46:28 +0000
Message-ID: <20190924074533.6618-12-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: e3155a01-5dbc-4778-2200-08d740c34ed6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4319253EBCCB7CB22CC32444F0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(14444005)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AUvf3hrlVxL3dS/MTWM5C2nJHwWQcnh2WKE+jLgJw0a4ZOrqo7Dk0mdMWq99l1Nf0ai9tj2ig+ICnpRUEdaz+aF3OZL5P/okQXDG1i51AbSdhrr574eMaVOLS4hWwuWKQ+2I86Z3XW3gIiNKs3xBDSiaUVpqUzsuk/JYGUytyoGcduJ3vme1epCI7wWupvVbct/nBRqQ+k/K1yJDIR7aXM5jqVNGP0Dio2vDELGDcP8JjB8EZXFvEpEJYcxceSqXJNk768Lks9OsW9bh1lzvf57XcN2d1ah5oUh185doIiPhL56d9a/wOzBJv8uMW+whF8wNxZTAvxAVzn/YnBRP1Fkf3EgQHYKCmtjqrZcFdppSE1/Y4kwGbzNbsCgWYzKwQNWM1P6M6ckGZKoG0bz4fwfxoQNnrby6nya6hsxZc/A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3155a01-5dbc-4778-2200-08d740c34ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:28.7048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9GnJMsxFXWq8/IdftvEkJqN9khyNY3I0ZVPwEg2J/u02R8TCKk+adZBr4zGp9SN3ROGpi0MHh7pQbln2mmitXEHxQvn04UDWiWB9H1D7fQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
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
index 31a4622d1eb9..33130ee84164 100644
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

