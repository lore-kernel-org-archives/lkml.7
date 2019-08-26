Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0A9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0960921883
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="DQDQOjyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbfHZMJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:09:40 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24968 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbfHZMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:09:08 -0400
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
IronPort-SDR: +cWE3UK4kxADAkXwkfd3ldxdvBkWTYAefW9na6aoou0f4hTJF5hISjnrpJRzoJq5J9Xi3/HYrq
 q22jd8vUUvViPKfrCRkiSsrRa1ykR0RairRw7Vln0ROAya/YavyeH69FQaM4ICvvZto6Y7WTe+
 drXn/zuMZ7AH8S8/lXOyIWvgWz8ssFiy5oQu0/6J1YwZfZHmNOgJVLDApZ+BrtKuxv9pFI0iUA
 LDltls/0IIk1mCS0rQbbnwVP8pc9tr2f2fyLMsN3eMtD4Qw201exzz5xibaE1gWPOkN7McprPb
 WrQ=
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="43686997"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 05:09:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 05:09:07 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 26 Aug 2019 05:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZllERcqDEEmYKjnRku+J+s8VoMfLkfPe1i5ubYCMor1XeajPypkkoJb8vPO0rraL3KCPjyxpGJ6bJ2mtGrJr9GLX3q/V5HjOUfVGBKr3zNQa6sIVZE14JP9/U1F7X4QjBjSmQQi3aAb6ng8a48MCxDWTwfOF6QkavEmMrFOKOr1ko4y7BzjW2XMhddSxYsx6tUSt3P8eGTGCEuDiqChq91TKv8CYs+yrsCT7qMAivXNtg7WhZ/8GAOGtWopELXV8mSWnHNsvynv/fkFvkyewcW+N836m4NpihK24vZfApDIiswg6P0FonbCnWAuY/vzKu4KflCoKy/zp9m8a4ut4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yK9dRxC9iY3j+O2ONywA5bmxln9Fx0o7B7YIQAhH6g=;
 b=BFXi6nuLhNaZySALgV13ptd+uqi6TSP2KvvTkTHbRK4kBNnzPk7pdLgTSoPmdGyv/nWP1cKGHqgGPwh+WTuLNrdTvOFGVDcohzDm9X7NzMeK4TmKLKDOreHOyTnnV0ieqM72hLbipqOnAQOJvAlczTyuK6geqAe8MQGBnllNmYphjRciDNi3YKPrYD4wQHW8ESw49EfPdoodMP6v3IEclZcWFKODPPy5P2CoMk5Wn1XfwBwcskCeBazgI/VEqxD5GK+6Z3EiFUBFL7EXWtwoACvHNN8CEMdlcGj2zS5b3Aa7HBB/TyR2u4QMBD/8IpYHigTJb20DJZqm/PLwBg/9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yK9dRxC9iY3j+O2ONywA5bmxln9Fx0o7B7YIQAhH6g=;
 b=DQDQOjyN/BOTOMswJAlzHB+Id5aRD8H8QI0VJ5FfmeC8Sl6+jSQ+WoPNTWQvWFqkAoLnBZkVVnXRFVdXHgAXECPFIDIy9XsrNr/KrprdkP9y8CXAo4JC0HkqfuRtBnT30+AYrKfj2H2GwPJP+qdd+3C4Frb/aNL57Jy4AEsy3GE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3678.namprd11.prod.outlook.com (20.178.252.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 12:09:06 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 12:09:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [RESEND PATCH v3 15/20] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Thread-Topic: [RESEND PATCH v3 15/20] mtd: spi-nor: Add
 s3an_post_sfdp_fixups()
Thread-Index: AQHVXAcLGug0TlbN8kamSzLVrzO6ow==
Date:   Mon, 26 Aug 2019 12:09:00 +0000
Message-ID: <20190826120821.16351-16-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: c7e0b2f3-6486-42fb-336c-08d72a1e2d9f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3678;
x-ms-traffictypediagnostic: MN2PR11MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3678A0E4E465C8EA58E2DCF6F0A10@MN2PR11MB3678.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(189003)(199004)(186003)(86362001)(305945005)(2906002)(7736002)(2201001)(6486002)(6436002)(6116002)(3846002)(66556008)(66946007)(66476007)(2501003)(66446008)(64756008)(5660300002)(71190400001)(14444005)(256004)(71200400001)(1076003)(6506007)(386003)(14454004)(107886003)(316002)(99286004)(76176011)(110136005)(52116002)(6666004)(2616005)(476003)(486006)(53936002)(66066001)(8676002)(8936002)(81166006)(6512007)(4326008)(25786009)(36756003)(478600001)(81156014)(102836004)(50226002)(446003)(11346002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3678;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RXC6BUH0PS89gCigq/42s5pMGWHujVUrypQA2rOWFeUZxbNgitlkPgxWqoEmp2JJNpQsyWNkHrzil6QuBhBsOSyD3dQMdnuLJ+RKApVFjXIvvDR17pCMyOYT7Ole6u7dPRnx8CYOOM5YVj5EpYu3VzqvgmAhXQ9VTBnKdb/t6Va/ldxwSowLXSvS7ankdHdrVPrdl/y0VY1Rz6TZONV757o+qdn9zRLvgcMSLRV/8F8xw23FIGxzLbJ54ne57DLTJA17WQhlT0/enWQ9Hxap6NAkn9MgP/pPmU/8ZA+HiputxrNAocbdXeCMPFfIWmS9Bs5byE5vQ7mTuxG14uLdT/B5a57J845Wd7MsSS+YowMoW9JUT1InJc4oSFFH62FL7QZNW0ziw0xs0wu+xyMfOJ32jc7NkSYE+ljGbvT9F60=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e0b2f3-6486-42fb-336c-08d72a1e2d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 12:09:00.0897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ra4WiIgyXE0fuTtc3GD/4b1Viy851cgyALWbSuJzhOoIjdp6nLIArOsgz/D1LqaiW8Ixm0sFuP5u4Emk8qKHIp8rMSu11uGeD41gCwGlmQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

s3an_nor_scan() was overriding the opcode selection done in
spi_nor_default_setup(). Set nor->setup() method in order to
avoid the unnecessary call to spi_nor_default_setup().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
v3: no changes, rebase on previous commits

 drivers/mtd/spi-nor/spi-nor.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 2aca56e07341..edf1c8badac9 100644
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
@@ -4530,6 +4531,11 @@ static void spansion_post_sfdp_fixups(struct spi_nor=
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
@@ -4551,6 +4557,9 @@ static void spi_nor_post_sfdp_fixups(struct spi_nor *=
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
@@ -4899,12 +4908,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *na=
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

