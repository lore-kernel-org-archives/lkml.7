Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C1EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC8F217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfDPLR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:17:29 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:33292 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727240AbfDPLRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:17:25 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x3GAkakx014006;
        Tue, 16 Apr 2019 13:46:36 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 3F6FE63002; Tue, 16 Apr 2019 14:16:33 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     gregkh@linuxfoundation.org, arnd@arnd.de, robh+dt@kernel.org,
        mark.rutland@arm.com, yuenn@google.com, venture@google.com,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 2/2] misc: npcm: add NPCM LPC BPC driver
Date:   Tue, 16 Apr 2019 14:16:31 +0300
Message-Id: <20190416111631.356803-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190416111631.356803-1-tmaimon77@gmail.com>
References: <20190416111631.356803-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM BIOS post code (BPC) driver.

The NPCM BPC monitoring two I/O address written by
the host on the Low Pin Count (LPC) bus, the capure
data stored in 128-word FIFO.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/misc/Kconfig              |   8 +
 drivers/misc/Makefile             |   1 +
 drivers/misc/npcm-lpc-bpc-snoop.c | 385 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 394 insertions(+)
 create mode 100644 drivers/misc/npcm-lpc-bpc-snoop.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec92a04..320a1d0083d2 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -532,6 +532,14 @@ config PVPANIC
 	  a paravirtualized device provided by QEMU; it lets a virtual machine
 	  (guest) communicate panic events to the host.
 
