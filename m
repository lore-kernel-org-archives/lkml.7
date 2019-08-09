Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701EFC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E4D2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cDAvsf7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406549AbfHIL3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:29:30 -0400
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:49541
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfHIL32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTDEnVkG7qygvr0w++WIY2YHDsAfur/vZhk//ip2V1jhm3LatUJHTTN4n3diwSUvtO8igUsBk2W+4vEtvveS99g/hcsWHq44PqqThaDI2yRAOF/AbnETWfIzXdFMA68oNzVywkIhbBGmfnx7EBW07kLFo7ukH2DPK8YPz2qAYtJV0RYb6nyzYco9ldbyXXdksNWV1fTsrP7CHyDSDjqA1WlbIafZ78syVitWXyYu6k647mG7xerdS8tCVOZnRFODDxirCMTTWXkFcGli2BNIFzzjcYUsEjj5E7t5XWm4ZbPnqsrHSu44Q4C7vmY30R8MzlsJgx5yOLXKBRtMmN0Rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTWPBLt7N35I6+mc5/CTAlCt2bBtiBjt4o0KenR1c6g=;
 b=fdnqMw1Yqcucrdzki4L2eWxXrQlDyvMpwod1JPk0VciAL8zSefYjfx9m7AZxMIS3eIfI4y3REEDFALVkthDODhm0U5JSlFZGKoaT7KyCRlvtpzxvD8GjirLck0ncgCjpV5qjunK1A3Zhq2ww+XCktAtFqrGvPNgUK12+rmUywSz9YPlFckcbEVxX3r/IaSY/Xhi6m7siMOuGY7TkEvGqdG/yzhZNzbX5S3YjnNxJ/TTlakCBM9ri5V1PB8ylduaTYmkPeUMHSh84M39mQ9S/T6tP+5+F9P9HLQgTqoPYNcgs+b6UvZ2iVvIlRQ7gqaaQ1g8AcF8O9A/LUY01tdsWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTWPBLt7N35I6+mc5/CTAlCt2bBtiBjt4o0KenR1c6g=;
 b=cDAvsf7ZhaWRQEoKZz9yePoUOee4NCnoTvMUJmgI41fYxIU3bHdOSiEwks8zwI+CUrr4APZ9+uYDjxQZTUHal1RU2fyY+t2ZVgrYHum/jQe6AU5OwNtQiXQqMT24KoO/C3Tt6Ff5AVoafoRlhMEPC1twQBK1jO3xPEDlznxMnDM=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3359.eurprd04.prod.outlook.com (52.134.1.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Fri, 9 Aug 2019 11:29:16 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 11:29:16 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v2 5/6] tty: serial: Add linflexuart driver for S32V234
