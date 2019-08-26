Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D17C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3BF217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="eqXETzB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfHZMJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:09:07 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33278 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbfHZMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:09:06 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: ax6khYD2ZtdR/+3oFaHSbd14tERUVove8aIlQ9TQoJiLt4XhL9CNeFJkWTdtzzwWPU+LJGxVfv
 1iFYSd9nd8pqXF4fat9chNn1ACBdcgyIU6BBSZdzmZJ/OcR75liAnTybt+c8mKzjR6QLRoNp68
 I4vBhSKoJsJrSCDSgczkoU+qWzfEpoT/wWo2SFsd1o1+Ueqv/x4g2vQsFCtG8COL/b24/f1K2q
 d4x9e5PGTqjQM+WxvfI7RRFJYgzOlKLTYXfwODuM+rSicSv3s0Ism9K5hdyO3aniVVzUNh5M2D
 +dY=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="46520780"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:09:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:09:04 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:09:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btbtYDdmjpEG5hYxi3LmUFYDt+GpuWu5zCGBZXJD/I+AAoZ2pJFjvl0MJXiG1s2sxeKnSf3lk8cOfXbcRpQsgINZ9FsYyqtRMVPxNfcWIwuxmB2cmvPjNTX58WP5dbEodnRj+U8vaKdccgVpi3nfsgwh7wnVYrKFxL7BvbhYGcvQ9XoJ6lg/ICYHSkHoYgwjxFdduL/Qg1yvCxYlUohXfBAxuZBGWnR1q/uVslCedryX1IVkz/IsT6Y71xE2xkQiKHALmeAG5ipWpRV0pqGoQUxvs5u3vI6R9Lvnrv0dlO0+IgSUxbsNYpjac2YQAKupZgm2K6iSg31F3Nlzru9YEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T1YHZWV8TyZgRF10y/o+KIqRMw8GGpK0CyRZfHJ8aM=;
 b=Ig5L4zzgn1H/M2GVxftiegH1u48L4bEVgVgPzpnUqvoUFuTsShVUNLsZhhBkrL1S9S6JNEEpR6N8/R8VHp3Er0OPAOtrM/wguG3iGrQuC2QerCFq98qEYUNG6lqOv13pLZS0nd6ClfEfAxquUGrNzesKn208+1alRiIXgwYh5/JUDKqDYHqe+DktA/WTlRd/Nk+EBYACGLaEHydrZkYoQtMpv8yu2NYXunM92p0db6Ao8+gOfi8r2uAyN3t0DOzPcZQgipN1iuxUK4x7e8JZnZ04QkKGAIi6oxRA9EIViMWQMxNUA8I5pwl6mwramCQTHie7BfaJgDHZH3qDnLPC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T1YHZWV8TyZgRF10y/o+KIqRMw8GGpK0CyRZfHJ8aM=;
 b=eqXETzB5cHHpFt8PtQ+1Paz6xKeMXxce7ScMKZ0TQ2F+FEpcF7mBWhOUn6EsRD3ZNJ0pnMJmGAF1jCejBK0RoZri9iLRHzZEDBR+Ce6tHpB1g509y3VIsQYoHhbajUap/m5S2yAOvWaI3s/c+3WLPULdJij9cqtoFbe2Gdbyv5M=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3678.namprd11.prod.outlook.com (20.178.252.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:09:02 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:09:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 10/20] mtd: spi-nor: Rework the SPI NOR lock/unlock
 logic
Thread-Topic: [RESEND PATCH v3 10/20] mtd: spi-nor: Rework the SPI NOR
 lock/unlock logic
