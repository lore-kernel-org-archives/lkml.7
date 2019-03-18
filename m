Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C313C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4042820872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfCRPtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:49:06 -0400
Received: from sauhun.de ([88.99.104.3]:36852 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfCRPtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:49:00 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id 85F474A134A;
        Mon, 18 Mar 2019 16:48:58 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 4/6] regulator: da9063: move definitions out of a header into the driver
Date:   Mon, 18 Mar 2019 16:47:56 +0100
Message-Id: <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those definitions are only used within the driver meanwhile, so put them
there.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/regulator/da9063-regulator.c | 44 +++++++++++++++++++++++++++++++-
 include/linux/mfd/da9063/pdata.h     | 49 ------------------------------------
 2 files changed, 43 insertions(+), 50 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 73c85039d0cf..c05859ad63d8 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -25,7 +25,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/mfd/da9063/core.h>
-#include <linux/mfd/da9063/pdata.h>
 #include <linux/mfd/da9063/registers.h>
 
 
@@ -34,6 +33,49 @@
 	REG_FIELD(_reg, __builtin_ffs((int)_mask) - 1, \
 		sizeof(unsigned int) * 8 - __builtin_clz((_mask)) - 1)
 
+/* DA9063 and DA9063L regulator IDs */
+enum {
+	/* BUCKs */
+	DA9063_ID_BCORE1,
+	DA9063_ID_BCORE2,
+	DA9063_ID_BPRO,
+	DA9063_ID_BMEM,
+	DA9063_ID_BIO,
+	DA9063_ID_BPERI,
+
+	/* BCORE1 and BCORE2 in merged mode */
+	DA9063_ID_BCORES_MERGED,
+	/* BMEM and BIO in merged mode */
+	DA9063_ID_BMEM_BIO_MERGED,
+	/* When two BUCKs are merged, they cannot be reused separately */
+
+	/* LDOs on both DA9063 and DA9063L */
+	DA9063_ID_LDO3,
+	DA9063_ID_LDO7,
+	DA9063_ID_LDO8,
+	DA9063_ID_LDO9,
+	DA9063_ID_LDO11,
+
+	/* DA9063-only LDOs */
+	DA9063_ID_LDO1,
+	DA9063_ID_LDO2,
+	DA9063_ID_LDO4,
+	DA9063_ID_LDO5,
+	DA9063_ID_LDO6,
+	DA9063_ID_LDO10,
+};
+
+/* Old regulator platform data */
+struct da9063_regulator_data {
+	int				id;
+	struct regulator_init_data	*initdata;
+};
+
+struct da9063_regulators_pdata {
+	unsigned int			n_regulators;
+	struct da9063_regulator_data	*regulator_data;
+};
+
 /* Regulator capabilities and registers description */
 struct da9063_regulator_info {
 	struct regulator_desc desc;
diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
index 50bed4f89c1a..21a2d107f0cf 100644
--- a/include/linux/mfd/da9063/pdata.h
+++ b/include/linux/mfd/da9063/pdata.h
@@ -16,55 +16,6 @@
 #ifndef __MFD_DA9063_PDATA_H__
 #define __MFD_DA9063_PDATA_H__
 
-#include <linux/regulator/machine.h>
-
-/*
- * Regulator configuration
- */
-/* DA9063 and DA9063L regulator IDs */
-enum {
-	/* BUCKs */
-	DA9063_ID_BCORE1,
-	DA9063_ID_BCORE2,
-	DA9063_ID_BPRO,
-	DA9063_ID_BMEM,
-	DA9063_ID_BIO,
-	DA9063_ID_BPERI,
-
-	/* BCORE1 and BCORE2 in merged mode */
-	DA9063_ID_BCORES_MERGED,
-	/* BMEM and BIO in merged mode */
-	DA9063_ID_BMEM_BIO_MERGED,
-	/* When two BUCKs are merged, they cannot be reused separately */
-
-	/* LDOs on both DA9063 and DA9063L */
-	DA9063_ID_LDO3,
-	DA9063_ID_LDO7,
-	DA9063_ID_LDO8,
-	DA9063_ID_LDO9,
-	DA9063_ID_LDO11,
-
-	/* DA9063-only LDOs */
-	DA9063_ID_LDO1,
-	DA9063_ID_LDO2,
-	DA9063_ID_LDO4,
-	DA9063_ID_LDO5,
-	DA9063_ID_LDO6,
-	DA9063_ID_LDO10,
-};
-
-/* Regulators platform data */
-struct da9063_regulator_data {
-	int				id;
-	struct regulator_init_data	*initdata;
-};
-
-struct da9063_regulators_pdata {
-	unsigned			n_regulators;
-	struct da9063_regulator_data	*regulator_data;
-};
-
-
 /*
  * RGB LED configuration
  */
-- 
2.11.0

