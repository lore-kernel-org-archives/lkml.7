Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C01CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3CB208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ueOaUdSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfJ2LRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:03 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36056 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfJ2LRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:01 -0400
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
IronPort-SDR: vVkiiLLHSRaxMpfpK3Ke7rSlW9pnI3n6e7sLdSFdw+FajeKC6T/E9Kc+8a3ZOl3rDmVQwSIlrj
 tFM6WNynvCRzNsb1nyEogf3QsFQ7gP2vWHD0GsK4IgB7ToE6Om+d9jp+OjATqkc6Rrezgh8sZ4
 u+UC+fjkuJQ8bcvVgHtJp+avAY7P19VlAUX47TACbb/g0qJP+z87kwtD6Xr+63XbBIsaI22RTq
 5hIx+0maZaxaPL1SsfeN7Gutw4aBuKV7iRRSe/9fZwNCddFvlIcDdbl44ufx9zttu3Dzu1u2Yq
 +t8=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292001"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:00 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 04:17:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYpY4eyNX5ibytc0fWhd8S7Tm3iVU0/HXbgCiXZ9QVyaZRM8Q93zjxysw2OSG/T9AHBDCeW7wxo5BgVQPtMqJWMZKWljNdtLnmVJrLVthN5mHR0DBC9GZfVsd92ESNQIb8IoXicGbGR0jxZ04ecc5TjJmQYdbg0OJy0CjMls6sX5Q/plQ+pb1t6nQhyKA6qLO03zyVqAgoNBqrcLI1+EYX5/W/WUs2kajv80bmR3fb2O9MQ1fo51xvYP9Cj5wrN38csyZ90QCDhshKH1rqLghH6iXdRSaNjCOA2qlj6c4JWiiO0t0gV9MyG0ahL535WvRFKfUOMENH4PF5Y3NunErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJfm5jh4Oz8X4fs+TaeWisQS8JOPbKaUWsgDfhGp8fo=;
 b=VyJYyav6gHAtL66JYhM3NObCMSemsoA6z2vhjtEP8n/l00D0WIeskltNkwT2D6EPPo6OfMU9I+Bxx9YGcfMghhFB8A0g9TQ8qVZErCHcon2r/rw82mqlzsGx8ghlv+kxnmEN4u0d2LWuy4epFOHWMpiLa7eMRvkDowWhhKhe3WtVQtTTFq48VfcjP3pTFnBPibCN+ng+SOTXw76P3yvFIf3Xx9iNniRrzgVW24KpKXtMehcIMo/OFVKTf1gHEH/s1O/cXVH8LWdp+G/XYl3mFhLmX3Y7rjJOCI2nO5op26Ht0vXNvg1EsP8qC7ILk9FF7C6bSxVNRdURcOezor5DvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJfm5jh4Oz8X4fs+TaeWisQS8JOPbKaUWsgDfhGp8fo=;
 b=ueOaUdSNF2m+RIdpJEyvsU29NQ/ifnAcf0P8XTGZGD+DeyLhZbX2g+XjPT4LzoDIjkT4vyeuWrkybUcDahR8ztW2IsZTTQV1ZK/7ldi+8UVa9mp4p8MVCflQss3yCef6uivGLGe4NynOSB3kKPrRiZ4YvwzZV9qeMHdv5Txevsw=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:16:59 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:16:59 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 07/32] mtd: spi-nor: Don't overwrite errno from Reg Ops
Thread-Topic: [PATCH v3 07/32] mtd: spi-nor: Don't overwrite errno from Reg
 Ops
Thread-Index: AQHVjkphLyVSrUAb9kyKn0dz1sgAkQ==
Date:   Tue, 29 Oct 2019 11:16:59 +0000
Message-ID: <20191029111615.3706-8-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 6a11ebe0-6295-4857-9289-08d75c6183f0
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB38232920B4676AFE17C75A80F0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lK+J0aQ+J7hmuyYns5kCzshQatVHTPy+eIB/Jqm4JzC64kSLytZjoUP2ATwKTmSa8JS7H4DB4FFCX+93Ymc9bQvw8b2aPhSCwnpx+9elz2AM3huGCFK79wd93Vn5YBD14gJZ3S4JRBQlFUNkLS3OvtCidJFvUBQzDO21k+ysrPGE8C1FDrH0QjxMf9RPGnsKuXkB2TTDpE5dF2DLwqEaF9UO5G1LTJEJSXeal2hcOA0yYLcQNd1AbjnFtrZzMPZEK35O7dy95ZtUFbQ+SyT0hbiU/5lj35Pk3jJgMyBr9q3xM87FxD9VlW8fQRQ2qFhsAyybtQyBK4z7vyZPqT2m5jKtrMwVPO8fapH2RJA3rhS5bwGxwNu4cRh0YsWS5hZki7e2p9KQvAM7q6eO5NaW1xZssoAVl/3GGXbMAUvoVVqfIH0Y4nnjml6rSBoXjSU4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a11ebe0-6295-4857-9289-08d75c6183f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:16:59.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu9f9vkJGFXBr0HhXMfAna8/rRDsqwSHvuIxEQJVnJ8obcx/ooYfN4xIY03ghjKV5xr1CS1PFxxPforGz89U188UrsploGjFvbuVxDIcbOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Do not overwrite the error numbers received the Register Operations
methods.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index c794eff69fe9..1a00438fd061 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1364,10 +1364,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struc=
t erase_info *instr)
=20
 		spi_nor_write_enable(nor);
=20
-		if (spi_nor_erase_chip(nor)) {
-			ret =3D -EIO;
+		ret =3D spi_nor_erase_chip(nor);
+		if (ret)
 			goto erase_err;
-		}
=20
 		/*
 		 * Scale the timeout linearly with the size of the flash, with
@@ -1839,7 +1838,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
 	ret =3D spi_nor_read_sr(nor);
 	if (ret < 0) {
 		dev_err(nor->dev, "error while reading status register\n");
-		return -EINVAL;
+		return ret;
 	}
 	sr_cr[0] =3D ret;
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
@@ -1870,7 +1869,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 	ret =3D spi_nor_read_cr(nor);
 	if (ret < 0) {
 		dev_err(dev, "error while reading configuration register\n");
-		return -EINVAL;
+		return ret;
 	}
=20
 	if (ret & CR_QUAD_EN_SPAN)
@@ -1882,7 +1881,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
 	ret =3D spi_nor_read_sr(nor);
 	if (ret < 0) {
 		dev_err(dev, "error while reading status register\n");
-		return -EINVAL;
+		return ret;
 	}
 	sr_cr[0] =3D ret;
=20
@@ -1932,7 +1931,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 	ret =3D spi_nor_write_sr2(nor, sr2);
 	if (ret) {
 		dev_err(nor->dev, "error while writing status register 2\n");
-		return -EINVAL;
+		return ret;
 	}
=20
 	ret =3D spi_nor_wait_till_ready(nor);
--=20
2.9.5

