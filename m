Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7D6C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61D92173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="twhsuPys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfHXMHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:07:43 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:58726 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfHXMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:07:38 -0400
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
IronPort-SDR: 9WdpyvTa0od86DSC0n0o+UdnMCoKur5mAsx2qI/aEwF3kIPJ/axpbnqeAwxcQD0oqJX6d/DoI3
 NYWYa9Wl7F6zzbZcC9Wnxkr77PR8kyT+AO10omNp4GkoyyiK39xQTwPHqoIu6KsklP7AGQapHo
 ayLLU9VERgJPv88nSafxLMHXbip8aXHyuKjJCEgQg1WiPYJ3SMbTP9uyu68QT8HWwMd3Qsklx3
 MDkCfvA5LD2PvNMq9TV6UkpVH2K3t/Kl4bObrkSCvlZ9PQT/697DWTAeZEmllXqnA0RqooFWFv
 wlM=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="46465209"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:07:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:07:16 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 24 Aug 2019 05:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9DYMNHYtZOqAX7Y1St1aGk/8UqieqnQJvg5wg9NUHARbwC0YesqK9N8LI3bOVC216kobuum6rurfGd7qLWQuL5OIYBOQnESMPWHnL+Amkz77rbWQFcWYld6h59lbesO0xjXkIVKQeMDY4136IWxVGX7sCI2FwimAfDeLdjn+euZBh6gBWlFwhW4p1sq3MWpc9eyTWdYMTOmZOhuPAwgQ3hb5L3BOUujhi6l0+bxp7cxK4NUmPpeqRupK5H3B6q3Mk82MI4TCdkg/V5vftJzvexeU+Yi0m5qH3PrHDsvSerGFkee3sexlKrSwoQwe+0o69GNJ6PWEaB8HxW0mYszOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpzFaDgbcXHoo8Uw7cs0pQz7kc/BreeNiNd713yqEO8=;
 b=AtfLjBORUTAZJawHU93cPE9GLylx4W10xMjktRmdq83gr6Bp+afFjwX6m2Ik+9N9CYeOe3/cxhf6JUPE6Twiz8ERdEVk1/OzqNI+xjWb3v2Z28KLMjUXHqEwBuGdm+2J4mdjhRArlK507nEbBWvG3Yt3rHj6iqbbQ2hIJXQUUfbOUwjJGI2h/QtzyW0g6/C6vBNJZ8cikhREAhzGQW7SvtCfcBFlx4mAywQADWnvHO/ArIMZn3L/0ATQXZJ85g3YU9cdp3QrQSlwpv2pCw/PxlW/CTBFaQxebjLroqRW5c212K12UWpk190fY0CIdM7W5uRvFVSHRS6qQhJfA7V5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpzFaDgbcXHoo8Uw7cs0pQz7kc/BreeNiNd713yqEO8=;
 b=twhsuPyssIOLQD5C8wM0DU6AC3OI0X1OaZRrytnhx4AO7wxnZol74pEsf3NFQg8/osniITIQ8nwdB2E04tBFouiN4oFs8Vz2qdC5AwiyUP5cF4IoLh4bU1gJZgnODd5Q63JX2k9t4je04LJIJBe/rrG2Ps8jDrvyqKqCCpm/wM4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4301.namprd11.prod.outlook.com (52.135.36.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 24 Aug 2019 12:07:16 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:07:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Topic: [PATCH v2 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Index: AQHVWnR4/TuQBJXYtU21nQDNHxeQOw==
Date:   Sat, 24 Aug 2019 12:07:16 +0000
Message-ID: <20190824120650.14752-6-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3ac1dba0-d8a4-4fce-1301-08d7288b9aec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4301;
x-ms-traffictypediagnostic: MN2PR11MB4301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4301768760988AEEA11ECF7FF0A70@MN2PR11MB4301.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(305945005)(99286004)(71190400001)(1076003)(71200400001)(7736002)(3846002)(6116002)(2501003)(52116002)(76176011)(4326008)(478600001)(2906002)(316002)(14454004)(53936002)(25786009)(110136005)(107886003)(5660300002)(386003)(102836004)(6506007)(6436002)(8676002)(186003)(66946007)(26005)(50226002)(6486002)(36756003)(8936002)(66556008)(64756008)(66446008)(66476007)(486006)(476003)(2616005)(6512007)(446003)(81166006)(81156014)(11346002)(2201001)(86362001)(14444005)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4301;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kSuKhC252XN8YbBvKxljPTei242j+bOcdkCnx0/JASNO8+c7n8nMTwEiVgkVzu9AYQakOl3U0vpvw/uCX65eHoOVFtNWlOX5WuaEcI/RS9W15vsAmAbDcNM8Jh31/NdtK/bRg7kq0VqrkLgE7wacacY0XmX2MnbUXLO8CdN1ZHz9AYJgAe8NJRi5LGWuoX2pwHdGu/680f506Ves41CnhoX+Q8UaDrUAxYgUwMO1XWNmvltI/paV/f9qqpTEKvW3risQggNQqxkyaSy6YDM5AUIbUEFvRU57N+r5eqrv6737ahoWQ8Cl+Bj2ed/BI8YUdRa0ZjJCUs1UPNwQctLNtUqV1uWteIyiXpej6CcvBn05Udluc1QqiEWIWwlfmkgrXGdHXfIj6omUCP6puFzy9DVArj2xzYMoKnFp3ioCnDg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac1dba0-d8a4-4fce-1301-08d7288b9aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:07:16.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6emF9iU8nUl75cgfLgs65lY49Pr0pSRP/FQIVC3Oho+T/tFtv0j3bK56FeTJQWFrw0iF0gQqiPZqN4AhyP9Zdpbe/20kGy7Z5YXDqzmpUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

s3an_nor_scan() was overriding the opcode selection done in
spi_nor_default_setup(). Set nor->setup() method in order to
avoid the unnecessary call to spi_nor_default_setup().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 17e6c96f9f9a..5e16f293a83b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2718,7 +2718,8 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
=20
-static int s3an_nor_scan(struct spi_nor *nor)
+static int s3an_nor_setup(struct spi_nor *nor,
+			  const struct spi_nor_hwcaps *hwcaps)
 {
 	int ret;
=20
@@ -4546,6 +4547,11 @@ static void spansion_post_sfdp_fixups(struct spi_nor=
 *nor)
 	nor->mtd.erasesize =3D nor->info->sector_size;
 }
=20
+static void s3an_post_sfdp_fixups(struct spi_nor *nor)
+{
+	nor->params.setup =3D s3an_nor_setup;
+}
+
 /**
  * spi_nor_post_sfdp_fixups() - Updates the flash's parameters and setting=
s
  * after SFDP has been parsed (is also called for SPI NORs that do not
@@ -4567,6 +4573,9 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *=
nor)
 		break;
 	}
=20
+	if (nor->info->flags & SPI_S3AN)
+		s3an_post_sfdp_fixups(nor);
+
 	if (nor->info->fixups && nor->info->fixups->post_sfdp)
 		nor->info->fixups->post_sfdp(nor);
 }
@@ -4932,12 +4941,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
me,
 		return -EINVAL;
 	}
=20
-	if (info->flags & SPI_S3AN) {
-		ret =3D s3an_nor_scan(nor);
-		if (ret)
-			return ret;
-	}
-
 	/* Send all the required SPI flash commands to initialize device */
 	ret =3D spi_nor_init(nor);
 	if (ret)
--=20
2.9.5

