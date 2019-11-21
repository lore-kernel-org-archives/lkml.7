Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BB2208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKUFCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:02:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:36442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfKUFCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:02:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13172B01C;
        Thu, 21 Nov 2019 05:02:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v5 5/9] irqchip: rtd1195-mux: Add RTD1195 definitions
Date:   Thu, 21 Nov 2019 06:02:04 +0100
Message-Id: <20191121050208.11324-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191121050208.11324-1-afaerber@suse.de>
References: <20191121050208.11324-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings and bit mappings for Realtek RTD1195 SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4 -> v5:
 * Mapped WDOG_NMI
 * Filled in irq_chip names
 
 v3 -> v4:
 * Use tabular formatting (Thomas)
 * Adopt different braces style (Thomas)
 * Updated with shortened isr_to_int_en_mask callback name (Thomas)
 * Renamed functions and variables from rtd119x_ to rtd1195_
 * Renamed enum values from RTD119X_ to RTD1195_
 
 v3: New
 
 drivers/irqchip/irq-rtd1195-mux.c | 104 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-rtd1195-mux.c b/drivers/irqchip/irq-rtd1195-mux.c
index 2f1bcfd9d5d6..e3e2e42d9df2 100644
--- a/drivers/irqchip/irq-rtd1195-mux.c
+++ b/drivers/irqchip/irq-rtd1195-mux.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Realtek RTD1295 IRQ mux
+ * Realtek RTD1195/RTD1295 IRQ mux
  *
  * Copyright (c) 2017-2019 Andreas Färber
  */
@@ -166,6 +166,82 @@ static const struct irq_domain_ops rtd1195_mux_irq_domain_ops = {
 	.map	= rtd1195_mux_irq_domain_map,
 };
 
