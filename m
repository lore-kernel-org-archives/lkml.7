Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A6BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D78820679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="obebGScR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKBLXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:49 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48468 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfKBLXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:43 -0400
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
IronPort-SDR: sMhdTtStZxhamvwGTQgc9f7e8CGUNlmAt8dW0Ir2FhNgVoX/5e8KOWmoCBlyFriDT9moijAkAa
 XZNlggMDNlsadBd2N1uzJMA8I5HFFylvVzG60CgUqWa9/E6xRtLmP54ht05Pp13e8hMrhI59zk
 Eo0Hp8rGKzlpPgRjLZDhdbySmjQVz44eBsJDJd4B9f03k4iVnv4e40PoFbOepR3/X91zYJKzlH
 Tu4ZmrWH9m0D8rIqNPAOJjsqrZZkiv2HTxxo1IeMfQ2T8DtWUJRltjKEO3igNi5q/y0p0pkicm
 K5s=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55071974"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:42 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWUd9iL1v3lVonV+/6NAYIwQTAg06kAh7rCO4lj7QU0kmA6U+w7S+RVqIPDq9I2BTDVot82OPOoagAV7gCaQsYXPELYCoqSoQMSKJ7ho02f5NJF26Sk47z97ydgcwIH9byXq6qNCjmglbintVL4YWcYphzu9degBpXPuK0to/QJVziRdOU37IZ1ceLHpXxIuUyApkEWY2rHECakh8XUm/6C9JAtk1DxxHMXiWa09LjqqVN1p4/kHimyjIeJEcYl2NarvcSY6guR08XUh5U4ZLAxyjf+8VAUt6kpJhUVR2sew/0BrP5VJ4tG6KTyOYMacnQcWjF3oU1N3RM91UaXvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy4OPSZICF6idLCCTzWC00so42qbQcIc89aOSs7BPU4=;
 b=IyUv1TOS2rPag/YkpvxqxFUWYkLHDYERGqKDisUrr1YpmzuuNBgKJ+UYnsDRPEn7fXJGafIUgHzQynpxbKl4IQImTzLTvCb0glU7gQK9BnFf9tjl8cOWDfYVgAe3XHdHiN86asuPb3ZOmOHwvYxMM/zvNP5vUc1KpJICtUYa787GsEc8v4tB/oJ+4IXfWl0/vVjeQr0gH9bBEb+5D7r8nWzFI+SN146Vz2P5vBEeJb2s0eQn+qeCannppk3YQ+jt8MFeNtnRmtcX1fMZrzGvxcLbWgWTTzXOzQJJYEsZPPEbWPQs25vvXYB9sHitI+WEgClgJKPPjbnU42Z9rZ9cTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy4OPSZICF6idLCCTzWC00so42qbQcIc89aOSs7BPU4=;
 b=obebGScR3EBa8dEA/USpNdRnQsJ0nuNsTK6RlP7+xGoI0AAxGla/hbDy22r9NjbTbkqsz7b4QqH8/7RDt1SnFNZxwdau5kL+sRpU4mrVLPi4wQyQOxUk6SY/1iLZ/JS3z4g7ISfYRXGIewoU7UJDKK5co8ZAUWTGpqUM/kNs7tk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:41 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 10/20] mtd: spi-nor: Fix errno on Quad Enable methods
Thread-Topic: [PATCH v4 10/20] mtd: spi-nor: Fix errno on Quad Enable methods
Thread-Index: AQHVkW/6/lMcRTFO50Oon7ENLmsQPQ==
Date:   Sat, 2 Nov 2019 11:23:41 +0000
Message-ID: <20191102112316.20715-11-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 1816defb-35b9-48fb-c3a2-08d75f871d06
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB37113F5CE563843BC353341EF07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1hdni+YRrnU7wMrR4+ECzQxW4AGxuqYU5fjgpPkemlKXHqr35M46oaipRpII1uTAOVrVVSHpZzcASjSsMCkSiaUGtuq/HmrVCPQLRZ4ii6BCOgFG2N3xJ6erEqBqqZvwrNnO9Z+1gybPjey65kmOKwVi1/52Gtd+qIWlv/NYo6xS5zzisR1a9VWCYa86KfW6yjHZp82JWZkfcW5olU/aQ1pNr66OocFz7pGVLZGpo0uiQib5seBgZcFBETTgnfeSxyAsHVg1xK8xZDcvFpMqz3IMPhUHt9Gc1dglUZp7gb7AWaBTpXOzHStzWbKJpb8ObLC3WYPeamW/4tv4G/upjtAFkpptAiG8Mkai0DiOxFgUqFP9YPZtkH/GnewO15KMld154PamLLZUjPZYO+lAmMi1sdQe2MJgOo9lfFKambcY8VfcbsGCpr4u73e0J6x
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1816defb-35b9-48fb-c3a2-08d75f871d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:41.2008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdSM2uhVMUBvEePMYXMFpB/29vTfoyFUMuTLg4ceTJFxmCUpHGO9OEuiGJMTDqRH9wydmaKpjTIigCknR9Cw6wmMLcyzkdeSu/QKpuHh9fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

When the Read-Modify-Write-Read-Back Quad Enable methods failed on
the Read-Back, they returned -EINVAL. Since this is an I/O error,
return -EIO.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f5193733a0f6..14146619bf19 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1964,7 +1964,7 @@ static int macronix_quad_enable(struct spi_nor *nor)
=20
 	if (!(nor->bouncebuf[0] & SR_QUAD_EN_MX)) {
 		dev_dbg(nor->dev, "Macronix Quad bit not set\n");
-		return -EINVAL;
+		return -EIO;
 	}
=20
 	return 0;
@@ -2042,7 +2042,7 @@ static int spansion_read_cr_quad_enable(struct spi_no=
r *nor)
=20
 	if (!(sr_cr[1] & CR_QUAD_EN_SPAN)) {
 		dev_dbg(nor->dev, "Spansion Quad bit not set\n");
-		return -EINVAL;
+		return -EIO;
 	}
=20
 	return 0;
@@ -2086,7 +2086,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
=20
 	if (!(*sr2 & SR2_QUAD_EN_BIT7)) {
 		dev_dbg(nor->dev, "SR2 Quad bit not set\n");
-		return -EINVAL;
+		return -EIO;
 	}
=20
 	return 0;
--=20
2.9.5

