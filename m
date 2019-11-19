Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60522C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E61022317
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKSCTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:19:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:58058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726952AbfKSCT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:19:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1869FB335;
        Tue, 19 Nov 2019 02:19:25 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v4 7/8] irqchip: rtd1195-mux: Add RTD1395 definitions
Date:   Tue, 19 Nov 2019 03:19:16 +0100
Message-Id: <20191119021917.15917-8-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191119021917.15917-1-afaerber@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings and bit mappings for Realtek RTD1395 SoC.

Based on BPI-M4-bsp linux-rtk/drivers/irqchip/irq-rtd139x.h.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v4: New
 
 drivers/irqchip/irq-rtd1195-mux.c | 83 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-rtd1195-mux.c b/drivers/irqchip/irq-rtd1195-mux.c
index 765d72653383..ad4b0ef3071b 100644
--- a/drivers/irqchip/irq-rtd1195-mux.c
+++ b/drivers/irqchip/irq-rtd1195-mux.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Realtek RTD1195/RTD1295 IRQ mux
+ * Realtek RTD1195/RTD1295/RTD1395 IRQ mux
  *
+ * Copyright (C) 2017 Realtek Semiconductor Corporation
  * Copyright (c) 2017-2019 Andreas Färber
  */
 
@@ -277,6 +278,62 @@ static const u32 rtd1295_misc_isr_to_scpu_int_en_mask[32] = {
 	[RTD1295_ISR_FAN_SHIFT]			= BIT(29),
 };
 
