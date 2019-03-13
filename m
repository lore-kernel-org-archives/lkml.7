Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A75C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F3C2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BkuOrRsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfCMTeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:34:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42164 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfCMTds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:33:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id o9so3290288wrv.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3q2Y8Ae5Q5aVEznQVZGdY0m0MoL10v1q/utHM3EnH4=;
        b=BkuOrRsgdNXQFNV+9veLeqf5YHkdAOMwLg3F+QcnTAoAKjOK8Jcntzg0iS7Vj7Im9+
         UWRnFFn6ihMl02P+XwJwFrtkF2ze5LXZyJejpVO6CRu9uJhaj3o0E+EPUM8Kmmehto16
         HdIkXVqgpzdEU+vZgAx7X45Dfs8F7aQ/DgoO0+/6hY/O4n21EWofls+kJJ2HsLp5tcI4
         coCa8SJyrUWi46hkklr+hTdaspmKgYm3rTZKgqLc75NHS/gJv36QVU23nA56hJyZQX/N
         5HJRxgcYcrH+jN6MR9IWikQEpNoKti9MpFT7OQANyjPpdgPM2w7ib3CxSyf3HxpRfzb+
         jSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3q2Y8Ae5Q5aVEznQVZGdY0m0MoL10v1q/utHM3EnH4=;
        b=fN69aKvESmaUGhIjiOc1U1U5GtMvGJiTxlqeAZBqH/sTFCzaIL4aLVDYSwRScdLpEl
         pM8IJ9B2LAxCWfEF7WPTmlSYvTSyVMspwLgHKgV2N5Vz5nNvsuj9L5IJye+mrjH+vr2t
         fD/Ig5EtJ0i33QxuZE6zV+aqRt7F0NbKpVeeKcgI5mbyAVbmY2bQ4Kfm1I6ICmeOh9G+
         RPhqES1TRoq8wJwdYiOM57svua5WFkAnVZdeD8rj9FkJGXxSXJCsJ5vSrwHmHIsUJ3Dl
         QWhCc4weYZyKKv7i5O68OknrqEN8e9jkLbq/s/q6Kk1yxyawPLRkLF74yJarqGzKdKOA
         XbfA==
X-Gm-Message-State: APjAAAWR841X3gkgO3e+BaDkygzYghWQqXKLixY72nE7dIQaPBLpgCW2
        AL9Nx37cZAPF9FKWimSB4mrKKg==
X-Google-Smtp-Source: APXvYqwjGo0j1Agl0Z7RcINl3l2dnjeam31Oium87w+TUqOqFHJVngwy4Z/1TML9GtI9rSUiH8wncg==
X-Received: by 2002:adf:9cc3:: with SMTP id h3mr27658602wre.47.1552505625104;
        Wed, 13 Mar 2019 12:33:45 -0700 (PDT)
Received: from localhost.localdomain (205.66.21.93.rev.sfr.net. [93.21.66.205])
        by smtp.gmail.com with ESMTPSA id z198sm3017497wmc.10.2019.03.13.12.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:33:44 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     linux-pm@vger.kernel.org, georgi.djakov@linaro.org
Cc:     mturquette@baylibre.com, ptitiano@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com,
        ccaione@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 1/3] drivers: interconnect: Add a driver for i.MX SoC
Date:   Wed, 13 Mar 2019 20:34:06 +0100
Message-Id: <20190313193408.23740-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support of i.MX SoC to interconnect framework.
This is based on busfreq, from NXP's tree.
This is is generic enough to be used to add support of interconnect
framework to any i.MX SoC, and, even, this could used for some other
SoC.
Thanks to interconnect framework, devices' driver request for
bandwidth which is use by busfreq to determine a performance level,
and then scale the frequency.
Busfreq platform drivers just have to registers interconnect nodes,
and OPPs.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/interconnect/Kconfig       |   1 +
 drivers/interconnect/Makefile      |   1 +
 drivers/interconnect/imx/Kconfig   |  13 +
 drivers/interconnect/imx/Makefile  |   1 +
 drivers/interconnect/imx/busfreq.c | 570 +++++++++++++++++++++++++++++
 drivers/interconnect/imx/busfreq.h | 123 +++++++
 6 files changed, 709 insertions(+)
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/busfreq.c
 create mode 100644 drivers/interconnect/imx/busfreq.h

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 07a8276fa35a..99955906bea8 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -11,5 +11,6 @@ menuconfig INTERCONNECT
 if INTERCONNECT
 
 source "drivers/interconnect/qcom/Kconfig"
