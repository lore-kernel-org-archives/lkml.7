Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36FD2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wd/7cm64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfCYOYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:24:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52134 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:24:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2PEOX9k086486;
        Mon, 25 Mar 2019 09:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553523873;
        bh=2tNH029d2WgJzWvKk3HYEvryLXUNAiUtv4dumFwU0kA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Wd/7cm64JosFDXAMEfR8zgO1ch9Podhl0CkPnzkNS+m59E9VgJ7Czp7RRgzLZa0BW
         s4BpdOmBxNtBCUJjP1QOYiYElXC6sDzJ0FkGEF4QiJ1hKWzc62+2+EqqxChi2fO98o
         SEvtJqfBOX6t/HwGiNuHCk0BnJDqVbCxBlxFGG/4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2PEOXbA124705
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 09:24:33 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 09:24:33 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 09:24:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2PEOXBQ032259;
        Mon, 25 Mar 2019 09:24:33 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/5] leds: TI LMU: Add common code for TI LMU devices
Date:   Mon, 25 Mar 2019 09:24:00 -0500
Message-ID: <20190325142403.30447-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190325142403.30447-1-dmurphy@ti.com>
References: <20190325142403.30447-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a TI LMU common framework for TI LMU devices that share
common features.

Currently the runtime ramp and brightness setting have
been identified as common features with common register settings.

This work is derived from Milo Kims TI LMU MFD code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/Kconfig              |   8 ++
 drivers/leds/Makefile             |   1 +
 drivers/leds/ti-lmu-led-common.c  | 131 ++++++++++++++++++++++++++++++
 include/linux/ti-lmu-led-common.h |  44 ++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/leds/ti-lmu-led-common.c
 create mode 100644 include/linux/ti-lmu-led-common.h

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index da00b9ed5a5c..3ae24eaf4cde 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -776,6 +776,14 @@ config LEDS_NIC78BX
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-nic78bx.
 
