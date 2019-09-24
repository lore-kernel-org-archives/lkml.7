Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C7C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF03720673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ggji2e17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409381AbfIXHqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:33 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:29719 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409370AbfIXHqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:30 -0400
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
IronPort-SDR: Ic4vXQkrOu/3LaUB0nzGCURRGXRMNsPfpAGlsBtzrwSup1lZuKF2Eo8/fjgNasnuln4wqfCaQG
 FRV/mYq0yQVx2DBxm3bkPwECnl4UglRpjx3x1QuD3H6QNh2ZdnxES0dTzVMqrgBzxAH7phpisA
 c99tqLVHJzDJvu13/m/rR87xhZizxvnIgAT4DnsYwQmGLAf0PfY7bkyMzw6P24+wR8bJC7Dl/U
 8XlJVtm9/Z1Ip1mekoIQgXRjnFqc90l5oBZn56df2Bs8C0Xwtq4FyZ9xAeV/ONtplKYKNi477t
 Bp4=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="51606487"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:26 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqLhHdtVgAnVFbiED4ulixgMIrNudaG801nwuId1Ikr9qlekoilGofECMz8sGWMI/3YLuFvobOxv1M3nROb19GX6+TPFfWqEiinhh9jNu07UN+IfJJUbamAkw3Yz5nu6aMyfuisq0vZAq0CUTLowtPIm94HEnMh/HhdyAWw1L4ZQNpGcle6oTQX2QW7Q3RnPUT84e2MVxrisJjE85luMXNkbgRxDbLqNRdf8k5A98f2WJYuJJmNA07dTXznG1oIpPqcg6VUyJTZkR+4XYHEMe4ccyorVor8MNwJSIuBOABfTjthusQJq9pu26ixQR+zM+WtG5YZoOzTY9vSLDSluZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LfroKdQIZ8fXiCs0JFOsT6JY+CtZPoYZmCam2YXviE=;
 b=hl18m8hxvqXyEjDUksMA9HtlBqvbpQOPTf1rOkbnz5CL5Mexn+JOeaHofrnvxfpti3aaTgx+viEKqYJi3RNdyRHHvduDhsd38FWG5yP+VaeRVymuzJwP+StmyytNbhElLwuJJns0l8MpePEQpAkNhkUtfI8pVpJs4bxaBdgPp6dE+mk7W9r0mgUcU1oOoSlQbbXLOzBqWc86iYYAHXhdrGntMLflquOblNiCInDl7cCYUkikXwsL4BXDHhCXL5fjBdZwmTZGMYOdf3kDZwoceMNRmaH0VD5t8v6eYIHF0jTuNOZyfoy38NHhu+C4UOnmP/3FNkhT61Z6Bc950nFx2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LfroKdQIZ8fXiCs0JFOsT6JY+CtZPoYZmCam2YXviE=;
 b=ggji2e17u8CE+20Ymnyfb1O00zo9YIjt+NO44K0DsIrcFD76r1hAToXgq+G/jfh9o1DdLERiomH4Zrp1ZMsoIlKL5K8nG/1pDuvYpJ9RvkGXsbH219yPjVm56SeLkHdkEy7yB+V4OAfzytZGHOriEtUxhy61+oJ0qABvLDYmWcM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:25 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:25 +0000
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
Subject: [PATCH v2 10/22] mtd: spi-nor: Rework write_sr()
Thread-Topic: [PATCH v2 10/22] mtd: spi-nor: Rework write_sr()
Thread-Index: AQHVcqwqkYJhMgq/4EeXQwoXNBbOlA==
Date:   Tue, 24 Sep 2019 07:46:24 +0000
Message-ID: <20190924074533.6618-11-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 224ff5bd-aa92-4ac5-912a-08d740c34cd7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43199EAC13F04F957EF478C6F0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(14444005)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001)(30864003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MDVJ+iCl4dTOQD4VeTpZtCQyJPgCWpia2BgBrFTfgaaoQE6sjwMgVFgikLkQG/bDTsWSc/3quRrH6scDgzkJQwxAqfYA5PFks1c1aD+MyBVfzPV+DTsUqbU09xhyxF80U92JhSsKXC2syV/RBV4IkqtWoN0r2J30DjYFdyJSdBTkqeo/YDh4Vf8qP02iFzh+7NtlHa+/Gg3H18Vn7VP+tuAQpF7KxvlrxRbRT7iCMEpwm6arcr5VPfnKKCXQj5QPVe76tfEUHrX0njhssc+5XoldKLHfPMwheExOtzoIrwpnR4MNgLZ1Z7ii/U8LTff3FjoaBoS3uKy13pgOenyIMQ7CXQV9gd1X9c5AL8xB8EpGmAoXRLGe7F8SYa9hJOFNP6smrIEQGzp4cNBqPS5nB5uvQ6nqggKLfzk/dCyzEn4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 224ff5bd-aa92-4ac5-912a-08d740c34cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:25.0309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H018xMPIGUJ8oOQSGOF/Jn6Doe0cojctFEvsXhuxVJ9fDDSzeXo6Y3iaHc60cFBdtLMDuFuCz77mpjLzJtSIROkiUQsrO6YLahyiJTljbMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The Status Register can be written with one or two bytes.

Merge:
static int write_sr(struct spi_nor *nor, u8 val)
static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
into
static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)

