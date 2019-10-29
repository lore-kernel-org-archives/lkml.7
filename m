Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E6CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AC92173E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HAIn1LhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfJ2LSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:18:36 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7406 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732797AbfJ2LRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:10 -0400
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
IronPort-SDR: DISlY6m2kvLK+f24IbgFge7vN3F7Z11d1tVwTpDt7BoZrWF/n53A8pAMJsVVVVUdVf+MZ8qyki
 T+6cHakCGr4THGEcse+1fO0lZ8Lb3RH5h9/BdaZvuoFsExq5DtDkl6Qfb/gS1sdDLF5BuRB44C
 Jw3gcthvSuz9/zZecmL8Xc7ZfQHCeuMI4Bn4/3+dJm1u/zrghr6Uuu7UF44EBzaCbsJidcsZlq
 TZYRITFJ6IBoypMJGSbusXvOxITR2oUVh/THifBEEPOEBcuybPijpVGnIn6yaVb78iWtQrFzhO
 rRc=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="54794558"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:07 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8QG8Cif0jB7p+L1FOR3xqGqVRp9fe+FIVV7FfxzhxXEUnWaO9tWUL1+OUgFrtTF8L3a3LGJtJGSgWECbFLjl5g1JY/9o5CwMXlnEi2TIeLUT5qmqhU9YPkMtZ8D9twbOJCW9K2I6hDkPohTzd3TYqAzfjC5TAaEBE0oYOBg2kGmWkdpKesh2GuEoqZBqkk4M1ytpmrHQDz7dEN5jtiq0bZN7poqQPHNVJJ6o2uZ+fbe28KTl3YAT74ucvhSEYA8Jzdn5gtsPIrbopLZAlLPI8e5FZK3SLosrpgw5+ars2bwd9LY4rBA9RYDMSKF/Ddbomh+pjblJXXxRYmNABvl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb9/f0DTQnUfsmphWgJ8rjD+7haO0npSYpXeNomgGTI=;
 b=NqHo0No0u+Da6DVb41ACcdqO6urGrS5FhKCGKk8S4O99ueaUOthOloI6YQiwTamSfmVayyV00gaUhktYHE/xewExhzS9PidSVfLYegIlSK2yV6KgT2cE28GeMgWX1IlRv9bm+JQP4HeAj6gKnHBL4DDV6Hzn3Tw7RGg1p+1NZUIgVu0fEi0D7KaF2Ks3281yMiloC2bzc2AqE5cPxk66RxB1vNDVJRgStYroWqMsvFfeHeFMNNR8BNY/LawxShiIIIqiZ9f7JshsPS4B2fYdIxex6997mW+E8e45udbCUM1n6aEO+LzyMgyszuDd1snKmCTlcUHC3Ytx08alVJTQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb9/f0DTQnUfsmphWgJ8rjD+7haO0npSYpXeNomgGTI=;
 b=HAIn1LhXUKXKHBz7JWO2uEiKUaVuuCWEYaGWz3D5LaFu5nvBxLc4sjj6AgbvzHlR6UwcJHfjylKHMm4lpJ7te52iq5073Ukio83BtL6flTxnYyTLOedcWenBPnozzpg3uu0cJjT6lp0RpL7OmyGPy+Ssx5tF+8B3eGw38gS5FJI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:06 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 11/32] mtd: spi-nor: Drop redundant error reports in Reg
 Ops callers
Thread-Topic: [PATCH v3 11/32] mtd: spi-nor: Drop redundant error reports in
 Reg Ops callers
Thread-Index: AQHVjkplMcJSJ7ucD0m8Dk/rmpqoYw==
Date:   Tue, 29 Oct 2019 11:17:05 +0000
Message-ID: <20191029111615.3706-12-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 1fb8980d-adab-48b3-35e8-08d75c6187cf
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB38239106B63FE887A3A50BFDF0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(14444005)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pcc/0L0YFD2koJaTi/jj34H+pSAheoCi98sH0zpUdBTjyaiFbWlLiNJPFbyvweAhXvgSb2RuvXMpToxwfA58UuYru8EB099vjWNV7MecoPX7L3bvSMG0/CSSu0h8Y3AgXk7IPVBtM+lKO2tgE9V0mks1U0fxSuoxBWmeaUz5Rxz3Qo1ZeGsuTY/p3oarcINT/LXvyynsBdx1ZIxKhGox8bW01STvQzU3c8lM5I4ZxqVGZnp5SHTfuN7GC9CGYhTohRGu6c2DyteQyc0Tzf1aUYYidGEZeltPN01bDTz6SKmbrdqVrIdiY6zPHIIWRp0JIeB7Sn9DdSQ+lBMUd7EGs/xt2iNoTqRZ2lzMGwTAsOWtVy/KZgeyaR8VR3T4CUuWWtKhDNK82ogpmsm9Bh0iM9ugdOZQVZwTrI5ZOgmL+QVJzY2gczRY05OcThnNxGgn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb8980d-adab-48b3-35e8-08d75c6187cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:05.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39N0mRMXpldaXhZ4NrSklzUOo3Mv1cBElqcx8mCcxwIKuANIfu6spwbvvx113OrW8E52Xbmq3AbcsEn1V631VS83Wl5jVSY6iwVuDr21Lj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Drop the error messages from the callers, since the callees
already print an error message in case of failure.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 50 +++++++++------------------------------=
----
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index ec179eac2069..4a1ecf452a39 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -812,14 +812,7 @@ static int spi_nor_write_sr_cr(struct spi_nor *nor, u8=
 *sr_cr)
 		return -EINVAL;
 	}
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret) {
-		dev_err(nor->dev,
-			"timeout while writing configuration register\n");
-		return ret;
-	}
-
-	return 0;
+	return spi_nor_wait_till_ready(nor);
 }
