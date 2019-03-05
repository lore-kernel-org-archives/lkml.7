Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548FCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E171520684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OeK+C383"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfCEKTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:19:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54974 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfCEKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101928euoutp0181043cb811952a32bffce12f4b021b91~JCMBWOo3K0639006390euoutp01B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190305101928euoutp0181043cb811952a32bffce12f4b021b91~JCMBWOo3K0639006390euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781168;
        bh=5aaGb8Tv9k0m3zUY8MKfdjWU8oigMo08+ZJr3x90j4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeK+C383JNSSKiOSHM2NnX2QfqibLGWD08kFa/A8hKnJCjKldkFPobhtz2EODq9cy
         Vi3fwVfo7sbTOh9XSFQvH1c6/vKlcMBuYl4G1aXec+L9jWB9r0ks9Wq6a3SVkk95qR
         meMU0Xz215V1KvWKcMpbAWYlWKwFTEFN2Drdyjq0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190305101928eucas1p282d42a10a62120f18349dfd2a23c991d~JCMAsn0IP2130221302eucas1p26;
        Tue,  5 Mar 2019 10:19:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 35.4F.04441.F2D4E7C5; Tue,  5
        Mar 2019 10:19:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101927eucas1p151816366df5b2071ca73dd7194b70799~JCL-81sGo0207602076eucas1p1d;
        Tue,  5 Mar 2019 10:19:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101927eusmtrp258ea6dfb61f0413f3e4e96569f0e1fa2~JCL-45jXp2083020830eusmtrp28;
        Tue,  5 Mar 2019 10:19:27 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-04-5c7e4d2f300b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.46.04284.F2D4E7C5; Tue,  5
        Mar 2019 10:19:27 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101926eusmtip1ede8e4c1cbab7ef1c78d426974b2f64f~JCL-QDMP52936629366eusmtip1b;
        Tue,  5 Mar 2019 10:19:26 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 5/8] drivers: devfreq: add DMC driver for Exynos5422
Date:   Tue,  5 Mar 2019 11:19:08 +0100
Message-Id: <1551781151-5562-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTcRTvv3vvdp2u/k3Jg4nCIOhBPujBDUMUeqwnfRPKrOkuKs1Hu74t
        m33Id7PMR2LNRHAMy9cQtUhTUdOcuSI1TcRFia/K+aiMzHlXffudc36Pw+HQhPQe5UZHRsex
        6miFSiYUk41dP0x7vc+kBfusffdh6kpqKGZo8TPF6DpNFKO1zBDMwECtiOm/OSti3mvcmTct
        ZULGmteJmJKB5wLmcecHETOarhcyHbMZVIBEXm/IEspfzD8TyG8bDUhurfc4R54XH1ayqsgE
        Vu3tf1kc0fbOTMUWVAuSSuYbRBpktqJsRNOA94N+OTQbiWkp1iPQ5D8R8MUigorJBZIvrAhm
        c/NF2chhQ9HwadrOqkJgKbGgf5I5fTZh8xViL2gyXLUJXHAqjA21EjYOgecQ3B9ZJG0DZ3wc
        xlfGKBsm8Q4o6K8lbFiCT0Bh5lOCT/OAEVPWBnbAJ6H1Uc2GEeBiESyaZ0iedATKvurtAmeY
        7jbaV3WHtWadgMcc9GcahDy+Bhkvm+wcP+joHqRsSxN4F9S0ePPtQCjQzor4G22G4bmttjax
        Du82FhN8WwKZt6Q8eycYc1/bg7ZBVXWR3VwOq+M6ij/PAwTNK2NEPvIs/R9WjpABubLxXFQ4
        y/lGs4lenCKKi48O9wqLiapH67/S97t7oQktmUPbEaaRzEkScfB6sJRSJHDJUe0IaELmIvnl
        mhYslSgVySmsOuaSOl7Fcu1oO03KXCWpmyYuSHG4Io69wrKxrPrvVEA7uGlQ3g1lz6FKoYc5
        Z8mUQ4xqj4bgpC2ZC+kfk4PGaa1xz6S1MgU1J3qHYsFU67AlsOjU8io1Zug0vW3Kym+4U/Hz
        VV2vf9vpumGlivyGPAdjxVNBYY4qJCoNwGE6hQ4c2b59D53OEjkHur4kHHO4GKYpL9SGDHZB
        h19vzwSWkVyEwnc3oeYUfwBdtfseJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xu7r6vnUxBts/c1psnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOHDtEmvB5DVMFTPebWZvYLz0mbGLkZNDQsBEYvOz
        V0wgtpDAUkaJ5zdNIOJiEpP2bWeHsIUl/lzrYuti5AKq+cQocfjHJKAGDg42AT2JHasKQWpE
        BOol+t9cAqthFvjOKHHoyQSwBcIC7hL3vt9hBbFZBFQlJp/dwAxi8wp4Skzt2M0MsUBO4ua5
        TjCbU8BLYv/C9cwQBwHVfF3IMoGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAMN92
        7OfmHYyXNgYfYhTgYFTi4c0wq40RYk0sK67MPcQowcGsJML7R7wuRog3JbGyKrUoP76oNCe1
        +BCjKdBRE5mlRJPzgTGYVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mD
        U6qBMdUl9HxRuekMfcXoPV++cTzl3rqXc7PK+wVhK4qzy5hFxRZ4bjqtm7KistDmZseC2Udr
        uJSvBnJvlXz9M/XN5FnXn1y7UXX2q6OklLueaNkrjdfrH9ncbHujGmvmIJu3f57m6im7n5zt
        s7owPYtz97WHH9qPzrpgcNhgdomDY3vJ0gePfjyNeaTEUpyRaKjFXFScCABIiCjUiQIAAA==
