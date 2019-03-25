Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD4C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EDE20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w0osocCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfCYDx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:53:29 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:37187
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729380AbfCYDx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BdNoADUEEznZkM4R3x0yQanj+jekJR5D+j2knZEdCw=;
 b=w0osocCNNVZ4glMEca0IQHlbopsbaCZAwuZghh7gsGP75jWvRTRxBPORFG7+9tf+YuqakQvdEgvz2y/9LCD8MxuRXqCH43481JMRSbZBN69yirAgQ5rAukkuNIKZX1rqptpMktbJ1sCZPB+7Kp4BhHNiENRo4D3E1aIIAZ5WojU=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB6304.eurprd04.prod.outlook.com (20.179.28.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 03:53:24 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 03:53:24 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: [patch v14 1/4] irqchip/qeic: move qeic driver from
 drivers/soc/fsl/qe
Thread-Topic: [patch v14 1/4] irqchip/qeic: move qeic driver from
 drivers/soc/fsl/qe
Thread-Index: AQHU4r5LQtLKFbovrkinc7hsHhwjUA==
Date:   Mon, 25 Mar 2019 03:53:23 +0000
Message-ID: <20190325035418.19065-2-qiang.zhao@nxp.com>
References: <20190325035418.19065-1-qiang.zhao@nxp.com>
In-Reply-To: <20190325035418.19065-1-qiang.zhao@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To VI1PR04MB3247.eurprd04.prod.outlook.com
 (2603:10a6:802:11::32)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8664d18e-2d73-414a-da33-08d6b0d56dc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6304;
x-ms-traffictypediagnostic: VI1PR04MB6304:
x-microsoft-antispam-prvs: <VI1PR04MB63045A935DC4339B2ED21EC2915E0@VI1PR04MB6304.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(199004)(189003)(36756003)(2201001)(68736007)(6512007)(71190400001)(53936002)(102836004)(26005)(386003)(486006)(6506007)(71200400001)(186003)(52116002)(76176011)(44832011)(2906002)(99286004)(106356001)(105586002)(25786009)(478600001)(4326008)(7736002)(5660300002)(305945005)(2501003)(6436002)(8676002)(50226002)(316002)(6486002)(81156014)(8936002)(81166006)(66066001)(97736004)(54906003)(110136005)(14444005)(446003)(256004)(14454004)(3846002)(11346002)(1076003)(2616005)(86362001)(6116002)(476003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6304;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ip7eVhfBESFaRk4YAlB6SvVP1mjG9Xv07c8dKLf8iy2r45GWxA03EJpG3AF+YDVU8P4wgDBngt7eHB88DqCiSPalLX79yD3yJnpuqQqpSfodtvRje8XiCi5zLn+Gz9xY4BedliDd2DZKYf4I7QC0al2P3dzcQ9J7B27Lp67/stnfBqFDKe3iFDFVHaXD1xquMp5ft994byzifzzOtuwGESZVRQ8ZZHaXPszRjDA5CZi1aTpeAA7Ki31kiSfOWqGknXhSsDYbr7mLG6aiUhWGwVXljzgCMQtmjyKEUgUDswMXD901NOUHIzYwp+ztUYb8dCpvDro/CGCESYh9YRfgd1SwJvnYTWWW5ZeEvWMIqVfFg+tMO2/kEx0N6PSYmqDEQL+lxIanegH5xIVakjs8lgAAid74yL45a32p+mzoRQw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8664d18e-2d73-414a-da33-08d6b0d56dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 03:53:23.8834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move the driver from drivers/soc/fsl/qe to drivers/irqchip,
merge qe_ic.h and qe_ic.c into irq-qeic.c.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 MAINTAINERS                                        |    6 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/{soc/fsl/qe/qe_ic.c =3D> irqchip/irq-qeic.c} |  141 ++++++++++++++=
++----
 drivers/soc/fsl/qe/Makefile                        |    2 +-
 drivers/soc/fsl/qe/qe_ic.h                         |  103 --------------
 5 files changed, 123 insertions(+), 130 deletions(-)
 rename drivers/{soc/fsl/qe/qe_ic.c =3D> irqchip/irq-qeic.c} (81%)
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d2..540a82d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6255,6 +6255,12 @@ F:	drivers/soc/fsl/qe/
 F:	include/soc/fsl/*qe*.h
 F:	include/soc/fsl/*ucc*.h
=20
+FREESCALE QEIC DRIVERS
+M:	Qiang Zhao <qiang.zhao@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/irqchip/irq-qeic.c
+
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 M:	Li Yang <leoyang.li@nxp.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 85972ae..726c0ba 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -97,3 +97,4 @@ obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
 obj-$(CONFIG_MADERA_IRQ)		+=3D irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+=3D irq-ls1x.o
+obj-$(CONFIG_QUICC_ENGINE)		+=3D irq-qeic.o
diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/irqchip/irq-qeic.c
similarity index 81%
rename from drivers/soc/fsl/qe/qe_ic.c
rename to drivers/irqchip/irq-qeic.c
index ec2ca86..aba7135 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -1,7 +1,7 @@
 /*
- * arch/powerpc/sysdev/qe_lib/qe_ic.c
+ * drivers/irqchip/irq-qeic.c
  *
- * Copyright (C) 2006 Freescale Semiconductor, Inc.  All rights reserved.
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.  All rights reserved.
  *
  * Author: Li Yang <leoli@freescale.com>
  * Based on code from Shlomi Gridish <gridish@freescale.com>
@@ -30,145 +30,234 @@
 #include <asm/io.h>
 #include <soc/fsl/qe/qe_ic.h>
=20
-#include "qe_ic.h"
+#define NR_QE_IC_INTS		64
+
+/* QE IC registers offset */
+#define QEIC_CICR		0x00
+#define QEIC_CIVEC		0x04
+#define QEIC_CRIPNR		0x08
+#define QEIC_CIPNR		0x0c
+#define QEIC_CIPXCC		0x10
+#define QEIC_CIPYCC		0x14
+#define QEIC_CIPWCC		0x18
+#define QEIC_CIPZCC		0x1c
+#define QEIC_CIMR		0x20
+#define QEIC_CRIMR		0x24
+#define QEIC_CICNR		0x28
+#define QEIC_CIPRTA		0x30
+#define QEIC_CIPRTB		0x34
+#define QEIC_CRICR		0x3c
+#define QEIC_CHIVEC		0x60
+
+/* Interrupt priority registers */
+#define CIPCC_SHIFT_PRI0	29
+#define CIPCC_SHIFT_PRI1	26
+#define CIPCC_SHIFT_PRI2	23
+#define CIPCC_SHIFT_PRI3	20
+#define CIPCC_SHIFT_PRI4	13
+#define CIPCC_SHIFT_PRI5	10
+#define CIPCC_SHIFT_PRI6	7
+#define CIPCC_SHIFT_PRI7	4
+
+/* CICR priority modes */
+#define CICR_GWCC		BIT(18)
+#define CICR_GXCC		BIT(17)
+#define CICR_GYCC		BIT(16)
+#define CICR_GZCC		BIT(19)
+#define CICR_GRTA		BIT(21)
+#define CICR_GRTB		BIT(22)
+#define CICR_HPIT_SHIFT		8
+#define CICR_HPIT_MASK		0x00000300
+#define CICR_HP_SHIFT		24
+#define CICR_HP_MASK		0x3f000000
+
+/* CICNR */
+#define CICNR_WCC1T_SHIFT	20
+#define CICNR_ZCC1T_SHIFT	28
+#define CICNR_YCC1T_SHIFT	12
+#define CICNR_XCC1T_SHIFT	4
+
+/* CRICR */
+#define CRICR_RTA1T_SHIFT	20
+#define CRICR_RTB1T_SHIFT	28
+
+/* Signal indicator */
+#define SIGNAL_MASK		3
+#define SIGNAL_HIGH		2
+#define SIGNAL_LOW		0
+
+struct qe_ic {
+	/* Control registers offset */
+	u32 __iomem *regs;
+
+	/* The remapper for this QEIC */
+	struct irq_domain *irqhost;
+
+	/* The "linux" controller struct */
+	struct irq_chip hc_irq;
+
+	/* VIRQ numbers of QE high/low irqs */
+	unsigned int virq_high;
+	unsigned int virq_low;
+};
+
+/*
+ * QE interrupt controller internal structure
+ */
+struct qe_ic_info {
+	/* location of this source at the QIMR register. */
+	u32	mask;
+
+	/* Mask register offset */
+	u32	mask_reg;
+
+	/*
+	 * for grouped interrupts sources - the interrupt
+	 * code as appears at the group priority register
+	 */
+	u8	pri_code;
+
+	/* Group priority register offset */
+	u32	pri_reg;
+};
=20
 static DEFINE_RAW_SPINLOCK(qe_ic_lock);
=20
 static struct qe_ic_info qe_ic_info[] =3D {
 	[1] =3D {
-	       .mask =3D 0x00008000,
+	       .mask =3D BIT(15),
 	       .mask_reg =3D QEIC_CIMR,
 	       .pri_code =3D 0,
 	       .pri_reg =3D QEIC_CIPWCC,
 	       },
 	[2] =3D {
-	       .mask =3D 0x00004000,
+	       .mask =3D BIT(14),
 	       .mask_reg =3D QEIC_CIMR,
 	       .pri_code =3D 1,
 	       .pri_reg =3D QEIC_CIPWCC,
 	       },
 	[3] =3D {
-	       .mask =3D 0x00002000,
+	       .mask =3D BIT(13),
 	       .mask_reg =3D QEIC_CIMR,
 	       .pri_code =3D 2,
 	       .pri_reg =3D QEIC_CIPWCC,
 	       },
 	[10] =3D {
-		.mask =3D 0x00000040,
+		.mask =3D BIT(6),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 1,
 		.pri_reg =3D QEIC_CIPZCC,
 		},
 	[11] =3D {
-		.mask =3D 0x00000020,
+		.mask =3D BIT(5),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 2,
 		.pri_reg =3D QEIC_CIPZCC,
 		},
 	[12] =3D {
-		.mask =3D 0x00000010,
+		.mask =3D BIT(4),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 3,
 		.pri_reg =3D QEIC_CIPZCC,
 		},
 	[13] =3D {
-		.mask =3D 0x00000008,
+		.mask =3D BIT(3),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 4,
 		.pri_reg =3D QEIC_CIPZCC,
 		},
 	[14] =3D {
-		.mask =3D 0x00000004,
+		.mask =3D BIT(2),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 5,
 		.pri_reg =3D QEIC_CIPZCC,
 		},
 	[15] =3D {
-		.mask =3D 0x00000002,
+		.mask =3D BIT(1),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 6,
 		.pri_reg =3D QEIC_CIPZCC,
 		},
 	[20] =3D {
-		.mask =3D 0x10000000,
+		.mask =3D BIT(28),
 		.mask_reg =3D QEIC_CRIMR,
 		.pri_code =3D 3,
 		.pri_reg =3D QEIC_CIPRTA,
 		},
 	[25] =3D {
-		.mask =3D 0x00800000,
+		.mask =3D BIT(23),
 		.mask_reg =3D QEIC_CRIMR,
 		.pri_code =3D 0,
 		.pri_reg =3D QEIC_CIPRTB,
 		},
 	[26] =3D {
-		.mask =3D 0x00400000,
+		.mask =3D BIT(22),
 		.mask_reg =3D QEIC_CRIMR,
 		.pri_code =3D 1,
 		.pri_reg =3D QEIC_CIPRTB,
 		},
 	[27] =3D {
-		.mask =3D 0x00200000,
+		.mask =3D BIT(21),
 		.mask_reg =3D QEIC_CRIMR,
 		.pri_code =3D 2,
 		.pri_reg =3D QEIC_CIPRTB,
 		},
 	[28] =3D {
-		.mask =3D 0x00100000,
+		.mask =3D BIT(20),
 		.mask_reg =3D QEIC_CRIMR,
 		.pri_code =3D 3,
 		.pri_reg =3D QEIC_CIPRTB,
 		},
 	[32] =3D {
-		.mask =3D 0x80000000,
+		.mask =3D BIT(31),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 0,
 		.pri_reg =3D QEIC_CIPXCC,
 		},
 	[33] =3D {
-		.mask =3D 0x40000000,
+		.mask =3D BIT(30),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 1,
 		.pri_reg =3D QEIC_CIPXCC,
 		},
 	[34] =3D {
-		.mask =3D 0x20000000,
+		.mask =3D BIT(29),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 2,
 		.pri_reg =3D QEIC_CIPXCC,
 		},
 	[35] =3D {
-		.mask =3D 0x10000000,
+		.mask =3D BIT(28),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 3,
 		.pri_reg =3D QEIC_CIPXCC,
 		},
 	[36] =3D {
-		.mask =3D 0x08000000,
+		.mask =3D BIT(27),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 4,
 		.pri_reg =3D QEIC_CIPXCC,
 		},
 	[40] =3D {
-		.mask =3D 0x00800000,
+		.mask =3D BIT(23),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 0,
 		.pri_reg =3D QEIC_CIPYCC,
 		},
 	[41] =3D {
-		.mask =3D 0x00400000,
+		.mask =3D BIT(22),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 1,
 		.pri_reg =3D QEIC_CIPYCC,
 		},
 	[42] =3D {
-		.mask =3D 0x00200000,
+		.mask =3D BIT(21),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 2,
 		.pri_reg =3D QEIC_CIPYCC,
 		},
 	[43] =3D {
-		.mask =3D 0x00100000,
+		.mask =3D BIT(20),
 		.mask_reg =3D QEIC_CIMR,
 		.pri_code =3D 3,
 		.pri_reg =3D QEIC_CIPYCC,
diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile
index 55a5553..f9a2713 100644
--- a/drivers/soc/fsl/qe/Makefile
+++ b/drivers/soc/fsl/qe/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for the linux ppc-specific parts of QE
 #
-obj-$(CONFIG_QUICC_ENGINE)+=3D qe.o qe_common.o qe_ic.o qe_io.o
+obj-$(CONFIG_QUICC_ENGINE)+=3D qe.o qe_common.o qe_io.o
 obj-$(CONFIG_CPM)	+=3D qe_common.o
 obj-$(CONFIG_UCC)	+=3D ucc.o
 obj-$(CONFIG_UCC_SLOW)	+=3D ucc_slow.o
diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
deleted file mode 100644
index 926a2ed..0000000
--- a/drivers/soc/fsl/qe/qe_ic.h
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * drivers/soc/fsl/qe/qe_ic.h
- *
- * QUICC ENGINE Interrupt Controller Header
- *
- * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Author: Li Yang <leoli@freescale.com>
- * Based on code from Shlomi Gridish <gridish@freescale.com>
- *
- * This program is free software; you can redistribute  it and/or modify i=
t
- * under  the terms of  the GNU General  Public License as published by th=
e
- * Free Software Foundation;  either version 2 of the  License, or (at you=
r
- * option) any later version.
- */
-#ifndef _POWERPC_SYSDEV_QE_IC_H
-#define _POWERPC_SYSDEV_QE_IC_H
-
-#include <soc/fsl/qe/qe_ic.h>
-
-#define NR_QE_IC_INTS		64
-
-/* QE IC registers offset */
-#define QEIC_CICR		0x00
-#define QEIC_CIVEC		0x04
-#define QEIC_CRIPNR		0x08
-#define QEIC_CIPNR		0x0c
-#define QEIC_CIPXCC		0x10
-#define QEIC_CIPYCC		0x14
-#define QEIC_CIPWCC		0x18
-#define QEIC_CIPZCC		0x1c
-#define QEIC_CIMR		0x20
-#define QEIC_CRIMR		0x24
-#define QEIC_CICNR		0x28
-#define QEIC_CIPRTA		0x30
-#define QEIC_CIPRTB		0x34
-#define QEIC_CRICR		0x3c
-#define QEIC_CHIVEC		0x60
-
-/* Interrupt priority registers */
-#define CIPCC_SHIFT_PRI0	29
-#define CIPCC_SHIFT_PRI1	26
-#define CIPCC_SHIFT_PRI2	23
-#define CIPCC_SHIFT_PRI3	20
-#define CIPCC_SHIFT_PRI4	13
-#define CIPCC_SHIFT_PRI5	10
-#define CIPCC_SHIFT_PRI6	7
-#define CIPCC_SHIFT_PRI7	4
-
-/* CICR priority modes */
-#define CICR_GWCC		0x00040000
-#define CICR_GXCC		0x00020000
-#define CICR_GYCC		0x00010000
-#define CICR_GZCC		0x00080000
-#define CICR_GRTA		0x00200000
-#define CICR_GRTB		0x00400000
-#define CICR_HPIT_SHIFT		8
-#define CICR_HPIT_MASK		0x00000300
-#define CICR_HP_SHIFT		24
-#define CICR_HP_MASK		0x3f000000
-
-/* CICNR */
-#define CICNR_WCC1T_SHIFT	20
-#define CICNR_ZCC1T_SHIFT	28
-#define CICNR_YCC1T_SHIFT	12
-#define CICNR_XCC1T_SHIFT	4
-
-/* CRICR */
-#define CRICR_RTA1T_SHIFT	20
-#define CRICR_RTB1T_SHIFT	28
-
-/* Signal indicator */
-#define SIGNAL_MASK		3
-#define SIGNAL_HIGH		2
-#define SIGNAL_LOW		0
-
-struct qe_ic {
-	/* Control registers offset */
-	volatile u32 __iomem *regs;
-
-	/* The remapper for this QEIC */
-	struct irq_domain *irqhost;
-
-	/* The "linux" controller struct */
-	struct irq_chip hc_irq;
-
-	/* VIRQ numbers of QE high/low irqs */
-	unsigned int virq_high;
-	unsigned int virq_low;
-};
-
-/*
- * QE interrupt controller internal structure
- */
-struct qe_ic_info {
-	u32	mask;	  /* location of this source at the QIMR register. */
-	u32	mask_reg; /* Mask register offset */
-	u8	pri_code; /* for grouped interrupts sources - the interrupt
-			     code as appears at the group priority register */
-	u32	pri_reg;  /* Group priority register offset */
-};
-
-#endif /* _POWERPC_SYSDEV_QE_IC_H */
--=20
1.7.1

