Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E36920830
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfCUOli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:41:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:1450 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCUOli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:41:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 07:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="157064212"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2019 07:41:23 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: intel_soc_pmic_bxtwc: Add device for the I2C master
Date:   Thu, 21 Mar 2019 17:41:22 +0300
Message-Id: <20190321144122.88484-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel WhiskeyCove PMIC has also I2C master interface that is
designed to be used for controlling a discrete battery
charger IC.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 03fe33882441..52885e2c0d85 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -84,6 +84,7 @@ enum bxtwc_irqs_adc {
 
 enum bxtwc_irqs_chgr {
 	BXTWC_USBC_IRQ = 0,
+	BXTWC_I2C_IRQ,
 	BXTWC_CHGR0_IRQ,
 	BXTWC_CHGR1_IRQ,
 };
@@ -121,7 +122,8 @@ static const struct regmap_irq bxtwc_regmap_irqs_adc[] = {
 
 static const struct regmap_irq bxtwc_regmap_irqs_chgr[] = {
 	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 0, 0x20),
-	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, 0x1f),
+	REGMAP_IRQ_REG(BXTWC_I2C_IRQ, 0, 0x0f),
+	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, 0x10),
 	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 1, 0x1f),
 };
 
@@ -208,6 +210,10 @@ static struct resource usbc_resources[] = {
 	DEFINE_RES_IRQ(BXTWC_USBC_IRQ),
 };
 
+static struct resource i2c_resources[] = {
+	DEFINE_RES_IRQ(BXTWC_I2C_IRQ),
+};
+
 static struct resource charger_resources[] = {
 	DEFINE_RES_IRQ_NAMED(BXTWC_CHGR0_IRQ, "CHARGER"),
 	DEFINE_RES_IRQ_NAMED(BXTWC_CHGR1_IRQ, "CHARGER1"),
@@ -241,6 +247,11 @@ static struct mfd_cell bxt_wc_dev[] = {
 		.num_resources = ARRAY_SIZE(usbc_resources),
 		.resources = usbc_resources,
 	},
+	{
+		.name = "bxt_wcove_i2c",
+		.num_resources = ARRAY_SIZE(i2c_resources),
+		.resources = i2c_resources,
+	},
 	{
 		.name = "bxt_wcove_ext_charger",
 		.num_resources = ARRAY_SIZE(charger_resources),
-- 
2.20.1

