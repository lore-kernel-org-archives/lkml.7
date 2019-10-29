Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825DCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BA820663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QBdLPNwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387798AbfJ2LTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:19:04 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7381 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbfJ2LRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:02 -0400
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
IronPort-SDR: U0QU2MGCIVl1fzsYe64Gro823obTXuw28E4PZqgc7rmtoy8eryhLzsLHi5mytDMMh8BqnEtD08
 MsOjfDDpESN5Ah1HHcoU2wg5WJtTHP3B6pm2AE5BdS4HBUfb0bG6n4YqjMbbbhLDHhbfiYp68w
 Yh4L68LwKHMCZi3mVsKxabz2zT3NRYKlpXih86+a+YNlz8kOJ6vlzBCCWe+vcHtDI8LYBPO6Id
 AnF+yvb8jdDeSjLQV2HRM0PumhtYf62/pwGdhDhkkPVZOQqrakWZJYwkZGGtu17ylk1wQwwW6Q
 OUA=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="54794528"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:16:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 04:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEYpSACBtFMpze2YQRUQFYuMdhfungrCfD8QLcL0MpMA+KyKW217Vedc2N2Od2OHwR0B3QifN9BE4rrqgBjGNwBCdU/pTXmdBDiV8r8C8gIHUZJkuIx2m7pry1rQNHQOBrGLBnkPJkbsgEpWcAplkDqayDGLis91xlskNOXdlAzHE1Zp1lnWjO0Ul4S4wiaSW9M1+Hlo4TpeuDvJKB7FW9h5SLynE5nJjm5wCF7KHItBJYd1ygER572jDo4imoUma7Gstwv5ZODLvRzUN8Ae3lvHXOtih9Iyy0vOG+76DLIztcd14n2r2rtYYe6MeKTTEmlg4qPrBVLePk2qcZbwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyV1TUej2St0d8Tu2sYvUg4eoH8lthIgHLUs59NsBoI=;
 b=IcSSjWY3/uagwHTC9PMzIukX69ps7JZcSkouXX4L7WLzGJAisynhWnoeBphvHnE0c97UtN5G0+gjnUth74EFOBDgje56cyefQIyHqFrAf8Pe5PK4RNMK6HZ1DnhwAp+rvdV18y23XbtlAiKs6ThJgPt02Iu9xp6Jyl8uA4ap8bPQrUJi++UYtf44rEs9cyGBskqPPLK+06SeXCPgjUTIxiJYO6hpJKtpB5R9HQ8ajeIWO4k/bgvZ5ZpQvrW2RzZAxOq+HxTEJrNEA+7YJKrvWrSp8X62zP5pef7F3BfYQmJF6+CEi6iGdNYHg2yIi6I8ox7Xe8P5Y5d8VXj53d/Ndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyV1TUej2St0d8Tu2sYvUg4eoH8lthIgHLUs59NsBoI=;
 b=QBdLPNwDtMc4GcwXTmTj+7XTlOjhYZ4Mf6zuuVlUSKP/dFuU7Pb9g80Psmlhyauqr9Q9Z7y6014d6IqaQj1azekOWZKmUOizG5pVwZ2qhoSzhQ3Q55fr/M1CHXslJUgC1fK/Vb0PQNgFdhC7XADfDDGP6MUOsLhCqn1hMToOBEo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:16:49 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:16:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 01/32] mtd: spi-nor: Prepend spi_nor_ to all Reg Ops
 methods
Thread-Topic: [PATCH v3 01/32] mtd: spi-nor: Prepend spi_nor_ to all Reg Ops
 methods