X-CMS-MailID: 20190305101927eucas1p151816366df5b2071ca73dd7194b70799
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101927eucas1p151816366df5b2071ca73dd7194b70799
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101927eucas1p151816366df5b2071ca73dd7194b70799
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101927eucas1p151816366df5b2071ca73dd7194b70799@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds driver for Exynos5422 Dynamic Memory Controller.
The driver provides support for dynamic frequency and voltage scaling for
DMC and DRAM. It supports changing timings of DRAM running with different
frequency.
The patch also contains needed MAINTAINERS file update.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 MAINTAINERS                      |    8 +
 drivers/devfreq/Kconfig          |   13 +
 drivers/devfreq/Makefile         |    1 +
 drivers/devfreq/exynos5422-dmc.c | 1154 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 1176 insertions(+)
 create mode 100644 drivers/devfreq/exynos5422-dmc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dce5c09..e20172b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3323,6 +3323,14 @@ S:	Maintained
 F:	drivers/devfreq/exynos-bus.c
 F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
 
+DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
+M:	Lukasz Luba <l.luba@partner.samsung.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Maintained
+F:	drivers/devfreq/exynos5422-dmc.c
+F:	Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
+
 BUSLOGIC SCSI DRIVER
 M:	Khalid Aziz <khalid@gonehiking.org>
 L:	linux-scsi@vger.kernel.org
diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6a172d3..a476477 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -113,6 +113,19 @@ config ARM_RK3399_DMC_DEVFREQ
           It sets the frequency for the memory controller and reads the usage counts
           from hardware.
 
+config ARM_EXYNOS5422_DMC_DEVFREQ
+	tristate "ARM EXYNOS5422 DMC DEVFREQ Driver"
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select DEVFREQ_GOV_USERSPACE
+	select PM_DEVFREQ_EVENT
+	select PM_OPP
+	help
+	  This adds DEVFREQ driver for Exynos5422 DMC (Dynamic Memory Controller).
+	  The driver provides support for Dynamic Voltage and Frequency Scaling in
+	  DMC and DRAM. It also supports changing timings of DRAM running with
+	  different frequency.
+
 source "drivers/devfreq/event/Kconfig"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 32b8d4d..e3620ff 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 
 # DEVFREQ Drivers
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
+obj-$(CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ)	+= exynos5422-dmc.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
 