+config NPCM_LPC_BPC_SNOOP
+	tristate "NPCM LPC BIOS Post Code snoop support"
+	depends on (ARCH_NPCM || COMPILE_TEST)
+	help
+	  Provides a NPCM BMC driver to control the LPC BIOS Post Code
+	  interface which allows the BMC to monitoring and save
+	  the data written by the host to an arbitrary LPC I/O port.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d5b7d3404dc7..5dd0bff75b60 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,5 +59,6 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
+obj-$(CONFIG_NPCM_LPC_BPC_SNOOP) += npcm-lpc-bpc-snoop.o
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
diff --git a/drivers/misc/npcm-lpc-bpc-snoop.c b/drivers/misc/npcm-lpc-bpc-snoop.c
new file mode 100644
index 000000000000..9b7f7313e14d
--- /dev/null
+++ b/drivers/misc/npcm-lpc-bpc-snoop.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2014-2018 Nuvoton Technology corporation.
+
+#include <linux/fs.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/kfifo.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/miscdevice.h>
+#include <linux/poll.h>
+
+#define DEVICE_NAME	"npcm-lpc-bpc"
+
+#define NUM_BPC_CHANNELS		2
+#define DW_PAD_SIZE			3
+
+/* BIOS POST Code FIFO Registers */
+#define NPCM_BPCFA2L_REG	0x2 //BIOS POST Code FIFO Address 2 LSB
+#define NPCM_BPCFA2M_REG	0x4 //BIOS POST Code FIFO Address 2 MSB
+#define NPCM_BPCFEN_REG	0x6 //BIOS POST Code FIFO Enable
+#define NPCM_BPCFSTAT_REG	0x8 //BIOS POST Code FIFO Status
+#define NPCM_BPCFDATA_REG	0xA //BIOS POST Code FIFO Data
+#define NPCM_BPCFMSTAT_REG	0xC //BIOS POST Code FIFO Miscellaneous Status
+#define NPCM_BPCFA1L_REG	0x10 //BIOS POST Code FIFO Address 1 LSB
+#define NPCM_BPCFA1M_REG	0x12 //BIOS POST Code FIFO Address 1 MSB
+
+/*BIOS regiser data*/
+#define FIFO_IOADDR1_ENABLE	0x80
+#define FIFO_IOADDR2_ENABLE	0x40
+
+/* BPC interface package and structure definition */
+#define BPC_KFIFO_SIZE		0x400
+
+/*BPC regiser data*/
+#define FIFO_DATA_VALID		0x80
+#define FIFO_OVERFLOW		0x20
+#define FIFO_READY_INT_ENABLE	0x8
+#define FIFO_DWCAPTURE		0x4
+#define FIFO_ADDR_DECODE	0x1
+
+/*Host Reset*/
+#define HOST_RESET_INT_ENABLE	0x10
+#define HOST_RESET_CHANGED	0x40
+
+struct npcm_bpc_channel {
+	struct npcm_bpc	*data;
+	struct kfifo		fifo;
+	wait_queue_head_t	wq;
+	bool			host_reset;
+	struct miscdevice	miscdev;
+};
+
+struct npcm_bpc {
+	void __iomem			*base;
+	int				irq;
+	bool				en_dwcap;
+	struct npcm_bpc_channel	ch[NUM_BPC_CHANNELS];
+};
+
+static struct npcm_bpc_channel *npcm_file_to_ch(struct file *file)
+{
+	return container_of(file->private_data, struct npcm_bpc_channel,
+			    miscdev);
+}
+
+static ssize_t npcm_bpc_read(struct file *file, char __user *buffer,
+			     size_t count, loff_t *ppos)
+{
+	struct npcm_bpc_channel *chan = npcm_file_to_ch(file);
+	struct npcm_bpc *lpc_bpc = chan->data;
+	unsigned int copied;
+	int ret = 0;
+	int cond_size = 1;
+
+	if (lpc_bpc->en_dwcap)
+		cond_size = 3;
+
+	if (kfifo_len(&chan->fifo) < cond_size) {
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible
+			(chan->wq, kfifo_len(&chan->fifo) > cond_size);
+		if (ret == -ERESTARTSYS)
+			return -EINTR;
+	}
+
+	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
+
+	return ret ? ret : copied;
+}
+
+static __poll_t npcm_bpc_poll(struct file *file, struct poll_table_struct *pt)
+{
+	struct npcm_bpc_channel *chan = npcm_file_to_ch(file);
+	__poll_t mask = 0;
+
+	poll_wait(file, &chan->wq, pt);
+	if (!kfifo_is_empty(&chan->fifo))
+		mask |= POLLIN;
+
+	if (chan->host_reset) {
+		mask |= POLLHUP;
+		chan->host_reset = false;
+	}
+
+	return mask;
+}
+
+static const struct file_operations npcm_bpc_fops = {
+	.owner		= THIS_MODULE,
+	.read		= npcm_bpc_read,
+	.poll		= npcm_bpc_poll,
+	.llseek		= noop_llseek,
+};
+
+static irqreturn_t npcm_bpc_irq(int irq, void *arg)
+{
+	struct npcm_bpc *lpc_bpc = arg;
+	u8 fifo_st;
+	u8 host_st;
+	u8 addr_index = 0;
+	u8 Data;
+	u8 padzero[3] = {0};
+	u8 last_addr_bit = 0;
+	bool isr_flag = false;
+
+	fifo_st = ioread8(lpc_bpc->base + NPCM_BPCFSTAT_REG);
+	while (FIFO_DATA_VALID & fifo_st) {
+		 /* If dwcapture enabled only channel 0 (FIFO 0) used */
+		if (!lpc_bpc->en_dwcap)
+			addr_index = fifo_st & FIFO_ADDR_DECODE;
+		else
+			last_addr_bit = fifo_st & FIFO_ADDR_DECODE;
+
+		/*Read data from FIFO to clear interrupt*/
+		Data = ioread8(lpc_bpc->base + NPCM_BPCFDATA_REG);
+		if (kfifo_is_full(&lpc_bpc->ch[addr_index].fifo))
+			kfifo_skip(&lpc_bpc->ch[addr_index].fifo);
+		kfifo_put(&lpc_bpc->ch[addr_index].fifo, Data);
+		if (fifo_st & FIFO_OVERFLOW)
+			pr_info("BIOS Post Codes FIFO Overflow!!!\n");
+
+		fifo_st = ioread8(lpc_bpc->base + NPCM_BPCFSTAT_REG);
+		if (lpc_bpc->en_dwcap && last_addr_bit) {
+			if ((fifo_st & FIFO_ADDR_DECODE) ||
+			    ((FIFO_DATA_VALID & fifo_st) == 0)) {
+				while (kfifo_avail(&lpc_bpc->ch[addr_index].fifo) < DW_PAD_SIZE)
+					kfifo_skip(&lpc_bpc->ch[addr_index].fifo);
+				kfifo_in(&lpc_bpc->ch[addr_index].fifo,
+					 padzero, DW_PAD_SIZE);
+			}
+		}
+		isr_flag = true;
+	}
+
+	host_st = ioread8(lpc_bpc->base + NPCM_BPCFMSTAT_REG);
+	if (host_st & HOST_RESET_CHANGED) {
+		iowrite8(HOST_RESET_CHANGED,
+			 lpc_bpc->base + NPCM_BPCFMSTAT_REG);
+		lpc_bpc->ch[addr_index].host_reset = true;
+		isr_flag = true;
+	}
+
+	if (isr_flag) {
+		wake_up_interruptible(&lpc_bpc->ch[addr_index].wq);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int npcm_bpc_config_irq(struct npcm_bpc *lpc_bpc,
+			       struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int rc;
+
+	lpc_bpc->irq = platform_get_irq(pdev, 0);
+	if (lpc_bpc->irq < 0) {
+		dev_err(dev, "get IRQ failed\n");
+		return lpc_bpc->irq;
+	}
+
+	rc = devm_request_irq(dev, lpc_bpc->irq,
+			      npcm_bpc_irq, IRQF_SHARED,
+			      DEVICE_NAME, lpc_bpc);
+	if (rc < 0) {
+		dev_warn(dev, "Unable to request IRQ %d\n", lpc_bpc->irq);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int npcm_enable_bpc(struct npcm_bpc *lpc_bpc, struct device *dev,
+			   int channel, u16 lpc_port)
+{
+	int rc;
+	u8 addr_en, reg_en;
+
+	init_waitqueue_head(&lpc_bpc->ch[channel].wq);
+
+	rc = kfifo_alloc(&lpc_bpc->ch[channel].fifo,
+			 BPC_KFIFO_SIZE, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	lpc_bpc->ch[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
+	lpc_bpc->ch[channel].miscdev.name =
+		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	lpc_bpc->ch[channel].miscdev.fops = &npcm_bpc_fops;
+	lpc_bpc->ch[channel].miscdev.parent = dev;
+	rc = misc_register(&lpc_bpc->ch[channel].miscdev);
+	if (rc)
+		return rc;
+
+	lpc_bpc->ch[channel].data = lpc_bpc;
+	lpc_bpc->ch[channel].host_reset = false;
+
+	/* Enable LPC snoop channel at requested port */
+	switch (channel) {
+	case 0:
+		addr_en = FIFO_IOADDR1_ENABLE;
+		iowrite8((u8)lpc_port & 0xFF,
+			 lpc_bpc->base + NPCM_BPCFA1L_REG);
+		iowrite8((u8)(lpc_port >> 8),
+			 lpc_bpc->base + NPCM_BPCFA1M_REG);
+		break;
+	case 1:
+		addr_en = FIFO_IOADDR2_ENABLE;
+		iowrite8((u8)lpc_port & 0xFF,
+			 lpc_bpc->base + NPCM_BPCFA2L_REG);
+		iowrite8((u8)(lpc_port >> 8),
+			 lpc_bpc->base + NPCM_BPCFA2M_REG);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (lpc_bpc->en_dwcap)
+		addr_en = FIFO_DWCAPTURE;
+
+	/*
+	 * Enable FIFO Ready Interrupt, FIFO Capture of I/O addr,
+	 * and Host Reset
+	 */
+	reg_en = ioread8(lpc_bpc->base + NPCM_BPCFEN_REG);
+	iowrite8(reg_en | addr_en | FIFO_READY_INT_ENABLE |
+		 HOST_RESET_INT_ENABLE, lpc_bpc->base + NPCM_BPCFEN_REG);
+
+	return 0;
+}
+
+static void npcm_disable_bpc(struct npcm_bpc *lpc_bpc, int channel)
+{
+	u8 reg_en;
+
+	switch (channel) {
+	case 0:
+		reg_en = ioread8(lpc_bpc->base + NPCM_BPCFEN_REG);
+		if (lpc_bpc->en_dwcap)
+			iowrite8(reg_en & ~FIFO_DWCAPTURE,
+				 lpc_bpc->base + NPCM_BPCFEN_REG);
+		else
+			iowrite8(reg_en & ~FIFO_IOADDR1_ENABLE,
+				 lpc_bpc->base + NPCM_BPCFEN_REG);
+		break;
+	case 1:
+		reg_en = ioread8(lpc_bpc->base + NPCM_BPCFEN_REG);
+		iowrite8(reg_en & ~FIFO_IOADDR2_ENABLE,
+			 lpc_bpc->base + NPCM_BPCFEN_REG);
+		break;
+	default:
+		return;
+	}
+
+	if (!(reg_en & (FIFO_IOADDR1_ENABLE | FIFO_IOADDR2_ENABLE)))
+		iowrite8(reg_en &
+			 ~(FIFO_READY_INT_ENABLE | HOST_RESET_INT_ENABLE),
+			 lpc_bpc->base + NPCM_BPCFEN_REG);
+
+	kfifo_free(&lpc_bpc->ch[channel].fifo);
+	misc_deregister(&lpc_bpc->ch[channel].miscdev);
+}
+
+static int npcm_bpc_probe(struct platform_device *pdev)
+{
+	struct npcm_bpc *lpc_bpc;
+	struct device *dev;
+	u32 port;
+	int rc;
+
+	dev = &pdev->dev;
+
+	lpc_bpc = devm_kzalloc(dev, sizeof(*lpc_bpc), GFP_KERNEL);
+	if (!lpc_bpc)
+		return -ENOMEM;
+
+	lpc_bpc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lpc_bpc->base))
+		return PTR_ERR(lpc_bpc->base);
+
+	dev_set_drvdata(&pdev->dev, lpc_bpc);
+
+	rc = of_property_read_u32_index(dev->of_node, "snoop-ports", 0,
+					&port);
+	if (rc) {
+		dev_err(dev, "no snoop ports configured\n");
+		return -ENODEV;
+	}
+
+	lpc_bpc->en_dwcap =
+		of_property_read_bool(dev->of_node, "nuvoton,lpc-en-dwcapture");
+
+	rc = npcm_bpc_config_irq(lpc_bpc, pdev);
+	if (rc)
+		return rc;
+
+	rc = npcm_enable_bpc(lpc_bpc, dev, 0, port);
+	if (rc) {
+		dev_err(dev, "Enable BIOS post code I/O port 0 failed\n");
+		return rc;
+	}
+
+	/*
+	 * Configuration of second BPC channel port is optional
+	 * Double-Word Capture ignoring address 2
+	 */
+	if (!lpc_bpc->en_dwcap) {
+		if (of_property_read_u32_index(dev->of_node, "snoop-ports",
+					       1, &port) == 0) {
+			rc = npcm_enable_bpc(lpc_bpc, dev, 1, port);
+			if (rc) {
+				dev_err(dev, "Enable BIOS post code I/O port 1 failed, disable I/O port 0\n");
+				npcm_disable_bpc(lpc_bpc, 0);
+				return rc;
+			}
+		}
+	}
+
+	pr_info("NPCM BIOS post code probe\n");
+
+	return rc;
+}
+
+static int npcm_bpc_remove(struct platform_device *pdev)
+{
+	struct npcm_bpc *lpc_bpc = dev_get_drvdata(&pdev->dev);
+	u8 reg_en;
+
+	reg_en = ioread8(lpc_bpc->base + NPCM_BPCFEN_REG);
+
+	if (reg_en & FIFO_IOADDR1_ENABLE)
+		npcm_disable_bpc(lpc_bpc, 0);
+	if (reg_en & FIFO_IOADDR2_ENABLE)
+		npcm_disable_bpc(lpc_bpc, 1);
+
+	return 0;
+}
+
+static const struct of_device_id npcm_bpc_match[] = {
+	{ .compatible = "nuvoton,npcm750-lpc-bpc-snoop" },
+	{ },
+};
+
+static struct platform_driver npcm_bpc_driver = {
+	.driver = {
+		.name		= DEVICE_NAME,
+		.of_match_table = npcm_bpc_match,
+	},
+	.probe = npcm_bpc_probe,
+	.remove = npcm_bpc_remove,
+};
+
+module_platform_driver(npcm_bpc_driver);
+
+MODULE_DEVICE_TABLE(of, npcm_bpc_match);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_DESCRIPTION("Linux driver to control NPCM LPC BIOS post code snooping");
-- 
2.14.1