+source "drivers/interconnect/imx/Kconfig"
 
 endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 28f2ab0824d5..20a13b7eb37f 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -4,3 +4,4 @@ icc-core-objs				:= core.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
+obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
new file mode 100644
index 000000000000..afd7b71bbd82
--- /dev/null
+++ b/drivers/interconnect/imx/Kconfig
@@ -0,0 +1,13 @@
+config INTERCONNECT_IMX
+	bool "i.MX interconnect drivers"
+	depends on ARCH_MXC || ARCH_MXC_ARM64 || COMPILE_TEST
+	help
+	  Support for i.MX interconnect hardware.
+
+config BUSFREQ
+	bool "busfreq interconnect driver"
+	depends on INTERCONNECT_IMX
+	help
+	  A generic interconnect driver that could be used for any i.MX.
+	  This provides a way to register master and slave and some opp
+	  to use when one or more master are in use.
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
new file mode 100644
index 000000000000..fea647183815
--- /dev/null
+++ b/drivers/interconnect/imx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_BUSFREQ) += busfreq.o
diff --git a/drivers/interconnect/imx/busfreq.c b/drivers/interconnect/imx/busfreq.c
new file mode 100644
index 000000000000..af461f788468
--- /dev/null
+++ b/drivers/interconnect/imx/busfreq.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+
+#include "busfreq.h"
+
+/*
+ * struct busfreq_opp_node - Describe the minimum bandwidth required by a node
+ * to enable the opp
+ * @icc_node: icc_node to test
+ * @min_avg_bw: minimum average bandwidth in kbps required to enable opp
+ * @min_peak_bw: minimum peak bandwidth in kbps required to enable opp
+ */
+struct busfreq_opp_node {
+	struct icc_node *icc_node;
+	u32 min_avg_bw;
+	u32 min_peak_bw;
+};
+
+/*
+ * struct busfreq_opp - Describe an opp
+ * This is used to configure multiple clock at once with the respect of
+ * hardware and performance requirements.
+ * @clks_count: number of clocks to configure
+ * @clks: array of clock
+ * @rates: array of rate, to apply for each clock when the opp is enabled
+ * @perf_level: Used to select the opp that would allow the lowest power
+ *              consumption when two or more opp satisfies the performances
+ *              requirements
+ * @node: entry in list of opp
+ * @nodes_count: number of opp node
+ * @nodes: array of opp node, to check node by node if opp satisfies the
+ *         the required performances
+ */
+struct busfreq_opp {
+	int clks_count;
+	struct clk **clks;
+	u64 *rates;
+	u32 perf_level;
+
+	struct list_head node;
+
+	int nodes_count;
+	struct busfreq_opp_node *nodes;
+};
+
+/*
+ * struct busfreq_icc_desc - Hold data required to control the interconnects
+ * @dev: device pointer for the overall interconnect
+ * @opps: list of opp
+ * @default_opp: the opp opp to use when the system is in special states
+ *               (boot, suspend, resume, shutdown)
+ * @current_opp: the opp currently in use
+ * @opp_locked: prevent opp to change while this is set
+ * @pm_notifier: used to set the default opp before suspend and
+ *               and select the best one after resume
+ * @pm_notifier: used to set the default opp before to reboot
+ */
+struct busfreq_icc_desc {
+	struct device *dev;
+
+	struct list_head opps;
+	struct busfreq_opp *default_opp;
+	struct busfreq_opp *current_opp;
+	bool opp_locked;
+
+	struct notifier_block pm_notifier;
+	struct notifier_block reboot_notifier;
+
+	struct mutex mutex;
+};
+
+static int busfreq_icc_aggregate(struct icc_node *node, u32 avg_bw,
+				  u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static int busfreq_set_opp_no_lock(struct busfreq_icc_desc *desc,
+				   struct busfreq_opp *requested_opp)
+{
+	int ret;
+	int i;
+
+	if (!requested_opp && !desc->default_opp)
+		return -EINVAL;
+
+	if (!requested_opp)
+		requested_opp = desc->default_opp;
+
+	if (desc->current_opp == requested_opp)
+		return 0;
+
+	if (desc->opp_locked)
+		return -EBUSY;
+
+	for (i = 0; i < requested_opp->clks_count; i++) {
+		ret = clk_set_rate(requested_opp->clks[i],
+				   requested_opp->rates[i]);
+		if (ret)
+			goto err;
+	}
+	desc->current_opp = requested_opp;
+
+	return 0;
+
+err:
+	dev_err(desc->dev, "Failed to set opp\n");
+	for (; i >= 0; i--)
+		clk_set_rate(desc->current_opp->clks[i],
+			     desc->current_opp->rates[i]);
+	return ret;
+}
+
+static int busfreq_set_opp(struct busfreq_icc_desc *desc,
+			   struct busfreq_opp *requested_opp)
+{
+	int ret;
+
+	mutex_lock(&desc->mutex);
+	ret = busfreq_set_opp_no_lock(desc, requested_opp);
+	mutex_unlock(&desc->mutex);
+
+	return ret;
+}
+
+static int busfreq_opp_bw_gt(struct busfreq_opp_node *opp_node,
+			      u32 avg_bw, u32 peak_bw)
+{
+	if (!opp_node)
+		return 0;
+	if (opp_node->min_avg_bw == BUSFREQ_UNDEFINED_BW) {
+		if (avg_bw)
+			return 2;
+		else
+			return 1;
+	}
+	if (opp_node->min_peak_bw == BUSFREQ_UNDEFINED_BW) {
+		if (peak_bw)
+			return 2;
+		else
+			return 1;
+	}
+	if (avg_bw >= opp_node->min_avg_bw)
+		return 1;
+	if (peak_bw >= opp_node->min_peak_bw)
+		return 1;
+	return 0;
+}
+
+static struct busfreq_opp *busfreq_cmp_bw_opp(struct busfreq_icc_desc *desc,
+					      struct busfreq_opp *opp1,
+					      struct busfreq_opp *opp2)
+{
+	int i;
+	int opp1_valid;
+	int opp2_valid;
+	int opp1_count = 0;
+	int opp2_count = 0;
+
+	if (!opp1 && !opp2)
+		return desc->current_opp;
+
+	if (!opp1)
+		return opp2;
+
+	if (!opp2)
+		return opp1;
+
+	if (opp1 == opp2)
+		return opp1;
+
+	for (i = 0; i < opp1->nodes_count; i++) {
+		struct busfreq_opp_node *opp_node1, *opp_node2;
+		struct icc_node *icc_node;
+		u32 avg_bw;
+		u32 peak_bw;
+
+		opp_node1 = &opp1->nodes[i];
+		opp_node2 = &opp2->nodes[i];
+		icc_node = opp_node1->icc_node;
+		avg_bw = icc_node->avg_bw;
+		peak_bw = icc_node->peak_bw;
+
+		opp1_valid = busfreq_opp_bw_gt(opp_node1, avg_bw, peak_bw);
+		opp2_valid = busfreq_opp_bw_gt(opp_node2, avg_bw, peak_bw);
+
+		if (opp1_valid == opp2_valid && opp1_valid == 1) {
+			if (opp_node1->min_avg_bw > opp_node2->min_avg_bw &&
+				opp_node1->min_avg_bw != BUSFREQ_UNDEFINED_BW)
+				opp1_valid++;
+			if (opp_node1->min_avg_bw < opp_node2->min_avg_bw &&
+				opp_node2->min_avg_bw != BUSFREQ_UNDEFINED_BW)
+				opp2_valid++;
+		}
+
+		opp1_count += opp1_valid;
+		opp2_count += opp2_valid;
+	}
+
+	if (opp1_count > opp2_count)
+		return opp1;
+	if (opp1_count < opp2_count)
+		return opp2;
+	return opp1->perf_level >= opp2->perf_level ? opp2 : opp1;
+}
+
+static int busfreq_set_best_opp(struct busfreq_icc_desc *desc)
+{
+	struct busfreq_opp *opp, *best_opp = desc->current_opp;
+
+	list_for_each_entry(opp, &desc->opps, node)
+		best_opp = busfreq_cmp_bw_opp(desc, opp, best_opp);
+	return busfreq_set_opp(desc, best_opp);
+}
+
+static int busfreq_set_locked_opp(struct busfreq_icc_desc *desc,
+				  struct busfreq_opp *requested_opp)
+{
+	int ret;
+
+	mutex_lock(&desc->mutex);
+	ret = busfreq_set_opp_no_lock(desc, requested_opp);
+	if (ret)
+		goto err;
+	desc->opp_locked = true;
+err:
+	mutex_unlock(&desc->mutex);
+
+	return ret;
+}
+
+static int busfreq_unlock_opp(struct busfreq_icc_desc *desc)
+{
+	mutex_lock(&desc->mutex);
+	desc->opp_locked = false;
+	mutex_unlock(&desc->mutex);
+
+	return busfreq_set_best_opp(desc);
+}
+
+static int busfreq_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct busfreq_icc_desc *desc = src->provider->data;
+
+	if (!dst->num_links)
+		return busfreq_set_best_opp(desc);
+
+	return 0;
+}
+
+static int busfreq_pm_notify(struct notifier_block *nb, unsigned long event,
+			     void *ptr)
+{
+	struct busfreq_icc_desc *desc;
+
+	desc = container_of(nb, struct busfreq_icc_desc, pm_notifier);
+	if (event == PM_SUSPEND_PREPARE)
+		busfreq_set_locked_opp(desc, desc->default_opp);
+	else if (event == PM_POST_SUSPEND)
+		busfreq_unlock_opp(desc);
+
+	return NOTIFY_OK;
+}
+
+static int busfreq_reboot_notify(struct notifier_block *nb, unsigned long event,
+				 void *ptr)
+{
+	struct busfreq_icc_desc *desc;
+
+	desc = container_of(nb, struct busfreq_icc_desc, reboot_notifier);
+	busfreq_set_locked_opp(desc, desc->default_opp);
+
+	return NOTIFY_OK;
+}
+
+static struct icc_node *busfreq_icc_node_add(struct icc_provider *provider,
+					     int id, const char *name)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct device *dev = desc->dev;
+	struct icc_node *icc_node;
+
+	icc_node = icc_node_create(id);
+	if (IS_ERR(icc_node)) {
+		dev_err(dev, "Failed to create node %d\n", id);
+		return icc_node;
+	}
+
+	if (icc_node->data)
+		return icc_node;
+
+	icc_node->name = name;
+	icc_node->data = &icc_node;
+	icc_node_add(icc_node, provider);
+
+	return icc_node;
+}
+
+static struct icc_node *busfreq_icc_node_get(struct icc_provider *provider,
+					     int id)
+{
+	return busfreq_icc_node_add(provider, id, NULL);
+}
+
+static void busfreq_unregister_nodes(struct icc_provider *provider)
+{
+	struct icc_node *icc_node, *tmp;
+
+	list_for_each_entry_safe(icc_node, tmp, &provider->nodes, node_list)
+		icc_node_destroy(icc_node->id);
+}
+
+static int busfreq_register_nodes(struct icc_provider *provider,
+				  struct busfreq_icc_node *busfreq_nodes,
+				  int count)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		struct icc_node *icc_node;
+		size_t j;
+
+		icc_node = busfreq_icc_node_add(provider,
+						busfreq_nodes[i].id,
+						busfreq_nodes[i].name);
+		if (IS_ERR(icc_node)) {
+			ret = PTR_ERR(icc_node);
+			goto err;
+		}
+
+		for (j = 0; j < busfreq_nodes[i].num_links; j++)
+			icc_link_create(icc_node, busfreq_nodes[i].links[j]);
+	}
+
+	return 0;
+
+err:
+	busfreq_unregister_nodes(provider);
+
+	return ret;
+}
+
+static struct busfreq_opp *busfreq_opp_alloc(struct icc_provider *provider,
+					     int count)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct device *dev = desc->dev;
+	struct busfreq_opp *opp;
+	struct icc_node *icc_node;
+
+	opp = devm_kzalloc(dev, sizeof(*opp), GFP_KERNEL);
+	if (!opp)
+		return ERR_PTR(-ENOMEM);
+
+	opp->clks_count = count;
+	opp->clks = devm_kzalloc(dev, sizeof(struct clk *) * count, GFP_KERNEL);
+	if (!opp->clks)
+		return ERR_PTR(-ENOMEM);
+
+	opp->rates = devm_kzalloc(dev, sizeof(u64) * count, GFP_KERNEL);
+	if (!opp->rates)
+		return ERR_PTR(-ENOMEM);
+
+	count = 0;
+	list_for_each_entry(icc_node, &provider->nodes, node_list)
+		count++;
+
+	opp->nodes = devm_kzalloc(dev, sizeof(*opp->nodes) * count, GFP_KERNEL);
+	if (!opp->nodes)
+		return ERR_PTR(-ENOMEM);
+	opp->nodes_count = count;
+
+	return opp;
+}
+
+static int busfreq_init_opp(struct icc_provider *provider,
+			    struct busfreq_opp *opp,
+			    struct busfreq_plat_opp *plat_opp)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct device *dev = desc->dev;
+	struct busfreq_opp_node *node;
+	struct icc_node *icc_node;
+	int i, j;
+
+	opp->perf_level = 0;
+	for (i = 0; i < opp->clks_count; i++) {
+		opp->clks[i] = devm_clk_get(dev, plat_opp->clks[i].name);
+		if (IS_ERR(opp->clks[i])) {
+			dev_err(dev, "Failed to get clock %s\n",
+				plat_opp->clks[i].name);
+			return PTR_ERR(opp->clks[i]);
+		}
+		opp->rates[i] = plat_opp->clks[i].rate;
+		opp->perf_level += opp->rates[i] >> 10;
+	}
+
+	i = 0;
+	list_for_each_entry(icc_node, &provider->nodes, node_list) {
+		node = &opp->nodes[i++];
+		node->icc_node = icc_node;
+	}
+
+	for (i = 0; i < plat_opp->nodes_count; i++) {
+		icc_node = busfreq_icc_node_get(provider,
+						plat_opp->nodes[i].id);
+		if (IS_ERR_OR_NULL(icc_node))
+			return -EINVAL;
+
+		for (j = 0, node = &opp->nodes[j]; j < opp->nodes_count;
+			j++, node = &opp->nodes[j]) {
+			if (node->icc_node == icc_node) {
+				node->min_avg_bw = BUSFREQ_UNDEFINED_BW;
+				node->min_peak_bw = BUSFREQ_UNDEFINED_BW;
+			}
+		}
+	}
+
+	INIT_LIST_HEAD(&opp->node);
+
+	return 0;
+}
+
+static int busfreq_register_opps(struct device *dev,
+				 struct icc_provider *provider,
+				 struct busfreq_plat_opp *busfreq_opps,
+				 int count)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct busfreq_opp *opp;
+	int ret;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		opp = busfreq_opp_alloc(provider, busfreq_opps[i].clks_count);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+
+		ret = busfreq_init_opp(provider, opp, &busfreq_opps[i]);
+		if (ret)
+			return ret;
+
+		if (busfreq_opps[i].default_opp)
+			desc->default_opp = opp;
+
+		list_add(&opp->node, &desc->opps);
+	}
+
+	return 0;
+}
+
+static void busfreq_unregister_opps(struct icc_provider *provider)
+{
+	struct busfreq_icc_desc *desc = provider->data;
+	struct device *dev = desc->dev;
+	struct busfreq_opp *opp, *tmp_opp;
+
+	list_for_each_entry_safe(opp, tmp_opp, &desc->opps, node) {
+		list_del(&opp->node);
+		devm_kfree(dev, opp->nodes);
+		devm_kfree(dev, opp->clks);
+		devm_kfree(dev, opp->rates);
+		devm_kfree(dev, opp);
+	}
+}
+
+int busfreq_register(struct platform_device *pdev,
+		     struct busfreq_icc_node *busfreq_nodes, int nodes_count,
+		     struct busfreq_plat_opp *busfreq_opps, int opps_count)
+{
+	struct device *dev = &pdev->dev;
+	struct busfreq_icc_desc *desc;
+	struct icc_provider *provider;
+	int ret;
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+	desc->dev = dev;
+	mutex_init(&desc->mutex);
+	INIT_LIST_HEAD(&desc->opps);
+
+	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
+	if (!provider)
+		return -ENOMEM;
+	provider->set = busfreq_icc_set;
+	provider->aggregate = busfreq_icc_aggregate;
+	provider->data = desc;
+	platform_set_drvdata(pdev, provider);
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(dev, "error adding interconnect provider\n");
+		return ret;
+	}
+
+	ret = busfreq_register_nodes(provider, busfreq_nodes, nodes_count);
+	if (ret) {
+		dev_err(dev, "error adding interconnect nodes\n");
+		goto provider_del;
+	}
+
+	ret = busfreq_register_opps(dev, provider, busfreq_opps, opps_count);
+	if (ret) {
+		dev_err(dev, "error adding busfreq opp\n");
+		goto unregister_nodes;
+	}
+
+	ret = busfreq_set_opp(desc, desc->default_opp);
+	if (ret)
+		goto unregister_opps;
+
+	desc->pm_notifier.notifier_call = busfreq_pm_notify;
+	register_pm_notifier(&desc->pm_notifier);
+
+	desc->reboot_notifier.notifier_call = busfreq_reboot_notify;
+	register_reboot_notifier(&desc->reboot_notifier);
+
+	return 0;
+
+unregister_opps:
+	busfreq_unregister_opps(provider);
+unregister_nodes:
+	busfreq_unregister_nodes(provider);
+provider_del:
+	icc_provider_del(provider);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(busfreq_register);
+
+int busfreq_unregister(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+	struct busfreq_icc_desc *desc = provider->data;
+	int ret;
+
+	unregister_reboot_notifier(&desc->reboot_notifier);
+	unregister_pm_notifier(&desc->pm_notifier);
+
+	ret = busfreq_set_opp(desc, desc->default_opp);
+	if (ret)
+		return ret;
+
+	icc_provider_del(provider);
+
+	busfreq_unregister_opps(provider);
+	busfreq_unregister_nodes(provider);
+	devm_kfree(&pdev->dev, desc);
+	devm_kfree(&pdev->dev, provider);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(busfreq_unregister);
diff --git a/drivers/interconnect/imx/busfreq.h b/drivers/interconnect/imx/busfreq.h
new file mode 100644
index 000000000000..a60481f10500
--- /dev/null
+++ b/drivers/interconnect/imx/busfreq.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+#ifndef __BUSFREQ_H
+#define __BUSFREQ_H
+
+#include <linux/kernel.h>
+
+#define BUSFREQ_MAX_LINKS	32
+#define BUSFREQ_UNDEFINED_BW	0xffffffff
+
+/*
+ * struct busfreq_icc_node - Describe an interconnect node
+ * @name: name of the node
+ * @id: an unique id to identify the node
+ * @links: an array of slaves' node id
+ * @num_links: number of id defined in links
+ */
+struct busfreq_icc_node {
+	char *name;
+	u16 id;
+	u16 links[BUSFREQ_MAX_LINKS];
+	u16 num_links;
+};
+
+/*
+ * struct busfreq_opp_clk - Clock name and rate to set for an opp
+ * @name: name of clock
+ * @rate: the rate to set when the opp is enabled
+ */
+struct busfreq_opp_clk {
+	char *name;
+	unsigned long rate;
+};
+
+/*
+ * struct busfreq_opp_bw - Describe a condition to meet to enable an opp
+ * @id: id of the node to test
+ * @avg_bw: minimum average bandwidth required to enable the opp, or
+ *          ignored if set to BUSFREQ_UNDEFINED_BW
+ * @peak_bw: minimum peak bandwidth required to enable the opp, or
+ *           ignored if set to BUSFREQ_UNDEFINED_BW
+ */
+struct busfreq_opp_bw {
+	u16 id;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+/*
+ * struct busfreq_plat_opp - Describe an opp to register in busfreq
+ * @clks: array of clocks to configure when the opp is enable
+ * @clks_count: number of clocks
+ * @nodes: array of opp nodes (condition to meet for each node to enable opp)
+ * @nodes_count: number of nodes
+ * @default_opp: use this opp as default opp if true
+ */
+struct busfreq_plat_opp {
+	struct busfreq_opp_clk *clks;
+	int clks_count;
+	struct busfreq_opp_bw *nodes;
+	int nodes_count;
+	bool default_opp;
+};
+
+#define DEFINE_BUS_INTERCONNECT(_name, _id, _numlinks, ...)	\
+	{							\
+		.id = _id,					\
+		.name = _name,					\
+		.num_links = _numlinks,				\
+		.links = { __VA_ARGS__ },			\
+	}
+
+#define DEFINE_BUS_MASTER(_name, _id, _dest_id)			\
+	DEFINE_BUS_INTERCONNECT(_name, _id, 1, _dest_id)
+
+#define DEFINE_BUS_SLAVE(_name, _id)				\
+	DEFINE_BUS_INTERCONNECT(_name, _id, 0)
+
+#define DEFINE_OPP_CLOCK(_name, _rate)				\
+	{							\
+		.name = _name,					\
+		.rate = _rate,					\
+	}
+
+#define DEFINE_OPP_BW(_id, _avg, _peak)				\
+	{							\
+		.id = _id,					\
+		.avg_bw = _avg,					\
+		.peak_bw = _peak,				\
+	}
+
+#define DEFINE_OPP_NODE(_id)					\
+	DEFINE_OPP_BW(_id, BUSFREQ_UNDEFINED_BW, BUSFREQ_UNDEFINED_BW)
+
+#define DEFINE_OPP(_clks, _nodes, _default)				\
+	{							\
+		.clks = _clks,					\
+		.clks_count = ARRAY_SIZE(_clks),		\
+		.nodes = _nodes,				\
+		.nodes_count = ARRAY_SIZE(_nodes),		\
+		.default_opp = _default,			\
+	}
+
+#define DEFINE_OPP_NO_NODES(_clks, _default)				\
+	{							\
+		.clks = _clks,					\
+		.clks_count = ARRAY_SIZE(_clks),		\
+		.nodes = NULL,					\
+		.nodes_count = 0,				\
+		.default_opp = _default,			\
+	}
+
+int busfreq_register(struct platform_device *pdev,
+		     struct busfreq_icc_node *busfreq_nodes, int nodes_count,
+		     struct busfreq_plat_opp *busfreq_opps, int opps_count);
+int busfreq_unregister(struct platform_device *pdev);
+
+#endif /* __BUSFREQ_H */
-- 
2.19.2

