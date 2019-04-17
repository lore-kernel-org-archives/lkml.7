Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65CC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73B5206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ6lpnts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfDQIIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:08:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46156 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfDQIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:08:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so11705323pfj.13;
        Wed, 17 Apr 2019 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qOCIU3pHa11BqOJDtitDLMSpV7CivUt4w35JumdU44Y=;
        b=mZ6lpntsPwm3BYMGb6SkGmAmUYBNQv/beMIhD08LY1QKfyE7zJkhUBpJVsxhOBL0CQ
         tvWV+h3SzXnaImARggK4H3IgqoQGR6dA/9t9XLEqyc2d9OseA/fbHbUB/XEa3ybShebi
         LZI0Z4Xpe3bQr8e46hjeX6pzQC2xiDd64WKHshAbW/slciysHneLP/lq/YPJdUMOlV21
         tq4DW4ZLPiWfbUzW2wGGykt4bUdEwDOZJw8d/h0K87VMHdQB/oHMeu+RqoAFLYa1YqzY
         jnESjn7Rdrq91t5GwCuJGIipUH4YnDZYr7GwKrqzoDpjcCysVLu4GD5yPNa+2pc3sGVF
         D5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qOCIU3pHa11BqOJDtitDLMSpV7CivUt4w35JumdU44Y=;
        b=cgLhFoIvU1l1WOXQjZaAOSffIOs49HVsZzMkGjnF5fUJ8zzpFH9jj2EbOCWVW2zYZG
         8I3GdUMYzRIqycSh9+3S2nfXRNlWjWgUZjBewGTaLltLaWuaicLu/u00ra7kQBV9mNqI
         NzVdcgZzQyvdszjxFo5gFC1/sE8QlGV6SaVARFKF1f9wY5uubZ6xMZttqaT5ez/H1533
         erYe9ydkGFkdwspqQ6N5ax8NC+dpb6XfQIJGatgbDhwX98lL5pRnD49C7Ye7GQGR3uqi
         sPYp6dmHt+CJZ/3YVOH1f1AeGJZUdnSb6zK2tPhOQwwTQkLQeQqvNtViXCQmoX10gwkJ
         en1g==
X-Gm-Message-State: APjAAAUhHvjFTQzMbIr7l/RKOjqpSANBGww6BSD9wbSSYFZFUUbLSLUL
        HkhEga1JTO7dANu6/miGU3c=
X-Google-Smtp-Source: APXvYqx3WU9Y7EFRLGZnkJt1pw2QHAr5hSpIIQYFRXrdwR8ITQ6rHVF5edf/EPduzZuir8IEWkRVGg==
X-Received: by 2002:a62:4554:: with SMTP id s81mr59788219pfa.66.1555488488103;
        Wed, 17 Apr 2019 01:08:08 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id 6sm70876136pfj.95.2019.04.17.01.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 01:08:07 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, wg@grandegger.com, mkl@pengutronix.de
Cc:     davem@davemloft.net, f.suligoi@asem.it,
        linux-kernel@vger.kernel.org, inux-can@vger.kernel.org,
        netdev@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 1/1] can: sja1000: f81601: add Fintek F81601 support
Date:   Wed, 17 Apr 2019 16:08:04 +0800
Message-Id: <1555488484-14602-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for Fintek PCIE to 2 CAN controller support

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/net/can/sja1000/Kconfig  |   8 ++
 drivers/net/can/sja1000/Makefile |   1 +
 drivers/net/can/sja1000/f81601.c | 223 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 drivers/net/can/sja1000/f81601.c

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index f6dc89927ece..8588323c5138 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -101,4 +101,12 @@ config CAN_TSCAN1
 	  IRQ numbers are read from jumpers JP4 and JP5,
 	  SJA1000 IO base addresses are chosen heuristically (first that works).
 
+config CAN_F81601
+	tristate "Fintek F81601 PCIE to 2 CAN Controller"
+	depends on PCI
+	help
+	  This driver adds support for Fintek F81601 PCIE to 2 CAN Controller.
+	  It had internal 24MHz clock source, but it can be changed by
+	  manufacturer. We can use modinfo to get usage for parameters.
+	  Visit http://www.fintek.com.tw to get more information.
 endif
