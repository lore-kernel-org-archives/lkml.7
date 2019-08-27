Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738ECC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D8A2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="b/lV2m/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfH0PJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:09:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58794 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729761AbfH0PI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:08:59 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RF27Pv026516;
        Tue, 27 Aug 2019 17:08:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=T2KW3krsTHjn6t/l3a3+5UDFPr5eKFx+8xw6T6gmWOs=;
 b=b/lV2m/B0ELgtF8gDiGylKZEywgqluw3kOIzenDiyiny0c08hePygsljrB0DjQoVSvL5
 nfIU0GYDWzXOeZ7iPaGb/A1QSa16W7RXiQWQpr0xrjPInV0hPODc8tL0RT5fczSagHBo
 mqZiS4uOlsr3pIt75aWjGo3OTbkrDe2ht62dbMnvoXZE1RJDfVjc4/q3E/H+gyKkUqxI
 045655Hgfp/0vL49wkH0TS20vFuOiH5MfEy3IyoUrfmsHaRfxacW7t6l0usmcxSEa9Jj
 ytzP/0zoBRyhHy9whdVjarwoe93S7GqNWEBjoKD9aj9oqdPOaJ7Apfc7uU541M0hzAUD iQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ujv4kt4ax-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Aug 2019 17:08:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 812BC53;
        Tue, 27 Aug 2019 15:08:21 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36A4D2B76DD;
        Tue, 27 Aug 2019 17:08:21 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 27 Aug
 2019 17:08:20 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Tue, 27 Aug 2019 17:08:20 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH v3 3/5] perf: stm32: ddrperfm driver creation
Thread-Topic: [PATCH v3 3/5] perf: stm32: ddrperfm driver creation
Thread-Index: AQHVXOlD+ZgoQYwFK0SqFlAqcgIaiA==
Date:   Tue, 27 Aug 2019 15:08:20 +0000
Message-ID: <1566918464-23927-4-git-send-email-gerald.baeza@st.com>
References: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1 SOC.

This perf drivers supports the read, write, activate, idle and total
time counters, described in the reference manual RM0436 that is
accessible from Documentation/arm/stm32/stm32mp157-overview.rst

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/perf/Kconfig         |   6 +
 drivers/perf/Makefile        |   1 +
 drivers/perf/stm32_ddr_pmu.c | 426 +++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 433 insertions(+)
 create mode 100644 drivers/perf/stm32_ddr_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 09ae8a9..a3d917e 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -114,6 +114,12 @@ config THUNDERX2_PMU
 	   The SoC has PMU support in its L3 cache controller (L3C) and
 	   in the DDR4 Memory Controller (DMC).
=20
+config STM32_DDR_PMU
+       tristate "STM32 DDR PMU"
+       depends on MACH_STM32MP157
+       help
+         Support for STM32 DDR performance monitor (DDRPERFM).
+
 config XGENE_PMU
         depends on ARCH_XGENE
         bool "APM X-Gene SoC PMU"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 2ebb4de..fd3368c 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_FSL_IMX8_DDR_PMU) +=3D fsl_imx8_ddr_perf.o
 obj-$(CONFIG_HISI_PMU) +=3D hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+=3D qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