+enum rtd1195_iso_isr_bits {
+	RTD1195_ISO_ISR_TC3_SHIFT		= 1,
+	RTD1195_ISO_ISR_UR0_SHIFT		= 2,
+	RTD1195_ISO_ISR_IRDA_SHIFT		= 5,
+	RTD1195_ISO_ISR_WDOG_NMI_SHIFT		= 7,
+	RTD1195_ISO_ISR_I2C0_SHIFT		= 8,
+	RTD1195_ISO_ISR_TC4_SHIFT		= 9,
+	RTD1195_ISO_ISR_I2C6_SHIFT		= 10,
+	RTD1195_ISO_ISR_RTC_HSEC_SHIFT		= 12,
+	RTD1195_ISO_ISR_RTC_ALARM_SHIFT		= 13,
+	RTD1195_ISO_ISR_VFD_WDONE_SHIFT		= 14,
+	RTD1195_ISO_ISR_VFD_ARDKPADA_SHIFT	= 15,
+	RTD1195_ISO_ISR_VFD_ARDKPADDA_SHIFT	= 16,
+	RTD1195_ISO_ISR_VFD_ARDSWA_SHIFT	= 17,
+	RTD1195_ISO_ISR_VFD_ARDSWDA_SHIFT	= 18,
+	RTD1195_ISO_ISR_GPIOA_SHIFT		= 19,
+	RTD1195_ISO_ISR_GPIODA_SHIFT		= 20,
+	RTD1195_ISO_ISR_CEC_SHIFT		= 22,
+};
+
+static const u32 rtd1195_iso_isr_to_scpu_int_en_mask[32] = {
+	[RTD1195_ISO_ISR_UR0_SHIFT]		= BIT(2),
+	[RTD1195_ISO_ISR_IRDA_SHIFT]		= BIT(5),
+	[RTD1195_ISO_ISR_I2C0_SHIFT]		= BIT(8),
+	[RTD1195_ISO_ISR_I2C6_SHIFT]		= BIT(10),
+	[RTD1195_ISO_ISR_RTC_HSEC_SHIFT]	= BIT(12),
+	[RTD1195_ISO_ISR_RTC_ALARM_SHIFT]	= BIT(13),
+	[RTD1195_ISO_ISR_VFD_WDONE_SHIFT]	= BIT(14),
+	[RTD1195_ISO_ISR_VFD_ARDKPADA_SHIFT]	= BIT(15),
+	[RTD1195_ISO_ISR_VFD_ARDKPADDA_SHIFT]	= BIT(16),
+	[RTD1195_ISO_ISR_VFD_ARDSWA_SHIFT]	= BIT(17),
+	[RTD1195_ISO_ISR_VFD_ARDSWDA_SHIFT]	= BIT(18),
+	[RTD1195_ISO_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1195_ISO_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1195_ISO_ISR_CEC_SHIFT]		= BIT(22),
+};
+
+enum rtd1195_misc_isr_bits {
+	RTD1195_MIS_ISR_WDOG_NMI_SHIFT		= 2,
+	RTD1195_MIS_ISR_UR1_SHIFT		= 3,
+	RTD1195_MIS_ISR_I2C1_SHIFT		= 4,
+	RTD1195_MIS_ISR_UR1_TO_SHIFT		= 5,
+	RTD1195_MIS_ISR_TC0_SHIFT		= 6,
+	RTD1195_MIS_ISR_TC1_SHIFT		= 7,
+	RTD1195_MIS_ISR_RTC_HSEC_SHIFT		= 9,
+	RTD1195_MIS_ISR_RTC_MIN_SHIFT		= 10,
+	RTD1195_MIS_ISR_RTC_HOUR_SHIFT		= 11,
+	RTD1195_MIS_ISR_RTC_DATE_SHIFT		= 12,
+	RTD1195_MIS_ISR_I2C5_SHIFT		= 14,
+	RTD1195_MIS_ISR_I2C4_SHIFT		= 15,
+	RTD1195_MIS_ISR_GPIOA_SHIFT		= 19,
+	RTD1195_MIS_ISR_GPIODA_SHIFT		= 20,
+	RTD1195_MIS_ISR_LSADC_SHIFT		= 21,
+	RTD1195_MIS_ISR_I2C3_SHIFT		= 23,
+	RTD1195_MIS_ISR_I2C2_SHIFT		= 26,
+	RTD1195_MIS_ISR_GSPI_SHIFT		= 27,
+};
+
+static const u32 rtd1195_misc_isr_to_scpu_int_en_mask[32] = {
+	[RTD1195_MIS_ISR_UR1_SHIFT]		= BIT(3),
+	[RTD1195_MIS_ISR_I2C1_SHIFT]		= BIT(4),
+	[RTD1195_MIS_ISR_UR1_TO_SHIFT]		= BIT(5),
+	[RTD1195_MIS_ISR_RTC_MIN_SHIFT]		= BIT(10),
+	[RTD1195_MIS_ISR_RTC_HOUR_SHIFT]	= BIT(11),
+	[RTD1195_MIS_ISR_RTC_DATE_SHIFT]	= BIT(12),
+	[RTD1195_MIS_ISR_I2C5_SHIFT]		= BIT(14),
+	[RTD1195_MIS_ISR_I2C4_SHIFT]		= BIT(15),
+	[RTD1195_MIS_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1195_MIS_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1195_MIS_ISR_LSADC_SHIFT]		= BIT(21),
+	[RTD1195_MIS_ISR_I2C2_SHIFT]		= BIT(26),
+	[RTD1195_MIS_ISR_GSPI_SHIFT]		= BIT(27),
+	[RTD1195_MIS_ISR_I2C3_SHIFT]		= BIT(28),
+	[RTD1195_MIS_ISR_WDOG_NMI_SHIFT]	= SCPU_INT_EN_NMI_MASK,
+};
+
 enum rtd1295_iso_isr_bits {
 	RTD1295_ISO_ISR_UR0_SHIFT		= 2,
 	RTD1295_ISO_ISR_IRDA_SHIFT		= 5,
@@ -238,6 +314,14 @@ static const u32 rtd1295_misc_isr_to_scpu_int_en_mask[32] = {
 	[RTD1295_MIS_ISR_WDOG_NMI_SHIFT]	= SCPU_INT_EN_NMI_MASK,
 };
 
+static const struct rtd1195_irq_mux_info rtd1195_iso_irq_mux_info = {
+	.name			= "iso",
+	.isr_offset		= 0x0,
+	.umsk_isr_offset	= 0x4,
+	.scpu_int_en_offset	= 0x40,
+	.isr_to_int_en_mask	= rtd1195_iso_isr_to_scpu_int_en_mask,
+};
+
 static const struct rtd1195_irq_mux_info rtd1295_iso_irq_mux_info = {
 	.name			= "iso",
 	.isr_offset		= 0x0,
@@ -246,6 +330,14 @@ static const struct rtd1195_irq_mux_info rtd1295_iso_irq_mux_info = {
 	.isr_to_int_en_mask	= rtd1295_iso_isr_to_scpu_int_en_mask,
 };
 
+static const struct rtd1195_irq_mux_info rtd1195_misc_irq_mux_info = {
+	.name			= "misc",
+	.umsk_isr_offset	= 0x8,
+	.isr_offset		= 0xc,
+	.scpu_int_en_offset	= 0x80,
+	.isr_to_int_en_mask	= rtd1195_misc_isr_to_scpu_int_en_mask,
+};
+
 static const struct rtd1195_irq_mux_info rtd1295_misc_irq_mux_info = {
 	.name			= "misc",
 	.umsk_isr_offset	= 0x8,
@@ -255,10 +347,18 @@ static const struct rtd1195_irq_mux_info rtd1295_misc_irq_mux_info = {
 };
 
 static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
+	{
+		.compatible = "realtek,rtd1195-iso-irq-mux",
+		.data = &rtd1195_iso_irq_mux_info,
+	},
 	{
 		.compatible = "realtek,rtd1295-iso-irq-mux",
 		.data = &rtd1295_iso_irq_mux_info,
 	},
+	{
+		.compatible = "realtek,rtd1195-misc-irq-mux",
+		.data = &rtd1195_misc_irq_mux_info,
+	},
 	{
 		.compatible = "realtek,rtd1295-misc-irq-mux",
 		.data = &rtd1295_misc_irq_mux_info,
@@ -323,5 +423,7 @@ static int __init rtd1195_irq_mux_init(struct device_node *node,
 
 	return 0;
 }
+IRQCHIP_DECLARE(rtd1195_iso_mux, "realtek,rtd1195-iso-irq-mux", rtd1195_irq_mux_init);
 IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd1195_irq_mux_init);
+IRQCHIP_DECLARE(rtd1195_misc_mux, "realtek,rtd1195-misc-irq-mux", rtd1195_irq_mux_init);
 IRQCHIP_DECLARE(rtd1295_misc_mux, "realtek,rtd1295-misc-irq-mux", rtd1195_irq_mux_init);
-- 
2.16.4

