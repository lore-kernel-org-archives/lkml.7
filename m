Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46174C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003FB20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w05wbNgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCKUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:20:38 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:61122
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfDCKUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xakVv5ZmrdSvyk5HptNW+10h6jcMzZWPauC4XUHMrg=;
 b=w05wbNgzYzRId2d5rt0OBb+IqWE/rZl4oKB7JHYbB9NqAIIs6wrHluZcI8PEhzaWr6ieuhaRzaub7+Syr1QfwRN6rAfEUWZXRMnf4YzpvIWbWIwIAeWJs1cQe/WhcSR/Vf0R2Nt3qGcz5u3FRBrm4sm3fgi5jlSutdS2VnQarK0=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB2749.eurprd04.prod.outlook.com (10.175.22.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Wed, 3 Apr 2019 10:20:31 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::78bc:c1e8:3caf:656b]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::78bc:c1e8:3caf:656b%6]) with mapi id 15.20.1750.014; Wed, 3 Apr 2019
 10:20:31 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Topic: [PATCH v3 2/2] driver: clocksource: Add nxp system counter timer
 driver support
Thread-Index: AQHU6gbeQOyQqy4i5kKmRS2/nYe/7Q==
Date:   Wed, 3 Apr 2019 10:20:31 +0000
Message-ID: <1554287101-16189-2-git-send-email-ping.bai@nxp.com>
References: <1554287101-16189-1-git-send-email-ping.bai@nxp.com>
In-Reply-To: <1554287101-16189-1-git-send-email-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 103e1725-39e7-48fb-1217-08d6b81e002b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB2749;
x-ms-traffictypediagnostic: VI1PR0402MB2749:
x-microsoft-antispam-prvs: <VI1PR0402MB2749BC2EBDBA4742EB8AB77387570@VI1PR0402MB2749.eurprd04.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(25786009)(81166006)(305945005)(106356001)(71190400001)(76176011)(6506007)(99286004)(386003)(446003)(2616005)(11346002)(52116002)(105586002)(6512007)(2906002)(102836004)(2501003)(6116002)(36756003)(4326008)(186003)(26005)(7736002)(53936002)(110136005)(6636002)(476003)(6436002)(486006)(54906003)(97736004)(50226002)(478600001)(3846002)(71200400001)(316002)(66066001)(256004)(8936002)(8676002)(86362001)(14454004)(81156014)(5660300002)(68736007)(6486002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2749;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tvYJ8K4SsydOGOdD3igI7ST2Pma80QBGkeczeGd/NlfvOn8bPlbzH0ziEFIRErWj2LdqQMNIR7aHrKiD1kmOE00thD2egJVlsdLHiXxGy2QW//d0ZaI4zAIgH8MSmOrI0fbs7NKbsdg4Z2g+FDE14cQBF1+OfV+AfL0y91OzHpFhAWkQqQzbChWB/hIx2i7yztK1GimWUYqGQg/q8YKlYHUOu7avniz0yAFS9RAgnfRl6H/TTggXLVND3K0rMUqOydClla0kGlg/wZ/csrrNfF6xacmM1EIz+sMs8HWwPfKlwmYFDOVfyz3mu6ikUDTlIGbWIC09t1HIYM0/s0sZ8+P0cKz0wdYDewH8dHAPA+qn5xLILFi9n1PGoXdkf7B6EHkI/U5llWQetgkUupdwm0R5E8/yHdU2CfV51682nCQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103e1725-39e7-48fb-1217-08d6b81e002b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 10:20:31.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bai Ping <ping.bai@nxp.com>

The system counter (sys_ctr) is a programmable system counter
which provides a shared time base to the Cortex A15, A7, A53 etc cores.
It is intended for use in applications where the counter is always
powered on and supports multiple, unrelated clocks. The sys_ctr hardware
supports:
 - 56-bit counter width (roll-over time greater than 40 years)
 - compare frame(64-bit compare value) contains programmable interrupt
   generation

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
change v1->v2:
 - no change=20
change v2->v3:
 - remove the clocksource, we only need to use this module for timer purpos=
e,
   so register it as clockevent is enough.
 - use the timer_of_init to init the irq, clock, etc.
 - remove some unnecessary comments.
---
 drivers/clocksource/Kconfig            |   7 ++
 drivers/clocksource/Makefile           |   1 +
 drivers/clocksource/timer-imx-sysctr.c | 149 +++++++++++++++++++++++++++++=
++++
 3 files changed, 157 insertions(+)
 create mode 100644 drivers/clocksource/timer-imx-sysctr.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a..90cd908 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -598,6 +598,13 @@ config CLKSRC_IMX_TPM
 	  Enable this option to use IMX Timer/PWM Module (TPM) timer as
 	  clocksource.
=20
+config TIMER_IMX_SYS_CTR
+	bool "i.MX system counter timer" if COMPILE_TEST
+	depends on ARCH_MXC
+	select TIMER_OF
+	help
+	  Enable this option to use i.MX system counter timer for clockevent.
+
 config CLKSRC_ST_LPC
 	bool "Low power clocksource found in the LPC" if COMPILE_TEST
 	select TIMER_OF if OF
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be6e0fb..bc5ce50 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_CLKSRC_MIPS_GIC)		+=3D mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+=3D timer-tango-xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+=3D timer-imx-gpt.o
 obj-$(CONFIG_CLKSRC_IMX_TPM)		+=3D timer-imx-tpm.o
