Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320D5CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F237A20663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Z+ve1LmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfJ2LSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:18:54 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7390 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732591AbfJ2LRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:17:03 -0400
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
IronPort-SDR: zUFWERfVs90BQ8bu0Gwb5YMOW3hJ7dmXA21amk+v8xG+0qiGduO+rEw/xC/ltwL1VBWim0QHAZ
 POWqTstucka/i8PaeBvMJj/VEjjoh1cLl6lk8pA79qxi1xlGgRvmEFFCmX++36topfPSpVjcYI
 hmcEkOj0PJb7j069txba4DpbxquOKOskqoW7WY3VT9PG5sw2ztOJv6eCzt52BtXnTBnmYxc4wm
 uGO3q8R3gmS2uQTyqbhQac5KAPkS4OyyhfwFrMb58aWMUzFR/W80OfoddykmA3LkhXn3Ohasuk
 5Qo=
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="54794533"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2019 04:17:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 04:16:59 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 29 Oct 2019 04:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVXcGgb8EZyiWA+WD7fbnobjYnRgEJUqSIyslZm2frgx7q1B9y9UIz3zb6yNwzni57n18s6DM4J92vnNzwMbW0//F9OZHsaZBRFuqLZNedwX+K7LLk70amL+NLuPttoRy3CFNaIbsmj91/2Vvcj/Mk1hA+8CCkDivCVQdEjRcEAmWgd6yhjczPA29ZGcG8nXDy7ey2/wlcIaq6tO4+ELiJSFDSv1TCPVwYceMRD79upPvdKukeXjmQ09t7uySdf/pulCCCfLBzl0MgNhNO42Yd6wV0wIRWlhMgjaCtD1HH5PG+vbdOV4fI6HsguZ1tmpKUXkxjrshBQvTloh8NCI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJLNMifH7PC7Q0gc6ZT2gZmUaKNvHnIybVQ92RUpFFM=;
 b=jnnMJCXvisMV7HvhkadRuS8eVE7Tn6s35yGXLVXwj36pDHOxqjAWtBEt5dkBeSvsuv/yOp1/9H6duL7EHONY3BYy/KDhGUrWFgbNWfJTXjMHvpHrn0TdmPx5jZsfRBbTGyiLUP4FRwACWsm+WCdZvWBqqatbQCvy7gw9FNJyYIXtBPtgIV1otWxUxbzjuKu+NxP0Me3+imef+H1ZJ7DtyJgXcRE3d55Dq8BFcdLlUdstQ+teDwUztwcn0MlaUKa7/vy+3aENuCwlc81F7JJZBIcWjYO1ogLnwhap3aPqzqmlNlw0yZDwF7ekx3WkDC9FBt7/yrpphJ3+TlWUnLz4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJLNMifH7PC7Q0gc6ZT2gZmUaKNvHnIybVQ92RUpFFM=;
 b=Z+ve1LmJzN/q8X2tdv9fdIV1x0G0UA+vCmUKNCA5xlKphUARCUICRrcx/9mNkSDtrsG30RFb7Yyf/WgE1fhU4pKNi+JDZnYY7a3Ipbs4Tni7PDQ3QazBtQeiN9DlWJfuwCTQ9qgqexgtj6Zk5JlZfTaXC9BNeJ5Lw/HAlpQqVho=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3823.namprd11.prod.outlook.com (20.178.254.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 11:16:57 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 11:16:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 06/32] mtd: spi-nor: Use dev_err() instead of pr_err()
Thread-Topic: [PATCH v3 06/32] mtd: spi-nor: Use dev_err() instead of pr_err()
Thread-Index: AQHVjkpgCy35jqUUmESko8ut5mvNkQ==
Date:   Tue, 29 Oct 2019 11:16:57 +0000
Message-ID: <20191029111615.3706-7-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 6f6e9566-a045-488e-c3f2-08d75c6182e6
x-ms-traffictypediagnostic: MN2PR11MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB38237109731D7253D326DE4AF0610@MN2PR11MB3823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(478600001)(8676002)(4326008)(8936002)(4744005)(66066001)(14454004)(36756003)(6512007)(107886003)(86362001)(11346002)(2616005)(476003)(486006)(6436002)(1076003)(2201001)(71200400001)(71190400001)(446003)(81156014)(81166006)(6486002)(50226002)(99286004)(66946007)(386003)(316002)(52116002)(6506007)(102836004)(76176011)(26005)(2501003)(305945005)(186003)(6116002)(110136005)(25786009)(2906002)(256004)(54906003)(3846002)(64756008)(66446008)(66556008)(66476007)(5660300002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3823;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENaNAAs14lc5E0NJIG5alm4t/6BzZQ5DXCUNIIkSHlmjQ2hYGj9gFJg8PrNoLDAK2HflO81WWAjn8pU77Mgehwgg8XJIDuTS4GM6nOf1g1NqA1MZIUNPOeL/v1D/poOCH54IzQb82CenPqQNprvNO5WT/wjJ3vwxkJF/A9dtWUivmkSS7axCsCWviEmgr7c1w/7PnM66zeAs4hB9Y+3nqZPqaGyEfXGYJFv5Qundw/96HF8tGwahD0f/9NSHrskVSe/Go5oCafIuVidIZvtaUVFJU88z4MJObArCEQ+/X/pURUgqMeDFI/0pOPFBd+UlzAOdWUD7rPDZH+nkZ3MZbLglSQRJkviB918vO3WN5FvE+eEigdx49BcmsGqJJo1UIXWPWGiTlTYRZlVOOOrElR0EO8a8r5AnW43z/js0qe1bKd/Ztq1HLXlg4vVpEroh
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6e9566-a045-488e-c3f2-08d75c6182e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 11:16:57.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSTTPHHuEuRWdnix4OLaEwL8gtgDN7qA9guxUpjzUJOYnQ6xIC5Od1eeFu15+UCj5R7j25I6wgJMTRP9nCT3LErlKS3lTul/yuVmojsqEnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Print identifying information about struct device.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index e801f390728c..c794eff69fe9 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -448,7 +448,7 @@ static int spi_nor_read_sr(struct spi_nor *nor)
 	}
=20
 	if (ret) {
-		pr_err("error %d reading SR\n", ret);
+		dev_err(nor->dev, "error %d reading SR\n", ret);
 		return ret;
 	}
=20
@@ -478,7 +478,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor)
 	}
=20
 	if (ret) {
-		pr_err("error %d reading FSR\n", ret);
+		dev_err(nor->dev, "error %d reading FSR\n", ret);
 		return ret;
 	}
=20
--=20
2.9.5