+config LEDS_TI_LMU_COMMON
+	tristate "LED driver for TI LMU"
+	depends on REGMAP
+	help
+          Say Y to enable the LED driver for TI LMU devices.
+          This supports common features between the TI LM3532, LM3631, LM3632,
+	  LM3633, LM3695 and LM3697.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 7a8b1f55d459..85fd449c002d 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
+obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= ti-lmu-led-common.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_CR0014114)		+= leds-cr0014114.o
diff --git a/drivers/leds/ti-lmu-led-common.c b/drivers/leds/ti-lmu-led-common.c
new file mode 100644
index 000000000000..65d44bde9050
--- /dev/null
+++ b/drivers/leds/ti-lmu-led-common.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2015 Texas Instruments
+// Copyright 2018 Sebastian Reichel
+// Copyright 2018 Pavel Machek <pavel@ucw.cz>
+// TI LMU LED common framework, based on previous work from
+// Milo Kim <milo.kim@ti.com>
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/of_device.h>
+
+#include <linux/ti-lmu-led-common.h>
+
+const static int ramp_table[16] = { 2, 262, 524, 1049, 2090, 4194, 8389,
+				16780, 33550, 41940, 50330, 58720,
+				67110, 83880, 100660, 117440};
+
+static int ti_lmu_common_update_brightness(struct ti_lmu_bank *lmu_bank,
+					   int brightness)
+{
+	struct regmap *regmap = lmu_bank->regmap;
+	u8 reg, val;
+	int ret;
+
+	/*
+	 * Brightness register update
+	 *
+	 * 11 bit dimming: update LSB bits and write MSB byte.
+	 *		   MSB brightness should be shifted.
+	 *  8 bit dimming: write MSB byte.
+	 */
+	if (lmu_bank->max_brightness == MAX_BRIGHTNESS_11BIT) {
+		reg = lmu_bank->lsb_brightness_reg;
+		ret = regmap_update_bits(regmap, reg,
+					 LMU_11BIT_LSB_MASK,
+					 brightness);
+		if (ret)
+			return ret;
+
+		val = brightness >> LMU_11BIT_MSB_SHIFT;
+	} else {
+		val = brightness;
+	}
+
+	reg = lmu_bank->msb_brightness_reg;
+
+	return regmap_write(regmap, reg, val);
+}
+
+int ti_lmu_common_set_brightness(struct ti_lmu_bank *lmu_bank, int brightness)
+{
+	return ti_lmu_common_update_brightness(lmu_bank, brightness);
+}
+EXPORT_SYMBOL(ti_lmu_common_set_brightness);
+
+static int ti_lmu_common_convert_ramp_to_index(unsigned int msec)
+{
+	int size = ARRAY_SIZE(ramp_table);
+	int i;
+
+	if (msec <= ramp_table[0])
+		return 0;
+
+	if (msec > ramp_table[size - 1])
+		return size - 1;
+
+	for (i = 1; i < size; i++) {
+		if (msec == ramp_table[i])
+			return i;
+
+		/* Find an approximate index by looking up the table */
+		if (msec > ramp_table[i - 1] && msec < ramp_table[i]) {
+			if (msec - ramp_table[i - 1] < ramp_table[i] - msec)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+int ti_lmu_common_set_ramp(struct ti_lmu_bank *lmu_bank)
+{
+	struct regmap *regmap = lmu_bank->regmap;
+	u8 ramp, ramp_up, ramp_down;
+
+	if (lmu_bank->ramp_up_msec == 0 && lmu_bank->ramp_down_msec == 0) {
+		ramp_up = 0;
+		ramp_down = 0;
+	} else {
+		ramp_up = ti_lmu_common_convert_ramp_to_index(lmu_bank->ramp_up_msec);
+		ramp_down = ti_lmu_common_convert_ramp_to_index(lmu_bank->ramp_down_msec);
+	}
+
+	if (ramp_up < 0 || ramp_down < 0)
+		return -EINVAL;
+
+	ramp = (ramp_up << 4) | ramp_down;
+
+	return regmap_write(regmap, lmu_bank->runtime_ramp_reg, ramp);
+
+}
+EXPORT_SYMBOL(ti_lmu_common_set_ramp);
+
+int ti_lmu_common_get_ramp_params(struct device *dev,
+				  struct fwnode_handle *child,
+				  struct ti_lmu_bank *lmu_data)
+{
+	int ret;
+
+	ret = fwnode_property_read_u32(child, "ramp-up-ms",
+				 &lmu_data->ramp_up_msec);
+	if (ret)
+		dev_warn(dev, "ramp-up-ms property missing\n");
+
+
+	ret = fwnode_property_read_u32(child, "ramp-down-ms",
+				 &lmu_data->ramp_down_msec);
+	if (ret)
+		dev_warn(dev, "ramp-down-ms property missing\n");
+
+	return 0;
+}
+EXPORT_SYMBOL(ti_lmu_common_get_ramp_params);
+
+MODULE_DESCRIPTION("TI LMU common LED framework");
+MODULE_AUTHOR("Sebastian Reichel");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("ti-lmu-led-common");
diff --git a/include/linux/ti-lmu-led-common.h b/include/linux/ti-lmu-led-common.h
new file mode 100644
index 000000000000..510c07025117
--- /dev/null
+++ b/include/linux/ti-lmu-led-common.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// TI LMU Common Core
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#ifndef _TI_LMU_COMMON_H_
+#define _TI_LMU_COMMON_H_
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <uapi/linux/uleds.h>
+
+#define LMU_11BIT_LSB_MASK	(BIT(0) | BIT(1) | BIT(2))
+#define LMU_11BIT_MSB_SHIFT	3
+
+#define MAX_BRIGHTNESS_8BIT	255
+#define MAX_BRIGHTNESS_11BIT	2047
+
+struct ti_lmu_bank {
+	struct regmap *regmap;
+
+	int max_brightness;
+
+	u8 lsb_brightness_reg;
+	u8 msb_brightness_reg;
+
+	u8 runtime_ramp_reg;
+	u32 ramp_up_msec;
+	u32 ramp_down_msec;
+};
+
+int ti_lmu_common_set_brightness(struct ti_lmu_bank *lmu_bank, int brightness);
+
+int ti_lmu_common_set_ramp(struct ti_lmu_bank *lmu_bank);
+
+int ti_lmu_common_get_ramp_params(struct device *dev,
+				  struct fwnode_handle *child,
+				  struct ti_lmu_bank *lmu_data);
+
+#endif /* _TI_LMU_COMMON_H_ */
-- 
2.19.0

