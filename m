Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E17CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4548208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BDKk/rgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbfJ2LRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:17:16 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16491 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfJ2LRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:13 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Q6T+yY2vj6ClWsaJBU4G5H2pG5xt5fHje6Sqrgs3IfutV4sncw0m6fq6VKNQn8ly+4D4ilvyXi
 tAhXSgvfPEEjFSasSNaOKijOQ30Z9+B7ylzGSLbZypgSosInb47Q3Ueruh33HqieQczHpguLq6
 P6puZFwxf+GpHwPEc7T2e6v4wtEixvHsrUu66wonTCioIJdDRksqQKqW3qkaoUKMjOXFwjozMD
 i9JF1ZDDT9lHxmyIv+WhBGa1s/BU01dcK0od42NENsakJy1V0jnCvJtEIVXuD5VICuT6Ds4xti
 AwM=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="53323557"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:17:12 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdUN2g97qEOYw4tDIvHzEp4nlXw9DjHMINGd+7YPVfL24AXCZNpH1Bkj45NNvNXqK6yzjykxkTTe1rclH4mXXNWSz2yxLW4jOnfCoy7badW9C5UajDW3VuV/m5D3BY8AF1+r6erB5oRf+BdYnOosbdZHB9X8DPFc6jiF9k0v00davIJhTqU30EMh0Mzir+lUEj51pHAWn3At6SNh7g4ggt3rwwxmYyUJPly/LPnsAP9EfG4HqrkNarAufuJ4QQ5vD5vE5Yk5I6osHbsGoxLskW9C4p9XNcV41drhLuTqNIYWosQDzEtqTF5k+iQeYiykG7c+kWbV9olFJenn5DhaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beDYlKX58ljdP5C7EPb5g7/Ls5nhqtkjDjksmkfO/Y4=;
 b=JJsU4VL5Ak0uiPobQZpmihNQrOKNntQMkE17tspXWNfcbOJqYiajjZMxctYD6q79ZD/r8HuDWVFm4Dz+ogB5WqgwcnRAk8FpCkXHoYDlx/NobekF3fOLAvUzfAoWIub3NbUz+WGBd4oVx5KxRHDaKgavMwYu6UP1jchtD2vczybG+bGhEqKStl3CiNtONsnYngLVup143XY8TVKgLOIv5RGeaMOXTNaUILlFxDWTpteSzgPY/KQvHUJonRyhncbjV9jpp0wr1RpWAjrryLWZrKETJAZfey8Qo6Rx30B9/56d04wnzT+Z6QaYhSM+uxn6n3ZtCph9BAoMQk33dZnGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beDYlKX58ljdP5C7EPb5g7/Ls5nhqtkjDjksmkfO/Y4=;
 b=BDKk/rgFRZ60LmuQPPgy6br5uXcW4WzN8t0uEPsxaaFF2oGxbzhO7kGkbkH/Qgrg1ijLUHehb+zU2hZ6CFbzooFMQV3ukCpsaCnELubbB4ioNMte1DUgPQnnPToSAjzSPXVq/T4qt7UhAajNuDy/xY52FOz9t6EjR3/xnQg9O88=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:17:10 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:17:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 14/32] mtd: spi-nor: Fix retlen handling in sst_write()
Thread-Topic: [PATCH v3 14/32] mtd: spi-nor: Fix retlen handling in
 sst_write()
Thread-Index: AQHVjkpoSVKjPGSGlU2f6aqVnPUv9A==
Date:   Tue, 29 Oct 2019 11:17:10 +0000
Message-ID: <20191029111615.3706-15-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 9fc2ae1a-668b-4cc2-b595-08d75c618ac9
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB382385C07E923F6D675F0160F0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IpnQPXkudblzU/BKOQeeohHJDzsc0HGGWS2H1wfvcaw82eGd42zzdGM+dYf6BIwjjMtUoLCqBZgS/qSziVC6rEEzhXa0WHqOxyH0LtDar1EAywfgxM7FtuyZomzXqYKZXF63cew1HINRQLz5cGdx1+eO25sj1/FK9qqAxLbakjxwCKCBp6bnSfdkR89On+3eRUa18H7CUWl3y0LgA7YFdfdHKZGxKHhePXsjTEiDfJY9jsS1lxw56oB3z6V9Jvz3IgbuiA7ljj4wxwUPmBI1f5SbTr99EXW8h2OJxOKz+/3L++h3KbLp7jEg5fTI6KaBndTjhkpBpFq3+NLUmHwoHAwChnfIwbrvBnbpUdvemO0nk2vHpX1Zonrac5LM3QtNGVC1PM/VmBoGexkO+g0SmnMvNe5OC68kWGU5x9sQ/dz5z6HslE0hB3+LXnG/NLtQ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc2ae1a-668b-4cc2-b595-08d75c618ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:17:10.7941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpHa+iSHsDnj7IXoqnLxFxUawC1Jf0naBTzRUAh1UgLvlwq9QVQP2GXedaQLSwFH9xDHCAkdIVLXxw3IkwgsjLDLgiB7YnQDa4MDlh77SGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

In case the write of the first byte failed, retlen was incorrectly
incremented to *retlen +=3D actual; on the exit path. retlen should be
incremented when actual data was written to the flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index bc46b946ac77..889fd77dbe96 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2667,7 +2667,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
 		size_t *retlen, const u_char *buf)
 {
 	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
-	size_t actual;
+	size_t actual =3D 0;
 	int ret;
=20
 	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
@@ -2680,9 +2680,8 @@ static int sst_write(struct mtd_info *mtd, loff_t to,=
 size_t len,
=20
 	nor->sst_write_second =3D false;
=20
-	actual =3D to % 2;
 	/* Start write from odd address. */
-	if (actual) {
+	if (to % 2) {
 		nor->program_opcode =3D SPINOR_OP_BP;
=20
 		/* write one byte. */
@@ -2693,8 +2692,10 @@ static int sst_write(struct mtd_info *mtd, loff_t to=
, size_t len,
 		ret =3D spi_nor_wait_till_ready(nor);
 		if (ret)
 			goto sst_write_err;
+
+		to++;
+		actual++;
 	}
-	to +=3D actual;
=20
 	/* Write out most of the data here. */
 	for (; actual < len - 1; actual +=3D 2) {
--=20
2.9.5

