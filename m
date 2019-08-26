Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375C6C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81A3217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UndrUTp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfHZMJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:09:26 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:23226 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731785AbfHZMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:09:11 -0400
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
IronPort-SDR: BfLMm0CpBFFNHxvKpMzywmsHmK4/VknBBSeV5KCIHA+WSC8gXF9ey6q8elxUrjI0fJZ8+RLcUi
 dix294OhckcPXkwPGBbmdif8OQL/eIn8T5eu3T5ozXme9RiPxYV3ZoSIVsmdImFTL8Y9BcpbBf
 HPXBMWK8wqUSGn6jj0wYm2r7VJvXC08GJR15aO3Y8xnncx1i6DaIF8rc1duRwiAGySKyeiW+B1
 uCy2MB+BxldqCcInBl/Dz/OV5YehQyUoYjllB3CPDV5dWeEiNC6dWij9wcy2W0+Bi1K0q+eDIP
 9lg=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="44989697"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:09:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:09:09 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:09:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpx06c0Cw613h/pNsSQOqwR6VeAV3wXIhU0b+P0s5HBMc7PvGm3PGjyIi+QjpRXo7/6Rlv4BM+k4kuM2rgseMQ7HjCZVTQy6sUcT+KQu4UcmsmzK20WUMqfIvOL0T1vhPqDVOZDZz8tLx+TQ9nwXlAcJ4WXNvTo4pW02JWlgp0O60eVzWH785C7+eKAVBXwxW6wvDYb29R9uwS6CRN1uEYH4JuuVhoA9pB4EkCevW16ocM1T86YEIhabSWCf/RobHKyAy26DBNhOvpQMNnK8xjiQzXdV1zeoNbgpjciqqf/fR6id/Oj8mqJ++4vWFcvwUZkV/f+mnxBxt/wii1UBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq2hOpJWptLTtqVywO/fAs3puBGR+PG/1p698ZvjECI=;
 b=ZU2V1v/G4DBN/HL7E7iYeBf/9RDMqlJAOHOQ14ST4hMn7IRIjOv+Is03UUkQypEcQUszCDDDeUXlIt1hkqnsakMQaL5KwB1u99k9LiEkPX12H0qz/75ZOMacOEusIqJYsbpr+NpZMTmcQxZ1EOuvp05Oz618PWMZ3RKOmPbNhSsMFtUeNTZRB82xnX0zy6nx2YDcpk+vGYwNv3o1572JT7CR7/Y8oYDSsmzEkrj/7L//fHDj6xf9UYWrVQ42miAx7PJXF72NE9nXEnb4hW9l346A/zMNxobxBVBHYEf5ShLaHCksDJoHlUJxY+dF9kduhdeSwRblICbwFFW2CKuBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq2hOpJWptLTtqVywO/fAs3puBGR+PG/1p698ZvjECI=;
 b=UndrUTp2KXe2/AaCfD+tTyQsrFYEneJpUMK3j/s3VKR4HvihkpCMvWs0CYW9DxqQS+Z9ge8asbL6Nir8Sz0Mx5bi+R2Mggpk0eP1Bj2Fhn/9yoZALIVfY1zmBkX4RvPymxzkeiNoFXRw9KdB4EM0v60kfjAn3CUKOiUZWwEITj8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3678.namprd11.prod.outlook.com (20.178.252.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:09:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:09:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 19/20] mtd: spi-nor: Introduce
 spi_nor_get_flash_info()
Thread-Topic: [RESEND PATCH v3 19/20] mtd: spi-nor: Introduce
 spi_nor_get_flash_info()
