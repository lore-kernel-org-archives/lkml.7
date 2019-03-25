Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C198C20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fZ9537qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfCYDx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:53:59 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:30433
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729380AbfCYDx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIawtB21SA/cSgJo8bNffCz5i0j1BimZzQheksfIOfA=;
 b=fZ9537qF/bCKSaw7AtKXsv8owdgsjeVkvYyA+BoK51DTYpaq0hlggWPyYjkswOexAxwZRXMf/i+1LktBzLvsph2v+Ad775wiR+vV+mp8gePpQSGQbnaCBtxBOUBEDDh5tWNuB+EcIcYq57h6TbBn3t2V1ZM9LEf0HCEBoDl7Ac4=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB5711.eurprd04.prod.outlook.com (20.178.126.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 03:53:48 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 03:53:48 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: [patch v14 4/4] irqchip/qeic: remove PPCisms for QEIC
Thread-Topic: [patch v14 4/4] irqchip/qeic: remove PPCisms for QEIC
Thread-Index: AQHU4r5ZdZ3VXG0AqU+7ZWVjasbJ9A==
Date:   Mon, 25 Mar 2019 03:53:48 +0000
Message-ID: <20190325035418.19065-5-qiang.zhao@nxp.com>
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
x-ms-office365-filtering-correlation-id: 703e15c9-a93e-4f22-f39a-08d6b0d57c2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5711;
x-ms-traffictypediagnostic: VI1PR04MB5711:
x-microsoft-antispam-prvs: <VI1PR04MB5711C7FACC0C79DA3DB14A15915E0@VI1PR04MB5711.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(478600001)(2906002)(44832011)(1076003)(53936002)(66066001)(14444005)(2201001)(256004)(50226002)(53946003)(81166006)(2501003)(106356001)(316002)(305945005)(7736002)(186003)(8676002)(105586002)(71200400001)(86362001)(26005)(97736004)(486006)(3846002)(76176011)(110136005)(54906003)(11346002)(71190400001)(25786009)(81156014)(5660300002)(8936002)(386003)(6506007)(6116002)(476003)(4326008)(6486002)(6512007)(99286004)(6436002)(446003)(2616005)(68736007)(30864003)(14454004)(36756003)(102836004)(52116002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5711;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6raOFGTtZuHr1fF7HTiRB1Pnum63gdH0y+Sq8IcYu9O8reNH9DP4oez+shde3dZunfQplnyGvAr+MDyZH1Qp123ZcFDum8cOR/Yq1lo6n8B0g3EEBu9a/0GKvcCbrU4bIHUl8qdId59NL/ROWuawo8t1JbN9bMnCQeM9tXZvhknuh3i9QX6eI2UBa6CEwWxMVTf3inC0OOATNXghuNNnPWDlzNHAo6YXyLqc/uWcDsEPgY5qSs8yZaBSHaxF46X/30RaHoBW3fRwXC99SNInjSioQfr64XOFsv/j0W5ohV2bVNS3neBn6EbeuN9Q99adR8LAmWCihmRUDW2nUz46OcYxE19HcNwrf7uJCy8xMdvDgcwdV4At42gi7RLXahESJYnh6nywPPU7IupL0Nyx2z12gFeDApMKUjyMzaxQEEA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703e15c9-a93e-4f22-f39a-08d6b0d57c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 03:53:48.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QEIC was supported on PowerPC, and dependent on PPC,
Now it is supported on other platforms, so remove PPCisms.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 arch/powerpc/platforms/83xx/km83xx.c          |    1 -
 arch/powerpc/platforms/83xx/misc.c            |    1 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c     |    1 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c     |    1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |    1 -
 arch/powerpc/platforms/83xx/mpc836x_rdk.c     |    1 -
 arch/powerpc/platforms/85xx/corenet_generic.c |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |    1 -
 arch/powerpc/platforms/85xx/twr_p102x.c       |    1 -
 drivers/irqchip/irq-qeic.c                    |  188 +++++++++++----------=
----
 include/soc/fsl/qe/qe_ic.h                    |  132 -----------------
 12 files changed, 80 insertions(+), 250 deletions(-)
 delete mode 100644 include/soc/fsl/qe/qe_ic.h

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/=
83xx/km83xx.c
index d8642a4..b1cef0a 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -38,7 +38,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
=20
 #include "mpc83xx.h"
=20
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83=
xx/misc.c
index 4150b56..b033a10 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -18,7 +18,6 @@
 #include <asm/io.h>
 #include <asm/hw_irq.h>
 #include <asm/ipic.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
=20
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platf=
orms/83xx/mpc832x_mds.c
index 74c154e..f86371b 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -37,7 +37,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
=20
 #include "mpc83xx.h"
=20
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platf=
orms/83xx/mpc832x_rdb.c
index 4389865..da91395 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -26,7 +26,6 @@
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
=20
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platf=
orms/83xx/mpc836x_mds.c
index fd44dd0..9b8bc8b 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -45,7 +45,6 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
=20
 #include "mpc83xx.h"
=20
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platf=
orms/83xx/mpc836x_rdk.c
index 93f024f..82fa344 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -21,7 +21,6 @@
 #include <asm/ipic.h>
 #include <asm/udbg.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
=20
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/p=
latforms/85xx/corenet_generic.c
index e44bb44..ac2478d 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -28,7 +28,6 @@
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
 #include <asm/swiotlb.h>
-#include <soc/fsl/qe/qe_ic.h>
=20
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platf=
orms/85xx/mpc85xx_mds.c
index 6892bc1..809266d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -49,7 +49,6 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 #include "smp.h"
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platf=
orms/85xx/mpc85xx_rdb.c
index 000d385..f806b6b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -27,7 +27,6 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
=20
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platfor=
ms/85xx/twr_p102x.c
index 6be9b33..4f620f2 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -23,7 +23,6 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <soc/fsl/qe/qe.h>
-#include <soc/fsl/qe/qe_ic.h>
=20
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/drivers/irqchip/irq-qeic.c b/drivers/irqchip/irq-qeic.c
index a6ccbfb..723c52e 100644
--- a/drivers/irqchip/irq-qeic.c
+++ b/drivers/irqchip/irq-qeic.c
@@ -18,8 +18,11 @@
 #include <linux/of_address.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/irqchip.h>
 #include <linux/errno.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/stddef.h>
@@ -27,9 +30,8 @@
 #include <linux/signal.h>
 #include <linux/device.h>
 #include <linux/spinlock.h>
-#include <asm/irq.h>
+#include <linux/irq.h>
 #include <asm/io.h>
-#include <soc/fsl/qe/qe_ic.h>
=20
 #define NR_QE_IC_INTS		64
=20
@@ -87,6 +89,43 @@
 #define SIGNAL_HIGH		2
 #define SIGNAL_LOW		0
=20
+#define NUM_OF_QE_IC_GROUPS	6
+
+/* Flags when we init the QE IC */
+#define QE_IC_SPREADMODE_GRP_W			BIT(0)
+#define QE_IC_SPREADMODE_GRP_X			BIT(1)
+#define QE_IC_SPREADMODE_GRP_Y			BIT(2)
+#define QE_IC_SPREADMODE_GRP_Z			BIT(3)
+#define QE_IC_SPREADMODE_GRP_RISCA		BIT(4)
+#define QE_IC_SPREADMODE_GRP_RISCB		BIT(5)
+
+#define QE_IC_LOW_SIGNAL			BIT(8)
+#define QE_IC_HIGH_SIGNAL			BIT(9)
+
+#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH	BIT(12)
+#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH	BIT(13)
+#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH	BIT(14)
+#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH	BIT(15)
+#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH	BIT(16)
+#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH	BIT(17)
+#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH	BIT(18)
+#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH	BIT(19)
+#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH	BIT(20)
+#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH	BIT(21)
+#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH	BIT(22)
+#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH	BIT(23)
+#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT		(12)
+
+/* QE interrupt sources groups */
+enum qe_ic_grp_id {
+	QE_IC_GRP_W =3D 0,	/* QE interrupt controller group W */
+	QE_IC_GRP_X,		/* QE interrupt controller group X */
+	QE_IC_GRP_Y,		/* QE interrupt controller group Y */
+	QE_IC_GRP_Z,		/* QE interrupt controller group Z */
+	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
+	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
+};
+
 struct qe_ic {
 	/* Control registers offset */
 	u32 __iomem *regs;
@@ -265,15 +304,15 @@ struct qe_ic_info {
 		},
 };
=20
-static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int=
 reg)
+static u32 qe_ic_read(__be32  __iomem *base, unsigned int reg)
 {
-	return in_be32(base + (reg >> 2));
+	return ioread32be(base + (reg >> 2));
 }
=20
-static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned i=
nt reg,
+static void qe_ic_write(__be32  __iomem *base, unsigned int reg,
 			       u32 value)
 {
-	out_be32(base + (reg >> 2), value);
+	iowrite32be(value, base + (reg >> 2));
 }
=20
 static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
@@ -375,8 +414,8 @@ static int qe_ic_host_map(struct irq_domain *h, unsigne=
d int virq,
 	.xlate =3D irq_domain_xlate_onetwocell,
 };
=20
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
+/* Return an interrupt vector or 0 if no interrupt is pending. */
+static unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 {
 	int irq;
=20
@@ -386,13 +425,13 @@ unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
 	irq =3D qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
=20
 	if (irq =3D=3D 0)
-		return NO_IRQ;
+		return 0;
=20
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
=20
-/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
+/* Return an interrupt vector or 0 if no interrupt is pending. */
+static unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 {
 	int irq;
=20
@@ -402,11 +441,38 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	irq =3D qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
=20
 	if (irq =3D=3D 0)
-		return NO_IRQ;
+		return 0;
=20
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
=20
+static void qe_ic_cascade_mpic(struct irq_desc *desc, int is_high)
+{
+	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	unsigned int cascade_irq;
+
+	if (is_high)
+		cascade_irq =3D qe_ic_get_high_irq(qe_ic);
+	else
+		cascade_irq =3D qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq !=3D 0)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
+static void qe_ic_cascade_low_mpic(struct irq_desc *desc)
+{
+	qe_ic_cascade_mpic(desc, 0);
+}
+
+static void qe_ic_cascade_high_mpic(struct irq_desc *desc)
+{
+	qe_ic_cascade_mpic(desc, 1);
+}
+
 static int __init qe_ic_init(struct device_node *node,
 			     struct device_node *parent)
 {
@@ -440,7 +506,7 @@ static int __init qe_ic_init(struct device_node *node,
 	qe_ic->virq_high =3D irq_of_parse_and_map(node, 0);
 	qe_ic->virq_low =3D irq_of_parse_and_map(node, 1);
=20
-	if (qe_ic->virq_low =3D=3D NO_IRQ) {
+	if (qe_ic->virq_low =3D=3D 0) {
 		pr_err("Failed to map QE_IC low IRQ\n");
 		ret =3D -ENOMEM;
 		goto err_domain_remove;
@@ -449,7 +515,7 @@ static int __init qe_ic_init(struct device_node *node,
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
 	irq_set_chained_handler(qe_ic->virq_low, qe_ic_cascade_low_mpic);
=20
-	if (qe_ic->virq_high !=3D NO_IRQ &&
+	if (qe_ic->virq_high !=3D 0 &&
 			qe_ic->virq_high !=3D qe_ic->virq_low) {
 		irq_set_handler_data(qe_ic->virq_high, qe_ic);
 		irq_set_chained_handler(qe_ic->virq_high,
@@ -467,98 +533,4 @@ static int __init qe_ic_init(struct device_node *node,
 	return ret;
 }
=20
-void qe_ic_set_highest_priority(unsigned int virq, int high)
-{
-	struct qe_ic *qe_ic =3D qe_ic_from_irq(virq);
-	unsigned int src =3D virq_to_hw(virq);
-	u32 temp =3D 0;
-
-	temp =3D qe_ic_read(qe_ic->regs, QEIC_CICR);
-
-	temp &=3D ~CICR_HP_MASK;
-	temp |=3D src << CICR_HP_SHIFT;
-
-	temp &=3D ~CICR_HPIT_MASK;
-	temp |=3D (high ? SIGNAL_HIGH : SIGNAL_LOW) << CICR_HPIT_SHIFT;
-
-	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
-}
-
-/* Set Priority level within its group, from 1 to 8 */
-int qe_ic_set_priority(unsigned int virq, unsigned int priority)
-{
-	struct qe_ic *qe_ic =3D qe_ic_from_irq(virq);
-	unsigned int src =3D virq_to_hw(virq);
-	u32 temp;
-
-	if (priority > 8 || priority =3D=3D 0)
-		return -EINVAL;
-	if (WARN_ONCE(src >=3D ARRAY_SIZE(qe_ic_info),
-		      "%s: Invalid hw irq number for QEIC\n", __func__))
-		return -EINVAL;
-	if (qe_ic_info[src].pri_reg =3D=3D 0)
-		return -EINVAL;
-
-	temp =3D qe_ic_read(qe_ic->regs, qe_ic_info[src].pri_reg);
-
-	if (priority < 4) {
-		temp &=3D ~(0x7 << (32 - priority * 3));
-		temp |=3D qe_ic_info[src].pri_code << (32 - priority * 3);
-	} else {
-		temp &=3D ~(0x7 << (24 - priority * 3));
-		temp |=3D qe_ic_info[src].pri_code << (24 - priority * 3);
-	}
-
-	qe_ic_write(qe_ic->regs, qe_ic_info[src].pri_reg, temp);
-
-	return 0;
-}
-
-/* Set a QE priority to use high irq, only priority 1~2 can use high irq *=
/
-int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int =
high)
-{
-	struct qe_ic *qe_ic =3D qe_ic_from_irq(virq);
-	unsigned int src =3D virq_to_hw(virq);
-	u32 temp, control_reg =3D QEIC_CICNR, shift =3D 0;
-
-	if (priority > 2 || priority =3D=3D 0)
-		return -EINVAL;
-	if (WARN_ONCE(src >=3D ARRAY_SIZE(qe_ic_info),
-		      "%s: Invalid hw irq number for QEIC\n", __func__))
-		return -EINVAL;
-
-	switch (qe_ic_info[src].pri_reg) {
-	case QEIC_CIPZCC:
-		shift =3D CICNR_ZCC1T_SHIFT;
-		break;
-	case QEIC_CIPWCC:
-		shift =3D CICNR_WCC1T_SHIFT;
-		break;
-	case QEIC_CIPYCC:
-		shift =3D CICNR_YCC1T_SHIFT;
-		break;
-	case QEIC_CIPXCC:
-		shift =3D CICNR_XCC1T_SHIFT;
-		break;
-	case QEIC_CIPRTA:
-		shift =3D CRICR_RTA1T_SHIFT;
-		control_reg =3D QEIC_CRICR;
-		break;
-	case QEIC_CIPRTB:
-		shift =3D CRICR_RTB1T_SHIFT;
-		control_reg =3D QEIC_CRICR;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	shift +=3D (2 - priority) * 2;
-	temp =3D qe_ic_read(qe_ic->regs, control_reg);
-	temp &=3D ~(SIGNAL_MASK << shift);
-	temp |=3D (high ? SIGNAL_HIGH : SIGNAL_LOW) << shift;
-	qe_ic_write(qe_ic->regs, control_reg, temp);
-
-	return 0;
-}
-
 IRQCHIP_DECLARE(qeic, "fsl,qe-ic", qe_ic_init);
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
deleted file mode 100644
index 6113699..0000000
--- a/include/soc/fsl/qe/qe_ic.h
+++ /dev/null
@@ -1,132 +0,0 @@
-/*
- * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
- *
- * Authors: 	Shlomi Gridish <gridish@freescale.com>
- * 		Li Yang <leoli@freescale.com>
- *
- * Description:
- * QE IC external definitions and structure.
- *
- * This program is free software; you can redistribute  it and/or modify i=
t
- * under  the terms of  the GNU General  Public License as published by th=
e
- * Free Software Foundation;  either version 2 of the  License, or (at you=
r
- * option) any later version.
- */
-#ifndef _ASM_POWERPC_QE_IC_H
-#define _ASM_POWERPC_QE_IC_H
-
-#include <linux/irq.h>
-
-struct device_node;
-struct qe_ic;
-
-#define NUM_OF_QE_IC_GROUPS	6
-
-/* Flags when we init the QE IC */
-#define QE_IC_SPREADMODE_GRP_W			0x00000001
-#define QE_IC_SPREADMODE_GRP_X			0x00000002
-#define QE_IC_SPREADMODE_GRP_Y			0x00000004
-#define QE_IC_SPREADMODE_GRP_Z			0x00000008
-#define QE_IC_SPREADMODE_GRP_RISCA		0x00000010
-#define QE_IC_SPREADMODE_GRP_RISCB		0x00000020
-
-#define QE_IC_LOW_SIGNAL			0x00000100
-#define QE_IC_HIGH_SIGNAL			0x00000200
-
-#define QE_IC_GRP_W_PRI0_DEST_SIGNAL_HIGH	0x00001000
-#define QE_IC_GRP_W_PRI1_DEST_SIGNAL_HIGH	0x00002000
-#define QE_IC_GRP_X_PRI0_DEST_SIGNAL_HIGH	0x00004000
-#define QE_IC_GRP_X_PRI1_DEST_SIGNAL_HIGH	0x00008000
-#define QE_IC_GRP_Y_PRI0_DEST_SIGNAL_HIGH	0x00010000
-#define QE_IC_GRP_Y_PRI1_DEST_SIGNAL_HIGH	0x00020000
-#define QE_IC_GRP_Z_PRI0_DEST_SIGNAL_HIGH	0x00040000
-#define QE_IC_GRP_Z_PRI1_DEST_SIGNAL_HIGH	0x00080000
-#define QE_IC_GRP_RISCA_PRI0_DEST_SIGNAL_HIGH	0x00100000
-#define QE_IC_GRP_RISCA_PRI1_DEST_SIGNAL_HIGH	0x00200000
-#define QE_IC_GRP_RISCB_PRI0_DEST_SIGNAL_HIGH	0x00400000
-#define QE_IC_GRP_RISCB_PRI1_DEST_SIGNAL_HIGH	0x00800000
-#define QE_IC_GRP_W_DEST_SIGNAL_SHIFT		(12)
-
-/* QE interrupt sources groups */
-enum qe_ic_grp_id {
-	QE_IC_GRP_W =3D 0,	/* QE interrupt controller group W */
-	QE_IC_GRP_X,		/* QE interrupt controller group X */
-	QE_IC_GRP_Y,		/* QE interrupt controller group Y */
-	QE_IC_GRP_Z,		/* QE interrupt controller group Z */
-	QE_IC_GRP_RISCA,	/* QE interrupt controller RISC group A */
-	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
-};
-
-#ifdef CONFIG_QUICC_ENGINE
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
-#else
-static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
-{ return 0; }
-static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
-{ return 0; }
-#endif /* CONFIG_QUICC_ENGINE */
-
-void qe_ic_set_highest_priority(unsigned int virq, int high);
-int qe_ic_set_priority(unsigned int virq, unsigned int priority);
-int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int =
high);
-
-static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq =3D qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq !=3D NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq =3D qe_ic_get_high_irq(qe_ic);
-
-	if (cascade_irq !=3D NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq =3D qe_ic_get_low_irq(qe_ic);
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-
-	if (cascade_irq !=3D NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq =3D qe_ic_get_high_irq(qe_ic);
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-
-	if (cascade_irq !=3D NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq;
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-
-	cascade_irq =3D qe_ic_get_high_irq(qe_ic);
-	if (cascade_irq =3D=3D NO_IRQ)
-		cascade_irq =3D qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq !=3D NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
-#endif /* _ASM_POWERPC_QE_IC_H */
--=20
1.7.1

