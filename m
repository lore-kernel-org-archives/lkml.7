Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89458C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F77921D7F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="a1/n/7Ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbfKGImK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:42:10 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9821 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfKGImE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:42:04 -0500
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
IronPort-SDR: hzzPbrrKpsH8/laMG7UWh7vSjJZLUg1NJpxu11Bkuex+5Ly4hEoA1wBRoZ1+L/4D2ZMI4F8PvR
 WsaOHVOJvSUNor68ZvrjlRt3T4rU8nRW4HLm+Bpjz7VH5F2q6pySVEh7y3Xe+3pG5ZGkEVLRzN
 gTBJKEOqZaSd0FS+N2nBDzy87ElzHxNh4zvujIwVhoSXhEHKgD56VkCVn7+hOHBjGsMIOF6yiJ
 O4NoRtdoe8RHHjV2Bmzcwk+MQl8MqjGkQFQ3hq0aXslcxIfbSPlMu+FG5maUK2a2/2E5vXxrdx
 el0=
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="54459171"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2019 01:42:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 01:42:02 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 01:42:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOO8mYQx6GosarpiJ8szPBdSUQCvRAYlMU4ptNXGvc51m6KteG2NeBmZV8RGSSLeGzSSCWS0zahChMimJvM2IYiEw8xxkKvvsB4VkFmVB09C3NmMJMCJNKRfprXZZEmMVEXOmlonOy3JAiFzD3Dsk50+CQjD1oT/GaeCh0tYAIxaFM1FyyhENQejQLnuYia1KzSUphR6YeAnwj39frtvloDw2M3OHzxHDgpm3naKCORC6CtGksqWPObkaokRKe1JJ9/KE4aENoZ8JrCYekNZghTY7pW4A+HoAfZCvIR1HzcA0mx8LnruJZak1syoG/grBoAtMx2kTjPOqfsxApUnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P+tOxWeak9J7ZAXQVrXGCbu5DaL6s0XjXJARa3VPaQ=;
 b=K2xSJ25WphqcD/R2pXnrJRMTn1UJi8aNcOxa3BFMgVIeE5WhIfUF12TTKY0Mse0dRrFjD9hf6wivS0dxctHMVlJfEwF9nBNxOF9THTMc8kl7MIQm9A2axURvCoCIA9sIEz7gfZ5rxNDdjr3I8DHBcJNXufwtUi6eSKde2MvzR9u0pLDjSxCLJOZUQjhSWpIUh7NlyK2hxxlCWHMadd0Oj1sLb2Y5jfY+B23C6TGshslNABiO0dHtkTQpvJJnlxoSqAPMkKFZdfA98C4H/XNHVRxfKOdkkDwbdISBAeeMvOjyHL+jcFMrtQksKdu8IKTpd57JbZAPnM597G4hM729xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2P+tOxWeak9J7ZAXQVrXGCbu5DaL6s0XjXJARa3VPaQ=;
 b=a1/n/7NiJMC69/zVfXQXKK82yOutkdmuZOiIXMtCltp68xQ6deQEaE4t74LyO31ZeayW+SICqzI9xaxS1uFmRKrnH3QD18V4S+Wjbt/HVqeWe2TfEra2U8zCvyOK5pi+i0AQobbSAzNBmjs+l1SKUvnT7cSYM8chKdIGQBmi5b4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3824.namprd11.prod.outlook.com (20.178.253.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 08:42:01 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.025; Thu, 7 Nov 2019
 08:42:01 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 4/6] mtd: spi-nor: Rename CR_QUAD_EN_SPAN to
 SR2_QUAD_EN_BIT1
Thread-Topic: [PATCH v5 4/6] mtd: spi-nor: Rename CR_QUAD_EN_SPAN to
 SR2_QUAD_EN_BIT1