diff --git a/drivers/net/can/sja1000/Makefile b/drivers/net/can/sja1000/Makefile
index 9253aaf9e739..6f6268543bd9 100644
--- a/drivers/net/can/sja1000/Makefile
+++ b/drivers/net/can/sja1000/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CAN_PEAK_PCMCIA) += peak_pcmcia.o
 obj-$(CONFIG_CAN_PEAK_PCI) += peak_pci.o
 obj-$(CONFIG_CAN_PLX_PCI) += plx_pci.o
 obj-$(CONFIG_CAN_TSCAN1) += tscan1.o
+obj-$(CONFIG_CAN_F81601) += f81601.o
diff --git a/drivers/net/can/sja1000/f81601.c b/drivers/net/can/sja1000/f81601.c
new file mode 100644
index 000000000000..1578bb837aaf
--- /dev/null
+++ b/drivers/net/can/sja1000/f81601.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Fintek F81601 PCIE to 2 CAN controller driver
+ *
+ * Copyright (C) 2019 Peter Hong <peter_hong@fintek.com.tw>
+ * Copyright (C) 2019 Linux Foundation
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/can/dev.h>
+#include <linux/io.h>
+#include <linux/version.h>
+
+#include "sja1000.h"
+
+#define F81601_PCI_MAX_CHAN		2
+
+#define F81601_DECODE_REG		0x209
+#define F81601_IO_MODE			BIT(7)
+#define F81601_MEM_MODE			BIT(6)
+#define F81601_CFG_MODE			BIT(5)
+#define F81601_CAN2_INTERNAL_CLK	BIT(3)
+#define F81601_CAN1_INTERNAL_CLK	BIT(2)
+#define F81601_CAN2_EN			BIT(1)
+#define F81601_CAN1_EN			BIT(0)
+
+#define F81601_TRAP_REG			0x20a
+#define F81601_CAN2_HAS_EN		BIT(4)
+
+struct f81601_pci_card {
+	int channels;			/* detected channels count */
+	void __iomem *addr;
+	spinlock_t lock;		/* for access mem io */
+	struct pci_dev *dev;
+	struct net_device *net_dev[F81601_PCI_MAX_CHAN];
+};
+
+static const struct pci_device_id f81601_pci_tbl[] = {
+	{ PCI_DEVICE(0x1c29, 0x1703) },
+	{},
+};
+
+MODULE_DEVICE_TABLE(pci, f81601_pci_tbl);
+
+static bool internal_clk = 1;
+module_param(internal_clk, bool, 0444);
+MODULE_PARM_DESC(internal_clk, "Use internal clock, default 1 (24MHz)");
+
+static unsigned int external_clk;
+module_param(external_clk, uint, 0444);
+MODULE_PARM_DESC(external_clk, "External Clock, must spec when internal_clk = 0");
+
+static u8 f81601_pci_read_reg(const struct sja1000_priv *priv, int port)
+{
+	return readb(priv->reg_base + port);
+}
+
+static void f81601_pci_write_reg(const struct sja1000_priv *priv, int port,
+				 u8 val)
+{
+	struct f81601_pci_card *card = priv->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->lock, flags);
+	writeb(val, priv->reg_base + port);
+	readb(priv->reg_base);
+	spin_unlock_irqrestore(&card->lock, flags);
+}
+
+static void f81601_pci_del_card(struct pci_dev *pdev)
+{
+	struct f81601_pci_card *card = pci_get_drvdata(pdev);
+	struct net_device *dev;
+	int i = 0;
+
+	for (i = 0; i < F81601_PCI_MAX_CHAN; i++) {
+		dev = card->net_dev[i];
+		if (!dev)
+			continue;
+
+		dev_info(&pdev->dev, "%s: Removing %s\n", __func__, dev->name);
+
+		unregister_sja1000dev(dev);
+		free_sja1000dev(dev);
+	}
+
+	pcim_iounmap(pdev, card->addr);
+}
+
+/* Probe F81601 based device for the SJA1000 chips and register each
+ * available CAN channel to SJA1000 Socket-CAN subsystem.
+ */
+static int f81601_pci_add_card(struct pci_dev *pdev,
+			       const struct pci_device_id *ent)
+{
+	struct sja1000_priv *priv;
+	struct net_device *dev;
+	struct f81601_pci_card *card;
+	int err, i;
+	u8 tmp;
+
+	if (pcim_enable_device(pdev) < 0) {
+		dev_err(&pdev->dev, "Failed to enable PCI device\n");
+		return -ENODEV;
+	}
+
+	dev_info(&pdev->dev, "Detected card at slot #%i\n",
+		 PCI_SLOT(pdev->devfn));
+
+	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	card->channels = 0;
+	card->dev = pdev;
+	spin_lock_init(&card->lock);
+
+	pci_set_drvdata(pdev, card);
+
+	tmp = F81601_IO_MODE | F81601_MEM_MODE | F81601_CFG_MODE |
+			F81601_CAN2_EN | F81601_CAN1_EN;
+
+	if (internal_clk) {
+		tmp |= F81601_CAN2_INTERNAL_CLK | F81601_CAN1_INTERNAL_CLK;
+
+		dev_info(&pdev->dev,
+			 "F81601 running with internal clock: 24Mhz\n");
+	} else {
+		dev_info(&pdev->dev,
+			 "F81601 running with external clock: %dMhz\n",
+			 external_clk / 1000000);
+	}
+
+	pci_write_config_byte(pdev, F81601_DECODE_REG, tmp);
+
+	card->addr = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
+
+	if (!card->addr) {
+		err = -ENOMEM;
+		dev_err(&pdev->dev, "%s: Failed to remap BAR\n", __func__);
+		goto failure_cleanup;
+	}
+
+	/* Detect available channels */
+	for (i = 0; i < F81601_PCI_MAX_CHAN; i++) {
+		/* read CAN2_HW_EN strap pin */
+		pci_read_config_byte(pdev, F81601_TRAP_REG, &tmp);
+		if (i == 1 && !(tmp & F81601_CAN2_HAS_EN))
+			break;
+
+		dev = alloc_sja1000dev(0);
+		if (!dev) {
+			err = -ENOMEM;
+			goto failure_cleanup;
+		}
+
+		card->net_dev[i] = dev;
+		dev->irq = pdev->irq;
+
+		priv = netdev_priv(dev);
+		priv->priv = card;
+		priv->irq_flags = IRQF_SHARED;
+		priv->reg_base = card->addr + 0x80 * i;
+		priv->read_reg = f81601_pci_read_reg;
+		priv->write_reg = f81601_pci_write_reg;
+
+		if (internal_clk)
+			priv->can.clock.freq = 24000000 / 2;
+		else
+			priv->can.clock.freq = external_clk / 2;
+
+		priv->ocr = OCR_TX0_PUSHPULL | OCR_TX1_PUSHPULL;
+		priv->cdr = CDR_CBP;
+
+		SET_NETDEV_DEV(dev, &pdev->dev);
+		dev->dev_id = i;
+
+		/* Register SJA1000 device */
+		err = register_sja1000dev(dev);
+		if (err) {
+			dev_err(&pdev->dev,
+				"%s: Registering device failed: %x\n", __func__,
+				err);
+			goto failure_cleanup;
+		}
+
+		card->channels++;
+
+		dev_info(&pdev->dev, "Channel #%d, %s at 0x%p, irq %d\n", i,
+			 dev->name, priv->reg_base, dev->irq);
+	}
+
+	if (!card->channels) {
+		err = -ENODEV;
+		goto failure_cleanup;
+	}
+
+	return 0;
+
+failure_cleanup:
+	dev_err(&pdev->dev, "%s: failed: %d. Cleaning Up.\n", __func__, err);
+	f81601_pci_del_card(pdev);
+
+	return err;
+}
+
+static struct pci_driver f81601_pci_driver = {
+	.name =		"f81601",
+	.id_table =	f81601_pci_tbl,
+	.probe =	f81601_pci_add_card,
+	.remove =	f81601_pci_del_card,
+};
+
+MODULE_DESCRIPTION("Fintek F81601 PCIE to 2 CANBUS adaptor driver");
+MODULE_AUTHOR("Peter Hong <peter_hong@fintek.com.tw>");
+MODULE_LICENSE("GPL v2");
+
+module_pci_driver(f81601_pci_driver);
-- 
2.7.4

