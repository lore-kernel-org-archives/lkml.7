Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF11C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2E5218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="k7cvtbE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfCNQ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:26:49 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7032 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfCNQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:26:44 -0400
X-IronPort-AV: E=Sophos;i="5.58,478,1544511600"; 
   d="scan'208";a="28204156"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Mar 2019 09:26:42 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Mar 2019 09:26:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjK1sMJrwzdv6U8V6o+NXHiirtWnLpiPW/aCkKqpTNI=;
 b=k7cvtbE7zzxBBhfnHX7wrLKgKql3DnpQiB6+Y5nIV+qZjFUeFDC/Ikgo7f0BgrZlaaVuwRMXbd7E5cw2dB9WdPG5Dp/9aePL8A+MQC+NS1RuCfr33m1MHOEuUaKHXO97/3BcqnS8i4wCx4fM810WPLIJSmjLZAoyZXF/pXWvX4g=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB0061.namprd11.prod.outlook.com (10.164.204.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 16:26:39 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 16:26:39 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 2/5] clocksource/drivers/timer-microchip-pit64b: add Microchip
 PIT64B support
Thread-Topic: [PATCH 2/5] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
Thread-Index: AQHU2oKzNY9L7o7MvUGRVNlgkbjplQ==
Date:   Thu, 14 Mar 2019 16:26:38 +0000
Message-ID: <1552580772-8499-3-git-send-email-claudiu.beznea@microchip.com>
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0088.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::32) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [86.120.234.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f683d25d-b5a4-4096-2f27-08d6a899d585
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB0061;
x-ms-traffictypediagnostic: MWHPR11MB0061:
x-microsoft-antispam-prvs: <MWHPR11MB0061EF2606446F170918DCCE874B0@MWHPR11MB0061.namprd11.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(107886003)(305945005)(106356001)(7736002)(14444005)(316002)(478600001)(86362001)(2201001)(72206003)(256004)(25786009)(99286004)(53936002)(6512007)(4326008)(8676002)(105586002)(81156014)(81166006)(54906003)(110136005)(50226002)(14454004)(6116002)(3846002)(66066001)(8936002)(97736004)(5660300002)(68736007)(2501003)(102836004)(6436002)(2906002)(71190400001)(446003)(386003)(2616005)(6506007)(476003)(186003)(71200400001)(26005)(30864003)(52116002)(11346002)(76176011)(36756003)(6486002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0061;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jxwbRarGAOSTbK6wyfLSaogKmKq3a+rtyM4BPyDf9JiMprDnCCo5SVj/57fakSXCs7M01bPa80njvjBgveWfm0eSKacFU/nOCzjOWmMIfqZbyoxm53ioecviY1AjCmPwnigM/T7FIY1ziM8xHR809VBpqm+eDFI0DYV6FxU2JDgfteG6BKWnyVaFYwptY6jaKoV2YZhD5lqepCKREtBh5oYXDJxXXNR6pwFbr8k59A7FT/mZ5qYn3Uvd+ElJeikBVeykav+cb0b3DV4gytUTKKyZ0UHCNsmNd9Tvua9DqZFLsYQRyLqtRfq5YBnWK356gj2RR4Yd5KJ+4HCrg11w3vQ+PnWr2in+Wby3nzFZASlOPYQq15V0eMNWgtNytiQpy6fksSwH+hnosKQ9R/zM7+y+4te737PJNI6kCB/hvCs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f683d25d-b5a4-4096-2f27-08d6a899d585
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 16:26:38.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0061
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add driver for Microchip PIT64B timer. Timer could be used in continuous
mode or oneshot mode. The hardware has 2x32 bit registers for period
emulating a 64 bit timer. The LSB_PR and MSB_PR registers are used to set
the period value (compare value). TLSB and TMSB keeps the current value
of the counter. After a compare the TLSB and TMSB register resets. Apart
from this the hardware has SMOD bit in mode register that allow to
reconfigure the timer without reset and start commands (start command
while timer is active is ignored).
The driver uses PIT64B timer as clocksource or clockevent. First requested
timer would be registered as clockevent, second one would be registered as
clocksource. Individual PIT64B hardware resources were used for clocksource
and clockevent to be able to support high resolution timers with this
hardware implementation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/Kconfig                  |   6 +
 drivers/clocksource/Makefile                 |   1 +
 drivers/clocksource/timer-microchip-pit64b.c | 464 +++++++++++++++++++++++=
++++
 3 files changed, 471 insertions(+)
 create mode 100644 drivers/clocksource/timer-microchip-pit64b.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5d93e580e5dc..2ad6f881a0bb 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -448,6 +448,12 @@ config OXNAS_RPS_TIMER
 config SYS_SUPPORTS_SH_CMT
         bool
=20
+config MICROCHIP_PIT64B
+	bool "Microchip PIT64B support"
+	depends on OF || COMPILE_TEST
+	help
+	  This option enables Microchip PIT64B timer.
+
 config MTK_TIMER
 	bool "Mediatek timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index c4a8e9ef932a..c53fa12b9b94 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_U300_TIMER)	+=3D timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+=3D timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+=3D timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+=3D timer-meson6.o
+obj-$(CONFIG_MICROCHIP_PIT64B)	+=3D timer-microchip-pit64b.o
 obj-$(CONFIG_TEGRA_TIMER)	+=3D timer-tegra20.o
 obj-$(CONFIG_VT8500_TIMER)	+=3D timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+=3D timer-zevio.o
diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clockso=
urce/timer-microchip-pit64b.c
new file mode 100644
index 000000000000..6787aa98ef01
--- /dev/null
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2019 Microchip Technology Inc.
+// Copyright (C) 2019 Claudiu Beznea (claudiu.beznea@microchip.com)
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+
+#define MCHP_PIT64B_CR		0x00	/* Control Register */
+#define MCHP_PIT64B_CR_START	BIT(0)
+#define MCHP_PIT64B_CR_SWRST	BIT(8)
+
+#define MCHP_PIT64B_MR		0x04	/* Mode Register */
+#define MCHP_PIT64B_MR_CONT	BIT(0)
+#define MCHP_PIT64B_MR_SGCLK	BIT(3)
+#define MCHP_PIT64B_MR_SMOD	BIT(4)
+#define MCHP_PIT64B_MR_PRES	GENMASK(11, 8)
+
+#define MCHP_PIT64B_LSB_PR	0x08	/* LSB Period Register */
+
+#define MCHP_PIT64B_MSB_PR	0x0C	/* MSB Period Register */
+
+#define MCHP_PIT64B_IER		0x10	/* Interrupt Enable Register */
+#define MCHP_PIT64B_IER_PERIOD	BIT(0)
+
+#define MCHP_PIT64B_ISR		0x1C	/* Interrupt Status Register */
+#define MCHP_PIT64B_ISR_PERIOD	BIT(0)
+
+#define MCHP_PIT64B_TLSBR	0x20	/* Timer LSB Register */
+
+#define MCHP_PIT64B_TMSBR	0x24	/* Timer MSB Register */
+
+#define MCHP_PIT64B_PRES_MAX	0x10
+#define MCHP_PIT64B_DEF_FREQ	2500000UL	/* 2.5 MHz */
+#define MCHP_PIT64B_LSBMASK	GENMASK_ULL(31, 0)
+#define MCHP_PIT64B_PRESCALER(p)	(MCHP_PIT64B_MR_PRES & ((p) << 8))
+
+#define MCHP_PIT64B_NAME	"pit64b"
+
+struct mchp_pit64b_common_data {
+	void __iomem *base;
+	struct clk *pclk;
+	struct clk *gclk;
+	u64 cycles;
+	u8 pres;
+};
+
+struct mchp_pit64b_clksrc_data {
+	struct clocksource *clksrc;
+	struct mchp_pit64b_common_data *cd;
+};
+
+struct mchp_pit64b_clkevt_data {
+	struct clock_event_device *clkevt;
+	struct mchp_pit64b_common_data *cd;
+};
+
+static struct mchp_pit64b_data {
+	struct mchp_pit64b_clksrc_data *csd;
+	struct mchp_pit64b_clkevt_data *ced;
+} data;
+
+static inline u32 mchp_pit64b_read(void __iomem *base, u32 offset)
+{
+	return readl_relaxed(base + offset);
+}
+
+static inline void mchp_pit64b_write(void __iomem *base, u32 offset, u32 v=
al)
+{
+	writel_relaxed(val, base + offset);
+}
+
+static inline u64 mchp_pit64b_get_period(void __iomem *base)
+{
+	u32 lsb, msb;
+
+	/* LSB must be read first to guarantee an atomic read of the 64 bit
+	 * timer.
+	 */
+	lsb =3D mchp_pit64b_read(base, MCHP_PIT64B_TLSBR);
+	msb =3D mchp_pit64b_read(base, MCHP_PIT64B_TMSBR);
+
+	return (((u64)msb << 32) | lsb);
+}
+
+static inline void mchp_pit64b_set_period(void __iomem *base, u64 cycles)
+{
+	u32 lsb, msb;
+
+	lsb =3D cycles & MCHP_PIT64B_LSBMASK;
+	msb =3D cycles >> 32;
+
+	/* LSB must be write last to guarantee an atomic update of the timer
+	 * even when SMOD=3D1.
+	 */
+	mchp_pit64b_write(base, MCHP_PIT64B_MSB_PR, msb);
+	mchp_pit64b_write(base, MCHP_PIT64B_LSB_PR, lsb);
+}
+
+static inline void mchp_pit64b_reset(struct mchp_pit64b_common_data *data,
+				     u32 mode, bool irq_ena)
+{
+	mode |=3D MCHP_PIT64B_PRESCALER(data->pres);
+	if (data->gclk)
+		mode |=3D MCHP_PIT64B_MR_SGCLK;
+
+	mchp_pit64b_write(data->base, MCHP_PIT64B_CR, MCHP_PIT64B_CR_SWRST);
+	mchp_pit64b_write(data->base, MCHP_PIT64B_MR, mode);
+	mchp_pit64b_set_period(data->base, data->cycles);
+	if (irq_ena)
+		mchp_pit64b_write(data->base, MCHP_PIT64B_IER,
+				  MCHP_PIT64B_IER_PERIOD);
+	mchp_pit64b_write(data->base, MCHP_PIT64B_CR, MCHP_PIT64B_CR_START);
+}
+
+static u64 mchp_pit64b_read_clk(struct clocksource *cs)
+{
+	return mchp_pit64b_get_period(data.csd->cd->base);
+}
+
+static u64 mchp_sched_read_clk(void)
+{
+	return mchp_pit64b_get_period(data.csd->cd->base);
+}
+
+static struct clocksource mchp_pit64b_clksrc =3D {
+	.name =3D MCHP_PIT64B_NAME,
+	.mask =3D CLOCKSOURCE_MASK(64),
+	.flags =3D CLOCK_SOURCE_IS_CONTINUOUS,
+	.rating =3D 210,
+	.read =3D mchp_pit64b_read_clk,
+};
+
+static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
+{
+	mchp_pit64b_write(data.ced->cd->base, MCHP_PIT64B_CR,
+			  MCHP_PIT64B_CR_SWRST);
+
+	return 0;
+}
+
+static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cede=
v)
+{
+	mchp_pit64b_reset(data.ced->cd, MCHP_PIT64B_MR_CONT, true);
+
+	return 0;
+}
+
+static int mchp_pit64b_clkevt_set_oneshot(struct clock_event_device *cedev=
)
+{
+	mchp_pit64b_reset(data.ced->cd, MCHP_PIT64B_MR_SMOD, true);
+
+	return 0;
+}
+
+static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
+					     struct clock_event_device *cedev)
+{
+	mchp_pit64b_set_period(data.ced->cd->base, evt);
+	mchp_pit64b_write(data.ced->cd->base, MCHP_PIT64B_CR,
+			  MCHP_PIT64B_CR_START);
+
+	return 0;
+}
+
+static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
+{
+	mchp_pit64b_write(data.ced->cd->base, MCHP_PIT64B_CR,
+			  MCHP_PIT64B_CR_SWRST);
+	if (data.ced->cd->gclk)
+		clk_disable_unprepare(data.ced->cd->gclk);
+	clk_disable_unprepare(data.ced->cd->pclk);
+}
+
+static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
+{
+	u32 mode =3D MCHP_PIT64B_MR_SMOD;
+
+	clk_prepare_enable(data.ced->cd->pclk);
+	if (data.ced->cd->gclk)
+		clk_prepare_enable(data.ced->cd->gclk);
+
+	if (clockevent_state_periodic(data.ced->clkevt))
+		mode =3D MCHP_PIT64B_MR_CONT;
+
+	mchp_pit64b_reset(data.ced->cd, mode, true);
+}
+
+static struct clock_event_device mchp_pit64b_clkevt =3D {
+	.name =3D MCHP_PIT64B_NAME,
+	.features =3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+	.rating =3D 150,
+	.set_state_shutdown =3D mchp_pit64b_clkevt_shutdown,
+	.set_state_periodic =3D mchp_pit64b_clkevt_set_periodic,
+	.set_state_oneshot =3D mchp_pit64b_clkevt_set_oneshot,
+	.set_next_event =3D mchp_pit64b_clkevt_set_next_event,
+	.suspend =3D mchp_pit64b_clkevt_suspend,
+	.resume =3D mchp_pit64b_clkevt_resume,
+};
+
+static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
+{
+	struct mchp_pit64b_clkevt_data *irq_data =3D dev_id;
+
+	if (data.ced !=3D irq_data)
+		return IRQ_NONE;
+
+	if (mchp_pit64b_read(irq_data->cd->base, MCHP_PIT64B_ISR) &
+	    MCHP_PIT64B_ISR_PERIOD) {
+		irq_data->clkevt->event_handler(irq_data->clkevt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
+					   u32 max_rate)
+{
+	u32 tmp;
+
+	for (*pres =3D 0; *pres < MCHP_PIT64B_PRES_MAX; (*pres)++) {
+		tmp =3D clk_rate / (*pres + 1);
+		if (tmp <=3D max_rate)
+			break;
+	}
+
+	if (*pres =3D=3D MCHP_PIT64B_PRES_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init mchp_pit64b_pres_prepare(struct mchp_pit64b_common_data =
*cd,
+					   unsigned long max_rate)
+{
+	unsigned long pclk_rate, diff =3D 0, best_diff =3D ULONG_MAX;
+	long gclk_round =3D 0;
+	u32 pres, best_pres;
+	int ret =3D 0;
+
+	pclk_rate =3D clk_get_rate(cd->pclk);
+	if (!pclk_rate)
+		return -EINVAL;
+
+	if (cd->gclk) {
+		gclk_round =3D clk_round_rate(cd->gclk, max_rate);
+		if (gclk_round < 0)
+			goto pclk;
+
+		if (pclk_rate / gclk_round < 3)
+			goto pclk;
+
+		ret =3D mchp_pit64b_pres_compute(&pres, gclk_round, max_rate);
+		if (ret)
+			best_diff =3D abs(gclk_round - max_rate);
+		else
+			best_diff =3D abs(gclk_round / (pres + 1) - max_rate);
+		best_pres =3D pres;
+	}
+
+pclk:
+	/* Check if requested rate could be obtained using PCLK. */
+	ret =3D mchp_pit64b_pres_compute(&pres, pclk_rate, max_rate);
+	if (ret)
+		diff =3D abs(pclk_rate - max_rate);
+	else
+		diff =3D abs(pclk_rate / (pres + 1) - max_rate);
+
+	if (best_diff > diff) {
+		/* Use PCLK. */
+		cd->gclk =3D NULL;
+		best_pres =3D pres;
+	} else {
+		clk_set_rate(cd->gclk, gclk_round);
+	}
+
+	cd->pres =3D best_pres;
+
+	pr_info("PIT64B: using clk=3D%s with prescaler %u, freq=3D%lu [Hz]\n",
+		cd->gclk ? "gclk" : "pclk", cd->pres,
+		cd->gclk ? gclk_round / (cd->pres + 1)
+			 : pclk_rate / (cd->pres + 1));
+
+	return 0;
+}
+
+static int __init mchp_pit64b_dt_init_clksrc(struct mchp_pit64b_common_dat=
a *cd)
+{
+	struct mchp_pit64b_clksrc_data *csd;
+	unsigned long clk_rate;
+	int ret;
+
+	csd =3D kzalloc(sizeof(*csd), GFP_KERNEL);
+	if (!csd)
+		return -ENOMEM;
+
+	csd->cd =3D cd;
+
+	if (csd->cd->gclk)
+		clk_rate =3D clk_get_rate(csd->cd->gclk);
+	else
+		clk_rate =3D clk_get_rate(csd->cd->pclk);
+
+	clk_rate =3D clk_rate / (cd->pres + 1);
+	csd->cd->cycles =3D ULLONG_MAX;
+	mchp_pit64b_reset(csd->cd, MCHP_PIT64B_MR_CONT, false);
+
+	data.csd =3D csd;
+
+	csd->clksrc =3D &mchp_pit64b_clksrc;
+
+	ret =3D clocksource_register_hz(csd->clksrc, clk_rate);
+	if (ret) {
+		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
+		goto free;
+	}
+
+	sched_clock_register(mchp_sched_read_clk, 64, clk_rate);
+
+	return 0;
+
+free:
+	kfree(csd);
+	data.csd =3D NULL;
+
+	return ret;
+}
+
+static int __init mchp_pit64b_dt_init_clkevt(struct mchp_pit64b_common_dat=
a *cd,
+					     u32 irq)
+{
+	struct mchp_pit64b_clkevt_data *ced;
+	unsigned long clk_rate;
+	int ret;
+
+	ced =3D kzalloc(sizeof(*ced), GFP_KERNEL);
+	if (!ced)
+		return -ENOMEM;
+
+	ced->cd =3D cd;
+
+	if (ced->cd->gclk)
+		clk_rate =3D clk_get_rate(ced->cd->gclk);
+	else
+		clk_rate =3D clk_get_rate(ced->cd->pclk);
+
+	clk_rate =3D clk_rate / (ced->cd->pres + 1);
+	ced->cd->cycles =3D DIV_ROUND_CLOSEST(clk_rate, HZ);
+
+	ret =3D request_irq(irq, mchp_pit64b_interrupt, IRQF_TIMER, "pit64b_tick"=
,
+			  ced);
+	if (ret) {
+		pr_debug("clkevt: Failed to setup PIT64B IRQ\n");
+		goto free;
+	}
+
+	data.ced =3D ced;
+
+	/* Set up and register clockevents. */
+	ced->clkevt =3D &mchp_pit64b_clkevt;
+	ced->clkevt->cpumask =3D cpumask_of(0);
+	ced->clkevt->irq =3D irq;
+	clockevents_config_and_register(ced->clkevt, clk_rate, 1, ULONG_MAX);
+
+	return 0;
+
+free:
+	kfree(ced);
+	data.ced =3D NULL;
+
+	return ret;
+}
+
+static int __init mchp_pit64b_dt_init(struct device_node *node)
+{
+	struct mchp_pit64b_common_data *cd;
+	u32 irq, freq =3D MCHP_PIT64B_DEF_FREQ;
+	int ret;
+
+	if (data.csd && data.ced)
+		return -EBUSY;
+
+	cd =3D kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	cd->pclk =3D of_clk_get_by_name(node, "pclk");
+	if (IS_ERR(cd->pclk)) {
+		ret =3D PTR_ERR(cd->pclk);
+		goto free;
+	}
+
+	cd->gclk =3D of_clk_get_by_name(node, "gclk");
+	if (IS_ERR(cd->gclk))
+		cd->gclk =3D NULL;
+
+	ret =3D of_property_read_u32(node, "clock-frequency", &freq);
+	if (ret)
+		pr_debug("PIT64B: failed to read clock frequency. Using default!\n");
+
+	ret =3D mchp_pit64b_pres_prepare(cd, freq);
+	if (ret)
+		goto free;
+
+	cd->base =3D of_iomap(node, 0);
+	if (!cd->base) {
+		pr_debug("%s: Could not map PIT64B address!\n",
+			 MCHP_PIT64B_NAME);
+		ret =3D -ENXIO;
+		goto free;
+	}
+
+	ret =3D clk_prepare_enable(cd->pclk);
+	if (ret)
+		goto unmap;
+
+	if (cd->gclk) {
+		ret =3D clk_prepare_enable(cd->gclk);
+		if (ret)
+			goto pclk_unprepare;
+	}
+
+	if (!data.ced) {
+		irq =3D irq_of_parse_and_map(node, 0);
+		if (!irq) {
+			pr_debug("%s: Failed to get PIT64B clockevent IRQ!\n",
+				 MCHP_PIT64B_NAME);
+			ret =3D -ENODEV;
+			goto gclk_unprepare;
+		}
+		ret =3D mchp_pit64b_dt_init_clkevt(cd, irq);
+		if (ret)
+			goto irq_unmap;
+	} else {
+		ret =3D mchp_pit64b_dt_init_clksrc(cd);
+		if (ret)
+			goto gclk_unprepare;
+	}
+
+	return 0;
+
+irq_unmap:
+	irq_dispose_mapping(irq);
+gclk_unprepare:
+	if (cd->gclk)
+		clk_disable_unprepare(cd->gclk);
+pclk_unprepare:
+	clk_disable_unprepare(cd->pclk);
+unmap:
+	iounmap(cd->base);
+free:
+	kfree(cd);
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(mchp_pit64b_clksrc, "microchip,sam9x60-pit64b",
+		 mchp_pit64b_dt_init);
--=20
2.7.4

