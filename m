Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E4C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00A720673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PKEv6tkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409363AbfIXHq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:26 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:29719 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409330AbfIXHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:25 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: AeeKypm3Xj/W1eNi36X2wMUDgg+HYWCJYiHRscqgxOyoo/lmaUv6LJf8RFWQqKDcqYdHvMz88l
 wmB6Uleu8NwmZMBDElB3Pa6ReuAPnGW186eEfgrDZ7iWjQ5u9KsUKWLAPt/fntG06dMh3l2sri
 nxvo4vathy4R7jtiaYz/mQ0wygiPFn/cefeN6c2niFEdPwB/LY/+O6C8mX+Ghhv76FmLMkS2CD
 vK4u+wiPsYHUxQEkQm8m5t8OraXwfMziILS3AfIv9t+KnFq9lDl3+vH91KZebikJ7+eRp48Aw9
 +Vw=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="51606460"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:23 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Sep 2019 00:46:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx577mspXttT/nG+BrJgncgqlH6qUCS3IL/OUnFg2th9G4lpZ/WBDvsA2UZhnubM2gQICsaIE+X9rUpUi5hLfLVtKygLscEbKic0297renVylXSXBg/LL3sK7+KHTGoiT8lElTkvyzChrCGde7YYPUlOugTcstRu9iyRiAKtvw2rdP6rWn8kgBb37WY1hyCwtsLiQNgPe3Vj7kwlMLSIOGbdMVSCWTqZ8jdMGszCUH5D+ub6DzeWB0ZHTFnqReMEIxZXiggsr9VLM7kZi90gvpjtyLID4SYGDV96gXmBv+EO4MtTteesRdQCtLr9/DwAZjmmTydiflDJhGeDQqAaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13mIgWj2Z1NMMHDpfeVOINAzw2daSFAmJ2a/ygFXfBo=;
 b=UNyQjW0iPdLVrk4l8O6a+9WZNu1BSsavbZRgGwT9juI2dio/cifje2Vgj3vSuFX3rZnTZblKVkPcL63hdzqECijqgCqOzg1i/Xi4lRPYBquuS2qIEwtiwSYUSzydVYrVSe2lIHgfcrw/7ZUAWbaymYqsl+9xecsZuuQHbKQ22cA/50us8rt2XoTXqz1IxdkHcbPkRg5mv0mQbxJj30yrdNpenVfH7zUr/LzSEAQUn5RrwJOco+CIk9eeFB5rNg2ypY7LL/AdBctiTNw0c52CMH1QzX4fdwCZnN3+aUd+YcvtKv890dmWuoBHhVonLsF2bv4fTd5s79p0NfDEM7kpbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13mIgWj2Z1NMMHDpfeVOINAzw2daSFAmJ2a/ygFXfBo=;
 b=PKEv6tkUVma53PnxostQQwkNhqP4RgY+eWkTsz9zopGmhTE0dQnIwli3x0suFNs7q+YBfgwebcPYCk1uQVnlxSJZTYwnXTEnEIJ2Z/GqWE3yt/uCsK0ItO1FgQXDTmqCyQlU1BBKxM1zPysbkGiDFjTto+KuzRP5KlXiMsW8/v8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:46:21 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:46:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 09/22] mtd: spi-nor: Fix retlen handling in sst_write()
Thread-Topic: [PATCH v2 09/22] mtd: spi-nor: Fix retlen handling in
 sst_write()
Thread-Index: AQHVcqwocr2G1vTqBEOgTu/C0BezHA==
Date:   Tue, 24 Sep 2019 07:46:21 +0000
Message-ID: <20190924074533.6618-10-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::50) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b336001-b099-4285-141c-08d740c34af3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB431964DDBCBB21AAEC0EF13EF0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iObHnYSACaX6WYGTueeLNm6muhNE0ghwZDWq4d2+Pxx892gtkQKlFLPbb2W68mLxPy+UpXwCRn16y5G00cT958y0r6M2t4HKiYy5gNiKem10b4kD+0BpSxi/thu3dZ3xluJ7o745vGzciF++1xSgpq9FziCXQouNgcad7C2jIxwc2KZtt55AI5KgOdOinBnt5DdxOrPL0TzU/PTKkIaUU/96fU/rNmhzf22xFd5wIyqL/hKyhLsL9UY2wdIm5RmyVoIQJ0n21iaklvKqa52eRcTb+YaSH+0cp0tBH+DSpd0iZ35qcFBhPQLUCxsJbv3fv/ShVJf/gQGFZL1ZJAJDxtzezIH6bl1gbXzISkTeJpkbp043AEkjj5qWHj21aKKTf+9J2XMNqGNMU6VmhsVOmULGCSE15QtSBwwdHCOSVC0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b336001-b099-4285-141c-08d740c34af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:46:21.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grlkVu7aXMILsCTffjnes7Y6copDMdfLNyH3YzTgYDdJ+4HD6TG82SbvL0OLQ205QkAsGyIiqN++YLPIKdwD12/xJZFy4Xs7traHYBl8cQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

In case the write of the first byte failed, retlen was incorrectly
incremented to *retlen +=3D actual; on the exit path. retlen should be
incremented when actual data was written to the flash.

Rename 'sst_write_err' label to 'out' as it is no longer generic for
all the write errors in the sst_write() method, and may introduce
confusion.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 0aee068a5835..be5dee622d51 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2665,12 +2665,12 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 		/* write one byte. */
 		ret =3D spi_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
-			goto sst_write_err;
+			goto unlock_and_unprep;
 		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n",
 		     (int)ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto unlock_and_unprep;
 	}
 	to +=3D actual;
=20
@@ -2681,12 +2681,12 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
o, size_t len,
 		/* write two bytes. */
 		ret =3D spi_nor_write_data(nor, to, 2, buf + actual);
 		if (ret < 0)
-			goto sst_write_err;
+			goto out;
 		WARN(ret !=3D 2, "While writing 2 bytes written %i bytes\n",
 		     (int)ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
 		to +=3D 2;
 		nor->sst_write_second =3D true;
 	}
@@ -2694,35 +2694,35 @@ static int sst_write(struct mtd_info *mtd, loff_t t=
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
 		WARN(ret !=3D 1, "While writing 1 byte written %i bytes\n",
 		     (int)ret);
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
=20
 		ret =3D spi_nor_write_disable(nor);
 		if (ret)
-			goto sst_write_err;
+			goto out;
=20
 		actual +=3D 1;
 	}
-sst_write_err:
+out:
 	*retlen +=3D actual;
 unlock_and_unprep:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
--=20
2.9.5

