Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74982CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40720217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kLt+uohO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfKBLYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:24:02 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48468 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfKBLXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:47 -0400
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
IronPort-SDR: x/yb+5W5r6jYi9c+05oFbN9fkXW3p7YuUFNuiBnbvXuIjhU/r3DAHSgEcmF1/pwM11VU+Tg3vK
 6tBN+Qnbt1v+XPSu6UaF/udrSCvbgD/AmY0NZzmwLm09V1FYNAuj+o8eqM2XDfpusj/FkY/EGc
 ufDdbq1ALse5VHmF76gItvCWyRsZ8ZXSv3y/ZuLDE9ISFU3oYhplqe7b+7eWohTUII1Hou1aME
 lM0tXzVw+xfhY6T2V7vABGIdJc+aK8xTq/OEbaJ1yEdx0mggGl73BNo1kboqFnHHdme+mMQd/S
 ixY=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55071982"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:47 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tnl82nv017793psNKkc9klb5dvrlQ+/mn90wQtOmQ14VR9MhA9aneI7u7SaP642wHdNeUTsyZ71+ja0oZA0E8LZIBULon1zNMYTRYPED82t0ESW9Tywyua4x4peqdkHpvyJykvfrPEsBFBkomFHrMd+Zbo/joGoU1hmFz354Se2NKcsyKNIEgIqt0eDknODhf66k6t+sIEqlpUpcGMEicdSAKBZIVzOIKdKhxuBcufowDt6rgHTPZVLmyDb53M9PoyIV6EPkW0mpQQMTUAzL+SbDHAxDw3mtNW55DS47NVHzsjvmz3tNEtGULY139aGxXap1yI5wkJ/Bf8hlzEy7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhNkopfWuP8oRW9r9hjFmkDTIBktP6W/Lx9ziSZruZI=;
 b=ZZQdhKdu3Cs+9k7ZQEw7kXlCULKVYhENX8kbDYNSshDwjDblvhf5KNGdBlazh4sFFPveXRfqx0OtYBG/quD0Q8msTtbOqtUDhiTG0G2J7YgzYvd4kd03rZSv8ESylfHJtcGLlm9FpfcwvKI/a0UxdX4uULpCugHBrpm4G9RDDbE9d+89/OYiYiGTcliSc/WqH+M0gd95DnzFwBYOfx2Zaf1vD6x+ecJafFzS1fYKQjatMfvpFykJ4dtschDTa0lLQ2q3YSNVJPmWvTbUPhk+Zp0CiOMCoFwa3SrIRDHVQWb6Gd4m0atFJQc4gQYCkYf7TXoq4bM5vzTLETx5FPKoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhNkopfWuP8oRW9r9hjFmkDTIBktP6W/Lx9ziSZruZI=;
 b=kLt+uohOsiE0CrfPs3B2aRk2Cg4bJ6GsPkB26DtEE8R8xkX20HvxSkPBc969OFGme/p6J9nWyjcwXwlGVfcnFaK7hzboTnbLmILCo0D0uHekPkRkU/fYdq0HkJVEpwlo6Nsts5HA2nJ0PVcwSDit+XTRHmLdC9wCs9AwZ1wgp0A=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:45 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 12/20] mtd: spi-nor: Print debug message when the read back
 test fails
Thread-Topic: [PATCH v4 12/20] mtd: spi-nor: Print debug message when the read
 back test fails
Thread-Index: AQHVkW/82Z42whGzzUysItCyifQ7OA==
Date:   Sat, 2 Nov 2019 11:23:44 +0000
Message-ID: <20191102112316.20715-13-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 4084c443-f4f3-4811-0821-08d75f871f39
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3711F09BF7C834EF6DD42A55F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(4744005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(14444005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJJZ/ARehqPq8EYXF9y/dv4UuAqthGVrLLSdkP9u7wucabmb5N7Rj2PM34wRhynK6fakswdB1vjItEDcmwpHrAjZzLrtGq0XsAh8C796sCOUi6cdtkv90sCYh2Ho2uwkb4nV3dhHd4lt1MxkqK2nDNDL00TATXI55N4K7ZG+p4WFHY+PkDujzws6g1HYGHbu5TyaZgaW/WfpxrXCSPjc1BDjHd7UfmlOMWCf6UorOFrgRooHClQzuW7p3W09kVYS6r2KPsqmjykMviQi6pqge6Qes4wg4TSG7nN2Y1ItSI4Cukj6HtqD852G3ujgEhdWPdF0Q4Oids9CHfrLOpX9rfNJWnQAeE2niH/Ol0Kkn3vCu1ThFZBs97MoovOh1nzFIfe9y2iX0UnmnalNka659F+Q8UqAiCiWOmz/8pOThYhGfE9uaGAXYnwsdYqIDjdS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4084c443-f4f3-4811-0821-08d75f871f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:45.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCcgAhQoWhDgB6B+/zVig3Uwn2VdgtZqI45m69qIcD2ZFPT1i2T5I+w6kaj4jJ2KeVH9PVSZxmEr95xhNKcM8M1HNROnmOqIU+AB9vi+AA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Demystify where the EIO error occurs.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8f5e9833081b..725dab241271 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -974,7 +974,12 @@ static int spi_nor_write_sr_and_check(struct spi_nor *=
nor, u8 status_new)
 	if (ret)
 		return ret;
=20
-	return (nor->bouncebuf[0] !=3D status_new) ? -EIO : 0;
+	if (nor->bouncebuf[0] !=3D status_new) {
+		dev_dbg(nor->dev, "SR: read back test failed\n");
+		return -EIO;
+	}
+
+	return 0;
 }
=20
 /**
--=20
2.9.5

