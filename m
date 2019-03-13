Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A115C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AC12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uhcsbeBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCMTdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:33:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33784 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfCMTdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:33:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id i8so3326259wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WBXmNn4StehscAZZnU0MKJI6NK9pgoT630krc3+Cgo=;
        b=uhcsbeBKnXhIbnOvppqkS8/0labsp64fSUsjAwd7QoW11Ivv+oDnXaIlKdBiFxf5k8
         15FhTnv68UInDqeQ3DtFvluM6SqgK5FSVrFx4ryqFwdBJQa//9E6wwjStgsDtO6Ty63a
         os/BoqWc8fh7IcP8l3p82xTBYPOJAUrRUIOZtaMelx/J7N1F7frH8RGJar5VJb5ezG/d
         xJrbNb61i/T6bRSu8If7dFoen8JjFhkKMSI0MAF+GZJj3XDZERUPlJ5pGuGdTlBILdzU
         3F/1cu8nJGyTfy04WlP0bxKk4GZV94WdTuaA7LGmw1JWSgkB7s88Z6d0i8Yd35IyuD3T
         wf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WBXmNn4StehscAZZnU0MKJI6NK9pgoT630krc3+Cgo=;
        b=VfGywIlWeYZksVmZnjkMDLt8SmCPNKeoiXESN4+w2wKsnn5oTh174hHKdcGQt6lyiu
         VguEvSrqp8wPwLkhbmWdzzor7Lg8qnc+1N1gl6rSccFth38Nef3kAv6f3aQa56xR8ZaN
         L4NIWBoGkQoFmtnPwWGiNPb1M5fV2bUqQ6OD6U6vVeOAX7t0eXMRybnr/NH60AURWaOK
         u+ZFVHMN2r2ZUw2reaKq84cKR6FnlbZz6gXXhxWLsXfFV+yE+RC1f8OqA3tw6VQ3qBmo
         MJJPDXfZ+Ph+29/RuLqc0dNJIwyGNs/incyAgxAKVcBlMvEyWcch/3JaAoW7N6vLc/+P
         27vQ==
X-Gm-Message-State: APjAAAUa9iKO3gPw4NPi8LTIxl0+p20KWPa4t3Y4Z5UlQDS+zG6k15Z1
        PRK19b6ZJq1OkFKXmuAl4W4jpw==
X-Google-Smtp-Source: APXvYqxxzjnP/Lp48jWJ/5p35pfgJXrELFTsCqpMsATR/Jg6stAepm24Xs6LM+WJ9eZbLF8o/T5mIw==
X-Received: by 2002:a5d:4583:: with SMTP id p3mr14261835wrq.114.1552505626654;
        Wed, 13 Mar 2019 12:33:46 -0700 (PDT)
Received: from localhost.localdomain (205.66.21.93.rev.sfr.net. [93.21.66.205])
        by smtp.gmail.com with ESMTPSA id z198sm3017497wmc.10.2019.03.13.12.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:33:45 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     linux-pm@vger.kernel.org, georgi.djakov@linaro.org
Cc:     mturquette@baylibre.com, ptitiano@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com,
        ccaione@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 2/3] drivers: interconnect: imx: Add support of i.MX8MM
Date:   Wed, 13 Mar 2019 20:34:07 +0100
Message-Id: <20190313193408.23740-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a platform driver for the i.MX8MM SoC.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/interconnect/imx/Kconfig          |   4 +
 drivers/interconnect/imx/Makefile         |   1 +
 drivers/interconnect/imx/busfreq-imx8mm.c | 132 ++++++++++++++++++++++
 include/dt-bindings/interconnect/imx8mm.h |  37 ++++++
 4 files changed, 174 insertions(+)
 create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h

diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
index afd7b71bbd82..b569d40e5ca0 100644
--- a/drivers/interconnect/imx/Kconfig
+++ b/drivers/interconnect/imx/Kconfig
@@ -11,3 +11,7 @@ config BUSFREQ
 	  A generic interconnect driver that could be used for any i.MX.
 	  This provides a way to register master and slave and some opp
 	  to use when one or more master are in use.