diff --git a/drivers/devfreq/exynos5422-dmc.c b/drivers/devfreq/exynos5422-dmc.c
new file mode 100644
index 0000000..0505a99
--- /dev/null
+++ b/drivers/devfreq/exynos5422-dmc.c
@@ -0,0 +1,1154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/devfreq.h>
+#include <linux/devfreq-event.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pm_opp.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#define EXYNOS5_DREXI_TIMINGAREF		(0x0030)
+#define EXYNOS5_DREXI_TIMINGROW0		(0x0034)
+#define EXYNOS5_DREXI_TIMINGDATA0		(0x0038)
+#define EXYNOS5_DREXI_TIMINGPOWER0		(0x003C)
+#define EXYNOS5_DREXI_TIMINGROW1		(0x00E4)
+#define EXYNOS5_DREXI_TIMINGDATA1		(0x00E8)
+#define EXYNOS5_DREXI_TIMINGPOWER1		(0x00EC)
+
+#define EXYNOS5_AREF_NORMAL			(0x2e)
+
+#define IS_MEM_2GB(val) \
+	(						\
+	 (((val) & 0xf0) & 0x20) ? 1 :			\
+		(((val) & 0xf0) & 0x30) ? 1 : 0		\
+	)
+
+#define EXYNOS5_POP_OPTIONS(val)	(((val >> 4) & 0x3UL) << 4)
+#define EXYNOS5_DDR_TYPE(val)		(((val >> 14) & 0x1UL))
+
+#define EXYNOS5_CHIP_PROD_ID		(0)
+#define EXYNOS5_CHIP_PKG_ID		(4)
+
+#define PPMU_PMCNT_CONST_RATIO_MUL	15
+#define PPMU_PMCNT_CONST_RATIO_DIV	10
+
+/**
+ * enum dmc_slot_id - An enum with slots in DMC
+ */
+enum dmc_slot_id {
+	DMC0_0,
+	DMC0_1,
+	DMC1_0,
+	DMC1_1,
+	DMC_SLOTS_END
+};
+
+/**
+ * struct dmc_slot_info - Describes DMC's slot
+ *
+ * The structure holds DMC's slot name which is part of the device name
+ * provided in DT. Each slot has particular share of the DMC bandwidth.
+ * To abstract the model performance and values in performance counters,
+ * fields 'ratio_mul' and 'ratio_div' are used in calculation algorithm
+ * for each slot. Please check the corresponding function with the algorithm,
+ * to see how these variables are used.
+ */
+struct dmc_slot_info {
+	char *name;
+	int id;
+	int ratio_mul;
+	int ratio_div;
+};
+
+/**
+ * struct dmc_opp_table - Operating level desciption
+ *
+ * Covers frequency and voltage settings of the DMC operating mode.
+ */
+struct dmc_opp_table {
+	u32 freq_hz;
+	u32 volt_uv;
+};
+
+/**
+ * struct exynos5_dmc - main structure describing DMC device
+ *
+ * The main structure for the Dynamic Memory Controller which covers clocks,
+ * memory regions, HW information, parameters and current operating mode.
+ */
+struct exynos5_dmc {
+	struct device *dev;
+	struct devfreq *df;
+	struct devfreq_simple_ondemand_data gov_data;
+	void __iomem *base_drexi0;
+	void __iomem *base_drexi1;
+	void __iomem *chip_id;
+	struct mutex lock;
+	unsigned long curr_rate;
+	unsigned long curr_volt;
+	struct dmc_opp_table *opp;
+	struct dmc_opp_table opp_bypass;
+	int opp_count;
+	u32 *timing_row;
+	u32 *timing_data;
+	u32 *timing_power;
+	u32 bypass_timing_row;
+	u32 bypass_timing_data;
+	u32 bypass_timing_power;
+	unsigned int prod_rev;
+	unsigned int pkg_rev;
+	unsigned int mem_info;
+	struct regulator *vdd_mif;
+	struct clk *fout_spll;
+	struct clk *fout_bpll;
+	struct clk *mout_spll;
+	struct clk *mout_bpll;
+	struct clk *mout_mclk_cdrex;
+	struct clk *dout_clk2x_phy0;
+	struct clk *mout_mx_mspll_ccore;
+	struct clk *mx_mspll_ccore_phy;
+	struct clk *mout_mx_mspll_ccore_phy;
+	struct clk *cdrex_pause;
+	struct clk *timing_set;
+	struct devfreq_event_dev **counter;
+	int num_counters;
+	bool counters_enabled;
+};
+
+/**
+ * exynos5_counters_fname() - Macro generating function for event devices
+ * @f:		function name suffix
+ *
+ * Macro which generates needed function for manipulation of event devices.
+ * It aims to avoid code duplication relaying on similar prefix and function
+ * parameters in the devfreq event device framework functions.
+ */
+#define exynos5_counters_fname(f)				\
+static int exynos5_counters_##f(struct exynos5_dmc *dmc)	\
+{								\
+	int i, ret;						\
+								\
+	for (i = 0; i < dmc->num_counters; i++) {		\
+		if (!dmc->counter[i])				\
+			continue;				\
+		ret = devfreq_event_##f(dmc->counter[i]);	\
+		if (ret < 0)					\
+			return ret;				\
+	}							\
+	return 0;						\
+}
+exynos5_counters_fname(set_event);
+exynos5_counters_fname(enable_edev);
+exynos5_counters_fname(disable_edev);
+
+/**
+ * dmc_slot - An array which holds DMC's slots information
+ *
+ * The array is used in algorithm calculating slots performance and usage
+ * based on performance counters' values. The values i.e. 15/10=1.5 correspond
+ * to slot share in the DMC channel, which has 2.0 abstract width.
+ */
+static const struct dmc_slot_info dmc_slot[] = {
+	{"dmc0_0", DMC0_0, 15, 10},
+	{"dmc0_1", DMC0_1, 5, 10},
+	{"dmc1_0", DMC1_0, 10, 10},
+	{"dmc1_1", DMC1_0, 10, 10},
+};
+
+/**
+ * find_target_freq_id() - Finds requested frequency in local DMC configuration
+ * @dmc:	device for which the information is checked
+ * @target_rate:	requested frequency in KHz
+ *
+ * Seeks in the local DMC driver structure for the requested frequency value
+ * and returns index or error value.
+ */
+static int find_target_freq_idx(struct exynos5_dmc *dmc,
+				unsigned long target_rate)
+{
+	int i;
+
+	for (i = dmc->opp_count - 1; i >= 0; i--)
+		if (dmc->opp[i].freq_hz <= target_rate)
+			return i;
+
+	return -EINVAL;
+}
+
+/**
+ * exynos5_dmc_chip_revision_settings() - Chooses proper DMC's configuration
+ * @dmc:	device for which is going to be checked and configured
+ *
+ * Function checks the HW product information in order to choose proper
+ * configuration for DMC frequency, voltage and DRAM timings.
+ */
+static int exynos5_dmc_chip_revision_settings(struct exynos5_dmc *dmc)
+{
+	unsigned int val;
+
+	val = readl(dmc->chip_id + EXYNOS5_CHIP_PROD_ID);
+	dmc->prod_rev = val;
+
+	val = readl(dmc->chip_id + EXYNOS5_CHIP_PKG_ID);
+	dmc->pkg_rev = val;
+
+	dmc->mem_info = EXYNOS5_POP_OPTIONS(val);
+	dmc->mem_info |= EXYNOS5_DDR_TYPE(val);
+
+	if (!IS_MEM_2GB(dmc->mem_info)) {
+		dev_warn(dmc->dev, "DRAM memory type not supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * exynos5_init_freq_table() - Initialized PM OPP framework
+ * @dev:	devfreq device for which the OPP table is going to be
+ *		initialized
+ * @dmc:	DMC device for which the frequencies are used for OPP init
+ * @profile:	devfreq device's profile
+ *
+ * Populate the devfreq device's OPP table based on current frequency, voltage.
+ */
+static int exynos5_init_freq_table(struct device *dev, struct exynos5_dmc *dmc,
+				   struct devfreq_dev_profile *profile)
+{
+	int i, ret;
+	int idx;
+	unsigned long freq;
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get OPP table\n");
+		return ret;
+	}
+
+	dmc->opp_count = dev_pm_opp_get_opp_count(dev);
+
+	dmc->opp = devm_kmalloc_array(dmc->dev, dmc->opp_count,
+				      sizeof(struct dmc_opp_table), GFP_KERNEL);
+	if (!dmc->opp)
+		goto err_opp;
+
+	idx = dmc->opp_count - 1;
+	for (i = 0, freq = ULONG_MAX; i < dmc->opp_count; i++, freq--) {
+		struct dev_pm_opp *opp;
+
+		opp = dev_pm_opp_find_freq_floor(dev, &freq);
+		if (IS_ERR(opp))
+			goto err_free_tables;
+
+		dmc->opp[idx - i].freq_hz = freq;
+		dmc->opp[idx - i].volt_uv = dev_pm_opp_get_voltage(opp);
+
+		dev_pm_opp_put(opp);
+	}
+
+	return 0;
+
+err_free_tables:
+	kfree(dmc->opp);
+err_opp:
+	dev_pm_opp_of_remove_table(dev);
+
+	return -EINVAL;
+}
+
+/**
+ * exynos5_set_bypass_dram_timings() - Low-level changes of the DRAM timings
+ * @dmc:	device for which the new settings is going to be applied
+ * @param:	DRAM parameters which passes timing data
+ *
+ * Low-level function for changing timings for DRAM memory clocking from
+ * 'bypass' clock source (fixed frequency @400MHz).
+ * It uses timing bank registers set 1.
+ */
+static void exynos5_set_bypass_dram_timings(struct exynos5_dmc *dmc)
+{
+	writel(EXYNOS5_AREF_NORMAL,
+	       dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGAREF);
+
+	writel(dmc->bypass_timing_row,
+	       dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGROW1);
+	writel(dmc->bypass_timing_row,
+	       dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGROW1);
+	writel(dmc->bypass_timing_data,
+	       dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGDATA1);
+	writel(dmc->bypass_timing_data,
+	       dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGDATA1);
+	writel(dmc->bypass_timing_power,
+	       dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGPOWER1);
+	writel(dmc->bypass_timing_power,
+	       dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGPOWER1);
+}
+
+/**
+ * exynos5_dram_change_timings() - Low-level changes of the DRAM final timings
+ * @dmc:	device for which the new settings is going to be applied
+ * @target_rate:	target frequency of the DMC
+ *
+ * Low-level function for changing timings for DRAM memory operating from main
+ * clock source (BPLL), which can have different frequencies. Thus, each
+ * frequency must have corresponding timings register values in order to keep
+ * the needed delays.
+ * It uses timing bank registers set 0.
+ */
+static int exynos5_dram_change_timings(struct exynos5_dmc *dmc,
+				       unsigned long target_rate)
+{
+	int idx;
+
+	for (idx = dmc->opp_count - 1; idx >= 0; idx--)
+		if (dmc->opp[idx].freq_hz <= target_rate)
+			break;
+
+	if (idx < 0)
+		return -EINVAL;
+
+	writel(EXYNOS5_AREF_NORMAL,
+	       dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGAREF);
+
+	writel(dmc->timing_row[idx],
+	       dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGROW0);
+	writel(dmc->timing_row[idx],
+	       dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGROW0);
+	writel(dmc->timing_data[idx],
+	       dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGDATA0);
+	writel(dmc->timing_data[idx],
+	       dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGDATA0);
+	writel(dmc->timing_power[idx],
+	       dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGPOWER0);
+	writel(dmc->timing_power[idx],
+	       dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGPOWER0);
+
+	return 0;
+}
+
+/**
+ * exynos5_dmc_align_target_voltage() - Sets the final voltage for the DMC
+ * @dmc:	device for which it is going to be set
+ * @target_volt:	new voltage which is chosen to be final
+ *
+ * Function tries to align voltage to the safe level for 'normal' mode.
+ * It checks the need of higher voltage and changes the value. The target
+ * voltage might be lower that currently set and still the system will be
+ * stable.
+ */
+static int exynos5_dmc_align_target_voltage(struct exynos5_dmc *dmc,
+					    unsigned long target_volt)
+{
+	int ret = 0;
+
+	if (dmc->curr_volt > target_volt) {
+		ret = regulator_set_voltage(dmc->vdd_mif, target_volt,
+					    target_volt);
+		if (!ret)
+			dmc->curr_volt = target_volt;
+	}
+
+	return ret;
+}
+
+/**
+ * exynos5_dmc_align_bypass_voltage() - Sets the voltage for the DMC
+ * @dmc:	device for which it is going to be set
+ * @target_volt:	new voltage which is chosen to be final
+ *
+ * Function tries to align voltage to the safe level for the 'bypass' mode.
+ * It checks the need of higher voltage and changes the value.
+ * The target voltage must not be less than currently needed, because
+ * for current frequency the device might become unstable.
+ */
+static int exynos5_dmc_align_bypass_voltage(struct exynos5_dmc *dmc,
+					    unsigned long target_volt)
+{
+	int ret = 0;
+	unsigned long bypass_volt = dmc->opp_bypass.volt_uv;
+
+	target_volt = max(bypass_volt, target_volt);
+
+	if (dmc->curr_volt >= target_volt)
+		return 0;
+
+	ret = regulator_set_voltage(dmc->vdd_mif, target_volt,
+				    target_volt);
+	if (!ret)
+		dmc->curr_volt = target_volt;
+
+	return ret;
+}
+
+/**
+ * exynos5_dmc_align_bypass_dram_timings() - Chooses and sets DRAM timings
+ * @dmc:	device for which it is going to be set
+ * @target_rate:	new frequency which is chosen to be final
+ *
+ * Function changes the DRAM timings for the temporary 'bypass' mode.
+ */
+static int exynos5_dmc_align_bypass_dram_timings(struct exynos5_dmc *dmc,
+						 unsigned long target_rate)
+{
+	int idx = find_target_freq_idx(dmc, target_rate);
+
+	if (idx < 0)
+		return -EINVAL;
+
+	exynos5_set_bypass_dram_timings(dmc);
+
+	return 0;
+}
+
+/**
+ * exynos5_dmc_switch_to_bypass_configuration() - Switching to temporary clock
+ * @dmc:	DMC device for which the switching is going to happen
+ * @target_rate:	new frequency which is going to be set as a final
+ * @target_volt:	new voltage which is going to be set as a final
+ *
+ * Function configures DMC and clocks for operating in temporary 'bypass' mode.
+ * This mode is used only temporary but if required, changes voltage and timings
+ * for DRAM chips. It switches the main clock to stable clock source for the
+ * period of the main PLL reconfiguration.
+ */
+static int exynos5_dmc_switch_to_bypass_configuration(struct exynos5_dmc *dmc,
+				   unsigned long target_rate,
+				   unsigned long target_volt)
+{
+	int ret;
+
+	/*
+	 * Having higher voltage for a particular frequency does not harm
+	 * the chip. Use it for the temporary frequency change when one
+	 * voltage manipulation might be avoided.
+	 */
+	ret = exynos5_dmc_align_bypass_voltage(dmc, target_volt);
+	if (ret)
+		return ret;
+
+	/*
+	 * Longer delays for DRAM does not cause crash, the opposite does.
+	 */
+	ret = exynos5_dmc_align_bypass_dram_timings(dmc, target_rate);
+	if (ret)
+		return ret;
+
+	clk_enable(dmc->timing_set);
+
+	/*
+	 * Voltage is set at least to a level needed for this frequency,
+	 * so switching clock source is safe now.
+	 */
+	clk_prepare_enable(dmc->fout_spll);
+	clk_prepare_enable(dmc->mout_spll);
+	clk_prepare_enable(dmc->mout_mx_mspll_ccore);
+
+	ret = clk_set_parent(dmc->mout_mclk_cdrex, dmc->mout_mx_mspll_ccore);
+
+	return ret;
+}
+
+/**
+ * exynos5_dmc_change_freq_and_volt() - Changes voltage and frequency of the DMC
+ * using safe procedure
+ * @dmc:	device for which the frequency is going to be changed
+ * @target_rate:	requested new frequency
+ * @target_volt:	requested voltage which corresponds to the new frequency
+ *
+ * The DMC frequency change procedure requires a few steps.
+ * The main requirement is to change the clock source in the clk mux
+ * for the time of main clock PLL locking. The assumption is that the
+ * alternative clock source set as parent is stable.
+ * The second parent's clock frequency is fixed to 400MHz, it is named 'bypass'
+ * clock. This requires alignment in DRAM timing parameters for the new
+ * T-period. There is two bank sets for keeping DRAM
+ * timings: set 0 and set 1. The set 0 is used when main clock source is
+ * chosen. The 2nd set of regs is used for 'bypass' clock. Switching between
+ * the two bank sets is part of the process.
+ * The voltage must also be aligned to the minimum required level. There is
+ * this intermediate step with switching to 'bypass' parent clock source.
+ * if the old voltage is lower, it requires an increase of the voltage level.
+ * The complexity of the voltage manipulation is hidden in low level function.
+ * In this function there is last alignment of the voltage level at the end.
+ */
+static int
+exynos5_dmc_change_freq_and_volt(struct exynos5_dmc *dmc,
+				 unsigned long target_rate,
+				 unsigned long target_volt)
+{
+	int ret;
+
+	ret = exynos5_dmc_switch_to_bypass_configuration(dmc, target_rate,
+							 target_volt);
+	if (ret)
+		return ret;
+
+	/* We are safe to increase the timings for current bypass frequency.
+	 * Thanks to this the settings we be ready for the upcoming clock source
+	 * change.
+	 */
+	exynos5_dram_change_timings(dmc, target_rate);
+
+	clk_set_rate(dmc->fout_bpll, target_rate);
+
+	clk_disable(dmc->timing_set);
+
+	ret = clk_set_parent(dmc->mout_mclk_cdrex, dmc->mout_bpll);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
+	clk_disable_unprepare(dmc->mout_spll);
+	clk_disable_unprepare(dmc->fout_spll);
+	/* Make sure if the voltage is not from 'bypass' settings and align to
+	 * the right level for power efficiency.
+	 */
+	ret = exynos5_dmc_align_target_voltage(dmc, target_volt);
+
+	return ret;
+}
+
+/**
+ * exynos5_dmc_get_volt_freq() - Gets the frequency and voltage from the OPP
+ * table.
+ * @dev:	device for which the frequency is going to be changed
+ * @freq:       requested frequency in KHz
+ * @target_rate:	returned frequency which is the same or lower than
+ *			requested
+ * @target_volt:	returned voltage which corresponds to the returned
+ *			frequency
+ *
+ * Function gets requested frequency and checks OPP framework for needed
+ * frequency and voltage. It populates the values 'target_rate' and
+ * 'target_volt' or returns error value when OPP framework fails.
+ */
+static int exynos5_dmc_get_volt_freq(struct device *dev, unsigned long *freq,
+				     unsigned long *target_rate,
+				     unsigned long *target_volt, u32 flags)
+{
+	struct dev_pm_opp *opp;
+
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	*target_rate = dev_pm_opp_get_freq(opp);
+	*target_volt = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
+
+	return 0;
+}
+
+/**
+ * exynos5_dmc_target() - Function responsible for changing frequency of DMC
+ * @dev:	device for which the frequency is going to be changed
+ * @freq:	requested frequency in KHz
+ * @flags:	flags provided for this frequency change request
+ *
+ * An entry function provided to the devfreq framework which provides frequency
+ * change of the DMC. The function gets the possible rate from OPP table based
+ * on requested frequency. It calls the next function responsible for the
+ * frequency and voltage change. In case of failure, does not set 'curr_rate'
+ * and returns error value to the framework.
+ */
+static int exynos5_dmc_target(struct device *dev, unsigned long *freq,
+			      u32 flags)
+{
+	struct exynos5_dmc *dmc = dev_get_drvdata(dev);
+	unsigned long target_rate = 0;
+	unsigned long target_volt = 0;
+	int ret;
+
+	ret = exynos5_dmc_get_volt_freq(dev, freq, &target_rate, &target_volt,
+					flags);
+	if (ret)
+		return ret;
+
+	if (target_rate == dmc->curr_rate)
+		return 0;
+
+	mutex_lock(&dmc->lock);
+
+	ret = exynos5_dmc_change_freq_and_volt(dmc, target_rate, target_volt);
+
+	if (ret) {
+		mutex_unlock(&dmc->lock);
+		return ret;
+	}
+
+	dmc->curr_rate = target_rate;
+
+	mutex_unlock(&dmc->lock);
+	return 0;
+}
+
+/**
+ * exynos5_cnt_name_match() - Tries to match 'edev' with the right device index
+ * @edev:       event device for which the name is going to be matched
+ *
+ * Function matches the name of the 'edev' counter device with known devices
+ * with configured ratios and shares of the DMC channels.
+ * When the name is matched, it returns the index for the proper device.
+ */
+static int exynos5_cnt_name_match(struct devfreq_event_dev *edev)
+{
+	int i;
+	int id = -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(dmc_slot); i++) {
+		if (strstr(edev->desc->name, dmc_slot[i].name))
+			return i;
+	}
+
+	return id;
+}
+
+/**
+ * exynos5_cnt_calculate() - Calculates the values of performance counters.
+ * @edev:	event device for which the counter is used for calculation
+ * @cnt:	raw counter value
+ * @cnt_norm:	counter value normalized to DMC performance ratio for a proper
+ *		channel or virtual channel
+ *
+ * Function calculates normalized value for the raw counter. The raw counter
+ * value does not show real channel usage. The DMC splits not equally the
+ * bandwidth for the channels. The function checks the type of the 'edev'
+ * counter and calculates the normalized value based on the 'shares' of the
+ * bandwidth set in the controller.
+ */
+static int exynos5_cnt_calculate(struct devfreq_event_dev *edev,
+				 unsigned long cnt, u64 *cnt_norm)
+{
+	int idx;
+
+	idx = exynos5_cnt_name_match(edev);
+	if (idx < 0)
+		return idx;
+
+	*cnt_norm = cnt;
+
+	if (!(dmc_slot[idx].ratio_mul == dmc_slot[idx].ratio_div)) {
+		*cnt_norm = *cnt_norm * dmc_slot[idx].ratio_mul;
+		*cnt_norm = div_u64(*cnt_norm, dmc_slot[idx].ratio_div);
+	}
+
+	*cnt_norm = *cnt_norm * PPMU_PMCNT_CONST_RATIO_MUL;
+	*cnt_norm = div_u64(*cnt_norm, PPMU_PMCNT_CONST_RATIO_DIV);
+
+	return idx;
+}
+
+/**
+ * exynos5_counters_get() - Gets the performance counters values.
+ * @dmc:	device for which the counters are going to be checked
+ * @load_count:	variable which is populated with counter value
+ * @total_count:	variable which is used as 'wall clock' reference
+ *
+ * Function which provides performance counters values. It sums up counters for
+ * two DMC channels. The 'total_count' is used as a reference and max value.
+ * The ratio 'load_count/total_count' shows the busy percentage [0%, 100%].
+ */
+static int exynos5_counters_get(struct exynos5_dmc *dmc,
+				unsigned long *load_count,
+				unsigned long *total_count)
+{
+	unsigned long load_dmc[2] = {0, 0};
+	unsigned long total = 0;
+	u64 load = 0;
+	struct devfreq_event_data event;
+	int ret, i, idx;
+
+	for (i = 0; i < dmc->num_counters; i++) {
+		if (!dmc->counter[i])
+			continue;
+
+		ret = devfreq_event_get_event(dmc->counter[i], &event);
+		if (ret < 0)
+			return ret;
+
+		idx = exynos5_cnt_calculate(dmc->counter[i], event.load_count,
+					    &load);
+		if (idx < 0)
+			continue;
+
+		if (idx == DMC0_0 || idx == DMC0_1)
+			load_dmc[0] += load;
+		else
+			load_dmc[1] += load;
+
+		if (total < event.total_count)
+			total = event.total_count;
+	}
+
+	*load_count = load_dmc[0] + load_dmc[1];
+	*total_count = total;
+
+	return 0;
+}
+
+/**
+ * exynos5_dmc_get_status() - Read current DMC performance statistics.
+ * @dev:	device for which the statistics are requested
+ * @stat:	structure which has statistic fields
+ *
+ * Function reads the DMC performance counters and calculates 'busy_time'
+ * and 'total_time'. To protect from overflow, the values are shifted right
+ * by 10. After read out the counters are setup to count again.
+ */
+static int exynos5_dmc_get_status(struct device *dev,
+				  struct devfreq_dev_status *stat)
+{
+	struct exynos5_dmc *dmc = dev_get_drvdata(dev);
+	unsigned long load, total;
+	int ret;
+	bool cnt_en;
+
+	mutex_lock(&dmc->lock);
+	cnt_en = dmc->counters_enabled;
+	mutex_unlock(&dmc->lock);
+	if (!cnt_en) {
+		dev_warn(dev, "performance counters needed, but not present\n");
+		return -EAGAIN;
+	}
+
+	ret = exynos5_counters_get(dmc, &load, &total);
+	if (ret < 0)
+		return -EINVAL;
+
+	/* To protect from overflow in calculation ratios, divide by 1024 */
+	stat->busy_time = load >> 10;
+	stat->total_time = total >> 10;
+
+	ret = exynos5_counters_set_event(dmc);
+	if (ret < 0) {
+		dev_err(dmc->dev, "could not set event counter\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * exynos5_dmc_get_cur_freq() - Function returns current DMC frequency
+ * @dev:	device for which the framework checks operating frequency
+ * @freq:	returned frequency value
+ *
+ * It returns the currently used frequency of the DMC. The real operating
+ * frequency might be lower when the clock source value could not be divided
+ * to the requested value.
+ */
+static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *freq)
+{
+	struct exynos5_dmc *dmc = dev_get_drvdata(dev);
+
+	mutex_lock(&dmc->lock);
+	*freq = dmc->curr_rate;
+	mutex_unlock(&dmc->lock);
+
+	return 0;
+}
+
+/**
+ * exynos5_dmc_df_profile - Devfreq governor's profile structure
+ *
+ * It provides to the devfreq framework needed functions and polling period.
+ */
+static struct devfreq_dev_profile exynos5_dmc_df_profile = {
+	.polling_ms = 500,
+	.target = exynos5_dmc_target,
+	.get_dev_status = exynos5_dmc_get_status,
+	.get_cur_freq = exynos5_dmc_get_cur_freq,
+};
+
+/**
+ * exynos5_dmc_align_initial_frequency() - Align initial frequency value
+ * @dmc:	device for which the frequency is going to be set
+ * @bootloader_init_freq:	initial frequency set by the bootloader in KHz
+ *
+ * The initial bootloader frequency, which is present during boot, might be
+ * different that supported frequency values in the driver. It is possible
+ * due to different PLL settings or used PLL as a source.
+ * This function provides the 'initial_freq' for the devfreq framework
+ * statistics engine which supports only registered values. Thus, some alignment
+ * must be made.
+ */
+unsigned long
+exynos5_dmc_align_init_freq(struct exynos5_dmc *dmc,
+			    unsigned long bootloader_init_freq)
+{
+	unsigned long aligned_freq;
+	int idx;
+
+	idx = find_target_freq_idx(dmc, bootloader_init_freq);
+	if (idx >= 0)
+		aligned_freq = dmc->opp[idx].freq_hz;
+	else
+		aligned_freq = dmc->opp[dmc->opp_count - 1].freq_hz;
+
+	return aligned_freq;
+}
+
+/**
+ * of_get_dram_timings() - helper function for parsing DT settings for DRAM
+ * @dmc:        device for which the frequency is going to be set
+ *
+ * The function parses DT entries with DRAM information.
+ */
+static int of_get_dram_timings(struct exynos5_dmc *dmc)
+{
+	int ret = 0;
+	int count;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "samsung,dram-timing");
+	if (!np)
+		return -EINVAL;
+
+	count = of_property_count_strings(np, "dram-timing-names");
+	if (count < 1)
+		return -EINVAL;
+
+	dmc->timing_row = devm_kmalloc_array(dmc->dev, count, sizeof(u32),
+					     GFP_KERNEL);
+	if (!dmc->timing_row)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "dram-timing-row",
+					 dmc->timing_row, count);
+
+	if (ret) {
+		dev_warn(dmc->dev, "failed parcing dram-timing-row\n");
+		return -EINVAL;
+	}
+
+	dmc->timing_data = devm_kmalloc_array(dmc->dev, count, sizeof(u32),
+					      GFP_KERNEL);
+	if (!dmc->timing_data)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "dram-timing-data",
+					 dmc->timing_data, count);
+	if (ret) {
+		dev_warn(dmc->dev, "failed parcing dram-timing-data\n");
+		return -EINVAL;
+	}
+
+	dmc->timing_power = devm_kmalloc_array(dmc->dev, count, sizeof(u32),
+					       GFP_KERNEL);
+	if (!dmc->timing_power)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "dram-timing-power",
+					 dmc->timing_power, count);
+	if (ret) {
+		dev_warn(dmc->dev, "failed parcing dram-timing-power\n");
+		return -EINVAL;
+	}
+
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL, "samsung,dmc-bypass-mode");
+	if (!np)
+		return -EINVAL;
+
+	ret = of_property_read_u32(np, "freq-hz",
+				   &dmc->opp_bypass.freq_hz);
+
+	ret |= of_property_read_u32(np, "volt-uv",
+				   &dmc->opp_bypass.volt_uv);
+
+	ret |= of_property_read_u32(np, "dram-timing-row",
+				   &dmc->bypass_timing_row);
+
+	ret |= of_property_read_u32(np, "dram-timing-data",
+				    &dmc->bypass_timing_data);
+
+	ret |= of_property_read_u32(np, "dram-timing-power",
+				    &dmc->bypass_timing_power);
+
+	of_node_put(np);
+
+	return ret;
+}
+
+/**
+ * exynos5_dmc_init_clks() - Initialize clocks needed for DMC operation.
+ * @dev:	device for which the clocks are setup
+ * @dmc:	DMC structure containing needed fields
+ *
+ * Get the needed clocks defined in DT device, enable and set the right parents.
+ * Read current frequency and initialize the initial rate for governor.
+ */
+static int exynos5_dmc_init_clks(struct device *dev, struct exynos5_dmc *dmc)
+{
+	int ret;
+	unsigned long target_volt = 0;
+	unsigned long target_rate = 0;
+
+	dmc->fout_spll = devm_clk_get(dev, "fout_spll");
+	if (IS_ERR(dmc->fout_spll))
+		return PTR_ERR(dmc->fout_spll);
+
+	dmc->fout_bpll = devm_clk_get(dev, "fout_bpll");
+	if (IS_ERR(dmc->fout_bpll))
+		return PTR_ERR(dmc->fout_bpll);
+
+	dmc->mout_mclk_cdrex = devm_clk_get(dev, "mout_mclk_cdrex");
+	if (IS_ERR(dmc->mout_mclk_cdrex))
+		return PTR_ERR(dmc->mout_mclk_cdrex);
+
+	dmc->mout_bpll = devm_clk_get(dev, "mout_bpll");
+	if (IS_ERR(dmc->mout_bpll))
+		return PTR_ERR(dmc->mout_bpll);
+
+	dmc->mout_mx_mspll_ccore = devm_clk_get(dev, "mout_mx_mspll_ccore");
+	if (IS_ERR(dmc->mout_mx_mspll_ccore))
+		return PTR_ERR(dmc->mout_mx_mspll_ccore);
+
+	dmc->dout_clk2x_phy0 = devm_clk_get(dev, "dout_clk2x_phy0");
+	if (IS_ERR(dmc->dout_clk2x_phy0))
+		return PTR_ERR(dmc->dout_clk2x_phy0);
+
+	dmc->mout_spll = devm_clk_get(dev, "ff_dout_spll2");
+	if (IS_ERR(dmc->mout_spll))
+		return PTR_ERR(dmc->mout_spll);
+
+	dmc->cdrex_pause = devm_clk_get(dev, "clk_cdrex_pause");
+	if (IS_ERR(dmc->cdrex_pause))
+		return PTR_ERR(dmc->cdrex_pause);
+
+	dmc->timing_set = devm_clk_get(dev, "clk_cdrex_timing_set");
+	if (IS_ERR(dmc->timing_set))
+		return PTR_ERR(dmc->timing_set);
+	/*
+	 * Convert frequency to KHz values and set it for the governor.
+	 */
+	dmc->curr_rate = clk_get_rate(dmc->mout_mclk_cdrex);
+	dmc->curr_rate = exynos5_dmc_align_init_freq(dmc, dmc->curr_rate);
+	exynos5_dmc_df_profile.initial_freq = dmc->curr_rate;
+
+	ret = exynos5_dmc_get_volt_freq(dev, &dmc->curr_rate, &target_rate,
+					&target_volt, 0);
+	if (ret)
+		return ret;
+
+	dmc->curr_volt = target_volt;
+
+	clk_prepare_enable(dmc->mout_spll);
+	clk_set_parent(dmc->mout_mx_mspll_ccore, dmc->mout_spll);
+	clk_prepare_enable(dmc->mout_mx_mspll_ccore);
+
+	clk_prepare_enable(dmc->fout_bpll);
+	clk_prepare_enable(dmc->mout_bpll);
+
+	clk_prepare_enable(dmc->cdrex_pause);
+	clk_prepare(dmc->timing_set);
+
+	return 0;
+}
+
+/**
+ * exynos5_performance_counters_init() - Initializes performance DMC's counters
+ * @dmc:	DMC for which it does the setup
+ *
+ * Initialization of performance counters in DMC for estimating usage.
+ * The counter's values are used for calculation of a memory bandwidth and based
+ * on that the governor changes the frequency.
+ * The counters are not used when the governor is GOVERNOR_USERSPACE.
+ */
+static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
+{
+	int counters_size;
+	int ret, i;
+
+	dmc->num_counters = devfreq_event_get_edev_count(dmc->dev);
+	if (dmc->num_counters < 0) {
+		dev_err(dmc->dev, "could not get devfreq-event counters\n");
+		return dmc->num_counters;
+	}
+
+	counters_size = sizeof(struct devfreq_event_dev) * dmc->num_counters;
+	dmc->counter = devm_kzalloc(dmc->dev, counters_size, GFP_KERNEL);
+	if (!dmc->counter)
+		return -ENOMEM;
+
+	for (i = 0; i < dmc->num_counters; i++) {
+		dmc->counter[i] =
+			devfreq_event_get_edev_by_phandle(dmc->dev, i);
+		if (IS_ERR_OR_NULL(dmc->counter[i]))
+			return -EPROBE_DEFER;
+	}
+
+	ret = exynos5_counters_enable_edev(dmc);
+	if (ret < 0) {
+		dev_err(dmc->dev, "could not enable event counter\n");
+		return ret;
+	}
+
+	ret = exynos5_counters_set_event(dmc);
+	if (ret < 0) {
+		dev_err(dmc->dev, "counld not set event counter\n");
+		return ret;
+	}
+
+	mutex_lock(&dmc->lock);
+	dmc->counters_enabled = true;
+	mutex_unlock(&dmc->lock);
+
+	return 0;
+}
+
+/**
+ * exynos5_dmc_probe() - Probe function for the DMC driver
+ * @pdev:	platform device for which the driver is going to be initialized
+ *
+ * Initialize basic components: clocks, regulators, performance counters, etc.
+ * Read out product version and based on the information setup
+ * internal structures for the controller (frequency and voltage) and for DRAM
+ * memory parameters: timings for each operating frequency.
+ * Register new devfreq device for controlling DVFS of the DMC.
+ */
+static int exynos5_dmc_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct exynos5_dmc *dmc;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
+	if (!dmc)
+		return -ENOMEM;
+
+	mutex_init(&dmc->lock);
+
+	dmc->dev = dev;
+	platform_set_drvdata(pdev, dmc);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dmc->base_drexi0 = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dmc->base_drexi0))
+		return PTR_ERR(dmc->base_drexi0);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	dmc->base_drexi1 = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dmc->base_drexi1))
+		return PTR_ERR(dmc->base_drexi1);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	dmc->chip_id = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dmc->chip_id))
+		return PTR_ERR(dmc->chip_id);
+
+	ret = exynos5_dmc_chip_revision_settings(dmc);
+	if (ret)
+		return ret;
+
+	ret = exynos5_init_freq_table(dev, dmc, &exynos5_dmc_df_profile);
+	if (ret)
+		return ret;
+
+	ret = of_get_dram_timings(dmc);
+	if (ret)
+		return ret;
+
+	dmc->vdd_mif = devm_regulator_get(dev, "vdd_mif");
+	if (IS_ERR(dmc->vdd_mif)) {
+		ret = PTR_ERR(dmc->vdd_mif);
+		dev_warn(dev, "couldn't get regulator\n");
+		return ret;
+	}
+
+	ret = exynos5_dmc_init_clks(dev, dmc);
+	if (ret) {
+		dev_warn(dev, "couldn't initialize clocks\n");
+		return ret;
+	}
+
+	ret = exynos5_performance_counters_init(dmc);
+	if (ret) {
+		dev_warn(dev, "couldn't probe performance counters\n");
+		goto remove_clocks;
+	}
+	/*
+	 * Setup default thresholds for the devfreq governor.
+	 * The values are chosen based on experiments.
+	 */
+	dmc->gov_data.upthreshold = 30;
+	dmc->gov_data.downdifferential = 5;
+
+	dmc->df = devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
+					  DEVFREQ_GOV_USERSPACE,
+					  &dmc->gov_data);
+
+	if (IS_ERR(dmc->df)) {
+		ret = PTR_ERR(dmc->df);
+		goto err_devfreq_add;
+	}
+
+	dev_info(&pdev->dev, "DMC init for prod_id=0x%08x pkg_id=0x%08x\n",
+		 dmc->prod_rev, dmc->pkg_rev);
+
+	return 0;
+
+err_devfreq_add:
+	exynos5_counters_disable_edev(dmc);
+remove_clocks:
+	clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
+	clk_disable_unprepare(dmc->mout_spll);
+
+	return ret;
+}
+
+/**
+ * exynos5_dmc_remove() - Remove function for the platform device
+ * @pdev:	platform device which is going to be removed
+ *
+ * The function relies on 'devm' framework function which automatically
+ * clean the device's resources. It just calls explicitly disable function for
+ * the performance counters.
+ */
+static int exynos5_dmc_remove(struct platform_device *pdev)
+{
+	struct exynos5_dmc *dmc = dev_get_drvdata(&pdev->dev);
+
+	exynos5_counters_disable_edev(dmc);
+
+	clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
+	clk_disable_unprepare(dmc->mout_spll);
+
+	dev_pm_opp_remove_table(&pdev->dev);
+
+	dev_info(&pdev->dev, "DMC removed\n");
+
+	return 0;
+}
+
+static const struct of_device_id exynos5_dmc_of_match[] = {
+	{ .compatible = "samsung,exynos5422-dmc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, exynos5_dmc_of_match);
+
+static struct platform_driver exynos5_dmc_platdrv = {
+	.probe	= exynos5_dmc_probe,
+	.remove = exynos5_dmc_remove,
+	.driver = {
+		.name	= "exynos5-dmc",
+		.of_match_table = exynos5_dmc_of_match,
+	},
+};
+module_platform_driver(exynos5_dmc_platdrv);
+MODULE_DESCRIPTION("Driver for Exynos5422 Dynamic Memory Controller dynamic frequency and voltage change"
+);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Samsung");
-- 
2.7.4

