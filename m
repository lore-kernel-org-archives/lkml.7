Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54F7CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F46D20679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 11:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EgumarlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKBLXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 07:23:41 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:39936 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfKBLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 07:23:39 -0400
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
IronPort-SDR: l9qh2G7aHzD5lUpZPKEVApEPSZLZtIXI8HDuALNojjTrhOlrB3hEc0ewBGHRqrcQ7fOxiAUIVW
 U6Nm9NxISI7XYG5LowqYUE3VwNkJhk9SnQ1TAIP3CFMzhiKf46P3LthFMRANT3AvTVvU9UGRfP
 /T9jjh/bi339dGojnXBuXNlL1RTv9PtmO9KqqFjopyYJUK1OV1gGMdSCHRoqfmSatVcs0VIFjJ
 vK2rmrdVlZW8Asi+tF4xVByDH/uGlO1bGdkdE9HqNtxTt1Q9MjU2eYV3p302gykI0SqNkyzaHq
 jns=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53900862"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 04:23:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 04:23:39 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 04:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsA5Hls+0sIkzy8Ri77ZroNtnoeBfweT0GwjJV/Or3bZHW1FQgAfdyS8NHeEBjkI+Imce7TwOYqZQVgOg/I9mtEyQaLhOLhOWluqUv/BqYiP0ETwIy7SqtJSvzwFEKOc6eW/0JDM5nWAsMHID5BZDmrFwVX6Ob8GIBZDnZbogVvvRXiIOCeiajGbkHsvxvkq513zyGVVb3xZDLCP2NI5D3HTTIVksbBbSegQH4od7FrwLNsOnYP4uUAIwo7v/aZLQGWP+2ffxAgHLmiw0exB4aTOOfNO0IcIvhDwAYzd5XsZkdRbVswwHHbVOgRsyf3sK0gfrmi9KgkhiKFGXqw0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPTf8+2eyRTkTeOGzHF3vSL8DFBglAXqaEotFvcBqBo=;
 b=J4bC25i0S3kFX03rnQA1urhcHrrDPZiKpQHtM4NValibZsw5aAZ6DbB5fYZ2w6x1ghTCTGQGaVo1CWBzg2KN6GkguzF8Pd1Bh520JmgArrNzoQpU2SI/En/DT3MpmFqlW/wHVcVzb818wbmtMvSV2jcoU7yoTcl3evCMnP5pBNB+x+vKjDs81aHHNPBSYKtYlmV4rCwfS7JTm9DU2ZgJ3HSjmw0zzAz0iKalwpNn2nXr6fUP2pSY4yUQS0IyiTCLLvo+d+7780X/VPreYv2XzeJjGuRrEbc6eVKYp8v3qjc4NGDYtcOEDPgWC26NCZxUIUHlfGU8ewYKoRbeSC6I7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPTf8+2eyRTkTeOGzHF3vSL8DFBglAXqaEotFvcBqBo=;
 b=EgumarlYzuBaOl1av+OYmQLD/OuMT6LN6roqiu5XxtLUOFWETWdrBkYl1DMkijQ//+j3js3J+Sq+DsitFo362WDj+MyRhV7wiGUJrhsEbCLIpj8KqK7HQJSWwQ9OSbfN8G0rdYNdgizqV6Vl0XiztTwzy9jdVU4XTd4T7KLkXek=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Sat, 2 Nov 2019 11:23:37 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 11:23:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <vigneshr@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 08/20] mtd: spi-nor: Describe all the Reg Ops
