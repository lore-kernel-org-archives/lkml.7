Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2D120684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rhxqOBTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLCOQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:16:43 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:30791 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLCOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:16:42 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: T37hLq4OlG2kYfV+QLSKWFVQ5io2qefw1QaJDPzZvGnBY4Y95hFWSz+1Wy1ugXXsydSMxWy4Zc
 u7dS6OpbBE/555Hi4TWc+HmdEo49M8h30PGIAm77tZm6Y43C0J7mbW0K3y2fE3pZH48y279l2f
 bXZ6ZnuKrAbHJhaIbqjmSbmpR5NWHLnqFr/PU2C736IGUs0vg2Px4gYAq/HEOIRDa43Cy42+JT
 DdlwN+vChqtYENI9J81WnkSJlNQSeT7i64369WCbOv2OXwr0mjhD4GHbb+UYleJ+ydOJK6asmG
 /Oc=
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="56431760"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2019 07:16:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 3 Dec 2019 07:16:42 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 3 Dec 2019 07:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXEFw6t8JjAtvYK/sXNoQLvCnmTvhAXzqWYBVpKuCIpaxHcDWfO7U6BO5Qdmnq1RSO28MjxHVourGJuSQGuou0I+MeNLjPODR6nBUQw0sWXOcFjUiJTdqDV7CKz+8qsYjD55UzppFyDVkF3BYbO5+m2SbVGUfUQeJGe09JqxdLJqEPX+iDYGRwEyowcP7S4usMRzX/rFIPOHeZ3CyScOLrns0ARlBWtOqu7BOOmQb6+BIi3lxOGFpxMMDHszKdk+EGGwOCSNFFwVbjzra+0DOtP8pnaB4K/OFqanFhWn6zzI4XhoFhGv8zNG9niMIJech95WkBlNj6kKFMY1ZHqxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXvqrrrzo545XPvFeITzoLQ0XLf0We0PbZImX7ir5PY=;
 b=VpdMxwrEOim+7qUhzDSdw8qmYmjwTcSShH0cRfe3XJm5Yv+7bI81GdwoADRhGRFWmas6jthrNO2j9OzIZvsfBFD1R3S1TpOCjUc8X4bShDfOcFVzcBMCFlHcyct2WhJFW65qlLlscGjCj3kOrQljtstelRnXJsV8V6Fsu9Ek4J5GG4rc5SZrQ8kXa/s2bytX54BV3hbmEvnDv7ZF1pb44i2JEokb+qBfbf8OmRt6/+pjHb/XQVztgDhubYLY5qy6AoPz09T9nq/qohQthsJZJD0WcQXEeNiyiG4aOBu2XjIH2grUQ9JJ0usU9tgQJu2IozrFzAC/9Ank3AnpeZzsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXvqrrrzo545XPvFeITzoLQ0XLf0We0PbZImX7ir5PY=;
 b=rhxqOBTqeuiq3WR5QyMcbMyWgDW913kgC5hUvQrHVf+klECSbO5cV5ElPjpTTqxxwQwnQfePZAsu3QqqcRdK4YcDMSJcnbMRGHGU34KmCt+KekfpRQsg3GhtqnxxBwR7M07K4odOZZjw79eWO4xHumnC/sl7clwWqj9PpctqaPo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3662.namprd11.prod.outlook.com (20.178.251.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 14:16:40 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::84c:6e75:22df:cbc9]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::84c:6e75:22df:cbc9%5]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 14:16:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <john.garry@huawei.com>, <vigneshr@ti.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: Fix the write Status Register on micron flashes
Thread-Topic: [PATCH] mtd: spi-nor: Fix the write Status Register on micron
 flashes
Thread-Index: AQHVqeRHcKWKCTf45E2yWEPJkz+EwA==
Date:   Tue, 3 Dec 2019 14:16:40 +0000
Message-ID: <20191203141625.13839-1-tudor.ambarus@microchip.com>
References: <00cf6eab-9798-b0e9-e4a2-5b2f8374b698@huawei.com>
In-Reply-To: <00cf6eab-9798-b0e9-e4a2-5b2f8374b698@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:208:122::16) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6a9d472-8528-4cc0-a3f6-08d777fb6a3a
x-ms-traffictypediagnostic: MN2PR11MB3662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB36628A62613923316D9AA63CF0420@MN2PR11MB3662.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(396003)(346002)(189003)(199004)(71200400001)(6512007)(76176011)(64756008)(52116002)(66476007)(66446008)(316002)(81166006)(386003)(2616005)(102836004)(26005)(1076003)(8936002)(99286004)(11346002)(305945005)(186003)(446003)(8676002)(81156014)(6436002)(107886003)(4326008)(6506007)(6486002)(5660300002)(66946007)(110136005)(7736002)(66556008)(54906003)(2201001)(50226002)(71190400001)(14444005)(25786009)(36756003)(2501003)(86362001)(3846002)(2906002)(6116002)(478600001)(14454004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3662;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NRWRT7FHpVVGUaxNSaQImU2CFdFuLFkpY1U+q5r+VpPtXhU+/EOnx4UNNDbmQGxem8YdBvG0EjpaK/dbZKAVISCLhYFX6Gm357v9PkSxuaHFPrynkB+/RP0qGqAJzh2B18TeBy6czk6/wlgZQa25RSKKxQJedzr1euQ83ChP6f9MZNRf596NlEyJ3y0RLVSc+fbnFsC2eO79Jc8TZwe84gjFWfUg+I8kp7CKE0vNXRg/HI/hOFr2eNBKaJQgDJZ3tHWW5Gb2qxcsZX15D0boJoqEacCEf98cwzo/ml7eyRYdijsjKAhxz2bUhdCn9NZjAe7oJlFyIRWO/G8+uZT7eAwkF+dK1A9MLDLMCO+uoKITzwcDJvWKJDrhgj606xsESJgIaJMEWQ+U0Uvqr2/JFmX9AjTkwKGIQEICvBzVt1Tov6axQ9BLkLcInora6VCV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a9d472-8528-4cc0-a3f6-08d777fb6a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 14:16:40.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOkOofjeG3z84rdfMbrvp8F3Mi2S8Vqw3bIqLJp6YeY3mYY2qfPwLLgiknnTD6TGPX0NHBWcAGcLwcCAux3NvBpdFx2vxGdC5Tq8hfrlXeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3662
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Micron flashes do not support 16 bit writes on the Status Register.
According to micron datasheets, when using the Write Status Register
(01h) command, the chip select should be driven LOW and held LOW until
the eighth bit of the last data byte has been latched in, after which
it must be driven HIGH. If CS is not driven HIGH, the command is not
executed, flag status register error bits are not set, and the write enable
latch remains set to 1. This fixes the lock operations on micron flashes.

Reported-by: John Garry <john.garry@huawei.com>
Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on lock()/unlock=
()")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f1490c7b5cb9..7e41493f69d8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -4607,6 +4607,7 @@ static void sst_set_default_init(struct spi_nor *nor)
 static void st_micron_set_default_init(struct spi_nor *nor)
 {
 	nor->flags |=3D SNOR_F_HAS_LOCK;
+	nor->flags &=3D ~SNOR_F_HAS_16BIT_SR;
 	nor->params.quad_enable =3D NULL;
 	nor->params.set_4byte =3D st_micron_set_4byte;
 }
--=20
2.14.5