Thread-Index: AQHVjkpbEAWn0W/WNUW6ZfmVSIdQEA==
Date:   Tue, 29 Oct 2019 11:16:49 +0000
Message-ID: <20191029111615.3706-2-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3c880d6e-8d55-49f6-f867-08d75c617de8
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3712999EACD134541245E6EDF0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(11346002)(446003)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(30864003)(26005)(99286004)(386003)(76176011)(52116002)(1076003)(102836004)(14444005)(71200400001)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nUEJN+I7Blhfw8Oxa58PTPL5LZjkb8cmeS/u1TnsniaI3PDcAk9NXEVivpS+wLwuhNV/kPOb5AomGoSplzFVi53ZkThA6FWNZTgJh+grkyFysTbxo9uVCyQ+blQ0TbVM8yeeb2HHMydd3fGDla0sf/+9F5aZg3AK0IXtwprvLXR0mfrQZ/tps3jZghBYGvspKQBieVY4j+ile2EAnF+jS9uIHjJmRTtIm/UicmY/vBUG+ZJXCJvh+qbZXfVl/siOXluJo57zI3gfVDIsv/2AE8UmXLDRMRGSsL4B/tFT3ZR/Ywmk7Rv3SDmcIru/2TcbgnXXDM1TJrRvG83wNdnCPH2OzX5c2UkVTDQCxTxxx1pjIsW5168HUczTp3uJ4evpAyRTBvmdtKI+hwexzA+DV2V8tAjbbmvCJ7O2u75chol4hS0TY7DA3DJyYwk1zl2S
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c880d6e-8d55-49f6-f867-08d75c617de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:16:49.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSbyhDV45DNBeW+yrUiCI0aXtzHozFl2pBbDB7qIVHTOwp5CwahaYkexUukJPeI9dzlYHVENqMFOJdGr1mjaOJax3VHEbPybuHJVmhLUF4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

All the core functions should begin with "spi_nor_".

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 110 +++++++++++++++++++++-----------------=
----
 1 file changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index a6f9f833c862..aca8245fb6c4 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -393,7 +393,7 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, =
loff_t to, size_t len,
  * Return the status register value.
  * Returns negative if error occurred.
  */
