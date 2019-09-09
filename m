Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C17CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86DA20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r3MaQvNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfIIJOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:14:11 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:9479 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfIIJOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568020450; x=1599556450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7bxATOD4YpTfA2T6D2FS+tUZcECPge1g5C9oB541ceY=;
  b=r3MaQvNOhjsiMpsLIonOEEGVK9Y8mAVsxQsGp3cbG27rcjcUIq30tfRS
   yAQe7Mmxs/Gndtq/vIr5OGpalI19sYROBkdBlAx+l+I3/Zial05Q8MthU
   HPGlZtBACRMZzZ9+WGEWLnk7atsd9N7CWkAF03IBQnVMyj6tZfMMPDJGJ
   A=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="829173315"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Sep 2019 09:11:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 263E9A1D0C;
        Mon,  9 Sep 2019 09:11:12 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 09:11:11 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.176) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 09:10:59 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <tglx@linutronix.de>, <arnd@arndb.de>, <venture@google.com>,
        <linus.walleij@linaro.org>, <olof@lixom.net>, <mripard@kernel.org>,
        <ssantosh@kernel.org>, <paul.kocialkowski@bootlin.com>,
        <mjourdan@baylibre.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <talel@amazon.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH 2/3] soc: amazon: al-pos: Introduce Amazon's Annapurna Labs POS driver
Date:   Mon, 9 Sep 2019 12:10:19 +0300
Message-ID: <1568020220-7758-3-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568020220-7758-1-git-send-email-talel@amazon.com>
References: <1568020220-7758-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D23UWA001.ant.amazon.com (10.43.160.68) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amazon's Annapurna Labs SoCs includes Point Of Serialization error
logging unit that reports an error in case write error (e.g. attempt to
write to a read only register).
This patch introduces the support for this unit.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 MAINTAINERS                 |   6 +++
 drivers/soc/Kconfig         |   1 +
 drivers/soc/Makefile        |   1 +
 drivers/soc/amazon/Kconfig  |   5 ++
 drivers/soc/amazon/Makefile |   1 +
 drivers/soc/amazon/al_pos.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 143 insertions(+)
 create mode 100644 drivers/soc/amazon/Kconfig
 create mode 100644 drivers/soc/amazon/Makefile
 create mode 100644 drivers/soc/amazon/al_pos.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e7a47b5..627af40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -751,6 +751,12 @@ F:	drivers/tty/serial/altera_jtaguart.c
 F:	include/linux/altera_uart.h
 F:	include/linux/altera_jtaguart.h
 
+AMAZON ANNAPURNA LABS POS
+M:	Talel Shenhar <talel@amazon.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
+F:	drivers/soc/amazon/al_pos.c
+
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 833e04a..913a6b1 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -2,6 +2,7 @@
 menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/actions/Kconfig"
+source "drivers/soc/amazon/Kconfig"
 source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/aspeed/Kconfig"
 source "drivers/soc/atmel/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2ec3550..c1c5c64 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
 obj-$(CONFIG_SOC_ASPEED)	+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
+obj-y				+= amazon/
 obj-y				+= bcm/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