=20
 /* Write status register and ensure bits in mask match written values */
@@ -1853,10 +1846,8 @@ static int spansion_no_read_cr_quad_enable(struct sp=
i_nor *nor)
=20
 	/* Keep the current value of the Status Register. */
 	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
-	if (ret) {
-		dev_err(nor->dev, "error while reading status register\n");
+	if (ret)
 		return ret;
-	}
=20
 	sr_cr[1] =3D CR_QUAD_EN_SPAN;
=20
@@ -1878,16 +1869,13 @@ static int spansion_no_read_cr_quad_enable(struct s=
pi_nor *nor)
  */
 static int spansion_read_cr_quad_enable(struct spi_nor *nor)
 {
-	struct device *dev =3D nor->dev;
 	u8 *sr_cr =3D nor->bouncebuf;
 	int ret;
=20
 	/* Check current Quad Enable bit value. */
 	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
-	if (ret) {
-		dev_err(dev, "error while reading configuration register\n");
+	if (ret)
 		return ret;
-	}
=20
 	if (sr_cr[1] & CR_QUAD_EN_SPAN)
 		return 0;
@@ -1896,10 +1884,8 @@ static int spansion_read_cr_quad_enable(struct spi_n=
or *nor)
=20
 	/* Keep the current value of the Status Register. */
 	ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
-	if (ret) {
-		dev_err(dev, "error while reading status register\n");
+	if (ret)
 		return ret;
-	}
=20
 	ret =3D spi_nor_write_sr_cr(nor, sr_cr);
 	if (ret)
@@ -1954,10 +1940,8 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 	}
=20
 	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret) {
-		dev_err(nor->dev, "timeout while writing status register 2\n");
+	if (ret)
 		return ret;
-	}
=20
 	/* Read back and check it. */
 	ret =3D spi_nor_read_sr2(nor, sr2);
@@ -1987,10 +1971,8 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 	u8 mask =3D SR_BP2 | SR_BP1 | SR_BP0;
=20
 	ret =3D spi_nor_read_sr(nor, &nor->bouncebuf[0]);
-	if (ret) {
-		dev_err(nor->dev, "error while reading status register\n");
+	if (ret)
 		return ret;
-	}
=20
 	spi_nor_write_enable(nor);
=20
@@ -2000,10 +1982,7 @@ static int spi_nor_clear_sr_bp(struct spi_nor *nor)
 		return ret;
 	}
=20
-	ret =3D spi_nor_wait_till_ready(nor);
-	if (ret)
-		dev_err(nor->dev, "timeout while writing status register\n");
-	return ret;
+	return spi_nor_wait_till_ready(nor);
 }
=20
 /**
@@ -2027,11 +2006,8 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_n=
or *nor)
=20
 	/* Check current Quad Enable bit value. */
 	ret =3D spi_nor_read_cr(nor, &sr_cr[1]);
-	if (ret) {
-		dev_err(nor->dev,
-			"error while reading configuration register\n");
+	if (ret)
 		return ret;
-	}
=20
 	/*
 	 * When the configuration register Quad Enable bit is one, only the
@@ -2039,18 +2015,12 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_=
nor *nor)
 	 */
 	if (sr_cr[1] & CR_QUAD_EN_SPAN) {
 		ret =3D spi_nor_read_sr(nor, &sr_cr[0]);
-		if (ret) {
-			dev_err(nor->dev,
-				"error while reading status register\n");
+		if (ret)
 			return ret;
-		}
=20
 		sr_cr[0] &=3D ~mask;
=20
-		ret =3D spi_nor_write_sr_cr(nor, sr_cr);
-		if (ret)
-			dev_err(nor->dev, "16-bit write register failed\n");
-		return ret;
+		return spi_nor_write_sr_cr(nor, sr_cr);
 	}
=20
 	/*
--=20
2.9.5