-static int read_sr(struct spi_nor *nor)
+static int spi_nor_read_sr(struct spi_nor *nor)
 {
 	int ret;
=20
@@ -423,7 +423,7 @@ static int read_sr(struct spi_nor *nor)
  * Return the status register value.
  * Returns negative if error occurred.
  */
-static int read_fsr(struct spi_nor *nor)
+static int spi_nor_read_fsr(struct spi_nor *nor)
 {
 	int ret;
=20
@@ -453,7 +453,7 @@ static int read_fsr(struct spi_nor *nor)
  * location. Return the configuration register value.
  * Returns negative if error occurred.
  */
-static int read_cr(struct spi_nor *nor)
+static int spi_nor_read_cr(struct spi_nor *nor)
 {
 	int ret;
=20
@@ -482,7 +482,7 @@ static int read_cr(struct spi_nor *nor)
  * Write status register 1 byte
  * Returns negative if error occurred.
  */
-static int write_sr(struct spi_nor *nor, u8 val)
+static int spi_nor_write_sr(struct spi_nor *nor, u8 val)
 {
 	nor->bouncebuf[0] =3D val;
 	if (nor->spimem) {
@@ -503,7 +503,7 @@ static int write_sr(struct spi_nor *nor, u8 val)
  * Set write enable latch with Write Enable command.
  * Returns negative if error occurred.
  */
-static int write_enable(struct spi_nor *nor)
+static int spi_nor_write_enable(struct spi_nor *nor)
 {
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
@@ -521,7 +521,7 @@ static int write_enable(struct spi_nor *nor)
 /*
  * Send write disable instruction to the chip.
  */
-static int write_disable(struct spi_nor *nor)
+static int spi_nor_write_disable(struct spi_nor *nor)
 {
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
@@ -644,9 +644,9 @@ static int st_micron_set_4byte(struct spi_nor *nor, boo=
l enable)
 {
 	int ret;
=20
-	write_enable(nor);
+	spi_nor_write_enable(nor);
 	ret =3D macronix_set_4byte(nor, enable);
-	write_disable(nor);
+	spi_nor_write_disable(nor);
=20
 	return ret;
 }
@@ -700,9 +700,9 @@ static int winbond_set_4byte(struct spi_nor *nor, bool =
enable)
 	 * Register to be set to 1, so all 3-byte-address reads come from the
 	 * second 16M. We must clear the register to enable normal behavior.
 	 */
-	write_enable(nor);
+	spi_nor_write_enable(nor);
 	ret =3D spi_nor_write_ear(nor, 0);
-	write_disable(nor);
+	spi_nor_write_disable(nor);
=20
 	return ret;
 }
@@ -752,7 +752,7 @@ static int spi_nor_clear_sr(struct spi_nor *nor)
=20
 static int spi_nor_sr_ready(struct spi_nor *nor)
 {
-	int sr =3D read_sr(nor);
+	int sr =3D spi_nor_read_sr(nor);
 	if (sr < 0)
 		return sr;
=20
@@ -786,7 +786,7 @@ static int spi_nor_clear_fsr(struct spi_nor *nor)
=20
 static int spi_nor_fsr_ready(struct spi_nor *nor)
 {
-	int fsr =3D read_fsr(nor);
+	int fsr =3D spi_nor_read_fsr(nor);
 	if (fsr < 0)
 		return fsr;
=20
@@ -864,7 +864,7 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor)
  *
  * Returns 0 if successful, non-zero otherwise.
  */
-static int erase_chip(struct spi_nor *nor)
+static int spi_nor_erase_chip(struct spi_nor *nor)
 {
 	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
=20
@@ -1215,7 +1215,7 @@ static int spi_nor_erase_multi_sectors(struct spi_nor=
 *nor, u64 addr, u32 len)
 	list_for_each_entry_safe(cmd, next, &erase_list, list) {
 		nor->erase_opcode =3D cmd->opcode;
 		while (cmd->count) {
-			write_enable(nor);
+			spi_nor_write_enable(nor);
=20
 			ret =3D spi_nor_erase_sector(nor, addr);
 			if (ret)
@@ -1270,9 +1270,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct=
 erase_info *instr)
 	if (len =3D=3D mtd->size && !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
 		unsigned long timeout;
=20
-		write_enable(nor);
+		spi_nor_write_enable(nor);
=20
-		if (erase_chip(nor)) {
+		if (spi_nor_erase_chip(nor)) {
 			ret =3D -EIO;
 			goto erase_err;
 		}
@@ -1298,7 +1298,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct=
 erase_info *instr)
 	/* "sector"-at-a-time erase */
 	} else if (spi_nor_has_uniform_erase(nor)) {
 		while (len) {
-			write_enable(nor);
+			spi_nor_write_enable(nor);
=20
 			ret =3D spi_nor_erase_sector(nor, addr);
 			if (ret)
@@ -1319,7 +1319,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct=
 erase_info *instr)
 			goto erase_err;
 	}
=20
-	write_disable(nor);
+	spi_nor_write_disable(nor);
=20
 erase_err:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_ERASE);
@@ -1328,12 +1328,13 @@ static int spi_nor_erase(struct mtd_info *mtd, stru=
ct erase_info *instr)
 }
=20
 /* Write status register and ensure bits in mask match written values */
-static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
+static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
+				      u8 mask)
 {
 	int ret;
=20
-	write_enable(nor);
-	ret =3D write_sr(nor, status_new);
+	spi_nor_write_enable(nor);
+	ret =3D spi_nor_write_sr(nor, status_new);
 	if (ret)
 		return ret;
=20
@@ -1341,7 +1342,7 @@ static int write_sr_and_check(struct spi_nor *nor, u8=
 status_new, u8 mask)
 	if (ret)
 		return ret;
=20
-	ret =3D read_sr(nor);
+	ret =3D spi_nor_read_sr(nor);
 	if (ret < 0)
 		return ret;
=20
@@ -1447,7 +1448,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, =
uint64_t len)
 	bool can_be_top =3D true, can_be_bottom =3D nor->flags & SNOR_F_HAS_SR_TB=
;
 	bool use_top;
=20
-	status_old =3D read_sr(nor);
+	status_old =3D spi_nor_read_sr(nor);
 	if (status_old < 0)
 		return status_old;
=20
@@ -1509,7 +1510,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, =
uint64_t len)
 	if ((status_new & mask) < (status_old & mask))
 		return -EINVAL;
=20
-	return write_sr_and_check(nor, status_new, mask);
+	return spi_nor_write_sr_and_check(nor, status_new, mask);
 }
=20
 /*
@@ -1527,7 +1528,7 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs=
, uint64_t len)
 	bool can_be_top =3D true, can_be_bottom =3D nor->flags & SNOR_F_HAS_SR_TB=
;
 	bool use_top;
=20
-	status_old =3D read_sr(nor);
+	status_old =3D spi_nor_read_sr(nor);
 	if (status_old < 0)
 		return status_old;
=20
@@ -1592,7 +1593,7 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs=
, uint64_t len)
 	if ((status_new & mask) > (status_old & mask))
 		return -EINVAL;
=20
-	return write_sr_and_check(nor, status_new, mask);
+	return spi_nor_write_sr_and_check(nor, status_new, mask);
 }
=20
 /*
@@ -1606,7 +1607,7 @@ static int stm_is_locked(struct spi_nor *nor, loff_t =
ofs, uint64_t len)
 {
 	int status;
=20
-	status =3D read_sr(nor);
+	status =3D spi_nor_read_sr(nor);
 	if (status < 0)
 		return status;
=20
@@ -1670,11 +1671,11 @@ static int spi_nor_is_locked(struct mtd_info *mtd, =
loff_t ofs, uint64_t len)
  * second byte will be written to the configuration register.
  * Return negative if error occurred.
  */
-static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
+static int spi_nor_write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
 {
 	int ret;
=20
-	write_enable(nor);
+	spi_nor_write_enable(nor);
=20
 	if (nor->spimem) {
 		struct spi_mem_op op =3D
@@ -1719,21 +1720,21 @@ static int macronix_quad_enable(struct spi_nor *nor=
)
 {
 	int ret, val;
=20
-	val =3D read_sr(nor);
+	val =3D spi_nor_read_sr(nor);
 	if (val < 0)
 		return val;
 	if (val & SR_QUAD_EN_MX)
 		return 0;
=20
-	write_enable(nor);
+	spi_nor_write_enable(nor);
=20
-	write_sr(nor, val | SR_QUAD_EN_MX);
+	spi_nor_write_sr(nor, val | SR_QUAD_EN_MX);
=20
 	ret =3D spi_nor_wait_till_ready(nor);
 	if (ret)
 		return ret;
=20
-	ret =3D read_sr(nor);
+	ret =3D spi_nor_read_sr(nor);
 	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
 		dev_err(nor->dev, "Macronix Quad bit not set\n");
 		return -EINVAL;
@@ -1758,7 +1759,8 @@ static int macronix_quad_enable(struct spi_nor *nor)
  * some very old and few memories don't support this instruction. If a pul=
l-up
  * resistor is present on the MISO/IO1 line, we might still be able to pas=
s the
  * "read back" test because the QSPI memory doesn't recognize the command,
- * so leaves the MISO/IO1 line state unchanged, hence read_cr() returns 0x=
FF.
+ * so leaves the MISO/IO1 line state unchanged, hence spi_nor_read_cr() re=
turns
+ * 0xFF.
  *
  * bit 1 of the Configuration Register is the QE bit for Spansion like QSP=
I
  * memories.
@@ -1772,12 +1774,12 @@ static int spansion_quad_enable(struct spi_nor *nor=
)
=20
 	sr_cr[0] =3D 0;
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
-	ret =3D write_sr_cr(nor, sr_cr);
+	ret =3D spi_nor_write_sr_cr(nor, sr_cr);
 	if (ret)
 		return ret;
=20
 	/* read back and check it */
-	ret =3D read_cr(nor);
+	ret =3D spi_nor_read_cr(nor);
 	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
@@ -1805,7 +1807,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
 	int ret;
=20
 	/* Keep the current value of the Status Register. */
-	ret =3D read_sr(nor);
+	ret =3D spi_nor_read_sr(nor);
 	if (ret < 0) {
 		dev_err(nor->dev, "error while reading status register\n");
 		return -EINVAL;
@@ -1813,7 +1815,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
 	sr_cr[0] =3D ret;
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
=20
-	return write_sr_cr(nor, sr_cr);
+	return spi_nor_write_sr_cr(nor, sr_cr);
 }
=20
 /**
@@ -1836,7 +1838,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 	int ret;
=20
 	/* Check current Quad Enable bit value. */
-	ret =3D read_cr(nor);
+	ret =3D spi_nor_read_cr(nor);
 	if (ret < 0) {
 		dev_err(dev, "error while reading configuration register\n");
 		return -EINVAL;
@@ -1848,19 +1850,19 @@ static int spansion_read_cr_quad_enable(struct spi_=
nor *nor)
 	sr_cr[1] =3D ret | CR_QUAD_EN_SPAN;
=20
 	/* Keep the current value of the Status Register. */
-	ret =3D read_sr(nor);
+	ret =3D spi_nor_read_sr(nor);
 	if (ret < 0) {
 		dev_err(dev, "error while reading status register\n");
 		return -EINVAL;
 	}
 	sr_cr[0] =3D ret;
=20
-	ret =3D write_sr_cr(nor, sr_cr);
+	ret =3D spi_nor_write_sr_cr(nor, sr_cr);
 	if (ret)
 		return ret;
=20
 	/* Read back and check it. */
-	ret =3D read_cr(nor);
+	ret =3D spi_nor_read_cr(nor);
 	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
 		dev_err(nor->dev, "Spansion Quad bit not set\n");
 		return -EINVAL;
@@ -1926,7 +1928,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 	/* Update the Quad Enable bit. */
 	*sr2 |=3D SR2_QUAD_EN_BIT7;
=20
-	write_enable(nor);
+	spi_nor_write_enable(nor);
=20
 	ret =3D spi_nor_write_sr2(nor, sr2);
 	if (ret < 0) {
@@ -1964,15 +1966,15 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	int ret;
 	u8 mask =3D SR_BP2 | SR_BP1 | SR_BP0;
=20
-	ret =3D read_sr(nor);
+	ret =3D spi_nor_read_sr(nor);
 	if (ret < 0) {
 		dev_err(nor->dev, "error while reading status register\n");
 		return ret;
 	}
=20
-	write_enable(nor);
+	spi_nor_write_enable(nor);
=20
-	ret =3D write_sr(nor, ret & ~mask);
+	ret =3D spi_nor_write_sr(nor, ret & ~mask);
 	if (ret) {
 		dev_err(nor->dev, "write to status register failed\n");
 		return ret;
@@ -2004,7 +2006,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
 	u8 *sr_cr =3D  nor->bouncebuf;
=20
 	/* Check current Quad Enable bit value. */
-	ret =3D read_cr(nor);
+	ret =3D spi_nor_read_cr(nor);
 	if (ret < 0) {
 		dev_err(nor->dev,
 			"error while reading configuration register\n");
@@ -2018,7 +2020,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
 	if (ret & CR_QUAD_EN_SPAN) {
 		sr_cr[1] =3D ret;
=20
-		ret =3D read_sr(nor);
+		ret =3D spi_nor_read_sr(nor);
 		if (ret < 0) {
 			dev_err(nor->dev,
 				"error while reading status register\n");
@@ -2026,7 +2028,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_no=
r *nor)
 		}
 		sr_cr[0] =3D ret & ~mask;
=20
-		ret =3D write_sr_cr(nor, sr_cr);
+		ret =3D spi_nor_write_sr_cr(nor, sr_cr);
 		if (ret)
 			dev_err(nor->dev, "16-bit write register failed\n");
 		return ret;
@@ -2602,7 +2604,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
 	if (ret)
 		return ret;
=20
-	write_enable(nor);
+	spi_nor_write_enable(nor);
=20
 	nor->sst_write_second =3D false;
=20
@@ -2641,14 +2643,14 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 	}
 	nor->sst_write_second =3D false;
=20
-	write_disable(nor);
+	spi_nor_write_disable(nor);
 	ret =3D spi_nor_wait_till_ready(nor);
 	if (ret)
 		goto sst_write_err;
=20
 	/* Write out trailing byte if it exists. */
 	if (actual !=3D len) {
-		write_enable(nor);
+		spi_nor_write_enable(nor);
=20
 		nor->program_opcode =3D SPINOR_OP_BP;
 		ret =3D spi_nor_write_data(nor, to, 1, buf + actual);
@@ -2659,7 +2661,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto sst_write_err;
-		write_disable(nor);
+		spi_nor_write_disable(nor);
 		actual +=3D 1;
 	}
 sst_write_err:
@@ -2711,7 +2713,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t=
 to, size_t len,
=20
 		addr =3D spi_nor_convert_addr(nor, addr);
=20
-		write_enable(nor);
+		spi_nor_write_enable(nor);
 		ret =3D spi_nor_write_data(nor, addr, page_remain, buf + i);
 		if (ret < 0)
 			goto write_err;
--=20
2.9.5

