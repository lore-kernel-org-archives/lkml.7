Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32866CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44BA21734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WUXo0aVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfJ2LS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:18:26 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36120 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbfJ2LRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:20 -0400
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
IronPort-SDR: 6Iu3bsmk1RRyQSDKVNbxz5qGDRDlEuDM3oCLkY5JIlaxeFHzTY2DK3s3bmTcTA7vTfJeZMvlNv
 Jwiq2zWZCZj4c/76LkV6OiLk4IBtLcyN0YBooOqIpc1v/rYpXcbRR613Dzr2lmkSNxyU3k/gLC
 v5HiHmHyPomMduW1pM3qEwuCV9cKiSrxE/4zPNOx5miqJJae5kfgCqnG/dwYW0XbL7vfWWjZ4m
 eR8dAxegcL9ZbVbUxvmZ1gHsVQ8M07DYm7+qPGYp/nUvRzCc+ILYfkk5CtQo+e4uZNbgx53Fxj
 lNs=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53292085"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:16 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2kcoUhLXo9nrRorwI1p5KJDKBSCGpIKFg8q+rzFMO5nL3hsRHGn3BVuR0PKiplHw91hFzZC19fKE2xhh8us6Q/RSfucj/TDQNnNUFxYWsiXCAiphosLqLGAAYHrZUsyRC8BFhYLk0NrjoV2lwgAhFtZ99LGKyMStwrCKNR1rXWkc7WYwTvVophuWuYSboGy7SwdmUn5OqltUkX98tUbDU6TJidoDZnHLm+LDQlvM4h1NBfCqr5Ou4hFGAwSTiUFBIUmEhlfDuyG46N2wH+6QDON+6HQq0V0zR7WPTQP1TvZbpCRs6UZvt/LuxEgU7wa23bKovAOzXEmTSXGGeu3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMjdnuOig21T9IzCdO20HhCmpyKpcmOWjdwuPzSPxo0=;
 b=V9gv9o4eU4loQ/9Xcqit6IpbKMezpIPNrFpBOvPXG+B+8I9pkcdMKItey45wq0LweeltE1i5+1wZ84w8XvpMjNqqtsRU9O1NVaT4B6NZ9glOrByf4t/d5PBx61+FUgqQG/wV9xGuljv8Idv+XfP3yv4C43r2c0pvSbkuctz33DaL3aJkcv/Yl0vX13MzBRRzY+WYWIMWyLveteYVj2ILxl4mGSN/ghzlBUqAphr0jGcDucVOyzCxjafCVTsz2gTLQcIXiuHvQOanAZ70DA2ncDGIgltKpABHVBysERHBexYLvbi3aZ1Oh6qQ0r5UvymtX1IcXjJzQB2mTKvD5b1Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMjdnuOig21T9IzCdO20HhCmpyKpcmOWjdwuPzSPxo0=;
 b=WUXo0aViFjldng3zR7pjEoL3BxsHsigPhRLUxd1Z6QpR8wgsevpat6fvwVz2svpb/XQ+VIwTQHDKpaTabdVHGUjZHPuVCBiihJzfl1HUnguBP6Ydr+mCyCYhKu5Gllf0UNrEVMSxwa/ibAQ6BFcNZ1Anpq3XZEt56l7O/L25few=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3712.namprd11.prod.outlook.com (20.178.253.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:14 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 16/32] mtd: spi-nor: Rename label as it is no longer
 generic
Thread-Topic: [PATCH v3 16/32] mtd: spi-nor: Rename label as it is no longer
 generic