Thread-Topic: [PATCH v4 08/20] mtd: spi-nor: Describe all the Reg Ops
Thread-Index: AQHVkW/4uobJxhxvj0OhsNkYta+AXw==
Date:   Sat, 2 Nov 2019 11:23:37 +0000
Message-ID: <20191102112316.20715-9-tudor.ambarus@microchip.com>
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
x-ms-office365-filtering-correlation-id: 83f98348-660f-42a0-2e7f-08d75f871af8
x-ms-traffictypediagnostic: MN2PR11MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3711D9B0C6E86D44618F45A3F07D0@MN2PR11MB3711.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(64756008)(386003)(316002)(446003)(4326008)(5660300002)(81166006)(6506007)(2616005)(76176011)(81156014)(11346002)(110136005)(476003)(25786009)(54906003)(8936002)(86362001)(486006)(14454004)(8676002)(102836004)(26005)(66476007)(50226002)(2906002)(6116002)(1076003)(2501003)(7736002)(3846002)(99286004)(71200400001)(36756003)(71190400001)(66556008)(256004)(305945005)(6486002)(6436002)(66946007)(66066001)(6512007)(66446008)(478600001)(186003)(52116002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3711;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBWtIVAnaTJ9fpi8s4Ju+z1/C1CycsbxkYL4Ox7vgYe3zDybUB2/j4jKZ759DaaDA5rVuDXzYGWHLZAxhLriptvwdIaBzEiLcyLwC8YnKd3eUZDwYAOmzBpMzsqK2vdTgGxxmfGbhHsAlyKbIOi/hDqVwHu2WTQO3oohtDGaJZ2U1F4/X6ibcHO1cbQ96CK19LZdejeWZ7DDj39G3uOUc9l69xtTXrssNoJF8Z1DMcaQ4JpVsAaLpSRY5WPjJ4KG9D/iGGkVdcHs4m3AW4fBATvl5I535LBJGTbWPakTJgbxgXNyTAOSRR9nch9rAdcJiSZkXFixB3gNIb0TFloxvU74/y7HFB1Kgg3g/fF3D4SXDTv5yy80Ksb3gj9OOHHyHHDaDZpNNNPxQrNUNO+Dq86Wcg4yt3ADllz+A2d6x1sjwUMbdMlbNGl1MVQT8hds
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f98348-660f-42a0-2e7f-08d75f871af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 11:23:37.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /do5NyL7JAMmWmIJafn0nJNv+2eoNHznURgwgPtecBSnKUTz/pd7HvpAs7cp+Oo5m2L+LyepkCXuUFTh62ISK3jyVe337TUhsFZw9QpZ6zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Document all the Register Operations.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 138 ++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 127 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 857675a4e329..99a9a6aba41d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -388,9 +388,11 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor,=
 loff_t to, size_t len,
 	return nor->controller_ops->write(nor, to, len, buf);
 }
=20
-/*
- * Set write enable latch with Write Enable command.
- * Returns negative if error occurred.
+/**
+ * spi_nor_write_enable() - Set write enable latch with Write Enable comma=
nd.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_write_enable(struct spi_nor *nor)
 {
@@ -415,8 +417,11 @@ static int spi_nor_write_enable(struct spi_nor *nor)
 	return ret;
 }
=20
-/*
- * Send write disable instruction to the chip.
+/**
+ * spi_nor_write_disable() - Send Write Disable instruction to the chip.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_write_disable(struct spi_nor *nor)
 {
@@ -534,6 +539,14 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr=
)
 	return ret;
 }
=20
+/**
+ * macronix_set_4byte() - Set 4-byte address mode for Macronix flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byt=
e
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int macronix_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
@@ -562,6 +575,14 @@ static int macronix_set_4byte(struct spi_nor *nor, boo=
l enable)
 	return ret;
 }
=20
+/**
+ * st_micron_set_4byte() - Set 4-byte address mode for ST and Micron flash=
es.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byt=
e
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int st_micron_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
@@ -577,6 +598,14 @@ static int st_micron_set_4byte(struct spi_nor *nor, bo=
ol enable)
 	return spi_nor_write_disable(nor);
 }
=20
+/**
+ * spansion_set_4byte() - Set 4-byte address mode for Spansion flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byt=
e
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spansion_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
@@ -602,6 +631,13 @@ static int spansion_set_4byte(struct spi_nor *nor, boo=
l enable)
 	return ret;
 }
=20
+/**
+ * spi_nor_write_ear() - Write Extended Address Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @ear:	value to write to the Extended Address Register.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 {
 	int ret;
@@ -627,6 +663,14 @@ static int spi_nor_write_ear(struct spi_nor *nor, u8 e=
ar)
 	return ret;
 }
=20
+/**
+ * winbond_set_4byte() - Set 4-byte address mode for Winbond flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the 4-byte address mode, false to exit the 4-byt=
e
+ *		address mode.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int winbond_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
@@ -651,6 +695,14 @@ static int winbond_set_4byte(struct spi_nor *nor, bool=
 enable)
 	return spi_nor_write_disable(nor);
 }
=20
+/**
+ * spi_nor_xread_sr() - Read the Status Register on S3AN flashes.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr:		pointer to a DMA-able buffer where the value of the
+ *              Status Register will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 {
 	int ret;
@@ -674,6 +726,13 @@ static int spi_nor_xread_sr(struct spi_nor *nor, u8 *s=
r)
 	return ret;
 }
=20
+/**
+ * s3an_sr_ready() - Query the Status Register of the S3AN flash to see if=
 the
+ * flash is ready for new commands.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int s3an_sr_ready(struct spi_nor *nor)
 {
 	int ret;
@@ -685,6 +744,10 @@ static int s3an_sr_ready(struct spi_nor *nor)
 	return !!(nor->bouncebuf[0] & XSR_RDY);
 }
=20
+/**
+ * spi_nor_clear_sr() - Clear the Status Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ */
 static void spi_nor_clear_sr(struct spi_nor *nor)
 {
 	int ret;
@@ -706,6 +769,13 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
 		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
 }
