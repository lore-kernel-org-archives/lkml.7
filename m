Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337B0C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCA624659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFMRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:17:33 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:17684 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLFMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:17:31 -0500
Received: from localhost.localdomain (10.28.8.19) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 6 Dec 2019
 20:17:50 +0800
From:   Qianggui Song <qianggui.song@amlogic.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
CC:     Qianggui Song <qianggui.song@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>
Subject: [PATCH 3/4] irqchip/meson-gpio: Add support for meson a1 SoCs
Date:   Fri, 6 Dec 2019 20:17:12 +0800
Message-ID: <20191206121714.14579-4-qianggui.song@amlogic.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206121714.14579-1-qianggui.song@amlogic.com>
References: <20191206121714.14579-1-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.19]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson a1 Socs have some changes compared with previous chips. For
A113L, it contains 62 pins and can be spied on:

- 62:128 undefined
- 61:50 12 pins on bank A
- 49:37 13 pins on bank F
- 36:20 17 pins on bank X
- 19:13 7  pins on bank B
- 12:0  13 pins on bank P

There are five relative registers for gpio interrupt controller, details
are as below:

- PADCTRL_GPIO_IRQ_CTRL0
  bit[31]:    enable/disable the whole irq lines
  bit[16-23]: both edge trigger
  bit[8-15]:  single edge trigger
  bit[0-7]:   pol trigger

- PADCTRL_GPIO_IRQ_CTRL[X]
  bit[0-6]:   7 bits to choose gpio source for irq line 2*[X] - 2
  bit[16-22]: 7 bits to choose gpio source for irq line 2*[X] - 1
  where X =1,2,3,4

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
---
 drivers/irqchip/irq-meson-gpio.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 1824ffc30de2..8478100706a6 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -40,6 +40,9 @@
 #define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
 #define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
 
+/* Below is used for Meson-A1 series like chips*/
+#define REG_PIN_A1_SEL	0x04
+
 #define INIT_MESON8_COMMON_DATA					\
 	.edge_single_offset = 0,				\
 	.pol_low_offset = 16,					\
@@ -48,9 +51,26 @@
 		.gpio_irq_sel_pin = meson8_gpio_irq_sel_pin,	\
 	},
 
+#define INIT_MESON_A1_COMMON_DATA				\
+	.support_edge_both = true,				\
+	.edge_both_offset = 16,					\
+	.edge_single_offset = 8,				\
+	.pol_low_offset = 0,					\
+	.pin_sel_mask = 0x7f,					\
+	.ops = {						\
+		.gpio_irq_sel_pin = meson_a1_gpio_irq_sel_pin,	\
+		.gpio_irq_init = meson_a1_gpio_irq_init,	\
+	},
+
 struct meson_gpio_irq_controller;
 static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
 				    unsigned int channel, unsigned long hwirq);
+static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				      unsigned int channel,
+				      unsigned long hwirq);
+
+static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl);
+
 struct irq_ctl_ops {
 	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
 					 unsigned int channel,
@@ -100,6 +120,11 @@ static const struct meson_gpio_irq_params sm1_params = {
 	INIT_MESON8_COMMON_DATA
 };
 
+static const struct meson_gpio_irq_params a1_params = {
+	.nr_hwirq = 62,
+	INIT_MESON_A1_COMMON_DATA
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -108,6 +133,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-sm1-gpio-intc", .data = &sm1_params },
+	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
 	{ }
 };
 
@@ -144,6 +170,21 @@ static void meson8_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
 				   hwirq << bit_offset);
 }
 
+static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_irq_controller *ctl,
+				      unsigned int channel,
+				      unsigned long hwirq)
+{
+	unsigned int reg_offset;
+	unsigned int bit_offset;
+
+	bit_offset = ((channel % 2) == 0) ? 0 : 16;
+	reg_offset = REG_PIN_A1_SEL + ((channel / 2) << 2);
+
+	meson_gpio_irq_update_bits(ctl, reg_offset,
+				   ctl->params->pin_sel_mask << bit_offset,
+				   hwirq << bit_offset);
+}
+
 static int
 meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 			       unsigned long  hwirq,
@@ -250,6 +291,12 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 	return 0;
 }
 
+/* For a1 or later chips like a1 there is a switch to enable/disable irq */
+static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl)
+{
+	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL, BIT(31), BIT(31));
+}
+
 static unsigned int meson_gpio_irq_type_output(unsigned int type)
 {
 	unsigned int sense = type & IRQ_TYPE_SENSE_MASK;
-- 
2.24.0