Thread-Index: AQHVlUc52k8BvaRMI0OSG2EtSt3f5Q==
Date:   Thu, 7 Nov 2019 08:42:01 +0000
Message-ID: <20191107084135.22122-5-tudor.ambarus@microchip.com>
References: <20191107084135.22122-1-tudor.ambarus@microchip.com>
In-Reply-To: <20191107084135.22122-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0060.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::40) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [109.166.128.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cb39618-276f-44f6-bca3-08d7635e5b6f
x-ms-traffictypediagnostic: MN2PR11MB3824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB382416CB68F3ADB14D406A2AF0780@MN2PR11MB3824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(366004)(376002)(39860400002)(346002)(189003)(199004)(25786009)(6512007)(66476007)(6486002)(110136005)(66946007)(6116002)(66446008)(71200400001)(86362001)(54906003)(66556008)(64756008)(2906002)(6436002)(256004)(36756003)(478600001)(66066001)(14454004)(8936002)(186003)(76176011)(52116002)(316002)(2616005)(99286004)(102836004)(71190400001)(107886003)(81156014)(81166006)(4326008)(2501003)(26005)(1076003)(11346002)(305945005)(7736002)(446003)(6506007)(5660300002)(486006)(476003)(386003)(8676002)(3846002)(50226002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3824;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTznz3MsVDkt+Ge+xXvmHuuRE2V/LiTCw/TM4vN5TouxYnFpMKlbZjvzLMNnMkl1ucqXZkBZuPgV4gd0tPCAN3M+UlNHhzcAJ2h4ofNIZ9ienQeb1vsQAHkt3Mx86A62ARdTDhtpTl4OgveqHUfPYomTIKY0bdOl3OnV3ts7mCUySUymX3F0ojFev/frqsuls6ddha718GGhNIgOkEMoKrCGLvKmHXiUl4bX8yIhjOK35DbLpVgVH+nUWf/sDk16dwgOVMLRihkhy3i7F1BPGOq5+328/LeYlOD0CfeXr9YEiWAK1NHxeIXlA3wENeaZp5sZjVN/Vj/qKoXSmG3x6UEUB1U25aE0A4y//zvhdR0cqJzg+peQBBa7egq/CECkXTDixgD+OwuiPGbgZQkUCj0jUcBT7GECwInBnhWHrO7w6CBe2dJn5edtWPB4l3+I
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb39618-276f-44f6-bca3-08d7635e5b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 08:42:01.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5f2ezRStwHy/f2jkA+qKa8tWPpv0lgmN+FNnNkAt2hfvdjHvv2vzs9Z4u4QsAB0p2dWgrY7elTqeQ0EwY98XHBTYAguKOJf6fztuT/Y0l5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

JEDEC Basic Flash Parameter Table, 15th DWORD, bits 22:20,
refers to this bit as "bit 1 of the status register 2".
Rename the macro accordingly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 8 ++++----
 include/linux/mtd/spi-nor.h   | 4 +---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d33ad56d3b67..8c59b5220e2a 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1026,7 +1026,7 @@ static int spi_nor_write_16bit_sr_and_check(struct sp=
i_nor *nor, u8 sr1)
 		 * Write Status (01h) command is available just for the cases
 		 * in which the QE bit is described in SR2 at BIT(1).
 		 */
-		sr_cr[1] =3D CR_QUAD_EN_SPAN;
+		sr_cr[1] =3D SR2_QUAD_EN_BIT1;
 	} else {
 		sr_cr[1] =3D 0;
 	}
@@ -2074,7 +2074,7 @@ static int spansion_no_read_cr_quad_enable(struct spi=
_nor *nor)
 	if (ret)
 		return ret;
=20
-	sr_cr[1] =3D CR_QUAD_EN_SPAN;
+	sr_cr[1] =3D SR2_QUAD_EN_BIT1;
=20
 	ret =3D spi_nor_write_sr(nor, sr_cr, 2);
 	if (ret)
@@ -2118,10 +2118,10 @@ static int spansion_read_cr_quad_enable(struct spi_=
nor *nor)
 	if (ret)
 		return ret;
=20
-	if (sr_cr[1] & CR_QUAD_EN_SPAN)
+	if (sr_cr[1] & SR2_QUAD_EN_BIT1)
 		return 0;
=20
-	sr_cr[1] |=3D CR_QUAD_EN_SPAN;
+	sr_cr[1] |=3D SR2_QUAD_EN_BIT1;
=20
 	/* Keep the current value of the Status Register. */
 	ret =3D spi_nor_read_sr(nor, sr_cr);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 11daecc5a83d..364309845de0 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -144,10 +144,8 @@
 #define FSR_P_ERR		BIT(4)	/* Program operation status */
 #define FSR_PT_ERR		BIT(1)	/* Protection error bit */
=20
-/* Configuration Register bits. */
-#define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
-
 /* Status Register 2 bits. */
+#define SR2_QUAD_EN_BIT1	BIT(1)
 #define SR2_QUAD_EN_BIT7	BIT(7)
=20
 /* Supported SPI protocols */
--=20
2.9.5

