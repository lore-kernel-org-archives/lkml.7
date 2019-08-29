Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40F3233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="D/9hcDp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfH2HKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:10:32 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:29769 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfH2HKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:10:32 -0400
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
IronPort-SDR: 5/0qo1HCxdGeCKfyYhB6fGBs+LflneYCFQb+fOnWfi1fAlsaa3cLDe4R0U2ON99j1lR/4yuHga
 qIkgJ3DmI3mXVRZzmoi/cvX4vu8fQlEMyVMWs3nd0P1PnjaV7fB95ryZjlV1rboEM4w2dEx0eJ
 y4fAqE53zoTltaja9TydEtZop4VsdoB64pGQaexqsL2BhB7xCljbrElwcY604ObnG3ecWXarhx
 mFbgCGZsg6G66y4LItAIhvLFdux7nfK18GjmKG4+sppDV5NGw7mSlnBPVbcw8Tf/AxySNrKpI/
 Vss=
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="44117207"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2019 00:10:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 29 Aug 2019 00:10:28 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 29 Aug 2019 00:10:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuFoeV66JYBliEMXIZtmKk7qrugdpdhOGC20Uf18fabosvzFdbktii/et29U1qIV+/UoM834CO1hor7aK6b/o5D9C9i+UJLJEl6cLeaED1qr9VM1dAJ4ZQxzAuUsoCKhvE5nqB2Zd0i09W72lHAZq7hT4eOiY9xpzr8BZgZgLhd+iSkoE4QbIWO8XRYTXFvX9SHjtANRCOXX4p5Phaa6hGKlixwatQZdJM84G/hDcr27JgOzKNB6YtuM4KJhnDAf1bA/Cc2TYgdh0rlkpPIgwK6/Ks+SsiB07VjfuH1W/kTGgUAOZZaM5sQACzrCmvRZRa9GG7xDAODXQoYHlV/LLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPob1TkyCjPs42BUy/9LHTDq35giq10F3hN438CEiSI=;
 b=dlOQpP8o47LTi9l6ZaC141mVOU+DbXENPZbxtPmes51cZsk7QawZBIiWh+78/kwQJdUf+f04es4SOuh53I1B/asjdWZDRo3Q8gBAL8E+q/BHAuL5Eq5Y+wcTJVJxx5lmA5czlVGSMOgOjYOSD38fhcCy4heP9unMgf8YYWYp3E7zBW46ipnG6b6OE2S+vwkPHtBxBT5l1ZmOuey3MyoKXWIg/rZdgKpAsxENDzuAUbWFKW6Gub+G3feZ48fDrgXZMXSbSBfpXjyVr7lOa1/7aqr46zvSXjX67GKJsgR4h87rJULXyl5szQmsA43+y6GUFvhKVFT/Z0/Rc14IPrqQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPob1TkyCjPs42BUy/9LHTDq35giq10F3hN438CEiSI=;
 b=D/9hcDp8LjhkZTsgGgvcW6/myi8zYRQbZ1ykeSUPrjuNOVXM3KPOkbPsUAslRCNp39HvJrY5gc51zArrleNF1hEnPKU6I4jPzZ4RnSV8FvheXRduv6BIHrXezWgzepRnineaEcgSUpm25o/171Ct/x0nBjA+DGNn11SGed34JAM=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3726.namprd11.prod.outlook.com (20.178.251.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 07:10:28 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 07:10:28 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhuohao@chromium.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/2] mtd: mtdcore: add debugfs nodes for querying the flash
 name and id
Thread-Topic: [PATCH 0/2] mtd: mtdcore: add debugfs nodes for querying the
 flash name and id
