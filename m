Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F13AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF3421901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfGVS04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:26:56 -0400
Received: from sauhun.de ([88.99.104.3]:43034 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfGVS0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:26:55 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 65BE34A148F;
        Mon, 22 Jul 2019 20:26:53 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: da9063: remove now unused platform_data
Date:   Mon, 22 Jul 2019 20:26:28 +0200
Message-Id: <20190722182628.7533-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All preparational patches have been applied, we can now remove the
include file for platform_data. Yiha!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/Kbuild                   |  1 -
 include/linux/mfd/da9063/pdata.h | 60 --------------------------------
 2 files changed, 61 deletions(-)
 delete mode 100644 include/linux/mfd/da9063/pdata.h

diff --git a/include/Kbuild b/include/Kbuild
index c38f0d46b267..68aa094fe86e 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -313,7 +313,6 @@ header-test-			+= linux/mfd/as3722.h
 header-test-			+= linux/mfd/cros_ec_commands.h
 header-test-			+= linux/mfd/da903x.h
 header-test-			+= linux/mfd/da9055/pdata.h
-header-test-			+= linux/mfd/da9063/pdata.h
 header-test-			+= linux/mfd/db8500-prcmu.h
 header-test-			+= linux/mfd/dbx500-prcmu.h
 header-test-			+= linux/mfd/dln2.h
diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
deleted file mode 100644
index 085edbf7601b..000000000000
--- a/include/linux/mfd/da9063/pdata.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Platform configuration options for DA9063
- *
- * Copyright 2012 Dialog Semiconductor Ltd.
- *
- * Author: Michal Hajduk, Dialog Semiconductor
- * Author: Krystian Garbaciak, Dialog Semiconductor
- */
-
-#ifndef __MFD_DA9063_PDATA_H__
-#define __MFD_DA9063_PDATA_H__
-
-/*
- * RGB LED configuration
- */
-/* LED IDs for flags in struct led_info. */
-enum {
-	DA9063_GPIO11_LED,
-	DA9063_GPIO14_LED,
-	DA9063_GPIO15_LED,
-
-	DA9063_LED_NUM
-};
-#define DA9063_LED_ID_MASK		0x3
-
-/* LED polarity for flags in struct led_info. */
-#define DA9063_LED_HIGH_LEVEL_ACTIVE	0x0
-#define DA9063_LED_LOW_LEVEL_ACTIVE	0x4
-
-
-/*
- * General PMIC configuration
- */
-/* HWMON ADC channels configuration */
-#define DA9063_FLG_FORCE_IN0_MANUAL_MODE	0x0010
-#define DA9063_FLG_FORCE_IN0_AUTO_MODE		0x0020
-#define DA9063_FLG_FORCE_IN1_MANUAL_MODE	0x0040
-#define DA9063_FLG_FORCE_IN1_AUTO_MODE		0x0080
-#define DA9063_FLG_FORCE_IN2_MANUAL_MODE	0x0100
-#define DA9063_FLG_FORCE_IN2_AUTO_MODE		0x0200
-#define DA9063_FLG_FORCE_IN3_MANUAL_MODE	0x0400
-#define DA9063_FLG_FORCE_IN3_AUTO_MODE		0x0800
-
-/* Disable register caching. */
-#define DA9063_FLG_NO_CACHE			0x0008
-
-struct da9063;
-
-/* DA9063 platform data */
-struct da9063_pdata {
-	int				(*init)(struct da9063 *da9063);
-	int				irq_base;
-	bool				key_power;
-	unsigned			flags;
-	struct da9063_regulators_pdata	*regulators_pdata;
-	struct led_platform_data	*leds_pdata;
-};
-
-#endif	/* __MFD_DA9063_PDATA_H__ */
-- 
2.20.1