+enum rtd1395_iso_isr_bits {
+	RTD1395_ISO_ISR_UR0_SHIFT		= 2,
+	RTD1395_ISO_ISR_IRDA_SHIFT		= 5,
+	RTD1395_ISO_ISR_I2C0_SHIFT		= 8,
+	RTD1395_ISO_ISR_I2C1_SHIFT		= 11,
+	RTD1395_ISO_ISR_RTC_HSEC_SHIFT		= 12,
+	RTD1395_ISO_ISR_RTC_ALARM_SHIFT		= 13,
+	RTD1395_ISO_ISR_LSADC0_SHIFT		= 16,
+	RTD1395_ISO_ISR_LSADC1_SHIFT		= 17,
+	RTD1395_ISO_ISR_GPIOA_SHIFT		= 19,
+	RTD1395_ISO_ISR_GPIODA_SHIFT		= 20,
+	RTD1395_ISO_ISR_GPHY_HV_SHIFT		= 28,
+	RTD1395_ISO_ISR_GPHY_DV_SHIFT		= 29,
+	RTD1395_ISO_ISR_GPHY_AV_SHIFT		= 30,
+	RTD1395_ISO_ISR_I2C1_REQ_SHIFT		= 31,
+};
+
+static const u32 rtd1395_iso_isr_to_scpu_int_en_mask[32] = {
+	[RTD1395_ISO_ISR_UR0_SHIFT]		= BIT(2),
+	[RTD1395_ISO_ISR_IRDA_SHIFT]		= BIT(5),
+	[RTD1395_ISO_ISR_I2C0_SHIFT]		= BIT(8),
+	[RTD1395_ISO_ISR_I2C1_SHIFT]		= BIT(11),
+	[RTD1395_ISO_ISR_RTC_HSEC_SHIFT]	= BIT(12),
+	[RTD1395_ISO_ISR_RTC_ALARM_SHIFT]	= BIT(13),
+	[RTD1395_ISO_ISR_LSADC0_SHIFT]		= BIT(16),
+	[RTD1395_ISO_ISR_LSADC1_SHIFT]		= BIT(17),
+	[RTD1395_ISO_ISR_GPIOA_SHIFT]		= BIT(19),
+	[RTD1395_ISO_ISR_GPIODA_SHIFT]		= BIT(20),
+	[RTD1395_ISO_ISR_GPHY_HV_SHIFT]		= BIT(28),
+	[RTD1395_ISO_ISR_GPHY_DV_SHIFT]		= BIT(29),
+	[RTD1395_ISO_ISR_GPHY_AV_SHIFT]		= BIT(30),
+	[RTD1395_ISO_ISR_I2C1_REQ_SHIFT]	= BIT(31),
+};
+
+enum rtd1395_misc_isr_bits {
+	RTD1395_MISC_ISR_UR1_SHIFT		= 3,
+	RTD1395_MISC_ISR_UR1_TO_SHIFT		= 5,
+	RTD1395_MISC_ISR_UR2_SHIFT		= 8,
+	RTD1395_MISC_ISR_UR2_TO_SHIFT		= 13,
+	RTD1395_MISC_ISR_I2C5_SHIFT		= 14,
+	RTD1395_MISC_ISR_SC0_SHIFT		= 24,
+	RTD1395_MISC_ISR_SPI_SHIFT		= 27,
+	RTD1395_MISC_ISR_FAN_SHIFT		= 29,
+};
+
+static const u32 rtd1395_misc_isr_to_scpu_int_en_mask[32] = {
+	[RTD1395_MISC_ISR_UR1_SHIFT]		= BIT(3),
+	[RTD1395_MISC_ISR_UR1_TO_SHIFT]		= BIT(5),
+	[RTD1395_MISC_ISR_UR2_TO_SHIFT]		= BIT(6),
+	[RTD1395_MISC_ISR_UR2_SHIFT]		= BIT(7),
+	[RTD1395_MISC_ISR_I2C5_SHIFT]		= BIT(14),
+	[RTD1395_MISC_ISR_SC0_SHIFT]		= BIT(24),
+	[RTD1395_MISC_ISR_SPI_SHIFT]		= BIT(27),
+	[RTD1395_MISC_ISR_FAN_SHIFT]		= BIT(29),
+};
+
 static const struct rtd1195_irq_mux_info rtd1195_iso_irq_mux_info = {
 	.isr_offset		= 0x0,
 	.umsk_isr_offset	= 0x4,
@@ -291,6 +348,13 @@ static const struct rtd1195_irq_mux_info rtd1295_iso_irq_mux_info = {
 	.isr_to_int_en_mask	= rtd1295_iso_isr_to_scpu_int_en_mask,
 };
 
+static const struct rtd1195_irq_mux_info rtd1395_iso_irq_mux_info = {
+	.isr_offset		= 0x0,
+	.umsk_isr_offset	= 0x4,
+	.scpu_int_en_offset	= 0x40,
+	.isr_to_int_en_mask	= rtd1395_iso_isr_to_scpu_int_en_mask,
+};
+
 static const struct rtd1195_irq_mux_info rtd1195_misc_irq_mux_info = {
 	.umsk_isr_offset	= 0x8,
 	.isr_offset		= 0xc,
@@ -305,6 +369,13 @@ static const struct rtd1195_irq_mux_info rtd1295_misc_irq_mux_info = {
 	.isr_to_int_en_mask	= rtd1295_misc_isr_to_scpu_int_en_mask,
 };
 
+static const struct rtd1195_irq_mux_info rtd1395_misc_irq_mux_info = {
+	.umsk_isr_offset	= 0x8,
+	.isr_offset		= 0xc,
+	.scpu_int_en_offset	= 0x80,
+	.isr_to_int_en_mask	= rtd1395_misc_isr_to_scpu_int_en_mask,
+};
+
 static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
 	{
 		.compatible = "realtek,rtd1195-iso-irq-mux",
@@ -314,6 +385,10 @@ static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
 		.compatible = "realtek,rtd1295-iso-irq-mux",
 		.data = &rtd1295_iso_irq_mux_info,
 	},
+	{
+		.compatible = "realtek,rtd1395-iso-irq-mux",
+		.data = &rtd1395_iso_irq_mux_info,
+	},
 	{
 		.compatible = "realtek,rtd1195-misc-irq-mux",
 		.data = &rtd1195_misc_irq_mux_info,
@@ -322,6 +397,10 @@ static const struct of_device_id rtd1295_irq_mux_dt_matches[] = {
 		.compatible = "realtek,rtd1295-misc-irq-mux",
 		.data = &rtd1295_misc_irq_mux_info,
 	},
+	{
+		.compatible = "realtek,rtd1395-misc-irq-mux",
+		.data = &rtd1395_misc_irq_mux_info,
+	},
 	{
 	}
 };
@@ -378,5 +457,7 @@ static int __init rtd1195_irq_mux_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(rtd1195_iso_mux, "realtek,rtd1195-iso-irq-mux", rtd1195_irq_mux_init);
 IRQCHIP_DECLARE(rtd1295_iso_mux, "realtek,rtd1295-iso-irq-mux", rtd1195_irq_mux_init);
+IRQCHIP_DECLARE(rtd1395_iso_mux, "realtek,rtd1395-iso-irq-mux", rtd1195_irq_mux_init);
 IRQCHIP_DECLARE(rtd1195_misc_mux, "realtek,rtd1195-misc-irq-mux", rtd1195_irq_mux_init);
 IRQCHIP_DECLARE(rtd1295_misc_mux, "realtek,rtd1295-misc-irq-mux", rtd1195_irq_mux_init);
+IRQCHIP_DECLARE(rtd1395_misc_mux, "realtek,rtd1395-misc-irq-mux", rtd1195_irq_mux_init);
-- 
2.16.4