+
+config BUSFREQ_IMX8MM
+	bool "i.MX8MM busfreq driver"
+	depends on BUSFREQ
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
index fea647183815..a92fea6e042d 100644
--- a/drivers/interconnect/imx/Makefile
+++ b/drivers/interconnect/imx/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_BUSFREQ) += busfreq.o
+obj-$(CONFIG_BUSFREQ_IMX8MM) += busfreq-imx8mm.o
diff --git a/drivers/interconnect/imx/busfreq-imx8mm.c b/drivers/interconnect/imx/busfreq-imx8mm.c
new file mode 100644
index 000000000000..c3b10a49dc29
--- /dev/null
+++ b/drivers/interconnect/imx/busfreq-imx8mm.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/interconnect/imx8mm.h>
+
+#include "busfreq.h"
+
+static struct busfreq_icc_node imx8mm_icc_nodes[] = {
+	/* NOC */
+	DEFINE_BUS_MASTER("A53-0", IMX8MM_CPU_0, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("A53-1", IMX8MM_CPU_1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("A53-2", IMX8MM_CPU_2, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("A53-3", IMX8MM_CPU_3, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("VPU H1", IMX8MM_VPU_H1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("VPU G1", IMX8MM_VPU_G1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("VPU G2", IMX8MM_VPU_G2, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("MIPI", IMX8MM_MIPI, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("USB-1", IMX8MM_USB_1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("USB-2", IMX8MM_USB_1, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("GPU", IMX8MM_GPU, IMX8MM_NOC),
+	DEFINE_BUS_MASTER("PCIE", IMX8MM_PCIE, IMX8MM_NOC),
+	DEFINE_BUS_SLAVE("DRAM", IMX8MM_DRAM),
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_NOC, 1, IMX8MM_DRAM),
+
+	/* PL301 */
+	DEFINE_BUS_MASTER("SAI-1", IMX8MM_SAI1, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-2", IMX8MM_SAI2, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-3", IMX8MM_SAI3, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-4", IMX8MM_SAI4, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-5", IMX8MM_SAI5, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SAI-6", IMX8MM_SAI6, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("SPDIF", IMX8MM_SPDIF, IMX8MM_PL301),
+	DEFINE_BUS_MASTER("FEC", IMX8MM_FEC, IMX8MM_PL301),
+	DEFINE_BUS_INTERCONNECT("PL301", IMX8MM_PL301, 1, IMX8MM_NOC),
+};
+
+static struct busfreq_opp_clk imx8mm_low_freq_clks[] = {
+	DEFINE_OPP_CLOCK("dram-alt", 100000000),
+	DEFINE_OPP_CLOCK("dram-apb", 40000000),
+	DEFINE_OPP_CLOCK("dram-core", 25000000),
+	DEFINE_OPP_CLOCK("noc", 150000000),
+	DEFINE_OPP_CLOCK("ahb", 22222222),
+	DEFINE_OPP_CLOCK("axi", 24000000),
+};
+
+static struct busfreq_opp_clk imx8mm_audio_freq_clks[] = {
+	DEFINE_OPP_CLOCK("dram-alt", 400000000),
+	DEFINE_OPP_CLOCK("dram-apb", 40000000),
+	DEFINE_OPP_CLOCK("dram-core", 100000000),
+	DEFINE_OPP_CLOCK("noc", 150000000),
+	DEFINE_OPP_CLOCK("ahb", 22222222),
+	DEFINE_OPP_CLOCK("axi", 24000000),
+};
+
+static struct busfreq_opp_bw imx8mm_audio_freq_nodes[] = {
+	DEFINE_OPP_NODE(IMX8MM_SAI1),
+	DEFINE_OPP_NODE(IMX8MM_SAI2),
+	DEFINE_OPP_NODE(IMX8MM_SAI3),
+	DEFINE_OPP_NODE(IMX8MM_SAI4),
+	DEFINE_OPP_NODE(IMX8MM_SAI5),
+	DEFINE_OPP_NODE(IMX8MM_SAI6),
+	DEFINE_OPP_NODE(IMX8MM_SPDIF),
+};
+
+static struct busfreq_opp_clk imx8mm_high_freq_clks[] = {
+	DEFINE_OPP_CLOCK("dram-apb", 800000000),
+	DEFINE_OPP_CLOCK("dram-core", 750000000),
+	DEFINE_OPP_CLOCK("noc", 750000000),
+	DEFINE_OPP_CLOCK("ahb", 133333333),
+	DEFINE_OPP_CLOCK("axi", 333000000),
+};
+
+static struct busfreq_opp_bw imx8mm_high_freq_nodes[] = {
+	DEFINE_OPP_NODE(IMX8MM_SAI1),
+	DEFINE_OPP_NODE(IMX8MM_SAI2),
+	DEFINE_OPP_NODE(IMX8MM_SAI3),
+	DEFINE_OPP_NODE(IMX8MM_SAI4),
+	DEFINE_OPP_NODE(IMX8MM_SAI5),
+	DEFINE_OPP_NODE(IMX8MM_SAI6),
+	DEFINE_OPP_NODE(IMX8MM_SPDIF),
+	DEFINE_OPP_NODE(IMX8MM_MIPI),
+};
+
+static struct busfreq_plat_opp imx8mm_opps[] = {
+	DEFINE_OPP_NO_NODES(imx8mm_low_freq_clks, false),
+	DEFINE_OPP(imx8mm_audio_freq_clks, imx8mm_audio_freq_nodes, false),
+	DEFINE_OPP(imx8mm_high_freq_clks, imx8mm_high_freq_nodes, true),
+};
+
+static int imx8mm_busfreq_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = busfreq_register(pdev, imx8mm_icc_nodes,
+			       ARRAY_SIZE(imx8mm_icc_nodes),
+			       imx8mm_opps, ARRAY_SIZE(imx8mm_opps));
+	return ret;
+}
+
+static int imx8mm_busfreq_remove(struct platform_device *pdev)
+{
+	return busfreq_unregister(pdev);
+}
+
+static const struct of_device_id busfreq_of_match[] = {
+	{ .compatible = "fsl,busfreq-imx8mm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, busfreq_of_match);
+
+static struct platform_driver imx8mm_busfreq_driver = {
+	.probe = imx8mm_busfreq_probe,
+	.remove = imx8mm_busfreq_remove,
+	.driver = {
+		.name = "busfreq-imx8mm",
+		.of_match_table = busfreq_of_match,
+	},
+};
+
+builtin_platform_driver(imx8mm_busfreq_driver);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/interconnect/imx8mm.h b/include/dt-bindings/interconnect/imx8mm.h
new file mode 100644
index 000000000000..4318ed319edc
--- /dev/null
+++ b/include/dt-bindings/interconnect/imx8mm.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework driver for i.MX SoC
+ *
+ * Copyright (c) 2019, BayLibre
+ * Author: Alexandre Bailon <abailon@baylibre.com>
+ */
+
+#ifndef __IMX8MM_INTERCONNECT_IDS_H
+#define __IMX8MM_INTERCONNECT_IDS_H
+
+#define IMX8MM_NOC	0
+#define IMX8MM_CPU_0	1
+#define IMX8MM_CPU_1	2
+#define IMX8MM_CPU_2	3
+#define IMX8MM_CPU_3	4
+#define IMX8MM_VPU_H1	5
+#define IMX8MM_VPU_G1	6
+#define IMX8MM_VPU_G2	7
+#define IMX8MM_MIPI	8
+#define IMX8MM_USB_1	9
+#define IMX8MM_USB_2	10
+#define IMX8MM_PCIE	11
+#define IMX8MM_GPU	12
+#define IMX8MM_DRAM	13
+
+#define IMX8MM_PL301	100
+#define IMX8MM_SAI1	101
+#define IMX8MM_SAI2	102
+#define IMX8MM_SAI3	103
+#define IMX8MM_SAI4	104
+#define IMX8MM_SAI5	105
+#define IMX8MM_SAI6	106
+#define IMX8MM_SPDIF	107
+#define IMX8MM_FEC	108
+
+#endif /* __IMX8MM_INTERCONNECT_IDS_H */
-- 
2.19.2