Avoid duplicating code by moving the calls to spi_nor_write_enable() and
spi_nor_wait_till_ready() inside spi_nor_write_sr().

Move the spi_nor_wait_till_ready() together with the spi_nor_ready()
methods to avoid forward declarations.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 426 +++++++++++++++++++-------------------=
----
 1 file changed, 191 insertions(+), 235 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index be5dee622d51..31a4622d1eb9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -537,25 +537,198 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *=
cr)
 	return ret;
 }
=20
+static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_IN(1, sr, 1));
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
+}
+
+static int s3an_sr_ready(struct spi_nor *nor)
+{
+	int ret;
+
+	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
+		return ret;
+	}
+
+	return !!(nor->bouncebuf[0] & XSR_RDY);
+}
+
+static int spi_nor_clear_sr(struct spi_nor *nor)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+}
+
+static int spi_nor_sr_ready(struct spi_nor *nor)
+{
+	int ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+
+	if (ret)
+		return ret;
+
+	if (nor->flags & SNOR_F_USE_CLSR &&
+	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
+		if (nor->bouncebuf[0] & SR_E_ERR)
+			dev_err(nor->dev, "Erase Error occurred\n");
+		else
+			dev_err(nor->dev, "Programming Error occurred\n");
+
+		spi_nor_clear_sr(nor);
+		return -EIO;
+	}
+
+	return !(nor->bouncebuf[0] & SR_WIP);
+}
+
+static int spi_nor_clear_fsr(struct spi_nor *nor)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
+}
+
+static int spi_nor_fsr_ready(struct spi_nor *nor)
+{
+	int ret =3D spi_nor_read_fsr(nor, &nor->bouncebuf[0]);
+
+	if (ret)
+		return ret;
+
+	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
+		if (nor->bouncebuf[0] & FSR_E_ERR)
+			dev_err(nor->dev, "Erase operation failed.\n");
+		else
+			dev_err(nor->dev, "Program operation failed.\n");
+
+		if (nor->bouncebuf[0] & FSR_PT_ERR)
+			dev_err(nor->dev,
+				"Attempted to modify a protected sector.\n");
+
+		spi_nor_clear_fsr(nor);
+		return -EIO;
+	}
+
+	return nor->bouncebuf[0] & FSR_READY;
+}
+
+static int spi_nor_ready(struct spi_nor *nor)
+{
+	int sr, fsr;
+
+	if (nor->flags & SNOR_F_READY_XSR_RDY)
+		sr =3D s3an_sr_ready(nor);
+	else
+		sr =3D spi_nor_sr_ready(nor);
+	if (sr < 0)
+		return sr;
+	fsr =3D nor->flags & SNOR_F_USE_FSR ? spi_nor_fsr_ready(nor) : 1;
+	if (fsr < 0)
+		return fsr;
+	return sr && fsr;
+}
+
 /*
- * Write status register 1 byte
- * Returns negative if error occurred.
+ * Service routine to read status register until ready, or timeout occurs.
+ * Returns non-zero if error.
+ */
+static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
+						unsigned long timeout_jiffies)
+{
+	unsigned long deadline;
+	int timeout =3D 0, ret;
+
+	deadline =3D jiffies + timeout_jiffies;
+
+	while (!timeout) {
+		if (time_after_eq(jiffies, deadline))
+			timeout =3D 1;
+
+		ret =3D spi_nor_ready(nor);
+		if (ret < 0)
+			return ret;
+		if (ret)
+			return 0;
+
+		cond_resched();
+	}
+
+	dev_err(nor->dev, "flash operation timed out\n");
+
+	return -ETIMEDOUT;
+}
+
+static int spi_nor_wait_till_ready(struct spi_nor *nor)
+{
+	return spi_nor_wait_till_ready_with_timeout(nor,
+						    DEFAULT_READY_WAIT_JIFFIES);
+}
+
+/**
+ * spi_nor_write_sr() - Write the Status Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr:		buffer to write to the Status Register.
+ * @len:	number of bytes to write to the Status Register.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int write_sr(struct spi_nor *nor, u8 val)
+static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 {
-	nor->bouncebuf[0] =3D val;
+	int ret;
+
+	ret =3D spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
=20
-		return spi_mem_exec_op(nor->spimem, &op);
+		ret =3D spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
+						     sr, len);
 	}
=20
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-					      nor->bouncebuf, 1);
+	if (ret) {
+		dev_err(nor->dev, "error while writing Status Register\n");
+		return ret;
+	}
+
+	ret =3D spi_nor_wait_till_ready(nor);
+
+	return ret;
 }
=20
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
@@ -741,161 +914,6 @@ static int winbond_set_4byte(struct spi_nor *nor, boo=
l enable)
 	return ret;
 }
=20
-static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, sr, 1));
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
-}
-
-static int s3an_sr_ready(struct spi_nor *nor)
-{
-	int ret;
-
-	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
-	if (ret < 0) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
-		return ret;
-	}
-
-	return !!(nor->bouncebuf[0] & XSR_RDY);
-}
-
-static int spi_nor_clear_sr(struct spi_nor *nor)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
-}
-
-static int spi_nor_sr_ready(struct spi_nor *nor)
-{
-	int ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
-
-	if (ret)
-		return ret;
-
-	if (nor->flags & SNOR_F_USE_CLSR &&
-	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
-		if (nor->bouncebuf[0] & SR_E_ERR)
-			dev_err(nor->dev, "Erase Error occurred\n");
-		else
-			dev_err(nor->dev, "Programming Error occurred\n");
-
-		spi_nor_clear_sr(nor);
-		return -EIO;
-	}
-
-	return !(nor->bouncebuf[0] & SR_WIP);
-}
-
-static int spi_nor_clear_fsr(struct spi_nor *nor)
-{
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		return spi_mem_exec_op(nor->spimem, &op);
-	}
-
-	return nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
-}
-
-static int spi_nor_fsr_ready(struct spi_nor *nor)
-{
-	int ret =3D spi_nor_read_fsr(nor, &nor->bouncebuf[0]);
-
-	if (ret)
-		return ret;
-
-	if (nor->bouncebuf[0] & (FSR_E_ERR | FSR_P_ERR)) {
-		if (nor->bouncebuf[0] & FSR_E_ERR)
-			dev_err(nor->dev, "Erase operation failed.\n");
-		else
-			dev_err(nor->dev, "Program operation failed.\n");
-
-		if (nor->bouncebuf[0] & FSR_PT_ERR)
-			dev_err(nor->dev,
-				"Attempted to modify a protected sector.\n");
-
-		spi_nor_clear_fsr(nor);
-		return -EIO;
-	}
-
-	return nor->bouncebuf[0] & FSR_READY;
-}
-
-static int spi_nor_ready(struct spi_nor *nor)
-{
-	int sr, fsr;
-
-	if (nor->flags & SNOR_F_READY_XSR_RDY)
-		sr =3D s3an_sr_ready(nor);
-	else
-		sr =3D spi_nor_sr_ready(nor);
-	if (sr < 0)
-		return sr;
-	fsr =3D nor->flags & SNOR_F_USE_FSR ? spi_nor_fsr_ready(nor) : 1;
-	if (fsr < 0)
-		return fsr;
-	return sr && fsr;
-}
-
-/*
- * Service routine to read status register until ready, or timeout occurs.
- * Returns non-zero if error.
- */
-static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
-						unsigned long timeout_jiffies)
-{
-	unsigned long deadline;
-	int timeout =3D 0, ret;
-
-	deadline =3D jiffies + timeout_jiffies;
-
-	while (!timeout) {
-		if (time_after_eq(jiffies, deadline))
-			timeout =3D 1;
-
-		ret =3D spi_nor_ready(nor);
-		if (ret < 0)
-			return ret;
-		if (ret)
-			return 0;
-
-		cond_resched();
-	}
-
-	dev_err(nor->dev, "flash operation timed out\n");
-
-	return -ETIMEDOUT;
-}
-
-static int spi_nor_wait_till_ready(struct spi_nor *nor)
-{
-	return spi_nor_wait_till_ready_with_timeout(nor,
-						    DEFAULT_READY_WAIT_JIFFIES);
-}
-
 /*
  * Erase the whole flash memory
  *
@@ -1375,15 +1393,9 @@ static int write_sr_and_check(struct spi_nor *nor, u=
8 status_new, u8 mask)
 {
 	int ret;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	ret =3D write_sr(nor, status_new);
-	if (ret)
-		return ret;
+	nor->bouncebuf[0] =3D status_new;
=20
-	ret =3D spi_nor_wait_till_ready(nor);
+	ret =3D spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
 	if (ret)
 		return ret;
=20
@@ -1713,49 +1725,6 @@ static int spi_nor_is_locked(struct mtd_info *mtd, l=
off_t ofs, uint64_t len)
 	return ret;
 }
=20
-/*
- * Write status Register and configuration register with 2 bytes
- * The first byte will be written to the status register, while the
- * second byte will be written to the configuration register.
- * Return negative if error occurred.
- */
-static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
-{
-	int ret;
-
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op =3D
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(2, sr_cr, 1));
-
-		ret =3D spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret =3D nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr_cr, 2);
-	}
-
-	if (ret < 0) {
-		dev_err(nor->dev,
-			"error while writing configuration register\n");
-		return -EINVAL;
-	}
-
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret) {
-		dev_err(nor->dev,
-			"timeout while writing configuration register\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -1777,13 +1746,9 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
 		return 0;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
-
-	write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
+	nor->bouncebuf[0] |=3D SR_QUAD_EN_MX;
=20
-	ret =3D spi_nor_wait_till_ready(nor);
+	ret =3D spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
 	if (ret)
 		return ret;
=20
@@ -1830,7 +1795,7 @@ static int spansion_quad_enable(struct spi_nor *nor)
=20
 	sr_cr[0] =3D 0;
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
-	ret =3D write_sr_cr(nor, sr_cr);
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
 		return ret;
=20
@@ -1872,7 +1837,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
=20
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
=20
-	return write_sr_cr(nor, sr_cr);
+	return spi_nor_write_sr(nor, sr_cr, 2);
 }
=20
 /**
@@ -1908,7 +1873,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 	if (ret)
 		return ret;
=20
-	ret =3D write_sr_cr(nor, sr_cr);
+	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
 		return ret;
=20
@@ -2026,19 +1991,10 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	if (ret)
 		return ret;
=20
-	ret =3D spi_nor_write_enable(nor);
-	if (ret)
-		return ret;
+	nor->bouncebuf[0] &=3D mask;
=20
-	ret =3D write_sr(nor, nor->bouncebuf[0] & ~mask);
-	if (ret) {
-		dev_err(nor->dev, "write to status register failed\n");
-		return ret;
-	}
+	ret =3D spi_nor_write_sr(nor, &nor->bouncebuf[0], 1);
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		dev_err(nor->dev, "timeout while writing status register\n");
 	return ret;
 }
=20
@@ -2077,7 +2033,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
=20
 		sr_cr[0] &=3D ~mask;
=20
-		ret =3D write_sr_cr(nor, sr_cr);
+		ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 		if (ret)
 			dev_err(nor->dev, "16-bit write register failed\n");
 		return ret;
--=20
2.9.5