+obj-$(CONFIG_TIMER_IMX_SYS_CTR)		+=3D timer-imx-sysctr.o
 obj-$(CONFIG_ASM9260_TIMER)		+=3D asm9260_timer.o
 obj-$(CONFIG_H8300_TMR8)		+=3D h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+=3D h8300_timer16.o
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/t=
imer-imx-sysctr.c
new file mode 100644
index 0000000..d3afc3b
--- /dev/null
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2017-2019 NXP
+
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "timer-of.h"
+
+#define CMP_OFFSET	0x10000
+
+#define CNTCV_LO	0x8
+#define CNTCV_HI	0xc
+#define CMPCV_LO	(CMP_OFFSET + 0x20)
+#define CMPCV_HI	(CMP_OFFSET + 0x24)
+#define CMPCR		(CMP_OFFSET + 0x2c)
+
+#define SYS_CTR_EN		0x1
+#define SYS_CTR_IRQ_MASK	0x2
+
+static void __iomem *sys_ctr_base;
+
+static void sysctr_timer_enable(bool enable)
+{
+	u32 val;
+
+	val =3D readl(sys_ctr_base + CMPCR);
+	val &=3D ~SYS_CTR_EN;
+	if (enable)
+		val |=3D SYS_CTR_EN;
+
+	writel(val, sys_ctr_base + CMPCR);
+}
+
+static void sysctr_irq_acknowledge(void)
+{
+	/*
+	 * clear the enable bit(EN =3D0) will clear
+	 * the status bit(ISTAT =3D 0), then the interrupt
+	 * signal will be negated(acknowledged).
+	 */
+	sysctr_timer_enable(false);
+}
+
+static inline u64 sysctr_read_counter(void)
+{
+	u32 cnt_hi, tmp_hi, cnt_lo;
+
+	do {
+		cnt_hi =3D readl_relaxed(sys_ctr_base + CNTCV_HI);
+		cnt_lo =3D readl_relaxed(sys_ctr_base + CNTCV_LO);
+		tmp_hi =3D readl_relaxed(sys_ctr_base + CNTCV_HI);
+	} while (tmp_hi !=3D cnt_hi);
+
+	return  ((u64) cnt_hi << 32) | cnt_lo;
+}
+
+static int sysctr_set_next_event(unsigned long delta,
+				 struct clock_event_device *evt)
+{
+	u32 cmp_hi, cmp_lo;
+	u64 next;
+
+	sysctr_timer_enable(false);
+
+	next =3D sysctr_read_counter();
+
+	next +=3D delta;
+
+	cmp_hi =3D (next >> 32) & 0x00fffff;
+	cmp_lo =3D next & 0xffffffff;
+
+	writel_relaxed(cmp_hi, sys_ctr_base + CMPCV_HI);
+	writel_relaxed(cmp_lo, sys_ctr_base + CMPCV_LO);
+
+	sysctr_timer_enable(true);
+
+	return 0;
+}
+
+static int sysctr_set_state_oneshot(struct clock_event_device *evt)
+{
+	sysctr_timer_enable(true);
+
+	return 0;
+}
+
+static int sysctr_set_state_shutdown(struct clock_event_device *evt)
+{
+	sysctr_timer_enable(false);
+
+	return 0;
+}
+
+static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt =3D dev_id;
+
+	sysctr_irq_acknowledge();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct timer_of to_sysctr =3D {
+	.flags =3D TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
+	.clkevt =3D {
+		.name			=3D "i.MX system counter timer",
+		.features		=3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ,
+		.set_state_oneshot	=3D sysctr_set_state_oneshot,
+		.set_next_event		=3D sysctr_set_next_event,
+		.set_state_shutdown	=3D sysctr_set_state_shutdown,
+		.rating			=3D 200,
+	},
+	.of_irq =3D {
+		.handler		=3D sysctr_timer_interrupt,
+		.flags			=3D IRQF_TIMER | IRQF_IRQPOLL,
+	},
+	.of_clk =3D {
+		.name =3D "per",
+	},
+};
+
+static void __init sysctr_clockevent_init(void)
+{
+	to_sysctr.clkevt.cpumask =3D cpumask_of(0);
+
+	clockevents_config_and_register(&to_sysctr.clkevt, timer_of_rate(&to_sysc=
tr),
+					0xff, 0x7fffffff);
+}
+
+static int __init sysctr_timer_init(struct device_node *np)
+{
+	int ret =3D 0;
+
+	ret =3D timer_of_init(np, &to_sysctr);
+	if (ret)
+		return ret;
+
+	sys_ctr_base =3D timer_of_base(&to_sysctr);
+
+	sysctr_clockevent_init();
+
+	return 0;
+}
+TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
--=20
1.9.1

