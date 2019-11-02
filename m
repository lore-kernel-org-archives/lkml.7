Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E6ACA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10A220679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="BqeEYrgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKBLXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:55 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48468 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfKBLXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:45 -0400
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
IronPort-SDR: Dj//6Oxnayc4DCHDgH3dH71+AAfKyrBlWKEa1u2wbE9TU+0HCWjfs5VDyZU/k8Dlx3FlcK7L/X
 2xmLFoz2SRpD11FWdeWAC4aEiRX+fDbzPOFj1h9cvRZlLslpTYCLHGvcAExU62QggYd40hFGNx
 +o7VRa1GI1sPSlCJW4mSmC+71sT0JMxWdePaFOhcYwlwPFn246vYfE4gXfpSXmSSTQvQPqRh+d
 gM6+kzN6NSPMwwD4c0llJtmflOdVFiHRByv3kV9ReD4MGi4oO4mjJs8Dyzm2LLozdz254GwtOI
 hKE=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="55071977"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:44 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxG3/0LJABosrbXv9jFlZQcrFwjhCY7EgYLfQtmrOW657bkwmBBcEIra+B0xzasDhXtCbqTQvnam/SzhMDeV1GzTeAgyBK+/uKFmwrphGGBhXqnCDhd1yak8y8vhcRIVh5btAwa+LhZXrZu9VhZbpnzV2ZL3np/OsLLH7TX68RjUdGIEM0dRK8CAiqFEdq7wRSCgW+dwQ4Van+dPSfsDyHWpYCQq7oQTl/DjfYoGcrc2MfhSKKU5JQkDET6Ok2yIxBOtmfvJbZW33rqxo0RHa+opKdNccw+dtNnG/FGcb3H+tY8o1hiJiyT+hm6xbMDAd8pKlT6oLgzxhjq/VrwiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+sI1YE0Xpkt0FhPi2anjmKX7Nszb3bufasL7As83SE=;
 b=ivULqCptvaHNvEEbNyilizDNgeL5K0Z3ItYBH6sR4o1RYWT/GDDjTEN+IleOvJkWvjCtFzXFbeoZ0q9AnJlCpZnvjFhwX3TRTTyqtZbkKLo6VVHC9w6/DZpWnCmPyniglb6xOBQ11ZluZxTPY0LOQxCzn7801y//khAAeRu29xjAouJXq1gvi08AmYgerc/k+lsv7KzLN5HrXDpvRUbZP4OTbfXqNoiL8ZhanQMMqLAZe2Z4W6VkJpb5D9Cv4I6m2397VYswdmtUrcTWk78p3rS/Vvk824cb46UQ8kKTBN4yvwBMipnhUEA4rje0Z1CbD1kE4JuQ+a1eWohYPdpTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+sI1YE0Xpkt0FhPi2anjmKX7Nszb3bufasL7As83SE=;
 b=BqeEYrgEfFImwsKh0OVUtTmFQJu+0ByLxLR2T6Q3Hqyn+bra2QT6Y6rIX3pscz1z7MdHqPVN4m/Mwt1M1FlDFL/G8PBPuATU2p7UF3XmDdGDovNhEsZNSGTuQqXqXiJhUi4clnMrdcz3kYY9w4cOge/nhq2kNzkGJcy6MqsgP88=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:43 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 11/20] mtd: spi-nor: Check all the bits written, not just
 the BP ones
Thread-Topic: [PATCH v4 11/20] mtd: spi-nor: Check all the bits written, not
 just the BP ones
Thread-Index: AQHVkW/7jY3VsbPeikC7kuRKBX87MA==
Date:   Sat, 2 Nov 2019 11:23:43 +0000
Message-ID: <20191102112316.20715-12-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 202ae619-a42d-4edf-f821-08d75f871e31
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3711CC3BC085FEB5A948B6B0F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(14444005)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0f+W7Ic821I+ao4zW8ZMSluLES3vfdKNbqCyZDuruoIS8uowXNvmgMY4ChFI1zrlpJeEL9EUvT/iec4C3N8/quAXvCDbG/lHhnU7kyHPqwueC1h6PLq7qLwkX8wYEVuC+d3Wu+3fKpc7Fj6rku60yZN7dIb37oeZPbDQOAEQPM9PTELUIu3ooOoMPkBZ9v0LWMckTA6Tw8zhWb1RqsRMhNAbbxFuzRORuIsV9cxyVT7ebXKriyIi2JxkUOHCu3FnBI2sgiMWFuvJNovYul6thVwzrdm0/qG+dGQX78CkDaWtNeZHko8hx6S0LBFJtv1MClurVDHubUniaMiU8PrY7UM/eKeWk50dliDFBtkulkq3xvaQWsQ01MdyYmc6wp/KCnnzWCuNyFnmyQtYTQmN5RZ1T7HPiRsiCVaJ9lIdnL1s+kU6QbpfnniI6aetSDN6
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 202ae619-a42d-4edf-f821-08d75f871e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:43.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nu38qv3MB1tfz/S9mJS/vk59djsJNfrfZ7Eu1+tD9j7gc1uTU3p8Tbb6eaAJ0hwOAYr7DR7JrzarqKt/nJW0sRuw6vaGPtKvxawgGWnMQyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Check that all the bits written in the write_sr_and_check() method
match the status_new received value. Failing to write the other bits
is dangerous too, extend the check.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 14146619bf19..8f5e9833081b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -960,8 +960,7 @@ static int spi_nor_write_sr(struct spi_nor *nor, const =
u8 *sr, size_t len)
 }
=20
 /* Write status register and ensure bits in mask match written values */
-static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new,
-				      u8 mask)
+static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 status_new)
 {
 	int ret;
=20
@@ -975,7 +974,7 @@ static int spi_nor_write_sr_and_check(struct spi_nor *n=
or, u8 status_new,
 	if (ret)
 		return ret;
=20
-	return ((nor->bouncebuf[0] & mask) !=3D (status_new & mask)) ? -EIO : 0;
+	return (nor->bouncebuf[0] !=3D status_new) ? -EIO : 0;
 }
=20
 /**
@@ -1774,7 +1773,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, =
uint64_t len)
 	if ((status_new & mask) < (status_old & mask))
 		return -EINVAL;
=20
-	return spi_nor_write_sr_and_check(nor, status_new, mask);
+	return spi_nor_write_sr_and_check(nor, status_new);
 }
=20
 /*
@@ -1859,7 +1858,7 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs=
, uint64_t len)
 	if ((status_new & mask) > (status_old & mask))
 		return -EINVAL;
=20
-	return spi_nor_write_sr_and_check(nor, status_new, mask);
+	return spi_nor_write_sr_and_check(nor, status_new);
 }
=20
 /*
--=20
2.9.5