diff --git a/drivers/soc/amazon/Kconfig b/drivers/soc/amazon/Kconfig
new file mode 100644
index 00000000..fdd4cdd
--- /dev/null
+++ b/drivers/soc/amazon/Kconfig
@@ -0,0 +1,5 @@
+config AL_POS
+	bool "Amazon's Annapurna Labs POS driver"
+	depends on ARCH_ALPINE || COMPILE_TEST
+	help
+	  Include support for the SoC POS error capability.
diff --git a/drivers/soc/amazon/Makefile b/drivers/soc/amazon/Makefile
new file mode 100644
index 00000000..a31441a
--- /dev/null
+++ b/drivers/soc/amazon/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_AL_POS) += al_pos.o
diff --git a/drivers/soc/amazon/al_pos.c b/drivers/soc/amazon/al_pos.c
new file mode 100644
index 00000000..6d0bdff
--- /dev/null
+++ b/drivers/soc/amazon/al_pos.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Talel Shenhar");
+MODULE_DESCRIPTION("Amazon's Annapurna Labs POS driver");
+
+/* Registers Offset */
+#define AL_POS_ERROR_LOG_1	0x0
+#define AL_POS_ERROR_LOG_0	0x4
+
+/* Registers Fields */
+#define AL_POS_ERROR_LOG_1_VALID	GENMASK(31, 31)
+#define AL_POS_ERROR_LOG_1_BRESP	GENMASK(18, 17)
+#define AL_POS_ERROR_LOG_1_REQUEST_ID	GENMASK(16, 8)
+#define AL_POS_ERROR_LOG_1_ADDR_HIGH	GENMASK(7, 0)
+
+#define AL_POS_ERROR_LOG_0_ADDR_LOW	GENMASK(31, 0)
+
+static int al_pos_panic;
+module_param(al_pos_panic, int, 0);
+MODULE_PARM_DESC(al_pos_panic, "Defines if POS error is causing panic()");
+
+struct al_pos {
+	struct platform_device *pdev;
+	void __iomem *mmio_base;
+	int irq;
+};
+
+static irqreturn_t al_pos_irq_handler(int irq, void *info)
+{
+	struct platform_device *pdev = info;
+	struct al_pos *pos = platform_get_drvdata(pdev);
+	u32 log1;
+	u32 log0;
+	u64 addr;
+	u16 request_id;
+	u8 bresp;
+
+	log1 = readl_relaxed(pos->mmio_base + AL_POS_ERROR_LOG_1);
+	if (!FIELD_GET(AL_POS_ERROR_LOG_1_VALID, log1))
+		return IRQ_NONE;
+
+	log0 = readl_relaxed(pos->mmio_base + AL_POS_ERROR_LOG_0);
+	writel_relaxed(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
+
+	addr = FIELD_GET(AL_POS_ERROR_LOG_0_ADDR_LOW, log0);
+	addr |= (FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1) << 32);
+	request_id = FIELD_GET(AL_POS_ERROR_LOG_1_REQUEST_ID, log1);
+	bresp = FIELD_GET(AL_POS_ERROR_LOG_1_BRESP, log1);
+
+	dev_err(&pdev->dev, "addr=0x%llx request_id=0x%x bresp=0x%x\n",
+		addr, request_id, bresp);
+
+	if (al_pos_panic)
+		panic("POS");
+
+	return IRQ_HANDLED;
+}
+
+static int al_pos_probe(struct platform_device *pdev)
+{
+	struct al_pos *pos;
+	struct resource *resource;
+	int ret;
+
+	pos = devm_kzalloc(&pdev->dev, sizeof(*pos), GFP_KERNEL);
+	if (!pos)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pos);
+	pos->pdev = pdev;
+
+	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pos->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
+	if (IS_ERR(pos->mmio_base)) {
+		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
+			PTR_ERR(pos->mmio_base));
+		return PTR_ERR(pos->mmio_base);
+	}
+
+	pos->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (pos->irq <= 0) {
+		dev_err(&pdev->dev, "fail to parse and map irq\n");
+		return -EINVAL;
+	}
+
+	ret = devm_request_irq(&pdev->dev,
+			       pos->irq,
+			       al_pos_irq_handler,
+			       0,
+			       pdev->name,
+			       pdev);
+	if (ret != 0) {
+		dev_err(&pdev->dev,
+			"failed to register to irq %d (%d)\n",
+			pos->irq, ret);
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "successfully loaded\n");
+
+	return 0;
+}
+
+static const struct of_device_id al_pos_of_match[] = {
+	{ .compatible = "amazon,al-pos", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, al_pos_of_match);
+
+static struct platform_driver al_pos_driver = {
+	.probe = al_pos_probe,
+	.driver = {
+		.name = "al-pos",
+		.of_match_table = al_pos_of_match,
+	},
+};
+
+module_platform_driver(al_pos_driver);
-- 
2.7.4

