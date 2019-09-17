Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F256AC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53E6214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gX/cBEgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfIQPzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:55:07 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7994 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbfIQPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:06 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: d+Nc2Rulb06OY5N7NaceS0zZVULDyE7EJlRxgqq5CNd9m9vjQvJhz1gT6AMfOVCqBwcq2T98nO
 C6mMu+xB98BWUXDMCpdnPFr33HRn7P8zHKO2P1nrJ7s011wyt+xJnn3CRCWNqnDgorhU5ZcVpG
 7l2a5/6EUPzQiD2ci1MjOCUaLL1ZP5PUOFex068HSkeAJuKzLI4gWlv+hO4x8cDCJP3wRXi4IC
 jYiu3n1T1F11QOFF1LX8LeYT5chjzz3pdC3WLS+A6w4EZ7jpzecSoiVY1Ae+ApkbqYLtB2EWCV
 ECw=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="46517547"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:54:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:54:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqQxZTmibgPsTNpRC+v4ZVVqC1BLxY4Qr/HBulqkOXCIcWruACJyQzlrIN+jptTUIfMe+qDSuVwMZ8L7bnkmcTaBVjH6untAvZoZ3DFIrhrA0rlztVGgf+KMoWK5SkJ48t0C5MyusToW3cTgdDcoyc9GvX71nBKm+IgtEnoA2GYBRwbnGYQzXV6viaf3Ru1dlkTMRh7se44ws4+oasmCKJVNDqYBOmIAywFnPjNs2xSyC+jC+eBnqLKKqJMR880+aWrLRIW5aaETNdT+zY+DY6SXc34tMQsKycg8HdjOg6pYjRsJKAWbyBGUbwBSCVUL0994JLan/yGuV1glQRZFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VDCyvHSOv9P80Ue/P+4wVsE5m6IE5589YJSUDfOwAU=;
 b=FrmjbVxsTw26e+PUqgF0JffkiJ8zCqJwjP6stmPYFTDL2Zns1kGT8j9HHOMRGHPQCEJ8yLqBuZNqPvSwN1+dScQ+u5shzsn+uVJElMmWU5ZL0rg3rEAS4yUK4JgU5XN4773EbASlgc53m1ppp9rcC1QdReoOnl6Bz2v+cHq4RUpjYyPsvyZ3SInp5e9lHqV3pKnrdKYMO+O2VPZPHWU8dLPJXwHGDcgrslnuK/Aqxpz/CR2+A0O+jzERPKb2DBe5jtFBO5T0hpQQKpSZbp8ZiDu/i7qZIpXC/Mjn3M7jX69f7HA95klzO0Fbyl+kZflC8shddcHDWnkYDFqJ4qTUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VDCyvHSOv9P80Ue/P+4wVsE5m6IE5589YJSUDfOwAU=;
 b=gX/cBEgRaidi1JUtFuD3tsoroAyCifHGDAoc48Rh+v+yAwglAGLzYYGd55RmKmRve4P1WruMg0AT+UL+goj4igvMbVJrvyf8awK/EjYasSaXkWSzy0/aSGNAo9Zq8BbxiOw/bKJ8pB8bxkJxvzngCZKGZ8B4Sms2nKtFjwUn12s=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:54:57 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:54:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 05/23] mtd: spi-nor: Rework read_sr()
Thread-Topic: [PATCH 05/23] mtd: spi-nor: Rework read_sr()
Thread-Index: AQHVbXBAM2cW12dHpUWRC4uQkzuNdQ==
Date:   Tue, 17 Sep 2019 15:54:56 +0000
Message-ID: <20190917155426.7432-6-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 1046d67f-ebe4-4dd8-e2f6-08d73b87632f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB398486E49FE54B9DF40DF65BF08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(14444005)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(2906002)(446003)(52116002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U22JuMRKgU73ZILGx11OeUIc+4mI3v6G5f7Uf68oN+X5/3sTo/rMPyHa74yE8dQzbCiuJvxlpPK2m2ucJYaHNjY7ycXi1rogPHcwjbJD8eu+efCopyGCjPSytkyDbGz2AGFdshcRLDASy4IivZ/V6OA9Mhin9ojs6X9BYxoo38ATyTDc8PnG01hZugRXpSABE/xqOq0bSJV6gei+Cqb9ef417Bl+1u+Nz2BkKU5As89HFwtuoxg5s82jtMC6a8FfK157CVOtLghJvdYMfVKVu4QrSB1QiETEDyP0uxMo54v1BwtBnnKg6AcXt46JNJkl/WdaCxEGri5D1qFnwg/EysqmrNZdJmABi4Bsbg6oBTF3pe7Zc1tG7YDhYIhIRsTxUNwaaNZrfYodOGmDa7mGVQPcGe7ljTnMwpT0AKKrXmM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1046d67f-ebe4-4dd8-e2f6-08d73b87632f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:54:56.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWpRo6XhAfaj5ejm4OyB1orL3mnzz5Zf54NBCKwgP6djyQ04yV3SvnUGS3XFPQoWn6Bl9m92ulE8hOYcdAiIRmDXuswBaRJOAxT8D9SCUjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

static int read_sr(struct spi_nor *nor)
becomes
static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)

