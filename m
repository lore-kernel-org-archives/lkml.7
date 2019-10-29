Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4933CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB3D208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="i7neZ5VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbfJ2LRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36131 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733025AbfJ2LRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:21 -0400
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
IronPort-SDR: 6H0ZMFE6eAbtHYceol178w7CJtkLJKVWBwQvcyEn7au6JziHJevGpB1REzV+p/m53Tms7eQxWX
 mxp9yjB3eIhD7wSKJLOFcqyQRSS/9kPhQRufHgO/56h7ko76vuSepdCSQywMY9rpzAj/Z05G9Y
 uNwW4VgIqOzHDO3SacxV73qQIq2T1FiWtssbioMUEd2G2t8osQxkRfaq/VGTMHNXv1H40ma+oB
 n20k5kpsKApI7DCPxxG8cyX9MRayVl2EcWpkQ86dh+5XLuRArWcgz8SBV6x9TUllfTd+QtiYPu
 VsU=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292087"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:18 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOXrzoCtZQoXNEbX/47e5ysMqLhAbp79iLHXNinPm9lnRL+cTxQvR9Vgg6niFpeTH95W5n84BcR1NFz9OSuhnuSSAKoDgWBfKwlwVMEHpyWTdVAaPhUGXkWmt2dpU9mkPxCGXwerRx16HD2PMEaK52+3dNwOxKROOQRz5rsILFte4936dDfvWDdMSJnkj9ODzPD60Xq37CU0mT7g3b1lyfUz30HjKkg/6TJk/eQJX4J+8BAhKpoJ+9HoQbdBmjXzj/EQuIttU7nznpPZShU+lZw9GVAtQnH3S1R+7SQRj5G/du3YB2bNtsj4uQM1/qlUbihWXZdty5XgiReoYs1Xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxt0/FmEoaf0ba4+d7BLBEpJnSSmujMti1ZQxMGx0zo=;
 b=hqWiudeznYlpa5gnVeSk0ct24sUb0FBVyH4hfyEfC2TxklQtowxX4pbfioQnPoVKgECo8e2ey+u+zpolvQpabZXjtFyRCbR+IE5pBq9fgEKIcK+x6Z0qhXrnSpPUU4c3Upaaqi6YnakZ/UJItmz95/Ead5lCeXRm3sg8vmHv5B5WZh4OgN5EdmfHRkOFCJPmEcg7HfuKGr5tN46lXa+idMsQ6L8LJU9J17v/NSrpMtRSMy/e6D+Y0xrlZe2PGmuf6Ypz4WUNQyknDDVGPYdYAURxeWsPsWY/B54QIfrlwmBvcllVUzmpXBzh9TE/GZnGfnsoVMfdQ/xK9TL+ucf+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxt0/FmEoaf0ba4+d7BLBEpJnSSmujMti1ZQxMGx0zo=;
 b=i7neZ5VTHLRUxprZxZdtSKlUi5evLj/XZQ+L/js25xcHD1U9jtPuvS6Q+w7/jcgdJiDHsjpOnwMaAZoU4Qb3Sqap8hQuDdy283NY1OSWACxWlEtNYH551b5PvlPUxxeQO271dnxnHcGE4/d8L/oxtwJ+xCAMT952sJ18R+XZRps=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:17 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 18/32] mtd: spi-nor: Constify data to write to the Status
 Register
Thread-Topic: [PATCH v3 18/32] mtd: spi-nor: Constify data to write to the
 Status Register
Thread-Index: AQHVjkpsCYpkWXjL6ECEsiVdkEng9A==
Date:   Tue, 29 Oct 2019 11:17:17 +0000
Message-ID: <20191029111615.3706-19-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 8b00f110-656a-4156-6adf-08d75c618ea0
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB371271F1D8C725815C3344F6F0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(11346002)(446003)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(26005)(99286004)(386003)(76176011)(52116002)(1076003)(102836004)(71200400001)(71190400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TMoxIuGxo7Xna48DWLUR2jfLB27PKVsAcIm4it1PkrQ0RbX1RhisHgGd66RY18ct3saH2kPQCC7L5YAwjl6lSFlHhKSLLPpfCpUsvfSKlq5ec9PNVNGz/TA8QvNBIZ4fmSwNhjL1qJ0SDe8uMh/JanXINr7ipnz6Uk+up+phm3nF3W1a/CO2rk0mnE0adyQbHQO3xnUcfiPR11qacWfMZ1JZwDhCOQYCM0grI0VG+Nf+ph17UZnNJMP7AunTQNdsjQBDdXxoWBmWz7Vym7KskGAOzuFNtjviJrPeemC1SZoj4ORJnykdNNSAQqVXDD8N1qtr9At79DL5elEczSXErxnS0xMjq02dYURgRj8qqkAGA4cDrlhwPoYvgL+Sjby6wxtNk1gGo8qd7RTOkODBM7eSJRr0X/VgAQRtTA4JO638B8mIxW/Y4IRx75vnsdZb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b00f110-656a-4156-6adf-08d75c618ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:17.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9C0JCUXjteGfCq9hi2TFzzLDSxzlwKuZgNpA6QuA8UTx/skq3JDwMSbd0VM+p4p/PeLxxxewHQcU8rcEjcLsrTHu+Oh0AKTsKZINzOmPP3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Constify the data to write to the Status Register.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5fb4d953b5c7..274786e1988f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -865,7 +865,7 @@ static int spi_nor_write_sr(struct spi_nor *nor, u8 val=
)
  * second byte will be written to the configuration register.
  * Return negative if error occurred.
  */
-static int spi_nor_write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
+static int spi_nor_write_sr_cr(struct spi_nor *nor, const u8 *sr_cr)
 {
 	int ret;
=20
@@ -912,7 +912,7 @@ static int spi_nor_write_sr_and_check(struct spi_nor *n=
or, u8 status_new,
 	return ((nor->bouncebuf[0] & mask) !=3D (status_new & mask)) ? -EIO : 0;
 }
=20
-static int spi_nor_write_sr2(struct spi_nor *nor, u8 *sr2)
+static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
 {
 	int ret;
=20
--=20
2.9.5