=20
+/**
+ * spi_nor_sr_ready() - Query the Status Register to see if the flash is r=
eady
+ * for new commands.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_sr_ready(struct spi_nor *nor)
 {
 	int ret =3D spi_nor_read_sr(nor, nor->bouncebuf);
@@ -727,6 +797,10 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
 	return !(nor->bouncebuf[0] & SR_WIP);
 }
=20
+/**
+ * spi_nor_clear_fsr() - Clear the Flag Status Register.
+ * @nor:	pointer to 'struct spi_nor'.
+ */
 static void spi_nor_clear_fsr(struct spi_nor *nor)
 {
 	int ret;
@@ -748,6 +822,13 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
 }
=20
+/**
+ * spi_nor_fsr_ready() - Query the Flag Status Register to see if the flas=
h is
+ * ready for new commands.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_fsr_ready(struct spi_nor *nor)
 {
 	int ret =3D spi_nor_read_fsr(nor, nor->bouncebuf);
@@ -772,6 +853,12 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
 	return nor->bouncebuf[0] & FSR_READY;
 }
=20
+/**
+ * spi_nor_ready() - Query the flash to see if it is ready for new command=
s.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_ready(struct spi_nor *nor)
 {
 	int sr, fsr;
@@ -788,9 +875,13 @@ static int spi_nor_ready(struct spi_nor *nor)
 	return sr && fsr;
 }
=20
-/*
- * Service routine to read status register until ready, or timeout occurs.
- * Returns non-zero if error.
+/**
+ * spi_nor_wait_till_ready_with_timeout() - Service routine to read the
+ * Status Register until ready, or timeout occurs.
+ * @nor:		pointer to "struct spi_nor".
+ * @timeout_jiffies:	jiffies to wait until timeout.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
 						unsigned long timeout_jiffies)
@@ -818,6 +909,13 @@ static int spi_nor_wait_till_ready_with_timeout(struct=
 spi_nor *nor,
 	return -ETIMEDOUT;
 }
=20
+/**
+ * spi_nor_wait_till_ready() - Wait for a predefined amount of time for th=
e
+ * flash to be ready, or timeout occurs.
+ * @nor:	pointer to "struct spi_nor".
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_wait_till_ready(struct spi_nor *nor)
 {
 	return spi_nor_wait_till_ready_with_timeout(nor,
@@ -880,6 +978,14 @@ static int spi_nor_write_sr_and_check(struct spi_nor *=
nor, u8 status_new,
 	return ((nor->bouncebuf[0] & mask) !=3D (status_new & mask)) ? -EIO : 0;
 }
=20
+/**
+ * spi_nor_write_sr2() - Write the Status Register 2 using the
+ * SPINOR_OP_WRSR2 (3eh) command.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr2:	pointer to DMA-able buffer to write to the Status Register 2.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
 {
 	int ret;
@@ -909,6 +1015,15 @@ static int spi_nor_write_sr2(struct spi_nor *nor, con=
st u8 *sr2)
 	return spi_nor_wait_till_ready(nor);
 }
=20
+/**
+ * spi_nor_read_sr2() - Read the Status Register 2 using the
+ * SPINOR_OP_RDSR2 (3fh) command.
+ * @nor:	pointer to 'struct spi_nor'.
+ * @sr2:	pointer to DMA-able buffer where the value of the
+ *		Status Register 2 will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
 static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 {
 	int ret;
@@ -932,10 +1047,11 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 =
*sr2)
 	return ret;
 }
=20
-/*
- * Erase the whole flash memory
+/**
+ * spi_nor_erase_chip() - Erase the entire flash memory.
+ * @nor:	pointer to 'struct spi_nor'.
  *
- * Returns 0 if successful, non-zero otherwise.
+ * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_erase_chip(struct spi_nor *nor)
 {
--=20
2.9.5