The new function returns 0 on success and -errno otherwise.
We let the callers pass the pointer to the buffer where the
value of the Status Register will be written. This way we avoid
the casts between int and u8, which can be confusing.

Prepend spi_nor_ to the function name, all functions should begin
with that.

S/pr_err/dev_err and drop duplicated dev_err in callers, in case the
function returns error.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 131 +++++++++++++++++++++-----------------=
----
 1 file changed, 65 insertions(+), 66 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7d0c1b598250..a23783641146 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -388,12 +388,14 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor=
, loff_t to, size_t len,
 	return nor->controller_ops->write(nor, to, len, buf);
 }
=20
-/*
- * Read the status register, returning its value in the location
- * Return the status register value.
- * Returns negative if error occurred.
+/**
+ * spi_nor_read_sr() - Read the Status Register.
+ * @nor:        pointer to 'struct spi_nor'
+ * @sr:		buffer where the value of the Status Register will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
-static int read_sr(struct spi_nor *nor)
+static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 {
 	int ret;
=20
@@ -402,20 +404,17 @@ static int read_sr(struct spi_nor *nor)
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_IN(1, sr, 1));
=20
 		ret =3D spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
-						    nor->bouncebuf, 1);
+		ret =3D nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR, sr, 1);
 	}
=20
-	if (ret < 0) {
-		pr_err("error %d reading SR\n", (int) ret);
-		return ret;
-	}
+	if (ret)
+		dev_err(nor->dev, "error %d reading SR\n", ret);
=20
-	return nor->bouncebuf[0];
+	return ret;
 }
=20
 /*
@@ -752,12 +751,14 @@ static int spi_nor_clear_sr(struct spi_nor *nor)
=20
 static int spi_nor_sr_ready(struct spi_nor *nor)
 {
-	int sr =3D read_sr(nor);
-	if (sr < 0)
-		return sr;
+	int ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+
+	if (ret)
+		return ret;
=20
-	if (nor->flags & SNOR_F_USE_CLSR && sr & (SR_E_ERR | SR_P_ERR)) {
-		if (sr & SR_E_ERR)
+	if (nor->flags & SNOR_F_USE_CLSR &&
+	    nor->bouncebuf[0] & (SR_E_ERR | SR_P_ERR)) {
+		if (nor->bouncebuf[0] & SR_E_ERR)
 			dev_err(nor->dev, "Erase Error occurred\n");
 		else
 			dev_err(nor->dev, "Programming Error occurred\n");
@@ -766,7 +767,7 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
 		return -EIO;
 	}
=20
-	return !(sr & SR_WIP);
+	return !(nor->bouncebuf[0] & SR_WIP);
 }
=20
 static int spi_nor_clear_fsr(struct spi_nor *nor)
@@ -1341,11 +1342,11 @@ static int write_sr_and_check(struct spi_nor *nor, =
u8 status_new, u8 mask)
 	if (ret)
 		return ret;
=20
-	ret =3D read_sr(nor);
-	if (ret < 0)
+	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+	if (ret)
 		return ret;
=20
-	return ((ret & mask) !=3D (status_new & mask)) ? -EIO : 0;
+	return ((nor->bouncebuf[0] & mask) !=3D (status_new & mask)) ? -EIO : 0;
 }
=20
 static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
@@ -1440,16 +1441,18 @@ static int stm_is_unlocked_sr(struct spi_nor *nor, =
loff_t ofs, uint64_t len,
 static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *mtd =3D &nor->mtd;
-	int status_old, status_new;
+	int ret, status_old, status_new;
 	u8 mask =3D SR_BP2 | SR_BP1 | SR_BP0;
 	u8 shift =3D ffs(mask) - 1, pow, val;
 	loff_t lock_len;
 	bool can_be_top =3D true, can_be_bottom =3D nor->flags & SNOR_F_HAS_SR_TB=
;
 	bool use_top;
=20
-	status_old =3D read_sr(nor);
-	if (status_old < 0)
-		return status_old;
+	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	status_old =3D nor->bouncebuf[0];
=20
 	/* If nothing in our range is unlocked, we don't need to do anything */
 	if (stm_is_locked_sr(nor, ofs, len, status_old))
