Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F342ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAD020663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OcfE2/zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbfJ2LSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:18:52 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36056 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfJ2LRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:04 -0400
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
IronPort-SDR: 9jNvIsO1AuZRJnyN7Kgx1gxZLhLb1LaIMrySpBEfVyoAp6TtIgSuek/ggNlHQ8Mctu2x+64VhF
 YszjC5v57GX8N/IGoYFHplsl3vJ6PkYyPfpfW5GsEQ/HI7DSNvpHUbkYCy/6jHxyQ5BGnXQYD7
 ahicPDRXRI/7O/n2+smZYKE4kUDXkUwhPy4n28LFOePSDA9UrX/n6wtQ8efc2HcdWNu4YWqHRP
 vz0/vjQbRdlHIcEhWnKzilYW/F08iAikbLK90VXUN+GYOh0yur+olj1zA2+ZKEeRxZBzGGlHlA
 5Hs=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292015"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:16:57 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 04:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4ASzFX5Ed2PehTrq+oNXbabsycCfP+4MFugiLuyASvZS64QxZ3Z1jHosIRxWc5YfSBrJeKhmJnaHakTrb7JmgLmiR6QQ7zsQDwRwCQcON0Ih/OBb9/uUQCjqvw2S+fwJ5LEeHnXsIFzwWlWbeVWVzbWaBcc8LEM8JY7HSQ2ns8OCID/f/BKC1EfStk6XU2PX/STXZkgvVOvarknpajjRvEftNrCpqIlcEmSr1vv3xLzt1MXQceEuDDMWRsUH5flzSSq0HheWcJVyqzYLMe04gano3lWRLYITdzhzrwe9ejW2N8lP1Cme1Hfy05FVD4aIm4FZOb+AWMDKZtMANIGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28ZYC1j8E+kuG2bv+2yseZiVDDr9MhcGxynWzsiE9gQ=;
 b=fqbKmyWhMOMzaEIbtcoIkogDovO7Qydku0gjiPiqhjjbFnA4Tcjq1BS4fVNAR7B+zf2jpcUHG8h3/tNHlH33n4WXw+qJ98hd1m6msncgdzuHUCwuEco+X0O859q1D/SgnGBleqWcKCqS8qz1NbD6LGPwxXlziJp79hSO6KUBpnxrLDhIDeUcWKUoxsY6mAM2x/BSKHi/trDWwLukBGhewD+HtIPhJlFxsoZ5yz8Dk9aDYZzH/8/fw/tV3JR1S+kCsxnttzTvF3x1tkQ8Nyo+dYqauBiP5vg4CuBzfyEpONVAxl/KMwZxl342T+s1zcLOEnzSp6aee9iOAkKRsrklbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28ZYC1j8E+kuG2bv+2yseZiVDDr9MhcGxynWzsiE9gQ=;
 b=OcfE2/zOQUjmVfzdJVQz4rciMfPybIlvxAJ1Qixzn64+eLxgiaQ8PqbInyD6A2RyjtR0BJnyqyW/8gzg+fShG9NGTK9Urb1UGVNKjogM4vjNN+/rtHypDxI2K5bgYCm1v/sNl7GdUHKJw5iwxhQkDlo0EVeWVz2djGjAbq2lUOs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:16:56 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:16:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 05/32] mtd: spi-nor: Drop explicit cast to int to already
 int value
Thread-Topic: [PATCH v3 05/32] mtd: spi-nor: Drop explicit cast to int to
 already int value
Thread-Index: AQHVjkpf8ywexjKiGUe8CuXMeClShw==
Date:   Tue, 29 Oct 2019 11:16:55 +0000
Message-ID: <20191029111615.3706-6-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: b4a26c8e-74d6-4e60-f40f-08d75c6181ee
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB38230F4D6FC0D364F7748E75F0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E4jletWC3uQGmU57XnuCn/LQZE7MH4itCxOYmkYPLhmpdHqiN/kp7GcfYbo+LjpjrZiuOikf2SAmFEKB4IZZ/5/FOD82tjzXS7NhFEClujZXYBi/gNdHO8iEIS/IOsiOAKIt685tu+R6c72r00WUYxjDRRLkPVi9MBVlePSRpcdC6rRRorEKq2yb6a3Rc8tSRcYAGUncNnh6FfE1DcCi5kZu+NNCr4Js+ZFTZKXnyobK0DNOP81MSmVjcpsyUBMAz0aJXSu3g5qRl0HRdc3ygdxjjFFk5eapP2RpB829nM5QBYuLk6WQ/kr9v8HT+6mUPyTeCyg55xAexemROdNQshR+FaC9QDoYQL41XS3LsQLGf+RYgId4piXKeXziW8kEty5O2K/HlNstMKmuDvIjOK9NeJn7sUo7YGd8MOmTl9JBUeVh4+B8D/Gt4S7AS8To
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a26c8e-74d6-4e60-f40f-08d75c6181ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:16:55.9527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mihv8VrHDJQl1yJfA9w+2tnzEQbaf5ORJeag2rweQWwDhHe+5T7Fow8b64rBOLrCAyPWRrKxq1emBSQDoep7fU89U+l04T0KmA9uXol1cZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

ret is already of type int.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4d3c37658ea5..e801f390728c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -448,7 +448,7 @@ static int spi_nor_read_sr(struct spi_nor *nor)
 	}
=20
 	if (ret) {
-		pr_err("error %d reading SR\n", (int) ret);
+		pr_err("error %d reading SR\n", ret);
 		return ret;
 	}
=20
@@ -644,7 +644,7 @@ static int s3an_sr_ready(struct spi_nor *nor)
=20
 	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
 	if (ret) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
+		dev_err(nor->dev, "error %d reading XRDSR\n", ret);
 		return ret;
 	}
=20
@@ -2619,8 +2619,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
 		ret =3D spi_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
 			goto sst_write_err;
-		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n",
-		     (int)ret);
+		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n", ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto sst_write_err;
@@ -2635,8 +2634,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
 		ret =3D spi_nor_write_data(nor, to, 2, buf + actual);
 		if (ret < 0)
 			goto sst_write_err;
-		WARN(ret !=3D 2, "While writing 2 bytes written %i bytes\n",
-		     (int)ret);
+		WARN(ret !=3D 2, "While writing 2 bytes written %i bytes\n", ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto sst_write_err;
@@ -2658,8 +2656,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
 		ret =3D spi_nor_write_data(nor, to, 1, buf + actual);
 		if (ret < 0)
 			goto sst_write_err;
-		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n",
-		     (int)ret);
+		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n", ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto sst_write_err;
@@ -2755,7 +2752,7 @@ static int s3an_nor_setup(struct spi_nor *nor,
=20
 	ret =3D spi_nor_xread_sr(nor, nor->bouncebuf);
 	if (ret) {
-		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
+		dev_err(nor->dev, "error %d reading XRDSR\n", ret);
 		return ret;
 	}
=20
--=20
2.9.5