+obj-$(CONFIG_STM32_DDR_PMU) +=3D stm32_ddr_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
diff --git a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c
new file mode 100644
index 0000000..d0480e0
--- /dev/null
+++ b/drivers/perf/stm32_ddr_pmu.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is the STM32 DDR performance monitor (DDRPERFM) driver
+ *
+ * Copyright (C) 2019, STMicroelectronics - All Rights Reserved
+ * Author: Gerald Baeza <gerald.baeza@st.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/hrtimer.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/perf_event.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+/*
+ * The PMU is able to freeze all counters and generate an interrupt when t=
here
+ * is a counter overflow. But, relying on this means that we lose all the
+ * events that occur between the freeze and the interrupt handler executio=
n.
+ * So we use a polling mechanism to avoid this lose of information.
+ * The fastest counter can overflow in ~8s @533MHz (that is the maximum DD=
R
+ * frequency supported on STM32MP157), so we poll in 4s intervals to ensur=
e
+ * we don't reach this limit.
+ */
+#define POLL_MS		4000
+
+#define DDRPERFM_CTL	0x000
+#define DDRPERFM_CFG	0x004
+#define DDRPERFM_STATUS 0x008
+#define DDRPERFM_CCR	0x00C
+#define DDRPERFM_IER	0x010
+#define DDRPERFM_ISR	0x014
+#define DDRPERFM_ICR	0x018
+#define DDRPERFM_TCNT	0x020
+#define DDRPERFM_CNT(X)	(0x030 + 8 * (X))
+#define DDRPERFM_HWCFG	0x3F0
+#define DDRPERFM_VER	0x3F4
+#define DDRPERFM_ID	0x3F8
+#define DDRPERFM_SID	0x3FC
+
+#define CTL_START	0x00000001
+#define CTL_STOP	0x00000002
+#define CCR_CLEAR_ALL	0x8000000F
+#define SID_MAGIC_ID	0xA3C5DD01
+
+enum {
+	READ_CNT,
+	WRITE_CNT,
+	ACTIVATE_CNT,
+	IDLE_CNT,
+	TIME_CNT,
+	PMU_NR_COUNTERS
+};
+
+struct stm32_ddr_pmu {
+	struct pmu pmu;
+	void __iomem *membase;
+	struct clk *clk;
+	struct hrtimer hrtimer;
+	cpumask_t pmu_cpu;
+	ktime_t poll_period;
+	struct perf_event *events[PMU_NR_COUNTERS];
+	u64 events_cnt[PMU_NR_COUNTERS];
+};
+
+static inline struct stm32_ddr_pmu *pmu_to_stm32_ddr_pmu(struct pmu *p)
+{
+	return container_of(p, struct stm32_ddr_pmu, pmu);
+}
+
+static inline struct stm32_ddr_pmu *hrtimer_to_stm32_ddr_pmu(struct hrtime=
r *h)
+{
+	return container_of(h, struct stm32_ddr_pmu, hrtimer);
+}
+
+static void stm32_ddr_pmu_event_configure(struct perf_event *event)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long config_base =3D event->hw.config_base;
+	u32 val;
+
+	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+
+	if (config_base < TIME_CNT) {
+		val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_CFG);
+		val |=3D (1 << config_base);
+		writel_relaxed(val, stm32_ddr_pmu->membase + DDRPERFM_CFG);
+	}
+}
+
+static void stm32_ddr_pmu_event_read(struct perf_event *event)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long config_base =3D event->hw.config_base;
+	struct hw_perf_event *hw =3D &event->hw;
+	u64 prev_count, new_count, mask;
+	u32 val, offset, bit;
+
+	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+
+	if (config_base =3D=3D TIME_CNT) {
+		offset =3D DDRPERFM_TCNT;
+		bit =3D 1 << 31;
+	} else {
+		offset =3D DDRPERFM_CNT(config_base);
+		bit =3D 1 << config_base;
+	}
+	val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_STATUS);
+	if (val & bit)
+		pr_warn("STM32 DDR PMU hardware counter overflow\n");
+	val =3D readl_relaxed(stm32_ddr_pmu->membase + offset);
+	writel_relaxed(bit, stm32_ddr_pmu->membase + DDRPERFM_CCR);
+	writel_relaxed(CTL_START, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+
+	do {
+		prev_count =3D local64_read(&hw->prev_count);
+		new_count =3D prev_count + val;
+	} while (local64_xchg(&hw->prev_count, new_count) !=3D prev_count);
+
+	mask =3D GENMASK_ULL(31, 0);
+	local64_add(val & mask, &event->count);
+
+	if (new_count < prev_count)
+		pr_warn("STM32 DDR PMU software counter rollover\n");
+}
+
+static void stm32_ddr_pmu_event_start(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	struct hw_perf_event *hw =3D &event->hw;
+
+	if (WARN_ON_ONCE(!(hw->state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(hw->state & PERF_HES_UPTODATE));
+
+	stm32_ddr_pmu_event_configure(event);
+
+	/* Clear all counters to synchronize them, then start */
+	writel_relaxed(CCR_CLEAR_ALL, stm32_ddr_pmu->membase + DDRPERFM_CCR);
+	writel_relaxed(CTL_START, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+	local64_set(&hw->prev_count, 0);
+	hw->state =3D 0;
+}
+
+static void stm32_ddr_pmu_event_stop(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long config_base =3D event->hw.config_base;
+	struct hw_perf_event *hw =3D &event->hw;
+	u32 val, bit;
+
+	if (WARN_ON_ONCE(hw->state & PERF_HES_STOPPED))
+		return;
+
+	writel_relaxed(CTL_STOP, stm32_ddr_pmu->membase + DDRPERFM_CTL);
+	if (config_base =3D=3D TIME_CNT)
+		bit =3D 1 << 31;
+	else
+		bit =3D 1 << config_base;
+	writel_relaxed(bit, stm32_ddr_pmu->membase + DDRPERFM_CCR);
+	if (config_base < TIME_CNT) {
+		val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_CFG);
+		val &=3D ~bit;
+		writel_relaxed(val, stm32_ddr_pmu->membase + DDRPERFM_CFG);
+	}
+
+	hw->state |=3D PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_UPDATE) {
+		stm32_ddr_pmu_event_read(event);
+		hw->state |=3D PERF_HES_UPTODATE;
+	}
+}
+
+static int stm32_ddr_pmu_event_add(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long config_base =3D event->hw.config_base;
+	struct hw_perf_event *hw =3D &event->hw;
+
+	stm32_ddr_pmu->events_cnt[config_base] =3D 0;
+	stm32_ddr_pmu->events[config_base] =3D event;
+
+	clk_enable(stm32_ddr_pmu->clk);
+	/*
+	 * Pin the timer, so that the overflows are handled by the chosen
+	 * event->cpu (this is the same one as presented in "cpumask"
+	 * attribute).
+	 */
+	hrtimer_start(&stm32_ddr_pmu->hrtimer, stm32_ddr_pmu->poll_period,
+		      HRTIMER_MODE_REL_PINNED);
+
+	stm32_ddr_pmu_event_configure(event);
+
+	hw->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		stm32_ddr_pmu_event_start(event, 0);
+
+	return 0;
+}
+
+static void stm32_ddr_pmu_event_del(struct perf_event *event, int flags)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	unsigned long config_base =3D event->hw.config_base;
+	bool stop =3D true;
+	int i;
+
+	stm32_ddr_pmu_event_stop(event, PERF_EF_UPDATE);
+
+	stm32_ddr_pmu->events_cnt[config_base] +=3D local64_read(&event->count);
+	stm32_ddr_pmu->events[config_base] =3D NULL;
+
+	for (i =3D 0; i < PMU_NR_COUNTERS; i++)
+		if (stm32_ddr_pmu->events[i])
+			stop =3D false;
+	if (stop)
+		hrtimer_cancel(&stm32_ddr_pmu->hrtimer);
+
+	clk_disable(stm32_ddr_pmu->clk);
+}
+
+static int stm32_ddr_pmu_event_init(struct perf_event *event)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D pmu_to_stm32_ddr_pmu(event->pmu);
+	struct hw_perf_event *hw =3D &event->hw;
+
+	if (event->attr.type !=3D event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event))
+		return -EINVAL;
+
+	if (event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	if (event->attr.exclude_user   ||
+	    event->attr.exclude_kernel ||
+	    event->attr.exclude_hv     ||
+	    event->attr.exclude_idle   ||
+	    event->attr.exclude_host   ||
+	    event->attr.exclude_guest)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	hw->config_base =3D event->attr.config;
+	event->cpu =3D cpumask_first(&stm32_ddr_pmu->pmu_cpu);
+
+	return 0;
+}
+
+static enum hrtimer_restart stm32_ddr_pmu_poll(struct hrtimer *hrtimer)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D hrtimer_to_stm32_ddr_pmu(hrtimer)=
;
+	int i;
+
+	for (i =3D 0; i < PMU_NR_COUNTERS; i++)
+		if (stm32_ddr_pmu->events[i])
+			stm32_ddr_pmu_event_read(stm32_ddr_pmu->events[i]);
+
+	hrtimer_forward_now(hrtimer, stm32_ddr_pmu->poll_period);
+
+	return HRTIMER_RESTART;
+}
+
+static ssize_t stm32_ddr_pmu_sysfs_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr =3D container_of(attr, struct dev_ext_attribute, attr);
+
+	return sprintf(buf, "config=3D0x%lx\n", (unsigned long)eattr->var);
+}
+
+#define STM32_DDR_PMU_ATTR(_name, _func, _config)			\
+	(&((struct dev_ext_attribute[]) {				\
+		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
+	})[0].attr.attr)
+
+#define STM32_DDR_PMU_EVENT_ATTR(_name, _config)		\
+	STM32_DDR_PMU_ATTR(_name, stm32_ddr_pmu_sysfs_show,	\
+			   (unsigned long)_config)
+
+static struct attribute *stm32_ddr_pmu_event_attrs[] =3D {
+	STM32_DDR_PMU_EVENT_ATTR(read_cnt, READ_CNT),
+	STM32_DDR_PMU_EVENT_ATTR(write_cnt, WRITE_CNT),
+	STM32_DDR_PMU_EVENT_ATTR(activate_cnt, ACTIVATE_CNT),
+	STM32_DDR_PMU_EVENT_ATTR(idle_cnt, IDLE_CNT),
+	STM32_DDR_PMU_EVENT_ATTR(time_cnt, TIME_CNT),
+	NULL
+};
+
+static struct attribute_group stm32_ddr_pmu_event_attrs_group =3D {
+	.name =3D "events",
+	.attrs =3D stm32_ddr_pmu_event_attrs,
+};
+
+static const struct attribute_group *stm32_ddr_pmu_attr_groups[] =3D {
+	&stm32_ddr_pmu_event_attrs_group,
+	NULL,
+};
+
+static int stm32_ddr_pmu_device_probe(struct platform_device *pdev)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu;
+	struct reset_control *rst;
+	struct resource *res;
+	int i, ret;
+	u32 val;
+
+	stm32_ddr_pmu =3D devm_kzalloc(&pdev->dev, sizeof(struct stm32_ddr_pmu),
+				     GFP_KERNEL);
+	if (!stm32_ddr_pmu)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, stm32_ddr_pmu);
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	stm32_ddr_pmu->membase =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(stm32_ddr_pmu->membase)) {
+		pr_warn("Unable to get STM32 DDR PMU membase\n");
+		return PTR_ERR(stm32_ddr_pmu->membase);
+	}
+
+	stm32_ddr_pmu->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(stm32_ddr_pmu->clk)) {
+		pr_warn("Unable to get STM32 DDR PMU clock\n");
+		return PTR_ERR(stm32_ddr_pmu->clk);
+	}
+
+	ret =3D clk_prepare_enable(stm32_ddr_pmu->clk);
+	if (ret) {
+		pr_warn("Unable to prepare STM32 DDR PMU clock\n");
+		return ret;
+	}
+
+	stm32_ddr_pmu->poll_period =3D ms_to_ktime(POLL_MS);
+	hrtimer_init(&stm32_ddr_pmu->hrtimer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	stm32_ddr_pmu->hrtimer.function =3D stm32_ddr_pmu_poll;
+
+	/*
+	 * The PMU is assigned to the cpu0 and there is no need to manage cpu
+	 * hot plug migration because cpu0 is always the first/last active cpu
+	 * during low power transitions.
+	 */
+	cpumask_set_cpu(0, &stm32_ddr_pmu->pmu_cpu);
+
+	for (i =3D 0; i < PMU_NR_COUNTERS; i++) {
+		stm32_ddr_pmu->events[i] =3D NULL;
+		stm32_ddr_pmu->events_cnt[i] =3D 0;
+	}
+
+	val =3D readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_SID);
+	if (val !=3D SID_MAGIC_ID)
+		return -EINVAL;
+
+	stm32_ddr_pmu->pmu =3D (struct pmu) {
+		.task_ctx_nr =3D perf_invalid_context,
+		.start =3D stm32_ddr_pmu_event_start,
+		.stop =3D stm32_ddr_pmu_event_stop,
+		.add =3D stm32_ddr_pmu_event_add,
+		.del =3D stm32_ddr_pmu_event_del,
+		.event_init =3D stm32_ddr_pmu_event_init,
+		.attr_groups =3D stm32_ddr_pmu_attr_groups,
+	};
+	ret =3D perf_pmu_register(&stm32_ddr_pmu->pmu, "stm32_ddr_pmu", -1);
+	if (ret) {
+		pr_warn("Unable to register STM32 DDR PMU\n");
+		return ret;
+	}
+
+	rst =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (!IS_ERR(rst)) {
+		reset_control_assert(rst);
+		udelay(2);
+		reset_control_deassert(rst);
+	}
+
+	pr_info("stm32-ddr-pmu: probed (DDRPERFM ID=3D0x%08x VER=3D0x%08x)\n",
+		readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_ID),
+		readl_relaxed(stm32_ddr_pmu->membase + DDRPERFM_VER));
+
+	clk_disable(stm32_ddr_pmu->clk);
+
+	return 0;
+}
+
+static int stm32_ddr_pmu_device_remove(struct platform_device *pdev)
+{
+	struct stm32_ddr_pmu *stm32_ddr_pmu =3D platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&stm32_ddr_pmu->pmu);
+
+	return 0;
+}
+
+static const struct of_device_id stm32_ddr_pmu_of_match[] =3D {
+	{ .compatible =3D "st,stm32-ddr-pmu" },
+	{ },
+};
+
+static struct platform_driver stm32_ddr_pmu_driver =3D {
+	.driver =3D {
+		.name	=3D "stm32-ddr-pmu",
+		.of_match_table =3D of_match_ptr(stm32_ddr_pmu_of_match),
+	},
+	.probe =3D stm32_ddr_pmu_device_probe,
+	.remove =3D stm32_ddr_pmu_device_remove,
+};
+
+module_platform_driver(stm32_ddr_pmu_driver);
+
+MODULE_DESCRIPTION("Perf driver for STM32 DDR performance monitor");
+MODULE_AUTHOR("Gerald Baeza <gerald.baeza@st.com>");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4