Thread-Index: AQHVXAcPi3T8X+P9M0ynbxQOIh0BzA==
Date:   Mon, 26 Aug 2019 12:09:07 +0000
Message-ID: <20190826120821.16351-20-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 0fdda10c-93c0-4daf-9bda-08d72a1e3223
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3678;
x-ms-traffictypediagnostic: MN2PR11MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB367854A97ADB3CEDD36F8B03F0A10@MN2PR11MB3678.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(52314003)(199004)(186003)(86362001)(305945005)(2906002)(7736002)(2201001)(6486002)(6436002)(6116002)(3846002)(66556008)(66946007)(66476007)(2501003)(66446008)(64756008)(5660300002)(71190400001)(14444005)(256004)(71200400001)(1076003)(6506007)(386003)(14454004)(107886003)(316002)(99286004)(76176011)(110136005)(52116002)(2616005)(476003)(486006)(53936002)(66066001)(8676002)(8936002)(81166006)(6512007)(4326008)(25786009)(36756003)(478600001)(81156014)(102836004)(50226002)(446003)(11346002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3678;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yaTIfTFWyG6lgNytlVh6cgjVbAHjhYvq37rhYUp4oiHCS5T8IVr6uY3Ib0wZol2XYYhKcJvLdx5+5nVm4KNCylecEQEXfyLZQ+gm3Rcn/mYZg5WbWnP/OvPKJvr0Njkje5fRavXQz90Nep/hmMsbuKXFzGmnbzIbyILywTk/r0t38MAgMaE23jZdtyhnzH87XZuFMCZ7rR/zH+1g8DrKUjfAW/dtQW1rrcFn3B417DWnnXtvfUYxQTU0mWSd/24ANuzN/reUCc3iX3zZhyJQXRiLgI5GgedStndZS6Aan3Xq2JDtgvsOcZBtm5mLJ02vnNYQ/EjR5rgshuukiL+x1Pi/duEM/p125Z5H08C1R61qgV5/FPw11nfeEqOGSBM+6F6h83sWbBEJjop07YXp9JiZk4lkuWNpAZgLV4d6jcI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdda10c-93c0-4daf-9bda-08d72a1e3223
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:09:07.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 930zTI0U1seAQ2V+GCsak5DnLtLHsubZOG7tYtrS6LEb+g+Ygeq3tgN4JuM8h/DqqQE9wnxsKlRlH+VhJxH9KceNFgdwFcxuVKkjoBueOTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Dedicate a function for getting the pointer to the flash_info
const struct. Trim a bit the spi_nor_scan() huge function.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: no changes

 drivers/mtd/spi-nor/spi-nor.c | 76 +++++++++++++++++++++++++--------------=
----
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d13317d1f372..ec70b58294ec 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4766,10 +4766,50 @@ static int spi_nor_set_addr_width(struct spi_nor *n=
or)
 	return 0;
 }
=20
+static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor=
,
+						       const char *name)
+{
+	const struct flash_info *info =3D NULL;
+
+	if (name)
+		info =3D spi_nor_match_id(name);
+	/* Try to auto-detect if chip name wasn't specified or not found */
+	if (!info)
+		info =3D spi_nor_read_id(nor);
+	if (IS_ERR_OR_NULL(info))
+		return ERR_PTR(-ENOENT);
+
+	/*
+	 * If caller has specified name of flash model that can normally be
+	 * detected using JEDEC, let's verify it.
+	 */
+	if (name && info->id_len) {
+		const struct flash_info *jinfo;
+
+		jinfo =3D spi_nor_read_id(nor);
+		if (IS_ERR(jinfo)) {
+			return jinfo;
+		} else if (jinfo !=3D info) {
+			/*
+			 * JEDEC knows better, so overwrite platform ID. We
+			 * can't trust partitions any longer, but we'll let
+			 * mtd apply them anyway, since some partitions may be
+			 * marked read-only, and we don't want to lose that
+			 * information, even if it's not 100% accurate.
+			 */
+			dev_warn(nor->dev, "found %s, expected %s\n",
+				 jinfo->name, info->name);
+			info =3D jinfo;
+		}
+	}
+
+	return info;
+}
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
-	const struct flash_info *info =3D NULL;
+	const struct flash_info *info;
 	struct device *dev =3D nor->dev;
 	struct mtd_info *mtd =3D &nor->mtd;
 	struct device_node *np =3D spi_nor_get_flash_node(nor);
@@ -4800,37 +4840,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 	if (!nor->bouncebuf)
 		return -ENOMEM;
=20
-	if (name)
-		info =3D spi_nor_match_id(name);
-	/* Try to auto-detect if chip name wasn't specified or not found */
-	if (!info)
-		info =3D spi_nor_read_id(nor);
-	if (IS_ERR_OR_NULL(info))
-		return -ENOENT;
-
-	/*
-	 * If caller has specified name of flash model that can normally be
-	 * detected using JEDEC, let's verify it.
-	 */
-	if (name && info->id_len) {
-		const struct flash_info *jinfo;
-
-		jinfo =3D spi_nor_read_id(nor);
-		if (IS_ERR(jinfo)) {
-			return PTR_ERR(jinfo);
-		} else if (jinfo !=3D info) {
-			/*
-			 * JEDEC knows better, so overwrite platform ID. We
-			 * can't trust partitions any longer, but we'll let
-			 * mtd apply them anyway, since some partitions may be
-			 * marked read-only, and we don't want to lose that
-			 * information, even if it's not 100% accurate.
-			 */
-			dev_warn(dev, "found %s, expected %s\n",
-				 jinfo->name, info->name);
-			info =3D jinfo;
-		}
-	}
+	info =3D spi_nor_get_flash_info(nor, name);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
=20
 	nor->info =3D info;
=20
--=20
2.9.5

