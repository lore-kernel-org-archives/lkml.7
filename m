Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9D5C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99892068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfLCHpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:45:45 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39399 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfLCHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:45:44 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB37jQU0016032, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB37jQU0016032
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Dec 2019 15:45:26 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Dec 2019 15:45:25 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>,
        cylee12 <cylee12@realtek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 4/6] clk: realtek: add reset controller support for Realtek SoCs
Date:   Tue, 3 Dec 2019 15:45:11 +0800
Message-ID: <20191203074513.9416-5-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203074513.9416-1-james.tai@realtek.com>
References: <20191203074513.9416-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cylee12 <cylee12@realtek.com>

This patch add reset control support for Realtek SoCs.

Signed-off-by: Cheng-Yu Lee <cylee12@realtek.com>
Signed-off-by: James Tai <james.tai@realtek.com>
---
 drivers/clk/realtek/Kconfig  |   1 +
 drivers/clk/realtek/Makefile |   1 +
 drivers/clk/realtek/reset.c  | 107 +++++++++++++++++++++++++++++++++++
 drivers/clk/realtek/reset.h  |  37 ++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 drivers/clk/realtek/reset.c
 create mode 100644 drivers/clk/realtek/reset.h

diff --git a/drivers/clk/realtek/Kconfig b/drivers/clk/realtek/Kconfig
index 5bca757dddfa..8e7e7edf64dd 100644
--- a/drivers/clk/realtek/Kconfig
+++ b/drivers/clk/realtek/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config COMMON_CLK_REALTEK
 	bool "Clock driver for realtek"
+	select RESET_CONTROLLER
 	select MFD_SYSCON
 
 config CLK_PLL_PSAUD
diff --git a/drivers/clk/realtek/Makefile b/drivers/clk/realtek/Makefile
index 050d450db067..43f8bd71c0c8 100644
--- a/drivers/clk/realtek/Makefile
+++ b/drivers/clk/realtek/Makefile
@@ -7,3 +7,4 @@ clk-rtk-y += clk-regmap-gate.o
 clk-rtk-y += clk-pll.o
 clk-rtk-$(CONFIG_CLK_PLL_PSAUD) += clk-pll-psaud.o
 clk-rtk-$(CONFIG_CLK_PLL_DIF) += clk-pll-dif.o
+clk-rtk-y += reset.o
diff --git a/drivers/clk/realtek/reset.c b/drivers/clk/realtek/reset.c
new file mode 100644
index 000000000000..3f4d1a723b2a
--- /dev/null
+++ b/drivers/clk/realtek/reset.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Realtek Semiconductor Corporation
+ */
+
+#include <linux/of.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include "reset.h"
+
+static int rtk_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long idx)
+{
+	struct rtk_reset_data *data = to_rtk_reset_controller(rcdev);
+	struct rtk_reset_bank *bank = &data->banks[idx >> 8];
+	uint32_t id   = idx & 0xff;
+	uint32_t mask = bank->write_en ? (0x3 << id) : BIT(id);
+	uint32_t val  = bank->write_en ? (0x2 << id) : 0;
+
+	return regmap_update_bits(data->regmap, bank->ofs, mask, val);
+}
+
+static int rtk_reset_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long idx)
+{
+	struct rtk_reset_data *data = to_rtk_reset_controller(rcdev);
+	struct rtk_reset_bank *bank = &data->banks[idx >> 8];
+	uint32_t id   = idx & 0xff;
+	uint32_t mask = bank->write_en ? (0x3 << id) : BIT(id);
+	uint32_t val  = mask;
+
+	return regmap_update_bits(data->regmap, bank->ofs, mask, val);
+}
+
+static int rtk_reset_reset(struct reset_controller_dev *rcdev,
+			   unsigned long idx)
+{
+	int ret;
+
+	ret = rtk_reset_assert(rcdev, idx);
+	if (ret)
+		return ret;
+
+	return rtk_reset_deassert(rcdev, idx);
+}
+
+static int rtk_reset_status(struct reset_controller_dev *rcdev,
+			    unsigned long idx)
+{
+	struct rtk_reset_data *data = to_rtk_reset_controller(rcdev);
+	struct rtk_reset_bank *bank = &data->banks[idx >> 8];
+	uint32_t id = idx & 0xff;
+	uint32_t val;
+
+	regmap_read(data->regmap, bank->ofs, &val);
+	return !((val >> id) & 1);
+}
+
+static struct reset_control_ops rtk_reset_ops = {
+	.assert   = rtk_reset_assert,
+	.deassert = rtk_reset_deassert,
+	.reset    = rtk_reset_reset,
+	.status   = rtk_reset_status,
+};
+
+static int rtk_of_reset_xlate(struct reset_controller_dev *rcdev,
+			      const struct of_phandle_args *reset_spec)
+{
+	struct rtk_reset_data *data = to_rtk_reset_controller(rcdev);
+	int val;
+
+	val = reset_spec->args[0];
+	if (val >= rcdev->nr_resets)
+		return -EINVAL;
+
+	if (data->id_xlate)
+		return data->id_xlate(val);
+	return val;
+}
+
+
+int rtk_reset_controller_add(struct device *dev, struct regmap *regmap,
+			     struct rtk_reset_initdata *initdata)
+{
+	struct rtk_reset_data *data;
+	struct device_node *np = dev->of_node;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->regmap    = regmap;
+	data->num_banks = initdata->num_banks;
+	data->banks     = initdata->banks;
+	data->id_xlate  = initdata->id_xlate;
+
+	data->rcdev.owner     = THIS_MODULE;
+	data->rcdev.ops       = &rtk_reset_ops;
+	data->rcdev.of_node   = np;
+	data->rcdev.nr_resets = initdata->num_banks * 0x100;
+	data->rcdev.of_xlate  = rtk_of_reset_xlate;
+	data->rcdev.of_reset_n_cells = 1;
+
+	return reset_controller_register(&data->rcdev);
+}
+
diff --git a/drivers/clk/realtek/reset.h b/drivers/clk/realtek/reset.h
new file mode 100644
index 000000000000..f0cc7b1045ee
--- /dev/null
+++ b/drivers/clk/realtek/reset.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2019 Realtek Semiconductor Corporation
+ * Author: Cheng-Yu Lee <cylee12@realtek.com>
+ */
+
+#ifndef __CLK_REALTEK_RESET_H
+#define __CLK_REALTEK_RESET_H
+
+#include <linux/reset-controller.h>
+
+struct rtk_reset_bank {
+	uint32_t ofs;
+	uint32_t write_en;
+};
+
+struct rtk_reset_data {
+	struct reset_controller_dev rcdev;
+	struct rtk_reset_bank *banks;
+	uint32_t num_banks;
+	struct regmap *regmap;
+	unsigned long (*id_xlate)(unsigned long id);
+};
+
+#define to_rtk_reset_controller(r) \
+	container_of(r, struct rtk_reset_data, rcdev)
+
+struct rtk_reset_initdata {
+	struct rtk_reset_bank *banks;
+	uint32_t num_banks;
+	unsigned long (*id_xlate)(unsigned long id);
+};
+
+int rtk_reset_controller_add(struct device *dev, struct regmap *regmap,
+			     struct rtk_reset_initdata *initdata);
+
+#endif /* __CLK_REALTEK_RESET_H */
-- 
2.24.0

