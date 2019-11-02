Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A49CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF44221726
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HvoyttWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfKBLXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:34 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48451 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfKBLXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:33 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: P9xifltL/BCFslVrgtBLFfwFQ5vXVVzxFOdsSuV6UZm5gEbP4gR9AfBXq3DX7DER/q5s1suTCK
 TPt439Y9qoKidgVzV8JV//JmotXrK112fqDKG776Z5TzREIkIyiVAg2tH2COM563dfsWpZIN2D
 kAtyPGdGu5m/oxfojI3EHs4PudmK31e1QJGNz6xsWEIpTs6IjoxSNdGN3OjMGPN+Lu/QOWYW2F
 9VoGG0tfbNX77MPB1hS6unR0MtF6AgamSgedSKA2s2ZoLu3rgat3t+sSwl/YJgC3TwGLpjLVeB
 Vj0=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55071961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:32 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+iJi7bJLpkG8bxWHzzsmVqdyqpzTWPBoD9wYWJIRakiB2JKJTWoOPjNQR3OE/ij6Kn6uq35MsKajEq0WbDM9YQEqyx4aWODGnf+h+5W5Xb1FWK/iUsnLL4UuShYQ/aaUIZuH5tUXX174+G3529hgoea92Ba7Mz4ik3MiQMGZFcRxE3X62jIrxHQU4YWJMNqdosAy5kvyXdDYIvropEN3xxuNXI4K43nIkZTUbrNl501uYmRv237BX2P3K7E4J62EzJu/8TlHwoZoejTzEpLH14ET7AjzGfO+5KRe4yRwMCFBqeRPN9FyL5GYgNL5MaZYY4NWtSe0gs5J8i56JrGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5corPCk+1J2hJq1HQ3AY6ZklcL/o3VcnW5QRsEclLzk=;
 b=BfNhhwsvI7fmkLwTiJ03MSZPK0eTLtGU0hvCetKfDx6kbk610ifIzg4XYzMriV61R9LQ7TpNUmTXEqN9kUr55UMlSMzbdDzWlhbqbJwlIgJ9QlSFVST4wQZJuVyQ2hM+zip2BlwOK8VLg5CYVA2slC3BTQ3Cqpe0O3FJy/wMGE7scA9qHEUurJOGyaSP0wY3nxkDIUPBojTh6ykYBzZrlbw1v5I4VeuOz9QmEp3BcqiEEkiNxJL7h7csYhIjsSAJc4avlha+LC8c0n85xMrgp6O/cN2eEkGx/qeS1YcSLjV+0nNclCKFqqyxBaKXpzYhN/nSAkm3gPlv8EwXAVPNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5corPCk+1J2hJq1HQ3AY6ZklcL/o3VcnW5QRsEclLzk=;
 b=HvoyttWt4gE+wj59GFHv5FYRGiTJZUANR9j4rh3UtN5Uwtakl4qXgclygC5rr24jGdZ6ihNqIO99rGJHMxZ4SqTbuZ8l9rtaabUidZFfjviNt7KFlHqM1SxpgB4KOak9opMp4R62H0vlRBhBS95P0bN8gttXMwbFfBevpp7qv0U=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:30 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 04/20] mtd: spi-nor: Rename label as it is no longer
 generic
Thread-Topic: [PATCH v4 04/20] mtd: spi-nor: Rename label as it is no longer
 generic
Thread-Index: AQHVkW/0JorkXIOJAUiA98T4rPn8zQ==
Date:   Sat, 2 Nov 2019 11:23:30 +0000
Message-ID: <20191102112316.20715-5-tudor.ambarus@microchip.com>
References: <20191102112316.20715-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191102112316.20715-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0143.eurprd07.prod.outlook.com
 (2603:10a6:802:16::30) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bf7abf1-9ca2-49a2-956c-08d75f8716cc
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37111440F1A0E80B9E5E4EEDF07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39850400004)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(107886003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlNGnjx7ra2XEP0B8a0RVqXyJlsT+lY8Qi5Kz/4zl8dvmiyIZ37t5q7ZCl13vXnzLOpzQ06QjAqgA1CYjmK87OifTmZu1SokeqMRcA0RkMVhvnzK8hvjsHZMfwp4E7oeQQYeuKVU3GtO+22q3e2q6ovk/DY0OZ+WnwEUP8DDSmOyuxiOsfNmGJxoF7ZHVWsBoOfD91cPD+vZb9Bck/r19vXyvlkTNnjoaMYbH3YyeaoRVIIQV2dlA7OYMkgbMKr6k6jODw0XZeRwVXRtwmAc4VyOWdhgGIQzgU67pggiJd65/RxV3f1U0+Dsa7SHbtogm7/0sfeGA34Rfnlu9/ZF9OW/xE2nyDo0mclOBIlDFJ3CeBLPrqFimZ+IoQ2obW/8hb9BvStHuvsnpFfW6D788yM2ELxfVs1LoJW10a0Xf2ffwcQUacJn/fwt6onlEjAS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf7abf1-9ca2-49a2-956c-08d75f8716cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:30.6459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jl1SXGqBjqcrB5pThxuQCcLdeAhAiAJjis6U5mlfdEQx0EmygVgGZsvShEf1SR8QHk8uwD+beBaAwgRtdFvQiUaeSVhfIHU6qLGXeG7r9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Rename 'sst_write_err' label to 'out' as it is no longer generic for
all the errors in the sst_write() method, and may introduce confusion.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5debb0f7ca13..01842cd92126 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2709,7 +2709,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
=20
 	ret =3D spi_nor_write_enable(nor);
 	if (ret)
-		goto sst_write_err;
+		goto out;
=20
 	nor->sst_write_second =3D false;
=20
@@ -2720,11 +2720,11 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
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
@@ -2737,11 +2737,11 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
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
@@ -2749,32 +2749,32 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
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

