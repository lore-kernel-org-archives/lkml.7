Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65476C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290CC21874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ikF2eSKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfHXMHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:07:39 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:58712 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfHXMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:07:37 -0400
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
IronPort-SDR: 2BWvKmsIxGxLW0bCaP0EZhjXmG5YrCrcJxPS9bTdiwrtwXrGoWVC0swFJicdW4jzF39VzgEtan
 7wIiXK1YIurvTXO0TuaW3WSsoS7rSIpNUnU19oROkKFLAJ6WzX8tNviZizZV185FeN6RYq7mYp
 c4atPZivLdgqx5GtAQYq15bBwsqgLbIFYy0JmrFy1wg0zkueDrGgdO/BYXzoe9J8TxDd8fLcmF
 PxZDeu2FEnzQfb9A7GzwZlLqFsWfarSYcGoepN6qvNMsPLuTgS62+R/80jsknpUNzmmxUcVmB+
 y4Q=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="46465198"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:07:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:07:19 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 24 Aug 2019 05:07:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GayKpOrize0oNrqoZ4WezwYjDeznjym8ZXLBNbwwxPotLP9RP8DajpuaxyXcqRlyUVad5QTGsUlORARQTL8BV4UjAl1A6T6q3zh+h14gCmI8a/iO3foWijU3j7bayQ9A6MvjdqrHWiMRLbkfpLaJziY11Vf9Dvkoem18zsr2O3VUxkrT3d4GjePwNaVhunJr7j1mtmo+Pz1ELBaJYK3oa+eYg/IdKIJHVaWzE/gWQeeoytZq9JnunAtz9vNn98Fe5P+M8QPozbxmEbU6v5wyMw577zJXRwOucWSTpcgJItmo+fm+cwPUgpMCKG7W2+tVubgsgB5Z1MxUKCLkDdufPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R72FliOoqWnY9hgStVwNYkqo9/Oi4W09P1KoLP2eH94=;
 b=Lw4Ato6SMQnvmJvn1Dj2nMLIY60xPJU/EP4di1cY3dnUukrQY6PenmqhibAd4rw711ipVfKV3xTNp8pfL3bmha2XUQV1pEtNXTL1mT+Ve+Ma2uBsvYvMomn0z15G3+Psc22a3Vy1YJbQwpjSTA+U59cd6sFlKYDnN0/9KKlNycA5YTGvkxnjM7tONcEUcrSAZsOGCzA4PpWf9wueoud7HbvDEdLPWkaLcNSeIz79cHqZpeBjbrng8Gm3TDclPB/Ma7tQQbALjyTdoitoe/Jxt/8zcr/8bsFYfS23gsqBABKMv+jRvPr/B6kzRtTVMilcuE+OOHTQZ3x6uXIocc/2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R72FliOoqWnY9hgStVwNYkqo9/Oi4W09P1KoLP2eH94=;
 b=ikF2eSKjfhgFBTa/M9wKeSNWc0R1rvSOhWKChf7dQMOhKCpNAyF7splUFCU1fL+V9Qdvnsyxpzk/FmIgjlSD/KUKgD0fzWFf0VkC+YU/qwzcCj1oitzZ9mDM2hXkM0cf/pcngUOv88Nr7wrh5Kz3mpcYKsjFmaZTU4qPKDRaNo8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4301.namprd11.prod.outlook.com (52.135.36.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 24 Aug 2019 12:07:17 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:07:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <boris.brezillon@bootlin.com>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 6/6] mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag
Thread-Topic: [PATCH v2 6/6] mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag
Thread-Index: AQHVWnR525fTUtp96EeU3jpXKgU9Ug==
Date:   Sat, 24 Aug 2019 12:07:17 +0000
Message-ID: <20190824120650.14752-7-tudor.ambarus@microchip.com>
References: <20190824120650.14752-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190824120650.14752-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::37) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d918e984-208a-4362-9785-08d7288b9bea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4301;
x-ms-traffictypediagnostic: MN2PR11MB4301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4301B7E2E8E5BEF5780E8B1CF0A70@MN2PR11MB4301.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(305945005)(99286004)(71190400001)(1076003)(71200400001)(7736002)(3846002)(6116002)(2501003)(52116002)(76176011)(4326008)(478600001)(2906002)(316002)(14454004)(53936002)(25786009)(110136005)(54906003)(107886003)(5660300002)(386003)(102836004)(6506007)(6436002)(8676002)(186003)(66946007)(26005)(50226002)(6486002)(36756003)(8936002)(66556008)(64756008)(66446008)(66476007)(486006)(476003)(2616005)(6512007)(446003)(81166006)(81156014)(11346002)(2201001)(86362001)(14444005)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4301;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zFYaW7St5ysJ/DBGZRo1+9dpgcCcxWesst+fc/54DmUeOetFoUwCbCvWggiJDx01pWpxHY9eqVTY6zQH5//PFyRA5+H3OsGw0SlUKRpqKA5kzv9ER5F5TVQa35fkdr/kHSS92E4/CEEcO2dDCf9ii12DVwHnBCeXU4067ceKzN5HPcUmgSK/VpaK4tsKmo1R4wTpuE1zMyEGoC1B7SuCkU4xneLxK4Ur2nQXxdJsSN4epVd5xowiawmqHT9JN4UKUwkWXcpe95GpRbsBNkR559GjGmliBO8NgoMiCxWr4x+PWtIiVusyRNv8IjChu1HQAtz8HZYFWgzyNYwTnD65elqiFcs0LI7csodXRB0TbgSEUTcHkSrkK92PPazCqIuXzabqHHrIr5rS+nBRh2+1sLr3cb5JSe5iZerZ7ZSOojs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d918e984-208a-4362-9785-08d7288b9bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:07:17.8971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEe7nwo97LorajRvqDswtw7PuXniLORxPglFiXMYloOZ+0V6hHq6yy3YeeAiirnHtlKboFOA3cHh1QtGEN2I7l9vQmMKp85G2EkkNA8P8lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

S3AN flashes use a specific opcode to read the status register.
We currently use the SPI_S3AN flag to decide whether this specific
SR read opcode should be used, but SPI_S3AN is about to disappear, so
let's add a new flag.

Note that we use the same bit as SPI_S3AN implies SPI_NOR_XSR_RDY and
vice versa.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5e16f293a83b..e76c23d1c54a 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -211,6 +211,14 @@ struct flash_info {
 					 * bit. Must be used with
 					 * SPI_NOR_HAS_LOCK.
 					 */
+#define SPI_NOR_XSR_RDY		BIT(10)	/*
+					 * S3AN flashes have specific opcode to
+					 * read the status register.
+					 * Flags SPI_NOR_XSR_RDY and SPI_S3AN
+					 * use the same bit as one implies the
+					 * other, but we will get rid of
+					 * SPI_S3AN soon.
+					 */
 #define	SPI_S3AN		BIT(10)	/*
 					 * Xilinx Spartan 3AN In-System Flash
 					 * (MFR cannot be used for probing
@@ -4839,7 +4847,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	 * spi_nor_wait_till_ready(). Xilinx S3AN share MFR
 	 * with Atmel spi-nor
 	 */
-	if (info->flags & SPI_S3AN)
+	if (info->flags & SPI_NOR_XSR_RDY)
 		nor->flags |=3D  SNOR_F_READY_XSR_RDY;
=20
 	if (info->flags & SPI_NOR_HAS_LOCK) {
--=20
2.9.5