Thread-Index: AQHVXjjWn7v6TIwgEkeFwU0X8/uyIQ==
Date:   Thu, 29 Aug 2019 07:10:28 +0000
Message-ID: <20190829071019.2495-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0165.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::22) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bfd6003-3f7d-4652-6b6e-08d72c4ff885
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3726;
x-ms-traffictypediagnostic: MN2PR11MB3726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3726C77AAAA84173BB33BD88F0A20@MN2PR11MB3726.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(71190400001)(50226002)(66446008)(66556008)(64756008)(66946007)(81156014)(71200400001)(1076003)(3846002)(66476007)(2906002)(14444005)(256004)(305945005)(36756003)(66066001)(5660300002)(7736002)(478600001)(26005)(6512007)(6436002)(81166006)(2616005)(2201001)(486006)(6486002)(4326008)(86362001)(476003)(52116002)(25786009)(99286004)(8936002)(102836004)(6506007)(386003)(6116002)(110136005)(53936002)(186003)(8676002)(316002)(2501003)(14454004)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3726;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nvmRODBu7Y1+09qtyUyIGd3bGukpSpjkbaQN9i4dFMD6aJUCtZjJTz2gDiA9SHdXLiZVzFxHCJNEfsGTWLvIFXhDSUDJ/W1w2QUASW2KzHhNjbFRUZK1uEElNDKGKqQjgyq5FsbxKbM0SyIjMRmxPZByuxXCQHWCV0Dne/c9pJRgF8IvTaxx+ZMxrk9U+YMWbbU+Sg7tRkRfu8Xxb8cV6DrFHaIeTTwOTTlyw49gzAdoSDLBqhJrhNW4nYGVUf6O5/kT2ZOHCWhmEmrY4cf/f34l3qnWQ1zkqb8MqJKOBiCgb/M6GKRLWK0lqs5RBrIyzATe+SA2Berfbzf2MAlZohqXICmfNiDhqxw7anOzwdc1cfYXzpl84gFybrBf/XhzPMg0+P1MWON70RLzgEvAmjtNFl2n4HMqht1bMvCtY0Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfd6003-3f7d-4652-6b6e-08d72c4ff885
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 07:10:28.3504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcJvjuMP+eP/hS9LmPfEgRhELj3MODWVEWaHE8kc0rjDwQRZD7c24x05Nlsi921zoQNmqgNw7/s4ECB1DaD96Bf6x+uNPTBx+vk6S/nUEeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

I just rebased Zhuohao's patches and fixed some checkpatch warnings and
checks. I'll let this a little bit here for some short review, and I intend
to apply the patches later today.

For patch 1/, I fixed the following:
CHECK: multiple assignments should be avoided
#82: FILE: drivers/mtd/mtdcore.c:390:
+	root =3D mtd->dbg.dfs_dir =3D debugfs_create_dir(dev_name(dev),

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using o=
ctal permissions '0400'.
#90: FILE: drivers/mtd/mtdcore.c:398:
+		dent =3D debugfs_create_file("partid", S_IRUSR, root, mtd,

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using o=
ctal permissions '0400'.
#97: FILE: drivers/mtd/mtdcore.c:405:
+		dent =3D debugfs_create_file("partname", S_IRUSR, root, mtd,


For patch 2/, I fixed some alignment checks, and I moved the call to
spi_nor_debugfs_init() immediately after spi_nor_get_flash_info(),
because it uses some info data set there.
CHECK: Alignment should match open parenthesis
#162: FILE: drivers/mtd/spi-nor/spi-nor.c:3939:
+static void spi_nor_debugfs_init(struct spi_nor *nor,
+		const struct flash_info *info)

CHECK: Alignment should match open parenthesis
#168: FILE: drivers/mtd/spi-nor/spi-nor.c:3945:
+	mtd->dbg.partid =3D devm_kasprintf(nor->dev, GFP_KERNEL,
+					"spi-nor:%*phN",

Zhuohao Lee (2):
  mtd: mtdcore: add debugfs nodes for querying the flash name and id
  mtd: spi-nor: enable the debugfs for the partname and partid

 drivers/mtd/mtdcore.c         | 86 ++++++++++++++++++++++++++++++++++++++-=
----
 drivers/mtd/spi-nor/spi-nor.c | 12 ++++++
 include/linux/mtd/mtd.h       |  3 ++
 3 files changed, 92 insertions(+), 9 deletions(-)

--=20
2.9.5