Thread-Index: AQHVXAcFrCpvcaMjzkSkkB6kiMDMIg==
Date:   Mon, 26 Aug 2019 12:08:50 +0000
Message-ID: <20190826120821.16351-11-tudor.ambarus@microchip.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190826120821.16351-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:28::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47bfae3d-6cee-4005-73f4-08d72a1e27b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3678;
x-ms-traffictypediagnostic: MN2PR11MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3678EA13AF095EA94570529CF0A10@MN2PR11MB3678.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(486006)(2616005)(476003)(6666004)(107886003)(316002)(14454004)(386003)(6506007)(76176011)(99286004)(52116002)(54906003)(110136005)(478600001)(102836004)(4326008)(25786009)(36756003)(446003)(26005)(11346002)(50226002)(81156014)(66066001)(8676002)(53936002)(81166006)(8936002)(6512007)(6486002)(6436002)(3846002)(6116002)(186003)(86362001)(305945005)(2201001)(7736002)(2906002)(64756008)(66446008)(1076003)(71190400001)(5660300002)(71200400001)(256004)(14444005)(66946007)(66556008)(66476007)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3678;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4pqUzqlVaJ/xMZG8yr2QA2P0q4J/3dqSUwlro/cKDgCaUX73wd+weZ1F3TPRdjBV2M+h+nExC1rLRVNBK8r3nGvwTTjVhj0NCzhny57UYDuKL9XYpH9HDAg0JWEfxyc1wczrreXcRaORBTWpWpHN6KbRFCWbCOJsmAUpeHnaRMOq74WLHkgmIjvy3VL3Q2xow3aU8BY0oOR/foW5HyccpaMsHlBeIjXIA+DpfOB3hK+ITtZMFxnM9es2VXBHrN9pTDwVI9PwvcZ48cuqcRYpx9hZ6/k9cvYJ++/FP1vrrNsrmqXIM+8Chp5k23zzTkQH2AaNXljYggT1F9LpBdWYtxmY/OYlahUyT2Nr2js9eqWXDLM0hrqInm1AjGr94M4eViPLCAtPoyIF1eEkGaTQJQG8Y1XJOjSeyRwFizpGup8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bfae3d-6cee-4005-73f4-08d72a1e27b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:08:50.1704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNQ7+67AFc/xFcM/eaLYrHxc9hIXFTLHpnKA3Hvnu5oEK2caxnFpSJ+t/aH26TsvhFdH+cjSAYbI0WOQ2Wxkf6XaieuBEU6MlqLpUNw/q8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

Add the SNOR_F_HAS_LOCK flag and set it when SPI_NOR_HAS_LOCK is set
in the flash_info entry or when it's a Micron or ST flash.

Move the locking hooks in a separate struct so that we have just
one field to update when we change the locking implementation.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
[tudor.ambarus@microchip.com: use ->default_init() hook, introduce
spi_nor_late_init_params(), set ops in nor->params]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: no changes, clear_sr_bp() is handled in the last patch of the
series.

 drivers/mtd/spi-nor/spi-nor.c | 50 ++++++++++++++++++++++++++++++++-------=
----
 include/linux/mtd/spi-nor.h   | 23 ++++++++++++++------
 2 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 235e82a121a1..3f997797fa9d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1598,6 +1598,12 @@ static int stm_is_locked(struct spi_nor *nor, loff_t=
 ofs, uint64_t len)
 	return stm_is_locked_sr(nor, ofs, len, status);
 }
=20
+static const struct spi_nor_locking_ops stm_locking_ops =3D {
+	.lock =3D stm_lock,
+	.unlock =3D stm_unlock,
+	.is_locked =3D stm_is_locked,
+};
+
 static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
@@ -1607,7 +1613,7 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t =
ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->flash_lock(nor, ofs, len);
+	ret =3D nor->params.locking_ops->lock(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK);
 	return ret;
@@ -1622,7 +1628,7 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_=
t ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->flash_unlock(nor, ofs, len);
+	ret =3D nor->params.locking_ops->unlock(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
 	return ret;
@@ -1637,7 +1643,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, lo=
ff_t ofs, uint64_t len)
 	if (ret)
 		return ret;
=20
-	ret =3D nor->flash_is_locked(nor, ofs, len);
+	ret =3D nor->params.locking_ops->is_locked(nor, ofs, len);
=20
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
 	return ret;
@@ -4148,6 +4154,7 @@ static void macronix_set_default_init(struct spi_nor =
*nor)
=20
 static void st_micron_set_default_init(struct spi_nor *nor)
 {
+	nor->flags =3D SNOR_F_HAS_LOCK;
 	nor->params.quad_enable =3D NULL;
 	nor->params.set_4byte =3D st_micron_set_4byte;
 }
@@ -4292,6 +4299,23 @@ static void spi_nor_info_init_params(struct spi_nor =
*nor)
 }