Thread-Index: AQHVjkpqMD2RUk5Y5U+2Bm7i3YhTrQ==
Date:   Tue, 29 Oct 2019 11:17:13 +0000
Message-ID: <20191029111615.3706-17-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: f0857d9d-b070-4367-dc5e-08d75c618cb1
x-ms-traffictypediagnostic: MN2PR11MB3712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3712E58319E59792442FC070F0610@MN2PR11MB3712.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(376002)(39860400002)(189003)(199004)(107886003)(6512007)(316002)(110136005)(4326008)(2201001)(305945005)(6436002)(54906003)(7736002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(6116002)(3846002)(6486002)(5660300002)(36756003)(86362001)(11346002)(446003)(8936002)(81156014)(81166006)(50226002)(2616005)(186003)(476003)(256004)(478600001)(8676002)(25786009)(14454004)(486006)(66066001)(2501003)(26005)(99286004)(386003)(76176011)(52116002)(1076003)(102836004)(71200400001)(71190400001)(6506007)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3712;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YPVM7xF2OaziEFJT447pdZxbuXTvS8hCCU0uI4CO6whyNJc5lkceTyN/O107gvjD6qcyh8usyIZqOZ0b07htmu5BwNWD4j76mPMq8beW2+acuGCEc+Wrw3g+l+6vJYhPhItsQI7mHjPF1CprVaBZQdHNSxIhNi2K4NkrLoCJrbTOcp1clek32EDEE279kaw1ZwBjS2dH7swcpaud1zGucUqW+HEdB/2Qt8GlK0IV3CJYiHNLEyL4x6n+vtI05xsNAYlHZB67IyWB6K1NpYQXthV9WJbqIEB6oKl0Um8rmCzCf8UbA6XDD9dyGVytF0A8cBSOHkppJr3mu4Eji4V/SEOtdOBbXH5UXAXEjj+rHpyOd6nYcE/ZlZmBuwN9Fn82xe1m60RrARxyflTqNoGwPKf3kbIxz06jM56LTTtA+vWCJAGkxPnQq21Lfc4JzCQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f0857d9d-b070-4367-dc5e-08d75c618cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:13.9883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vA/4glEoeHUS8kzoZ6lxt5UZZPqFVRnlLaZzirA/Y4nvp4jqvVDSG1XJPbWzgodweD4vml/EyQIzfAo4YBivbHX1L3Bw7BD0NFOSPAZWDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rename 'sst_write_err' label to 'out' as it is no longer generic for
all the errors in the sst_write() method, and may introduce confusion.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 21f01fdcfa16..ed7c233a7208 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2705,7 +2705,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
=20
 	ret =3D spi_nor_write_enable(nor);
 	if (ret)
-		goto sst_write_err;
+		goto out;
=20
 	nor->sst_write_second =3D false;
=20
@@ -2716,11 +2716,11 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 		/* write one byte. */
 		ret =3D spi_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
-			goto sst_write_err;
+			goto out;
 		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n", ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
=20
 		to++;
 		actual++;
@@ -2733,11 +2733,11 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 		/* write two bytes. */
 		ret =3D spi_nor_write_data(nor, to, 2, buf + actual);
 		if (ret < 0)
-			goto sst_write_err;
+			goto out;
 		WARN(ret !=3D 2, "While writing 2 bytes written %i bytes\n", ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
 		to +=3D 2;
 		nor->sst_write_second =3D true;
 	}
@@ -2745,32 +2745,32 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
=20
 	ret =3D spi_nor_write_disable(nor);
 	if (ret)
-		goto sst_write_err;
+		goto out;
=20
 	ret =3D spi_nor_wait_till_ready(nor);
 	if (ret)
-		goto sst_write_err;
+		goto out;
=20
 	/* Write out trailing byte if it exists. */
 	if (actual !=3D len) {
 		ret =3D spi_nor_write_enable(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
=20
 		nor->program_opcode =3D SPINOR_OP_BP;
 		ret =3D spi_nor_write_data(nor, to, 1, buf + actual);
 		if (ret < 0)
-			goto sst_write_err;
+			goto out;
 		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n", ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
=20
 		actual +=3D 1;
=20
 		ret =3D spi_nor_write_disable(nor);
 	}
-sst_write_err:
+out:
 	*retlen +=3D actual;
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
 	return ret;
--=20
2.9.5