@@ -1520,16 +1523,18 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs=
, uint64_t len)
 static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *mtd =3D &nor->mtd;
-	int status_old, status_new;
+	int ret, status_old, status_new;
 	u8 mask =3D SR_BP2 | SR_BP1 | SR_BP0;
 	u8 shift =3D ffs(mask) - 1, pow, val;
 	loff_t lock_len;
 	bool can_be_top =3D true, can_be_bottom =3D nor->flags & SNOR_F_HAS_SR_TB=
;
 	bool use_top;
=20
-	status_old =3D read_sr(nor);
-	if (status_old < 0)
-		return status_old;
+	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	status_old =3D nor->bouncebuf[0];
=20
 	/* If nothing in our range is locked, we don't need to do anything */
 	if (stm_is_unlocked_sr(nor, ofs, len, status_old))
@@ -1604,13 +1609,12 @@ static int stm_unlock(struct spi_nor *nor, loff_t o=
fs, uint64_t len)
  */
 static int stm_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
-	int status;
+	int ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
=20
-	status =3D read_sr(nor);
-	if (status < 0)
-		return status;
+	if (ret)
+		return ret;
=20
-	return stm_is_locked_sr(nor, ofs, len, status);
+	return stm_is_locked_sr(nor, ofs, len, nor->bouncebuf[0]);
 }
=20
 static const struct spi_nor_locking_ops stm_locking_ops =3D {
@@ -1717,24 +1721,28 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_=
cr)
  */
 static int macronix_quad_enable(struct spi_nor *nor)
 {
-	int ret, val;
+	int ret;
=20
-	val =3D read_sr(nor);
-	if (val < 0)
-		return val;
-	if (val & SR_QUAD_EN_MX)
+	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	if (nor->bouncebuf[0] & SR_QUAD_EN_MX)
 		return 0;
=20
 	write_enable(nor);
=20
-	write_sr(nor, val | SR_QUAD_EN_MX);
+	write_sr(nor, nor->bouncebuf[0] | SR_QUAD_EN_MX);
=20
 	ret =3D spi_nor_wait_till_ready(nor);
 	if (ret)
 		return ret;
=20
-	ret =3D read_sr(nor);
-	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
+	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+	if (ret)
+		return ret;
+
+	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
 		dev_err(nor->dev, "Macronix Quad bit not set\n");
 		return -EINVAL;
 	}
@@ -1805,12 +1813,10 @@ static int spansion_no_read_cr_quad_enable(struct s=
pi_nor *nor)
 	int ret;
=20
 	/* Keep the current value of the Status Register. */
-	ret =3D read_sr(nor);
-	if (ret < 0) {
-		dev_err(nor->dev, "error while reading status register\n");
-		return -EINVAL;
-	}
-	sr_cr[0] =3D ret;
+	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
+	if (ret)
+		return ret;
+
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
=20
 	return write_sr_cr(nor, sr_cr);
@@ -1848,12 +1854,9 @@ static int spansion_read_cr_quad_enable(struct spi_n=
or *nor)
 	sr_cr[1] =3D ret | CR_QUAD_EN_SPAN;
=20
 	/* Keep the current value of the Status Register. */
-	ret =3D read_sr(nor);
-	if (ret < 0) {
-		dev_err(dev, "error while reading status register\n");
-		return -EINVAL;
-	}
-	sr_cr[0] =3D ret;
+	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
+	if (ret)
+		return ret;
=20
 	ret =3D write_sr_cr(nor, sr_cr);
 	if (ret)
@@ -1964,15 +1967,13 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	int ret;
 	u8 mask =3D SR_BP2 | SR_BP1 | SR_BP0;
=20
-	ret =3D read_sr(nor);
-	if (ret < 0) {
-		dev_err(nor->dev, "error while reading status register\n");
+	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
+	if (ret)
 		return ret;
-	}
=20
 	write_enable(nor);
=20
-	ret =3D write_sr(nor, ret & ~mask);
+	ret =3D write_sr(nor, nor->bouncebuf[0] & ~mask);
 	if (ret) {
 		dev_err(nor->dev, "write to status register failed\n");
 		return ret;
@@ -2018,13 +2019,11 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_=
nor *nor)
 	if (ret & CR_QUAD_EN_SPAN) {
 		sr_cr[1] =3D ret;
=20
-		ret =3D read_sr(nor);
-		if (ret < 0) {
-			dev_err(nor->dev,
-				"error while reading status register\n");
+		ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
+		if (ret)
 			return ret;
-		}
-		sr_cr[0] =3D ret & ~mask;
+
+		sr_cr[0] &=3D ~mask;
=20
 		ret =3D write_sr_cr(nor, sr_cr);
 		if (ret)
--=20
2.9.5