Thread-Topic: [PATCH v2 5/6] tty: serial: Add linflexuart driver for S32V234
Thread-Index: AQHVTqWtXXET2+6xDU23/kc3OkYYnw==
Date:   Fri, 9 Aug 2019 11:29:16 +0000
Message-ID: <20190809112853.15846-6-stefan-gabriel.mirea@nxp.com>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
In-Reply-To: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.22.0
x-clientproxiedby: AM5PR06CA0024.eurprd06.prod.outlook.com
 (2603:10a6:206:2::37) To VI1PR0402MB2863.eurprd04.prod.outlook.com
 (2603:10a6:800:af::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 690abe05-8d31-4302-84e9-08d71cbccf90
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3359;
x-ms-traffictypediagnostic: VI1PR0402MB3359:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3359562E5AE3967E437DBB06DFD60@VI1PR0402MB3359.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(66476007)(66446008)(66556008)(64756008)(5660300002)(6512007)(26005)(186003)(6306002)(2201001)(52116002)(76176011)(8936002)(99286004)(14454004)(50226002)(30864003)(1076003)(86362001)(66946007)(71190400001)(71200400001)(4326008)(386003)(966005)(6506007)(53936002)(478600001)(53946003)(102836004)(110136005)(2906002)(256004)(25786009)(8676002)(66066001)(476003)(2616005)(14444005)(54906003)(2501003)(486006)(316002)(36756003)(6116002)(3846002)(6486002)(7736002)(6636002)(7416002)(6436002)(305945005)(81156014)(446003)(11346002)(81166006)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3359;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IeCEVP37jN4qKGFJN0b/5vMWoMH06ux8C23Vgrx/cS7DC/5c5px8ZYm8mZzilh04UQk1naXaIzj4tSqOrObYz/vDIm5DTjLhK75xUORX5XcWW2JN2bdlUzSsyXszevfTaUiwprNWmARim+2hcvU91NE1n1QlglWXRo/jmu6u6LqNYmSpA2sSHcfcleV71JFvzRLNsTHMvkej/gHELNNWgI2qvliqlMU+hMittb9hB3GuAKkxA6SiaNJdhAJa2KqBtPtpiB++B4fPvoL6CzM/7cHSjroidTxrRKDOlHY6R29CRyGtyYjKZcSbyoiFmyKSNvkdi3GP8OMA4ck+RxJ79jUAzeT2aasGicgWkjJXvAj/l2kM5z/V3ujG6/IOH/W3HzPh0cbzt7TK0xYLnqB94Q/7O0E+WDaYntRpcKJJbdE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690abe05-8d31-4302-84e9-08d71cbccf90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 11:29:16.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFiBcu4N7EQLn1KCfhMI/D7PBKK9iHlxZBseQZfPPGGIg6NiuJTKzp+S0yzP/B24vrsHyrxQGipyrDev7X2ncHEPX7PGO3xoYtT3SOigDw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3359
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for LINFlex driver, based on:
- the version of Freescale LPUART driver after commit b3e3bf2ef2c7 ("Merge
  4.0-rc7 into tty-next");
- commit abf1e0a98083 ("tty: serial: fsl_lpuart: lock port on console
  write").
In this basic version, the driver can be tested using initramfs and relies
on the clocks and pin muxing set up by U-Boot.

Remarks concerning the earlycon support:

- LinFlexD does not allow character transmissions in the INIT mode (see
  section 47.4.2.1 in the reference manual[1]). Therefore, a mutual
  exclusion between the first linflex_setup_watermark/linflex_set_termios
  executions and linflex_earlycon_putchar was employed and the characters
  normally sent to earlycon during initialization are kept in a buffer and
  sent afterwards.

- Empirically, character transmission is also forbidden within the last 1-2
  ms before entering the INIT mode, so we use an explicit timeout
  (PREINIT_DELAY) between linflex_earlycon_putchar and the first call to
  linflex_setup_watermark.

- U-Boot currently uses the UART FIFO mode, while this driver makes the
  transition to the buffer mode. Therefore, the earlycon putchar function
  matches the U-Boot behavior before initializations and the Linux behavior
  after.

[1] https://www.nxp.com/webapp/Download?colCode=3DS32V234RM

Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Adrian.Nitu <adrian.nitu@freescale.com>
Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
Signed-off-by: Ana Nedelcu <B56683@freescale.com>
Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
Signed-off-by: Matthew Nunez <matthew.nunez@nxp.com>
[stefan-gabriel.mirea@nxp.com: Reduced for upstreaming and implemented
                               earlycon support]
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 drivers/tty/serial/Kconfig                    |  15 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/fsl_linflexuart.c          | 942 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 5 files changed, 967 insertions(+)
 create mode 100644 drivers/tty/serial/fsl_linflexuart.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 46b826fcb5ad..4d545732aadc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1090,6 +1090,12 @@
 			the framebuffer, pass the 'ram' option so that it is
 			mapped with the correct attributes.
=20
+		linflex,<addr>
+			Use early console provided by Freescale LinFlex UART
+			serial driver for NXP S32V234 SoCs. A valid base
+			address must be provided, and the serial port must
+			already be setup and configured.
+
 	earlyprintk=3D	[X86,SH,ARM,M68k,S390]
 			earlyprintk=3Dvga
 			earlyprintk=3Dsclp
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index fd385c8c53a5..b4fa2f7c96bd 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1452,6 +1452,21 @@ config SERIAL_FSL_LPUART_CONSOLE
 	  If you have enabled the lpuart serial port on the Freescale SoCs,
 	  you can make it the console by answering Y to this option.
=20
+config SERIAL_FSL_LINFLEXUART
+	tristate "Freescale linflexuart serial port support"
+	select SERIAL_CORE
+	help
+	  Support for the on-chip linflexuart on some Freescale SOCs.
+
+config SERIAL_FSL_LINFLEXUART_CONSOLE
+	bool "Console on Freescale linflexuart serial port"
+	depends on SERIAL_FSL_LINFLEXUART=3Dy
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  If you have enabled the linflexuart serial port on the Freescale
+	  SoCs, you can make it the console by answering Y to this option.
+
 config SERIAL_CONEXANT_DIGICOLOR
 	tristate "Conexant Digicolor CX92xxx USART serial port support"
 	depends on OF
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 7cd7cabfa6c4..7a3d52a453b7 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_SERIAL_EFM32_UART) +=3D efm32-uart.o
 obj-$(CONFIG_SERIAL_ARC)	+=3D arc_uart.o
 obj-$(CONFIG_SERIAL_RP2)	+=3D rp2.o
 obj-$(CONFIG_SERIAL_FSL_LPUART)	+=3D fsl_lpuart.o
+obj-$(CONFIG_SERIAL_FSL_LINFLEXUART)	+=3D fsl_linflexuart.o
 obj-$(CONFIG_SERIAL_CONEXANT_DIGICOLOR)	+=3D digicolor-usart.o
 obj-$(CONFIG_SERIAL_MEN_Z135)	+=3D men_z135_uart.o
 obj-$(CONFIG_SERIAL_SPRD) +=3D sprd_serial.o
diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_=
linflexuart.c
new file mode 100644
index 000000000000..26b9601a0952
--- /dev/null
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -0,0 +1,942 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Freescale linflexuart serial port driver
+ *
+ * Copyright 2012-2016 Freescale Semiconductor, Inc.
+ * Copyright 2017-2018 NXP
+ */
+
+#if defined(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE) && \
+	defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/console.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
+#include <linux/delay.h>
+
+/* All registers are 32-bit width */
+
+#define LINCR1	0x0000	/* LIN control register				*/
+#define LINIER	0x0004	/* LIN interrupt enable register		*/
+#define LINSR	0x0008	/* LIN status register				*/
+#define LINESR	0x000C	/* LIN error status register			*/
+#define UARTCR	0x0010	/* UART mode control register			*/
+#define UARTSR	0x0014	/* UART mode status register			*/
+#define LINTCSR	0x0018	/* LIN timeout control status register		*/
+#define LINOCR	0x001C	/* LIN output compare register			*/
+#define LINTOCR	0x0020	/* LIN timeout control register			*/
+#define LINFBRR	0x0024	/* LIN fractional baud rate register		*/
+#define LINIBRR	0x0028	/* LIN integer baud rate register		*/
+#define LINCFR	0x002C	/* LIN checksum field register			*/
+#define LINCR2	0x0030	/* LIN control register 2			*/
+#define BIDR	0x0034	/* Buffer identifier register			*/
+#define BDRL	0x0038	/* Buffer data register least significant	*/
+#define BDRM	0x003C	/* Buffer data register most significant	*/
+#define IFER	0x0040	/* Identifier filter enable register		*/
+#define IFMI	0x0044	/* Identifier filter match index		*/
+#define IFMR	0x0048	/* Identifier filter mode register		*/
+#define GCR	0x004C	/* Global control register			*/
+#define UARTPTO	0x0050	/* UART preset timeout register			*/
+#define UARTCTO	0x0054	/* UART current timeout register		*/
+
+/*
+ * Register field definitions
+ */
+
+#define LINFLEXD_LINCR1_INIT		BIT(0)
+#define LINFLEXD_LINCR1_MME		BIT(4)
+#define LINFLEXD_LINCR1_BF		BIT(7)
+
+#define LINFLEXD_LINSR_LINS_INITMODE	BIT(12)
+#define LINFLEXD_LINSR_LINS_MASK	(0xF << 12)
+
+#define LINFLEXD_LINIER_SZIE		BIT(15)
+#define LINFLEXD_LINIER_OCIE		BIT(14)
+#define LINFLEXD_LINIER_BEIE		BIT(13)
+#define LINFLEXD_LINIER_CEIE		BIT(12)
+#define LINFLEXD_LINIER_HEIE		BIT(11)
+#define LINFLEXD_LINIER_FEIE		BIT(8)
+#define LINFLEXD_LINIER_BOIE		BIT(7)
+#define LINFLEXD_LINIER_LSIE		BIT(6)
+#define LINFLEXD_LINIER_WUIE		BIT(5)
+#define LINFLEXD_LINIER_DBFIE		BIT(4)
+#define LINFLEXD_LINIER_DBEIETOIE	BIT(3)
+#define LINFLEXD_LINIER_DRIE		BIT(2)
+#define LINFLEXD_LINIER_DTIE		BIT(1)
+#define LINFLEXD_LINIER_HRIE		BIT(0)
+
+#define LINFLEXD_UARTCR_OSR_MASK	(0xF << 24)
+#define LINFLEXD_UARTCR_OSR(uartcr)	(((uartcr) \
+					& LINFLEXD_UARTCR_OSR_MASK) >> 24)
+
+#define LINFLEXD_UARTCR_ROSE		BIT(23)
+
+#define LINFLEXD_UARTCR_RFBM		BIT(9)
+#define LINFLEXD_UARTCR_TFBM		BIT(8)
+#define LINFLEXD_UARTCR_WL1		BIT(7)
+#define LINFLEXD_UARTCR_PC1		BIT(6)
+
+#define LINFLEXD_UARTCR_RXEN		BIT(5)
+#define LINFLEXD_UARTCR_TXEN		BIT(4)
+#define LINFLEXD_UARTCR_PC0		BIT(3)
+
+#define LINFLEXD_UARTCR_PCE		BIT(2)
+#define LINFLEXD_UARTCR_WL0		BIT(1)
+#define LINFLEXD_UARTCR_UART		BIT(0)
+
+#define LINFLEXD_UARTSR_SZF		BIT(15)
+#define LINFLEXD_UARTSR_OCF		BIT(14)
+#define LINFLEXD_UARTSR_PE3		BIT(13)
+#define LINFLEXD_UARTSR_PE2		BIT(12)
+#define LINFLEXD_UARTSR_PE1		BIT(11)
+#define LINFLEXD_UARTSR_PE0		BIT(10)
+#define LINFLEXD_UARTSR_RMB		BIT(9)
+#define LINFLEXD_UARTSR_FEF		BIT(8)
+#define LINFLEXD_UARTSR_BOF		BIT(7)
+#define LINFLEXD_UARTSR_RPS		BIT(6)
+#define LINFLEXD_UARTSR_WUF		BIT(5)
+#define LINFLEXD_UARTSR_4		BIT(4)
+
+#define LINFLEXD_UARTSR_TO		BIT(3)
+
+#define LINFLEXD_UARTSR_DRFRFE		BIT(2)
+#define LINFLEXD_UARTSR_DTFTFF		BIT(1)
+#define LINFLEXD_UARTSR_NF		BIT(0)
+#define LINFLEXD_UARTSR_PE		(LINFLEXD_UARTSR_PE0 |\
+					 LINFLEXD_UARTSR_PE1 |\
+					 LINFLEXD_UARTSR_PE2 |\
+					 LINFLEXD_UARTSR_PE3)
+
+#define LINFLEX_LDIV_MULTIPLIER		(16)
+
+#define DRIVER_NAME	"fsl-linflexuart"
+#define DEV_NAME	"ttyLF"
+#define UART_NR		4
+
+#define EARLYCON_BUFFER_INITIAL_CAP	8
+
+#define PREINIT_DELAY			2000 /* us */
+
+static const struct of_device_id linflex_dt_ids[] =3D {
+	{
+		.compatible =3D "fsl,s32-linflexuart",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, linflex_dt_ids);
+
+#ifdef CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE
+static struct uart_port *earlycon_port;
+static bool linflex_earlycon_same_instance;
+static spinlock_t init_lock;
+static bool during_init;
+
+static struct {
+	char *content;
+	unsigned int len, cap;
+} earlycon_buf;
+#endif
+
+static void linflex_stop_tx(struct uart_port *port)
+{
+	unsigned long ier;
+
+	ier =3D readl(port->membase + LINIER);
+	ier &=3D ~(LINFLEXD_LINIER_DTIE);
+	writel(ier, port->membase + LINIER);
+}
+
+static void linflex_stop_rx(struct uart_port *port)
+{
+	unsigned long ier;
+
+	ier =3D readl(port->membase + LINIER);
+	writel(ier & ~LINFLEXD_LINIER_DRIE, port->membase + LINIER);
+}
+
+static inline void linflex_transmit_buffer(struct uart_port *sport)
+{
+	struct circ_buf *xmit =3D &sport->state->xmit;
+	unsigned char c;
+	unsigned long status;
+
+	while (!uart_circ_empty(xmit)) {
+		c =3D xmit->buf[xmit->tail];
+		writeb(c, sport->membase + BDRL);
+
+		/* Waiting for data transmission completed. */
+		while (((status =3D readl(sport->membase + UARTSR)) &
+					LINFLEXD_UARTSR_DTFTFF) !=3D
+					LINFLEXD_UARTSR_DTFTFF)
+			;
+
+		xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		sport->icount.tx++;
+
+		writel(status | LINFLEXD_UARTSR_DTFTFF,
+		       sport->membase + UARTSR);
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(sport);
+
+	if (uart_circ_empty(xmit))
+		linflex_stop_tx(sport);
+}
+
+static void linflex_start_tx(struct uart_port *port)
+{
+	unsigned long ier;
+
+	linflex_transmit_buffer(port);
+	ier =3D readl(port->membase + LINIER);
+	writel(ier | LINFLEXD_LINIER_DTIE, port->membase + LINIER);
+}
+
+static irqreturn_t linflex_txint(int irq, void *dev_id)
+{
+	struct uart_port *sport =3D dev_id;
+	struct circ_buf *xmit =3D &sport->state->xmit;
+	unsigned long flags;
+	unsigned long status;
+
+	spin_lock_irqsave(&sport->lock, flags);
+
+	if (sport->x_char) {
+		writeb(sport->x_char, sport->membase + BDRL);
+
+		/* waiting for data transmission completed */
+		while (((status =3D readl(sport->membase + UARTSR)) &
+			LINFLEXD_UARTSR_DTFTFF) !=3D LINFLEXD_UARTSR_DTFTFF)
+			;
+
+		writel(status | LINFLEXD_UARTSR_DTFTFF,
+		       sport->membase + UARTSR);
+
+		goto out;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(sport)) {
+		linflex_stop_tx(sport);
+		goto out;
+	}
+
+	linflex_transmit_buffer(sport);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(sport);
+
+out:
+	spin_unlock_irqrestore(&sport->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t linflex_rxint(int irq, void *dev_id)
+{
+	struct uart_port *sport =3D dev_id;
+	unsigned int flg;
+	struct tty_port *port =3D &sport->state->port;
+	unsigned long flags, status;
+	unsigned char rx;
+
+	spin_lock_irqsave(&sport->lock, flags);
+
+	status =3D readl(sport->membase + UARTSR);
+	while (status & LINFLEXD_UARTSR_RMB) {
+		rx =3D readb(sport->membase + BDRM);
+		flg =3D TTY_NORMAL;
+		sport->icount.rx++;
+
+		if (status & (LINFLEXD_UARTSR_BOF | LINFLEXD_UARTSR_SZF |
+			      LINFLEXD_UARTSR_FEF | LINFLEXD_UARTSR_PE)) {
+			if (status & LINFLEXD_UARTSR_SZF)
+				status |=3D LINFLEXD_UARTSR_SZF;
+			if (status & LINFLEXD_UARTSR_BOF)
+				status |=3D LINFLEXD_UARTSR_BOF;
+			if (status & LINFLEXD_UARTSR_FEF)
+				status |=3D LINFLEXD_UARTSR_FEF;
+			if (status & LINFLEXD_UARTSR_PE)
+				status |=3D  LINFLEXD_UARTSR_PE;
+		}
+
+		writel(status | LINFLEXD_UARTSR_RMB | LINFLEXD_UARTSR_DRFRFE,
+		       sport->membase + UARTSR);
+		status =3D readl(sport->membase + UARTSR);
+
+		if (uart_handle_sysrq_char(sport, (unsigned char)rx))
+			continue;
+
+#ifdef SUPPORT_SYSRQ
+			sport->sysrq =3D 0;
+#endif
+		tty_insert_flip_char(port, rx, flg);
+	}
+
+	spin_unlock_irqrestore(&sport->lock, flags);
+
+	tty_flip_buffer_push(port);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t linflex_int(int irq, void *dev_id)
+{
+	struct uart_port *sport =3D dev_id;
+	unsigned long status;
+
+	status =3D readl(sport->membase + UARTSR);
+
+	if (status & LINFLEXD_UARTSR_DRFRFE)
+		linflex_rxint(irq, dev_id);
+	if (status & LINFLEXD_UARTSR_DTFTFF)
+		linflex_txint(irq, dev_id);
+
+	return IRQ_HANDLED;
+}
+
+/* return TIOCSER_TEMT when transmitter is not busy */
+static unsigned int linflex_tx_empty(struct uart_port *port)
+{
+	unsigned long status;
+
+	status =3D readl(port->membase + UARTSR) & LINFLEXD_UARTSR_DTFTFF;
+
+	return status ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int linflex_get_mctrl(struct uart_port *port)
+{
+	return 0;
+}
+
+static void linflex_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+}
+
+static void linflex_break_ctl(struct uart_port *port, int break_state)
+{
+}
+
+static void linflex_setup_watermark(struct uart_port *sport)
+{
+	unsigned long cr, ier, cr1;
+
+	/* Disable transmission/reception */
+	ier =3D readl(sport->membase + LINIER);
+	ier &=3D ~(LINFLEXD_LINIER_DRIE | LINFLEXD_LINIER_DTIE);
+	writel(ier, sport->membase + LINIER);
+
+	cr =3D readl(sport->membase + UARTCR);
+	cr &=3D ~(LINFLEXD_UARTCR_RXEN | LINFLEXD_UARTCR_TXEN);
+	writel(cr, sport->membase + UARTCR);
+
+	/* Enter initialization mode by setting INIT bit */
+
+	/* set the Linflex in master mode and activate by-pass filter */
+	cr1 =3D LINFLEXD_LINCR1_BF | LINFLEXD_LINCR1_MME
+	      | LINFLEXD_LINCR1_INIT;
+	writel(cr1, sport->membase + LINCR1);
+
+	/* wait for init mode entry */
+	while ((readl(sport->membase + LINSR)
+		& LINFLEXD_LINSR_LINS_MASK)
+		!=3D LINFLEXD_LINSR_LINS_INITMODE)
+		;
+
+	/*
+	 *	UART =3D 0x1;		- Linflex working in UART mode
+	 *	TXEN =3D 0x1;		- Enable transmission of data now
+	 *	RXEn =3D 0x1;		- Receiver enabled
+	 *	WL0 =3D 0x1;		- 8 bit data
+	 *	PCE =3D 0x0;		- No parity
+	 */
+
+	/* set UART bit to allow writing other bits */
+	writel(LINFLEXD_UARTCR_UART, sport->membase + UARTCR);
+
+	cr =3D (LINFLEXD_UARTCR_RXEN | LINFLEXD_UARTCR_TXEN |
+	      LINFLEXD_UARTCR_WL0 | LINFLEXD_UARTCR_UART);
+
+	writel(cr, sport->membase + UARTCR);
+
+	cr1 &=3D ~(LINFLEXD_LINCR1_INIT);
+
+	writel(cr1, sport->membase + LINCR1);
+
+	ier =3D readl(sport->membase + LINIER);
+	ier |=3D LINFLEXD_LINIER_DRIE;
+	ier |=3D LINFLEXD_LINIER_DTIE;
+
+	writel(ier, sport->membase + LINIER);
+}
+
+static int linflex_startup(struct uart_port *port)
+{
+	int ret =3D 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	linflex_setup_watermark(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	ret =3D devm_request_irq(port->dev, port->irq, linflex_int, 0,
+			       DRIVER_NAME, port);
+
+	return ret;
+}
+
+static void linflex_shutdown(struct uart_port *port)
+{
+	unsigned long ier;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* disable interrupts */
+	ier =3D readl(port->membase + LINIER);
+	ier &=3D ~(LINFLEXD_LINIER_DRIE | LINFLEXD_LINIER_DTIE);
+	writel(ier, port->membase + LINIER);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	devm_free_irq(port->dev, port->irq, port);
+}
+
+static void
+linflex_set_termios(struct uart_port *port, struct ktermios *termios,
+		    struct ktermios *old)
+{
+	unsigned long flags;
+	unsigned long cr, old_cr, cr1;
+	unsigned int old_csize =3D old ? old->c_cflag & CSIZE : CS8;
+
+	cr =3D readl(port->membase + UARTCR);
+	old_cr =3D cr;
+
+	/* Enter initialization mode by setting INIT bit */
+	cr1 =3D readl(port->membase + LINCR1);
+	cr1 |=3D LINFLEXD_LINCR1_INIT;
+	writel(cr1, port->membase + LINCR1);
+
+	/* wait for init mode entry */
+	while ((readl(port->membase + LINSR)
+		& LINFLEXD_LINSR_LINS_MASK)
+		!=3D LINFLEXD_LINSR_LINS_INITMODE)
+		;
+
+	/*
+	 * only support CS8 and CS7, and for CS7 must enable PE.
+	 * supported mode:
+	 *	- (7,e/o,1)
+	 *	- (8,n,1)
+	 *	- (8,e/o,1)
+	 */
+	/* enter the UART into configuration mode */
+
+	while ((termios->c_cflag & CSIZE) !=3D CS8 &&
+	       (termios->c_cflag & CSIZE) !=3D CS7) {
+		termios->c_cflag &=3D ~CSIZE;
+		termios->c_cflag |=3D old_csize;
+		old_csize =3D CS8;
+	}
+
+	if ((termios->c_cflag & CSIZE) =3D=3D CS7) {
+		/* Word length: WL1WL0:00 */
+		cr =3D old_cr & ~LINFLEXD_UARTCR_WL1 & ~LINFLEXD_UARTCR_WL0;
+	}
+
+	if ((termios->c_cflag & CSIZE) =3D=3D CS8) {
+		/* Word length: WL1WL0:01 */
+		cr =3D (old_cr | LINFLEXD_UARTCR_WL0) & ~LINFLEXD_UARTCR_WL1;
+	}
+
+	if (termios->c_cflag & CMSPAR) {
+		if ((termios->c_cflag & CSIZE) !=3D CS8) {
+			termios->c_cflag &=3D ~CSIZE;
+			termios->c_cflag |=3D CS8;
+		}
+		/* has a space/sticky bit */
+		cr |=3D LINFLEXD_UARTCR_WL0;
+	}
+
+	if (termios->c_cflag & CSTOPB)
+		termios->c_cflag &=3D ~CSTOPB;
+
+	/* parity must be enabled when CS7 to match 8-bits format */
+	if ((termios->c_cflag & CSIZE) =3D=3D CS7)
+		termios->c_cflag |=3D PARENB;
+
+	if ((termios->c_cflag & PARENB)) {
+		cr |=3D LINFLEXD_UARTCR_PCE;
+		if (termios->c_cflag & PARODD)
+			cr =3D (cr | LINFLEXD_UARTCR_PC0) &
+			     (~LINFLEXD_UARTCR_PC1);
+		else
+			cr =3D cr & (~LINFLEXD_UARTCR_PC1 &
+				   ~LINFLEXD_UARTCR_PC0);
+	} else {
+		cr &=3D ~LINFLEXD_UARTCR_PCE;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	port->read_status_mask =3D 0;
+
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |=3D	(LINFLEXD_UARTSR_FEF |
+						 LINFLEXD_UARTSR_PE0 |
+						 LINFLEXD_UARTSR_PE1 |
+						 LINFLEXD_UARTSR_PE2 |
+						 LINFLEXD_UARTSR_PE3);
+	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
+		port->read_status_mask |=3D LINFLEXD_UARTSR_FEF;
+
+	/* characters to ignore */
+	port->ignore_status_mask =3D 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |=3D LINFLEXD_UARTSR_PE;
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |=3D LINFLEXD_UARTSR_PE;
+		/*
+		 * if we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |=3D LINFLEXD_UARTSR_BOF;
+	}
+
+	writel(cr, port->membase + UARTCR);
+
+	cr1 &=3D ~(LINFLEXD_LINCR1_INIT);
+
+	writel(cr1, port->membase + LINCR1);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *linflex_type(struct uart_port *port)
+{
+	return "FSL_LINFLEX";
+}
+
+static void linflex_release_port(struct uart_port *port)
+{
+	/* nothing to do */
+}
+
+static int linflex_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+/* configure/auto-configure the port */
+static void linflex_config_port(struct uart_port *port, int flags)
+{
+	if (flags & UART_CONFIG_TYPE)
+		port->type =3D PORT_LINFLEXUART;
+}
+
+static const struct uart_ops linflex_pops =3D {
+	.tx_empty	=3D linflex_tx_empty,
+	.set_mctrl	=3D linflex_set_mctrl,
+	.get_mctrl	=3D linflex_get_mctrl,
+	.stop_tx	=3D linflex_stop_tx,
+	.start_tx	=3D linflex_start_tx,
+	.stop_rx	=3D linflex_stop_rx,
+	.break_ctl	=3D linflex_break_ctl,
+	.startup	=3D linflex_startup,
+	.shutdown	=3D linflex_shutdown,
+	.set_termios	=3D linflex_set_termios,
+	.type		=3D linflex_type,
+	.request_port	=3D linflex_request_port,
+	.release_port	=3D linflex_release_port,
+	.config_port	=3D linflex_config_port,
+};
+
+static struct uart_port *linflex_ports[UART_NR];
+
+#ifdef CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE
+static void linflex_console_putchar(struct uart_port *port, int ch)
+{
+	unsigned long cr;
+
+	cr =3D readl(port->membase + UARTCR);
+
+	writeb(ch, port->membase + BDRL);
+
+	if (!(cr & LINFLEXD_UARTCR_TFBM))
+		while ((readl(port->membase + UARTSR) &
+					LINFLEXD_UARTSR_DTFTFF)
+				!=3D LINFLEXD_UARTSR_DTFTFF)
+			;
+	else
+		while (readl(port->membase + UARTSR) &
+					LINFLEXD_UARTSR_DTFTFF)
+			;
+
+	if (!(cr & LINFLEXD_UARTCR_TFBM)) {
+		writel((readl(port->membase + UARTSR) |
+					LINFLEXD_UARTSR_DTFTFF),
+					port->membase + UARTSR);
+	}
+}
+
+static void linflex_earlycon_putchar(struct uart_port *port, int ch)
+{
+	unsigned long flags;
+	char *ret;
+
+	if (!linflex_earlycon_same_instance) {
+		linflex_console_putchar(port, ch);
+		return;
+	}
+
+	spin_lock_irqsave(&init_lock, flags);
+	if (!during_init)
+		goto outside_init;
+
+	if (earlycon_buf.len >=3D 1 << CONFIG_LOG_BUF_SHIFT)
+		goto init_release;
+
+	if (!earlycon_buf.cap) {
+		earlycon_buf.content =3D kmalloc(EARLYCON_BUFFER_INITIAL_CAP,
+					       GFP_ATOMIC);
+		earlycon_buf.cap =3D earlycon_buf.content ?
+				   EARLYCON_BUFFER_INITIAL_CAP : 0;
+	} else if (earlycon_buf.len =3D=3D earlycon_buf.cap) {
+		ret =3D krealloc(earlycon_buf.content, earlycon_buf.cap << 1,
+			       GFP_ATOMIC);
+		if (ret) {
+			earlycon_buf.content =3D ret;
+			earlycon_buf.cap <<=3D 1;
+		}
+	}
+
+	if (earlycon_buf.len < earlycon_buf.cap)
+		earlycon_buf.content[earlycon_buf.len++] =3D ch;
+
+	goto init_release;
+
+outside_init:
+	linflex_console_putchar(port, ch);
+init_release:
+	spin_unlock_irqrestore(&init_lock, flags);
+}
+
+static void linflex_string_write(struct uart_port *sport, const char *s,
+				 unsigned int count)
+{
+	unsigned long cr, ier =3D 0;
+
+	ier =3D readl(sport->membase + LINIER);
+	linflex_stop_tx(sport);
+
+	cr =3D readl(sport->membase + UARTCR);
+	cr |=3D (LINFLEXD_UARTCR_TXEN);
+	writel(cr, sport->membase + UARTCR);
+
+	uart_console_write(sport, s, count, linflex_console_putchar);
+
+	writel(ier, sport->membase + LINIER);
+}
+
+static void
+linflex_console_write(struct console *co, const char *s, unsigned int coun=
t)
+{
+	struct uart_port *sport =3D linflex_ports[co->index];
+	unsigned long flags;
+	int locked =3D 1;
+
+	if (sport->sysrq)
+		locked =3D 0;
+	else if (oops_in_progress)
+		locked =3D spin_trylock_irqsave(&sport->lock, flags);
+	else
+		spin_lock_irqsave(&sport->lock, flags);
+
+	linflex_string_write(sport, s, count);
+
+	if (locked)
+		spin_unlock_irqrestore(&sport->lock, flags);
+}
+
+/*
+ * if the port was already initialised (eg, by a boot loader),
+ * try to determine the current setup.
+ */
+static void __init
+linflex_console_get_options(struct uart_port *sport, int *parity, int *bit=
s)
+{
+	unsigned long cr;
+
+	cr =3D readl(sport->membase + UARTCR);
+	cr &=3D LINFLEXD_UARTCR_RXEN | LINFLEXD_UARTCR_TXEN;
+
+	if (!cr)
+		return;
+
+	/* ok, the port was enabled */
+
+	*parity =3D 'n';
+	if (cr & LINFLEXD_UARTCR_PCE) {
+		if (cr & LINFLEXD_UARTCR_PC0)
+			*parity =3D 'o';
+		else
+			*parity =3D 'e';
+	}
+
+	if ((cr & LINFLEXD_UARTCR_WL0) && ((cr & LINFLEXD_UARTCR_WL1) =3D=3D 0)) =
{
+		if (cr & LINFLEXD_UARTCR_PCE)
+			*bits =3D 9;
+		else
+			*bits =3D 8;
+	}
+}
+
+static int __init linflex_console_setup(struct console *co, char *options)
+{
+	struct uart_port *sport;
+	int baud =3D 115200;
+	int bits =3D 8;
+	int parity =3D 'n';
+	int flow =3D 'n';
+	int ret;
+	int i;
+	unsigned long flags;
+	/*
+	 * check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if (co->index =3D=3D -1 || co->index >=3D ARRAY_SIZE(linflex_ports))
+		co->index =3D 0;
+
+	sport =3D linflex_ports[co->index];
+	if (!sport)
+		return -ENODEV;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	else
+		linflex_console_get_options(sport, &parity, &bits);
+
+	if (earlycon_port && sport->mapbase =3D=3D earlycon_port->mapbase) {
+		linflex_earlycon_same_instance =3D true;
+
+		spin_lock_irqsave(&init_lock, flags);
+		during_init =3D true;
+		spin_unlock_irqrestore(&init_lock, flags);
+
+		/* Workaround for character loss or output of many invalid
+		 * characters, when INIT mode is entered shortly after a
+		 * character has just been printed.
+		 */
+		udelay(PREINIT_DELAY);
+	}
+
+	linflex_setup_watermark(sport);
+
+	ret =3D uart_set_options(sport, co, baud, parity, bits, flow);
+
+	if (!linflex_earlycon_same_instance)
+		goto done;
+
+	spin_lock_irqsave(&init_lock, flags);
+
+	/* Emptying buffer */
+	if (earlycon_buf.len) {
+		for (i =3D 0; i < earlycon_buf.len; i++)
+			linflex_console_putchar(earlycon_port,
+				earlycon_buf.content[i]);
+
+		kfree(earlycon_buf.content);
+		earlycon_buf.len =3D 0;
+	}
+
+	during_init =3D false;
+	spin_unlock_irqrestore(&init_lock, flags);
+
+done:
+	return ret;
+}
+
+static struct uart_driver linflex_reg;
+static struct console linflex_console =3D {
+	.name		=3D DEV_NAME,
+	.write		=3D linflex_console_write,
+	.device		=3D uart_console_device,
+	.setup		=3D linflex_console_setup,
+	.flags		=3D CON_PRINTBUFFER,
+	.index		=3D -1,
+	.data		=3D &linflex_reg,
+};
+
+static void linflex_earlycon_write(struct console *con, const char *s,
+				   unsigned int n)
+{
+	struct earlycon_device *dev =3D con->data;
+
+	uart_console_write(&dev->port, s, n, linflex_earlycon_putchar);
+}
+
+static int __init linflex_early_console_setup(struct earlycon_device *devi=
ce,
+					      const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write =3D linflex_earlycon_write;
+	earlycon_port =3D &device->port;
+
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(linflex, "fsl,s32-linflexuart",
+		    linflex_early_console_setup);
+
+#define LINFLEX_CONSOLE	(&linflex_console)
+#else
+#define LINFLEX_CONSOLE	NULL
+#endif
+
+static struct uart_driver linflex_reg =3D {
+	.owner		=3D THIS_MODULE,
+	.driver_name	=3D DRIVER_NAME,
+	.dev_name	=3D DEV_NAME,
+	.nr		=3D ARRAY_SIZE(linflex_ports),
+	.cons		=3D LINFLEX_CONSOLE,
+};
+
+static int linflex_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct uart_port *sport;
+	struct resource *res;
+	int ret;
+
+	sport =3D devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
+		return -ENOMEM;
+
+	ret =3D of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		return ret;
+	}
+	if (ret >=3D UART_NR) {
+		dev_err(&pdev->dev, "driver limited to %d serial ports\n",
+			UART_NR);
+		return -ENOMEM;
+	}
+
+	sport->line =3D ret;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	sport->mapbase =3D res->start;
+	sport->membase =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(sport->membase))
+		return PTR_ERR(sport->membase);
+
+	sport->dev =3D &pdev->dev;
+	sport->type =3D PORT_LINFLEXUART;
+	sport->iotype =3D UPIO_MEM;
+	sport->irq =3D platform_get_irq(pdev, 0);
+	sport->ops =3D &linflex_pops;
+	sport->flags =3D UPF_BOOT_AUTOCONF;
+
+	linflex_ports[sport->line] =3D sport;
+
+	platform_set_drvdata(pdev, sport);
+
+	ret =3D uart_add_one_port(&linflex_reg, sport);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int linflex_remove(struct platform_device *pdev)
+{
+	struct uart_port *sport =3D platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&linflex_reg, sport);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int linflex_suspend(struct device *dev)
+{
+	struct uart_port *sport =3D dev_get_drvdata(dev);
+
+	uart_suspend_port(&linflex_reg, sport);
+
+	return 0;
+}
+
+static int linflex_resume(struct device *dev)
+{
+	struct uart_port *sport =3D dev_get_drvdata(dev);
+
+	uart_resume_port(&linflex_reg, sport);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(linflex_pm_ops, linflex_suspend, linflex_resume);
+
+static struct platform_driver linflex_driver =3D {
+	.probe		=3D linflex_probe,
+	.remove		=3D linflex_remove,
+	.driver		=3D {
+		.name	=3D DRIVER_NAME,
+		.owner	=3D THIS_MODULE,
+		.of_match_table	=3D linflex_dt_ids,
+		.pm	=3D &linflex_pm_ops,
+	},
+};
+
+static int __init linflex_serial_init(void)
+{
+	int ret;
+
+	ret =3D uart_register_driver(&linflex_reg);
+	if (ret)
+		return ret;
+
+	ret =3D platform_driver_register(&linflex_driver);
+	if (ret)
+		uart_unregister_driver(&linflex_reg);
+
+#ifdef CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE
+	spin_lock_init(&init_lock);
+#endif
+
+	return ret;
+}
+
+static void __exit linflex_serial_exit(void)
+{
+	platform_driver_unregister(&linflex_driver);
+	uart_unregister_driver(&linflex_reg);
+}
+
+module_init(linflex_serial_init);
+module_exit(linflex_serial_exit);
+
+MODULE_DESCRIPTION("Freescale linflex serial port driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_c=
ore.h
index 5642c05e0da0..25a3dead4473 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -293,4 +293,7 @@
 /* SiFive UART */
 #define PORT_SIFIVE_V0	120
=20
+/* Freescale Linflex UART */
+#define PORT_LINFLEXUART	121
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
--=20
2.22.0