=20
 /**
+ * spi_nor_late_init_params() - Late initialization of default flash param=
eters.
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Used to set default flash parameters and settings when the ->default_in=
it()
+ * hook or the SFDP parser let voids.
+ */
+static void spi_nor_late_init_params(struct spi_nor *nor)
+{
+	/*
+	 * NOR protection support. When locking_ops are not provided, we pick
+	 * the default ones.
+	 */
+	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params.locking_ops)
+		nor->params.locking_ops =3D &stm_locking_ops;
+}
+
+/**
  * spi_nor_init_params() - Initialize the flash's parameters and settings.
  * @nor:	pointer to a 'struct spi-nor'.
  *
@@ -4316,6 +4340,10 @@ static void spi_nor_info_init_params(struct spi_nor =
*nor)
  *    Please not that there is a ->post_bfpt() fixup hook that can overwri=
te the
  *    flash parameters and settings imediately after parsing the Basic Fla=
sh
  *    Parameter Table.
+ *
+ * 4/ Late default flash parameters initialization, used when the
+ * ->default_init() hook or the SFDP parser do not set specific params.
+ *		spi_nor_late_init_params()
  */
 static void spi_nor_init_params(struct spi_nor *nor)
 {
@@ -4326,6 +4354,8 @@ static void spi_nor_init_params(struct spi_nor *nor)
 	if ((nor->info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
 	    !(nor->info->flags & SPI_NOR_SKIP_SFDP))
 		spi_nor_sfdp_init_params(nor);
+
+	spi_nor_late_init_params(nor);
 }
=20
 static int spi_nor_select_read(struct spi_nor *nor,
@@ -4707,6 +4737,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	if (info->flags & SPI_S3AN)
 		nor->flags |=3D  SNOR_F_READY_XSR_RDY;
=20
+	if (info->flags & SPI_NOR_HAS_LOCK)
+		nor->flags |=3D SNOR_F_HAS_LOCK;
+
 	/*
 	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
 	 * with the software protection bits set.
@@ -4731,16 +4764,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 	mtd->_read =3D spi_nor_read;
 	mtd->_resume =3D spi_nor_resume;
=20
-	/* NOR protection support for STmicro/Micron chips and similar */
-	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_ST ||
-	    JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
-	    info->flags & SPI_NOR_HAS_LOCK) {
-		nor->flash_lock =3D stm_lock;
-		nor->flash_unlock =3D stm_unlock;
-		nor->flash_is_locked =3D stm_is_locked;
-	}
-
-	if (nor->flash_lock && nor->flash_unlock && nor->flash_is_locked) {
+	if (nor->params.locking_ops) {
 		mtd->_lock =3D spi_nor_lock;
 		mtd->_unlock =3D spi_nor_unlock;
 		mtd->_is_locked =3D spi_nor_is_locked;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7da89dd483cb..ea3bcac54dc2 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -243,6 +243,7 @@ enum spi_nor_option_flags {
 	SNOR_F_BROKEN_RESET	=3D BIT(6),
 	SNOR_F_4B_OPCODES	=3D BIT(7),
 	SNOR_F_HAS_4BAIT	=3D BIT(8),
+	SNOR_F_HAS_LOCK		=3D BIT(9),
 };
=20
 /**
@@ -466,6 +467,18 @@ enum spi_nor_pp_command_index {
 struct spi_nor;
=20
 /**
+ * struct spi_nor_locking_ops - SPI NOR locking methods
+ * @lock:	lock a region of the SPI NOR.
+ * @unlock:	unlock a region of the SPI NOR.
+ * @is_locked:	check if a region of the SPI NOR is completely locked
+ */
+struct spi_nor_locking_ops {
+	int (*lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
+	int (*unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
+	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
+};
+
+/**
  * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
  * Includes legacy flash parameters and settings that can be overwritten
  * by the spi_nor_fixups hooks, or dynamically when parsing the JESD216
@@ -483,6 +496,7 @@ struct spi_nor;
  *                      Table.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
+ * @locking_ops:	SPI NOR locking methods.
  */
 struct spi_nor_flash_parameter {
 	u64				size;
@@ -496,6 +510,8 @@ struct spi_nor_flash_parameter {
=20
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte)(struct spi_nor *nor, bool enable);
+
+	const struct spi_nor_locking_ops *locking_ops;
 };
=20
 /**
@@ -536,10 +552,6 @@ struct flash_info;
  * @erase:		[DRIVER-SPECIFIC] erase a sector of the SPI NOR
  *			at the offset @offs; if not provided by the driver,
  *			spi-nor will send the erase opcode via write_reg()
- * @flash_lock:		[FLASH-SPECIFIC] lock a region of the SPI NOR
- * @flash_unlock:	[FLASH-SPECIFIC] unlock a region of the SPI NOR
- * @flash_is_locked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
- *			completely locked
  * @clear_sr_bp:	[FLASH-SPECIFIC] clears the Block Protection Bits from
  *			the SPI NOR Status Register.
  * @params:		[FLASH-SPECIFIC] SPI-NOR flash parameters and settings.
@@ -579,9 +591,6 @@ struct spi_nor {
 			size_t len, const u_char *write_buf);
 	int (*erase)(struct spi_nor *nor, loff_t offs);
=20
-	int (*flash_lock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
-	int (*flash_unlock)(struct spi_nor *nor, loff_t ofs, uint64_t len);
-	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 	int (*clear_sr_bp)(struct spi_nor *nor);
 	struct spi_nor_flash_parameter params;
=20
--=20
2.9.5

