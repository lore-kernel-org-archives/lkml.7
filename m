Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C4FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEC721929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfJXWCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:02:12 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:43370 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729946AbfJXWCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:02:09 -0400
X-Greylist: delayed 804 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2019 18:02:00 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x9OLlqZD022499;
        Fri, 25 Oct 2019 00:47:52 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 0BA586026D; Fri, 25 Oct 2019 00:47:52 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, benjaminfair@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 3/3] reset: npcm: add NPCM reset controller driver
Date:   Fri, 25 Oct 2019 00:47:46 +0300
Message-Id: <20191024214746.88431-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191024214746.88431-1-tmaimon77@gmail.com>
References: <20191024214746.88431-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton NPCM BMC reset controller driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/Kconfig      |   7 +
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-npcm.c | 273 +++++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 drivers/reset/reset-npcm.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7b07281aa0ae..5dbfdf6d717a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -89,6 +89,13 @@ config RESET_MESON_AUDIO_ARB
 	  This enables the reset driver for Audio Memory Arbiter of
 	  Amlogic's A113 based SoCs
 
+config RESET_NPCM
+	bool "NPCM BMC Reset Driver"
+	depends on ARCH_NPCM || COMPILE_TEST
+	help
+	  This enables the reset controller driver for Nuvoton NPCM 
+	  BMC SoCs.
+
 config RESET_OXNAS
 	bool
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index cf60ce526064..00767c03f5f2 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
+obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
new file mode 100644
index 000000000000..cf9e6c1d9242
--- /dev/null
+++ b/drivers/reset/reset-npcm.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Nuvoton Technology corporation.
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/of_address.h>
+
+/* NPCM7xx GCR registers */
+#define NPCM_MDLR_OFFSET	0x7C
+#define NPCM_MDLR_USBD0		BIT(9)
+#define NPCM_MDLR_USBD1		BIT(8)
+#define NPCM_MDLR_USBD2_4	BIT(21)
+#define NPCM_MDLR_USBD5_9	BIT(22)
+
+#define NPCM_USB1PHYCTL_OFFSET	0x140
+#define NPCM_USB2PHYCTL_OFFSET	0x144
+#define NPCM_USBXPHYCTL_RS	BIT(28)
+
+/* NPCM7xx Reset registers */
+#define NPCM_SWRSTR		0x14
+#define NPCM_SWRST		BIT(2)
+
+#define NPCM_IPSRST1		0x20
+#define NPCM_IPSRST1_USBD1	BIT(5)
+#define NPCM_IPSRST1_USBD2	BIT(8)
+#define NPCM_IPSRST1_USBD3	BIT(25)
+#define NPCM_IPSRST1_USBD4	BIT(22)
+#define NPCM_IPSRST1_USBD5	BIT(23)
+#define NPCM_IPSRST1_USBD6	BIT(24)
+
+#define NPCM_IPSRST2		0x24
+#define NPCM_IPSRST2_USB_HOST	BIT(26)
+
+#define NPCM_IPSRST3		0x34
+#define NPCM_IPSRST3_USBD0	BIT(4)
+#define NPCM_IPSRST3_USBD7	BIT(5)
+#define NPCM_IPSRST3_USBD8	BIT(6)
+#define NPCM_IPSRST3_USBD9	BIT(7)
+#define NPCM_IPSRST3_USBPHY1	BIT(24)
+#define NPCM_IPSRST3_USBPHY2	BIT(25)
+
+#define NPCM_RC_RESETS_PER_REG	32
+
+struct npcm_rc_data {
+	struct reset_controller_dev rcdev;
+	struct notifier_block restart_nb;
+	u32 sw_reset_number;
+	void __iomem *base;
+	spinlock_t lock;
+};
+
+#define to_rc_data(p) container_of(p, struct npcm_rc_data, rcdev)
+
+static int npcm_rc_restart(struct notifier_block *nb, unsigned long mode,
+			   void *cmd)
+{
+	struct npcm_rc_data *rc = container_of(nb, struct npcm_rc_data,
+					       restart_nb);
+
+	writel(NPCM_SWRST << rc->sw_reset_number, rc->base + NPCM_SWRSTR);
+	mdelay(1000);
+
+	pr_emerg("%s: unable to restart system\n", __func__);
+
+	return NOTIFY_DONE;
+}
+
+static int npcm_rc_setclear_reset(struct reset_controller_dev *rcdev,
+				  unsigned long id, bool set)
+{
+	struct npcm_rc_data *rc = to_rc_data(rcdev);
+	u32 ctrl_offset = NPCM_IPSRST1;
+	unsigned long flags;
+	u32 stat, rst_bit;
+
+	ctrl_offset += (id / NPCM_RC_RESETS_PER_REG) * sizeof(u32);
+	rst_bit = 1 << (id % NPCM_RC_RESETS_PER_REG);
+
+	spin_lock_irqsave(&rc->lock, flags);
+	stat = readl(rc->base + ctrl_offset);
+	if (set)
+		writel(stat | rst_bit, rc->base + ctrl_offset);
+	else
+		writel(stat & ~rst_bit, rc->base + ctrl_offset);
+	spin_unlock_irqrestore(&rc->lock, flags);
+
+	return 0;
+}
+
+static int npcm_rc_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return npcm_rc_setclear_reset(rcdev, id, true);
+}
+
+static int npcm_rc_deassert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	return npcm_rc_setclear_reset(rcdev, id, false);
+}
+
+static int npcm_rc_status(struct reset_controller_dev *rcdev,
+			  unsigned long id)
+{
+	struct npcm_rc_data *rc = to_rc_data(rcdev);
+	u32 bit, ctrl_offset = NPCM_IPSRST1;
+
+	ctrl_offset += (id / NPCM_RC_RESETS_PER_REG) * sizeof(u32);
+	bit = 1 << (id % NPCM_RC_RESETS_PER_REG);
+
+	return (readl(rc->base + ctrl_offset) & bit);
+}
+
+/*
+ *  The following procedure should be observed in USB PHY, USB device and
+ *  USB host initialization at BMC boot
+ */
+static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 mdlr, iprst1, iprst2, iprst3;
+	struct regmap *gcr_regmap;
+	u32 ipsrst1_bits = 0;
+	u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
+	u32 ipsrst3_bits = 0;
+
+	if (of_device_is_compatible(np, "nuvoton,npcm750-reset")) {
+		gcr_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
+		if (IS_ERR(gcr_regmap)) {
+			dev_err(&pdev->dev, "Failed to find nuvoton,npcm750-gcr\n");
+			return PTR_ERR(gcr_regmap);
+		}
+	}
+
+	/* checking which USB device is enabled */
+	regmap_read(gcr_regmap, NPCM_MDLR_OFFSET, &mdlr);
+	if (!(mdlr & NPCM_MDLR_USBD0))
+		ipsrst3_bits |= NPCM_IPSRST3_USBD0;
+	if (!(mdlr & NPCM_MDLR_USBD1))
+		ipsrst1_bits |= NPCM_IPSRST1_USBD1;
+	if (!(mdlr & NPCM_MDLR_USBD2_4))
+		ipsrst1_bits |= (NPCM_IPSRST1_USBD2 |
+				 NPCM_IPSRST1_USBD3 |
+				 NPCM_IPSRST1_USBD4);
+	if (!(mdlr & NPCM_MDLR_USBD0)) {
+		ipsrst1_bits |= (NPCM_IPSRST1_USBD5 |
+				 NPCM_IPSRST1_USBD6);
+		ipsrst3_bits |= (NPCM_IPSRST3_USBD7 |
+				 NPCM_IPSRST3_USBD8 |
+				 NPCM_IPSRST3_USBD9);
+	}
+
+	/* assert reset USB PHY and USB devices */
+	iprst1 = readl(rc->base + NPCM_IPSRST1);
+	iprst2 = readl(rc->base + NPCM_IPSRST2);
+	iprst3 = readl(rc->base + NPCM_IPSRST3);
+
+	iprst1 |= ipsrst1_bits;
+	iprst2 |= ipsrst2_bits;
+	iprst3 |= (ipsrst3_bits | NPCM_IPSRST3_USBPHY1 |
+		   NPCM_IPSRST3_USBPHY2);
+
+	writel(iprst1, rc->base + NPCM_IPSRST1);
+	writel(iprst2, rc->base + NPCM_IPSRST2);
+	writel(iprst3, rc->base + NPCM_IPSRST3);
+
+	/* clear USB PHY RS bit */
+	regmap_update_bits(gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, 0);
+	regmap_update_bits(gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, 0);
+
+	/* deassert reset USB PHY */
+	iprst3 &= ~(NPCM_IPSRST3_USBPHY1 | NPCM_IPSRST3_USBPHY2);
+	writel(iprst3, rc->base + NPCM_IPSRST3);
+
+	udelay(50);
+
+	/* set USB PHY RS bit */
+	regmap_update_bits(gcr_regmap, NPCM_USB1PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
+	regmap_update_bits(gcr_regmap, NPCM_USB2PHYCTL_OFFSET,
+			   NPCM_USBXPHYCTL_RS, NPCM_USBXPHYCTL_RS);
+
+	/* deassert reset USB devices*/
+	iprst1 &= ~ipsrst1_bits;
+	iprst2 &= ~ipsrst2_bits;
+	iprst3 &= ~ipsrst3_bits;
+
+	writel(iprst1, rc->base + NPCM_IPSRST1);
+	writel(iprst2, rc->base + NPCM_IPSRST2);
+	writel(iprst3, rc->base + NPCM_IPSRST3);
+
+	return 0;
+}
+
+static const struct reset_control_ops npcm_rc_ops = {
+	.assert		= npcm_rc_assert,
+	.deassert	= npcm_rc_deassert,
+	.status		= npcm_rc_status,
+};
+
+static int npcm_rc_probe(struct platform_device *pdev)
+{
+	struct npcm_rc_data *rc;
+	struct resource res;
+	int ret;
+
+	rc = devm_kzalloc(&pdev->dev, sizeof(*rc), GFP_KERNEL);
+	if (!rc)
+		return -ENOMEM;
+
+	of_address_to_resource(pdev->dev.of_node, 0, &res);
+	rc->base = devm_ioremap_resource(&pdev->dev, &res);
+	if (IS_ERR(rc->base))
+		return PTR_ERR(rc->base);
+
+	spin_lock_init(&rc->lock);
+
+	rc->rcdev.owner = THIS_MODULE;
+	rc->rcdev.nr_resets = resource_size(&res) / 4 * BITS_PER_LONG;
+	rc->rcdev.ops = &npcm_rc_ops;
+	rc->rcdev.of_node = pdev->dev.of_node;
+
+	platform_set_drvdata(pdev, rc);
+
+	ret = reset_controller_register(&rc->rcdev);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register device\n");
+		return ret;
+	}
+
+	if (npcm_usb_reset(pdev, rc))
+		dev_warn(&pdev->dev, "NPCM USB reset failed, can cause issues with UDC and USB host\n");
+
+	if (!of_property_read_u32(pdev->dev.of_node, "nuvoton,sw-reset-number",
+				  &rc->sw_reset_number)) {
+		if (rc->sw_reset_number && rc->sw_reset_number < 5) {
+			rc->restart_nb.priority = 192,
+			rc->restart_nb.notifier_call = npcm_rc_restart,
+			ret = register_restart_handler(&rc->restart_nb);
+			if (ret)
+				dev_warn(&pdev->dev, "failed to register restart handler\n");
+		}
+	}
+
+	pr_info("NPCM RESET driver probed\n");
+	return ret;
+}
+
+static const struct of_device_id npcm_rc_match[] = {
+	{ .compatible = "nuvoton,npcm750-reset" },
+	{ }
+};
+
+static struct platform_driver npcm_rc_driver = {
+	.probe	= npcm_rc_probe,
+	.driver	= {
+		.name			= "npcm-reset",
+		.of_match_table		= npcm_rc_match,
+		.suppress_bind_attrs	= true,
+	},
+};
+builtin_platform_driver(npcm_rc_driver);
-- 
2.22.0

